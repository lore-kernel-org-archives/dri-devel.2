Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A30606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qf8KrlDZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4465D10E34A;
	Tue, 24 Nov 2026 12:06:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B70510E34A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:06:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E7B7142B7E;
 Tue, 24 Nov 2026 12:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9C41F000C0;
 Tue, 24 Nov 2026 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795522010;
 bh=JKT+SrwlQG14Zxpxl2Pk5goSaHfcBqsRsszCkqpUgdg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qf8KrlDZKu5phSh0vpugB3ZZ5CmCJ+oEK4dgg/TKS1keGsRqTzom8h59FF8vQlefi
 80RQ6bshK3r3L4yn/9F70dwDuEW2PVnX1BSRgH5VobOEf5ROeh07uwup9WMOlAPvwb
 +xd3tSyFbLV448aJF2v7MLh9p3eXBCWVE200DutXlUOYscdFHPgEIDOVsJM9pSvcOr
 N2FjWn3tePtpvko1vkZSE9YJEbFsZxnny+d9QThJ8b91YcvNl/BaYGlVD9RK5LkOM2
 2WG4PRK6sNsN2El+rrmsWVOr0slpqV81pphpNLSP9g/xibxY6yR/cjCkYPwk89hodj
 1fC/ySsmb3s6A==
Message-ID: <sashiko-outbox-231098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: tc358762: fix reset gpio handling
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261124-tc3-reset-v1-1-a5d27fe4b5de@kemnade.info>
References: <20261124-tc3-reset-v1-0-a5d27fe4b5de@kemnade.info>
 <20261124-tc3-reset-v1-1-a5d27fe4b5de@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:06:49 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/bridge: tc358762: logical GPIOD_OUT_LOW in
  tc358762_parse_dt() breaks reset
- [Low] drm/bridge: tc358762: missing Fixes trailer and unclear commit
  message wording
--

commit 9028d6282d51dd304edf7f4805b90948cbd05227
Author: Andreas Kemnade <andreas@kemnade.info>

> drm/bridge: tc358762: fix reset gpio handling
>
> Reset gpio is asserted when the chip should be active, deasserted when
> the chip is enabled. That is the wrong way. Apparently users are working
> around this by using GPIO_ACTIVE_HIGH to compensate for that bug but that
> is not correcly describing the hardware. Ignore GPIO polarity for now
> to ease transition hoping that nobody has an inverter in the signal path.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

[Severity: Low]
Should this bug fix include a Fixes tag:

  Fixes: 3355f4ee561d ("drm/bridge: tc358762: Add reset GPIO support")

Also, the first sentence says "asserted when the chip should be active,
deasserted when the chip is enabled", where both clauses describe the
active/enabled state rather than enabling vs. disabling the chip.

> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/t=
c358762.c
> index 76564d5e4f69f..404420c7b517e 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -164,7 +164,7 @@ static void tc358762_post_disable(struct drm_bridge *=
bridge,
>  	ctx->pre_enabled =3D false;
> =20
>  	if (ctx->reset_gpio)
> -		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +		gpiod_set_raw_value_cansleep(ctx->reset_gpio, 0);
> =20
>  	ret =3D regulator_disable(ctx->regulator);
>  	if (ret < 0)
> @@ -182,7 +182,7 @@ static void tc358762_pre_enable(struct drm_bridge *br=
idge,
>  		dev_err(ctx->dev, "error enabling regulators (%d)\n", ret);
> =20
>  	if (ctx->reset_gpio) {
> -		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		gpiod_set_raw_value_cansleep(ctx->reset_gpio, 1);
>  		usleep_range(5000, 10000);
>  	}

[Severity: High]
Does requesting ctx->reset_gpio with logical GPIOD_OUT_LOW in
tc358762_parse_dt() drive the physical reset pin high during probe when the
Device Tree specifies GPIO_ACTIVE_LOW?

drivers/gpu/drm/bridge/tc358762.c:tc358762_parse_dt() {
	...
	/* Reset GPIO is optional */
	ctx->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
	if (IS_ERR(ctx->reset_gpio))
		return PTR_ERR(ctx->reset_gpio);
	...
}

With GPIO_ACTIVE_LOW in Device Tree, GPIOD_OUT_LOW (logical 0) is inverted
by gpiolib to physical 1 at probe time while vddc-supply is still disabled.
On standalone reset GPIOs, the bridge is not held in reset during power-up
and gpiod_set_raw_value_cansleep(ctx->reset_gpio, 1) in
tc358762_pre_enable() becomes a 1-to-1 no-op.  On the Raspberry Pi 7-inch
panel unit (drivers/regulator/rpi-panel-attiny-regulator.c), driving the
reset line to physical 1 at probe sets PC_RST_BRIDGE_N in REG_PORTC, which
causes attiny_lcd_power_is_enabled() to report the regulator as already
enabled so regulator_enable(ctx->regulator) in tc358762_pre_enable() skips
enabling panel and bridge power.

Instead of using raw GPIO accessors, should tc358762 use logical active-low
reset values (GPIOD_OUT_HIGH at probe, 0 in tc358762_pre_enable(), and 1 in
tc358762_post_disable()) and add a polarity quirk for "toshiba,tc358762"
"reset-gpios" in of_gpio_try_fixup_polarity() to handle older Device Trees?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-tc3-reset-=
v1-0-a5d27fe4b5de@kemnade.info?part=3D1
