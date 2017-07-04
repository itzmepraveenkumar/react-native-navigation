import React, { Component } from 'react';
import { NativeModules, Platform } from 'react-native';

import Home from './Screens/Home'
import NavScreen from './Screens/NavScreen'
import ModScreen from './Screens/ModScreen'

import UnderDevelopment from './Screens/UnderDevelopment'

const { HybridNavigationManager } = NativeModules;

const Screens= {
  Home: Home,
  NavScreen: NavScreen,
  ModScreen: ModScreen
}

export default class AppNavigator extends Component {

  constructor(props) {
    super(props);
    const { name, type, params, rootTag } = props;
    let data = null;
    if (this.checkPlatformAndObject('android','string',params)) {
      data = JSON.parse(params);
    }
    const navigate = { name, type, goBack:this.goBack, navigateTo:this.navigateTo, trackEvents:this.trackEvents };
    this.state = {
      navigate,
      data
    }
  }  

  render() {
    const ScreenToLoad = this.getScreenToLoad();
    return (
      <ScreenToLoad data={this.state.data} navigation={this.state.navigate}/> 
    );
  }

  getScreenToLoad() {
    if (this.props.name) {
      const screenToLoad = Screens[this.props.name];
      if (screenToLoad) {
        return screenToLoad;
      }
    } 
    return UnderDevelopment;
  }

  goBack = (dataToPass) => {
    const screenName = this.state.navigate.name;
    const type = this.state.navigate.type;
    if (this.checkPlatformAndObject('android','object',dataToPass)) {
      dataToPass = JSON.stringify(dataToPass);
    }
    HybridNavigationManager.goBack(screenName, type, dataToPass);
  }

  navigateTo = (screenName, type, dataToPass) => {
    if (screenName && typeof screenName === 'string') {
      if (!type) {
        type = 'push';
      }
      if (this.checkPlatformAndObject('android','object',dataToPass)) {
        dataToPass = JSON.stringify(dataToPass);
      }
      HybridNavigationManager.navigate(screenName, type, dataToPass);
    }
  }

  trackEvents = (eventName,properties) => {
    if (typeof eventName === 'string' && eventName) {
      if (typeof properties === 'object' && properties) {
        if (Platform.OS === 'android') {
          properties = JSON.stringify(properties);
        }
        HybridNavigationManager.saveEventInAnalytics(eventName,properties);
      }
      HybridNavigationManager.saveEventInAnalytics(eventName,null);
    }
  }

  checkPlatformAndObject(os,type,property) {
    if (Platform.OS === os && typeof property === type && property) {
      return true
    }
    else {
      return false
    }
  }
}

