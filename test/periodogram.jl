#in matlab:
#x=rand(512,1);
#[s,f,t,p]=spectrogram(x,ones(1,256),128,256,1);
#save
#
#in julia:
#using MAT
#
#matdata=matread("spectrogram.mat");
#
#for i in ("x", "f", "t", "p")
#  fid=open("spectrogram_$i.txt","w")
#  print(fid,matdata["$i"])
#  close(fid)
#end

using DSP, Base.Test

x0 = readdlm("spectrogram_x.txt",'\t')
f0 = readdlm("spectrogram_f.txt",'\t')
t0 = readdlm("spectrogram_t.txt",'\t')
p0 = readdlm("spectrogram_p.txt",'\t')
p, t, f = spectrogram(x0, nfft=256, fs=1, noverlap=128)

# with real input matlab outputs a 1-sided PSD
@test_approx_eq p0[[1,129],:] p[[1,129],:]
@test_approx_eq p0[2:128,:]./2 p[2:128,:]
@test_approx_eq f0 f[1:129]
@test_approx_eq t0 t