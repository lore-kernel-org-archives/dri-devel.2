Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F96ECA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC4F10E2F8;
	Thu,  1 Oct 2026 06:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UXNChz04";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE7F10E202
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:28:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A8E93601FE;
 Thu,  1 Oct 2026 06:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C551F000FF;
 Thu,  1 Oct 2026 06:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790836114;
 bh=v4A8AWeG5UdU3l+v/s+Hlf/e4vUv52p2AFz1neNQlEI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UXNChz04yFGja/nd3GqEHe8ekEic4stbjx0l28h3p1fHwXm90tQViFBPRGj3vhrHW
 IZUnW4fQ/t1cozDnOxtCIuM5OwVo69TXLicUDtY95TZX2dwef4lLD4dzY84oLZGV0N
 D3i0mvKk+Stv47KaH43R/mZ0bWT7+LpjQKAz7iksd7JGgPUkPLg+i7mv7XaZ67BiuI
 GW4YYb+4T4rG7cW+2pYI20n0fWOIhVBvOvp9zoqpeMLlqKfP0W9Ble+qH2+Ie/PxEM
 Syp35LaLKP6P1/WhPWaAExx8Q0C7aJyyozN/kbQmueeRDVrYJ1nisN8F+2r+Z+Dvkd
 abOrBQhcJL44A==
Date: Thu, 1 Oct 2026 08:28:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] dt-bindings: display: Add Solomon SSD16xx
 e-paper controller binding
Message-ID: <20261001-neon-dazzling-urchin-46b103@quoll>
References: <20260927182329.4193961-1-devarsht@ti.com>
 <20260927182329.4193961-3-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260927182329.4193961-3-devarsht@ti.com>
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

On Sun, Sep 27, 2026 at 11:53:17PM +0530, Devarsh Thakkar wrote:
> Add device tree binding for the Solomon Systech SSD16xx family of e-Paper
> display controllers (SSD1683 [1], SSD1673 [3], SSD1680 [4], SSD1681 [5]).
> 

A nit, subject: drop second/last, redundant "binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

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
> Changes from v1:
>   - Added fallback compatible for the controller
>   - Wrap lines to 80
> 
>  .../bindings/display/solomon,ssd16xx.yaml     | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> new file mode 100644
> index 000000000000..b31fb862de04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml

Filename must match compatible.

> @@ -0,0 +1,87 @@
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
> +  The SSD16xx family includes e-paper display controllers (SSD1673,
> +  SSD1680, SSD1681, SSD1683, SSD1677) with integrated gate driver,
> +  source driver and timing controller. Different panels use these
> +  controllers in monochrome or 3-color (black/white/red) configurations.
> +  The controller uses a 4-wire SPI interface and requires GPIO pins for
> +  reset, busy status, and data/command control. A 3-wire mode is also
> +  available where the D/C bit is transmitted along the SPI data line
> +  before each byte.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          # Good Display 4.2" 400x300 monochrome e-ink panel
> +          - gooddisplay,gdey042t81
> +      - enum:

No, fallback cannot be enumeration.

> +          - solomon,ssd1683
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
> +      GPIO connected to the BUSY pin. Active high when the controller
> +      is busy updating the display.
> +
> +  dc-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the D/C (Data/Command) pin. Low for command,
> +      high for data.
> +
> +  rotation:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 90, 180, 270]
> +    description:
> +      Display rotation in degrees clockwise.
> +

Is this display controller or panel? If panel, then missing ref to
panel-common. If display controller, then description is misleading.

Best regards,
Krzysztof

