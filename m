Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD926CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C04010EAD8;
	Tue, 19 May 2026 07:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OUXRRSlm";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D69A10EAD8
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:33:11 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-488ad135063so24136455e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779175990; x=1779780790; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=WT2XihSgFDy/lOv8L6CXXNwwAVk4RQea7wu+1npHTP8=;
 b=OUXRRSlmH3nzasdvZKMrGHNA+z7ZgxWhf2aHTvayvMc48xgM1hry4+16UptoqInu2v
 cdS+DfBuyFngs1sOvY4D7LrYmyRN9G15bgN1VhAUhf5PQ28vZiSsMi8mF8e2gaOnf7A+
 shmTP0pVYKjqeICj1iTJtNIBxy07KKKo7X0L6+IZ+jYa9sYt5WXZfIFLymoXH6tdsB8r
 04mGUMt0yjc8O65e0Hkc47ij3UocmNgHG058WWFA2poKcGQHzGv4sFu6eWQgqxPDvdh6
 l+MKcvoiDIr9k2x/c8rP+XDRsZMHnDYDBCU0mdGWWkVggD/kC/LSdaRSiFkfijQH8Oq7
 DVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779175990; x=1779780790;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WT2XihSgFDy/lOv8L6CXXNwwAVk4RQea7wu+1npHTP8=;
 b=UUOHV/owDJJotujiw9TdQbdUSeLQWBvOeCAFFASiJu/himj8sP6rWQ2/Oyut4NVCH4
 6+f1RjA2MwKtXMR6nh6yCdo4BFGrLIdnk/znm3t1xKC2bgFOTOutE/dz6OD1A7gLp6Go
 gSfIBCBSE61iSHEDdrwmP4tkP74hSdOsHB6F/2WZwWIOjiPggueJDZkJoFUS4GnvnYzR
 QNXxNa7pjzrdrB1+5WGo9kOgflRwELJpLBYHCFO5Ek+/kPJyDpUp9V7EnvwswKblf/Kl
 FPudNb+ytIFOd1HxJ5v4+b1B/lDwQ1nU9GIual+XKJt72bTuBeEqQW8hhNGs6Sg6japl
 YDDw==
X-Gm-Message-State: AOJu0YxlAFIwwhLxZA7Fjf0J2pKUeiqe4S+df8+By7UfaKD6+vXTkp9k
 vwHsBwtcgziyriBrbsj5N1idhY6CdTHgM8TNqWvr1AIgR7K3u4XlcIKL9Z0+MJovPuI=
X-Gm-Gg: Acq92OHXeX/gQWszanBUtKY0DrZHAXY2ZdWyDY/ysAktSHTuithi92bnDY7VrsH9Yfz
 esuo043fAPh2E2BTwnKSXs8Qok7KLBvrBSWBguaGqlwBtTyO64bQRJCxSqo4Lix9v25PyqsLrsM
 4KTtoSDjeIbw+0FMsUlMe+qK+W4TOpiXxXwMtMCspfU9IHPsdS0gfzqpBUQ1Ls2ajZgp7a56WNx
 bTIpoHnnOc3FAMAt7Cl97yhMYtxEoxg/i/avBZ531niUznEPeaU7LcJFEISoR7yxswGtdmvarmJ
 QthkQLK9ZiUcnmSMBqALPeHBHrmgS2bpJ0yflql+4/+iT6t1D/SHsTQ1Zgkjehb+HG9viFFdwtb
 BTVI+lCB7pnyT89XLGy5AUdYKp9fBw1VTNQWboHSDOy2+y47v7xf3loJkVdAsIhSOGM4UO73UaR
 GfOlSukmqIuTE6n/ElYTpWvBz1ulvsd/BZcuBIZMZkJ32UHTDsAfIi8uo9Ednf3GXXKyxD+zs0u
 1k6RlarIROs+20=
X-Received: by 2002:a05:600c:858d:b0:48e:82b4:b54 with SMTP id
 5b1f17b1804b1-48fe6514873mr222865245e9.23.1779175989618; 
 Tue, 19 May 2026 00:33:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ff43f213esm136408795e9.1.2026.05.19.00.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:33:09 -0700 (PDT)
Message-ID: <4ed0c9c4-6a48-4c25-9caa-16914587e580@linaro.org>
Date: Tue, 19 May 2026 09:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 08/13] drm/meson: dw-hdmi: Use local dev variable
 consistently in bind()
To: Jonas Karlman <jonas@kwiboo.se>, Kevin Hilman <khilman@baylibre.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20260518194744.2483580-1-jonas@kwiboo.se>
 <20260518194744.2483580-9-jonas@kwiboo.se>
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
In-Reply-To: <20260518194744.2483580-9-jonas@kwiboo.se>
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

On 5/18/26 21:47, Jonas Karlman wrote:
> Replace indirect struct device accesses via pdev->dev with the local dev
> parameter already available in meson_dw_hdmi_bind(), for consistency and
> readability.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 30099bf71aad..fcd2426af9fc 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -671,9 +671,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   
>   	DRM_DEBUG_DRIVER("\n");
>   
> -	match = of_device_get_match_data(&pdev->dev);
> +	match = of_device_get_match_data(dev);
>   	if (!match) {
> -		dev_err(&pdev->dev, "failed to get match data\n");
> +		dev_err(dev, "failed to get match data\n");
>   		return -ENODEV;
>   	}
>   
> @@ -771,7 +771,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   		return PTR_ERR(meson_dw_hdmi->hdmi);
>   	}
>   
> -	meson_dw_hdmi->bridge = of_drm_find_and_get_bridge(pdev->dev.of_node);
> +	meson_dw_hdmi->bridge = of_drm_find_and_get_bridge(dev->of_node);
>   	if (!meson_dw_hdmi->bridge) {
>   		devm_free_irq(dev, irq, meson_dw_hdmi);
>   		dw_hdmi_remove(meson_dw_hdmi->hdmi);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
