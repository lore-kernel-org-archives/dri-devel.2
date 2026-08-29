Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A39C61DD6
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 20:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0919610E085;
	Sat, 29 Aug 2026 20:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X8UMeXiI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2022F10E085
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 20:15:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E082141967;
 Sat, 29 Aug 2026 20:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796D31F000E9;
 Sat, 29 Aug 2026 20:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788034500;
 bh=Z9HSNJCOp0EkaUL1Ll5zvr9SQQscvbVTNrjXTlkBLZ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X8UMeXiIAxoylA2bji2rjLpVXfzbyue/PJShZBX1wuo6LA/z1OF7FR9AvJm0ArHjQ
 wtDbPK6UsW63/IdR4DgGkAa3iIbfLV6dl790/lwasOs1Kyj0NCybzJkds1nAvJJFv6
 piNR0+WbYbEGvFxG/4MwGnn03J+REgo8P4mAL3fM8OR5ehnzdo4qKmw8uEtjIkDMR3
 swJd3oqEyJbUzEMyyg9C+bJreoW0KVSq7suiaYQGSkTcyV/l9KjU3djJGIMWN4dGFP
 WwQPVn6JJXN/OsbyZtcGh/mManb7xD2H4nGCiusTg7UPZ/wz+Fp+w0fVDBO/WRlIvp
 tC2PgzmY3um4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: display: panel: Add bindings for
 Novatek NT51021
To: "Nickolay Goppen" <setotau@mainlining.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260829-qcom-novatek-nt51021-panels-v1-1-cc1ca61bd261@mainlining.org>
References: <20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org>
 <20260829-qcom-novatek-nt51021-panels-v1-1-cc1ca61bd261@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 20:14:59 +0000
Message-Id: <20260829201500.796D31F000E9@smtp.kernel.org>
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
- [Medium] Commit message and schema description contradict the schema's co=
mpatible list by claiming to only support 'boe,tv101wum-nx0' while silently=
 including 'boe,tv080wum-nx2'.
- [Medium] The description for `reset-gpios` incorrectly specifies the pola=
rity as '(active high)', which contradicts the example and typical panel re=
set semantics.
--

commit 4949971c710c300054975d637c238b42bc5c2c75
Author: Nickolay Goppen <setotau@mainlining.org>

dt-bindings: display: panel: Add bindings for Novatek NT51021

This commit introduces device tree bindings for the Novatek NT51021 display
driver IC. It explicitly states support is added for the BOE TV101WUM-NX0
WUXGA video mode panel.

> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt51=
021.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.=
yaml
> new file mode 100644
> index 0000000000000..a3e4ed10e645d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
> @@ -0,0 +1,93 @@
[ ... ]
> +description: |
> +  The NT51021 IC from Novatek is a generic DSI Panel IC used to drive dsi
> +  panels.
> +  Right now, support is added only for a BOE WUXGA LCD display panels wi=
th a
> +  resolution of 1200x1920. They are video mode DSI panels.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - boe,tv101wum-nx0
> +          - boe,tv080wum-nx2

[Severity: Medium]
The commit message and the schema description state that support is added
only for the BOE TV101WUM-NX0 panel, but this adds boe,tv080wum-nx2 to the
compatible list.

Is this regression intended, or should the description and commit message be
updated to reflect support for both panels?

[ ... ]
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: phandle of gpio for reset line - This should be 8mA, gp=
io
> +      can be configured using mux, pinctrl, pinctrl-names (active high)

[Severity: Medium]
Could this description cause regressions for users configuring the reset
line?

The text explicitly specifies (active high) for the reset-gpios polarity,
but typical panel semantics and the example block further down use active
low:

            reset-gpios =3D <&tlmm 62 GPIO_ACTIVE_LOW>;

If users follow this text description instead of the example, could they
drive the physical line incorrectly and prevent the panel from initializing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829-qcom-novat=
ek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org?part=3D1
