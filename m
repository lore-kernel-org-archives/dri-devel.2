Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77649107BCF2
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE35510E04D;
	Wed, 18 Mar 2026 10:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ixit.cz header.i=@ixit.cz header.b="0x56s/TS";
	dkim-atps=neutral
Received: from ixit.cz (ixit.cz [185.100.197.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EFDB10E444
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:30:54 +0000 (UTC)
Received: from [IPV6:2a02:f000:10bd:e301::1d7] (unknown
 [IPv6:2a02:f000:10bd:e301::1d7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id CDEDC5340EC6;
 Wed, 18 Mar 2026 11:30:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1773829846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ySmRO3DM2H1VVSWDueEkjq2xi5/f6QFsmik7iIaDqK8=;
 b=0x56s/TSoZIHJw89MWhfKvDWXFUMGpc+CbTswtJOxxE0U/ghB4zfzJd1iAXNfQ+dMI6zkx
 F2Hti2+pdHsC1bKSDO31Z0hoxhE5c40IwMEeFk92yrsIH4doMEQ2QdJpE1USaN+t2bqOcd
 E1AA1i2a7XgFotUvng5Vi09cdqFYfdI=
Message-ID: <7e31ff87-3350-4a6a-9517-e0ad02d36040@ixit.cz>
Date: Wed, 18 Mar 2026 11:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drm: panel: Add Samsung S6E8FC0 DSI controller for
 M1906F9 panel
To: Yedaya Katsman <yedaya.ka@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Kamil_Go=C5=82da?=
 <kamil.golda@protonmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20260317-panel-patches-v5-0-ef99f7b280da@gmail.com>
 <20260317-panel-patches-v5-2-ef99f7b280da@gmail.com>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260317-panel-patches-v5-2-ef99f7b280da@gmail.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 17/03/2026 19:50, Yedaya Katsman wrote:
> Add driver for Samsung S6E8FC0 DSI controller for M1906F9 video mode panel,
> found in Xiaomi Mi A3 mobile phone.
> 
> Co-developed-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> ---
> 
> The downstream dts claims a max brightness of 2047, but seems to ignore the
> MSB.
> ---

[...]
> +
> +static const struct regulator_bulk_data s6e8fc0_m1906f9_supplies[] = {
> +	{ .supply = "vdd" },
> +	{ .supply = "vci" },
> +};

these power supplies should be only DDIC related

> +
> +static inline
> +struct s6e8fc0_ctx *to_s6e8fc0_ctx(struct drm_panel *panel)
> +{
> +	return container_of_const(panel, struct s6e8fc0_ctx, panel);
> +}
> +
> +static void s6e8fc0_m1906f9_reset(struct s6e8fc0_ctx *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(12000, 13000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(2000, 3000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +}
> +
> +#define s6e8fc0_m1906f9_test_key_on_lvl2(ctx) \
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0x5a, 0x5a)
> +#define s6e8fc0_m1906f9_test_key_off_lvl2(ctx) \
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0xa5, 0xa5)
> +#define s6e8fc0_m1906f9_test_key_on_lvl3(ctx) \
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0x5a, 0x5a)
> +#define s6e8fc0_m1906f9_test_key_off_lvl3(ctx) \
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0xa5, 0xa5)
> +

macros are definitely DDIC only (not panel related, thus s6e8fc0 only)

> +static int s6e8fc0_m1906f9_on(struct s6e8fc0_ctx *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	s6e8fc0_m1906f9_test_key_on_lvl3(&dsi_ctx);
> +
> +	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x0000);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY,
> +				     0x20);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 50);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x04, 0xed);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xed,
> +				     0xe4, 0x08, 0x96, 0xa4, 0x2a, 0x72, 0xe2,
> +				     0xca, 0x00);
> +	s6e8fc0_m1906f9_test_key_off_lvl3(&dsi_ctx);
> +	s6e8fc0_m1906f9_test_key_on_lvl2(&dsi_ctx);
> +	s6e8fc0_m1906f9_test_key_on_lvl3(&dsi_ctx);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x93);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x05, 0xf4);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf4, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xed, 0x01, 0x81, 0x04);
> +	s6e8fc0_m1906f9_test_key_off_lvl2(&dsi_ctx);
> +	s6e8fc0_m1906f9_test_key_off_lvl3(&dsi_ctx);
> +
> +	return dsi_ctx.accum_err;
> +}
> +

[...]

> +
> +static const struct of_device_id samsung_s6e8fc0_m1906f9_of_match[] = {

this struct is only DDIC related, the content of it below is panel related

> +	{ .compatible = "samsung,s6e8fc0-m1906f9" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, samsung_s6e8fc0_m1906f9_of_match);
> +
> +static struct mipi_dsi_driver s6e8fc0_m1906f9_driver = {
> +	.probe = s6e8fc0_m1906f9_probe,
> +	.remove = s6e8fc0_remove,
> +	.driver = {
> +		.name = "panel-samsung-s6e8fc0-m1906f9",
> +		.of_match_table = samsung_s6e8fc0_m1906f9_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(s6e8fc0_m1906f9_driver);

mipi_dsi_driver is DDIC related, not panel.


Otherwise LGTM, with requested changes

Reviewed-by: David Heidelberg <david@ixit.cz>

Thank you!
David

> +
> +MODULE_AUTHOR("Kamil Gołda <kamil.golda@protonmail.com>");
> +MODULE_DESCRIPTION("DRM driver for Samsung s6e8fc0 DSI controller");
> +MODULE_LICENSE("GPL");
> 

-- 
David Heidelberg

