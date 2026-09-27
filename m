Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A707C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5683810E686;
	Sun, 27 Sep 2026 18:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BNpMaif8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1943510E686
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:35:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D723C43904;
 Sun, 27 Sep 2026 18:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE601F000FF;
 Sun, 27 Sep 2026 18:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790534155;
 bh=rUqyOGpQ5p0dUJf3fovNuhsOcuyUoqVFwHQz5BKJrZs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BNpMaif8Pn+lSie17cbRfBfjYwc5Ahy2EzHaNxesFDEJtQ9jwaWwqOYP7xpwvIQB4
 WMI7QT/1gwFSGJkoj4Kat/bTbLqXKjQkMH/suflvsAMDv3T37r55FAJTXORIfTRZyO
 W/wFdvCCeJsRZuB1EmuxwvOxXHXQh5I4sszt65bqf3U2WjPrp3cg1U/nrHmprfyr+Z
 jrI3XVGagpufWvlIU6/kZ5TDnD8y7dOap29PluZFIMUUrr/qGRrwVoAVjvNqy7MOtA
 hrmm3YjJsbiGL4/go+AF2eUBJRWHsaCA//syDZOtJ2zOXcXZe9Q2/lTtAuH4KiOv70
 ybw8Y7IFynlEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/14] dt-bindings: display: solomon,ssd16xx: Add
 Solomon SSD1677 controller
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260927182329.4193961-4-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
 <20260927182329.4193961-4-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:35:54 +0000
Message-Id: <20260927183555.6BE601F000FF@smtp.kernel.org>
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
- [Medium] dt-bindings: display: solomon,ssd16xx: commit message and schema=
 mismatch for ssd1677
--

commit 0557e7fb08a4970f824714f1d57d93f2cdcd0204
Author: Devarsh Thakkar <devarsht@ti.com>

dt-bindings: display: solomon,ssd16xx: Add Solomon SSD1677 controller

Adds support for the Solomon SSD1677 controller to the solomon,ssd16xx
binding. The commit message indicates adding it to the controller fallback
enum, but the schema restructuring implements it as a standalone constant.

> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd16xx.ya=
ml b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> index b31fb862de042..1a94ad9b0d944 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> @@ -24,12 +24,13 @@ allOf:
> =20
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          # Good Display 4.2" 400x300 monochrome e-ink panel
> -          - gooddisplay,gdey042t81
> -      - enum:
> -          - solomon,ssd1683
> +    oneOf:
> +      - items:
> +          - enum:
> +              # Good Display 4.2" 400x300 monochrome e-ink panel
> +              - gooddisplay,gdey042t81
> +          - const: solomon,ssd1683
> +      - const: solomon,ssd1677

[Severity: Medium]
The commit message explicitly states the intent to "Add solomon,ssd1677 to
the controller fallback compatible enum." However, the patch implements it
as a standalone const under a new oneOf block.

In dt-schema, a bare const validates an array containing exactly one elemen=
t.
While restructuring the schema to avoid falsely linking the new ssd1677
controller with the existing ssd1683-based panel is structurally correct,
this creates a mismatch between the commit message's stated intent and the
implemented schema constraints.

Developers attempting to use the compatible string as a fallback (as
advertised in the commit message) like:

	compatible =3D "vendor,panel", "solomon,ssd1677";

will encounter dt-schema validation failures during make dtbs_check. Can the
commit message be updated to reflect the standalone nature of this new
compatible, or does the schema need to permit fallback usage?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927182329.4193=
961-1-devarsht@ti.com?part=3D3
