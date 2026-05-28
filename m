Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A485BCD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 11:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1DAB10F03B;
	Thu, 28 May 2026 11:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GzNr5b51";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0BA10F036
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 11:07:55 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so133945635e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 04:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779966474; x=1780571274; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=jdEan+OEa59Pk8W7jTB8S9kGLZiRAs4H/P8LLJyS2nI=;
 b=GzNr5b517h9VXL2Y+o4FgVljqT1tPmjJYcj9G0O4o9YrCkSRTapK5qmfm+rne52To0
 R4QLMC4b7tAtxlzq14FjsZuerz62zzv1noW3TdzV+V5rTbE5iuBhJs2j/ppuKeF2/aPQ
 X7U5za0cJ+wsXLs/wSh/GvsOaDIohCvHz94egi0g0eGxalDu4wrJRU5HzbJt+YMy4lyJ
 mM4ZLayYoQwuMhLCLGh/4VGiutDC8OT9iWiPk36DbuLEfAYK8FCsJFDI3XzBFFYNJH0g
 UHKaqmC8d/468yfrRDGua9Cs9tqCuG8udEqrgyhST1pm8ayN/tEdeCZyRuPRlP8m92CM
 9LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779966474; x=1780571274;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdEan+OEa59Pk8W7jTB8S9kGLZiRAs4H/P8LLJyS2nI=;
 b=hOFcTpsYkmz9ElIaH2/MvQbz/oucKGekYyqWj4pGiCPry0RXzLqiCOLWpKZJgv+e4d
 ggtbmv7EHT5NIYHH4AlleU68uI+qZ7Lq69sMsKyoYTP8/SUGZzRj1OTQBN/oIdAtpP3Q
 xU88i2ve/c29tH0h4P8SRiuZFNN3FBhjorRna5isWkuNgvZyR4yODSj5cdUVWBMUlOua
 eXXcThtWSgp+qZJBwDjqQYpO9CUJZ65OqxblLUD3qQzGJQ98RgDKUW29M1ALHxV/0DKp
 CYgUAKtleEuP5exiAs+Yrw6MjZXo1g9QE0EklFUjQl7D+hkzlcI1VOlT2I71eLwrsmjz
 o7ww==
X-Gm-Message-State: AOJu0YzJnC9ByGvBX+IDRlLZ9NEMi9keTy6cnYk6GPNhifYlZBq6ckag
 xZASb5AKTF8wBGsaffohZTIT4yKaKV54B5SeA+Mum2YBhGQqdl2t5Fc/cEoGuDmZKVs=
X-Gm-Gg: Acq92OGR0edOnYE+nj10GZdz3g7EUKz67KLKJqE2bZQgyu2gZkyDE3kNvTeQAQ4vUd/
 TtCjgCOi8+mUqWksXWjlrjdpm5Ww06qH8qhmEy4jYD5cb51xLnIPVkQCioYrfoCcPoRAivzJHB2
 Gdfc3MrxKMFyyViebzBU3uuOulg2aWZfh68iOeoCmn7sNlqgI6ACzq5fJfYoB98gT8qwuJnc1NR
 pXkmthwyqj9USM/g6xGG461gwRwiRNmc5iZGphMLjBtby4GTAUMw1tTr9hHZoD4JtwWKuShZ5eC
 jf/nJEbGK2xTVPyWbDkl6F+ARXrse87Gd+4oyrdRnVmwXxfMx2SuhyDX2pZUv0dFIKvz6357MmK
 f53NAyS2LQ42Q8HQMhvceVevPwa4u8Sdtmo7kPAMbnYb4wZpzakwYMFpxXlRk0NOBYVC/Us7fes
 +6sZgFID6eYMbI2JLFkrFIxL4OgxzxI0TgeENcmOk64So=
X-Received: by 2002:a05:600c:4ecc:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-490426cd8a4mr416004715e9.21.1779966473758; 
 Thu, 28 May 2026 04:07:53 -0700 (PDT)
Received: from [172.20.10.2] ([37.167.60.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49091d57c0dsm55223895e9.0.2026.05.28.04.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 04:07:53 -0700 (PDT)
Message-ID: <86a1e8e4-1e83-439d-840f-6687dfc87fe3@linaro.org>
Date: Thu, 28 May 2026 13:07:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 2/3] drm/bridge: display-connector: don't autoenable
 HPD IRQ
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
 <20260528-dp-connector-hpd-v3-2-d656eb1079b7@oss.qualcomm.com>
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
In-Reply-To: <20260528-dp-connector-hpd-v3-2-d656eb1079b7@oss.qualcomm.com>
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

On 5/28/26 09:10, Dmitry Baryshkov wrote:
> If HPD IRQ is enabled in the display_connector's probe, it can be
> triggered too early, before the DRM connector is completely setup. Use
> the enable_hpd / disable_hpd callbacks to control enablement of the HPD
> IRQ.
> 
> Fixes: 0c275c30176b ("drm/bridge: Add bridge driver for display connectors")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/bridge/display-connector.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
> index 16c0631adeb1..6bb1134f75c3 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -87,6 +87,20 @@ display_connector_bridge_detect(struct drm_bridge *bridge, struct drm_connector
>   	return display_connector_detect(bridge);
>   }
>   
> +static void display_connector_hpd_enable(struct drm_bridge *bridge)
> +{
> +	struct display_connector *conn = to_display_connector(bridge);
> +
> +	enable_irq(conn->hpd_irq);
> +}
> +
> +static void display_connector_hpd_disable(struct drm_bridge *bridge)
> +{
> +	struct display_connector *conn = to_display_connector(bridge);
> +
> +	disable_irq(conn->hpd_irq);
> +}
> +
>   static const struct drm_edid *display_connector_edid_read(struct drm_bridge *bridge,
>   							  struct drm_connector *connector)
>   {
> @@ -178,6 +192,8 @@ static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
>   static const struct drm_bridge_funcs display_connector_bridge_funcs = {
>   	.attach = display_connector_attach,
>   	.detect = display_connector_bridge_detect,
> +	.hpd_enable = display_connector_hpd_enable,
> +	.hpd_disable = display_connector_hpd_disable,
>   	.edid_read = display_connector_edid_read,
>   	.atomic_get_output_bus_fmts = display_connector_get_output_bus_fmts,
>   	.atomic_get_input_bus_fmts = display_connector_get_input_bus_fmts,
> @@ -307,6 +323,7 @@ static int display_connector_probe(struct platform_device *pdev)
>   						NULL, display_connector_hpd_irq,
>   						IRQF_TRIGGER_RISING |
>   						IRQF_TRIGGER_FALLING |
> +						IRQF_NO_AUTOEN |
>   						IRQF_ONESHOT,
>   						"HPD", conn);
>   		if (ret) {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
