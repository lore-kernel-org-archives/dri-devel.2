Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F720CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 12:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E8710E5C2;
	Sat, 10 Oct 2026 12:08:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nwAmOnv9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80FBC10E2B0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 12:08:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF75860204;
 Sat, 10 Oct 2026 12:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27E21F000FF;
 Sat, 10 Oct 2026 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791634108;
 bh=7WHDSx4VLZtcN6zBFrATuVA/bE4Q6wOIlzLajOqITHY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nwAmOnv9XUSWNw1qBJ5zppXWTDJ/whPnTywhOc6oNIU9WyJwffsB/XCKFo6ur7qgr
 0muVJu8nq2kQHTR3zGYJ8cp1x9ENvlxcK7BitWsFfAFfjzQph3CKYVyDxOB6jSOfHC
 RD4WWB7ebclZ92XnN3VmV34L8dVY+c9kextqUNThBTMpM+2RXMik3wwYOzbClMe+7i
 BCR3RW7I/bT7T1zNQgIelV0x+SQAsX4+DaGEsNrpJJWSBupJ20JQj62JEFL+4u7UOS
 V7SBpXdA64i5ASC+gKZTaUyLUVd8GfWnrBLc57vCy0zBeJFHqTX++XoeT4ReWo6BYh
 IEdzk3AWkLTXg==
Message-ID: <sashiko-outbox-166487@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: mediatek: mt8167: Add HDMI display nodes
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, neil.armstrong@linaro.org,
 linux-clk@vger.kernel.org, olteanv@gmail.com, robh@kernel.org,
 linux-phy@lists.infradead.org, vkoul@kernel.org
In-Reply-To: <20261010115539.9237-8-l.scorcia@gmail.com>
References: <20261010115539.9237-1-l.scorcia@gmail.com>
 <20261010115539.9237-8-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 12:08:27 +0000
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
- [Low] dts: mt8167: hdmiddc compatible array violates schema enum constrai=
nt
--

commit c20e20334411b75b4e2b444ca191ccb04b2ad0ef
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

arm64: dts: mediatek: mt8167: Add HDMI display nodes

This commit adds the required device tree nodes to enable HDMI output on the
mt8167 SoC.

> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8167.dtsi
> index 27cf32d7ae35f..ab76e0637eb15 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi

[ ... ]

> @@ -120,6 +141,15 @@ iommu: m4u@10203000 {
>  			#iommu-cells =3D <1>;
>  		};
> =20
> +		hdmiddc: i2c@11011000 {
> +			compatible =3D "mediatek,mt8167-hdmi-ddc", "mediatek,mt8173-hdmi-ddc";

[Severity: Low]
Does this compatible array violate the devicetree schema constraints?

The mediatek,hdmi-ddc.yaml schema uses an enum constraint for the compatible
property:

properties:
  compatible:
    enum:
      - mediatek,mt7623-hdmi-ddc
      - mediatek,mt8167-hdmi-ddc
      - mediatek,mt8173-hdmi-ddc

This restricts the property to a single string and prevents fallback arrays.

Compiling the devicetree with make dtbs_check will throw a schema validation
warning here.

> +			reg =3D <0 0x11011000 0 0x10>;
> +			interrupts =3D <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
> +			clocks =3D <&topckgen CLK_TOP_26M_HDMI_SIFM>;
> +			clock-names =3D "ddc-i2c";
> +			status =3D "disabled";
> +		};
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010115539.9237=
-1-l.scorcia@gmail.com?part=3D7
