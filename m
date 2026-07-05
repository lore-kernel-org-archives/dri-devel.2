Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDAAC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DEF310E305;
	Sun,  5 Jul 2026 19:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LiU6EM5H";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71BFC10E305
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:18:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 11EAD42B75;
 Sun,  5 Jul 2026 19:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36921F000E9;
 Sun,  5 Jul 2026 19:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783279135;
 bh=QMdDJZZv/We+1XTHyOM3Kgok2RzB7mrG0RREhYvDWW4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LiU6EM5HOY6gZW1p5+mdvGA9P8JnNGQ8Miie0PYOkY+o2EFoc3YmnY0tETQYCZkjn
 Zc9Iqtj6JtQj0MUcBUEqmnnCkNPMjaHx4jTf8Pnc4yaK5k8SascazjHrFO0GRLTVQy
 CEclM+UMgTIQaaEi3JQvmp3gqg9DIhTcLeRbLctjsbljvb+25AEkAgzUDIyB1FHTsf
 uUvEV0ddgHFgNbQml7jbRbqN9nU1sg8Fulxi8K6aqw/+6MJsXuvs9jd8GA2wRf0VTi
 Ymxpmd2zR+yq/8aOzWenxRZaqBtQhcmMiI5caPlWWB2oBsGOBFSqjwnGocSxoI3vJ5
 gRi24j3F4aMeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/13] HACK: use cb1 address in lpac dtb node
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-8-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-8-01d50c3e0c99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 19:18:54 +0000
Message-Id: <20260705191854.A36921F000E9@smtp.kernel.org>
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
- [Medium] Mismatch between node unit-address and 'reg' property in the 'lp=
ac' node, and incorrect topological sorting.
--

commit 3a9d2680f6799fd4ea05a09430cb0898981bea9a
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

HACK: use cb1 address in lpac dtb node

This commit relocates the lpac device tree node within the sm8650 device
tree and modifies its unit-address.

> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/q=
com/sm8650.dtsi
> index 44e5f9d4b335f..66ea9155e2289 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi

[ ... ]

> @@ -4254,6 +4247,13 @@ opp-834000000 {
>  			};
>  		};
> =20
> +		lpac: lpac@3dc1000 {
> +			compatible =3D "qcom,lpac";
> +			reg =3D <0x0 0x03d00000 0x0 0x61000>;

[Severity: Medium]
Does this code miss updating the reg property to match the new unit-address?
The unit-address is set to @3dc1000, but the first address specified in the
reg property is still 0x03d00000.=20

According to the Devicetree Specification, a node's unit-address must exact=
ly
match the first address in its reg property. Leaving it as 0x03d00000 means
the device continues to map to the old address space (which overlaps with t=
he
gpu node) and fails to actually use the cb1 address. It will also trigger a
unit_address_vs_reg warning from the Device Tree Compiler.

> +
> +			iommus =3D <&adreno_smmu 1 0x0>;
> +		};
> +
>  		gmu: gmu@3d6a000 {
>  			compatible =3D "qcom,adreno-gmu-750.1", "qcom,adreno-gmu";

Should the lpac node be placed after this gmu node? Device tree nodes are
typically sorted by unit-address, and 3dc1000 comes after 3d6a000, making
this current placement topologically incorrect.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-descriptiv=
e-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com?part=3D8
