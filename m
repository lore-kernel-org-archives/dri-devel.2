Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1DAC4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 03:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2938C10E05D;
	Sat, 18 Jul 2026 03:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vif4lhcf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5830E10E05D
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 03:19:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74B9360DC0;
 Sat, 18 Jul 2026 03:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCDC1F000E9;
 Sat, 18 Jul 2026 03:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784344759;
 bh=8hswH5SY+ol+rA06OBext9z9Ry74y5yrt8cC4kWViWI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vif4lhcfbkv1BZ1yRL34Ejr94OTSTKCcZuz1bbTWFo3rIOR4XKB6md34tcHHsGv5w
 FV3Mxu19pSftzbPjLE9pfxQyCXYUYL3u4JWPySkJEVsHbgZaaJLUkC+sEhEZymt8vN
 KdVg8SaUo/3OM/95oCxCBEaQcM4oDIN4Zw5qtcr3pFXUc+Ggy+NeKAG/bnMLTzC4zQ
 dANORh+wFHlEDNoeWtQJvUDfsRjAAhvFgMjy+J+t8Vq4W9MyqfoIRWF6Ciwdm7z985
 nuBdQy+3sFj0hfU+i9nEK25IAiTRsTjnAd6BkbCjviDy70zxdasACfvgISiO/eBax8
 ESLhGRy6G8T9g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/8] dt-bindings: npu: rockchip: add
 rockchip,rk3576-rknn-core
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260718031146.3368811-2-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
 <20260718031146.3368811-2-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 03:19:18 +0000
Message-Id: <20260718031918.DDCDC1F000E9@smtp.kernel.org>
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
- [Low] The schema allows `sram-supply` to be specified for RK3576 even tho=
ugh the hardware does not support it.
--

--- Patch [1]: [RFC PATCH v2 1/8] dt-bindings: npu: rockchip: add rockchip,=
rk3576-rknn-core ---
commit af7a16605153304ec36efac86040bd1175195ecd
Author: Jiaxing Hu <gahing@gahingwoo.com>

dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core

This commit documents the RK3576 NPU core by adding it to the compatible
enum. It also moves sram-supply from the globally required list to an
if-then block specifically for RK3588, as the RK3576 does not use it.

> diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-c=
ore.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.=
yaml
> index caca2a4903cd1..985cde6b2f523 100644
> --- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
> +++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml

[ ... ]

> @@ -75,7 +76,16 @@ required:
>    - resets
>    - reset-names
>    - npu-supply
> -  - sram-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3588-rknn-core
> +    then:
> +      required:
> +        - sram-supply

[Severity: Low]
Does this change inadvertently allow sram-supply to be specified for RK3576?

Because sram-supply is defined in the top-level properties block, removing
it from the global required list makes it implicitly optional for RK3576,
rather than forbidding it.

Device tree nodes for RK3576 could mistakenly include sram-supply without
triggering a validation error during dt_binding_check.

Would it be appropriate to add an else block setting sram-supply: false to
fully restrict it?

>  additionalProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718031146.3368=
811-1-gahing@gahingwoo.com?part=3D1
