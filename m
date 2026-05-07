Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27632CD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D79910F1AE;
	Thu,  7 May 2026 15:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VA5/MjH3";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B9C210F1BC
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:36:28 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891f625344so11828065e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778168187; x=1778772987; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=BOJ+8+8n014/ZZxYvTpXNz4gBXn6E+/f1gXcWqpdrZs=;
 b=VA5/MjH3e4TOJvOtS7Xxkmsequ2o8HnO+YDQrVfUFeuD9i/o5zVmDqXbrSJ9kfVJXK
 bkAH91MuHqs1EzRr3v0HBKsDPBfMsNfWZUk73mamt/Xs7Nd0nq+ARuvkPj/n3PYzPere
 Qq/nKs9a5zyqoyGBgwa6WBAKqalXFkYwZ+YBN9gcOBhL08r2hFJsCU7mMh57QBOJSrnG
 pT5was4iAb/JWLboNZoFjOid4OqgidWYnHeYaTFFSEIHHnEI0/AgAsaH97BU9QuBnK07
 Gm1Ba/I+iGPMO1+JeTq+HXi/4eCr2smn5ApiG1eemVOKz9q3q1hvbpBlrGnDtbHOX+Lx
 wkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168187; x=1778772987;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BOJ+8+8n014/ZZxYvTpXNz4gBXn6E+/f1gXcWqpdrZs=;
 b=Y7B94CBqy7oJ1cBS0RjQn4TnYB6pFrnh/K7jc3zYUPgnf8h5+uPb7pyPk1o+2Dzfxs
 wj4Sd3Z7wMgggK07k1YZs1XTmo7PTHU9SZX+oBgKZn9n2IBWqM0Hg55lFT6K37p40dFP
 +ETNrUu3Jzv0znRUNnAHDSdnozob//arKqua9NfLNCYx7gSrSRYjVbDMtdjuBl7lco8M
 FO3vAfqfWbyR4Ob0VnFmTl75bLX7xviryQMoGzS+4XFTSvSVYVmhiVtLJ0QN+k6/kAYH
 lDTpN7ZCeRggs98caOuFzRZvzv+DGvR8bb82jTOHnq8lgu0+Bdfj7NfSkmKCwRSnsM0O
 04fQ==
X-Gm-Message-State: AOJu0YxH7ENp0oOJjxwMtbIjTBjmiBmOIdNdKnsTI8sGBv/SMeE4bIIL
 WmenEmzIaq2IQ+0b3Ids4FOKAJSh84mUTxiEUTsrK3sL7E1CilSIHuySJY11/4V9oKA=
X-Gm-Gg: AeBDieslTnC7jqoGHgK1gBNkMt4oryqEbDVyxZIHLhd5DxFWedXGwrbKMLUASWpWq8w
 QLZX7uLm9caCh0EXL8XQpzkYWFZBtl2ek2dXwo7B7fg5iMzhNtgn163Af+MPBK42p/ultkfnp0F
 YXFs8JEStKPS9WcbC0wp66pQLauBYwHJoKmMNNhHQAv+OlJ9q/puiAn/rPTL31OU96UwtZnlzYT
 bnSco+7NTyCR5U+53/ZPC5BUujxFELmp0q1INHdxlPbzNw48QPBKF0DnL8QASf+8ZW8FWANZ7LQ
 crpjJXWc3rh8S36S4FF36AUX0/DQ9O0ajm+m3qrtOR19F/B+3RGoTe1NzL6l1PP/XyVEA/+l+gw
 FGjWsnOnjWZjdbdcV+wat0PQvsh0a8pq7fUJSAZAoqvltmwL82Ry2seyOkioWYfYB7bMziTFxGr
 Ys2/e5j7G7VrinPlEJhHPu5wUEIW5E+EmkT8P7GOSJ0ujFwF1lJvfLfqlKerA9IY4br1lqb+Oj0
 ljMdbLep2Cm1C5Epw==
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-48e5e0089e0mr57342345e9.13.1778168186924; 
 Thu, 07 May 2026 08:36:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70?
 ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312dbf8sm40556895e9.23.2026.05.07.08.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:36:26 -0700 (PDT)
Message-ID: <bbb995b8-198b-4d05-a1c3-d9050830ea10@linaro.org>
Date: Thu, 7 May 2026 17:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 06/10] drm/panel/tdo-tl070wsh30: Use refcounted allocation
 in place of devm_kzalloc()
To: Albert Esteve <aesteve@redhat.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>, Michael Walle
 <mwalle@kernel.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-6-51f448c7c291@redhat.com>
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
In-Reply-To: <20260507-drm_panel_init_rm-v1-6-51f448c7c291@redhat.com>
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
>   drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> index 227f97f9b136f..13cfe252a838d 100644
> --- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> +++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> @@ -162,9 +162,6 @@ static int tdo_tl070wsh30_panel_add(struct tdo_tl070wsh30_panel *tdo_tl070wsh30)
>   		return err;
>   	}
>   
> -	drm_panel_init(&tdo_tl070wsh30->base, &tdo_tl070wsh30->link->dev,
> -		       &tdo_tl070wsh30_panel_funcs, DRM_MODE_CONNECTOR_DSI);
> -
>   	err = drm_panel_of_backlight(&tdo_tl070wsh30->base);
>   	if (err)
>   		return err;
> @@ -183,10 +180,13 @@ static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_LPM;
>   
> -	tdo_tl070wsh30 = devm_kzalloc(&dsi->dev, sizeof(*tdo_tl070wsh30),
> -				    GFP_KERNEL);
> -	if (!tdo_tl070wsh30)
> -		return -ENOMEM;
> +	tdo_tl070wsh30 = devm_drm_panel_alloc(&dsi->dev,
> +					      __typeof(*tdo_tl070wsh30), base,
> +					      &tdo_tl070wsh30_panel_funcs,
> +					      DRM_MODE_CONNECTOR_DSI);
> +
> +	if (IS_ERR(tdo_tl070wsh30))
> +		return PTR_ERR(tdo_tl070wsh30);
>   
>   	mipi_dsi_set_drvdata(dsi, tdo_tl070wsh30);
>   	tdo_tl070wsh30->link = dsi;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
