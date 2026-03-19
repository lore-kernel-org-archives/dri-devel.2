Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5B4108E1DC
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2F3D10E89A;
	Thu, 19 Mar 2026 10:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i0G5PUUt";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB5110E91E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:33:27 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso4588345e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773916406; x=1774521206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ErO3x4eMWQB/57fETjq+oKLlpjxWHpiaCaJPFs1ooGg=;
 b=i0G5PUUtu1qPQFYv2ETX5BpA3D7c9m4GsvJ1jIiy3Ik0GjTxEZv92NBtSArQF138b8
 PorW5fMYm6Qe63VMISv+5o1FihlCt23FlhYw6lTJ83TWg3LiOIBBPPPVGpuuO6MTw6d3
 lvhKVmloBRCC+kuES2d8uVud+ql18q7hFB65LSx1GNdWjTgJB6i0tc/f592IfT5k6IBH
 OsNVoFkX01tbaf7aEhzLMp9RzEywfrEUa47fbut0kp4/4MiSxfUhtq/x1jBpnV4qhzpi
 0oyiixYQOjWy9259BWhha48jfjVTkDm048zg8gjYWv+1RCCYp/NtknvATZoRk3bRzts5
 /SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773916406; x=1774521206;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErO3x4eMWQB/57fETjq+oKLlpjxWHpiaCaJPFs1ooGg=;
 b=L7Ld60SFC3eijwDyY73XSteshEx81/If6V+PqbwuzAl+lFyuVRUn/SZuCzuPRdCm0W
 B40EJNvaqYKhIzFLtWCQ6/PW6ut50k0j9STegha/hxo7v9xq6ebuzVD/TtXa8Qm/G/fU
 U1FDn6FsV+vRAY/xntzVkVxilBPAZYZ2Z5jEG92/Z98DdmAcyTDlAUkaCAPGmqpXRIGp
 KnW+Tsmg5twVFa+bBTEJ3fqvpGg8+C9w5rGU71IF7CWpsHebBywPtD/N4MHXsYYbCy7y
 llRTK1KWmwqmFraPe93pWTf8IRA78FYTzE6pgz9Q9jmJbbVye077EhRxmxeIHtutvwCS
 /fsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYg448tGyxQ31k/N6itRnBvGROCqZChKhIW1dodB9gIqJiNCTAGTOceuYfROnYK2xaIovGQaBT33E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbWwUY6GlUdUPcTLUQAes5AfU2Y5sIFDpuQ+7E23aJzNvok1k+
 dzde8cU7w8GMLm7QvMDF6R+frp8HeTcADELuIinQT+TT/GQ6w0RfrbwVoNpUsTqcWvk=
X-Gm-Gg: ATEYQzxPENSfKwwz86eRTF0oFZnAHcRmQFVaAlKd6OvgP7kgKuA9IsNbmeezCmETDFt
 yUWlsUdKRAVrLTwLoj/SUBxq6JLAzbo1XBPOtgnZd8r/MV3Ak+Kg1wAJDULLm7Y0uRZZ8ig4S8D
 dr0WN39m932a5RrtcDsxuzooIhVT6tJ16J2JM8eOrfHCTmIdY/kElmKgsFJ37mhgBu2w5t1TVjn
 aRJgn/uP86BBSYw+77x1yxNM8FjQuCvk7i/fyL5N+JbECBU3/Y89DtYbkBCXUMGARu9IKcVdie0
 DKGkpoBOaBolwT4se/WcmJD2zM0+BJarnamAJcMhXOx40UFPpq3geUGpD7MSqFW1k7fOmRm0YaV
 jWiKKyl0xw/OsezjQ7XwutPwj5QXMo/uqtXwK98PJmVOkZnR5S32AQ9KLdS04vRleqFJHQn98Y3
 Wb+OVOF7qKudpJHkmposK8L/bIgKNaJht5UZ+Uesrq6fy/pnrOVFrhrJwg7rOkWuIYhJgQZp6mg
 Kkmo6c=
X-Received: by 2002:a05:600c:8b85:b0:485:4135:5c92 with SMTP id
 5b1f17b1804b1-486f41ffff7mr112681655e9.0.1773916405763; 
 Thu, 19 Mar 2026 03:33:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8e54:fbaf:8cb6:e9f7?
 ([2a01:e0a:106d:1080:8e54:fbaf:8cb6:e9f7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8ba4a74sm56533335e9.12.2026.03.19.03.33.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 03:33:25 -0700 (PDT)
Message-ID: <90623d8f-6eee-40e5-ace7-6bd701dd2868@linaro.org>
Date: Thu, 19 Mar 2026 11:33:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/3] drm/msm/dpu: fix video mode DSC INTF timing width
 for non 8 bit panels
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260318-dsi-rgb101010-support-v2-0-698b7612eaeb@pm.me>
 <20260318-dsi-rgb101010-support-v2-3-698b7612eaeb@pm.me>
 <c9d14a74-8e59-43bb-827b-577c8f675c8f@linaro.org>
 <_varXMigTiaLa1CVxsqWY0wJNnR8xZGw5lAS8MmyxrVAjHPK1Mu-H-heiIMxB9SdcJoEhjUDUtUo8dZvTi_GsQwYKsuGnc1tsFlSDqoKfA0=@pm.me>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <_varXMigTiaLa1CVxsqWY0wJNnR8xZGw5lAS8MmyxrVAjHPK1Mu-H-heiIMxB9SdcJoEhjUDUtUo8dZvTi_GsQwYKsuGnc1tsFlSDqoKfA0=@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 3/19/26 09:48, Alexander Koskovich wrote:
> On Thursday, March 19th, 2026 at 4:35 AM, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> On 3/19/26 05:00, Alexander Koskovich wrote:
>>> Using bits_per_component * 3 as the divisor for the compressed INTF
>>> timing width produces constant FIFO errors for panels such as the BOE
>>> BF068MWM-TD0 which is a 10 bit panel.
>>>
>>> The downstream driver calculates the compressed timing width by
>>> dividing the total compressed bytes per line by 3 which does not depend
>>> on bits_per_component. Switch the divisor to 24 to match downstream.
>>>
>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>>> ---
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 12 +++++++-----
>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>> index 0ba777bda253..9b046a0e77aa 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>> @@ -122,19 +122,21 @@ static void drm_mode_to_intf_timing_params(
>>>    	}
>>>
>>>    	/*
>>> -	 * for DSI, if compression is enabled, then divide the horizonal active
>>> -	 * timing parameters by compression ratio. bits of 3 components(R/G/B)
>>> -	 * is compressed into bits of 1 pixel.
>>> +	 * For DSI, if DSC is enabled, use a fixed divisor of 24 rather than
>>> +	 * bits_per_component * 3 when calculating the compressed timing width.
>>> +	 *
>>> +	 * This matches the downstream driver and is required for panels with
>>> +	 * bits_per_component != 8.
>>>    	 */
>>>    	if (phys_enc->hw_intf->cap->type != INTF_DP && timing->compression_en) {
>>>    		struct drm_dsc_config *dsc =
>>>    		       dpu_encoder_get_dsc_config(phys_enc->parent);
>>> +
>>>    		/*
>>>    		 * TODO: replace drm_dsc_get_bpp_int with logic to handle
>>>    		 * fractional part if there is fraction
>>>    		 */
>>> -		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) /
>>> -				(dsc->bits_per_component * 3);
>>> +		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) / 24;
>>
>>
>>
>> @bits_per_component: Bits per component to code (8/10/12) <= how the DSC pixels are encoded in the stream
>> @bits_per_pixel: Target bits per pixel with 4 fractional bits, bits_per_pixel << 4 <= the target display pixels
>>
>> - bits_per_component is the transport width
>> - bits_per_pixel is the display width
>> - 3 is the DSC compression ratio
>>
>> So for a RGB101010 DSC display bits_per_pixel should be 10 << 4
>>
>> But here you say bits_per_component should be 8 ? can you share the downstream config of your panel ?
> 
> This is what is defined downstream for this panel, they're using 8:
> https://github.com/NothingOSS/android_kernel_msm-6.1_nothing_sm7635/blob/sm7635/b/mr/vendor/qcom/proprietary/display-devicetree/display/dsi-panel-rm69220-dsc-fhd-plus-120hz-vid-boe.dtsi
> 
>>
>> Are you sure about the bits_per_component & bits_per_pixel values you set in the dsc parameters ?
> 
> I'm pretty sure they're correct, here's the panel driver I have atm:
> https://github.com/AKoskovich/linux/blob/asteroids-6.19.y/drivers/gpu/drm/panel/panel-boe-bf068mwm-td0.c

So I looked at downstream, and bit-per-component is not used at all for the width calculation.

Here's the full downstream calculation with your panel:


intf_width = mode->timing.h_active;		=> 1080

slice_per_pkt = dsc_info->slice_per_pkt;	=> 2
slice_per_intf = DIV_ROUND_UP(intf_width, dsc_info->config.slice_width);	=> 1080/540 = 2

if (slice_per_pkt > slice_per_intf)
	slice_per_pkt = 1;

bpp = DSC_BPP(dsc_info->config);	=> 8

bytes_in_slice = DIV_ROUND_UP(dsc_info->config.slice_width * bpp, 8);	=> 540 * 8 / 8 = 540


dsc_info->bytes_per_pkt = bytes_in_slice * slice_per_pkt;	=> 540 * 2 = 1080
dsc_info->pkt_per_line = slice_per_intf / slice_per_pkt;	=> 2 / 2 = 1

...

phys->dce_bytes_per_line = comp_info->dsc_info.bytes_per_pkt * comp_info->dsc_info.pkt_per_line; => 1080 * 1 = 1080

...

if (p->compression_en) {
	if (p->wide_bus_en)
		data_width = DIV_ROUND_UP(p->dce_bytes_per_line, 6); => 1080 / 6 = 180
	else
		data_width = DIV_ROUND_UP(p->dce_bytes_per_line, 3); => 1080 / 3 = 360
}

So you're right, it should be a fixed (8 * 3) division, and a (8 * 6) in case of widebus, but DSI widebus is not yet handled.

Neil

> 
>>
>> Neil
>>
>>
>>>    		timing->xres = timing->width;
>>>    	}
>>>    }
>>>
>>
>>
> 
> Thanks,
> Alex

