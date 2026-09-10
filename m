Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B0BC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506F010F3D1;
	Thu, 10 Sep 2026 09:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b/IiDOC7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D761410F3D1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:37:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A7FDE411D1;
 Thu, 10 Sep 2026 09:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0844A1F000FF;
 Thu, 10 Sep 2026 09:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789033047;
 bh=76CVFKEDW0GIDUNEHxaR1IVvxhYDaTAGEQjJ5WjheiU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b/IiDOC7HvYAGYS0J3oSYXxBZqZuviktLyqjpg0UOYWP9/ABphJlUKgV/IXXw5Dt5
 R2nPR52VMKm5kIM6wd/17T3JB/HA2gijCGFuJvB2B1Ah4vE7yrdjPCMapXClObWbSE
 EzFza+X/ekmZExp24trEql0tzxUu6sy1ZptqB2SVZB0klLdgXzALdCmfd5srh1BO90
 UVv+jRsiYokZwIRjsLoGDiEWinWc71OF76KF0cuSg71yPD+N8ovNDXUBtmt5woMk1o
 TSi+Qnbcf+hRlIsvSmrvRwmHBGd586NkYSjza2DMvzpA63tpLkoddQ8e5sDYEvp0Iz
 9xQRxjbosZDvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/12] dt-bindings: phy: Document MT8195 and MT8196
 DisplayPort PHYs
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: vkoul@kernel.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com, conor+dt@kernel.org,
 robh@kernel.org, neil.armstrong@linaro.org, devicetree@vger.kernel.org
In-Reply-To: <20260910092038.48291-2-angelogioacchino.delregno@collabora.com>
References: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
 <20260910092038.48291-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:37:26 +0000
Message-Id: <20260910093727.0844A1F000FF@smtp.kernel.org>
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
- [High] The proposed PHY binding models the PHY as a standalone device wit=
h a `reg` region that overlaps the existing DP/eDP MAC controller, causing =
resource conflicts and breaking backward compatibility.
--

commit 4c8f0a6ba6ee74a2973e7591e070dd77de336be6
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

dt-bindings: phy: Document MT8195 and MT8196 DisplayPort PHYs

This commit adds bindings for the DisplayPort and Embedded DisplayPort PHYs
found in the MediaTek MT8195 and MT8196 SoCs. The PHY supports varying
impedance calibrations to reach an optimal EYE signal pattern.

> diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy=
.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.yaml
> @@ -0,0 +1,77 @@
[ ... ]
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8195-dp-phy
> +      - mediatek,mt8196-edp-phy
> +
> +  reg:
> +    maxItems: 1

[Severity: High]
Will this reg property overlap with the existing DP/eDP MAC controller?

If this new binding is implemented as a standalone device node, the PHY
driver (mtk_dp_phy_probe) and the DP driver (mtk_dp_dt_parse) will both
call devm_platform_ioremap_resource() on the same memory space.

Since the DP controller currently maps the entire 32KB region and the PHY
binding requires mapping the first 8KB, will they conflict when requesting
the memory region from iomem_resource?

It appears the second driver to probe would fail with -EBUSY, breaking
backward compatibility for display functionality.

[ ... ]
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy@1c500000 {
> +        compatible =3D "mediatek,mt8195-dp-phy";
> +        reg =3D <0x1c500000 0x2000>;

[Severity: High]
Does this example demonstrate mapping the PHY exactly where the existing
mediatek,mt8195-edp-tx device is mapped in older device trees?

If the device tree uses this newly documented PHY node layout, it seems a
regression would occur unconditionally during system boot due to the
conflicting memory regions.

> +        #phy-cells =3D <0>;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910092038.4829=
1-1-angelogioacchino.delregno@collabora.com?part=3D1
