Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2110606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UicikaNG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD13410E3A2;
	Sun,  1 Nov 2026 08:37:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0683E10E1F8
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 08:37:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0681402EC;
 Sun,  1 Nov 2026 08:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2371F000C1;
 Sun,  1 Nov 2026 08:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793522263;
 bh=s8ynbOzbDYPDsC94LHqxD8cYq8ZNmPgFJ74SCas7Q/k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UicikaNGfHPT6G95+Zo2yjTvS2h51KZ8Mfo8nZERNV50WTXmuOfBmtqVEvzjhPvFJ
 XUWAU8X/rQH8mOKU9kFRSyyjxV7qVGniygWS9CjVouueZ2JD3w9L2vn5BI+qYkr/Kf
 cOZZf2LHH26zXCyXH88rNvZ9nB/HcSALz12GS0XnwCYdE4bEgRWqFQ5J1d9eJpTW8E
 Wm4wU2KHKjmuL2Qdjp94GjoUc75J72+LMie+lQN4Yf5YU1ukZrkMxzFzGpWBYbfa2F
 RIXa5iXOM1QPbveprycrLwTC8llK4EnScICc9n0mlTZFfTMdIxJJWxXq2M2wx32nbQ
 GyTxRLv3RSfww==
Message-ID: <sashiko-outbox-192335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 06/15] dt-bindings: npu: rockchip: add rockchip,
 rk3576-rknn-core
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261101082307.151957-7-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-7-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 08:37:42 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: npu: rockchip: unwieldy per-compatible if-then-else in=
 rknn-core
--

commit 64ea8c4aa2d26a009304ed33c9932abdd0a2a97d
Author: Jiaxing Hu <gahing@gahingwoo.com>

dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core

This commit adds the rockchip,rk3576-rknn-core compatible to
rockchip,rk3588-rknn-core.yaml, widening the top-level resource properties
and constraining each SoC variant with an if-then-else block under allOf.

> diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-c=
ore.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.=
yaml
> index caca2a4903cd1..3b611b64c8aa0 100644
> --- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
> +++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml

[ ... ]

> @@ -75,7 +83,40 @@ required:
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
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          maxItems: 4
> +        power-domains:
> +          maxItems: 1
> +        resets:
> +          minItems: 2
> +        reset-names:
> +          minItems: 2
> +      required:
> +        - sram-supply
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 6
> +        clock-names:
> +          minItems: 6
> +        power-domains:
> +          minItems: 2
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          maxItems: 1
> +        sram-supply: false

[Severity: Low]
This isn't a bug, but adding rockchip,rk3576-rknn-core to
rockchip,rk3588-rknn-core.yaml requires loosening the top-level definitions=
 of
clocks, clock-names, power-domains, resets, reset-names, and required, and
then overriding all six properties in the allOf if-then-else block.

Since the two variants differ across most of their resource properties, wou=
ld
it be cleaner to split rockchip,rk3576-rknn-core into its own binding schema
document rather than adding these per-compatible conditionals?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101082307.1519=
57-1-gahing@gahingwoo.com?part=3D6
