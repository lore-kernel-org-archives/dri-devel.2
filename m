Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CD5C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28F010F3F3;
	Fri, 18 Sep 2026 14:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CsbE37Ak";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A19010F3F3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:51:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1AE8602C5;
 Fri, 18 Sep 2026 14:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087EA1F000FF;
 Fri, 18 Sep 2026 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789743086;
 bh=z9LZYGN3YMatQEVOW4MX/OzIOZm3uPhV2mvS5GCfi14=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CsbE37AkdtAD30bL3mdPfer9NGUvdcetWbAddRI4d0KAmfFG3zcxBDUoV9cL0sUmB
 WXWnNXahFkVDIgzzUIIQv5Nw2UaH08fgpz8kJPT7wPaZUl8k6MZCsDx6hXd4mT95Bf
 N7s0QetpnljOAEsIctGXUgvrtSuhvzayCCvwtUaA2rJ/7YrOJNwNVjg5sE/gBkr5wo
 8kDQUcJQgjHMcJcdJvYSo2BwNfTb0y/Xm5J8X9ZQ2OAd42u/r2RZE7jliqYuWYHIsx
 J9VQk8/mmLAy+jrUNt4aK1qVcy5SRuPaskAm9nETXbqVf4y2iEeIs2eMWcIiWsaO0j
 gO6sFZp2ptYzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: Add Novatek NT37705
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260918-fp6-panel-v2-1-6695c4008920@fairphone.com>
References: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
 <20260918-fp6-panel-v2-1-6695c4008920@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:51:25 +0000
Message-Id: <20260918145126.087EA1F000FF@smtp.kernel.org>
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
- [Medium] dt-bindings: loose compatible schema allows undocumented strings=
 and omits IC fallback
--

commit df95ba2aa44d396fccc370e5b084b78edf5052e8
Author: Luca Weiss <luca.weiss@fairphone.com>

dt-bindings: display: panel: Add Novatek NT37705

This commit adds a new device tree binding for the Novatek NT37705, a
display driver IC for AMOLED DSI panels. It also describes the BOE
BJ631JHM-T71-D900 panel used in the Fairphone Gen. 6.

Link: https://lore.kernel.org/r/81a3c207-4d8f-490f-8e2a-6f3f4c2acd35@kernel=
.org/

> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37=
705.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.=
yaml
> new file mode 100644
> index 0000000000000..1c796599f6fce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/novatek,nt37705.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT37705-based DSI display panels
> +
> +maintainers:
> +  - Luca Weiss <luca.weiss@fairphone.com>
> +
> +description:
> +  The Novatek NT37705 is a generic DSI Panel IC used to control AMOLED p=
anels.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: boe,bj631jhm-t71-d900

[Severity: Medium]
Will this loose containment check in properties.compatible allow undocument=
ed
strings to silently pass validation?=20

In dt-schema, the contains keyword only verifies that at least one item
matches the constraint, without restricting the presence, length, or content
of additional items in the array. Consequently, a poorly crafted device tree
node with compatible =3D "undocumented-garbage", "boe,bj631jhm-t71-d900"; w=
ill
silently pass validation, defeating strict schema checking.

Specific panel strings should be constrained with an exact match (e.g., con=
st
or enum), or an items array if fallbacks are used.

Additionally, standard practice for generic panel ICs is to include a gener=
ic
fallback string. Should the novatek,nt37705 fallback be included here?
For example:=20
items: [ enum: [ boe,bj631jhm-t71-d900 ], const: novatek,nt37705 ]

The generic string novatek,nt37705 mentioned in the schema description is
completely missing from the schema definition and the example.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-fp6-panel-=
v2-0-6695c4008920@fairphone.com?part=3D1
