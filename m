Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1BAC4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C3410F53F;
	Fri, 17 Jul 2026 12:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BAAstyqs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4348D10F53F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:28:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DF68F4128A;
 Fri, 17 Jul 2026 12:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693211F000E9;
 Fri, 17 Jul 2026 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784291288;
 bh=mLUhEODnpqoOCbWwLaXeT4x8ON01RupU/xxbO4MV1LE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BAAstyqs33CZc4v/2JHllCtggkNKz0uQSvIGuZJanBZn+0vmKqrDXWjKJF3yEARNe
 AXMEWG3oh0lDGEL6gjnlvpXe0HSTlr4MrTYj5jdmuEK1k0sIAxVwVAnQGCNsfzcjq0
 4I3FIjvosJmfP1+LCDlWqWwN9pOGR2k/KKA5grcBHPiTP64CgROYpBibVcB8T+zhOM
 YIiyqdQwmMO3NpWwAHaade4fQIyq83ONCUOWYv16MkvTaHW5jh81BdQ7DxOIVpGJTk
 ykhnklu5JuJ8wDeOr1viPrgv9LXHg9kTAqI5SNP+8V7SqTqd1JvRTK7WIs4QWXpT8R
 1oI1fDDZ8eqBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: lcdif: Add interface pixel format
To: "Francesco Dolcini" <francesco@dolcini.it>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, conor+dt@kernel.org,
 imx@lists.linux.dev
In-Reply-To: <20260717121847.488148-2-francesco@dolcini.it>
References: <20260717121847.488148-1-francesco@dolcini.it>
 <20260717121847.488148-2-francesco@dolcini.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 12:28:07 +0000
Message-Id: <20260717122808.693211F000E9@smtp.kernel.org>
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
- [Low] Introduction of the legacy, non-standard `interface-pix-fmt` proper=
ty for a standard hardware concept (parallel bus width), violating modern D=
T principles.
--

--- Patch [1]: [PATCH v1 1/4] dt-bindings: lcdif: Add interface pixel forma=
t ---
commit 7225ea545d2ff50540972dd75d375b8ecea4f315
Author: Francesco Dolcini <francesco.dolcini@toradex.com>

dt-bindings: lcdif: Add interface pixel format

This commit updates the fsl,lcdif device tree binding to support the
interface-pix-fmt property. The property is used to describe the hardware's
parallel data bus transfer width to match board wiring and prevent shifted
colors.

> diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/D=
ocumentation/devicetree/bindings/display/fsl,lcdif.yaml
> index 2dd0411ec6516..209ee5a96e393 100644
> --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> @@ -58,6 +58,13 @@ properties:
>      items:
>        - const: rx
> =20
> +  interface-pix-fmt:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - rgb24
> +      - rgb565
> +      - rgb666

[Severity: Low]
Is this introducing a legacy, non-standard property into the new schema ABI=
?=20

Standard devicetree guidelines usually prefer endpoint properties like
bus-width (defined in video-interfaces.yaml) to describe physical parallel
data line configurations, such as setting bus-width =3D <18> for RGB666.

If a custom property is strictly necessary here rather than using the stand=
ard
endpoint properties, does this require a vendor prefix like
fsl,interface-pix-fmt to comply with modern devicetree naming conventions?

> +
>    interrupts:
>      items:
>        - description: LCDIF DMA interrupt

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717121847.4881=
48-1-francesco@dolcini.it?part=3D1
