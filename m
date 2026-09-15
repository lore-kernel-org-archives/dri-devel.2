Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BF8C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A7110FB30;
	Tue, 15 Sep 2026 08:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="afOQ7FnA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09FAC10F35C
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:57:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A930443A08;
 Tue, 15 Sep 2026 08:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4421F000FF;
 Tue, 15 Sep 2026 08:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789462625;
 bh=JfTSHi+Nv6zPc8um5FBAk5XspUmAQX4Uqkbl5zoxT10=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=afOQ7FnAHNLbffgbW8nPv0GTXFfaqsl5Xl7L9owviAv3N4U1Hb5mF1gqVP8pEb5Uy
 xN8MxUH3xYxRlekKZRQGhU3of4XPVXo8mhTmwN5DZULI7kmEtK78H2tFS/YEwqCnvs
 6mI9uPxwFe3lJKjzMbITC/Nsvld+WqpQckFsIttMuFbc0qiwMldgxsJ862e7ndjFW+
 AzurpUvSiQYoiMzKcw1s3NfcohFRhNJC6GxLgJUVvPPhsohjhbURAaZO44lCYlcmGJ
 S+ZVpZS3XR8NYmDalAZBXgFSY3dT9DBEyXwF/XUaaF5QSOfsQujSUpErgVWguXGRW4
 qAbTUI49D+s5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/13] dt-bindings: display: mediatek: wdma: Add
 compatibles for more SoCs
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260915084148.11385-13-angelogioacchino.delregno@collabora.com>
References: <20260915084148.11385-1-angelogioacchino.delregno@collabora.com>
 <20260915084148.11385-13-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 08:57:04 +0000
Message-Id: <20260915085705.3E4421F000FF@smtp.kernel.org>
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
- [High] dt-bindings: mtk-wdma: incorrect mt8173 fallback for 34-bit IOVA S=
oCs
--

commit 9abef195ff9795774aad1384f098d2674d2e411c
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

dt-bindings: display: mediatek: wdma: Add compatibles for more SoCs

This commit adds missing device tree compatible strings for the Write DMA
hardware in multiple MediaTek SoCs, including MT6893, MT8183, MT8186, MT819=
2,
and MT8195. It also specifies that MT6893 is not compatible with MT8173 due
to its introduction of destination addresses larger than 32 bits.

> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
wdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdm=
a.yaml
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.ya=
ml
> @@ -22,11 +22,16 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - mediatek,mt6893-disp-wdma
>            - mediatek,mt8173-disp-wdma
>        - items:
>            - enum:
>                - mediatek,mt6795-disp-wdma
>                - mediatek,mt8167-disp-wdma
> +              - mediatek,mt8183-disp-wdma
> +              - mediatek,mt8186-disp-wdma
> +              - mediatek,mt8192-disp-wdma
> +              - mediatek,mt8195-disp-wdma
>            - const: mediatek,mt8173-disp-wdma

[Severity: High]
Does using the mediatek,mt8173-disp-wdma fallback for these newer SoCs risk
silent DMA memory corruption or IOMMU translation faults when writing to
addresses above 4GB?

The WDMA hardware in MT8186, MT8192, and MT8195 uses 34-bit IOVA spaces,
which is indicated by the IOVA_34_EN flag in their IOMMU platform data.

When the DRM writeback driver configures the WDMA, it will be handed 34-bit
dma_addr_t addresses. Because the schema specifies the MT8173 fallback, the
driver binds using the MT8173 match data.

Since MT8173 only supports 32-bit addresses, its driver data configures
reg_wdma_dst_addr0_msb =3D 0. This causes the driver to write only the lower
32 bits of the destination address, silently dropping the upper 2 bits of t=
he
34-bit IOVA during normal display writeback operations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915084148.1138=
5-1-angelogioacchino.delregno@collabora.com?part=3D12
