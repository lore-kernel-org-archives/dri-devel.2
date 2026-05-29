Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C9ACD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 09:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A392210FC1C;
	Fri, 29 May 2026 09:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ePYRdHFI";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA1F10FC1C
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:51:11 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso80400055e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780048270; x=1780653070;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qf1xsznGow3Mq8kqI6r2C6YXYEYFaDdBn6M5Ic+GMxw=;
 b=ePYRdHFI8X29Hwt+NwdYlRoHXlpLC8lZN+zVfglnOEa53MZc0vZbsT7N42tuEl+X6R
 dArzuFpUKCsdzlWwbwTFev9cTLEM5enhGV3i9U9+eZIqwEm+ozQl1wkky5VyVx3md9PA
 Y1kGCMC1CHY+l28D1LDF/uKAhnxa3MsEoR3P4QWku1ejPZ9r2nZuWEVMoV3XsdROXKX3
 L/l2y3wRRBYMGO/hN5N35KY03QPr/ztwCgDddad4+QiXC3fiYQWryG+nhj+B74AoR6G7
 BiWZJ7I3Pbb7mHEDYM7L08VyJqcFdtz627t3WmmuRdd6CCRcXde/4e5xw8py9Vw6Les4
 s8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780048270; x=1780653070;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qf1xsznGow3Mq8kqI6r2C6YXYEYFaDdBn6M5Ic+GMxw=;
 b=Brmw99ThY6kZMBufSWRUbjqo1TGdtt1k0TfTouXpL7EonZmw9299T0jj5n+pHCIOfm
 mggGKCkag013J3bS+rOX02U19QMKgetZIuuyVwiTTjOTi0+rPfuvdVKgLue/i/qvy3NI
 MSgy1mroo3HPTg7/K2M20cgeykTSn0klPVpnZlvANQsDQBotAWEIst54dueNt1cIf1Qp
 fKtFCY16xDtAsXa4OlwlPSVoEu5AqtjMdL3FkbigS2BBhNUb4kubiPeLNGaNkLTLWBR4
 bbQ0Ks5x/5VWEsOET4UPePtQiZrt0Daeop+uX0GMXbOUaynmJ+8f5+5XQW+kutJ8my4j
 CQbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DSJrp5aLTz5hz/EV1fcFIAbcORseMDCHzjGLHYuRmZeQSQTquI4f/ZcEwjr7twaGLZWQkgStsWu0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbTWPE9l/7HfQEWj2l84XlX7Nn2omLxafR9OFyP7xREHPS/M44
 UR4Y+jT6kCP0XPSQhAi9yg/05C56EaiVIyQkDLShGXmtHqMEbP06B3cEP7b3YWH88Pw=
X-Gm-Gg: Acq92OEiIb4/EfHA6H+tAY4Z3oPcvu9tFjqmKlNjj/cBMD2l7DRfC1Ji2iUME+34X+z
 saSubg+7u7/I0qjoVoX9CYeAE4BBxfQaR7YLuCf03qQUq++SvvlcJm/70ANari0L+p/i/E6qGBk
 yp4By4U3kweJwbqp4g798fWx0XmsgIRRnCNBCLflBbshAhdxHaiCqfWQl77qWHXcgoWagWWIAzL
 mM4qKF6rOXWXMkqr8x/AoI4zVAsZmaLn7blQkbPcoLL2GMXMyGM/xjIuYecnmbXfbWtax6uLFD4
 85Ni3QSWT5tHODQ++39IM2bsBW1mTxaLDY2+iDuFC/lDYydz5SlcD9qTISPvsC88kzH8Ld8lE/D
 wYf+rnrU1+oHBzjSHuIi584BwzSpQlGFkZdmgzopoyLcAjrXCRfGYzfHAJEV2BvYpHRi6cOv/tc
 vqZxbVq6zLC+k/oLOu3LfbipLocNp/Q/TrQnf7iQC9PPCgfaC5EiSOFQBOW44HODd42F1t0WkRw
 8UVRqw1AAhvAGR38VL5U3PFb1QK0Pb8LwfWaFVLsBsQPUFrbgyMk2ZDrATmutpP4m9P98FOUMuI
 +g8G5vOedFyAy3QNgl8=
X-Received: by 2002:a05:600c:12d1:b0:48a:5970:1fe1 with SMTP id
 5b1f17b1804b1-4909c091fd2mr22900055e9.4.1780048269850; 
 Fri, 29 May 2026 02:51:09 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm2337806f8f.29.2026.05.29.02.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 02:51:08 -0700 (PDT)
Date: Fri, 29 May 2026 10:51:06 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <ahlhinOh3NxB7FY_@aspen.lan>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528135123.103745-2-clamor95@gmail.com>
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

On Thu, May 28, 2026 at 04:51:18PM +0300, Svyatoslav Ryhel wrote:
> Document the LM3533 - a complete power source for backlight, keypad and
> indicator LEDs in smartphone handsets. The high-voltage inductive boost
> converter provides the power for two series LED strings display backlight
> and keypad functions.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++++
>  .../bindings/leds/ti,lm3533-leds.yaml         |  66 +++++++
>  .../devicetree/bindings/leds/ti,lm3533.yaml   | 170 ++++++++++++++++++
>  3 files changed, 304 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
>  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
>  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
> new file mode 100644
> index 000000000000..866b0fb8ed04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/ti,lm3533-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LM3533 high voltage series LED strings
> +
> +description:
> +  This is part of the TI LM3533 MFD device. It represents two high voltage series
> +  LED strings for display backlight controlled by the TI LM3533.
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/leds/backlight/common.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,lm3533-backlight
> +
> +  reg:
> +    description: Control bank selection (0 = bank A, 1 = bank B).
> +    maximum: 1
>    <snip>
> +  ti,pwm-config-mask:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Control Bank PWM Configuration Register mask that allows to configure
> +      PWM input in Zones 0-4
> +      BIT(0) - PWM Input is enabled
> +      BIT(1) - PWM Input is enabled in Zone 0
> +      BIT(2) - PWM Input is enabled in Zone 1
> +      BIT(3) - PWM Input is enabled in Zone 2
> +      BIT(4) - PWM Input is enabled in Zone 3
> +      BIT(5) - PWM Input is enabled in Zone 4

This is optional and the drive implements a default (zero) that is not
documented here.

Is zero a sane default from a DT binding point of view?


Daniel.
