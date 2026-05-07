Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7A4CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970F410F1AC;
	Thu,  7 May 2026 15:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vMBs+VMI";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2CF10F1AC
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:35:40 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so12581625e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778168138; x=1778772938; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=48EgchF5dtmC/4scZDvcW2a4RnHCw/qdBUIKinwh0Wk=;
 b=vMBs+VMIxspwuYvQRkIdnh9X4L8B9bM9j6ovrrVo1Chu30ccLD23+KD1hVItUE9g4Z
 X62sQ31jydbrgcHzbjFvw7vlmvo/ZlwnOlX1sMerKBYYUI+2IEFY9I705y9sNUUgQd7q
 O0izyg0AtNInD5QjkoWyyFAxOe8X04qDCKeLCE0TDMLuWrvW3T962jVFuSNZS+cH2F+1
 ScbvNTpOG/ifVLeOaTC8R6ThU3uxRrNFlbPp+3UhF5rBJm4M7THOE9gX6e3TtbaMHP68
 5TQ2UZe5GPmoHU6hJQ/XB7AfJ0aMQyoI+6u1ARlg6LUC3xx/f3yHVmDj4EPkUNisTIDx
 ZWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168138; x=1778772938;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48EgchF5dtmC/4scZDvcW2a4RnHCw/qdBUIKinwh0Wk=;
 b=TMxgHfMSwIFndkLJ4p5tzOoYtt3VfGK0FiffLNvW7sf69ZGEDyoXAFnHqIwsA1ZB2X
 UOT5j+m1Nn4YpYue32CPuPuuQO6/uhG5ijTGmTAAXVrgl/t+d6ujo9PWDjW/Z4287YvK
 R9rwBYYPAVpiL9vEQ89Tc1rGOl7sHJHpjCIP/39pPFkc1GdvCaCTegzw+OpzCPECiHKb
 KwHGL6BPrkVYsuOkDAMtHYKW8DxgnWE8D2Rs5GzIP3JNxJvvIzv1LKLCRcpitrz2CExy
 wIqWGs0xT3Tcu+1xY4TwjaFPo5SIMrAo91bUfn6eRHV3Flq3konNVXs5wEBbXkpQzbMb
 8pMw==
X-Gm-Message-State: AOJu0YxF9eUHMBQC7d/qAGa1FEk77mLa6D4H53BfgSFCHRfY1cvu1HfF
 XdsGtj69jeNBVFdURF+z77RlCpTeuJZdAtl5LS5/SHZA21mTx3hsQ1gztTEIA+4IMc4=
X-Gm-Gg: AeBDieuJwue5KsN1zMSfDdKlIKiB0UJCqf90PKUx8FrmTRMjvT85E36ZLQWkFOvdq9j
 iFzJpAmUOTyihhG72+AR2IAiA25ioI/3ZovRmnGYz01BPmreD69rW5Xf8Saxgkf63CzRmTdnB6v
 VyVxVE3/Bw4W4UHvIklHnLMxuNFlUy4ARCKHr/fihbCcRWAbQ5mrCIzYs6E/JcOkkGdxc4d3i3v
 lCB279uue98j3Rw/avVS/dEnMkw3VIBOlxiDyOyQPfluAVYUBlfor9bgMDjkmp7vq/hu/nbeVbm
 w17GLOBF4BhRuSSEjkNglJaSoIPV6G8UxP33cqi1hnA5AyffBX9Olhy4oOMctUKL0acuYxaDkvl
 sh4+3bpevzSp1f3ZyIaw4r+LivUe1DNgHeOaun17UzdsTBZxClY6izvKJUZv9OfRdEvIm1QW7R9
 K+/PpXApESErCQnh0ZuCo4KnDqY2JvQwHNV6jaaYwPD/W19TWOuvv5wONalroMLq60pQrKdZpcI
 FqpO5UBM3DhraGqNA==
X-Received: by 2002:a05:600c:8908:b0:48a:7a10:4f17 with SMTP id
 5b1f17b1804b1-48e51f21e0cmr94559425e9.6.1778168138248; 
 Thu, 07 May 2026 08:35:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70?
 ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53116a9fsm63026735e9.8.2026.05.07.08.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:35:37 -0700 (PDT)
Message-ID: <3e306cdc-ebc9-4aa5-b820-d73808072945@linaro.org>
Date: Thu, 7 May 2026 17:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 04/10] drm/panel/lxd-m9189a: Use refcounted allocation in
 place of devm_kzalloc()
To: Albert Esteve <aesteve@redhat.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>, Michael Walle
 <mwalle@kernel.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-4-51f448c7c291@redhat.com>
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
In-Reply-To: <20260507-drm_panel_init_rm-v1-4-51f448c7c291@redhat.com>
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
>   drivers/gpu/drm/panel/panel-lxd-m9189a.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lxd-m9189a.c b/drivers/gpu/drm/panel/panel-lxd-m9189a.c
> index 68019e1e43a96..baaf170779e03 100644
> --- a/drivers/gpu/drm/panel/panel-lxd-m9189a.c
> +++ b/drivers/gpu/drm/panel/panel-lxd-m9189a.c
> @@ -165,9 +165,12 @@ static int lxd_m9189_probe(struct mipi_dsi_device *dsi)
>   	struct m9189_panel *m9189;
>   	int ret;
>   
> -	m9189 = devm_kzalloc(dev, sizeof(*m9189), GFP_KERNEL);
> -	if (!m9189)
> -		return -ENOMEM;
> +	m9189 = devm_drm_panel_alloc(dev, __typeof(*m9189), panel,
> +				    &m9189_panel_funcs,
> +				    DRM_MODE_CONNECTOR_DSI);
> +
> +	if (IS_ERR(m9189))
> +		return PTR_ERR(m9189);
>   
>   	m9189->supply = devm_regulator_get(dev, "power");
>   	if (IS_ERR(m9189->supply))
> @@ -191,8 +194,6 @@ static int lxd_m9189_probe(struct mipi_dsi_device *dsi)
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST;
>   
> -	drm_panel_init(&m9189->panel, dev, &m9189_panel_funcs,
> -		       DRM_MODE_CONNECTOR_DSI);
>   	m9189->panel.prepare_prev_first = true;
>   
>   	ret = drm_panel_of_backlight(&m9189->panel);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
