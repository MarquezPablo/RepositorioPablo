
# PART 1
############################################
# We will start by creating a sine sweep   #
# to review signal processing fundamentals #
############################################

# import all necessary libraries
import librosa
import librosa.display
import numpy as np
from scipy.signal import chirp, butter, lfilter
from scipy.fft import fft
import matplotlib.pyplot as plt

# declare general signal variables:
dur = 3                           # duration in seconds
sr = 44100                        # sampling rate
t = np.linspace(0, dur, dur*sr, endpoint=False)   # time vector

# Q: What's the dimensionality of the time vector? why?
# A: 1x132300, there are 132300 timestamps refering to each sample
# Q: What is the Nyquist limit of this signal?
# A:sr/2  ->  22050Hz

# Define the nyquist limit using the relevant variables defined so far
nyq =int(sr/2) # your code here

# generate a sine sweep lasting dur and going from 20Hz to 20kHz. Hint: use the scipy chirp function
y = chirp(t,20,3,20000) # your code here

# we can listen to the resulting signal using these functions
from IPython.display import Audio
Audio(data = y, rate = sr)

librosa.display.waveplot(y,sr)



# compute the FFT of the signal using scipy's fft
Y = fft(y) # your code here

# the FFT is complex-valued, so get its magnitude using np.abs
Y = np.abs(Y) # your code here


# compute the frequency bins for the fft using np.linspace
f =np.linspace(0, Y.shape[0],  Y.shape[0])*sr/Y.shape[0] # your code here

# now plot the fft using plt.plot
plt.plot(f,Y)
plt.xlabel('Fequency (Hz)')
plt.show()

# Q: What do you see in the resulting plot? Does it look like what you expect? Do you find it useful?
# A:the resulting response power at each frequency, not very useful because I dont know how to interpret it.
    
    # librosa.display let's you visualize the short-time Fourier transform 

# first, compute the signals short-time Fourier transform using librosa.stft
S = librosa.stft(y) # your code here

# the stft is also complex-valued, so get it's magnitude (you could get it in dB using librosa's amplitude_to_db)
S = np.abs(S) # your code here

# now you can visualize it using librosa.display.specshow. Make sure you pass the parameters x_axis='time',y_axis='linear'
librosa.display.specshow(S) # your code here

# Q: What do you see in the resulting plot? Do you find it useful?
# Q: Which one is a better picture about the signal's content, the waveform, the fft, or the stft? why?
# A: the most intuitive visualization for me is the spectrogram of the fft, it is more intuitive to see the change in power
#for each frequency over the time
    
    
    # PART 2
#######################
# Problem statement   #
#######################


# You are working with a collaborator who is not very familar with 
# digital signals. You give them your chirp signal y(t) with a sampling rate of 
# 44100, but they tell you that the sampling rate is too high. To fix this, they have 
# downsampled your signal using the following method to obtain y_
y_ = y[::2]

# Q: what is the new sampling rate?
#A: sr/2 -> 22050
sr_ = sr/2# your code here


# plot it's spectrogram

# first, compute the signals short-time Fourier transform using stft
S = librosa.stft(y_) # your code here

# the stft is also complex-valued, so get it's magnitude (you could get it in dB using librosa's amplitude_to_db)
S = np.abs(S) # your code here
# now you can visualize it using librosa.display.specshow
librosa.display.specshow(S) # your code here

# Q: what is wrong?
# A: the signal wasn't filtered before decimating

# Q: what is the series of signal processing steps that are needed to properly 
# downsample the signal? (i.e. the steps that your collaborator completely ignored)
# A: 1-. Lowpass the signal with digital filter
#    2-. Decimate the signal taking every n sample

    
    
# This problem can be solved by passing a the signal through a lowpass filter
 # with a cut-off frequency close but below nyquist. 

# You show your collaborator how this is properly done by: 
# first filtering the signal, then
# second then using their same resampling method

# define the lowpass filter function
def lowpass(cutoff, sr, order):
    nyq =sr/2 # your code here to define the nyquist limit    

    # this function returns the coefficients needed to build a
    # butterworth lowpass filter
    # see the function documentation https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.butter.html
    # and https://ccrma.stanford.edu/~jos/fp/Butterworth_Lowpass_Design.html
    # if you need to refresh your knowledge of digital fitlers

    b, a = butter(order, cutoff/nyq, btype='low', analog=False) 
    return b, a

# now create a helper function to filter the signal
def lowpass_filter(data, cutoff, sr, order):
    b, a = lowpass(cutoff, sr, order=order)
    y = lfilter(b, a, data)
    return y

y_ = lowpass_filter(y,10000, sr, 20)
y_ = y_[::2]

# Q: What happens if you change the number 20 for another smaller or larger number? 
# A:for higher numbers the slope of the gain becomes higher for the transition frequency bands
# Q: What does this number do? What is the "order" of a butterworth lowpass filter and why is it important?
# A: it modifies de response of the filter between the transition frequency bands

# now listen to the signal, plot it in the time domain, and plot its spectrogram
from IPython.display import Audio
Audio(data=y_, rate=sr_)


    
t_ = np.linspace(0, dur/2, int(dur*sr_), endpoint=False)
y_ = librosa.resample(y, orig_sr = 44100, target_sr = 22050)
plt.plot(t_,y_)
S_ = librosa.stft(y_)    
S_ = np.abs(S_)

# also plot the spectrogram of the signal
librosa.display.specshow(S_) # your code here

# Q: What was different this time? Why is this method better?
# A: the signal was properly processed, so the high frequency components
#    of the signal did not cause aliasing

#############################################################################
import math as mt

y_brahms, sr_brahms = librosa.load(librosa.example('brahms'))

dur_brahms = y_brahms.shape[0]/sr_brahms

t_brahms = np.linspace(0, mt.ceil(dur_brahms), mt.ceil(dur_brahms)*sr_brahms, endpoint=False)
t_brahms = t_brahms[0:y_brahms.shape[0]]

plt.plot(t_brahms,y_brahms)



y_brahms_down = librosa.resample(y_brahms, orig_sr = sr_brahms, target_sr = sr_brahms/2)
plt.plot(t_brahms[0:y_brahms_down.shape[0]],y_brahms_down)