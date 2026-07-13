Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C00C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCFB10E8DD;
	Mon, 13 Jul 2026 10:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D4zAOOJp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E0E110E5BE
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:23:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DBE2743B9D;
 Mon, 13 Jul 2026 10:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B961F000E9;
 Mon, 13 Jul 2026 10:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783938183;
 bh=O4pFbY3sHD35vNUh03hA6PVgcanumjvglL4prHYJS54=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D4zAOOJpJ3HRzS6StXQSWrN4sBtu6+4EhL6/CGoLj1oeOW244nKM5SnQ3KMxyajVz
 reCAMlJCBqO1B+JcIzFiVqZlpu6NEksG882AbktSH9hAtY8FSzX2ATper5nPFhYiis
 ktE4CdvEnoWp0G7dJWYf+qsaikrkj27GacBZrla8fr/1dqvx7oziAmQZjgTNXSlncH
 bwVrzBwGSCIE1nbodKTebh+O+j9bS3E8m0n7f+zL3zVVtwrIYpcXGcijCsDzjj5J0r
 1uqfgr6QGiMxO/NDJoZg9DinqKh4RmVEE7xpSn9N2JFDqx/X+006GyZ/FSKFErMVR+
 NuRc4jBntJVSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] dt-bindings: display: mediatek: wdma: Add
 compatibles for more SoCs
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260713095837.16590-10-angelogioacchino.delregno@collabora.com>
References: <20260713095837.16590-1-angelogioacchino.delregno@collabora.com>
 <20260713095837.16590-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:23:03 +0000
Message-Id: <20260713102303.71B961F000E9@smtp.kernel.org>
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
- [Medium] The mediatek,mt6893-disp-wdma compatible string is incorrectly p=
laced in the standalone enum block, preventing it from using the mediatek,m=
t8173-disp-wdma fallback.
--

--- Patch [9]: [PATCH v2 09/10] dt-bindings: display: mediatek: wdma: Add c=
ompatibles for more SoCs ---
commit f57f0fa27efb2b4a343645baf41ff18e654a1717
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

dt-bindings: display: mediatek: wdma: Add compatibles for more SoCs

This commit adds missing device tree compatible strings for the Write DMA
hardware on several MediaTek SoCs. It specifically targets the Dimensity 12=
00
and the Kompanio 500/520/820/1200 series.

> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
wdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdm=
a.yaml
> index 97d052b0fb614..c3ed867d058d9 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.ya=
ml
> @@ -22,11 +22,16 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - mediatek,mt6893-disp-wdma

[Severity: Medium]
Is mediatek,mt6893-disp-wdma incorrectly placed in this standalone enum blo=
ck?

Placing it here prevents it from using the mediatek,mt8173-disp-wdma
fallback string. Because the MediaTek DRM driver only matches
mediatek,mt8173-disp-wdma, Device Trees for the MT6893 will either break
driver probing if they follow this schema strictly, or fail validation
if they include the fallback string to allow the driver to probe.

Should this compatible string be placed in the items block below with the
other SoCs instead?

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713095837.1659=
0-1-angelogioacchino.delregno@collabora.com?part=3D9
