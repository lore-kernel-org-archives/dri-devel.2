Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ECDC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E0D10F2A5;
	Wed,  8 Jul 2026 20:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QfTzSeLv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B41AA10F2A5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 20:37:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6939943644;
 Wed,  8 Jul 2026 20:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AA31F000E9;
 Wed,  8 Jul 2026 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783543024;
 bh=POo4reXuXxtUEoTC99UPcPEYcy1S5WLVHZGqNrq6pzM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QfTzSeLvprOD2MYJA0oqudKCFJFDaNcsPUkAmzPYBBAIuF+cKjSlDID8ls9lHCfZa
 yLXtBKpDkZhoa2Yczk9l3w0HVUq35H/9mOpWN/GVzU7EwH1o+wMZ2/CL0APFwNrC3R
 jN/XpERbGlz+BkVpbHX6NuP5VMvHitoB4ImAZtbwUFr4o0smaW4yl+Oj6250YbPjqN
 gpALmRT3wYPbOGCf6m/sHX4thFq7kNBkjDjuYdr4B3+U1vxspaUt86y6CYRM+4RYd4
 pqI3k8aCDoGxBpvgG5S8TYrEKK3t40+j4xagBTiqJdBKGzyU9YUyyHS590gpgz3ESE
 15WBOTIJ7KDlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: display: lcdif: Allow display0 child
 node for i.MX6UL
To: Frank.Li@oss.nxp.com
Cc: conor+dt@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260708-arm_dts_ldb-v1-3-4f5579b85797@nxp.com>
References: <20260708-arm_dts_ldb-v1-0-4f5579b85797@nxp.com>
 <20260708-arm_dts_ldb-v1-3-4f5579b85797@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 20:37:03 +0000
Message-Id: <20260708203703.E5AA31F000E9@smtp.kernel.org>
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
- [Medium] The schema inadvertently allows `dmas` and `dma-names` propertie=
s for the `fsl,imx6ul-lcdif` compatible string.
--

--- Patch [3]: [PATCH 3/4] dt-bindings: display: lcdif: Allow display0 chil=
d node for i.MX6UL ---
commit 4b641f03375f74e811e7a58ce3d750c19709f1d5
Author: Frank Li <Frank.Li@nxp.com>

dt-bindings: display: lcdif: Allow display0 child node for i.MX6UL

The legacy i.MX6UL LCDIF binding uses a display0 child node to describe
the attached display. This commit updates the binding schema to allow
this child node for fsl,imx6ul-lcdif.

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
Does this inadvertently allow dmas and dma-names properties for the
fsl,imx6ul-lcdif compatible string?

By adding fsl,imx6ul-lcdif to this combined exemption block, it appears to
successfully bypass the legacy display restrictions to allow display0, but
it also exempts the i.MX6UL from the dmas restrictions which were correctly
applied prior to this patch.

If a device tree incorrectly defines dmas properties on an fsl,imx6ul-lcdif
node, dtbs_check might now silently pass without triggering a schema
violation warning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-arm_dts_ld=
b-v1-0-4f5579b85797@nxp.com?part=3D3
