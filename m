Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5F2C4450E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A59610E75A;
	Thu, 16 Jul 2026 11:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eBpMgeCd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F211710E75A
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:36:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29C82601EB;
 Thu, 16 Jul 2026 11:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850871F00A3A;
 Thu, 16 Jul 2026 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784201769;
 bh=E3Ww+J9dhlePbQo3yPsSYBG0Sik+uy39A44ROGTjViM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eBpMgeCdNSzPR6dG65UC8aYHKUNG8Mk6gK7L5rkfBEgSGUBtG8fi9pUGxtFGm/WEr
 yqLGPU7nl7MXs8L3iY/RChjxLKTUC0w341whOULlQ6ofvXL6mOJ8o7KfOAaRjo6OE2
 kt45Uvv72/Gy1ygnxzFuODktK4mxi1vSZPx8njgbOhNhqG5pytEYmvvTFKfjZ2yAUx
 Z3IqQX6Apw9hmIUQF08rju3sQy9yTqoCnKPkOTSEsDRdzK46gRk3xkFqiRQxrp1kbD
 i5MxVHCrVQcXdRRF4lkqVIrbCvr+4ZUARFfj6WLE6Dc0mUMnoJp0D26ZERGhFkwHWl
 YkJBj09B4/gqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
To: mohit.dsor@oss.qualcomm.com
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260716-lt9611c-v7-v7-1-7553a14735fc@oss.qualcomm.com>
References: <20260716-lt9611c-v7-v7-0-7553a14735fc@oss.qualcomm.com>
 <20260716-lt9611c-v7-v7-1-7553a14735fc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 11:36:09 +0000
Message-Id: <20260716113609.850871F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The schema fails to restrict the number of MIPI DSI ports for th=
e 1-port LT9611C variant, and the updated title inaccurately describes all =
variants as '2 Port'.
- [Low] The YAML description uses non-standard fullwidth CJK ideographic co=
mmas instead of standard ASCII commas.
--

--- Patch [1]: [PATCH v7 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/U=
XD) MIPI DSI to HDMI driver ---
commit f290f005feeeb3c95f9e36c02a61ab4f708f4e53
Author: Sunyun Yang <syyang@lontium.com>

dt-bindings: bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

This commit adds compatible strings and updates the description for the
LT9611C, LT9611EX, and LT9611UXD bridge devices.

> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9=
611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.=
yaml
> index 429a06057ae85..e0821a63d9d74 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> @@ -4,19 +4,23 @@
>  $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
> +title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge

[Severity: Medium]
Since the commit message indicates the LT9611C only supports 1 port, should
the title be updated to reflect that not all of these devices are 2 port
bridges?

> =20
>  maintainers:
>    - Vinod Koul <vkoul@kernel.org>
> =20
>  description: |
> -  The LT9611 and LT9611UXC are bridge devices which convert DSI to HDMI
> +  The LT9611=E3=80=81LT9611UXC=E3=80=81LT9611C=E3=80=81LT9611EX and LT96=
11UXD

[Severity: Low]
This isn't a bug, but it looks like fullwidth CJK ideographic commas (U+300=
1)
were used here instead of standard ASCII commas.

> +  are bridge devices which convert DSI to HDMI
> =20
>  properties:
>    compatible:
>      enum:
>        - lontium,lt9611
> +      - lontium,lt9611c
> +      - lontium,lt9611ex

[Severity: Medium]
Because the LT9611C is a 1-port device, should there be an allOf/if block
added to restrict the number of ports for this specific compatible string?

Without it, wouldn't a device tree using lontium,lt9611c silently pass
dt_binding_check validation even if it defines both port@0 and port@1?

>        - lontium,lt9611uxc
> +      - lontium,lt9611uxd
> =20
>    reg:
>      maxItems: 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-lt9611c-v7=
-v7-0-7553a14735fc@oss.qualcomm.com?part=3D1
