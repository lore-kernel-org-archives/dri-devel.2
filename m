Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B3FCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241D710E856;
	Mon, 18 May 2026 14:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TlbxErMc";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F0B10E856
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:01:30 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso19676795e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779112889; x=1779717689; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+LB2Sjg0VNa6qbJErLOgdik8RDhZEWe/BW61T3GfWXI=;
 b=TlbxErMchyBWUn3EHJ3bkl4XWJR4By+kcDBu+fYpTH/nWzpWpjtZigfCRkoxlgiV0a
 eDlJ3+5HqQpwndIdHHmMCJoihs1LHI07aRWssswe8bNCgON3cnjvU4aeL/ScrpqHKTEN
 n+fD0UOFz30RVwA6jTzaqAcNY2m0qj8Wj1IodyhNHtH1jAcnGH2JGLxrYWWRcshDYZly
 +zZOYw87IU+7MQZHGPoRrB0ntUPTmPr5UTwdeT7mmCoiUOV9rDCqbzVM8H8wb5Y2twZY
 dzE53+mXyqivXvErlFNaRHF09sYbtE80Ys3MkmzW+G3k+n/O0OfUDFlXRp0Y/RE85Hrg
 5hTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779112889; x=1779717689;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LB2Sjg0VNa6qbJErLOgdik8RDhZEWe/BW61T3GfWXI=;
 b=Dpgoah7QKlp66AuPJ6eet4krTgMW/jqo+VTYXCCWeHzp6bE8tsh+8Ht226zpGli31G
 J6840qeYYPP0/2G2K/HtprN12+e4AGlVDk177Tc99dQEWlBRnuFi0rt0UmdL5u3850qo
 hhsGkQpZqwexYBkvBn3Con+1uMJSR/44nEhWMgzMcTxp5ARTg/54yMpPcx7/jXL7tCKm
 lPeiL8s51JosDRTXDx2KNmk8zcy0+t21gji8Mk9uKeUJX4MRmLaUW+X0/ODw0jpSeu3v
 qoH+aFMr+JHw1YKYqXJZydigFVrFUXQH9MvDz4Z0IcJQqEDpFv3kZn5/ak/o/ffF6e2k
 nQMQ==
X-Gm-Message-State: AOJu0YzWBcZPxFYEd6Dpj+mKsiEb5Mi5sVrDLQPSMu6phYFGRzcuTzxO
 1XaxvriZpKUf1q1rX5vV6aIqgPcoTw+cIwnzf6jmk6CzysSoJK3/AhdOEzi9reYcK3Y=
X-Gm-Gg: Acq92OEXyovuaqZSsj1D32eLMtbzzHyWhb2wxeXpnwVWFIMgXS/UAl9/ZEXCYI/rFp7
 tJ7HBXpm7jXRAML58mkRG30PJQrb3nsEvZ+ScWlRV1ijktFw8HwbCBCLA/Hg+nFYN8U19ZDMZ2t
 YXeBgS5pfRfbXZy6lZDWJvvZaXoIDB4zqTHPseQuUL2t8g6U4f6p+JWlvge6Mv0t1su1AQp7GED
 eos0w+gKmbnuN2mYjNGym1dILUE3K06zydvJPoFRQI8PqtolnFy1J3JKmfUr9/kVjzLpGn6Kbdb
 wU73+XWUmyJrvVgpJ4oGh/FarwterbSqoKByP2UNgRxzbhNXyNX6M5RDMGmmAS/VTkPxGCdjODE
 M7GhNRaB/3KDO9TZ47UQapkLm5aEsfqcoNBBMHYqLTYStu6HbCSQislMKV2aqjgmX0QDcLdIp+1
 uRL2vonCJwGGoO65kkcc14fuOYOQQYBy3i/qbDoMCw9QF6Oo039ftczEBYRWq7GZNrWw4oIXOZI
 1mhV7E=
X-Received: by 2002:a05:600c:8b6e:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-48fe61ed21amr247255575e9.20.1779112889228; 
 Mon, 18 May 2026 07:01:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53767ecsm234857745e9.10.2026.05.18.07.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:01:28 -0700 (PDT)
Message-ID: <b74dfbae-4e12-448d-a818-b2dd4f00a5d8@linaro.org>
Date: Mon, 18 May 2026 16:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 13/13] drm/panel-simple: Fix
 powertip,ph800480t013-idf02 timings
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
 <20260513-tc358762-fixes-v3-13-6698b55008b9@ideasonboard.com>
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
In-Reply-To: <20260513-tc358762-fixes-v3-13-6698b55008b9@ideasonboard.com>
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

On 5/13/26 15:10, Tomi Valkeinen wrote:
> The powertip,ph800480t013-idf02 panel was added to panel-simple, and
> with the tc358762 driver, enabled the use of RaspberryPi 7" DSI display.
> 
> I have been testing the RaspberryPi 7" DSI display module with TI's
> BeagleY-AI, and I can't get a good image with the current panel timings.
> 
> It's been quite difficult to figure out exactly what are the issues.
> Possibly RPi DSI TX and TI DSI TX have their own quirks which affect
> this also. However, now that the tc358762 driver has been fixed wrt. the
> signal timings it sends, this patch makes the panel work fine on
> BeagleY-AI.
> 
> Fix the timings according to the datasheet:
> 
> - hsw + hbp must equal to 46. This was correct in the timings, but the
>    hsw was very tight, and at least Cadence DSI has trouble with such
>    short hsync. Increase hsw to the middle of the hsw range from the
>    datasheet, and decrease hbp accordingly.
> - vsw + vbp must equal to 23. This was 24, resulting in slight shift in
>    the image.
> - The upstream timings seemed to aim for 50 fps, but this is a normal 60
>    fps panel, so adjust the timings to get 60 fps. As there's no strict
>    rule what numbers to pick here, I used the "typical" values from panel
>    datasheet for pclk, hfp and vfp. However, vfp of 23 instead of the
>    datasheet's 22 give us a closer match to 60 fps, so I used that.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 91ab280869ba..16aeafd2b02e 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -4041,15 +4041,15 @@ static const struct panel_desc powertip_ph128800t006_zhc01 = {
>   };
>   
>   static const struct drm_display_mode powertip_ph800480t013_idf02_mode = {
> -	.clock = 24750,
> +	.clock = 33333,
>   	.hdisplay = 800,
> -	.hsync_start = 800 + 54,
> -	.hsync_end = 800 + 54 + 2,
> -	.htotal = 800 + 54 + 2 + 44,
> +	.hsync_start = 800 + 210,
> +	.hsync_end = 800 + 210 + 20,
> +	.htotal = 800 + 210 + 20 + 26,
>   	.vdisplay = 480,
> -	.vsync_start = 480 + 49,
> -	.vsync_end = 480 + 49 + 2,
> -	.vtotal = 480 + 49 + 2 + 22,
> +	.vsync_start = 480 + 23,
> +	.vsync_end = 480 + 23 + 2,
> +	.vtotal = 480 + 23 + 2 + 21,
>   	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
