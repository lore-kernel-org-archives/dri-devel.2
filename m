Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD6DC61DBE
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 08:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97CF310E0C8;
	Sat, 29 Aug 2026 08:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="blZ+aBCW";
	dkim-atps=neutral
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr
 [80.12.242.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2853610E0C8
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 08:18:25 +0000 (UTC)
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
 by smtp.orange.fr with ESMTPSA
 id 0EGXxPPfLrYCi0EGYxAOOR; Sat, 29 Aug 2026 10:18:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1787991502;
 bh=pm5AuBFWT26WTMK2I/IakRM9AAO1FZ716ZvF/Hn53X8=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=blZ+aBCW52xwmWZZN0sd8OiWTM8AgT2+vz9V9i5Uqm9PH73FnyN+0nIB0ifCTgNMm
 vbj8QyeoGYc+223nzvuFgYh3nR0QQMhzqicWMM1Y7Letb474A4T7W/BUjhsytMrkOb
 5gqdLHQzmK8UvRy54wryQzU8IBtbyBxka43UBRHjjTy8e6UyAAqomHAQ/rGzYPecDM
 f8i4lf1iaJWwAigsw3AA4tuCCZU1giSr3LeXlFZRMPzgkyTuOfCkhu3SAcXj7nMXxN
 WcMIndguCjwNpZcVsaJb0GmUYa2w/VvRf4Oy+Fg/7FIQi2xRlNkq5xXk3ehTZVAC6Q
 w6G3DXnuYCYcQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 29 Aug 2026 10:18:22 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
Message-ID: <968d5cd7-60e0-450e-b096-6058d76863d8@wanadoo.fr>
Date: Sat, 29 Aug 2026 10:18:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/ch1115: add support for Chipwealth CH1115 OLED
 controller
To: =?UTF-8?Q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>, Shuah Khan <skhan@linuxfoundation.org>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <cover.1787973729.git.nico.antinori.7@gmail.com>
 <cb767f9b1db18f981c363222f96a46061e77e4c7.1787973729.git.nico.antinori.7@gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <cb767f9b1db18f981c363222f96a46061e77e4c7.1787973729.git.nico.antinori.7@gmail.com>
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

Le 29/08/2026 à 08:32, Nicolás Antinori a écrit :
> Chipwealth CH1115 is a controller for monochrome dot matrix OLED panels.
> 
> Add DRM support for this chip using i2c bus.
> 
> Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>

Hi,

a few nitpick below, should it help.

...

> +static int ch1115_connector_init(struct ch1115_device *ch1115)
> +{
> +	struct drm_connector *connector = &ch1115->connector;
> +	struct drm_encoder *encoder = &ch1115->encoder;
> +	struct drm_device *dev = &ch1115->dev;
> +	int ret;
> +
> +	ret = drm_connector_init(dev, connector, &ch1115_connector_funcs,
> +				 DRM_MODE_CONNECTOR_Unknown);
> +

Unneeded empty ilne.

> +	if (ret)
> +		return ret;
> +
> +	drm_connector_helper_add(connector, &ch1115_connector_helper_funcs);
> +
> +	return drm_connector_attach_encoder(connector, encoder);
> +}

...

> +static int ch1115_probe(struct i2c_client *client)
> +{
> +	struct ch1115_device *ch1115;
> +	struct device *dev;
> +	struct backlight_device *bl;
> +	int ret;
> +
> +	dev = &client->dev;
> +	ch1115 = devm_drm_dev_alloc(&client->dev, &ch1115_driver,
> +				    struct ch1115_device, dev);
> +	if (IS_ERR(ch1115))
> +		return PTR_ERR(ch1115);
> +
> +	i2c_set_clientdata(client, ch1115);
> +
> +	ch1115->client = client;
> +	ch1115->regmap = devm_regmap_init(dev, &ch1115_regmap_bus,
> +					  client, &ch1115_regmap_config);
> +	if (IS_ERR(ch1115->regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(ch1115->regmap),
> +				     "Failed to initialize regmap\n");
> +	}

Un-needed { } to be consistent with other paths below.

> +
> +	ret = ch1115_parse_dt(ch1115);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to parse DT\n");
> +
> +	ch1115->pages = DIV_ROUND_UP(ch1115->height, CH1115_PAGE_HEIGHT);
> +	ch1115->bytes_per_row = DIV_ROUND_UP(ch1115->width, 8);
> +	ch1115->x_start_offset = ch1115->flip_horizontal
> +		? CH1115_MAX_WIDTH - ch1115->width
> +		: 0;
> +	ch1115->mode = ch1115_mode(ch1115);
> +
> +	ch1115->hwbuf = devm_kzalloc(dev, (ch1115->width * ch1115->height) / 8,
> +				     GFP_KERNEL);
> +	if (!ch1115->hwbuf)
> +		return -ENOMEM;
> +
> +	ch1115->row = devm_kzalloc(dev, ch1115->width, GFP_KERNEL);
> +	if (!ch1115->row)
> +		return -ENOMEM;
> +
> +	// Backlight
> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ch1115,
> +					    &ch1115_bl_ops, NULL);
> +	if (IS_ERR(bl))
> +		return dev_err_probe(dev, PTR_ERR(bl),
> +				     "Unable to register backlight device\n");
> +
> +	bl->props.brightness = ch1115->contrast;
> +	bl->props.max_brightness = CH1115_MAX_CONTRAST;
> +	ch1115->bl_dev = bl;
> +
> +	// DRM
> +	ret = ch1115_mode_config_init(ch1115);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to initialize mode config\n");
> +
> +	ret = ch1115_plane_init(ch1115);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to initialize primary plane\n");
> +
> +	ret = ch1115_crtc_init(ch1115);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to initialize CRTC\n");
> +
> +	ret = ch1115_encoder_init(ch1115);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to initialize encoder\n");
> +
> +	ret = ch1115_connector_init(ch1115);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to initialize connector\n");
> +
> +	drm_mode_config_reset(&ch1115->dev);
> +
> +	ret = drm_dev_register(&ch1115->dev, 0);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to register DRM device\n");
> +
> +	drm_client_setup(&ch1115->dev, NULL);
> +
> +	return 0;
> +}
> +
> +static void ch1115_remove(struct i2c_client *client)
> +{
> +	struct ch1115_device *ch1115 = i2c_get_clientdata(client);
> +	int ret;
> +
> +	u8 cmd_list[] = {
> +		CH1115_CMD_OFF,
> +
> +		CH1115_CMD_ALL_ON,
> +
> +		CH1115_CMD_DC_DC,
> +		CH1115_VAL_DC_DC_OFF,
> +	};
> +
> +	drm_dev_unplug(&ch1115->dev);
> +	drm_atomic_helper_shutdown(&ch1115->dev);
> +
> +	ret = ch1115_send_command_list(ch1115, cmd_list, ARRAY_SIZE(cmd_list));
> +	if (ret < 0)
> +		dev_err(&client->dev, "There was an error executing the shutdown commands");

Missing trailing \n to be consistent with other messages.

> +}
...

CJ
