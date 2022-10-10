# TunerEnvironmentObject

This is an example of mocking an observable object
It demonstrates the problem that in order for the view model to update the observed value it needs to be forced to do so. 
Here a timer is used as a workaround in the init of the view model to force the update of pitch

The tuner in this project comes from audiokit

