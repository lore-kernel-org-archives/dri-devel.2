Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59B8EBFD21
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF3210E39E;
	Mon, 13 Apr 2026 09:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PxAKwsmL";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730D910E39E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:25:53 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4888375f735so39782735e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776072352; x=1776677152; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=WxTuUhvNuyjpocH8H2TWu25ZZLHbeZ5L/TpNb0PyPXg=;
 b=PxAKwsmLDqlaiSoWQVVGD4SNacl8/VDNfIuN/xK7gBwBjAnhyHnaPpzcyVmYvV97oR
 MFSxxjoricuJ/SozikkzJhMLCqLOEhr7FKlTuHSpHmSU3UB0OvNRUxcHCuGqEk0nmpGc
 k9/TqC57bPQELA6kbmBfQCR4gryxCeUd1MI7c7IZ7wzc2Plh6q98VmcxouBaFOreLZnx
 103LpIZCH2m4gDAAkx3MaPR+Hp9O2YOb4HaDJit57CMb2MgBVzWGJtcU2gibEVan/jyO
 Z9Kiz9CF5NqAUncd6UACUC/9AEuHi6nSpvH8rzNJm5PMRxXrQM5aSiZoMoc7pHy970Ms
 Me2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776072352; x=1776677152;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxTuUhvNuyjpocH8H2TWu25ZZLHbeZ5L/TpNb0PyPXg=;
 b=Gg+htTp2/AvSXC0GYf1DpdOY3iUlIHjiHCGN+1xTfqBgBrKujSbNwPF3R7HmfLqFLy
 bBBvBVJIJxOFnUelSc1jr36FegsWzVf2e02kKSzVePhRUdG/x5AkIMzr68DCT+b4SJ6y
 ubuYxEbZXGhtrPtQ4+XkREiAusGdNcmXNmpweWYxrUXL7PbZ0TbvmCtUtIpV7Hv2Zyhl
 yORG44w02lb519oa3vUgLHP7W1iKog6oy3Gp0J7PCS1S1kmngnJKkvnWr/hPsbI4lU5A
 iwohJFHiKMlMfr4zW+JR94VPv86MSIPqRvCuRQOFkeKsPbACS/T0dE1qxZ7UWklmS4+b
 /86A==
X-Gm-Message-State: AOJu0YzK7X8yks4zlXKUbPctNcG5S0QGfH1I4SlFehPxR2bqthXrSzMK
 B5aBdh2AxD2JCpaKhX13Kv6V/FnXWyUv+Iv7gS4qMZOiSsbHrhjEfPySo5KHHdKH2NE=
X-Gm-Gg: AeBDiettrYLdbD0JyvrW1BXgjAnqK0vMPA+qlpHQC1xnOeiMzEYT2dE+jbGplx1XUP7
 1lxrXlw7kNZhK2ikQ7BIl23dcPS1aRUfGJ71DlE1v1V0ZSU/UhRiZllN6K0Vjeih8i2vEta3HL0
 un02G3N6aoTg61HdXAuhRuUnXLguXg4OGuQKT3Y4HOrmG8QjbFIOxrxdOR2+/drVS6iNrduOBhb
 T6wf0MMv+ZZRAG0LYegjKJsr2pEy61agGjBm+DLy/ajwKIR4h1HlvHY9XOXtg4euIMmZK46AcUh
 R20ziESYDxM9eA/UpTXGM6W5HRW2fX4SdW8aEpxHWmeJLq6pahEm25afcX9fyuPALpt/l1a6HF5
 6XvN5LsJ+VQOsSq/6KZ70knCMyWPMnW4GKn7JCPL22oS5QHIs70hqVl2MpCWmBQuzU+d+U/m6VR
 d5nwETeY8t9VMC1jsdU/r9bJ/rZg+6dlB3kuvGI0L4a6mXrLevMqvL13aLig63MWQtEuSssIV67
 KEjWrF1
X-Received: by 2002:a05:600c:c10d:b0:488:ae4e:51a5 with SMTP id
 5b1f17b1804b1-488d683d633mr115963445e9.15.1776072351876; 
 Mon, 13 Apr 2026 02:25:51 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:fcf:4600:4cfb:7427:8a08:9d25?
 ([2a01:cb1c:fcf:4600:4cfb:7427:8a08:9d25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d684b55fsm94935965e9.26.2026.04.13.02.25.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 02:25:51 -0700 (PDT)
Message-ID: <a32bd2ec-10c4-4cfe-b206-9e96bdab37fd@linaro.org>
Date: Mon, 13 Apr 2026 11:25:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add Startek KD070HDFLD092 LVDS
 panel support
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260407-panel-simple-startek-upstream-v1-0-76721696655f@pengutronix.de>
 <20260407-panel-simple-startek-upstream-v1-2-76721696655f@pengutronix.de>
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
In-Reply-To: <20260407-panel-simple-startek-upstream-v1-2-76721696655f@pengutronix.de>
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

On 4/7/26 11:31, Stefan Kerkmann wrote:
> The Startek KD070HDFLD092 is a 7" WSVGA LVDS panel.
> 
> Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 91ab280869bac..737a1014f8112 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -4540,6 +4540,32 @@ static const struct panel_desc starry_kr070pe2t = {
>   	.connector_type = DRM_MODE_CONNECTOR_DPI,
>   };
>   
> +static const struct display_timing startek_kd070hdfld092_timing = {
> +	.pixelclock = { 40800000, 51200000, 67200000 },
> +	.hactive = { 1024, 1024, 1024 },
> +	.hfront_porch = { 40, 160, 216 },
> +	.hback_porch = { 30, 140, 140 },
> +	.hsync_len = { 20, 20, 20 },
> +	.vactive = { 600, 600, 600 },
> +	.vfront_porch = { 2, 12, 177 },
> +	.vback_porch = { 5, 20, 20 },
> +	.vsync_len = { 3, 3, 3 },
> +	.flags = DISPLAY_FLAGS_DE_HIGH,
> +};
> +
> +static const struct panel_desc startek_kd070hdfld092 = {
> +	.timings = &startek_kd070hdfld092_timing,
> +	.num_timings = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 154,
> +		.height = 86,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>   static const struct display_timing startek_kd070wvfpa_mode = {
>   	.pixelclock = { 25200000, 27200000, 30500000 },
>   	.hactive = { 800, 800, 800 },
> @@ -5532,6 +5558,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "starry,kr070pe2t",
>   		.data = &starry_kr070pe2t,
> +	}, {
> +		.compatible = "startek,kd070hdfld092",
> +		.data = &startek_kd070hdfld092,
>   	}, {
>   		.compatible = "startek,kd070wvfpa",
>   		.data = &startek_kd070wvfpa,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
