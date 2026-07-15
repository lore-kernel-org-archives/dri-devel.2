Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C64C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9609E10F023;
	Wed, 15 Jul 2026 12:16:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DyE6rBTz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC79510F023
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:15:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 64BCE40F4C;
 Wed, 15 Jul 2026 12:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103AE1F000E9;
 Wed, 15 Jul 2026 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784117753;
 bh=W6xl1HFy97nB07pNNhO40/DXz/pokBvQDkFWNqUQ5wA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DyE6rBTzF+riTV7T0NSwSHtGbatOo8D1mBm4ihYfoXzSCQTIEGMe0D/va1JDKNNWa
 JI5Rk1+WSs+Oln0g3tICJy/GwmGDWHmEF2YXBIBctMhWyT4+A//AJiFZXQ1WQ1/H3a
 HfovahLqYwCudB53WNCFlmS3RbQm7WuzO4iyKxbsqThL5ALplOUNRobjpaPakBCWtZ
 XqTuf+t0Wak+GEfatNVZ7i5LUI1vjIy3yEIWNLtTH9+rUml1Ay6ouYFt2iGYIS0BOo
 y9n7UDj0p6alrgcgdU2nr3bsP2ePcUwEdMHqecXR/2xWWxuz+fCfHTONHJf3Nm8p0/
 dAYWvz0qTACFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/11] dt-bindings: display: mediatek: wdma: Add
 compatibles for more SoCs
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260715114916.19690-11-angelogioacchino.delregno@collabora.com>
References: <20260715114916.19690-1-angelogioacchino.delregno@collabora.com>
 <20260715114916.19690-11-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 12:15:52 +0000
Message-Id: <20260715121553.103AE1F000E9@smtp.kernel.org>
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
- [Medium] Inconsistent compatibility fallback for 64-bit SoCs (MT8192/MT81=
95) violating hardware constraints described in the commit.
--

--- Patch [10]: [PATCH v5 10/11] dt-bindings: display: mediatek: wdma: Add =
compatibles for more SoCs ---
commit ffb6d1b73de2ee2d9fba381dca064a6d8fef7acf
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

dt-bindings: display: mediatek: wdma: Add compatibles for more SoCs

This commit adds missing compatibles for the Write DMA hardware in the
Display Controller for Dimensity 1200 (MT6893) and Kompanio
500/520/820/1200 (MT8183/MT8186/MT8192/MT8195).

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

[Severity: Medium]
The commit message explicitly excludes MT6893 from falling back to
MT8173 because it introduces support for destination addresses larger
than 32 bits. Should this same rule apply to MT8192 and MT8195?

Since MT8195 (Kompanio 1200) and MT6893 (Dimensity 1200) are the same
generation of SoCs sharing the same IP, grouping MT8192 and MT8195 here
implies they can safely fall back to the legacy 32-bit driver.=20

If an OS binds a legacy 32-bit driver to the MT8195 WDMA using this
fallback, won't it misprogram the DMA addresses by truncating them to 32
bits when attempting a DMA operation above 4GB?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715114916.1969=
0-1-angelogioacchino.delregno@collabora.com?part=3D10
