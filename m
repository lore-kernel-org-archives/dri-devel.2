Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA076606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maa4m6ll
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C3B510EFE2;
	Tue, 24 Nov 2026 07:45:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10CB910EF18
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:45:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7401C61E01;
 Tue, 24 Nov 2026 07:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4371F000C6;
 Tue, 24 Nov 2026 07:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795506314;
 bh=wAGgr8ibrwYcP8oDZVC+XCxHDnlnCkP54G0H6idRA4M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=maa4m6llbxkaufCr8cZ9slCrJCWcJbiPCR8fdRjTZCGb9n12XRqy69rJIo2Sz3UmG
 1ZRDvQ6bFg9Y4tXddg8nfOKef0kTS2DwH8lTx+CnzJ9gffeu13doQg4hIeI/CNbOdq
 NmRqCsD9Q6xZ1D+eP45+1ePnitgtouOPa6Wsmz5M52iE7eQlUn6eFBTqOyZPupKKgn
 /qfcNTlg1DyFFpbuKSy47ACawgU0WAD5Zo8/OFm3Dgy3XNUGvP0oTtok8tndG1GcfE
 VdNo1fNARmpPK5E/Jomx1BKQOL05Wik5er7+Eb1xltR5GD8m4glGdscWzuA3fQCbFt
 rvf9dJJI1QIzA==
Message-ID: <sashiko-outbox-230664@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/20] ARM: dts: omap3-pandora: Model LCD power
 enable dependencies
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <0c0bc2049bad3e236bab5fd86b8cd0b11fd56d11.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <0c0bc2049bad3e236bab5fd86b8cd0b11fd56d11.1795505160.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:45:13 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] ARM: dts: omap3-pandora: usb_host_5v disabled after boot due to
  no consumer
- [Low] ARM: dts: omap3-pandora: deprecated fixed-regulator-* node names
  on new nodes
- [Low] ARM: dts: omap3-pandora: twl_gpio inserted between bluetooth
  comment and mcbsp3
- [Low] ARM: dts: omap3-pandora: dead startup-delay-us on GPIO-less
  lcd_5v regulator
--

commit f12a2f12a91cab92b448c35782704537aa5d9f32
Author: H. Nikolaus Schaller <hns@goldelico.com>

ARM: dts: omap3-pandora: Model LCD power enable dependencies

This commit adds fixed-regulator nodes aux_5v and lcd_5v to model the LCD
and USB host 5V power supply enable dependencies across OpenPandora board
revisions, and enables ti,use-regen on twl_gpio.

> diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/a=
rm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> index 2097ec15c6513..f25fc4f8ad042 100644
> --- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> @@ -31,6 +31,28 @@ hfclk_26m: oscillator {
>  		clock-frequency =3D <26000000>;
>  	};
> =20
> +	/* Shared 5V rail for headphone amplifier, early LCD and USB */
> +	aux_5v: fixed-regulator-5v {
> +		compatible =3D "regulator-fixed"; /* TPS61029DRC */
> +		regulator-name =3D "aux_5v";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		startup-delay-us =3D <5000>;
> +		enable-active-high;
> +		gpio =3D <&twl_gpio 20 GPIO_ACTIVE_HIGH>; /* REGEN */
> +		vin-supply =3D <&vaux1>; /* logical enable dependency */
> +	};
> +
> +	/* LCD_5V: switched shared 5V on rev 5a, separate supply on rev 6d */
> +	lcd_5v: fixed-regulator-lcd-5v {

[Severity: Low]
Documentation/devicetree/bindings/regulator/fixed-regulator.yaml marks node
names not matching ^regulator(-[0-9]+v[0-9]+|-[0-9a-z-]+)?$ as deprecated.
Should these new nodes be named regulator-5v (or regulator-aux-5v) and
regulator-lcd-5v so they do not add dtbs_check warnings?

> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "lcd_5v";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		startup-delay-us =3D <5000>;
> +		vin-supply =3D <&aux_5v>; /* logical enable dependency */
> +	};

[Severity: Low]
Does startup-delay-us on lcd_5v have any effect when the node has no enable
GPIO?

In reg_fixed_voltage_probe(), a regulator-fixed node without a gpio property
registers with fixed_voltage_ops (which has no .is_enabled callback) and
rdev->ena_pin set to NULL.  _regulator_is_enabled() therefore always returns
1, causing _regulator_enable() to skip _regulator_do_enable() where
desc.enable_time (startup-delay-us) is applied.  Since lcd_5v controls no
hardware resource of its own, lcd could reference aux_5v directly in
vcc-supply, or startup-delay-us could be dropped from lcd_5v.

Also, the commit message mentions "patch 17", which will lose its meaning in
git history once committed.

[ ... ]

> @@ -212,15 +234,13 @@ hsusb2_phy: hsusb2-phy-pins {
>  		#phy-cells =3D <0>;
>  	};
> =20
> -	/* HS USB Host VBUS supply
> -	 * disabling this regulator causes current leakage, and LCD flicker
> -	 * on earlier (CC) board revisions, so keep it always on */
> +	/* HS USB Host VBUS supply */
>  	usb_host_5v: fixed-regulator-usb_host_5v {
> +		vin-supply =3D <&aux_5v>;
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "usb_host_5v";
>  		regulator-min-microvolt =3D <5000000>;
>  		regulator-max-microvolt =3D <5000000>;
> -		regulator-always-on;
>  		regulator-boot-on;
>  		enable-active-high;
>  		gpio =3D <&gpio6 4 GPIO_ACTIVE_HIGH>;	/* GPIO_164 */

[Severity: High]
Won't removing regulator-always-on from usb_host_5v cause
regulator_late_cleanup() to disable USB Host VBUS 30 seconds after boot?

Nothing in the device tree references &usb_host_5v (hsusb2_phy only has
vcc-supply =3D <&vaux2>), so rdev->use_count stays at 0.  When
regulator_late_cleanup() runs, it sees !c->always_on and rdev->use_count =
=3D=3D 0
and calls _regulator_do_disable(rdev), turning off GPIO 164 with no consumer
to re-enable it and reintroducing the current leakage and LCD flicker on CC
boards noted in the removed comment.

In addition, set_machine_constraints() enables rdev->supply (aux_5v, and
transitively vaux1) at boot when boot_on is set, but regulator_late_cleanup=
()
calls _regulator_do_disable() directly without disabling rdev->supply,
permanently leaking that enable reference on aux_5v and vaux1.

[ ... ]

> @@ -711,6 +731,10 @@ &mcbsp2 {
>  };
> =20
>  /* bluetooth */
> +&twl_gpio {
> +	ti,use-regen;
> +};
> +
>  &mcbsp3 {
>  };

[Severity: Low]
This isn't a bug, but inserting &twl_gpio here separates the /* bluetooth */
comment from the &mcbsp3 node it describes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795505160.gi=
t.hns@goldelico.com?part=3D14
