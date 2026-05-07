Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9794CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 18:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE12C10E29B;
	Thu,  7 May 2026 18:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T6yjzuJz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0818110E29B
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 18:34:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1753860181;
 Thu,  7 May 2026 18:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C73C2BCB2;
 Thu,  7 May 2026 18:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778178860;
 bh=5eoQ6vGJ6VF5O9Wfoi0/iTdnirH1bn21qKZb/NKAVik=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T6yjzuJzCU3zfTShJRsTrFrAN3oqBcHFCtsyadFJQZcIcTjTUAyRtrBLj5svzVLGL
 3sb/IqNwMcrpWiywQtJxbkBsXgjvP9xS7sml4PpXfS2pWWoeJSbcmxQA1CikJcfafi
 mjHqSZ6gtjm+wed1p8Ix+fd0Dyqr1cm2dXGO2ixSve+nMbxFP5kQ3PZV/wN2Vfjxu5
 E44s3zrzhD2ZManQH/mkW0QdBUXEYur1VTMbpMyU7Vd7wzZMOf0EbnhiMMzPZCg4HF
 47iBdyAXeFUb/jtCE3fwJDwfhwiuAzpJWTpRfMlke2Z8UuA/461Z81xlUBCYio8Z0Q
 x6BcmsCBCexNg==
Date: Thu, 7 May 2026 13:34:18 -0500
From: Rob Herring <robh@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, praneeth@ti.com, vigneshr@ti.com,
 s-jain1@ti.com, s-wang12@ti.com, r-donadkar@ti.com,
 r-sharma3@ti.com, afd@ti.com
Subject: Re: [PATCH 2/6] dt-bindings/display: Add Solomon SSD16xx e-paper
 controller binding
Message-ID: <20260507183418.GA2213122-robh@kernel.org>
References: <20260430183311.2978142-1-devarsht@ti.com>
 <20260430183311.2978142-3-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430183311.2978142-3-devarsht@ti.com>
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

On Fri, May 01, 2026 at 12:03:07AM +0530, Devarsh Thakkar wrote:
> Add device tree binding for the Solomon Systech SSD16xx family of e-Paper
> display controllers (SSD1683 [1], SSD1673 [3], SSD1680 [4], SSD1681 [5]).
> 
> The binding covers the 4-wire SPI interface with required GPIO pins for
> reset (active-low), busy status (active-high), and data/command selection.
> The spi-max-frequency is capped at 20 MHz per the SSD1683 datasheet [1]
> which is also the maximum supported frequency amongst the family.
> 
> An optional rotation property allows static display orientation to be
> configured from device tree.
> 
> The data/command selection GPIO pin is also kept as optional since various
> SSD16XX controllers such as SSD1683 [1] support 3-wire mode too with
> data/command selection bit transmitted as first bit before sending the data
> sequence.
> 
> The first supported compatible is for Gooddisplay GDEY042T81 which is 4.2",
> 400x300 resolution black/white e-paper display using SSD1683 controller.
> 
> Links:
> [1] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1683
> [2] : https://files.seeedstudio.com/wiki/Other_Display/42-epaper/GDEY042T81.pdf
> [3] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1673
> [4] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1680
> [5] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1681
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  .../bindings/display/solomon,ssd16xx.yaml     | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> new file mode 100644
> index 000000000000..2433ddb859d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/solomon,ssd16xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Solomon Systech SSD16xx controller based e-paper display panels
> +
> +maintainers:
> +  - Devarsh Thakkar <devarsht@ti.com>
> +
> +description:
> +  The SSD16xx family includes e-paper display controllers (SSD1680, SSD1681,
> +  SSD1673, SSD1683) with integrated gate driver, source driver and timing controller.
> +  Different panels use these controllers in monochrome or 3-color configurations.
> +  The controller uses a 4-wire SPI interface and requires GPIO pins for reset,
> +  busy status, and data/command control with a 3-wire mode also available
> +  where D/C bit is transmitted along the SPI data line before sending actual data.

Wrap lines at 80 chars.

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - gooddisplay,gdey042t81  # 4.2" 400x300 monochrome (SSD1683 controller)

If you know the controller, make it a fallback compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the RSTB (reset) pin. Active low.
> +
> +  busy-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the BUSY pin. Active high when the controller is
> +      busy updating the display.
> +
> +  dc-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the D/C (Data/Command) pin. Low for command, high
> +      for data.
> +
> +  rotation:
> +    enum: [0, 90, 180, 270]
> +    description:
> +      Display rotation in degrees counter clockwise (0,90,180,270)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - busy-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        display@0 {
> +            compatible = "gooddisplay,gdey042t81";
> +            reg = <0>;
> +            spi-max-frequency = <2000000>;
> +            reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> +            busy-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
> +            dc-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> -- 
> 2.39.1
> 
