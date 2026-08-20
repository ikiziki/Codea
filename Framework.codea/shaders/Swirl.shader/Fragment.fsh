//
// A basic fragment shader
//

//Default precision qualifier
precision highp float;

//This represents the current texture on the mesh
uniform lowp sampler2D texture;

uniform vec2 texSize;

//Swirl parameters
uniform float radius;
uniform float angle;

//The interpolated vertex color for this fragment
varying lowp vec4 vColor;

//The interpolated texture coordinate for this fragment
varying highp vec2 vTexCoord;

vec4 swirl(sampler2D tex, vec2 uv)
{
    vec2 center = texSize * 0.5;
    
    vec2 tc = (uv * texSize) - center;
    
    float dist = length(tc);
    
    if( dist < radius )
    {
        float percent = (radius - dist) / radius;
        float theta = percent * percent * angle * 8.0;
        float s = sin(theta);
        float c = cos(theta);
        
        tc = vec2( dot(tc,vec2(c,-s)), dot(tc, vec2(s,c)) );
    }
    
    tc += center;
    
    return texture2D( tex, tc/texSize );
}

void main()
{
    //Sample the texture at the interpolated coordinate
    vec2 uv = vTexCoord.st;

    //Set the output color to the texture color
    gl_FragColor = swirl(texture,uv) * vColor;
}
