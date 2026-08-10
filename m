Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5883CC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3DB10E788;
	Mon, 10 Aug 2026 09:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SFsAl1CJ";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C14510E788
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:59:44 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so1193342f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786355982; x=1786960782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SiMbtxTKEvUw/r0Ou/ONt2ZII0Ap2iYNjYN/HVqfmSU=;
 b=SFsAl1CJ/Fih90wPFJtiUnQTUoD7TPNTvBcQjyEnYrdrLvT3C77zXRfub7W7m0kMtb
 wl40wrYKTkrgiJkdqwbwB05wmpTo+d48YFpaVn0pyDMO31xLCxxk5s7qhSz/0umyRooq
 Y6MOH+2eQ5rRHBFSAPplC11STdoMTLca8OAPPlqLWbtIRX6aNuoCNjmRF812RX2ie9z0
 58V83IbEPyewh/ODHHRYhE2+/Z6dWoAU3CHwIRTCfbZby5dI4AvhaC2orjTcnOdoSu1e
 UxbhpaIJBzkfxo5CqS/PwpldgkZ0iKh1+72/gi5OwbEMS+IdO2gxaH16JCsfCvvsux5e
 C4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786355982; x=1786960782;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SiMbtxTKEvUw/r0Ou/ONt2ZII0Ap2iYNjYN/HVqfmSU=;
 b=aYh3NtKIQzIQ4nUim2HrddIB4OI1IpKzdQK1VQjWyL8db1Vw/Qge7fZVTg1uV8eEPD
 NmatC5FTXoFtrm2sO9mB7RdNettxbEnUiGM6k96tMD6dlMYA1pPpZbSRTBIixo2q8Ld9
 RV/DN8wOZeVRV/k6b9o9OgH2m0aBa6WC3MzIAy2kAJnLhRrHx/SluPUpkTuCUVIp1hF/
 Z5RqrSUgK8N64dxLkMNNwJkd3SotIyhI54RKBJFb7Df514Rx7vp4XXFbao51CufBFpv/
 rJWmIYiVZFQdvfzZY3vRTmsC7BSCkw6F38H+q2ALJsWqD9LvO8xbyLDKXf+g/S68Mm4t
 +l2g==
X-Gm-Message-State: AOJu0Yy1egDA/5dZDlC+E/9ky2U10cX1wrlScoo4R6AXxF180h5C5R/b
 gJ74IeRGtuV2O0NUkb+bCD2QdTOnko7JFQSVfi+gwHJ9t5L5io0AFawQT5O7tz+8z+U=
X-Gm-Gg: AR+sD13b1eikQzkPlSnaAY5ofpbtUiI5F2dVWmg4fcFb23HRh7fqiterJ/AjZgvyq7n
 W7TQNS10DrmlgehhhbHxQ0u1gs2iL+ABjeaCP2e2gdpaAAY5rTxZuhryr/Gy4/zoUr9d1erwFRN
 /1qhzynbs1V5KfJaSIqa5iNRvRDSpgBsbWPWhLsz45djGY8WWzfBRVs5qvLljXfaahn/CMxP66n
 HaAhF0yGupLi09/4hmkE4T/o2W+MhFBqy72/ik0TFzwvN1FE6h40+8MfVPutARyJQSQqJO+EuEW
 DLSpmLdQ5Zwauk8WhCEFpQDugPku+QVFkReBO7JVSh7+jiZJ9SIffAz2meUiPB05ZRO6R6OhO58
 cTDFXa0MXrQSIaG8p9/ZDCoUSGKjhYEM/EAWw1Cw6tTe3OFPovDZaaDIir4zmP15dNvZ6c+EXzY
 YNTeiDW8Yz1fSQXm7eKqIDOumnFgK4fmDXtmKohVN5w6eDsyd3dUKXqDlNfTCYzzhdAb3BCzfMs
 V/stuBetVDVwDIkxWFhT2VKw2IZKdQR51h14LnT5g==
X-Received: by 2002:a05:6000:240b:b0:47f:8fb6:c32f with SMTP id
 ffacd0b85a97d-48130eefaacmr23781864f8f.24.1786355982283; 
 Mon, 10 Aug 2026 02:59:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32?
 ([2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e8cd0sm32743162f8f.17.2026.08.10.02.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 02:59:41 -0700 (PDT)
Message-ID: <277b95f9-7edb-4ed8-91c3-658a0bfde8c9@linaro.org>
Date: Mon, 10 Aug 2026 11:59:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/2] drm/panel: lg-sw43408: use the full DCS brightness
 range
To: david@ixit.cz, Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>, Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20260810-fix-blueline-panel-v2-0-9344dfdbc3f9@ixit.cz>
 <20260810-fix-blueline-panel-v2-2-9344dfdbc3f9@ixit.cz>
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
In-Reply-To: <20260810-fix-blueline-panel-v2-2-9344dfdbc3f9@ixit.cz>
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

On 8/10/26 11:55, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> The vendor firmware panel configuration (XBL DisplayDxe panel XML)
> declares DCSMaxBrightness 0x332 with a two-byte brightness command,
> and the driver already sends two bytes via
> mipi_dsi_dcs_set_display_brightness_large().
> 
> Capping max_brightness at 255 therefore limits the panel to ~31% of
> its real brightness range. Use the firmware maximum.
> 
> Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> index 0bf8e08f10b9c..be132b65b0c13 100644
> --- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
> +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> @@ -203,17 +203,17 @@ static const struct backlight_ops sw43408_backlight_ops = {
>   };
>   
>   static int sw43408_backlight_init(struct sw43408_panel *ctx)
>   {
>   	struct device *dev = &ctx->link->dev;
>   	const struct backlight_properties props = {
>   		.type = BACKLIGHT_PLATFORM,
>   		.brightness = 255,
> -		.max_brightness = 255,
> +		.max_brightness = 818,
>   	};
>   
>   	ctx->base.backlight = devm_backlight_device_register(dev, dev_name(dev), dev,
>   							     ctx->link,
>   							     &sw43408_backlight_ops,
>   							     &props);
>   
>   	if (IS_ERR(ctx->base.backlight))
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
