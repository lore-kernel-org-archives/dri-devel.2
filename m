Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D493DC531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3280710E886;
	Tue, 28 Jul 2026 11:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VwXNNFH9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DD510E884
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:14:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FB9760A9F;
 Tue, 28 Jul 2026 11:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC7A1F00A3A;
 Tue, 28 Jul 2026 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785237278;
 bh=qK1rq2pN5UkDLoQmfh04o60rR2ywXluT5EU3UZDapfU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VwXNNFH9qx62vFiD/C0GrXwnji2dFkpR5UXuM0qwy5NvFl98PGS3b/v8Yk4LiqB+G
 qk74qs4kRDrn1vDp8thendEjzLFSsP3voVpDP3U8aX/pVyD34+TJfz4FeNVREvZnlu
 HmUhKti1sf4iu1N9VDjUtcRv0pmrAHN//uG+QRO34I/lj8T5Ya1SHtCqFQ2YSYJu2r
 vDm6H0MMRiFd6aJc9RGlW/RC+gr8IXdmgFAsTRh9tl7p9JVpxOimPgQIrt8MctjtWr
 Eh2j+SCNV1eOD+MIkIxvelBwRe8k9ngciI6j6YQkgwWwN7SVezBS79W5nST7jpGsi1
 c5OcU9u4G3cyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
To: mohit.dsor@oss.qualcomm.com
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260728-lt9611c-v7-v8-1-bda216bfaf37@oss.qualcomm.com>
References: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
 <20260728-lt9611c-v7-v8-1-bda216bfaf37@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 11:14:37 +0000
Message-Id: <20260728111438.1EC7A1F00A3A@smtp.kernel.org>
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
- [Medium] The schema lacks a conditional constraint to restrict `port@1` f=
or the 1-port LT9611C variant, and the title incorrectly describes all devi=
ces as 2-port.
- [Low] Use of Chinese ideographic commas instead of standard ASCII commas =
in the description.
--

--- Patch [1]: [PATCH v8 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/U=
XD) MIPI DSI to HDMI driver ---
commit 479e58120e4ea7ccc6ba2a2452966c2bdee319fa
Author: Sunyun Yang <syyang@lontium.com>

dt-bindings: bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

This commit adds compatible strings and documentation for the Lontium LT961=
1C,
LT9611EX, and LT9611UXD MIPI DSI to HDMI bridges.

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
The commit message notes that the LT9611C variant supports 1-port MIPI DSI.
Does this title need to be adjusted since it broadly describes all of the
supported devices as "2 Port"?

>  maintainers:
>    - Vinod Koul <vkoul@kernel.org>
> =20
>  description: |
> -  The LT9611 and LT9611UXC are bridge devices which convert DSI to HDMI
> +  The LT9611=E3=80=81LT9611UXC=E3=80=81LT9611C=E3=80=81LT9611EX and LT96=
11UXD

[Severity: Low]
This isn't a bug, but there appear to be non-ascii ideographic commas
used in this list instead of standard commas. Should these be replaced to
prevent rendering or text-processing quirks in the documentation?

> +  are bridge devices which convert DSI to HDMI
> =20
>  properties:
>    compatible:
>      enum:
>        - lontium,lt9611
> +      - lontium,lt9611c

[Severity: Medium]
Since the LT9611C variant only supports a single MIPI DSI port, should the
schema include an allOf: conditional block to explicitly set port@1: false
for the lontium,lt9611c compatible string?

Without this constraint, device tree configurations that accidentally inclu=
de
an invalid second DSI port (port@1) will silently pass schema validation
for this hardware variant.

> +      - lontium,lt9611ex
>        - lontium,lt9611uxc
> +      - lontium,lt9611uxd

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-lt9611c-v7=
-v8-0-bda216bfaf37@oss.qualcomm.com?part=3D1
