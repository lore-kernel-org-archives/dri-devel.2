Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC898C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F276F10E235;
	Thu, 20 Aug 2026 19:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cp3FWQap";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9929F10E235
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:05:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ACDB860A58;
 Thu, 20 Aug 2026 19:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C9B1F000E9;
 Thu, 20 Aug 2026 19:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787252727;
 bh=jGkjERQmwepU+LHsNdygzAmEQAPxvtTO7/xGi3vu7nc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cp3FWQapqjGI4opABxazzW7irCxp+D/d29/zj7iT2ngp20po/vB1GNtT6J8M3Z+Z4
 F5HuA7qereRAicDIykWNSsWwIt+iS25sb1/Mi7VDFm7ytOeS3ZxC6/vauA7IyCBHBO
 f/l0mWgfBkRhr3eHq87nvzvDOVCaNO90UZ/NHz5xzCFaMo2BBCNg5v1Pic3CTcsIeX
 gpqBYirWjSWqAdom0r+AbSnE4qXA50XzbovOtbN6IC9TfrHcV0G0W9cwSgjMuvO3h9
 8clrZNOBUS+lMXKKLOk/eALk88uU4Qjm9R0HvrelaznsQyxjYNyRZ7QyH+4X6G932Z
 0Q58UIR/HJx+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: Document 10"
 Raspberry Pi Touch Display 2
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260820185506.84448-1-marek.vasut+renesas@mailbox.org>
References: <20260820185506.84448-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 19:05:26 +0000
Message-Id: <20260820190527.08C9B1F000E9@smtp.kernel.org>
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
- [Medium] Adding `raspberrypi,dsi-10inch` without conditional blocks uncon=
ditionally forces incorrect hardware constraints (discrete supplies and ena=
ble-gpios) onto the new panel variant.
--

--- Patch [1]: [PATCH v2 1/4] dt-bindings: display: panel: Document 10" Ras=
pberry Pi Touch Display 2 ---
commit 2739ad573af941325eae5c172cd4464d44cc6055
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

dt-bindings: display: panel: Document 10" Raspberry Pi Touch Display 2

This commit documents the 10" Raspberry Pi Touch Display 2 MIPI-DSI TFT
LCD panel. The panel is based on the Ilitek ILI79600A controller.

> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,il799=
00a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.=
yaml
> index 02f7fb1f16dc7..f8644e9a4478d 100644
> --- a/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
> @@ -14,10 +14,15 @@ allOf:
> =20
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - tianma,tl121bvms07-00
> -      - const: ilitek,il79900a
> +    oneOf:
> +      - items:
> +          - enum:
> +              - raspberrypi,dsi-10inch
> +          - const: ilitek,ili79600a

[Severity: Medium]
Will this unconditionally force incorrect hardware constraints onto the new
panel variant?

Adding the compatible string here causes the raspberrypi,dsi-10inch panel
to inherit the global required properties present later in this file:

required:
  - compatible
  - reg
  - enable-gpios
  - avdd-supply
  - avee-supply
  - pp1800-supply

If device trees omit enable-gpios or the discrete supplies for this new
hardware variant, will they incorrectly fail dtbs_check schema validation?

Should the binding use conditional blocks to handle the different required
properties for each hardware variant?

> +      - items:
> +          - enum:
> +              - tianma,tl121bvms07-00
> +          - const: ilitek,il79900a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820185506.8444=
8-1-marek.vasut+renesas@mailbox.org?part=3D1
