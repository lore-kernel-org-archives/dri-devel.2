Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B30DC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F409510E583;
	Tue, 28 Jul 2026 12:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oilzEXyw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A0E10E583
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 12:29:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 179C340523;
 Tue, 28 Jul 2026 12:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9901F000E9;
 Tue, 28 Jul 2026 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785241765;
 bh=jKYh6ma6/e5zAxGizgqjVB77XvQ0VLy68nPeb0FD9LE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oilzEXywOzu3a+k6LbgpSM1PyRsfZIShpvJJn/Kw2vSbjAuSyRQgs+RfaAcwCUXV4
 139uLCGP1wz4pk8ImM1a+RJVwvIO/zwsNNXDK+BW185ROrXraRaSpJpChxRCdb5rP3
 03uBxPF06uEvWP5cciB36jS9rhJ9EYcOHzPvddUBJtsOpwrfZARtm7Fxz6wAM0K385
 1BzDosWaO+iNiNNae2v1L3bRjEv3yCjM/TF7n+4eBxjQDWn0ZHrxv9+zFw5LDwlHym
 Ubp6Q6CqywqfB3ZJJPpnN9agkx7AOLsdAZbHwbJUCaSjiiBfmwabkwOwpia3U53C9b
 SFK10z14RMMGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] dt-bindings: display: sn65dsi83: Add output
 data-lanes property
To: "Wojciech Dubowik" <wojciech.dubowik@mt.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260728122032.692482-3-wojciech.dubowik@mt.com>
References: <20260728122032.692482-1-wojciech.dubowik@mt.com>
 <20260728122032.692482-3-wojciech.dubowik@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 12:29:24 +0000
Message-Id: <20260728122924.AA9901F000E9@smtp.kernel.org>
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
- [Medium] The `data-lanes` property requires exactly 4 items, breaking sup=
port for 18-bit (3-lane) LVDS configurations.
--

--- Patch [2]: [PATCH v7 2/3] dt-bindings: display: sn65dsi83: Add output d=
ata-lanes property ---
commit 9dc2b5a1e0c25c9fb7936d93599a48a919079b3b
Author: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

dt-bindings: display: sn65dsi83: Add output data-lanes property

Add an optional output lvds data lanes property with two allowed values
for default and reversed layout.

> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi8=
3.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> index e69b6343a8ebb..0eb3913acc9d4 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> @@ -125,6 +125,21 @@ $defs:
>                lanes in microvolts.
>              maxItems: 2
> =20
> +          data-lanes:
> +            description:
> +              Array of physical LVDS data lane indexes
> +            oneOf:
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +                  - const: 4
> +              - items:
> +                  - const: 4
> +                  - const: 3
> +                  - const: 2
> +                  - const: 1

[Severity: Medium]
Will this strict 4-item constraint break validation for 18-bit (3-lane) LVDS
configurations?

In dt-schema, specifying an items list automatically implies minItems equal=
 to
the length of the list unless explicitly overridden. Without a minItems set=
ting
defined here, the schema will reject arrays shorter than 4 elements, such as
data-lanes =3D <1 2 3> or <4 3 2>.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728122032.6924=
82-1-wojciech.dubowik@mt.com?part=3D2
