Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4055DC4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 14:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DEE210E3FB;
	Sat, 18 Jul 2026 14:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nQybqVIz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9420D10E3FB
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:57:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 08FCF41616;
 Sat, 18 Jul 2026 14:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A941F000E9;
 Sat, 18 Jul 2026 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784386644;
 bh=vyTY3vQSB0rzSa7WAqI8qrO3ZogMSS+KqYJ+pxkPEig=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nQybqVIzAInc/U70UO4eh4FcS2qe830ZYC2iA9rtew3cqqZKi3sYSG5c53QQ27rSW
 fGgDlJH/3l+UVAYpJ2zJpGYa8x868A4eCEMgsGPcwaIiHOidWfq/BubmXx3jx+9Rv6
 aCVQgtIV4Aa8X0bL1Fb1wQp/j5SAuNNqFDcTrwNDMZbB2lF3/N1KRz/8h4UpPpOniQ
 UmcvKlks3690AQ2xw4x794snH3+5F60YtDYEUkBpIDbPEguDkTEVeOgLtQieChtx13
 1r/eCRw7TtgNd1boZgJc/YKG59vo1BhWxea3esfYYm02jyosNW/p5hKfjGmYpjn9AB
 tXuDipM7A4HZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: display: lcdif: Allow display0
 child node for i.MX6UL
To: Frank.Li@oss.nxp.com
Cc: devicetree@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260718-arm_dts_ldb-v2-3-f5669571aa2b@nxp.com>
References: <20260718-arm_dts_ldb-v2-0-f5669571aa2b@nxp.com>
 <20260718-arm_dts_ldb-v2-3-f5669571aa2b@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 14:57:23 +0000
Message-Id: <20260718145724.75A941F000E9@smtp.kernel.org>
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
- [Medium] Undocumented Schema Relaxation: The commit message claims to onl=
y allow the `display0` child node, but the patch also removes the requireme=
nt for the `port` node and allows multiple legacy properties (`display`, `l=
cd-supply`, `dmas`, `dma-names`) for `fsl,imx6ul-lcdif`. The explanation fo=
r these additional relaxations was placed below the `---` separator, meanin=
g it will be lost from the permanent git history when the patch is applied.
--

--- Patch [3]: [PATCH v2 3/4] dt-bindings: display: lcdif: Allow display0 c=
hild node for i.MX6UL ---
commit 0235ccaa0f6772b41fe4b752e56f626d79d4d469
Author: Frank Li <Frank.Li@nxp.com>

dt-bindings: display: lcdif: Allow display0 child node for i.MX6UL

This commit updates the binding schema to allow the display0 child node
for fsl,imx6ul-lcdif to resolve a CHECK_DTBS warning.

> diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/D=
ocumentation/devicetree/bindings/display/fsl,lcdif.yaml
> index 2dd0411ec6516..2b123ddf06841 100644
> --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> @@ -182,6 +182,7 @@ allOf:
>              contains:
>                enum:
>                  - fsl,imx28-lcdif
> +                - fsl,imx6ul-lcdif
>      then:
>        properties:
>          dmas: false

[Severity: Medium]
Does this change do more than just allow the display0 child node mentioned
in the commit message?

By adding fsl,imx6ul-lcdif to this exclusion list, it skips the block that
previously disabled legacy properties. This removes the requirement for the
port node and allows multiple legacy properties (display, lcd-supply, dmas,
dma-names).

The explanation for this was placed below the --- separator in the patch:

"sashiko report problem and allow dma/dma-names for i.MX6ul. which should
be fine for this kinds of old platform."

Since text below the separator is discarded when the patch is applied, this
justification will be lost.

Could this explanation be moved into the commit message itself to preserve
the reasoning in the permanent git history?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718-arm_dts_ld=
b-v2-0-f5669571aa2b@nxp.com?part=3D3
