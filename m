Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3C9F9D0CA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D1A10E5E8;
	Tue, 14 Apr 2026 12:59:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PulJIzX2";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CD810E5E8
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 12:59:34 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43cf5ad500fso4731832f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776171573; x=1776776373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=36NQBjdVOl8b2F78n+KMqXPnTDHbTcKHZXkBZWWZqFY=;
 b=PulJIzX2z4yJMISLVql6aL+JQT4h4xcw3we2scCNav9/7cEXQuEk0bk9G/GrOG/dV9
 GCVX/wEdHYqVX3UzgNZiIRf86NsJvAcZgP80OfrG1simkR9AeX+MttwawLJWuVOimt/C
 10Q8FfuyyNlBEPXLZHUaMTIgAdR95okT2dP6oJvXLwiegyZjNGIkeS1LnAqiSK90ZGbY
 mCjhDXfi/X3ALH0eFpALUbS45IAvSXbfFoKXzXzz/useOSUDcmZuiMkesFgoIXQo/ZX4
 bHsnRNaydizD8MoB8Js1fKdN3n1JRlT/eLiRDPk9Ihd8LePxgB48GjncBP+r7r4U4721
 QRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776171573; x=1776776373;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=36NQBjdVOl8b2F78n+KMqXPnTDHbTcKHZXkBZWWZqFY=;
 b=bpXD3s4L99FESmoQurFggxhDRtBbNgJj/y85qGXNnmBN2ysWY9ZWl6zKwzS27HcdRT
 X7IcRHuKA64B4rSZhcu3EHsWh2LOVMod7q0w4FFfhqNpqeM+yz74KJzZfgI8BOURMqEM
 7G9Sfj3XUl2EFAEQdRXpIwFyIwZzDgw4Uqf4PLmW9m3vH48UYbSgiKCH0NZPI2ybnYyb
 4lmoBSStNvK1R5H7sxsi3kwS6gXs5kVWIWx8CxU5xtkXE6zaVVKwDCXEnqepVgmQZlKB
 8KOc6BIGZ8opMk6Dkkfxugd5JphgcuDxoiXVYHInVfrfnrTyVmgTkOqRvztDs5t5cnNL
 1zrQ==
X-Gm-Message-State: AOJu0YyO1QEa7SH2hYaGG+70TePkKB0KqaXmbYLpMtVRyPF+ts1jCeZK
 WKu2Dwm+xOOw9T0l51OcJ1EKV9b8inxSnnGLDwUyj2FK84hyb+VFW+CSxfxQM4cMvuc=
X-Gm-Gg: AeBDieulU7JnQoOqqFQi2JXxgUxiIcsZcSJEKe8Ie7UD9Fvhxsuxpyt8hztoPB3SBRW
 kwccTjNWVa7OktoPnqxgLjsUEKiYgRRUQxl5QnRBFsXYlkWVBt/RVVLf8+8TenI9/DZ9BsxhEnU
 wG9+tvOhj5eFCZk2zwo901jndXRe4daxYWa8yFj5lDr98DWDA5pZUbgmKY9Gh1kRpV38ExVcv13
 gJOlLPzT9fVwz2M+ovCjoye7pGtrwdoTlOC5UQNNdeJvNkfnKgJH8JrgNXgxjkU9dvpp6VPUtZl
 Tt9GF2s7WJipjGDrSEkcHz7XICeN8F+wzvpt+Vd//FhnK4DbwIGs6EaYweZtuXH5Oso2IWE9UaU
 OBZJ74WXj4r5i8TePg6rxVGpAW+tJgx64AX8fsNL1SM0JKqih6TZWeiZbRWYgfpNE3OuzV2+h/C
 nAUZ2S3k9cyTYh2ZMX7dkX3pNhAfNCfri/eWgdfxDOTNW6riXSB4ZCjjfveYbyy+y7m7nHfSs/f
 SyzchLVTZ3AfZs=
X-Received: by 2002:a05:6000:615:b0:43d:1bf6:927 with SMTP id
 ffacd0b85a97d-43d64292737mr25826396f8f.14.1776171573040; 
 Tue, 14 Apr 2026 05:59:33 -0700 (PDT)
Received: from ?IPV6:2001:861:c12:13d0:5627:3bd0:f3ee:8a22?
 ([2001:861:c12:13d0:5627:3bd0:f3ee:8a22])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e50200sm41735888f8f.29.2026.04.14.05.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 05:59:32 -0700 (PDT)
Message-ID: <1b9323f4-f370-47a4-a45d-ecf781405cc1@linaro.org>
Date: Tue, 14 Apr 2026 14:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 16/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 720p DSI panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
 <20260413-waveshare-dsi-touch-v3-16-3aeb53022c32@oss.qualcomm.com>
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
In-Reply-To: <20260413-waveshare-dsi-touch-v3-16-3aeb53022c32@oss.qualcomm.com>
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

On 4/13/26 16:05, Dmitry Baryshkov wrote:
> Add configuration for Waveshare 9.0" and 10.1" 720p DSI panels using
> JD9365 controller.
> 
> Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 312 +++++++++++++++++++++++
>   1 file changed, 312 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 7744c66514c9..6fff3299f4ad 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -21,6 +21,8 @@
>   #include <linux/of.h>
>   #include <linux/regulator/consumer.h>
>   
> +#include <video/mipi_display.h>
> +
>   struct jadard;
>   
>   struct jadard_panel_desc {
> @@ -2283,6 +2285,49 @@ static const struct jadard_panel_desc waveshare_8_0_inch_a_desc = {
>   		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
>   };
>   
> +static int waveshare_10_1_b_init(struct jadard *jadard);
> +
> +static const struct jadard_panel_desc waveshare_9_0_inch_b_desc = {
> +	.mode_4ln = &(const struct drm_display_mode) {
> +		.clock		= (720 + 60 + 60 + 4) * (1280 + 16 + 12 + 4) * 60 / 1000,
> +
> +		.hdisplay	= 720,
> +		.hsync_start	= 720 + 60,
> +		.hsync_end	= 720 + 60 + 60,
> +		.htotal		= 720 + 60 + 60 + 4,
> +
> +		.vdisplay	= 1280,
> +		.vsync_start	= 1280 + 16,
> +		.vsync_end	= 1280 + 16 + 12,
> +		.vtotal		= 1280 + 16 + 12 + 4,
> +
> +		.width_mm	= 114,
> +		.height_mm	= 196,
> +		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +	},
> +	.mode_2ln = &(const struct drm_display_mode) {
> +		.clock		= (720 + 50 + 50 + 50) * (1280 + 26 + 12 + 4) * 60 / 1000,
> +
> +		.hdisplay	= 720,
> +		.hsync_start	= 720 + 50,
> +		.hsync_end	= 720 + 50 + 50,
> +		.htotal		= 720 + 50 + 50 + 50,
> +
> +		.vdisplay	= 1280,
> +		.vsync_start	= 1280 + 26,
> +		.vsync_end	= 1280 + 26 + 12,
> +		.vtotal		= 1280 + 26 + 12 + 4,
> +
> +		.width_mm	= 114,
> +		.height_mm	= 196,
> +		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +	},
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.init = waveshare_10_1_b_init,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +};
> +
>   static const struct drm_display_mode waveshare_10_1_a_mode = {
>   	.clock		= (800 + 40 + 20 + 20) * (1280 + 20 + 20 + 4) * 60 / 1000,
>   
> @@ -2627,6 +2672,265 @@ static const struct jadard_panel_desc waveshare_10_1_inch_a_desc = {
>   		MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
>   };
>   
> +static int waveshare_10_1_b_init(struct jadard *jadard)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x00);
> +	jadard_enable_standard_cmds(&dsi_ctx);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x3d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x3f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xbf);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xbf);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x74);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xa0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x7e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x24);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0xa9);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x38);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x1a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x65);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x52);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x3d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x2d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x2d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x3f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x2d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x34);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x27);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x24);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x18);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x65);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x52);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x3d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x2d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x2d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x3f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x2d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x34);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x27);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x24);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x18);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x00);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x51);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x55);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x51);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x4b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x4a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x51);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x55);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x51);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x4b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x4a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x15);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x15);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x66);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x55);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x66);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xe3);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0xd5);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x21);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x66);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xb3);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x60);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x58);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x0f);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x1d);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x00);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	msleep(120);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	msleep(5);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_TEAR_ON);
> +
> +	return 0;
> +}
> +
> +static const struct jadard_panel_desc waveshare_10_1_inch_b_desc = {
> +	.mode_4ln = &(const struct drm_display_mode) {
> +		.clock		= (720 + 60 + 60 + 4) * (1280 + 16 + 12 + 4) * 60 / 1000,
> +
> +		.hdisplay	= 720,
> +		.hsync_start	= 720 + 60,
> +		.hsync_end	= 720 + 60 + 60,
> +		.htotal		= 720 + 60 + 60 + 4,
> +
> +		.vdisplay	= 1280,
> +		.vsync_start	= 1280 + 16,
> +		.vsync_end	= 1280 + 16 + 12,
> +		.vtotal		= 1280 + 16 + 12 + 4,
> +
> +		.width_mm	= 125,
> +		.height_mm	= 222,
> +		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +	},
> +	.mode_2ln = &(const struct drm_display_mode) {
> +		.clock		= (720 + 50 + 50 + 50) * (1280 + 26 + 12 + 4) * 60 / 1000,
> +
> +		.hdisplay	= 720,
> +		.hsync_start	= 720 + 50,
> +		.hsync_end	= 720 + 50 + 50,
> +		.htotal		= 720 + 50 + 50 + 50,
> +
> +		.vdisplay	= 1280,
> +		.vsync_start	= 1280 + 26,
> +		.vsync_end	= 1280 + 26 + 12,
> +		.vtotal		= 1280 + 26 + 12 + 4,
> +
> +		.width_mm	= 125,
> +		.height_mm	= 222,
> +		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +	},
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.init = waveshare_10_1_b_init,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +};
> +
>   static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>   {
>   	struct device *dev = &dsi->dev;
> @@ -2762,10 +3066,18 @@ static const struct of_device_id jadard_of_match[] = {
>   		.compatible = "waveshare,8.0-dsi-touch-a",
>   		.data = &waveshare_8_0_inch_a_desc
>   	},
> +	{
> +		.compatible = "waveshare,9.0-dsi-touch-b",
> +		.data = &waveshare_9_0_inch_b_desc
> +	},
>   	{
>   		.compatible = "waveshare,10.1-dsi-touch-a",
>   		.data = &waveshare_10_1_inch_a_desc
>   	},
> +	{
> +		.compatible = "waveshare,10.1-dsi-touch-b",
> +		.data = &waveshare_10_1_inch_b_desc
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, jadard_of_match);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
