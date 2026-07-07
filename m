Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD94C44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC5A010EDA8;
	Tue,  7 Jul 2026 14:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="auu5775D";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0770110EDA8
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:35:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DCAD742E60;
 Tue,  7 Jul 2026 14:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D661F000E9;
 Tue,  7 Jul 2026 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783434933;
 bh=yoJyL3+5kI5tecVgVKNUxAu+uoe7KSfvJLUpR4/oxHM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=auu5775DszXK1pFPaGL+dZztza5GOmZOrrvsNyTTYssuNtQGFH/KFvNPbgJNZhBgd
 9YSFdW1i9seJC7VGP8Pi8IEkhUxQgtBB4S+iKiTY8uFLzfxmVKFopq1f+jwplJ/VIN
 EsgbxyhhD6S3lVMCcUzQkOzSu3FRmz8lwJQIKU3eV1weMHLFAwoLqrAEmXWoTL6vOz
 UelEjso1NfAJBmoXLglBK+4SCBV6YDFqlhxGU3SlqihmOZ4+D/bCyNjnv8cc4Jd9ui
 8oedsVP1+kGQMe8zU4kPQejZ9fp3A7SBP3ZnXIpsOQG26vJma5ssMFGOtJuB9AjZVx
 Z6VAuRNURqRcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/12] dt-bindings: phy: Document MT8195 and MT8196
 DisplayPort PHYs
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, linux-phy@lists.infradead.org, neil.armstrong@linaro.org,
 olteanv@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 vkoul@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260707141931.191172-2-angelogioacchino.delregno@collabora.com>
References: <20260707141931.191172-1-angelogioacchino.delregno@collabora.com>
 <20260707141931.191172-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:35:33 +0000
Message-Id: <20260707143533.65D661F000E9@smtp.kernel.org>
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
- [High] The proposed PHY binding incorrectly models the PHY as a standalon=
e device node with an overlapping `reg` region that conflicts with the exis=
ting DP/eDP TX controller.
--

--- Patch [1]: [PATCH v2 01/12] dt-bindings: phy: Document MT8195 and MT819=
6 DisplayPort PHYs ---
commit 697e3d14510b082973bfd257d964015014dae7b9
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

dt-bindings: phy: Document MT8195 and MT8196 DisplayPort PHYs
   =20
This adds bindings for the DisplayPort and Embedded DisplayPort PHYs found
in the MediaTek MT8195 and MT8196 SoCs. It includes properties for varying
impedance calibrations to optimize the EYE signal pattern.

> diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy=
.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.yaml
[ ... ]
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
[ ... ]
> +examples:
> +  - |
> +    phy@1c500000 {
> +        compatible =3D "mediatek,mt8195-dp-phy";
> +        reg =3D <0x1c500000 0x2000>;
[Severity: High]
Will this reg region conflict with the existing DP/eDP TX controller?

The existing MT8195 DP controller node (edp_tx in mt8195.dtsi) already uses
the base address 0x1c500000 for its region, and the monolithic mtk_dp.c
driver requests this entire exclusive region.

If the PHY is modeled as a standalone sibling node with an overlapping memo=
ry
bound, it seems the kernel's devm_platform_ioremap_resource will fail with
-EBUSY during driver probe and break the display controller.

Should the PHY instead be modeled as a child node without an absolute reg, =
or
should these calibration properties be merged directly into the existing
mediatek,dp.yaml controller binding?

> +        #phy-cells =3D <0>;
> +        nvmem-cells =3D <&edp_glb_bias_trim>, <&edp_clktx_impsel>,
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707141931.1911=
72-1-angelogioacchino.delregno@collabora.com?part=3D1
