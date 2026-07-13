Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1037AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4689010EA07;
	Mon, 13 Jul 2026 14:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S1dWm8LZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE9C910EA07
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 14:42:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9780A40A43;
 Mon, 13 Jul 2026 14:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4F91F00A3A;
 Mon, 13 Jul 2026 14:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783953741;
 bh=Ndyus4C5pLtwG8sU+06pp+DBs92OiWXZdXuF0XPFvvw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S1dWm8LZN1Od1U2Oxen5xddFLVClqI2e+Kk5+TMw64VwxbIyWTtViLqLfX34L2LiN
 R/1YkvtPgaoNVB8ovY5OlU/ZMuCJzihfaXPmODmeC7Nqh1LKqcoonR00Hx0FtuP/qH
 mECmGD9fAmQMEDEVKJWT+UTKWasqwP1WjjlY8OtY6/CqJL18qvhknPDMNaLhpGqWcm
 HKFhrRAJeS799rCEnACAeqy6e01SerAI7VdKz7w3ZvRyjN642gCyGvXcoHFT9za2xe
 8Xu9bTdEYoT3RGMlX9iwJk5CcBpzPXSFe1J0+/tA8a9BJbbX8K613u43kO+p7S+Er4
 HMN+nlwpJn9Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] dt-bindings: display: mediatek: wdma: Add
 compatibles for more SoCs
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260713142746.40259-10-angelogioacchino.delregno@collabora.com>
References: <20260713142746.40259-1-angelogioacchino.delregno@collabora.com>
 <20260713142746.40259-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 14:42:20 +0000
Message-Id: <20260713144221.2C4F91F00A3A@smtp.kernel.org>
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
- [Medium] The compatible string `mediatek,mt6893-disp-wdma` is incorrectly=
 added to the standalone enum instead of the fallback items list.
--

--- Patch [9]: [PATCH v4 09/10] dt-bindings: display: mediatek: wdma: Add c=
ompatibles for more SoCs ---
commit 8001f83833ae9c684be67bc719c7aaa056f90763
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

dt-bindings: display: mediatek: wdma: Add compatibles for more SoCs

Multiple MediaTek SoCs have the Write DMA hardware in their Display
Controller. This commit adds the missing compatibles for Dimensity 1200
(MT6893) and for Kompanio 500/520/820/1200.

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
Does this incorrectly place mediatek,mt6893-disp-wdma as a standalone
compatible string rather than in the items list requiring a fallback?

If a device tree uses compatible =3D "mediatek,mt6893-disp-wdma" to satisfy
this schema, the DRM driver will not probe the device since it only matches
mediatek,mt8173-disp-wdma. If the developer instead provides the fallback=20
compatible =3D "mediatek,mt6893-disp-wdma", "mediatek,mt8173-disp-wdma" so =
the
driver can probe it, won't the device tree fail schema validation here?

>               - mediatek,mt8173-disp-wdma
>           - items:
>               - enum:
>                   - mediatek,mt6795-disp-wdma
>                   - mediatek,mt8167-disp-wdma
> +              - mediatek,mt8183-disp-wdma
> +              - mediatek,mt8186-disp-wdma
> +              - mediatek,mt8192-disp-wdma
> +              - mediatek,mt8195-disp-wdma
>               - const: mediatek,mt8173-disp-wdma

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713142746.4025=
9-1-angelogioacchino.delregno@collabora.com?part=3D9
