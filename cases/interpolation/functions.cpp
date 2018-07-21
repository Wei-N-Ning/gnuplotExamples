
#include <cmath>

template<typename T0, typename T1>
inline T0 max_of( const T0& i_a, const T1& i_b ) {
    return ( i_a > i_b ) ? i_a : i_b;
}

template<typename T0, typename T1>
inline T0 min_of( const T0& i_a, const T1& i_b )
{
    return ( i_a < i_b ) ? i_a : i_b;
}

template<class T>
inline T saturate(const T& i_a) {
    return max_of(T(0), min_of(T(1), i_a));
}

template< class R, class T >
inline T smoothStep(const R& i_t, const T& i_p0, const T& i_p1) {
    T t0 = saturate( ( i_t - i_p0 ) / ( i_p1 - i_p0 ) );
    return t0 * t0 * ( T(3) - T(2)*t0 );
}

template<class R, class T>
inline T smoothStepPerlin(const R& i_t, const T& i_p0, const T& i_p1) {
    T t0 = saturate( ( i_t - i_p0 ) / ( i_p1 - i_p0 ) );
    return t0*t0*t0* ( t0* ( t0*T(6) - T(15) ) + T(10) );
}

template<class R, class T>
inline T smoothStepQuintic(const R& i_t, const T& i_p0, const T& i_p1) {
    if ( i_t <  i_p0 ) {
        return T(0);
    }
    if ( i_t >= i_p1 ) {
        return T(1);
    }
    T t0 = ( i_t - i_p0 ) / ( i_p1 - i_p0 );
    return t0*t0*t0 * (T(10) + t0 * (T(-15) + t0*T(6)));
}

template<class R, class T>
inline T cosine(const R& i_t, const T& i_p0, const T& i_p1) {
    T t0 = ( T(1) - cos( i_t* T(M_PI) ) ) / T(2);
    return i_p0 * (T(1)-t0) + i_p1*t0;
}
