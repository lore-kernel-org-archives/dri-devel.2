Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6B7CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9754D8924B;
	Tue, 19 May 2026 07:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="La981zJg";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAED210E36F
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:24:41 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso38936605e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779175480; x=1779780280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=T1JwviSU788ImildKu5V2g5LdkhxoNhqBKf1BksYwwI=;
 b=La981zJgjZrvuTd0UDcgckPqkU7HonQKJ3gPJgcwHjeZjOoTiVRmhg0cx74JFwoxeX
 /HZPrEHEMSPPYZk4mFLwfQ37ZyOWqWE4gZ0SsWL6ZAZMiGbf+EJwRUNOnYYy4J29ZsOg
 mhAUHhdMhJMIHT8xK6AAdTa+b7L8Xd9N/ax7yEtFhEygWwc0h9kFaZQc8oPg7EeZ4sux
 riLm07ME/sdwpcAaG/fdx2MfQY0a+dSaF+PUYZ6vz2snMPrxlxGl09KObDKL9MmgF8Qx
 H+uOM33wLocrew/N5HyU67TXZIyQiTAlDHxEKCV0bAo/RL76CdUnSNKakCAxLJMcKUQJ
 gAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779175480; x=1779780280;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T1JwviSU788ImildKu5V2g5LdkhxoNhqBKf1BksYwwI=;
 b=hYPY0epj2aLToXQvEyK4qd/tdMDvnyTtrJhsK6rAPdC9QEha7N+NsZ0TJ9Y3M50V8J
 3rWWSz/kq6qOjLHnmcTytQ2/bDePkAyi2U4yhrDRRbuhYX45wtljWJBK2ORDzYNMcUQO
 5gWfTCnQX454FxgxtOw0qoSjpMD4K1BBUOJ2mNYiHMXxv0qio4va355beH+CxZqeuPuE
 jasGChe1NYihW1EcfTKdujVE7R9a04y1pGgCfw2dox4ML0Wrnb/suMFVZTc5d77qSciE
 7HAwZfWgpXXE4iWjrn5Jt7KBLRV/RUuGmoWv5/Jq3s2JY5fy33OOVsJCzNUe8Pudwezb
 ElTg==
X-Gm-Message-State: AOJu0Yy2IMdZNysLQf4UIf0Jx/W2IrAwEo6wAUY/ZhhLMlRv17VdX9xu
 2V2mI7qligNJ+lliG1meAmM3TwmM6WC+DVnG7m5VK6TgjTc2uOOJHL07lP4qg9JvVWk=
X-Gm-Gg: Acq92OEFYCDsDePc0hwZEgYox/UvJiiqmKV7yhhQdqpqq0uSCfWGSQ8yd8g+qw4gvs8
 U6LqG9PNfRzxtbUqWlWQLovKbOfQBVejBZhcRxekdLi9IZQt9DkheXIote5NpYVHiiXEcukBNN/
 KrCOwfyadogkfD9Hsyz0w11qwRKk5rBc/ZquVbLOkdOsENYOMfRdKQYCrjvVtRh7m2TxpHvOo/e
 gyu052gp7HZvdmUuJCTLlCDsJB/WHHRhIxqoI6LacQQ88ZcvXyABxYoAjlKVYjX20ZXyQHhkvHM
 pJWwGnvbzeVcRBnpKuvtnHuVRfBGJ8MoqTIGEaC66XXh6L58lO4G30aAGzashXSBZXUn8ovxPZi
 XMf+UJDJog2yJtv5RxfwwkGgrI5J5E91PyCw6BLYZTbzzzcF/e6QXStk4ysXd9el4/mMR+tHyXD
 6E490ZyFxKFiFxUW1qM9cS1WsM4BnPeHsmif9o1JBySPjRt5X38Eyao3FumNswWruq7RDrNI+DN
 8+g
X-Received: by 2002:a05:600c:c086:b0:48a:563c:c8c5 with SMTP id
 5b1f17b1804b1-48fe60eabddmr207018885e9.8.1779175480245; 
 Tue, 19 May 2026 00:24:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2c96csm102486505e9.2.2026.05.19.00.24.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:24:39 -0700 (PDT)
Message-ID: <b135ff44-16d5-4a9d-9c7f-478c070efbb0@linaro.org>
Date: Tue, 19 May 2026 09:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 03/13] drm/meson: dw-hdmi: Call dw_hdmi_remove()
 consistently
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
 <20260518194744.2483580-4-jonas@kwiboo.se>
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
In-Reply-To: <20260518194744.2483580-4-jonas@kwiboo.se>
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
> dw-hdmi export two similar pair of functions to probe()/remove() and
> bind()/unbind(), update to use dw_hdmi_remove() for consistency.
> 
> dw_hdmi_probe() will drm_bridge_add() the dw-hdmi bridge, so it is
> expected that of_drm_find_and_get_bridge() always return the dw-hdmi
> bridge. Regardless, validate that the dw-hdmi can be found for
> consistent error handling.
> 
> Also always ensure the IRQ handler and bridge is released before
> dw_hdmi_remove() is called.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index eafe7daf6ff1..9aafdc768f2b 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -775,10 +775,17 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   	platform_set_drvdata(pdev, meson_dw_hdmi);
>   
>   	meson_dw_hdmi->hdmi = dw_hdmi_probe(pdev, &meson_dw_hdmi->dw_plat_data);
> -	if (IS_ERR(meson_dw_hdmi->hdmi))
> +	if (IS_ERR(meson_dw_hdmi->hdmi)) {
> +		devm_free_irq(dev, irq, meson_dw_hdmi);
>   		return PTR_ERR(meson_dw_hdmi->hdmi);
> +	}
>   
>   	meson_dw_hdmi->bridge = of_drm_find_and_get_bridge(pdev->dev.of_node);
> +	if (!meson_dw_hdmi->bridge) {
> +		devm_free_irq(dev, irq, meson_dw_hdmi);
> +		dw_hdmi_remove(meson_dw_hdmi->hdmi);
> +		return -ENODEV;
> +	}
>   
>   	DRM_DEBUG_DRIVER("HDMI controller initialized\n");
>   
> @@ -793,8 +800,8 @@ static void meson_dw_hdmi_unbind(struct device *dev, struct device *master,
>   	int irq = platform_get_irq(pdev, 0);
>   
>   	devm_free_irq(dev, irq, meson_dw_hdmi);
> -	dw_hdmi_unbind(meson_dw_hdmi->hdmi);
>   	drm_bridge_put(meson_dw_hdmi->bridge);
> +	dw_hdmi_remove(meson_dw_hdmi->hdmi);
>   }
>   
>   static const struct component_ops meson_dw_hdmi_ops = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
