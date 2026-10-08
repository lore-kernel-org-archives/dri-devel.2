Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B5FCA600A
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 08:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB1A10E403;
	Thu,  8 Oct 2026 08:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JBy0nD7m";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F5B10E403
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 08:24:39 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso45640925e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791447878; x=1792052678; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M6ASayUKoMdn/Pu+VkK60Fyzl8gQVjykNVGO1atxmUU=;
 b=JBy0nD7mIsBG03BIRWKBnccB9gDtpWOzJ8h4HiO+CYKUxRV1Uu9BAlHeWU2owo4YVv
 L1HUjn8luIBWQb91NvcQ5WgOGtP71zdA7pFEkkhaFB8EkkpcHPVY4VxTksoWUQXikNPg
 q1OltuwMUWm1eEs6sMdwO1ZX5y3GzpfBtzFP/MxfMBi3HCqbIMcBqEFb1afxxD94NEBY
 RvR2AmskPwosUkUAmFYKKrGPKEE3FxgVJRxKDduC9bDe2YZLWxa0V2zznj0wbO+XDnhg
 Xyc8i1mSZVE9LNEsDswwbsozNpHnWnGmQtPhLjk27FxQwTcEGhTZEDyQknHHhUDkuSCk
 A0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791447878; x=1792052678;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M6ASayUKoMdn/Pu+VkK60Fyzl8gQVjykNVGO1atxmUU=;
 b=TjIsU5/P/a3d4bHmoTJfDV/D9Si4TTV4MmoHvu1F/uWdnoTNtWL2zKHPaM0W2cRLpa
 +vrOuE/1o21d+R5LdfHQeoJI4pYl1SlAXCrz9LuXUzfOoOUTMgJmgw0Bw/PSHEjyPyRV
 qbNARUhzWcvUdXuPZpzPgyEoM0G+tAaKkfkG6z0kewtMiGYKW/PbSItCS4o+LueWiWLg
 RLSg/F9+Ls2kvc3Qt/bADKJ3VzcUgxBmj0r3G2WvoHvT2EWqieKv79GVTcLcUy4HqhYV
 PdzeTBx3kD7T7HKccpvwNkZ8ajtV80Nmr0C64YRSplSJ5rKIjK46r4Lc+uu8Y6oFILJS
 0wCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGk6oqZwH4vDc4Ir1/w+lxUUDFlThnJZF2FjFXCfpHoaxQCN421ekl7+iKPNZZd0gwwXu5Ni9fyIY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++njezZuoo2vgnMAT/4d1rVpRkJAuSTowgOV5f0WYxrZoUMUQdx5
 r76TDZMTaxC1gVQ46OuL6cDQorEwbbflq2H3xFOglKH6q9bXQ2g339iZAK02smNhdLY=
X-Gm-Gg: AYBFou3Q8HqZfVNv6RT2uy2nHDkOo/4lz12M5dem2sCN9DKAVhmkcaPF4NSI4xG5Uo8
 fi4ic8RTf/SVACrKe7TQT7lW/zIxtt6Wv1qXmWI/WYY3AU+QpS3gv2Tv21UL9j0LDrvBgscqH95
 VmjT7jMBroPXj4bVY3ILOLke5gP5mU56SgsKzBc1uiSxVLvfVgPcJAXM7BXyJ8Uxvlqb7cSdpge
 uV8eMB+Ryi9msdkkPtCdlW9Mi7WODU4AVC3d8hK806vtRzNzWYwn8mjXu7A7Lrp9sJyyTyjmul7
 K/8WUj4oW6ojDNlnz5qL7VbPzHJIrUbUrEYH9LTF+7i6mmkfq1AebHjnwKeWu8b6p4HSPUncSMG
 k+gR3ycTBBlPlto3e9hYhxww5s8zQt5bzBYGJwU64lhjNgHFJTy9Qz4+SroGlKibpe4Al+1as34
 mIvDecz4OYDTXfZUuS4Sxi93IR9JPBjZsU7nwRiGcBXacb+SXNdColxMYWYGbyFJs5eYIF0zA4v
 2/pBH9a0TAFGaaekUwFRTiwaXd1lKk=
X-Received: by 2002:a05:600c:810c:b0:4a1:7163:3e41 with SMTP id
 5b1f17b1804b1-4a1804234ffmr77254905e9.9.1791447878231; 
 Thu, 08 Oct 2026 01:24:38 -0700 (PDT)
Received: from [192.168.151.76] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843d1e0bsm51322805e9.6.2026.10.08.01.24.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 01:24:37 -0700 (PDT)
Message-ID: <fa64131e-52a3-4058-9655-e1a4c36de47d@linaro.org>
Date: Thu, 8 Oct 2026 10:24:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/4] drm/panel: st7703: move init commands to prepare()
To: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, =?UTF-8?Q?Guido_G=C3=BCnther?=
 <agx@sigxcpu.org>
Cc: Ondrej Jirman <megi@xff.cz>, Purism Kernel Team <kernel@puri.sm>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
References: <20261007201859.3709656-1-marc-olivier.champagne@savoirfairelinux.com>
 <20261007201859.3709656-3-marc-olivier.champagne@savoirfairelinux.com>
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
In-Reply-To: <20261007201859.3709656-3-marc-olivier.champagne@savoirfairelinux.com>
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

On 10/7/26 22:18, Marc-Olivier Champagne wrote:
> The panel init sequence is currently sent from enable(), i.e. after
> the DSI host has started the video stream. Not all DSI hosts accept
> command packets in that state, so the init sequence may never reach
> the panel.
> 
> Move the init sequence to prepare(), right after the panel reset, to
> ensure it is sent before the host enables the video stream.
> 
> Since the init sequence can now fail in prepare(), power the panel
> back down on error: the panel core does not call unprepare() when
> prepare() fails, leaving the power supplies enabled.
> 
> Both patterns are already used by other DSI panel drivers.
> 
> Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7703.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> index 368c57591817..f4635a7327de 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -774,8 +774,6 @@ static int st7703_enable(struct drm_panel *panel)
>   	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>   	struct mipi_dsi_multi_context dsi_ctx = {.dsi = dsi};
>   
> -	ctx->desc->init_sequence(&dsi_ctx);
> -
>   	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>   
>   	/* It takes the controller 120 msec to wake up after sleep. */
> @@ -784,7 +782,7 @@ static int st7703_enable(struct drm_panel *panel)
>   	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>   
>   	if (!dsi_ctx.accum_err)
> -		dev_dbg(ctx->dev, "Panel init sequence done\n");
> +		dev_dbg(ctx->dev, "Panel enable done\n");
>   
>   	return dsi_ctx.accum_err;
>   }
> @@ -819,6 +817,8 @@ static int st7703_unprepare(struct drm_panel *panel)
>   static int st7703_prepare(struct drm_panel *panel)
>   {
>   	struct st7703 *ctx = panel_to_st7703(panel);
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +	struct mipi_dsi_multi_context dsi_ctx = {.dsi = dsi};
>   	int ret;
>   
>   	dev_dbg(ctx->dev, "Resetting the panel\n");
> @@ -843,6 +843,18 @@ static int st7703_prepare(struct drm_panel *panel)
>   	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>   	usleep_range(15000, 20000);
>   
> +	ctx->desc->init_sequence(&dsi_ctx);
> +
> +	if (dsi_ctx.accum_err) {
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		regulator_disable(ctx->iovcc);
> +		regulator_disable(ctx->vcc);
> +
> +		return dsi_ctx.accum_err;
> +	}
> +
> +	dev_dbg(ctx->dev, "Panel init sequence done\n");
> +
>   	return 0;
>   }
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
