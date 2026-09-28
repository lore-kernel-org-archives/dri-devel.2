Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B41CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 333F710E92C;
	Mon, 28 Sep 2026 16:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nirbHt65";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F4A10E92C
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:35:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BC6540860
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53281F000FF;
 Mon, 28 Sep 2026 16:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790613350;
 bh=w/sVognZBorzeMIsjNGcSKPpCvaHEm1JDK4PKd4R7Qc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nirbHt65n2yYu0oyRo7D16HRtKHd6xck+JbTm40dBlsZI4rUqumBgvQlRBIZuJIyM
 3kJyQAZpERCQptOxksU8b9THDIcmXwa4Mms68shK6d/dJBouWaW6R5hlE+jC+o0761
 x105WgzzkSvwlXvBYjQhm9lLD80JJ9zFLKjlJaWE4kxnqvdEQrYp7Xq4CJgmvlqPt2
 mwby4y2sSSSZVKvzhFuIC9bNFgoLcMpSjVmzyOlXCbanXFj+OvoGp1ffDIkycyDqAF
 5y0lSZsOgk9LvDlUb0WS/uz20ymFvUPoA7N5du7FOErf5XUyDTJR2FBP2x058hksV7
 aRhY40fMJXCfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf
 generic panel binding
To: "Maxime Ripard" <mripard@kernel.org>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:35:49 +0000
Message-Id: <20260928163549.E53281F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/panel: userspace BPF requirement breaks early boot panic displ=
ay
- [Low] dt-bindings: display: non-standard dsi-lanes instead of endpoint da=
ta-lanes
- [Low] dt-bindings: display: missing gpio.h include causes DTC syntax error
- [Low] dt-bindings: display: examples fail validation against legacy schem=
as
--

commit e9b8b6539dfc465519559ca54cf48b580b394bd1
Author: Maxime Ripard <mripard@kernel.org>
Subject: dt-bindings: display: Add panel-mipi-dsi-bpf generic panel binding

This commit introduces a generic MIPI-DSI panel binding where power sequenc=
ing
and DSI init commands are handled by BPF programs loaded from userspace. It
defines standard regulator supplies and DSI parameters while using a fallba=
ck
compatible string to match the generic driver.

> diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-d=
si-bpf.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-ds=
i-bpf.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.=
yaml
> @@ -0,0 +1,184 @@
[ ... ]
> +title: Generic MIPI-DSI panel with BPF init sequences
> +
> +maintainers:
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +description: |
> +  A generic MIPI-DSI panel driver where the panel-specific power sequenc=
ing
> +  and DSI init commands are provided by BPF programs.

[Severity: High]
Does this architectural requirement to rely on userspace-loaded BPF programs
result in the loss of early boot display capabilities? If the system crashes
during early boot, before userspace can mount the rootfs and load the BPF
objects, it appears the kernel would be unable to autonomously initialize t=
he
display to render the framebuffer console, splash screens, or kernel panic
messages.

[ ... ]
> +  elvss-supply:
> +    description: OLED EL negative supply
> +
> +  dsi-lanes:
> +    description: Number of DSI data lanes
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3, 4]
> +    default: 4

[Severity: Low]
Could this lead to fragmentation of device tree standards? Standard devicet=
ree
practice for DSI and CSI typically describes lane configurations using the
data-lanes property within the port or endpoint graph node, rather than
introducing a custom property like dsi-lanes at the root level.

[ ... ]
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        panel@0 {
> +            compatible =3D "elida,kd35t133", "panel-mipi-dsi-bpf";

[Severity: Low]
Will this trigger schema validation errors during make dt_binding_check? The
dt-schema tool automatically evaluates examples against existing legacy
schemas, such as the one for elida,kd35t133. Because legacy schemas typical=
ly
expect exactly one const compatible string and enforce additionalProperties:
false, they might reject the dual-compatible array and the generic
BPF-specific properties used in this example.

[ ... ]
> +  - |
> +    /* OLED panel using avdd/avee and elvdd/elvss supplies */
> +
> +    dsi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        panel@0 {
> +            compatible =3D "boe,bf060y8m-aj0", "panel-mipi-dsi-bpf";

[Severity: Low]
Similar to the previous example, will dt-schema reject this dual-compatible
array and the generic properties when evaluated against the existing
boe,bf060y8m-aj0 schema?

[ ... ]
> +            vcc-supply =3D <&vreg_l14a>;
> +            iovcc-supply =3D <&vreg_l12a>;
> +            elvdd-supply =3D <&vreg_oled_pos>;
> +            elvss-supply =3D <&vreg_oled_neg>;
> +            reset-gpios =3D <&tlmm 6 GPIO_ACTIVE_LOW>;

[Severity: Low]
Will the dt-extract-example tool cause a DTC syntax error here? This second
example block seems to be missing the include for dt-bindings/gpio/gpio.h
which is required for the GPIO_ACTIVE_LOW macro.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-drm-mipi-d=
si-panel-ebpf-v1-0-5244926aace4@kernel.org?part=3D1
