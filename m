Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA84C55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A94B010F38E;
	Fri, 31 Jul 2026 18:37:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IBqZHmAW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92A0210F38E
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 18:37:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 40A6A42E9A;
 Fri, 31 Jul 2026 18:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36FF1F00AC4;
 Fri, 31 Jul 2026 18:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785523024;
 bh=hFIVwkrTyDRg4x5IaouxNGVMHZXSfiHwFsR7n5YIZe0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IBqZHmAWUCaF7inEo89rQmIHOfqZriV3iAgYdZEXe6WfxdfFvhkVkDRynKEffUqJt
 kML2HCkYIx5/9C0y2A7Y6H66g/e9vf0sd93RAsUOFe33nG2UZAiATwt+urVEtkufVp
 b70LWq+oopvdQ6o5IkaN9jWc03UCO+VFheidK8heJSCdHNWCQt71q3FhjGWFKpLeBE
 Ue5jXTOQ2CH5GW1x5pHsIXLD+b4gQ4CijjQOgzPTic9Rdi7zo3YMaWowAqoqmxT0Jn
 jTkdcX0K0zAyhWb9RRUioeKhCSr0QzRHPhsElQDkmO2LNa/D+rDUepULXyP3LFL4ED
 E8cw7aEs2cS3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 20/21] dt-bindings: display: rockchip: dw-dp: Fix
 sound DAI cells
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-20-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
 <20260731-synopsys-dw-dp-improvements-v8-20-ac1e6a75782f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:37:03 +0000
Message-Id: <20260731183703.D36FF1F00AC4@smtp.kernel.org>
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
- [Low] Changing `#sound-dai-cells` to `const: 1` without updating in-tree =
DTS files in the same series breaks `dtbs_check` bisectability.
--

--- Patch [20]: [PATCH v8 20/21] dt-bindings: display: rockchip: dw-dp: Fix=
 sound DAI cells ---
commit afb955faffe4407ec88a5c35c168c8dd82310361
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

dt-bindings: display: rockchip: dw-dp: Fix sound DAI cells

This commit updates the #sound-dai-cells property for the Rockchip dw-dp
controllers from 0 to 1 to allow selecting between I2S and S/PDIF interface=
s.
It anticipates future Multi Stream Transport (MST) support where additional
numbers will identify both the interface and the stream.

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

[Severity: Low]
Does this change break dtbs_check bisectability for RK3588 boards?

The commit message mentions that the mainline rk3588 DTS include sets this
to 0 and will be fixed up separately. If the in-tree DTS files (such as
arch/arm64/boot/dts/rockchip/rk3588-base.dtsi) are not updated in the same
patch series, make dtbs_check will fail on those boards during a bisect
until the separate fix is applied.

> +    description: 0 for I2S, 1 for S/PDIF
> =20
>  required:
>    - compatible

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-synopsys-d=
w-dp-improvements-v8-0-ac1e6a75782f@collabora.com?part=3D20
