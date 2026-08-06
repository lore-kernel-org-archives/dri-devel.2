Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B526EC56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D34510E379;
	Thu,  6 Aug 2026 17:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hnNd2NY4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3143010E379
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:40:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D1664413AB;
 Thu,  6 Aug 2026 17:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668AB1F000E9;
 Thu,  6 Aug 2026 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786038000;
 bh=HNbJ2lDAXNy6h9hE+GS0iEj13vS1uo9+AAkvbEu546A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hnNd2NY4NmmA/iSY/jqizmaMibLPoW7TEVNRXo2UErvBtH4nkQbDmhsNT+9t5gYbc
 fvWGQo+huVhlUmIyuX3oRfV06OwUqmxKrU5EPxHnksSSmkV02iH+CnXVojC57XHL/3
 6bwfb6O7QY98D4QqtO1ZG0b0lDHrEOkokVo53+IyJL7ryJYZ9zPHYDH3zmpyY60ySG
 4JRU2eI0Fi6crTBr4QH587ZTFm1+hZ1L8DmaI7R2TV9WIPOxO0LzdAzRC7fZdQyVzW
 +KocwPqaC4S8JVzdFx2hs4CG2qUTeXQ9J6Kj8eEuQQNdIOlYi9v6ZwrNPhX5YSz7gB
 FLNGJAFBHfh7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 20/21] dt-bindings: display: rockchip: dw-dp: Fix
 sound DAI cells
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-20-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v11-20-0d508505f383@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:39:59 +0000
Message-Id: <20260806174000.668AB1F000E9@smtp.kernel.org>
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
- [Medium] Device Tree schema validation breakage for existing `rockchip,rk=
3588-dp` configurations.
--

--- Patch [20]: [PATCH v11 20/21] dt-bindings: display: rockchip: dw-dp: Fi=
x sound DAI cells ---
commit 2c15bbfcf4dec184872abdf4c2e06063a52d1e2f
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

dt-bindings: display: rockchip: dw-dp: Fix sound DAI cells

The RK3588 and RK3576 DesignWare DisplayPort controllers both have two
possible DAI interfaces: I2S and S/PDIF. Thus an argument is needed to
to select the right interface.

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
Will this strict constraint update cause make dtbs_check validation to
fail for existing in-tree device trees?

The mainline arch/arm64/boot/dts/rockchip/rk3588-base.dtsi still defines
#sound-dai-cells =3D <0>; for DP nodes.

While the commit message notes this breakage is intentional and will be
fixed up separately, could changing the schema without the accompanying
DTS updates cause automated CI validation failures and break bisectability?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v11-0-0d508505f383@collabora.com?part=3D20
