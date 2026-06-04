Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EF1CD6E6D
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1FA5112807;
	Thu,  4 Jun 2026 14:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J3y6pYUq";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B778112804
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:42:34 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45ef82204c6so464950f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780584153; x=1781188953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=edXeUisUOZStFE68DISSeh9JLM/7psQJBNg/h6ooJj0=;
 b=J3y6pYUq4XgNASgRx2hov2436FOjAeBPbJReus1fH9JsnLfGi0q9rGYnWZHAbIrGnq
 gjHVsgNW2qH6xjkSDjhnqUQESBmJJSkXgVQjCbkMHXaNaX1XhARxcn4ZK7JmiYlMruUI
 3A63/QW83obq5wfeH74dGrpzjjeLtgZTd7qsoJrkLz42QUiYuUYWWZTRoCymWH8f39c6
 sv2dTxYnmkk6y3NQvrlCeLcopOWTi1wkYJoEk49ioG3ywk6LqhNL+oqKLmYTa9avsQKx
 IYizkE6wTgkUueq+sI2v6Yluiic10BawGLiDsyOlUmMRM0YhQx7Dsp7tbwMDvqV+ijSR
 PT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780584153; x=1781188953;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edXeUisUOZStFE68DISSeh9JLM/7psQJBNg/h6ooJj0=;
 b=ibHUXvpLg9mU/M8JGfbUxZDiMbIR+8jC7bDwmuXEJptsias7f7yB48o6WeWlIQb+qh
 F2bRgCmdVGS2CeIOsaMF+Jjp0rDJ7I7PXFZIFiwCA8xZUx2S5z/1mZvqTsvZWNgflO4I
 1LQ99ARIIVuGLJmMGz9hRw+bL+yyA0htLLgqsT5AqG39zCJGXebvF+xr4mWp5+1t1Vh9
 X/dcQXKO2NCHDStK1xGcSqBEfwi6a4gxwR1v7uUZYMFe+8EiMExQw27C8Ftr5OUZtxsa
 IAPYP++aMQ7+DGACprIg5fofdxgJK17bbOaL2H/rvwfb9EiaY5oqk9W1/ipRzvv3+iZh
 IZhQ==
X-Gm-Message-State: AOJu0Yx02X3DwSRrQ4H46Tp4g7c1AsbDhLxUyFx4akkiv/JIuF5GzxZI
 0ViwOiO4yBH1Upkq4N77MflqWBr4/kpWglRzzwpJKuG8viDJsQTo3GKwXd/AMIRX48hJg/cX7YF
 PJO5R
X-Gm-Gg: Acq92OGf9XgwobE+hJyqcvWR/yUym4btB/4cX7DYdYPn8xcFtiEk5Md58mQvJBtsN5F
 +LBDx+LuTQyAJdQf8iui/n4MuOZfNJ04B3s0+0ceFXQxCWPaYDnFXnT/abf2y8HyAIbvg1vJEEy
 R1kSPyCBPtAYK2nqXoDh+G8mZJGWB6IXn31wbc7lXw+ppnyL2NJWB0FlYYmws7/+m/Ww6RIjJG4
 o0DvORKQLiIR4/Ejb063+mDOK5TdofzFbaDZFiUoIgv9+aLLIucgUxl2wb7uDHlwuM3txbl4RfT
 bEFH150u2tEQvVE0tW1l4Dr4pPGBF8mPEYJ7xPFeH3Sn5qSg08IPZ76Ghv3d1t697cAdl4htwCV
 lMyStx0q815UN09m9GH/BaGkMzy94aQyTbvfH/zxhNy2suD2aZYuyapLYpmYf8mVjIPUqXCXl01
 HzbIKcUyCpj5t5eSllP/vmYrdRipXZA32IMz/GDZLm5nIxlouMfYHqsvP+aSqOoDHcm1owvmP+p
 znVPVOn1ex9FBk=
X-Received: by 2002:a5d:6941:0:b0:43d:68ad:3b7f with SMTP id
 ffacd0b85a97d-46021829aefmr9569274f8f.21.1780584152786; 
 Thu, 04 Jun 2026 07:42:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dbd:100f:afd5:9221?
 ([2a01:e0a:106d:1080:dbd:100f:afd5:9221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dc412sm17426979f8f.4.2026.06.04.07.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 07:42:32 -0700 (PDT)
Message-ID: <18d06d5f-7bf3-4e8d-bc8e-b0c632864190@linaro.org>
Date: Thu, 4 Jun 2026 16:42:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] drm/panel: Enable DSC for Visionox VTDR6130 panel
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260604-topic-sm8x50-vtdr6130-dsc-v1-1-09bcd1dff1fb@linaro.org>
 <20260604130349.2BE0F1F00893@smtp.kernel.org>
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
In-Reply-To: <20260604130349.2BE0F1F00893@smtp.kernel.org>
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

On 6/4/26 15:03, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The panel driver DRM_PANEL_VISIONOX_VTDR6130 lacks Kconfig dependencies for DSC helpers, causing a linker error when compiled without them.
> --
> 
> commit 2b76aa2af63143268815713af0dc4f51234d7f43
> Author: Jun Nie <jun.nie@linaro.org>
> 
> drm/panel: Enable DSC for Visionox VTDR6130 panel
> 
> This commit enables display compression (DSC v1.2) for the 1080x2400 Visionox
> VTDR6130 AMOLED DSI panel. It sets up the DSC configuration parameters and
> sends the picture parameter set during panel initialization.
> 
>> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
>> index 97a79411e1ecd..0cdcdbbc766da 100644
>> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
>> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> [ ... ]
>> @@ -123,6 +128,9 @@ static int visionox_vtdr6130_on(struct visionox_vtdr6130 *ctx)
>>   	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>>   	mipi_dsi_msleep(&dsi_ctx, 20);
>>   
>> +	drm_dsc_pps_payload_pack(&pps, dsi->dsc);
> 
> [Severity: Low]
> Will this cause a linker error if CONFIG_DRM_DISPLAY_DSC_HELPER is not enabled?

Good catch

> 
> This adds a call to drm_dsc_pps_payload_pack(), but it doesn't appear to
> update the Kconfig entry for DRM_PANEL_VISIONOX_VTDR6130 to select
> DRM_DISPLAY_DSC_HELPER and DRM_DISPLAY_HELPER.
> 
> Could this lead to undefined reference errors during the build for
> configurations where the panel is enabled but the helpers are not?
> 
>> +	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
>> +
>>   	return dsi_ctx.accum_err;
>>   }
> 

