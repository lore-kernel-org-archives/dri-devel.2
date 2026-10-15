Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE05ECC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587F010EBCE;
	Thu, 15 Oct 2026 19:06:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2993710EBCE
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 19:06:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E28B143CF8;
 Thu, 15 Oct 2026 19:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F891F000C4;
 Thu, 15 Oct 2026 19:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792091191;
 bh=V4oOWsdkXWlhCRhA4V6tBrbRkRQXYEj4yKUhwmJslNI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aaTocO0FoGis8eZrX1Og6I3GSNNNsronN/v2aYSgnET9eiVreyMoOvhHcopXKQh7D
 W7D8Ox9RPZ/gaU0Cb0Yek7k7U7OuBHhOGNfpZxNPpSxjlG5ZSaC2gTASNWKr5Ycxhm
 uoDfl+HNXYoR6HpqMTS6BzFWVhTrV7nevG1FW7avMBSUUc6NyvtAwGHkYvmCf+pylN
 vL81oZ1Z2qHTbXxZhFZ0cwPsmd1YhiB2HCF51WAs9TGB2yCiaaDWNMA+O0eaAkvKYa
 gNi+HbKb6SDrooyR7rzCp+VpaoBF1ttzTYmf7T8TYP0X0C2HTE4EiPzf0ei//FN1ws
 vRcmvX2gW3Q5Q==
Message-ID: <sashiko-outbox-173346@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/2] riscv: dts: spacemit: k1: add PowerVR GPU
 device node
To: "Iker Pedrosa" <ikerpedrosam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261015-orangepi-gpu-v1-1-03566a615660@gmail.com>
References: <20261015-orangepi-gpu-v1-0-03566a615660@gmail.com>
 <20261015-orangepi-gpu-v1-1-03566a615660@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 19:06:31 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] dts: build failure due to missing k1-power.h dt-binding header
- [Low] dts: undocumented compatible strings for spacemit k1-gpu
--

commit 8e44783c41b2ae5db8c6c7e6e7e39b06ba8d49af
Author: Iker Pedrosa <ikerpedrosam@gmail.com>

riscv: dts: spacemit: k1: add PowerVR GPU device node

Add device tree node for the Imagination Technologies PowerVR Rogue GPU
(BVNC 36.29.52.182 / BXE-2-32) found in the Spacemit K1 SoC.

> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/s=
pacemit/k1.dtsi
> index 3fabfd34114b2..82cade2f76fe4 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -5,6 +5,7 @@
> =20
>  #include <dt-bindings/clock/spacemit,k1-syscon.h>
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/power/spacemit,k1-power.h>

[Severity: Low]
Does this header exist in the tree? It doesn't appear to be added in this
patch or in the tree yet, which causes a fatal preprocessor error and
compilation failure.

[ ... ]

> @@ -1119,6 +1120,17 @@ multimedia-bus {
>  			#size-cells =3D <2>;
>  			dma-ranges =3D <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
>  				     <0x0 0x80000000 0x1 0x00000000 0x3 0x80000000>;
> +
> +			gpu: gpu@cac00000 {
> +				compatible =3D "spacemit,k1-gpu", "img,img-bxe-2-32", "img,img-rogue=
";

[Severity: Low]
Are these compatible strings documented in a DT binding schema?

"spacemit,k1-gpu" and "img,img-bxe-2-32" appear to be undocumented, which w=
ill
cause dt_binding_check to fail. Omitting them from the schema also means
their constraints (like required clocks or power domains) won't be properly
validated.

> +				reg =3D <0x0 0xcac00000 0x0 0x80000>;
> +				interrupts =3D <75>;
> +				clocks =3D <&syscon_apmu CLK_GPU>;
> +				clock-names =3D "core";
> +				resets =3D <&syscon_apmu RESET_GPU>;
> +				power-domains =3D <&syscon_apmu K1_PMDOMAIN_GPU>;

[Severity: Low]
Is it possible to build this node? This relies on K1_PMDOMAIN_GPU which was
presumably provided by the missing spacemit,k1-power.h header mentioned
above.

> +				status =3D "disabled";
> +			};
>  		};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-orangepi-g=
pu-v1-0-03566a615660@gmail.com?part=3D1
