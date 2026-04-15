Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C079FF419A0
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 12:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CFCF10E0C9;
	Wed, 15 Apr 2026 12:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LD0luwbU";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2F610E0C9
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 12:56:29 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so47411885e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776257788; x=1776862588; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TlZO0eraAxc9RdlGoUu/4T/udUp+sK68ZU76CN9CV3w=;
 b=LD0luwbUd4i5OtjSpKzji3LLdM20Qt+HuVDJYB/Xpk47slGR1d67sicU4khssEgOzb
 0Ags79pBJWe949oq73d+hf6ekT7+RVkSwqq/rYZ6fQBRaDS9aryIt5tYEYJt1gFRwk5C
 sIB+nswjt6fdQ5MvDBVdXwB68QWg0hMORkGBOeO/WElsShZJcNOVFnZqxPzuFPbm2BM5
 +Szf9r1hlW04zgn5PPFbPoxkBj/jZv5+dE+vrqQxl14R3eUD6ved1v5z1iYXOqDfS9cJ
 PNckGwQ/9fuHwU+TkBL7r/eBA+M1VEnod2O2pWAxVY0d+XAIMf2vAQAMK8DDf0BhNntl
 jEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776257788; x=1776862588;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TlZO0eraAxc9RdlGoUu/4T/udUp+sK68ZU76CN9CV3w=;
 b=mYwghwbRbnhpvJDjAhpJX0F1GQDms/SGXW5tOhs7/91R4jrVdgDOmDM04ItWAy7nkV
 nZYm4kAV6sBCax9sJtmCrcm+/nz4spLBC5YIE53gdxFLsPxQN9QiFzlU7K2fXpqdDJ4p
 hZOyeEx5F9q/ZYX4t+2FXltP8EudIDG2x9j1lEsZdE1LtVrpG/dpHHFIRrMnKQ0HnKgs
 amvht+LtRylt25PIXjlEXsVX/wU/0tWzyg0DDbxMwXDOv7SjX+mMzNALTRFUTnPwhguY
 LG6qQuc0gAIgJbggxPTKdFM6r6jyJjxznimS6nweSg/ra0ABKA3UjZpQeStrHppqZYXw
 ENaQ==
X-Gm-Message-State: AOJu0Yz/BBurhpZAyyhqfqmtIhtxBDpwNyT0RigK+qrlY19UxKpWJvzW
 vuXwFDkMlhYnTTVUVvPeohdel6ztxOA33V0zjSA6SKV9nueXnjx+CceZ3/uiXheetX0=
X-Gm-Gg: AeBDietdWyoBr3OHrmoAglDE5XnRRzumJ9gu54mrqmx+wcUXRYwWCpLyF/R5NF9IWtY
 DTTgjnFrtIeyG8zbTdB40uF3GhqLcD8nm4Re8cKx0u4WF6dnTLuyyF4z844O/QwGxNEELDb1Boe
 ll52Np8xQwT3cKzWXzmhM47r7NTFCZmofWah6/pSiGsW6LuimOZWxGe8DpUndVY1sSvftENISFe
 2IoFmxf1xaRaz//b7uXtodzBpsFjYzAi7i5j5BJ7rpQmB56gfhjT8nnRaalEpt7HikbehEl2nfg
 eTxD6OK3z1Oon5ZVJnLhcbPuisF3/P20XLjNHfy44t7iE7u9xvHbguklnv9xzyfOop4mB80Af8p
 6k0MCVqvWSWwGLjI4B4+ebuvYOleU5m4nljopxH9fqLW4Nyt8azsVkaaJCecw4t14FTiGnUucxD
 CFj6Cc1OD4wVANJZ4lgV40EsHy8z0lBVIMeKwhuErVjiBj/3izA2zkpxmvdQl5sGY6zLKWathEv
 jk6xEYRYAD7LT3W6A==
X-Received: by 2002:a05:600c:3b29:b0:486:fbf6:abd4 with SMTP id
 5b1f17b1804b1-488d67d24cbmr280170325e9.9.1776257787605; 
 Wed, 15 Apr 2026 05:56:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1c29:ca2f:5699:2fdf?
 ([2a01:e0a:106d:1080:1c29:ca2f:5699:2fdf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f1d5dd43sm49046795e9.0.2026.04.15.05.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 05:56:26 -0700 (PDT)
Message-ID: <661c12a0-d736-4a5e-8bd5-43f0b46da4d6@linaro.org>
Date: Wed, 15 Apr 2026 14:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 2/2] drm/bridge: waveshare-dsi: support DSI LCD kits
 with LVDS panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260412-ws-lcd-v3-0-db22c2631828@oss.qualcomm.com>
 <20260412-ws-lcd-v3-2-db22c2631828@oss.qualcomm.com>
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
In-Reply-To: <20260412-ws-lcd-v3-2-db22c2631828@oss.qualcomm.com>
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

On 4/12/26 19:32, Dmitry Baryshkov wrote:
> Several Waveshare DSI LCD kits use LVDS panels and the ICN6202 DSI2LVDS
> bridge. Support that setup by handling waveshare,dsi2lvds compatible.
> The only difference with the existing waveshare,dsi2dpi is the bridge's
> output type (LVDS vs DPI).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/bridge/waveshare-dsi.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/waveshare-dsi.c b/drivers/gpu/drm/bridge/waveshare-dsi.c
> index 32d40414adb9..ded57f298d64 100644
> --- a/drivers/gpu/drm/bridge/waveshare-dsi.c
> +++ b/drivers/gpu/drm/bridge/waveshare-dsi.c
> @@ -177,7 +177,7 @@ static int ws_bridge_probe(struct i2c_client *i2c)
>   	regmap_write(ws->reg_map, 0xc2, 0x01);
>   	regmap_write(ws->reg_map, 0xac, 0x01);
>   
> -	ws->bridge.type = DRM_MODE_CONNECTOR_DPI;
> +	ws->bridge.type = (uintptr_t)i2c_get_match_data(i2c);
>   	ws->bridge.of_node = dev->of_node;
>   	devm_drm_bridge_add(dev, &ws->bridge);
>   
> @@ -185,7 +185,8 @@ static int ws_bridge_probe(struct i2c_client *i2c)
>   }
>   
>   static const struct of_device_id ws_bridge_of_ids[] = {
> -	{.compatible = "waveshare,dsi2dpi",},
> +	{.compatible = "waveshare,dsi2dpi", .data = (void *)DRM_MODE_CONNECTOR_DPI, },
> +	{.compatible = "waveshare,dsi2lvds", .data = (void *)DRM_MODE_CONNECTOR_LVDS, },
>   	{ }
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
