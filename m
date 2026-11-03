Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE20606A332
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeV2jRvk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBE910F4E4;
	Tue,  3 Nov 2026 10:49:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C4D210E4A4
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 10:49:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A51D54095F;
 Tue,  3 Nov 2026 10:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9B31F000C1;
 Tue,  3 Nov 2026 10:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793702950;
 bh=x3jybUZUjli2SkdPvv0VvHSWCQMmhs4hSkS0vW9Fq+w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EeV2jRvkMNGFnMwNJQSil8aFaPnCkKT2tIw0ZU+QpTC9eGsW2oWIG9dDmSuC7HmsV
 jJ9xZMzGAYi7NxibwLTbhmrV+7ldV7X1PBnxlGB7pEshYdPyic0kRRWUG/hz4W7ZB8
 SG7FDhOsIP914u2JGK/dX1St3+LrMmGlAtx5pqKDjwx8fZhfiueHvabpffkv6tcFBI
 JXjq6aStNJ6z/j2GxyJJAnedpYt7sIGA/5dttGuw0YNgMVpERAnUlJYtMPQeviuLBZ
 HkwVbfB5zZuZvX/IPM3pCaSKqKZ7xlEbg3l9+sMvnpqweDyy1Va2u0MPFh3K7SIoQM
 32eqYDnVKj3Hw==
Date: Tue, 3 Nov 2026 11:49:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adam Azuddin <azuddinadam@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, 
 tzimmermann@suse.de, jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: display: panel: Add RAiO RA8875
 display controller
Message-ID: <20261103-zippy-quantum-bat-98b5ed@quoll>
References: <20261030083737.47188-1-azuddinadam@gmail.com>
 <20261030083737.47188-2-azuddinadam@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030083737.47188-2-azuddinadam@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 04:37:35PM +0800, Adam Azuddin wrote:
> The RA8875 is an SPI-connected TFT display controller by RAiO
> Technology Inc. It supports display resolutions of up to 800x480.
> 
> Assisted-by: LLM

You can drop this.

> Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
> ---
>  .../bindings/display/panel/raio,ra8875.yaml   | 87 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
> new file mode 100644
> index 000000000000..661398bda0ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/raio,ra8875.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RAiO RA8875 Display Controller
> +
> +maintainers:
> +  - Adam Azuddin <azuddinadam@gmail.com>
> +
> +description:
> +  The RA8875 is a TFT LCD controller for panels up to 800x480 pixels.
> +  It can be connected to the host via 8080/6800 parallel interface,
> +  SPI or I2C.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: raio,ra8875
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description:
> +      3.3 V supply for the IO pins, the oscillator IO pins, the ADC pins
> +      and the internal LDO. The 1.8 V core rail is generated internally.
> +
> +  reset-gpios:
> +    description:
> +      GPIO connected to the active-low RST# pin. Optional, since the board
> +      may instead use an RC reset circuit.
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      INT# pin, active low. Signals RA8875 interrupt events such as touch
> +      panel, key scan, DMA, BTE and font access completion. Optional, since
> +      the host can poll the interrupt status register instead.

Last sentence is not correct. What driver can do is here less relevant.
Question is whether hardware datasheet allows interrupt being not
connected.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - display-timings
> +  - vdd-supply

Best regards,
Krzysztof

