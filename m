Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14729C88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F85A10E752;
	Tue, 15 Sep 2026 21:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n66ICA8d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A22010E752
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 21:03:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ACFD843845;
 Tue, 15 Sep 2026 21:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D0F1F000FF;
 Tue, 15 Sep 2026 21:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789506234;
 bh=ZQV6ssqytvvtKAHdm8zAQn8yAkBtgmwEcLHfQhGFEug=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n66ICA8dqJMa/IedeiWHS5Ta7BqUOtAspkPk3KObqPWtm0GAoGES2+Li0FlEK18bt
 FrdzPsRpMWlviZyXGxJ4CZQcCV0kvpnpJ4SoQF2T/7gFeoyIoeGNZZg6lYmkgR0Qrs
 6iTd8lrqidbD3LgYpIKOGtK0NYG9ZUJRLu+OfDZi0nIxUqT1kv/S1XZ3WSJQmIAozW
 cdBl7Crz4BJvIs2iIm5F+OOwONLfmaCfPga3A7vmSPkXk/GstmvZoY1EH54gDeQb69
 BV6mMP125yrYsA9idQGcWG+trzeI5ET7GHJhiuhZG4CG4sH7aSaEolUtf7m1txeojM
 wnfQsTWmVC38g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] ARM: dts: bcm2835: Add the V3D reset line
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260915-vc4-reset-control-v2-4-cb3a25b07822@igalia.com>
References: <20260915-vc4-reset-control-v2-0-cb3a25b07822@igalia.com>
 <20260915-vc4-reset-control-v2-4-cb3a25b07822@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 21:03:53 +0000
Message-Id: <20260915210354.41D0F1F000FF@smtp.kernel.org>
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
- [Medium] clk: reference leak and underflow in bcm2835_reset_reset via byp=
assed genpd
--

commit a62442494a68213d73ba03025de353d2162a2d5f
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

ARM: dts: bcm2835: Add the V3D reset line

This commit wires up the V3D reset line to the shared V3D node in the
device tree for BCM2835, BCM2836, and BCM2837. This enables the vc4
driver to use the reset line when recovering from a hang instead of
forcing the power domain down.

> diff --git a/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi b/arch/arm/bo=
ot/dts/broadcom/bcm2835-common.dtsi
> index 1e76b290510d3..39eea8ce10583 100644
> --- a/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
> +++ b/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
> @@ -139,6 +139,7 @@ v3d: v3d@7ec00000 {
>  			compatible =3D "brcm,bcm2835-v3d";
>  			reg =3D <0x7ec00000 0x1000>;
>  			interrupts =3D <1 10>;
> +			resets =3D <&pm BCM2835_RESET_V3D>;

[Severity: Medium]
Will this reset configuration conflict with the firmware power domain on
Raspberry Pi?

On boards where the V3D device uses a firmware-managed power domain, the
native bcm2835-power genpd is left uninitialized and its native clock
(BCM2835_CLOCK_V3D) enable count is 0.

When the vc4 driver detects a GPU hang, it triggers a reset that calls
into bcm2835_reset_reset(). This unconditionally cycles the native power
domain off and on:

drivers/pmdomain/bcm/bcm2835-power.c:bcm2835_reset_reset() {
	...
	ret =3D bcm2835_power_pd_power_off(&pd->base);
	...
}

drivers/pmdomain/bcm/bcm2835-power.c:bcm2835_asb_power_off() {
	...
	clk_disable_unprepare(pd->clk);
	...
}

Does calling clk_disable_unprepare() here trigger a kernel WARN_ON by
underflowing the uninitialized 0 count? And subsequently, when the reset
path calls bcm2835_power_pd_power_on(), does clk_prepare_enable()
increment the count from 0 to 1, permanently leaking a clock reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-vc4-reset-=
control-v2-0-cb3a25b07822@igalia.com?part=3D4
