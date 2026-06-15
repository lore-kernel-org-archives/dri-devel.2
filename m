Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB33CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 05:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7FC910E1B3;
	Mon, 15 Jun 2026 05:38:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cIS22vpz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D1110E1B3
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 05:38:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D8BB6008A;
 Mon, 15 Jun 2026 05:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172EA1F000E9;
 Mon, 15 Jun 2026 05:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781501926;
 bh=61hhhHxcLFdnYxc73vAonQrotow/c6tshPZMdlSimBs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cIS22vpzTpXb6oBTunY9fHvKllDKVLyTg9aFbuSKk45xfnJEICk4G0/WRGZtMPhkT
 C3craMqr9NSt0FB3EY/idQnvhVy1Z0gPbe0A6uPT8umjArxH9wFS0RdKyfQ4HdMZYE
 vOvsa1tQvisyYjnFZDgfnXmwvbsYKwc2Z1Ux/bHsQPgNsewjeLbrLg1jDWohkdxaew
 Xjwcv6pF0UdwG4UxW1/vftfcLqts3+fuiTOdHVHnaMsDtoo+3XNFmWPg2T82v3rSkv
 R7ysCXACp4FkPL/5mMbVxleWTPAdw8NsO/yEMz0mEVCbelFAmZx0IX2vKJ3mpIDDRK
 R8gQhXv87tL0w==
Date: Mon, 15 Jun 2026 07:38:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>,
 phone-devel@vger.kernel.org, Amir Dahan <system64fumo@tuta.io>
Subject: Re: [PATCH v3 2/4] dt-bindings: display: panel: Add documentation
 for lg,sw49410-lh609qh1
Message-ID: <20260615-thick-trout-of-inquire-4e4251@quoll>
References: <20260614-judyln-panel-v3-0-07f4134441bd@postmarketos.org>
 <20260614-judyln-panel-v3-2-07f4134441bd@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260614-judyln-panel-v3-2-07f4134441bd@postmarketos.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sun, Jun 14, 2026 at 05:07:59PM -0700, Paul Sajna wrote:
> Document how to use lg,sw49410-lh609qh1 in a devicetree

"Add Foo bar MIPI DSI panel, which suppors somehing something resolution
etc."

You describe hardware.

> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  .../bindings/display/panel/lg,sw49410.yaml         | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 

A nit, subject: drop second/last, redundant "documentation for". The
"dt-bindings" prefix is already stating that this is documentation.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml
> new file mode 100644
> index 000000000000..4c4bf4d89353
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/lg,sw49410.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LG LH609QH1 MIPI-DSI panel with SW49410 controller
> +
> +maintainers:
> +  - Paul Sajna <sajattack@postmarketos.org>
> +
> +description:
> +  LG LH609QH1 6.1" 1440x3120 MIPI DSI panel with SW49410 controller found in LG G7 ThinQ smartphone.

Please wrap code according to the preferred limit expressed in Kernel
coding style (checkpatch is not a coding style description, but only a
tool).  However don't wrap blindly (see Kernel coding style).

> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: lg,sw49410
> +      - const: lg,sw49410-lh609qh1

This is very confusing - why two compatibles and why same devices - both
sw49410 - are compatible with each other?

> +
> +  reg:
> +    maxItems: 1
> +
> +  backlight:
> +    description: Backlight device reference

Drop property here, not needed.

> +
> +  reset-gpios:
> +    description: Reset pin reference
> +
> +  vsp-supply:
> +    description: Positive voltage supply
> +
> +  vsn-supply:
> +    description: Negative voltage supply
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - port
> +  - vsp-supply
> +  - vsn-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            reg = <0>;
> +            compatible = "lg,sw49410-lh609qh1";
> +
> +            backlight = <&pmi8998_wled>;
> +            reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
> +            width-mm = <65>;
> +            height-mm = <140>;
> +
> +            vsp-supply = <&lab>;
> +            vsn-supply = <&ibb>;
> +
> +            pinctrl-0 = <&sde_dsi_active &sde_te_active_sleep>;
> +            pinctrl-1 = <&sde_dsi_sleep &sde_te_active_sleep>;
> +            pinctrl-names = "default", "sleep";
> +
> +            port {
> +              panel_in: endpoint {

Messed/inconsistent indentation.


Best regards,
Krzysztof

