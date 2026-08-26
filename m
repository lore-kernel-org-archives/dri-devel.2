Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202DEC61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4418F10E275;
	Wed, 26 Aug 2026 09:59:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CrnCWMzn";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A4210E275
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:59:06 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so6516195e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 02:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787738344; x=1788343144; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dOmSdYlyOAFsl03GMtU/+gDLnQrEtJ7AmptXO+pqeoU=;
 b=CrnCWMznWST40qoIPwRSkYunV7Ua8wkxx0a9j9vRmfDAIsAdxqGYYECF2L7dd0gM6B
 eu6Rms/0Wf4kI4vC9spk2WdDHg+VLq4vC9GF/S5Yd0XTALNuWzWXxMfDZ2UoC8euCtSg
 EcmhplCwUTuPjHs0f7dafT8uttjnRg1vHugEpEOQ1MsdwgCUaHibpNdHDKtWV8PeoY8H
 nsqWME0Bq41qgJa8b3HFqCdPe4nNlfwZxIXBCUscdwmNav1vwIsKwxjJX5A6kFXWT2VC
 UUOyL6IvQ+PhxyJJ3oMoTSxLBhH/Lbjh2YlQ+NPwMJ9e9oAP8lYWVuQ6SU+q2vn0eS7H
 kxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787738344; x=1788343144;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dOmSdYlyOAFsl03GMtU/+gDLnQrEtJ7AmptXO+pqeoU=;
 b=l9gH+BpXVl8v7R8HYviTuyAQCdQyF86+3e/G9yuUSzFTGbPbxINMJuQO3wfM4U/pEK
 ud7GojJ9ANRCCV7d/uNMmI5pR+KiYiWOv6ulhTxiNnkbN1D3ssPQkGvHQw0H34LVIBPh
 7Mq+ISuGx2Y/qKldrYW1lqUoev+E5uTEroM79LqiXguMNikeajtHu/CN3qvpqeBA3kSP
 R3hm7jX+yprYOpWhe7df9ZoEMkD2AV4JkS08iJ1+HNSUA/nq0o93ww6uec6WiD3EI0SC
 PjBQusESHxYCt59/JvOCYBAZENFFIf3tdqDcI5TodiX79AjJXmj64Um5+eKj/NEJ4kbQ
 OwRQ==
X-Gm-Message-State: AFuF++kC6ePkI4tVap2xgQwjD9uVplw6DorSBEfXnltlWxjwdfKN8wLO
 VIpb5odZbpn6jpDFNPbGa1AODQxK9cxTNwIeEbY1mKFduvDXsZS+IXbv4JOtbrOUN3w=
X-Gm-Gg: AR+sD11WUoC0wNBpEzKjeZpV1rQHJee7ui519uRPOPZt938hv7AfdVieP9lRuOSBuBr
 rL8NLl4YQ4aZXWhmfu2EsymBUoe0SPNdAg/vd3GMR7b/Jye0F3k85WzDk8IbHgOpW/UCAH9/jl7
 P9ffYlG5TPJgXdHEKqRHbOOwcN0XvjCQgXM6V/bARhKxIWLcH2o59/5b9c6VfMNQ3QK4eq6H1/L
 veNQ/6+L5q//W7lEWceYt/ox3/fB19BGf8VCC3Pobx560bMBipUEoFQ5ByKZcPhJ/v7psUian3+
 8iaJgOyeax71YDFZ/tYar/dY9WYvTqfpusXsv/BLvwDYm22P40upXTYiEDsdqOofj8+AQx5FsZy
 BIeM+DwIPiYWEpOfcqfqkqlfoUIFfBDGaClJzPxHme2dRLwkpCaeYB35jq/IGyHu83DK8eEgYms
 5xKhvGaCeEVe9Tyn+KcrI0t2P6KQ2/WzqWMg3usbvf3/X4TqRJWQNoiXVHqKId4SMQpJ0jNmXPG
 Poz4yLj7l2Kx/SIx4ClOSLbBq9C098h2bGj5zT/RfCOzg==
X-Received: by 2002:a05:600c:c4ab:b0:499:a8bd:1930 with SMTP id
 5b1f17b1804b1-499dc6ef59dmr47369445e9.5.1787738344263; 
 Wed, 26 Aug 2026 02:59:04 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:135f:84f0:37f7:9223:8e7a:9b5f?
 ([2a0d:e487:135f:84f0:37f7:9223:8e7a:9b5f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5616f7sm13098775e9.2.2026.08.26.02.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 02:59:03 -0700 (PDT)
Message-ID: <7d654e24-de41-442d-a388-1767d93d9ae6@linaro.org>
Date: Wed, 26 Aug 2026 11:58:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/4] drm/panel: visionox-vtdr6130: Add panel orientation
 support
To: webgeek1234@gmail.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260814-rp6-panel-v1-0-111c1aeccf0f@gmail.com>
 <20260814-rp6-panel-v1-2-111c1aeccf0f@gmail.com>
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
In-Reply-To: <20260814-rp6-panel-v1-2-111c1aeccf0f@gmail.com>
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

On 8/14/26 20:17, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Fetch orientation from the device tree if provided.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> index 6733e0e1d0612..b66d6c7128c75 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> @@ -11,6 +11,7 @@
>   #include <drm/display/drm_dsc.h>
>   #include <drm/display/drm_dsc_helper.h>
>   #include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_of.h>
>   #include <drm/drm_modes.h>
>   #include <drm/drm_panel.h>
>   
> @@ -22,6 +23,7 @@ struct visionox_vtdr6130 {
>   	struct mipi_dsi_device *dsi;
>   	struct gpio_desc *reset_gpio;
>   	struct regulator_bulk_data *supplies;
> +	enum drm_panel_orientation orientation;
>   };
>   
>   static const struct regulator_bulk_data visionox_vtdr6130_supplies[] = {
> @@ -218,10 +220,18 @@ static int visionox_vtdr6130_get_modes(struct drm_panel *panel,
>   	return 1;
>   }
>   
> +static enum drm_panel_orientation visionox_vtdr6130_get_orientation(struct drm_panel *panel)
> +{
> +	struct visionox_vtdr6130 *ctx = to_visionox_vtdr6130(panel);
> +
> +	return ctx->orientation;
> +}
> +
>   static const struct drm_panel_funcs visionox_vtdr6130_panel_funcs = {
>   	.prepare = visionox_vtdr6130_prepare,
>   	.unprepare = visionox_vtdr6130_unprepare,
>   	.get_modes = visionox_vtdr6130_get_modes,
> +	.get_orientation = visionox_vtdr6130_get_orientation,
>   };
>   
>   static int visionox_vtdr6130_bl_update_status(struct backlight_device *bl)
> @@ -293,6 +303,12 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
>   			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
>   	ctx->panel.prepare_prev_first = true;
>   
> +	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get orientation %d\n", ret);
> +		return ret;
> +	}
> +
>   	ctx->panel.backlight = visionox_vtdr6130_create_backlight(dsi);
>   	if (IS_ERR(ctx->panel.backlight))
>   		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
