Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E001ACD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5247410E9EB;
	Tue, 19 May 2026 07:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cx96On0v";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B9610E9EB
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:34:35 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so47082965e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779176074; x=1779780874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NkpJii8tv30gQeyVix9/XICxyBov61uU4hi0wKikcJ8=;
 b=Cx96On0v5CANJm+bI/wce1yxhqU7z6J4dqwb4xBttNOtTv1gfyXGjx30YekfkotvgD
 yKC0ius2sgelc9jIK1Bpdv6nWZy1OaNLoEdtbDGJpbY7II2eWTTPkP9M73DewmlyOeqv
 YIjFBTCMYg0U14UhaspI3LS4BNBH0WO55yGkIBqnGpxnQJnxNSZSiPYsO6M7/D0QPyDV
 wPcWZsWTr2TBQF8hX8pWChUEn3BDTmDvXU/ZQHgDFOzKfxgbtvsOA76FgIKZMt1gpxcj
 IxPaVe8Hms3wYzBH8NzmbrfYyabRSuulltbnSG+wr9TWW9diD8pJJcgvZRfmCQNR+cHP
 Eg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779176074; x=1779780874;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkpJii8tv30gQeyVix9/XICxyBov61uU4hi0wKikcJ8=;
 b=JM88AwMnAwd553M1ZTz0mvdFlromciofShxnCoMxJA5lIhVyjorrHmpBTO/h5Xh3zv
 TWyrMQegPziwSsAUV9N9Bth1hnsFdOxw0+cackFyFcpPCOLIvPZyoJPtQwNzzIpy2mjC
 89At582lmKSEQEIfxhyQRDzx1zCBbtXFU5LUqRdYVOS9FmVFjnO4Z+HriQtsXVNnwqZ6
 XLK2sl6ErLgrKwQyyMdGZiIW1H8nZsvBz3pqZtZ7HT09aj0BVAeMgNFGNT8BB9w18bgY
 7CWr4VXMc1fWy2qZV/waG0xf6PiT6PXUXYbyY2CG934/DbPQ+deUkC2z1DpvuGQ+injD
 o8/g==
X-Gm-Message-State: AOJu0YzxJKtUEwwD9CiYLS/MbsAakAblQD7PXBmPVT4rbZPaE/OxZhlD
 iVz2TAaZmnt32j1rw9bx9oNnfjJDLubMBq4csXC227hhWydjerQHAhGdq8hgHcckShw=
X-Gm-Gg: Acq92OFb62DTmoRHT1qRAsAwkh7e2FgSEj0mbbsD8uLTMAuUQrZQjssbS4qB4MXzbRu
 Pbz6s545Qzh+WFd9kkPLtK6HRwxrW/QcYmsEA9UOfmtPNRYh1bPyoGZYuLFuQlRsxpZXhxsue9P
 kpayA+vLoXybiDihvfQqMQ1pTH0iZ0qKwHqcu5Y3sSHdi1CQWyUePr0D1OhDJxKHFcv8PvIEb4f
 wn1K4HEGDmrIUfBzpqapnhGXLv5OWHoEh2Eifgk/ahiHrw9SOGslmFMNuXNzkFHozIE8KRA5lx0
 ZHEncgoNJIv51V4iZnWTMETvoLByzSElz9sgCTZqGjXmZvy3K7qQ/uOlBGtGuuJo/q3DXzFLarg
 xm7We9h3p5jREEezL6nLia3+zPBVOGJP+5zb/q3TjV2B+ZJ7E23uWKrY3ttS/gAo4zDfiTU7Chi
 XG3Y6pUlwYXi4rBT7LubbfMF1ZijqpjvmCV/Ic7eieFDswEgQUZTIAisR3KS8ljRxRzGcOT5H25
 kxDur6yVf02QGE=
X-Received: by 2002:a05:600c:4692:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48fe632661bmr293018735e9.19.1779176074203; 
 Tue, 19 May 2026 00:34:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17a22sm43795418f8f.22.2026.05.19.00.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:34:33 -0700 (PDT)
Message-ID: <c5b417b6-1430-4a4e-a0ea-207221a4d344@linaro.org>
Date: Tue, 19 May 2026 09:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 10/13] drm/meson: dw-hdmi: Use dev_err_probe() to report
 errors
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
 <20260518194744.2483580-11-jonas@kwiboo.se>
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
In-Reply-To: <20260518194744.2483580-11-jonas@kwiboo.se>
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
> Change to use dev_err_probe() to report bind() errors consistently.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 65 +++++++++++++--------------
>   1 file changed, 30 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index d0cf2042d41c..1dd59196ff7f 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -650,10 +650,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   	DRM_DEBUG_DRIVER("\n");
>   
>   	match = of_device_get_match_data(dev);
> -	if (!match) {
> -		dev_err(dev, "failed to get match data\n");
> -		return -ENODEV;
> -	}
> +	if (!match)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Failed to get match data\n");
>   
>   	meson_dw_hdmi = devm_kzalloc(dev, sizeof(*meson_dw_hdmi),
>   				     GFP_KERNEL);
> @@ -667,50 +666,45 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   
>   	ret = devm_regulator_get_enable_optional(dev, "hdmi");
>   	if (ret < 0 && ret != -ENODEV)
> -		return ret;
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get/enable hdmi regulator\n");
>   
>   	meson_dw_hdmi->hdmitx_apb = devm_reset_control_get_exclusive(dev,
>   						"hdmitx_apb");
> -	if (IS_ERR(meson_dw_hdmi->hdmitx_apb)) {
> -		dev_err(dev, "Failed to get hdmitx_apb reset\n");
> -		return PTR_ERR(meson_dw_hdmi->hdmitx_apb);
> -	}
> +	if (IS_ERR(meson_dw_hdmi->hdmitx_apb))
> +		return dev_err_probe(dev, PTR_ERR(meson_dw_hdmi->hdmitx_apb),
> +				     "Failed to get hdmitx_apb reset\n");
>   
>   	meson_dw_hdmi->hdmitx_ctrl = devm_reset_control_get_exclusive(dev,
>   						"hdmitx");
> -	if (IS_ERR(meson_dw_hdmi->hdmitx_ctrl)) {
> -		dev_err(dev, "Failed to get hdmitx reset\n");
> -		return PTR_ERR(meson_dw_hdmi->hdmitx_ctrl);
> -	}
> +	if (IS_ERR(meson_dw_hdmi->hdmitx_ctrl))
> +		return dev_err_probe(dev, PTR_ERR(meson_dw_hdmi->hdmitx_ctrl),
> +				     "Failed to get hdmitx reset\n");
>   
>   	meson_dw_hdmi->hdmitx_phy = devm_reset_control_get_exclusive(dev,
>   						"hdmitx_phy");
> -	if (IS_ERR(meson_dw_hdmi->hdmitx_phy)) {
> -		dev_err(dev, "Failed to get hdmitx_phy reset\n");
> -		return PTR_ERR(meson_dw_hdmi->hdmitx_phy);
> -	}
> +	if (IS_ERR(meson_dw_hdmi->hdmitx_phy))
> +		return dev_err_probe(dev, PTR_ERR(meson_dw_hdmi->hdmitx_phy),
> +				     "Failed to get hdmitx_phy reset\n");
>   
>   	meson_dw_hdmi->hdmitx = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(meson_dw_hdmi->hdmitx))
>   		return PTR_ERR(meson_dw_hdmi->hdmitx);
>   
>   	clk = devm_clk_get_enabled(dev, "isfr");
> -	if (IS_ERR(clk)) {
> -		dev_err(dev, "Unable to get isfr pclk\n");
> -		return PTR_ERR(clk);
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "Failed to get isfr pclk\n");
>   
>   	clk = devm_clk_get_enabled(dev, "iahb");
> -	if (IS_ERR(clk)) {
> -		dev_err(dev, "Unable to get iahb pclk\n");
> -		return PTR_ERR(clk);
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "Failed to get iahb pclk\n");
>   
>   	clk = devm_clk_get_enabled(dev, "venci");
> -	if (IS_ERR(clk)) {
> -		dev_err(dev, "Unable to get venci pclk\n");
> -		return PTR_ERR(clk);
> -	}
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "Failed to get venci pclk\n");
>   
>   	dw_plat_data->regm = devm_regmap_init(dev, NULL, meson_dw_hdmi,
>   					      &meson_dw_hdmi_regmap_config);
> @@ -724,10 +718,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_top_irq,
>   					dw_hdmi_top_thread_irq, IRQF_SHARED,
>   					"dw_hdmi_top_irq", meson_dw_hdmi);
> -	if (ret) {
> -		dev_err(dev, "Failed to request hdmi top irq\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to request hdmi top irq\n");
>   
>   	meson_dw_hdmi_init(meson_dw_hdmi);
>   
> @@ -752,14 +745,16 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   	meson_dw_hdmi->hdmi = dw_hdmi_probe(pdev, &meson_dw_hdmi->dw_plat_data);
>   	if (IS_ERR(meson_dw_hdmi->hdmi)) {
>   		devm_free_irq(dev, irq, meson_dw_hdmi);
> -		return PTR_ERR(meson_dw_hdmi->hdmi);
> +		return dev_err_probe(dev, PTR_ERR(meson_dw_hdmi->hdmi),
> +				     "Failed to probe dw-hdmi bridge\n");
>   	}
>   
>   	meson_dw_hdmi->bridge = of_drm_find_and_get_bridge(dev->of_node);
>   	if (!meson_dw_hdmi->bridge) {
>   		devm_free_irq(dev, irq, meson_dw_hdmi);
>   		dw_hdmi_remove(meson_dw_hdmi->hdmi);
> -		return -ENODEV;
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Failed to find dw-hdmi bridge\n");
>   	}
>   
>   	DRM_DEBUG_DRIVER("HDMI controller initialized\n");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
