Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36CFC4451B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2134989131;
	Sun, 19 Jul 2026 16:15:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k1NRHXXv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 625FB89131
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 16:15:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E54F60051;
 Sun, 19 Jul 2026 16:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8DE1F000E9;
 Sun, 19 Jul 2026 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784477703;
 bh=7VmY+yA/umQSE3C/zMBxyjO2tlXcsRnHdy6kysnjwfM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k1NRHXXvxfa5fatoWGz2qy7Rj2lZ3AICgBIBdkziIOoJJFA1lcE8EWIUb87olYpGa
 cA8FT+YsI5qI+Xep8GYFo6A+5PNdku6tp0YpWYT3YRIIEgUyXGmtShZdLrIV4dDwN1
 YvbIXjRl8Hb3ZybxDg5Cujxx6t9/KIxpK/29FtBDWdAOeGW8AL2vL4RVqiq6k5DwvF
 RNLdi4m2gqAqmNnUalVOp4a8DhgMNL8AF9AEx6oD9SvBbckJLt1tFbJqZwORj1iP7U
 zyIJjXqtkQdhD/zmqxjJxFsoa0uE7A70Q7wGZl0hm5svdCyVau5GZGHRb53J4vkFSB
 m3+qE7l6NAczA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: display: panel-lvds: Add boe,dv215fhm-r01
 compatible
To: "Vishnu Saini" <vishnu.saini@oss.qualcomm.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260719-b4-lvds-panel-doc-v1-1-6a18c213c2f6@oss.qualcomm.com>
References: <20260719-b4-lvds-panel-doc-v1-1-6a18c213c2f6@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 16:15:02 +0000
Message-Id: <20260719161502.DE8DE1F000E9@smtp.kernel.org>
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
- [High] Removing 'port' from the global required list without conditional =
replacements allows all panels to omit their display controller connection.
- [Medium] The schema fails to apply the dual-LVDS binding for the new dual=
-channel panel, breaking validation for pixel-order properties.
--

--- Patch [1]: [PATCH] dt-bindings: display: panel-lvds: Add boe,dv215fhm-r=
01 compatible ---
commit dda569bad0ff68efade6e9633f374c324001833a
Author: Vishnu Saini <vishnu.saini@oss.qualcomm.com>

dt-bindings: display: panel-lvds: Add boe,dv215fhm-r01 compatible

This commit adds the BOE DV215FHM-R01 21.5" dual-channel LVDS panel
to the panel-lvds binding. It also removes the global port requirement
to allow dual-channel panels to use the ports topology with separate
port@0 and port@1 nodes.

> diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.y=
aml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> index b89f86bc06837..584818b2df6ea 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml

[ ... ]

> @@ -72,6 +74,12 @@ properties:
> =20
>        - const: panel-lvds
> =20
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description:
> +      For dual-channel LVDS panels, use 'ports' with port@0 for odd pixe=
ls
> +      and port@1 for even pixels instead of the single 'port' property.

[Severity: Medium]
Since the boe,dv215fhm-r01 compatible requires dual-LVDS properties like
dual-lvds-odd-pixels and dual-lvds-even-pixels in its ports, shouldn't this
schema conditionally reference /schemas/display/lvds-dual-ports.yaml?

Without referencing the dual-LVDS schema, won't these properties fail
validation as unrecognized properties, or fail to have their mandatory
presence enforced when someone instantiates this dual-channel panel?

> +
>  unevaluatedProperties: false
> =20
>  required:
> @@ -80,6 +88,4 @@ required:
>    - width-mm
>    - height-mm
>    - panel-timing
> -  - port
> -
>  ...

[Severity: High]
Does removing port from the global required list without providing
conditional replacements allow all existing single-channel LVDS panels to
silently pass validation even if they omit their display controller
connection?

Would it be safer to enforce this requirement using an anyOf block such as
anyOf: [{required: [port]}, {required: [ports]}], or to use conditional
if-then blocks to ensure validation constraints for prior generations are
not globally relaxed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719-b4-lvds-pa=
nel-doc-v1-1-6a18c213c2f6@oss.qualcomm.com?part=3D1
