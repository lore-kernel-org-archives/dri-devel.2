Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10783C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A1F810E39C;
	Tue, 21 Jul 2026 18:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kqc4k9xf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6423110E39C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:26:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1DD2601DE;
 Tue, 21 Jul 2026 18:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DA01F00A3D;
 Tue, 21 Jul 2026 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784658381;
 bh=oooanRceJQzIxh5KK5RDrxpR9VKaAnVoPG4PFRbbjXM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kqc4k9xfhrUL0CTRTex5YJqGBB2hdN2HBWBn79rgBwrRCCrPS4TBh1JUCYtxJ/rv+
 bGjnWlOTBGIcbmzWWCzTZSuIh7PjRKy148GvANZwwTjhCcV/4TURWPrYIW1xayhq2A
 3baTWBYR/VIUNqon28oHcmpqxQf4yaDJNnJ8+q7PY2Y9RU20IDWZpmTBOglFxFxzrw
 g1xu+gB8o5wufgzM+A+vp/z3IHbp38UmIaMoPzth03fZeEyUMnZ+M/UZ5vNaC0yLHs
 53tnj4Y9i20jfR7LNYYMJmtevvvuaqO3WSPQ0UB4ErR9jHcHdOj4zYlb3Is9NM02lw
 9rTm71ay5Yo9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] dt-bindings: display: rockchip: dw-dp: Fix
 sound DAI cells
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260721-synopsys-dw-dp-improvements-v4-9-f0f4a4ede712@collabora.com>
References: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
 <20260721-synopsys-dw-dp-improvements-v4-9-f0f4a4ede712@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 18:26:20 +0000
Message-Id: <20260721182621.13DA01F00A3D@smtp.kernel.org>
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
- [Medium] Unconditional ABI breakage of `#sound-dai-cells` in Device Tree =
binding.
--

--- Patch [9]: [PATCH v4 09/10] dt-bindings: display: rockchip: dw-dp: Fix =
sound DAI cells ---
commit 3829785f7403edd4d5c1e524c76b4c78f5cf26da
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

dt-bindings: display: rockchip: dw-dp: Fix sound DAI cells

This commit updates the rockchip dw-dp binding to change #sound-dai-cells
from 0 to 1, allowing the selection between I2S and S/PDIF. The example is
also updated to reflect this new required cell count.

> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,=
dw-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw=
-dp.yaml
> index 2b0d9e23e9432..c4f8959dd65da 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.y=
aml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.y=
aml
[ ... ]
> @@ -83,7 +83,8 @@ properties:
>      maxItems: 1
> =20
>    "#sound-dai-cells":
> -    const: 0
> +    const: 1
> +    description: 0 for I2S, 1 for S/PDIF

[Severity: Medium]
Will this unconditional constraint change cause a regression by breaking
Device Tree ABI backward compatibility?

Existing in-tree device trees such as
arch/arm64/boot/dts/rockchip/rk3588-base.dtsi still define the property with
0 cells:

arch/arm64/boot/dts/rockchip/rk3588-base.dtsi:dp0 {
	...
	resets =3D <&cru SRST_DP0>;
	#sound-dai-cells =3D <0>;
	status =3D "disabled";
}

A similar definition exists in
arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi for dp1.

Could this update lead to immediate dtbs_check validation failures and break
audio initialization for users booting with older, previously valid DTBs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-synopsys-d=
w-dp-improvements-v4-0-f0f4a4ede712@collabora.com?part=3D9
