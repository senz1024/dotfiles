import numpy as np

np.a = np.array

def _arangeshape(*x):
    if len(x)==1 and isinstance(x[0], list):
        x = x[0]
    return np.arange(np.prod(x)).reshape(x)

np.arangeshape = _arangeshape

