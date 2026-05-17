Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D18CD4F21
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 14:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812E610E27A;
	Sun, 17 May 2026 14:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DUfwGsU7";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A7D510E27A
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 14:27:10 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2ee990e8597so4361966eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 07:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779028029; cv=none;
 d=google.com; s=arc-20240605;
 b=HJXcnWsKqa6cRBaMnHX8fAdDOxg7fE84mYkuco4npw0qWixJ37+70dQbH5jEodCmZd
 AIKZw3vid/knHTzkCKl3OuAiMW57Vjml3ucqzv1X7Qtxljw/ZdW+7BoxuTkLiRmsyXIq
 T3r86kn/yLNbDCsDrmVkjVgVViOZf8I5pcyLaWsOzQOEp5Sh/CXusZCr/3u+J1/poAVV
 xusgobsobji5nxchmzUgrA4mNOPLmehZXrIu9JiavkwZEuYr2jbbFFfoisg6/jfF7sUZ
 mTPCE5QUo0iYZ1SDYx8e7bNhslsv5X/ttjobFqG/PwAK1l2N7TI36FooSCYw6LpCtP/2
 rVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/a8k6USexvPeSs3shg8rdzm72XqtvkOnD2zVZ13eQgA=;
 fh=05NpuNhn+iJZAQ4MKazXd7RHzuYIF363CAcioeW5lAE=;
 b=MxN3m9fc/oHYezYp8qc/6SbKZl/3r2MrkcBuBCMOobuAnl/V9hP/Ic/qQjwrngk62b
 i5W9tFTHrIJ8mVcIdJzYjcnFYE0Xb3sXwNdKCxPtxBB9cswEnkWZ+O9azxgPGAM3/EMX
 XgmLYrG1SoyTODQXknKzWxyxGvCEoZgJtUftBP1TQsnq72ySURII8FBgzLW4BnEJB5MI
 UCWNzuiHjI/wFUi8zEaVYavfdvpBeY1oz84kQpinKz9CCXAxHsbkhKUFtCGMUldoe1ie
 mu9NFNavF2bihIa/xZGt5rTBmHpua9G+tdA0SamZE1Fq6TM+JWwD5P9K3x9efIX+JzNK
 ikLA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779028029; x=1779632829; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/a8k6USexvPeSs3shg8rdzm72XqtvkOnD2zVZ13eQgA=;
 b=DUfwGsU7RJ0lGpMU7NY4e6qQ8r7hkv4DNndJzdbfDiDPqFhd0jVg9GF9cXjKOMmkB3
 MsMs5QFg4LEYbp6ihDk7uHbUvkGhjze3aZDf8QmFEt+kNeoXvwJg4Q1eql0FKzacfrXS
 u/cISq12JnAIzBm2fIKbKJTxzjAM+1QJWQrHK/KFerjyP0Kra5EkpAL1boAXJT5GzG7P
 fVHucT2EpGPFQaiZBEiLDm9Lr1T/XbjlidGL+xq2iO7JiWP1jeGhkOtiFHn5BMPecQSa
 EIJTMi6mwbfr1Ya7Lw1XtNxHYO3z1jISJQIzUmnPjDtJ6h/9Z0Iz2L+WNlOTRP8rlF5n
 13ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779028029; x=1779632829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/a8k6USexvPeSs3shg8rdzm72XqtvkOnD2zVZ13eQgA=;
 b=T+C3ivxUCHJ3+p63FPHd38+FbnkIKQVk7hZ4qkVh4X8qOHXo95tSW0KCTfclKlfgIH
 kf+XWdpCplI2eSV1EqsWBXmo4zP6fK9lglFHYDJMF02VuNAEckh0ON1XNAlpi1uvFPNZ
 UycLb1iJrL+OGfiNNTel7LhOeagTjLQdX9KyFaHh3u5f/bT4Rd8G3gz5GlvoezvcB/IE
 iTQEhF42AkHemxVO0ci3KHaFUwp6xua9ThNACxO7nMeQwIja9KwK/VgXRtkdG20CjrU8
 LRmJ9ZuXrmzKg9owgu5gL0ZSudoWdRMqu1FNw0mDLjveL/A5987r4clh4HCWN/EaxGxp
 n4rA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6daH4u98mPMkl5vNue8chYgU/DNWOxZDTbqaTqpUmhUcDXtRLtuGz7ia07/FGe8iZTY2M49dxVnE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8PuDnGxXLkyON6XzKlgpqWNNprR2bFPSMAqsS1iwoccLwY5LN
 sBGer0PC5IY0dl89qI3aw4L4K2VKzoU4G7aRQxPDdoL3DMHOzh51SjeDDuoEpnhIH+JRnkOVZ1q
 Qr4CNhN79b0ZItSvghTi++x6vzgnesHs=
X-Gm-Gg: Acq92OHVlrIufCUmLsFavsMoQ8lYVlpT0D9uDHWfPg+6HZ6zB3b+e2okILtww+QoByy
 LBpHrbdRTl5Cof4GnYwv74s/I4gMGrQf3xeB1p0Dnlaixa1j6XjMJfhL8NfbyzKbiT3c4lt+Nf8
 2VuEoC9K3sQ2llQFjvcaCFdXAnrUR2cyWdObPqewOURHTE+N5eC/AB534h0PuEh2aLq3Eu9JmFi
 X1ayEL56s5SB+9M0LNlhG3+kw7C679zuNDVN9X+nk5BQd2drKa+O5eYkT/H85rizlzX8+zEIRgH
 YTcvoBpH
X-Received: by 2002:a05:7300:a907:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-30398680c36mr5240683eec.22.1779028029014; Sun, 17 May 2026
 07:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com>
 <20260517074306.30937-2-clamor95@gmail.com>
 <20260517144453.61cc210c@jic23-huawei>
In-Reply-To: <20260517144453.61cc210c@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 17:26:57 +0300
X-Gm-Features: AVHnY4IEMjYjQh2-EeqHWPNZxgaMpOfNHnP0k3ytWy1tFi4KeKl3gs6PRb7odls
Message-ID: <CAPVz0n10naSo_1n99orPGM4U8iDkOn1DW9Xe_RGE56CMpLm8kQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] dt-bindings: leds: Document TI LM3533 LED
 controller
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16:4=
5 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 17 May 2026 10:43:01 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Document the LM3533 - a complete power source for backlight, keypad and
> > indicator LEDs in smartphone handsets. The high-voltage inductive boost
> > converter provides the power for two series LED strings display backlig=
ht
> > and keypad functions.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Hi Svyatoslav,
>
> I focused on the ALS part.. A few comments.
>
> > +# see ti,lm3533.yaml for an example
> > diff --git a/Documentation/devicetree/bindings/leds/ti,lm3533.yaml b/Do=
cumentation/devicetree/bindings/leds/ti,lm3533.yaml
> > new file mode 100644
> > index 000000000000..2e200f172400
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/ti,lm3533.yaml
> > @@ -0,0 +1,190 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/ti,lm3533.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI LM3533 Complete Lighting Power Solution
> > +
> > +description: >
> > +  The LM3533 is a complete power source for backlight, keypad, and ind=
icator LEDs
> > +  in smartphone handsets. The high-voltage inductive boost converter p=
rovides the
> > +  power for two high voltage series LED strings for display backlight =
and four low
> > +  voltage control banks for individual LEDs. Additionally, LM3533 feat=
ures an ALS
> > +  sensor support.
> Mention it is an interface for an external ALS.
>

Noted, thank you!

> > +  light-sensor:
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        const: ti,lm3533-als
> > +
> > +      interrupts:
> > +        maxItems: 1
> > +
> > +      ti,resistor-ohm:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Internal configuration resister value when ALS is in Analog =
Sensor
> > +          mode and PWM mode is disabled.
>
> Good to note why this is a firmware thing rather than a userspace control=
led
> thing. I looked it up, it's because expectation is the input is a current=
 from
> the external analog ALS and these are used to convert it to a voltage wit=
h target
> range.
>

I will include your explanation.

> > +        minimum: 1575
> > +        maximum: 200000
> > +
> > +      ti,pwm-mode:
> > +        type: boolean
> > +        description:
> > +          Switch for mode in which ALS is running. If this property is=
 set
> > +          then ALS is running in PWM mode, internal resistor value is =
set to
> > +          high-impedance (0) and ti,resistor-ohm property is ignored.
> I'd mention the ALS is an external device - so this is saying what interf=
ace thing
> thing connected is using.
>

Noted

> > +
> > +    required:
> > +      - compatible
> > +
> > +    anyOf:
> > +      - required:
> > +          - ti,resistor-ohm
> > +      - required:
> > +          - ti,pwm-mode
> > +
> > +patternProperties:
> > +  "^backlight@[01]$":
> > +    $ref: /schemas/leds/backlight/ti,lm3533-backlight.yaml#
> > +
> > +  "^led@[2-5]$":
> > +    $ref: /schemas/leds/ti,lm3533-leds.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - light-sensor
> > +  - backlight@0
> > +  - backlight@1
>
> Similar for the led nodes.
>
> > +  - led@2
> > +  - led@3
> > +  - led@4
> > +  - led@5
>
> Curious - why are all the led nodes required?  What if some aren't wired =
to anything?
>

This is limitations of mfd devices. If it has subnodes, all subnodes
must be present to reflect mfd composition. Unused nodes should be
disabled.

However, I have asked Lee if he is fine if I will program dynamic mfd
composition based on the device tree. If he is fine, "required"
props/nodes list will be reduced.

> > +
> > +additionalProperties: false
>
