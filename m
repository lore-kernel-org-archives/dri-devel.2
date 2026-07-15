Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE823C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1846110E152;
	Wed, 15 Jul 2026 18:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NQPGx37g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC57C10E152
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:53:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EB8B4050C;
 Wed, 15 Jul 2026 18:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E244F1F000E9;
 Wed, 15 Jul 2026 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784141585;
 bh=26Nhtqrx66ck/35B7NmIGeHnGbHzVnSYGTXiHgfrvXM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NQPGx37guQLfDHa6NEFurZ+sqaBljUx983SXQw87WpA7qiXTcrT7g1KH2A7Ffb1zj
 lIwcgQEdaAaH1AsXcQewgZaZB8VC/u1j71yv/+7EjXGd/Wbar79zlitANOZFpj6Iz5
 1QjtDgTCIQtJnm1xkpvPOg5SAdksqswj3cKUo47ZTkldRJcS3Stkej5KYztANr36Un
 xWhxWLfqEK3Dk8Nfq/9KnIvMLtUzXou4IRloLF8yUnKq+N2KKOBOVCoaI4hsxJELma
 vpWs+/TdYbz4ZGIVkiPxIUuYsTeUOkWs8O+dPgYMfdR9NSa68cIMb+4JLOd4Y8Ga2Y
 fQrcnbJYL5vew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] arm64: dts: imx8dxl-evk: Add onboard GPIO mux
 controller
To: Frank.Li@oss.nxp.com
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, Frank.Li@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260715-dxl_lcdif-v2-5-da797562636e@nxp.com>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-5-da797562636e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:53:04 +0000
Message-Id: <20260715185304.E244F1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The generic pinctrl mux driver uses a blocking semaphore lock for =
mux states without registering pinctrl pins, causing an indefinite kernel t=
hread hang if multiple devices request overlapping multiplexer states.
--

--- Patch [5]: [PATCH v2 5/7] arm64: dts: imx8dxl-evk: Add onboard GPIO mux=
 controller ---
commit 2474a73a6c541ff5bdb893980b3be68aefebe7b3
Author: Frank Li <Frank.Li@nxp.com>
Date:   Wed Jul 15 18:34:50 2026 +0000

arm64: dts: imx8dxl-evk: Add onboard GPIO mux controller
   =20
This commit adds a GPIO mux controller to explicitly describe the onboard
signal multiplexer using the pinctrl-multiplexer framework. The patch routes
signals for functions like lpuart1 and spi3, preparing the device tree for
additional overlays that require different mux configurations.

> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/b=
oot/dts/freescale/imx8dxl-evk.dts
> index 78e8d41e67916..33941645641f5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts

[ ... ]

> +	pinctrl-gpiomux {
> +		compatible =3D "pinctrl-multiplexer";

[Severity: High]
This isn't a bug introduced by this patch, but since this patch makes this=
=20
board the first real in-tree consumer of the pinctrl-multiplexer framework,=
=20
could it expose a deadlock risk in the generic mux driver?

Looking at drivers/pinctrl/pinctrl-generic-mux.c, the driver registers the=
=20
pinctrl provider without defining any pins (npins =3D 0) in mux_pinctrl_pro=
be():

drivers/pinctrl/pinctrl-generic-mux.c:mux_pinctrl_probe() {
	pctl_desc->pctlops =3D &mux_pinctrl_ops;
	pctl_desc->pmxops =3D &mux_pinmux_ops;

	ret =3D devm_pinctrl_register_and_init(dev, pctl_desc, mpctl,
					     &mpctl->pctl);
	...
}

Because it bypasses the pinctrl core's built-in pin conflict detection,=20
any overlapping state conflicts are deferred to the mux subsystem API:

drivers/pinctrl/pinctrl-generic-mux.c:mux_pinmux_set_mux() {
	...
	ret =3D mux_state_select(func->mux_state);
	...
}

If two devices (e.g., via the DT overlays mentioned in the commit message)=
=20
define pinctrl states sharing the same underlying mux-controller, the first=
=20
device will acquire the mux lock semaphore and hold it for its bound lifeti=
me.=20

When the second device probes, it calls mux_state_select() and blocks=20
indefinitely on down_killable(), causing a kernel thread hang instead of a=
=20
graceful failure.

Should the generic pinctrl mux driver use mux_state_try_select() instead of=
=20
mux_state_select() so that conflicting overlay requests fail gracefully wit=
h=20
-EBUSY?

> +
> +		m4_debug_fun: cm4-uart-grp {
> +			mux-states =3D <&m4_debug_mux 1>;
> +		};

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-dxl_lcdif-=
v2-0-da797562636e@nxp.com?part=3D5
