function err = stderr(data,dim)
err = std(data,[],dim)/sqrt(size(data,dim));