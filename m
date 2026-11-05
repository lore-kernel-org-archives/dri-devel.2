Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F162606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrQwagZT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5353D11219B;
	Thu,  5 Nov 2026 08:36:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E93112031
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:36:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 5BB8F42E0D;
 Thu,  5 Nov 2026 08:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5D5DA1F000C1;
 Thu,  5 Nov 2026 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793867812;
 bh=7DN9bHAclZBpT6vA3s4oOOECdcaCHYQWkqSsJ9/4dr0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HrQwagZTfYENUwlOVqBX7j3Ry31NE7PqcuvSGhedvmmRowAdHkvNkWCMDjIy/iLUf
 VmRBT4m1c6spcToj+JyhygV7yrDVWi3OND4cdKoXE7cqXxwkAsFvpKELL1ct19tEZy
 OIpH10/0LbZ1M9981gJ7Lq9Bpu5jEb0V55DOfwehCe4OWHnW3YhqYVrJ1XWCJvdO1x
 lmJcOmydSvYIrP6ifHWVZpGMYdO5aOYY3XZb0Z99fKoXqHfyZM7sbJ/CklOHGK+BX1
 PsoRQz6VxPSH1AGUV3W3c8MqMlzoQW0qjEIClGaY0LTVVfcx/yGdPoNQ131AvM/J0Z
 oR7GSaL24Q76A==
Date: Thu, 5 Nov 2026 09:36:48 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/panel-mipi-dbi: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
Message-ID: <ic7droim3dya3jtsherqq34ko7xdbwyjmw7oulq37rgvar7jt3@77nh4qbksbxa>
References: <20261103-panel-mipi-non-exclusive-gpios-v1-0-aa862c1d71e3@oss.qualcomm.com>
 <20261103-panel-mipi-non-exclusive-gpios-v1-3-aa862c1d71e3@oss.qualcomm.com>
 <sashiko-outbox-195387@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195387@kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 01:42:47PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] drm/panel-mipi-dbi: broken shared dc GPIO in panel_mipi_dbi_spi_probe()
> --
> 
> commit 90b279985dbeced362ebac928f364d9afff9972e
> Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
> drm/panel-mipi-dbi: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
> 
> This commit removes the deprecated GPIOD_FLAGS_BIT_NONEXCLUSIVE flag when
> requesting the dc GPIO in panel_mipi_dbi_spi_probe(), relying on the GPIOLIB
> shared GPIO proxy instead.
> 
> > diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> > index 60cd65cae41d8..6f09b723cd7c3 100644
> > --- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> > +++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> > @@ -418,8 +418,7 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
> >  	if (IS_ERR(dbi->reset))
> >  		return dev_err_probe(dev, PTR_ERR(dbi->reset), "Failed to get GPIO 'reset'\n");
> >  
> > -	/* Multiple panels can share the "dc" GPIO, but only if they are on the same SPI bus! */
> > -	dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> > +	dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
> 
> [Severity: High]
> Can gpio-shared-proxy work for a shared MIPI DBI D/C line across multiple
> panels on the same SPI bus?
> 
> Unlike a shared reset or enable pin, the D/C GPIO in MIPI DBI Type C Option 3
> is a bus control signal (0 for commands, 1 for parameters and pixel data)
> multiplexed under spi_bus_lock(). In drivers/gpu/drm/drm_mipi_dbi.c,
> mipi_dbi_typec3_command() leaves dbi->dc asserted at 1 after transferring
> command parameters or pixel data:
> 
> drivers/gpu/drm/drm_mipi_dbi.c:mipi_dbi_typec3_command() {
> 	...
> 	spi_bus_lock(spi->controller);
> 	gpiod_set_value_cansleep(dbi->dc, 0);
> 	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, 1);
> 	ret = mipi_dbi_spi_transfer(spi, speed_hz, 8, &cmd, 1);
> 	spi_bus_unlock(spi->controller);
> 	if (ret || !num)
> 		return ret;
> 
> 	...
> 	spi_bus_lock(spi->controller);
> 	gpiod_set_value_cansleep(dbi->dc, 1);
> 	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, num);
> 	ret = mipi_dbi_spi_transfer(spi, speed_hz, bpw, par, num);
> 	spi_bus_unlock(spi->controller);
> 
> 	return ret;
> }
> 
> When panel_mipi_dbi_spi_probe() requests dc with GPIOD_OUT_LOW,
> shared_desc->def_val is 0. Once panel A sends a command with parameters and
> sets dbi->dc to 1, gpio_shared_proxy_set_unlocked() sets panel A's
> proxy->voted_change = true and increments shared_desc->votecnt to 1. Because
> mipi_dbi_typec3_command() returns with dbi->dc still at 1, panel A retains its
> vote after releasing spi_bus_lock().
> 
> When panel B on the same SPI bus then calls gpiod_set_value_cansleep(dbi->dc, 0)
> in mipi_dbi_typec3_command() or mipi_dbi_typec3_command_read() to send a
> command byte, gpio_shared_proxy_set_unlocked() checks whether any other proxy
> still holds a vote for 1:
> 
> drivers/gpio/gpio-shared-proxy.c:gpio_shared_proxy_set_unlocked() {
> 	...
> 	/* Desired value is the default. */
> 	if (!proxy->voted_change) {
> 		if (!shared_desc->votecnt)
> 			ret = gpiod_set_value_cansleep(desc, shared_desc->def_val);
> 		goto out;
> 	}
> 
> 	/* We previously voted for change. */
> 	if (shared_desc->votecnt == 1) {
> 		/* This is the last remaining vote for change, set value to default. */
> 		ret = gpiod_set_value_cansleep(desc, shared_desc->def_val);
> 		if (ret)
> 			goto out;
> 	}
> 	...
> }
> 
> Because panel A's vote keeps shared_desc->votecnt >= 1, gpio-shared-proxy will
> not drive the physical D/C GPIO back to 0 when panel B requests 0, leaving the
> physical D/C line stuck high in data mode during panel B's command transfers
> (and vice versa once panel B also sets dc to 1).
>

Ugh, this really only works by chance right now and is racy but sashiko
is right that gpio-shared-proxy would break it entirely. It would
probably need a dedicated power sequencer.

Bart
