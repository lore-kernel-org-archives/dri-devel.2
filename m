Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF55C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D4710F726;
	Fri,  3 Jul 2026 09:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jraEe4ez";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2BC910F726
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 09:49:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5850341372;
 Fri,  3 Jul 2026 09:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F761F000E9;
 Fri,  3 Jul 2026 09:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783072155;
 bh=TbsIW8A8QV+QRdEo3sVmZwQGoZ0T+VvR1pXly6UWHO4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jraEe4ezfUrBu8c5arE/ttedlAbJe8UgGD1hI9VVAUNsV+7mtMP+oa6Zs8CqXCGej
 dPLbBRrOXqogFlY4pn8oL72XZqIR5zfcNO9VcdWTBK9j4YSlbXlQQ+0gEXpCdiT/n5
 fZ62nzdpF9dv9h+flM0XQ61BT4zJGwufqN/V2Ep4InjfK6ydM9GTa63SND9yR1a9fO
 cKd1avCYbTxzFkjkKj2oGQqHpB1wNP782n6OwGTMfdyThBUD86YdwBKCc5SBGxZnKA
 viZ8FNzVkQDrzY3LTr+MioRdt1z/xA9gc9DHbhbM3HRPbghSBIc7qSOTY7a/El36OX
 5Q3DZQraooSYw==
Received: from johan by xi.lan with local (Exim 4.99.3)
 (envelope-from <johan@kernel.org>) id 1wfaWG-00000000hvY-3m36;
 Fri, 03 Jul 2026 11:49:12 +0200
Date: Fri, 3 Jul 2026 11:49:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 01/14] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <akeFmMQ_S1Y18hlu@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-2-clamor95@gmail.com>
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

On Wed, Jun 17, 2026 at 11:00:18AM +0300, Svyatoslav Ryhel wrote:
> Document the LM3533 - a complete power source for backlight, keypad and
> indicator LEDs in smartphone handsets. The high-voltage inductive boost
> converter provides the power for two series LED strings display backlight
> and keypad functions.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org> #for light sensor
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backlight
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led-controller@36 {
> +            compatible = "ti,lm3533";
> +            reg = <0x36>;
> +
> +            enable-gpios = <&gpio 110 GPIO_ACTIVE_HIGH>;
> +            vin-supply = <&vdd_3v3_bat>;
> +
> +            ti,boost-ovp-microvolt = <24000000>;
> +            ti,boost-freq-hz = <500000>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            backlight@0 {
> +                compatible = "ti,lm3533-backlight";
> +                reg = <0>;
> +
> +                default-brightness = <113>;
> +
> +                led-max-microamp = <23400>;
> +                led-sources = <0 1>;
> +            };
> +
> +            led@2 {
> +                compatible = "ti,lm3533-leds";
> +                reg = <2>;
> +
> +                led-max-microamp = <23400>;
> +                led-sources = <0 1>;
> +            };
> +
> +            led@4 {
> +                compatible = "ti,lm3533-leds";
> +                reg = <4>;
> +
> +                led-max-microamp = <23400>;
> +                led-sources = <2>;
> +            };
> +
> +            led@5 {
> +                compatible = "ti,lm3533-leds";
> +                reg = <5>;
> +
> +                led-max-microamp = <23400>;
> +                led-sources = <3 4>;
> +            };
> +
> +            light-sensor {

Doesn't the binding (or dts) checker complain about this node not having
an address?

> +                compatible = "ti,lm3533-als";
> +
> +                interrupt-parent = <&gpio>;
> +                interrupts = <80 IRQ_TYPE_LEVEL_LOW>;
> +
> +                ti,pwm-mode;
> +            };
> +        };
> +    };
> +...

Johan
