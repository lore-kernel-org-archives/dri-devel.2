Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097EECD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 13:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 496BD10E0A3;
	Sun, 17 May 2026 13:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PwLTCZ45";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA4910E0A3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 13:45:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 51CC9429F7;
 Sun, 17 May 2026 13:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE23EC2BCB0;
 Sun, 17 May 2026 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779025506;
 bh=Yhlx+peDKSMRGYl8zT9YWqABpdNepHKaSStG0Z7fuZQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PwLTCZ45pGDzdvmztnoD8yfkeN6fRVyVzZng8MUKQ1zxWLWv6zS8BA84KMl5CX3Ti
 M8EK73nR+FFWDPXHOLp64pZ2JPF2xLkQrzMu3Xef3xWYVqtz1j/jPY16A6aRLqeqai
 Cs2Cq59jvw4pcdRQ0MUI2tm2njYat8dxH7XDZbZH3exfu6JKe9pG37lA21CLYGhSAL
 q3pB1JkygH6zROInk6TUopqNxKWpQ9OpTEb+AHA3UHJtaE5KYfN9kl+u5j2+sXpoPM
 g6iMe6lH3mcp/8A/c8ZZfFYrgUgW+ASD2B+yzexi/ILtawigG9Lwq1IwFo02G6IBPh
 +ZKN5rYAzmmzw==
Date: Sun, 17 May 2026 14:44:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 1/6] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <20260517144453.61cc210c@jic23-huawei>
In-Reply-To: <20260517074306.30937-2-clamor95@gmail.com>
References: <20260517074306.30937-1-clamor95@gmail.com>
 <20260517074306.30937-2-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 17 May 2026 10:43:01 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Document the LM3533 - a complete power source for backlight, keypad and
> indicator LEDs in smartphone handsets. The high-voltage inductive boost
> converter provides the power for two series LED strings display backlight
> and keypad functions.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Hi Svyatoslav,

I focused on the ALS part.. A few comments.

> +# see ti,lm3533.yaml for an example
> diff --git a/Documentation/devicetree/bindings/leds/ti,lm3533.yaml b/Documentation/devicetree/bindings/leds/ti,lm3533.yaml
> new file mode 100644
> index 000000000000..2e200f172400
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/ti,lm3533.yaml
> @@ -0,0 +1,190 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/ti,lm3533.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LM3533 Complete Lighting Power Solution
> +
> +description: >
> +  The LM3533 is a complete power source for backlight, keypad, and indicator LEDs
> +  in smartphone handsets. The high-voltage inductive boost converter provides the
> +  power for two high voltage series LED strings for display backlight and four low
> +  voltage control banks for individual LEDs. Additionally, LM3533 features an ALS
> +  sensor support.
Mention it is an interface for an external ALS.

> +  light-sensor:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        const: ti,lm3533-als
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      ti,resistor-ohm:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Internal configuration resister value when ALS is in Analog Sensor
> +          mode and PWM mode is disabled.

Good to note why this is a firmware thing rather than a userspace controlled
thing. I looked it up, it's because expectation is the input is a current from
the external analog ALS and these are used to convert it to a voltage with target
range.

> +        minimum: 1575
> +        maximum: 200000
> +
> +      ti,pwm-mode:
> +        type: boolean
> +        description:
> +          Switch for mode in which ALS is running. If this property is set
> +          then ALS is running in PWM mode, internal resistor value is set to
> +          high-impedance (0) and ti,resistor-ohm property is ignored.
I'd mention the ALS is an external device - so this is saying what interface thing
thing connected is using.

> +
> +    required:
> +      - compatible
> +
> +    anyOf:
> +      - required:
> +          - ti,resistor-ohm
> +      - required:
> +          - ti,pwm-mode
> +
> +patternProperties:
> +  "^backlight@[01]$":
> +    $ref: /schemas/leds/backlight/ti,lm3533-backlight.yaml#
> +
> +  "^led@[2-5]$":
> +    $ref: /schemas/leds/ti,lm3533-leds.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - light-sensor
> +  - backlight@0
> +  - backlight@1

Similar for the led nodes.

> +  - led@2
> +  - led@3
> +  - led@4
> +  - led@5

Curious - why are all the led nodes required?  What if some aren't wired to anything?

> +
> +additionalProperties: false

