Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E07BC98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C362010F57D;
	Thu, 24 Sep 2026 13:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LUtgMUNL";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFE010F57D
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:36:02 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so11812615e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790256961; x=1790861761; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U22T5ktXeO8XQfbmyXBSjvK2W4d1tae1YGReIurscXk=;
 b=LUtgMUNLiosLTfN/eprb0a47L63CLJ5/ycxqjc2FgzfuilNUkFUhySiFbwoKt9ybey
 yONPuM81aBHu9ChmN9WwgGdKmdsqS17dXbo9oBb+Rg1SdgEg1paId83P52b0Bux0mqNs
 Qg26lrH+xqtSh8q8jsQpe7blzHHkDPqHAIIZAEb2cerrSZCm6yS2gK4th77V854Dbwd5
 2vFn/EtgNgYq+F3cObxdxjK1ZlyynPY9QV+U73iu5j7QYnGe4DlacNLQ51+chuPMiiUK
 U1McRDRHoDa0jg9uf3uyjXB9VeuFINnt7pEDthHpff26obsWBw4ZUzqBkKjAWXWUlaui
 gm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256961; x=1790861761;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U22T5ktXeO8XQfbmyXBSjvK2W4d1tae1YGReIurscXk=;
 b=zhJtBsVuDmRy1iit0Hoxddz4nLIn+MEaAd9H3YagzwUv0i8RZGgzZSbD66K4tfpCsV
 J7DmZxnoaQDjl6BLfWgBf29zl55xMbMxoCG00gIhb424rj1gRJWFWJYQ6NMlB3AetH3l
 /yZasXKiPeBWIl/BO0M8Lr+/MJy3K10WbJmDaxCig7yDBPjFeAFd3jvIFp+EvdxCnbBx
 3IvbwmnEh9dp1uleF5KQj6uLiSW9aL0LyftTB5XIg9ptZZNW9jGMZqiIdoem2wkxVYvD
 SK/EE5wHozxMz1knskm24vHjCuschdoKo2UHuwgQSxA0pg+Nj74TmD2NSvjVxMvRO/gT
 nyfg==
X-Forwarded-Encrypted: i=1;
 AKwUvByp8tc5bTgK0rO7mpl1Ygrg1zLwNbQacHgIEfpBivGpyLoDgfPKq7c7qKFqmAzF70rDUa2dHCu1hyA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mTYdm5SlYv1rNkeYiQ+q5WzNhpxAge4xxYCnF4oE7bomk/RyjX
 Hqy+QXsIIECiPqQYCy+XW30s17TXBRwhUpkVVI9CI5wAL0CRV4Uoy4fCK20u4mFWIOI=
X-Gm-Gg: AYBFou0RmErEKR2ICn7OaPct4qBtFy0AamZPIMmUcs4lJlajOYJWcHgpcF3oGmIzjU2
 NDSPhZKj1DXPKkRvpQDlg2n8OpeYmQQI87/BZu76NQ8afaEciWZ2+c3JPHtQBpFLClw4k1/BJtu
 kK+ZMw44XIqZDWunJc+ZdHqoTSlE1Yu8DeGYpdpZZhmnEWD3VTbFW/Nv3W9MJsDqedZt0bhAwyc
 OyB3QihX9HldbK1xrbVr00eRi2Y6BePQJ+65i8LX9ejV52W/laAmz/1Dch/SgGcPkYz1eA9glBC
 3bzp1ug8LuwxgQk3ldLQIqEwjj9DpmzCEWqq7j5n5cAWNL80Nrxb/kOJ1QDdICOqxwno3iWijo0
 M228gSJuoNA3EExz7ap2LV4YQ6GZGQ0ASYyatmpeJfJI0TVjEbBs3nl66ehud9YZkNKwJg28zhi
 qbGngteYb8CH7G5Orh7ZiI04eiqYPN2Z6lqK0LFXtN0rngE01RmX18y/N2ay0X7AemshnnDE///
 t3HaUzvAwM0pNvfA8ux8410K4bi9fgj7P+TIKVQvOq0ljSiCka9Vg==
X-Received: by 2002:a05:600c:1385:b0:49f:ce78:3567 with SMTP id
 5b1f17b1804b1-49fe66fa5c2mr40253725e9.24.1790256960649; 
 Thu, 24 Sep 2026 06:36:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877a2d5sm14384759f8f.27.2026.09.24.06.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:36:00 -0700 (PDT)
Message-ID: <3c92a2ea-c588-4bc6-8d6a-8006f595e9cf@linaro.org>
Date: Thu, 24 Sep 2026 15:35:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 6/9] drm/panel: novatek-nt36672a: Add 3 panels used in
 Xiaomi phones
To: Alexey Minnekhanov <alexeymin@minlexx.ru>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>,
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 phone-devel@vger.kernel.org, Richard Acayan <mailingradian@gmail.com>
References: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
 <20260917-nt36672a-panels-v2-6-f8de8be5b86f@minlexx.ru>
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
In-Reply-To: <20260917-nt36672a-panels-v2-6-f8de8be5b86f@minlexx.ru>
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

On 9/17/26 18:43, Alexey Minnekhanov wrote:
> Add support for 3 panels used in 2 Xiaomi smartphones, all based on
> Qualcomm SDM636/660 SoC:
> 
> * Shenchao panel used in Xiaomi Redmi Note 7 (xiaomi-lavender), the
>    exact model string is unknown
> * Tianma TL063FVMC43-02  for Xiaomi Redmi Note 6 Pro (xiaomi-tulip)
> * Tianma TL063FVMCA01-00 for Xiaomi Redmi Note 7 (xiaomi-lavender)
> 
> They all are DSI video mode panels using Novatek NT36672A controller,
> so they can share almost exactly the same init/off sequences with
> minimal differences between variants. This allows to avoid a lot of
> code duplication.
> 
> Co-developed-by: Richard Acayan <mailingradian@gmail.com>
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> 
> ---
> v2: sort compatible strings alphabetically in of_device_id
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 166 +++++++++++++++++++++++++
>   1 file changed, 166 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> index a445c8067aa5f..d356348d39608 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> @@ -357,6 +357,90 @@ static void tianma_fhd_video_send_deinit_cmds(struct mipi_dsi_multi_context *dsi
>   	msleep(60); /* 0x3C = 60ms delay */
>   }
>   
> +static void lavender_tulip_init_cmds(struct mipi_dsi_multi_context *dsi_ctx)
> +{
> +	/*
> +	 * This function supports 3 similar panels with minimal differences
> +	 * in their init sequences. We assume base to be lavender-tianma
> +	 * panel, and 2 variations (lavender-shenchao and tulip) are handled as
> +	 * differences to base.
> +	 */
> +	const struct device_node *node = dev_of_node(&dsi_ctx->dsi->dev);
> +	bool is_shenchao = of_device_is_compatible(node, "shenchao,fhdplus-video");
> +	bool is_tulip = of_device_is_compatible(node, "tianma,tl063fvmc43-02");
> +
> +	dsi_ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x18, 0x96);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x04);
> +
> +	if (is_shenchao)
> +		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x27);
> +	else
> +		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x20);
> +
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +
> +	if (is_shenchao)
> +		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd9, 0x10);
> +	else
> +		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x78, 0x01);
> +
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x24);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x82, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x84, 0x31);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x88, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x8a, 0x31);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x8e, 0xe4);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x8f, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x90, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x26);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xa9, 0x12);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xaa, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xae, 0x8a);
> +
> +	if (is_shenchao)
> +		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1c, 0xfa);
> +
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x10);
> +
> +	if (is_shenchao)
> +		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x01);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 80);
> +
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x01);
> +	mipi_dsi_dcs_set_tear_on_multi(dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +
> +	if (is_tulip) {
> +		mipi_dsi_dcs_set_display_brightness_multi(dsi_ctx, 0x00ff);
> +	} else {
> +		/* lavender tianma + shenchao specific part */
> +		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x68, 0x03, 0x04);
> +		mipi_dsi_dcs_set_display_brightness_multi(dsi_ctx, 0x00b8);
> +	}
> +
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x2c);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
> +
> +	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
> +}
> +
> +static void lavender_tulip_deinit_cmds(struct mipi_dsi_multi_context *dsi_ctx)
> +{
> +	dsi_ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_set_display_off_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 20);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 120);
> +}
> +
>   static const struct drm_display_mode tianma_fhd_video_panel_default_mode = {
>   	.clock		= 161331,
>   
> @@ -389,6 +473,85 @@ static const struct nt36672a_panel_desc tianma_fhd_video_panel_desc = {
>   	.send_deinit_cmds = tianma_fhd_video_send_deinit_cmds,
>   };
>   
> +/* common for both lavender-tianma and lavender-shenchao panels */
> +static const struct drm_display_mode lavender_panel_default_mode = {
> +	.clock		= (1080 + 90 + 2 + 120) * (2340 + 10 + 3 + 8) * 60 / 1000,
> +
> +	.hdisplay	= 1080,
> +	.hsync_start	= 1080 + 90,
> +	.hsync_end	= 1080 + 90 + 2,
> +	.htotal		= 1080 + 90 + 2 + 120,
> +
> +	.vdisplay	= 2340,
> +	.vsync_start	= 2340 + 10,
> +	.vsync_end	= 2340 + 10 + 3,
> +	.vtotal		= 2340 + 10 + 3 + 8,
> +
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct nt36672a_panel_desc shenchao_lavender_panel_desc = {
> +	.display_mode = &lavender_panel_default_mode,
> +
> +	.width_mm = 67,
> +	.height_mm = 145,
> +
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.lanes = 4,
> +	.send_init_cmds = lavender_tulip_init_cmds,
> +	.send_deinit_cmds = lavender_tulip_deinit_cmds,
> +};
> +
> +static const struct nt36672a_panel_desc tianma_lavender_panel_desc = {
> +	.display_mode = &lavender_panel_default_mode,
> +
> +	.width_mm = 67,
> +	.height_mm = 145,
> +
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.lanes = 4,
> +	.send_init_cmds = lavender_tulip_init_cmds,
> +	.send_deinit_cmds = lavender_tulip_deinit_cmds,
> +};
> +
> +static const struct drm_display_mode tianmaplus_e7t_tulip_mode = {
> +	.clock		= (1080 + 100 + 28 + 120) * (2280 + 10 + 3 + 8) * 60 / 1000,
> +
> +	.hdisplay	= 1080,
> +	.hsync_start	= 1080 + 100,
> +	.hsync_end	= 1080 + 100 + 28,
> +	.htotal		= 1080 + 100 + 28 + 120,
> +
> +	.vdisplay	= 2280,
> +	.vsync_start	= 2280 + 10,
> +	.vsync_end	= 2280 + 10 + 3,
> +	.vtotal		= 2280 + 10 + 3 + 8,
> +
> +	.width_mm = 68,
> +	.height_mm = 143,
> +
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct nt36672a_panel_desc tianmaplus_e7t_tulip_panel_desc = {
> +	.display_mode = &tianmaplus_e7t_tulip_mode,
> +
> +	.width_mm = 68,
> +	.height_mm = 143,
> +
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.lanes = 4,
> +	/* tulip panel uses almost the same init/deinit sequences as lavender */
> +	.send_init_cmds = lavender_tulip_init_cmds,
> +	.send_deinit_cmds = lavender_tulip_deinit_cmds,
> +};
> +
>   static int nt36672a_panel_add(struct nt36672a_panel *pinfo)
>   {
>   	struct device *dev = &pinfo->link->dev;
> @@ -465,7 +628,10 @@ static void nt36672a_panel_remove(struct mipi_dsi_device *dsi)
>   }
>   
>   static const struct of_device_id panel_nt36672a_match[] = {
> +	{ .compatible = "shenchao,fhdplus-video", .data = &shenchao_lavender_panel_desc },
>   	{ .compatible = "tianma,fhd-video", .data = &tianma_fhd_video_panel_desc },
> +	{ .compatible = "tianma,tl063fvmc43-02", .data = &tianmaplus_e7t_tulip_panel_desc },
> +	{ .compatible = "tianma,tl063fvmca01-00", .data = &tianma_lavender_panel_desc },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, panel_nt36672a_match);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
