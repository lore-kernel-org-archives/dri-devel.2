Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44440606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCVofGrz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE6510E4D5;
	Tue,  3 Nov 2026 13:42:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8863A10E4D5
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:42:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2BFBC402DB;
 Tue,  3 Nov 2026 13:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48D91F000C1;
 Tue,  3 Nov 2026 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793713368;
 bh=QDObCe6O7rjfCKHYtojSqpqclnncYQkjEZrORV6kUd8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QCVofGrzIY50O7ZvmAZhP7hlATkqhLYVtrMKIGncl0mniVAZnpEIo45pH9H52wCDr
 JDTmpsb4u2QHG7+A5vGhvOw3dEloQmkhkR/vGNiCYwqBnlllzV9mNm9jmuX/mlr6HG
 rNjmdOf2fWp8/1tywWK+7cnpaek8cJYbL5RK9oeDsF0KpKJTZPQGblCa3Q1P87/LiU
 NRKYWpuklsiHZ/ipSPmgO9CiRMbUMlFXvX7DQctRSbjmA4hiQH9zZ1Vee+oAl6KRc6
 tG/uVzjtY47v4hmoB03tvdXpCkqP5Xghbn0i4mgvUhOIWdj+GcjPcPDHbCMviIOP35
 FrKEWbPshfe9A==
Message-ID: <sashiko-outbox-195387@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/panel-mipi-dbi: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-gpio@vger.kernel.org
In-Reply-To: <20261103-panel-mipi-non-exclusive-gpios-v1-3-aa862c1d71e3@oss.qualcomm.com>
References: <20261103-panel-mipi-non-exclusive-gpios-v1-0-aa862c1d71e3@oss.qualcomm.com>
 <20261103-panel-mipi-non-exclusive-gpios-v1-3-aa862c1d71e3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:42:47 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/panel-mipi-dbi: broken shared dc GPIO in panel_mipi_dbi_spi_pr=
obe()
--

commit 90b279985dbeced362ebac928f364d9afff9972e
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

drm/panel-mipi-dbi: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE

This commit removes the deprecated GPIOD_FLAGS_BIT_NONEXCLUSIVE flag when
requesting the dc GPIO in panel_mipi_dbi_spi_probe(), relying on the GPIOLIB
shared GPIO proxy instead.

> diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny=
/panel-mipi-dbi.c
> index 60cd65cae41d8..6f09b723cd7c3 100644
> --- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> +++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> @@ -418,8 +418,7 @@ static int panel_mipi_dbi_spi_probe(struct spi_device=
 *spi)
>  	if (IS_ERR(dbi->reset))
>  		return dev_err_probe(dev, PTR_ERR(dbi->reset), "Failed to get GPIO 're=
set'\n");
> =20
> -	/* Multiple panels can share the "dc" GPIO, but only if they are on the=
 same SPI bus! */
> -	dc =3D devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW | GPIOD_FLAGS_B=
IT_NONEXCLUSIVE);
> +	dc =3D devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);

[Severity: High]
Can gpio-shared-proxy work for a shared MIPI DBI D/C line across multiple
panels on the same SPI bus?

Unlike a shared reset or enable pin, the D/C GPIO in MIPI DBI Type C Option=
 3
is a bus control signal (0 for commands, 1 for parameters and pixel data)
multiplexed under spi_bus_lock(). In drivers/gpu/drm/drm_mipi_dbi.c,
mipi_dbi_typec3_command() leaves dbi->dc asserted at 1 after transferring
command parameters or pixel data:

drivers/gpu/drm/drm_mipi_dbi.c:mipi_dbi_typec3_command() {
	...
	spi_bus_lock(spi->controller);
	gpiod_set_value_cansleep(dbi->dc, 0);
	speed_hz =3D mipi_dbi_spi_cmd_max_speed(spi, 1);
	ret =3D mipi_dbi_spi_transfer(spi, speed_hz, 8, &cmd, 1);
	spi_bus_unlock(spi->controller);
	if (ret || !num)
		return ret;

	...
	spi_bus_lock(spi->controller);
	gpiod_set_value_cansleep(dbi->dc, 1);
	speed_hz =3D mipi_dbi_spi_cmd_max_speed(spi, num);
	ret =3D mipi_dbi_spi_transfer(spi, speed_hz, bpw, par, num);
	spi_bus_unlock(spi->controller);

	return ret;
}

When panel_mipi_dbi_spi_probe() requests dc with GPIOD_OUT_LOW,
shared_desc->def_val is 0. Once panel A sends a command with parameters and
sets dbi->dc to 1, gpio_shared_proxy_set_unlocked() sets panel A's
proxy->voted_change =3D true and increments shared_desc->votecnt to 1. Beca=
use
mipi_dbi_typec3_command() returns with dbi->dc still at 1, panel A retains =
its
vote after releasing spi_bus_lock().

When panel B on the same SPI bus then calls gpiod_set_value_cansleep(dbi->d=
c, 0)
in mipi_dbi_typec3_command() or mipi_dbi_typec3_command_read() to send a
command byte, gpio_shared_proxy_set_unlocked() checks whether any other pro=
xy
still holds a vote for 1:

drivers/gpio/gpio-shared-proxy.c:gpio_shared_proxy_set_unlocked() {
	...
	/* Desired value is the default. */
	if (!proxy->voted_change) {
		if (!shared_desc->votecnt)
			ret =3D gpiod_set_value_cansleep(desc, shared_desc->def_val);
		goto out;
	}

	/* We previously voted for change. */
	if (shared_desc->votecnt =3D=3D 1) {
		/* This is the last remaining vote for change, set value to default. */
		ret =3D gpiod_set_value_cansleep(desc, shared_desc->def_val);
		if (ret)
			goto out;
	}
	...
}

Because panel A's vote keeps shared_desc->votecnt >=3D 1, gpio-shared-proxy=
 will
not drive the physical D/C GPIO back to 0 when panel B requests 0, leaving =
the
physical D/C line stuck high in data mode during panel B's command transfers
(and vice versa once panel B also sets dc to 1).

Also, the two in-tree DT users mentioned in the commit message only define a
single panel each and do not share dc-gpios, whereas DRM_PANEL_MIPI_DBI its=
elf
does not select HAVE_SHARED_GPIOS and can be used on any platform or via DT
overlays where shared dc-gpios configurations (added in commits 3a63ef6e4b9e
and 8cc8ccbaa5d8) would now either fail probe with -EBUSY or fail to toggle
the physical D/C line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-panel-mipi=
-non-exclusive-gpios-v1-0-aa862c1d71e3@oss.qualcomm.com?part=3D3
