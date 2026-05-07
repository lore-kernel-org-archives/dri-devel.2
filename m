Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885BCCD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 07:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5D610E1B5;
	Thu,  7 May 2026 07:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WSLAL7MM";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8054610E1B5
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 07:11:51 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-44b330c5cc6so357728f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 00:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778137910; x=1778742710; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=bGYzjuf3R/p5pJNr3Enknt/6f+NCeQFDRQlWU1+0ACg=;
 b=WSLAL7MMl6k3DYG1IExdMK6mfbrzNXr9lAgGj3uDVvhFUSbNY1TED4rcEPWEH2HI2y
 zfr5Hmm4DrTxeJpidhNROzDZk+XLUiBFbEXPUO2XOoOlR5AyWl/3e1owPQs6IfS41RAb
 Rw1QWFcBlzzR+XQm6QAKJJ4r2qAgJj0+5Dhy0w73RYuCK20eREgX7N+MEQsbU7S7CZ0W
 bSwlFIoV5h/0iAgq6cdVLzAYEq+kkUEw87kjugNasYbfXu0mA9wrTzgphyqPmHdnYlzG
 +8TVWs/6JRUCQc085ACU3vhG/9lxRFLPwG7Nz7Y9FhwsPagcF+xeVGGJMzSdxqdpKyoH
 FJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778137910; x=1778742710;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGYzjuf3R/p5pJNr3Enknt/6f+NCeQFDRQlWU1+0ACg=;
 b=dt6+vWQJP4kO1HQMqzzg3wB7oaN9/M9G8UnCEv65yYToDrEUiDiJKhOwiAlZy5QTxc
 dfI5Z6Ep/UgRlJWEilQZMq7xNozUTamb2ReP5F7lCEinWnLhchsk0UeaqHT1xDuVVKrY
 vJCZn/HSeWZ7mAormdPR0CdaNq5+pvZ+L+snw60ItnMS5w50We4mpAuADZsHIVdeJvOw
 +80x+nhAWAyOlvd2X/7PKj4BXsewoc/ajFE6eB1sdPOPoMUM5/whXNzCcWfiJXJKGxZa
 ZR1TGQV8idNW/ycQQ/RcU8iJTpZpItXI2OIBk8YbEYoQ1tGpSHMRTURqRVJg7VuclcR0
 kHjw==
X-Gm-Message-State: AOJu0YxbWDBR3JyZmP8uH//pbtDm5tzuidLFx+zJSOxSRMSlQkzE4w5k
 5AejiWTrv7jiU7bNSPl7vCm5aLNsmVGLdfngnoKdQCPmqV3ufv/P5c4n+Q8vbITmOqE=
X-Gm-Gg: AeBDiev2sPAVTD5+b7CpgFjBjTvZtHACGP3vbEmfeuNgNz+0B6A4O9U4pbatvonvEPi
 nw1Rn+43mZxgFFKtRem3wgHk9ByF/9qUBk+KrGkzge0SFwb4+Cw7yiP6JQL8+ALOP9GeWytOzBn
 cEKtTo6nPxzz8vkHXYxuJIkhzB+hKyAYCqjYHauwB3kj59xk6naDQjr0yNSBdPGcNmwcShmQY6w
 G414YoyUrzlhik2MfDnK5RPl4oKeucuD4Iijlabor6G0cf6KuIwJzWrnODJjjLBiBKkxQoxR/rc
 6cNUs3M/o9WLJ4PBHRLkWeysTYXR55yLmgbSEDRMeGJ11dtSXlKdsas3yZgdB3W3hChllUA7Sn9
 /ASmy8S1Uh4/YxQYhjrCBOXKYfbSYwRCLp8TZ4lU3cyc9RZwYaBMDsrpWxqTeqAdRj8skBEg2g8
 S8cDbrbUE0r5TVN8OWW14Ngq+ytlVqfd9DefmgbYNc/0OlXbxhY/mgw/CIxuYUlhWkLzJg4zf6R
 h634kEjq9nt0qh9/A==
X-Received: by 2002:a5d:5d87:0:b0:43d:d037:d59c with SMTP id
 ffacd0b85a97d-4515b524224mr10977840f8f.16.1778137909805; 
 Thu, 07 May 2026 00:11:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5798:67fd:c866:b378?
 ([2a01:e0a:106d:1080:5798:67fd:c866:b378])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-450524834eesm17521496f8f.4.2026.05.07.00.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 00:11:49 -0700 (PDT)
Message-ID: <d3f99285-1811-45f7-91be-5017438c2475@linaro.org>
Date: Thu, 7 May 2026 09:11:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] drm/panel: visionox-rm69299: Split DSI commands out
 into enable/disable
To: =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20260427-visionox-rm69299-enable-v1-0-fa7d62d26d87@sigxcpu.org>
 <20260427-visionox-rm69299-enable-v1-1-fa7d62d26d87@sigxcpu.org>
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
In-Reply-To: <20260427-visionox-rm69299-enable-v1-1-fa7d62d26d87@sigxcpu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/27/26 15:56, Guido Günther wrote:
> It's when DSI commands should be sent and it also fixes these DSI errors
> on every screen blank/unblank on the SHIFT6mq:
> 
> dmesg:
>    msm_dsi ae94000.dsi: [drm:dsi_cmds2buf_tx] *ERROR* wait for video done timed out
>    dsi_cmds2buf_tx: cmd dma tx failed, type=0x5, data0=0x28, len=4, ret=-110
>    panel-visionox-rm69299 ae94000.dsi.0: sending DCS SET_DISPLAY_OFF failed: -110

This error is un unprepare, the link should be in LP11 so the command should still work,
but you can move them to disable(), but in the other way you should still keep the
power on commands in prepare() since the link is in LP11 and video is not flowing.

Neil

> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>   drivers/gpu/drm/panel/panel-visionox-rm69299.c | 77 +++++++++++++++-----------
>   1 file changed, 44 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> index f1430370ff94..3c92a6ceb8df 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> @@ -158,6 +158,46 @@ static inline struct visionox_rm69299 *panel_to_ctx(struct drm_panel *panel)
>   	return container_of(panel, struct visionox_rm69299, panel);
>   }
>   
> +static int visionox_rm69299_enable(struct drm_panel *panel)
> +{
> +	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	for (int i = 0; i < ctx->desc->init_seq_len; i++)
> +		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, &ctx->desc->init_seq[i * 2], 2);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +
> +	/* Per DSI spec wait 120ms after sending exit sleep DCS command */
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
> +	/* Per DSI spec wait 120ms after sending set_display_on DCS command */
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int visionox_rm69299_disable(struct drm_panel *panel)
> +{
> +	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +
> +	/* 120ms delay required here as per DCS spec */
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
>   static int visionox_rm69299_power_on(struct visionox_rm69299 *ctx)
>   {
>   	int ret;
> @@ -193,16 +233,6 @@ static int visionox_rm69299_power_off(struct visionox_rm69299 *ctx)
>   static int visionox_rm69299_unprepare(struct drm_panel *panel)
>   {
>   	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
> -	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> -
> -	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> -
> -	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> -
> -	/* 120ms delay required here as per DCS spec */
> -	mipi_dsi_msleep(&dsi_ctx, 120);
> -
> -	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>   
>   	return visionox_rm69299_power_off(ctx);
>   }
> @@ -210,29 +240,8 @@ static int visionox_rm69299_unprepare(struct drm_panel *panel)
>   static int visionox_rm69299_prepare(struct drm_panel *panel)
>   {
>   	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
> -	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> -	int ret, i;
>   
> -	ret = visionox_rm69299_power_on(ctx);
> -	if (ret < 0)
> -		return ret;
> -
> -	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> -
> -	for (i = 0; i < ctx->desc->init_seq_len; i++)
> -		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, &ctx->desc->init_seq[i * 2], 2);
> -
> -	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> -
> -	/* Per DSI spec wait 120ms after sending exit sleep DCS command */
> -	mipi_dsi_msleep(&dsi_ctx, 120);
> -
> -	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> -
> -	/* Per DSI spec wait 120ms after sending set_display_on DCS command */
> -	mipi_dsi_msleep(&dsi_ctx, 120);
> -
> -	return dsi_ctx.accum_err;
> +	return visionox_rm69299_power_on(ctx);
>   }
>   
>   static const struct drm_display_mode visionox_rm69299_1080x2248_60hz = {
> @@ -284,7 +293,9 @@ static int visionox_rm69299_get_modes(struct drm_panel *panel,
>   
>   static const struct drm_panel_funcs visionox_rm69299_drm_funcs = {
>   	.unprepare = visionox_rm69299_unprepare,
> -	.prepare = visionox_rm69299_prepare,
> +	.disable   = visionox_rm69299_disable,
> +	.prepare   = visionox_rm69299_prepare,
> +	.enable	   = visionox_rm69299_enable,
>   	.get_modes = visionox_rm69299_get_modes,
>   };
>   
> 

