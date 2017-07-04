
import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  TouchableOpacity,
  View
} from 'react-native';

export default class ModScreen extends Component {

  render() {
    return (
        <View style={styles.container}>
            <Text style={styles.welcome}>Modal Screen</Text>
            <TouchableOpacity style={styles.btn} onPress={()=>this.goBack()}>
                <Text style={styles.txtBtn}>Go Back</Text>
            </TouchableOpacity>
        </View>
    );
  }

  goBack() {
      this.props.navigation.goBack(null);
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
