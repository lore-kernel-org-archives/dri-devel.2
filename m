Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684A7C5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 11:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99AE610E36C;
	Sun, 23 Aug 2026 11:28:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OKk2OoGT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6465B10E36C
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 11:28:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6FC342DB2;
 Sun, 23 Aug 2026 11:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896AE1F000E9;
 Sun, 23 Aug 2026 11:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787484494;
 bh=sVA2nTFwdB9AbrUROrsDttAGxu4oSLrIWqtGBp1hayE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OKk2OoGTrrPN7kHGYt5ZX+1YzMm7FjQ38XkFWlrsuZtCFQjNJBBxUfY672ERRGR0s
 ayJzD2VgONWsr9XWVawU1gA/hllVNRwpDZ399aioGuO64btFjl9OSjAy1hleIEU/Da
 tMuCa26RMfGhtnfLJ1OmNLKUWj6GSUC1ZVBrPCHFiuxayWzsIl/EUlKtsGKMqInTUo
 AXxNGJw6ZvRScKWhVbqQr1v0snQ4/6Te2DeNVAx1HCx733rB8I33vLbW+M0YioNk7G
 q09b10no3hswUomAPfituYjuhdWoi52aNFU7WFZ7caf5PGEve7XJk+NcxN6jfWCOHP
 9vk+/g1lAyR7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260823111959.17029-2-amit.barzilai22@gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-2-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 11:28:14 +0000
Message-Id: <20260823112814.896AE1F000E9@smtp.kernel.org>
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
- [Low] The binding is missing controller-specific default values for `solo=
mon,width` and `solomon,height`.
--

--- Patch [1]: [PATCH v5 1/6] dt-bindings: display: Add Solomon SSD1351 OLE=
D controller ---
commit c53d1459d9817dd8adf46b673b2d950a10a1775b
Author: Amit Barzilai <amit.barzilai22@gmail.com>

dt-bindings: display: Add Solomon SSD1351 OLED controller

This commit adds a device tree binding for the Solomon SSD1351 128x128
65k-color RGB OLED display controller. It leverages the shared
solomon,ssd-common.yaml properties used by other Solomon display controller=
s.

> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1351.ya=
ml b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
> new file mode 100644
> index 0000000000000..80850c2ab5b3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
[ ... ]
> +allOf:
> +  - $ref: solomon,ssd-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - solomon,ssd1351

[Severity: Low]
Should this properties block also declare default values for solomon,width
and solomon,height?

Other bindings that include solomon,ssd-common.yaml, such as
solomon,ssd133x.yaml, establish default geometry values for their specific
compatible strings in this block. Without these default values, device trees
that omit the width and height properties will lack a schema-defined default
geometry.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823111959.1702=
9-1-amit.barzilai22@gmail.com?part=3D1
