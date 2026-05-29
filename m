Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6ABCD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 10:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F74F10FC74;
	Fri, 29 May 2026 10:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OGXNYi5s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD0110FC6C
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 10:07:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EC127409AE;
 Fri, 29 May 2026 10:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043B61F00893;
 Fri, 29 May 2026 10:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780049236;
 bh=lXKf6EfvdGOigOoLkgyY217iW74Ag1v0A+N5KPnAyHc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OGXNYi5sCoKbBpMSoTnYkMJq24CnAv2tZyU0np08BylAsUiretKRXFAH5l700jWNn
 55IC0jiozhxx2J+i9XwtOevmWmDF+MwGC+j7NaFQIDYRudZCvi/PO13NCKAoZqZcf1
 isBPuV+ezZGnKLhF4voSUmHkf64Ktv+WvOCzxRFNrjP377q71hKV8VLbsg3klJIaCQ
 ip860dX0//ShSx0qBiGEJVBRqmJASCfQtFzTnkp1E6u++2IXBVhY9wM7AzmXWjA3a+
 NWIZ0oBjSdvgW2RBag7JVsDEb9GPBKqrWuyCMjERlvMih8z5ueBTEl890C3ow7M7Gs
 WDwD7ZdE+U2Bw==
Date: Fri, 29 May 2026 11:07:11 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
Message-ID: <ahllT_HVTAJ5MbkS@aspen.lan>
References: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
 <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-1-ec8194bbc885@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-1-ec8194bbc885@linaro.org>
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

On Tue, May 19, 2026 at 10:43:38AM +0200, Neil Armstrong wrote:
> Document the Silergy SY7758 6-channel High Efficiency LED Driver
> used for backlight brightness control.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
> new file mode 100644
> index 000000000000..80e978d691c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/silergy,sy7758.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silergy SY7758 6-channel High Efficiency LED Driver
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description:
> +  Silergy SY7758 is a high efficiency 6-channels LED backlight
> +  driver with I2C brightness control.
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: silergy,sy7758
> +
> +  reg:
> +    maxItems: 1
> +
> +  vddio-supply: true
> +
> +  enable-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddio-supply

Sorry for missing this in v2 but is vddio-supply really a required
property?

It's unusual for supplies to be mandatory (and the it is not mandatory
in the driver implementation).


Daniel.
