Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7379C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3740C10E9AB;
	Mon, 13 Jul 2026 13:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JHknMkhP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 249E310E9AB
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:14:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9BEAB6004E;
 Mon, 13 Jul 2026 13:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A3A1F000E9;
 Mon, 13 Jul 2026 13:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783948441;
 bh=PRLHanZMxbEdUq6B1EYlA36V+3uPBczIeUx2vKsLZfQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JHknMkhPYcwdgoeZtKmaTjbZoGMg95r9f6GU2OWbt9M+0xo/wuxsLmIQCk/7UfDae
 XDJitCBGVLpjNCZ/SaLWNTC8k6DozhdNfFRl0J8cwim5k7kBVaUbzIyMUz+j83/RxE
 /1y6NwLtGvSaAQq62wdR0oEpjTt5aQf+rsvCKQ2jkfp1Nuglfjrhx6Zc7aubbFi8/x
 HfJCNQfnxSjLU73WiuEZxlb3afVwP6VAmiXKQsfF0Me40SskhyVJ+9uOF0jOplQu6P
 ejWWSU0798rkpyASwUixThlbxj+y5bXVZArXSYqQB6srsoVPxtLBTyw8ScCCtKrng7
 5QP/AiTgaf/QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] dt-bindings: display: mediatek: wdma: Add
 compatibles for more SoCs
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260713130103.34654-10-angelogioacchino.delregno@collabora.com>
References: <20260713130103.34654-1-angelogioacchino.delregno@collabora.com>
 <20260713130103.34654-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:14:00 +0000
Message-Id: <20260713131401.02A3A1F000E9@smtp.kernel.org>
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
 placed in the standalone `enum` block instead of the fallback `items` bloc=
k, which either prevents driver binding or fails schema validation.
--

--- Patch [9]: [PATCH v3 09/10] dt-bindings: display: mediatek: wdma: Add c=
ompatibles for more SoCs ---
commit c59d6955686a17afe19c1a5b4dee46c913103970
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

dt-bindings: display: mediatek: wdma: Add compatibles for more SoCs

This commit adds missing compatibles for Write DMA hardware on Dimensity
1200 and Kompanio 500/520/820/1200 SoCs.

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

[Severity: Medium]
Will this cause an issue for device trees trying to probe the mt6893 hardwa=
re?

Since this compatible string is placed in the standalone enum block instead
of the fallback items block, a device tree node providing only this string
will pass schema validation but fail to probe in the kernel, as the driver
only matches the mediatek,mt8173-disp-wdma fallback.

Conversely, if a device tree provides the necessary fallback string to
enable the driver to probe, it will fail schema validation because the
array of strings won't match this single-item enum block.=20

Should this be moved to the fallback items list below alongside the other
newly added SoC variants?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713130103.3465=
4-1-angelogioacchino.delregno@collabora.com?part=3D9
