Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4A1606A338
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g41N13ax
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C12710F978;
	Wed, 11 Nov 2026 08:36:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F3910F96C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:36:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A82C45E1A;
 Wed, 11 Nov 2026 08:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EA11F00A05;
 Wed, 11 Nov 2026 08:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794386163;
 bh=1HIxbApyiQowjnqXKzbDN9ZBPxizvL+h7XM8y3qOXtg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g41N13ax7LWYuSiy2cZUZ5g76BmT9hEApXcB9HVrLpffGlmWxGZCPNPHnkvOKQvjY
 7LIhW4QAwCs9abDs4rnlFVDTPZGFItf3dovagjVz5eUErxzyVHRYu2Jg1BrugRWM/X
 kzreTQFuLN6HDP98JpTy9fCTttDNBRg3dviLK0kiA9nmw1b48FvwrokOe81mDBga5C
 KpA6RwAoB3zZVVKGf71ztYv2iG9LpYBH+M7F+eIL0LlzVe7xFsSRpsWugtBaGY6tGH
 eNLKxNEWx3dBwE/CPiGdwslx5UfFsOd52GgLryNjnau1ZuxazRTfGpw76tWTqZlxu8
 BzPWv0cFGQIbw==
Message-ID: <sashiko-outbox-208621@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: freescale: Add support for
 bytesatwork i.MX93
To: "Frank Obergfell" <frank.obergfell@bytesatwork.ch>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261111081150.950272-6-frank.obergfell@bytesatwork.ch>
References: <20261111081150.950272-1-frank.obergfell@bytesatwork.ch>
 <20261111081150.950272-6-frank.obergfell@bytesatwork.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:36:02 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] arm64: dts: freescale: imx93-bytedevkit: unused backlight-lvds
  left enabled
--

commit c60831b496cfd3af119e905c5fcb49dc6905f857
Author: Frank Obergfell <frank.obergfell@bytesatwork.ch>

arm64: dts: freescale: Add support for bytesatwork i.MX93

This commit adds device tree files for the bytesatwork i.MX93 byteENGINE
OSM module and the byteDEVKIT board.

> diff --git a/arch/arm64/boot/dts/freescale/imx93-bytedevkit.dts b/arch/ar=
m64/boot/dts/freescale/imx93-bytedevkit.dts
> new file mode 100644
> index 0000000000000..cb5d17c8444c3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-bytedevkit.dts

[ ... ]

> +	lcd_bl: backlight-lvds {
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_lvds_backlight>;
> +		compatible =3D "gpio-backlight";
> +		gpios =3D <&gpio2 26 GPIO_ACTIVE_HIGH>;
> +		default-on;
> +	};

[Severity: Low]
Should backlight-lvds be disabled or removed while the LVDS display
pipeline and touch controller on lpi2c1 are disabled?  With default-on set
and no panel referencing &lcd_bl, gpio_backlight_probe() registers an
unused backlight device and drives GPIO2_IO26 high at boot even though
only the MIPI DSI panel is active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111081150.9502=
72-1-frank.obergfell@bytesatwork.ch?part=3D5
