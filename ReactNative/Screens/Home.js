import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  TouchableOpacity,
  View
} from 'react-native';

export default class Home extends Component {

  constructor(props) {
    super(props);
    props.navigation.trackEvents('Home',{user:'praveen'});
  }

  render() {
    return (
        <View style={styles.container}>
            <Text style={styles.welcome}>Hello, Praveen</Text>
            <TouchableOpacity style={styles.btn} onPress={()=>this.loadNavigationScreen()}>
                <Text style={styles.txtBtn}>Navigate Model</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.btn} onPress={()=>this.loadModalScreen()}>
                <Text style={styles.txtBtn}>Model Screen</Text>
            </TouchableOpacity>
        </View>
    );
  }

  loadNavigationScreen () {
    this.props.navigation.navigateTo('NavScreen','push',{'name':'praveen'});
  }

  loadModalScreen () {
    this.props.navigation.navigateTo('ModScreen','modal',{'name':'praveen'});
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  btn:{
      padding: 10,
      margin: 5,
      borderRadius: 2,
      backgroundColor: 'rgb(255,6,60)'
  },
  txtBtn:{
    fontSize: 12,
    fontWeight: '600',
    textAlign: 'center',
    color: 'rgb(255,255,255)'
  }
});

AppRegistry.registerComponent('SampleNavigation', () => SampleNavigation);
