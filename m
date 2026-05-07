Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12F7CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E07910F1C2;
	Thu,  7 May 2026 15:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nBnwReEh";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5646410F1C3
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:37:24 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so802793f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778168243; x=1778773043; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FR5wZFgikhLRQ2djaH08NzpUj2HNfqrfQYUASHjPXMA=;
 b=nBnwReEhSo/EsievN6cP0T0Iqck7ZCb1yXd7BUuhF4Z4ligoy3P6RZcSiQO15QcsFZ
 jD3FVGiFuKzXnk8HwJl2aDyHk3MYjG9L+Slgtkg2bErB5QxDzYxT6LyNwBbN5rduA6oD
 WR1GGSuWoBNLBEo4R+SNXeBgt09EF8DkWI8M5J2RgAHtgDUSEd5P23Y9A3zJuQpgy2n4
 qkpP1DjJvg32SIBTSAQssmj2ro4jRkcle/h58tvQ4JmwqHikq9GTJ8hOYc7g/blWKQsL
 jhKaE+kvi3bBx6tI5+HJL9DEGuEKtNbhP7UEcGstBsp5XKBvxs4z2zVdelGIh2E4aPbP
 5i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168243; x=1778773043;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FR5wZFgikhLRQ2djaH08NzpUj2HNfqrfQYUASHjPXMA=;
 b=n4hHmN0ICwOJ7NTwha60LT0m+pQMQoE2EVlkcMW1VQSdZt1lIxdEjfxtSxgxhuShIF
 vkwUv39YKaXDBt5GQkzSp99z9/2hsgQHmVke+vvGzFUcgmwUq208zUydvzOPVIYRHg7+
 /W6SsQD6wS0YnbhZ9xxwmFDltrXVAcUjGjtvCslfA3E4b0F/yIx+588+PAXszI3kfwrP
 HvUNUaJf/BTPrPsKbWkGOh97oOKQdVDAETCgOlmeRQlfI7zdKNyRuQCSxh6ds+JvIUy1
 EVW7+evDwOlkhCfmWp32kw71SrsvDDuyXtxOnrdymUJdsHZFyl6Myq6+KhOzB9Bs+CPr
 NX5g==
X-Gm-Message-State: AOJu0YyLOFKsAmkSpRBKXyEBYGh+HfQ+UzdQ6x42WMYEl1OwJp9mw1fS
 15Ob8LRLbiBqEoyIdLHBmwf2v+zjtE8VCetO9koFC9asQQPRNGNcer/do5KiAZcgCic=
X-Gm-Gg: AeBDieuKiYW2M+6ni/vT4VW/nLbRyu36j+BKIOQsyB6fsHD+O6PwEW0jcRZ56xdcWXf
 VN6o4ZZ9kSQSLvouR+vheLZN2CGKSvkFotuf9lQxOSPf+zVcMZ/eoLQ43Bn01DjDm73eiyoHXni
 ea97G8gmNIYz56LilXz6ZGizKn8VFs5EXyt6EmduD8bInr1r1NKx5/tv8UsdoeYzB0c0cQWiSyf
 O5JrQGTIwg1egjs8iF4NGw2C6csryEi9JsHEiBmLcTimTQx1xvYe9/1PlaHLsoRRKLKOFeUIIu7
 gUnO1zl+Qk90oDID7CzLFBcA1V+V1zI6hWtkyczTjBkzgn4GV2OZcOz4OCvqz3RaUn12dNG5a9K
 nQ5cM5s1HpNPwYN7/2JfT7gddKrTeVatCixucjSdAxIHe3WjFNlM9chdNzyQmPyviFlGqkA8BrD
 x+sDybc4cuezLqB6CRqBwTJy+ttWs8SDmAH3TBbdS8toPMZclSQyBFAutCmubikhrLpfmbIYnwt
 6oQJ5pq1sx9TCoPIQ==
X-Received: by 2002:a05:6000:2c01:b0:43e:a72e:ec5a with SMTP id
 ffacd0b85a97d-4515ce1c804mr13704951f8f.20.1778168242629; 
 Thu, 07 May 2026 08:37:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70?
 ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960902sm23025743f8f.28.2026.05.07.08.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:37:21 -0700 (PDT)
Message-ID: <ee79f7b4-1e58-41af-a4a9-d72cfaea8bdb@linaro.org>
Date: Thu, 7 May 2026 17:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 09/10] drm/panel/startek-kd070fhfid015: Use refcounted
 allocation in place of devm_kzalloc()
To: Albert Esteve <aesteve@redhat.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>, Michael Walle
 <mwalle@kernel.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-9-51f448c7c291@redhat.com>
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
In-Reply-To: <20260507-drm_panel_init_rm-v1-9-51f448c7c291@redhat.com>
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

On 5/7/26 13:53, Albert Esteve wrote:
> Move to using the new API devm_drm_panel_alloc() to allocate the
> panel. In the call to the new API, avoid using explicit type and use
> __typeof() for more type safety.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
> index c0c95355b7435..7f04b7b404e7d 100644
> --- a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
> +++ b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
> @@ -286,9 +286,6 @@ static int stk_panel_add(struct stk_panel *stk)
>   		return ret;
>   	}
>   
> -	drm_panel_init(&stk->base, &stk->dsi->dev, &stk_panel_funcs,
> -		       DRM_MODE_CONNECTOR_DSI);
> -
>   	drm_panel_add(&stk->base);
>   
>   	return 0;
> @@ -303,9 +300,12 @@ static int stk_panel_probe(struct mipi_dsi_device *dsi)
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = (MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM);
>   
> -	stk = devm_kzalloc(&dsi->dev, sizeof(*stk), GFP_KERNEL);
> -	if (!stk)
> -		return -ENOMEM;
> +	stk = devm_drm_panel_alloc(&dsi->dev, __typeof(*stk), base,
> +				  &stk_panel_funcs,
> +				  DRM_MODE_CONNECTOR_DSI);
> +
> +	if (IS_ERR(stk))
> +		return PTR_ERR(stk);
>   
>   	mipi_dsi_set_drvdata(dsi, stk);
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
