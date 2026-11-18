Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7A606A332
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNd0u1Ft
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DA310FFA7;
	Wed, 18 Nov 2026 19:09:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2467B10FFBB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 19:09:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECCD86383B;
 Wed, 18 Nov 2026 19:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618AF1F000C4;
 Wed, 18 Nov 2026 19:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795028941;
 bh=7c8ppuunIdtFjvUrjCDWTw1becCkmfL7Vf+hBZTuAWs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SNd0u1FtLMCP4FsOjVjU0piGYQyKOhXRcLIrelZsERTot3gJOx2Ev8F/wL7/SwjfX
 KbePEsL5R+xgr2nH0lKVWHK2Md0DV5eBDyuyz7LYJw/oK7i3AaZNlqollE8FGHl+wF
 6GUcIOW6SzD/LPlRrGL/oVRmdMlLkEZ897laIDCPHN+e0QQN5WqohZybqG6hc8cYp+
 H2+VRGtqEeg7JCBVUNaO2zlacqi1OYhrpJEE+xoGSXtFzaMEZCKGExdZl6XLNdphoG
 218UyUf2R+HrNc9OrMr8oyy/Vfrd49Jibgy9vnMb58XgP413HvLhrdZFBkwKwhVHiy
 54vgf5VglsvhQ==
Message-ID: <sashiko-outbox-221816@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] riscv: dts: spacemit: k1: add PowerVR GPU device node
To: "Iker Pedrosa" <ikerpedrosam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118-orangepi-gpu-v2-1-f68676f844eb@gmail.com>
References: <20261118-orangepi-gpu-v2-1-f68676f844eb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 19:09:00 +0000
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
- [High] riscv: dts: spacemit: build failure from missing
  spacemit,k1-power.h header
--

commit efc5334efe329206674ea5227e542cbbf6e41d33
Author: Iker Pedrosa <ikerpedrosam@gmail.com>

riscv: dts: spacemit: k1: add PowerVR GPU device node

This commit adds the PowerVR Rogue GPU device tree node for the SpacemiT
K1 SoC and enables it by default.

> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/s=
pacemit/k1.dtsi
> index 5d5f7f8a393d3..15bee2137e14e 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -5,6 +5,7 @@
> =20
>  #include <dt-bindings/clock/spacemit,k1-syscon.h>
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/power/spacemit,k1-power.h>
> =20
>  #include "k1-pdma.h"
> =20
> @@ -1119,6 +1120,16 @@ multimedia-bus {
>  			#size-cells =3D <2>;
>  			dma-ranges =3D <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
>  				     <0x0 0x80000000 0x1 0x00000000 0x3 0x80000000>;
> +
> +			gpu: gpu@cac00000 {
> +				compatible =3D "spacemit,k1-gpu", "img,img-bxe-2-32", "img,img-rogue=
";
> +				reg =3D <0x0 0xcac00000 0x0 0x80000>;
> +				interrupts =3D <75>;
> +				clocks =3D <&syscon_apmu CLK_GPU>;
> +				clock-names =3D "core";
> +				resets =3D <&syscon_apmu RESET_GPU>;
> +				power-domains =3D <&syscon_apmu K1_PMDOMAIN_GPU>;
> +			};
>  		};
> =20
>  		network-bus {

[Severity: High]
Does this break the DTB build when CONFIG_ARCH_SPACEMIT is enabled?
Neither include/dt-bindings/power/spacemit,k1-power.h nor K1_PMDOMAIN_GPU
is present in the tree yet, so preprocessing any SpacemiT K1 board DTS
that includes k1.dtsi fails until the prerequisite power-domain series is
applied.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-orangepi-g=
pu-v2-1-f68676f844eb@gmail.com?part=3D1
