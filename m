Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9877ACD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 10:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8B710FD01;
	Fri, 29 May 2026 10:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tLxuTnFW";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3439310FD01
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 10:56:30 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso200350eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 03:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780052189; cv=none;
 d=google.com; s=arc-20240605;
 b=ZhPpbtOV1yEaev7T8f0FdxmHMaxrqKM2tFtkyyxaVmIeb2za90Xg20hc2UGTBvUQZ9
 S1XszCB+rNekpIeqGzMDuqIhpiwk6VlmadobdDH45A9miv2/ydqMFWz++xwfrn6RyMt0
 Np3OX22nM1nJvHvdONYSJtdoDY3ySBS9KCXjrhic1flhL6y/69T813lWTCmhRnowSEOG
 nkgMOIRBtIAeFzRG3bFjoZS6xXXWEjLlwrHBNHkImZXkfQSiivFrmJeq6uRH8QXowWSn
 FOey8mLlFESaSckJu2gA6uP5yCWcaUFiZShlOHmNZVjb7VBcjo1NlROwCYcqjFuBla3d
 jUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QT9o7z8njCzuauXIRpTZNkDYlGBM5NI3aWAig5/bi7I=;
 fh=XijP9WFnrv9WT+t7ovRgmHZ66+ez+uYudBgDEeoXhUg=;
 b=Qb4+scmfQNfpgdvVEOhl9WncyhlAbCu1oOv8GaiTTQUH6AmP+h2v8W7eB9i6LC+FcF
 7ZPUDsedOvPppTF++gnlAQ9LUWGj5WJxp9uvF/yBr8uOu0RcnYie0ychGF0ggwKyQrrY
 a5i8VXnZtGEsc8Q5ISS6aIAJg+1o9GSQUBtPWRu3rCXS3QQ8n2pBw1Yr1ZjsJ2MaME56
 zi/2BVVT8EqHLZCS9mc8dPkO1junjGc1lJJEmLQ2kFkHxDmgjQIaQiRYtmetipWToWzx
 JHJ+fE5l5xBHHwYjL2EtMgQuBy390DokkmD2HL4V7O1WkN0UBbqhipLiNmdHwLYynHOy
 TgNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780052189; x=1780656989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QT9o7z8njCzuauXIRpTZNkDYlGBM5NI3aWAig5/bi7I=;
 b=tLxuTnFW+IiNdLMEQVFgk6MPPH+U1PPagVKUG9nGzvvx9mMO/tLyrUjlRW53292O/u
 63efg9Mllv5Sq6USXjK6RlJr5B5GsTgiarFZZlw80Y8//rUHtLU8JganI9P18dyZGmzR
 ilHOAqzceBGWiGRQzpCcUYrbi98qItYjnk+mAlJw3nNHmYt/jQdrBgd+8EnsGgWcilB1
 LHavXhiEIi6TdyG7liblurPZLoGRdaprpclwuY62Q5KS/ZhOPu2yE5Av+OzEStBQJo3H
 L4OQ9R+rY05WRoDDa9xiFxA7ygaimtcI/iEyMECUmioT3+wa5R1GvwcFWVPwi6pdKVYu
 wHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780052189; x=1780656989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QT9o7z8njCzuauXIRpTZNkDYlGBM5NI3aWAig5/bi7I=;
 b=Saa7zxHmK16JPOSc60LRVvitQ/4LYp2CTisZCfcgTqE8U4SawfbvdWhOzXoimDjEv2
 PyepLTdYA2YsMmBC6wq7tEMCrmGCBf61iVw//iS9YFuiuRkHfluSvmTAs2ux0whJYv8k
 UXOMHDm2zn0c3YnTNYQ7D/qvoyfVvEtfCrD/SlRg7FburKn8o62TEQZPGzdUwZxUmj4s
 vOW96L8bs7B+q144a9D13GZdiM19xadP8NfniwQCTZZik6Qox7gBqYsUT3RZa0k+JQrv
 GFsemdJ+2pGfpnXf92pkQOF/DIExxfeAVf6u0ee+u/Uvj3/9MreGqXQh9qjsnmw1qqcD
 rbEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SNMdr5ZBuezds7b+6C9LYTX+MvTxuyKyDhvFfY/O5YBn8+BuyVH8PbRC1RP31Rej3Q6KtLKo7XDU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRcgQAolUJvdELoB3/4GRkbgumdS9gx+YoyKAsqbLlIM+264Cq
 68ALeiFmMGfV8pO76WweAA28GLJjy/WhwQ7uq5W15Rg7CPsK09sM/SRNEGzMbpd+try2QTCmO5k
 5GMUQm6s4AefHz7zXN8HTUU2VnVr0yZ8=
X-Gm-Gg: Acq92OEZHVGtmRwWp8ozzLlq6LhIjGK2vTe4kuRPYPfx3eUDvCDSGAkPMSZIlp7vYzz
 hz0FYh8l3hnyLg7f6jrMzEmq0zsLRELsYTCa4BYHXYn9Tla5lStNkInwryVXEeHyNIU/V3uzyT2
 oqE5d99Sz45eARmTRchxjv8P9NvMqwkUdJJcfaXCo3NbW/huMy6BaeQkTJk6MrWlZLgOY85YwVM
 S7WArWi52rdM7lvcdiNBUEmOq+CCxGWE1hQT+H2BaivoqcaTh4yvGz72BU8vOcRhCuWXQ9VyjUA
 Q8d8wMPUcyuSDWnlWtXHkVacLPBOxg==
X-Received: by 2002:a05:7301:688a:b0:2da:4216:7ea3 with SMTP id
 5a478bee46e88-304eb16c784mr1065135eec.14.1780052189412; Fri, 29 May 2026
 03:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-2-clamor95@gmail.com>
 <ahlhinOh3NxB7FY_@aspen.lan>
 <CAPVz0n3C8D+amSRkF=Koj6Niu6u8uz4LbMoRYEX32_ECm5-tSQ@mail.gmail.com>
 <ahludIZPMUlPDTG_@aspen.lan>
In-Reply-To: <ahludIZPMUlPDTG_@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 13:56:16 +0300
X-Gm-Features: AVHnY4J2FFsbeePVzhdaZr1L7xTMY9M_-IQ9RntYfCEGWE3LHkP9pzzQ1jAxVDc
Message-ID: <CAPVz0n0XvQwLd6gv2kiVHfSTyM_jF142beSwWb3L9sBLEQDzZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: Document TI LM3533 LED
 controller
To: Daniel Thompson <daniel@riscstar.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
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

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:4=
6 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, May 29, 2026 at 01:07:50PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
12:51 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, May 28, 2026 at 04:51:18PM +0300, Svyatoslav Ryhel wrote:
> > > > Document the LM3533 - a complete power source for backlight, keypad=
 and
> > > > indicator LEDs in smartphone handsets. The high-voltage inductive b=
oost
> > > > converter provides the power for two series LED strings display bac=
klight
> > > > and keypad functions.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++++
> > > >  .../bindings/leds/ti,lm3533-leds.yaml         |  66 +++++++
> > > >  .../devicetree/bindings/leds/ti,lm3533.yaml   | 170 ++++++++++++++=
++++
> > > >  3 files changed, 304 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/leds/backligh=
t/ti,lm3533-backlight.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm353=
3-leds.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm353=
3.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm=
3533-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,l=
m3533-backlight.yaml
> > > > new file mode 100644
> > > > index 000000000000..866b0fb8ed04
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-ba=
cklight.yaml
> > > > @@ -0,0 +1,68 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/leds/backlight/ti,lm3533-backli=
ght.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: TI LM3533 high voltage series LED strings
> > > > +
> > > > +description:
> > > > +  This is part of the TI LM3533 MFD device. It represents two high=
 voltage series
> > > > +  LED strings for display backlight controlled by the TI LM3533.
> > > > +
> > > > +maintainers:
> > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/leds/backlight/common.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: ti,lm3533-backlight
> > > > +
> > > > +  reg:
> > > > +    description: Control bank selection (0 =3D bank A, 1 =3D bank =
B).
> > > > +    maximum: 1
> > > >    <snip>
> > > > +  ti,pwm-config-mask:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: |
> > > > +      Control Bank PWM Configuration Register mask that allows to =
configure
> > > > +      PWM input in Zones 0-4
> > > > +      BIT(0) - PWM Input is enabled
> > > > +      BIT(1) - PWM Input is enabled in Zone 0
> > > > +      BIT(2) - PWM Input is enabled in Zone 1
> > > > +      BIT(3) - PWM Input is enabled in Zone 2
> > > > +      BIT(4) - PWM Input is enabled in Zone 3
> > > > +      BIT(5) - PWM Input is enabled in Zone 4
> > >
> > > This is optional and the drive implements a default (zero) that is no=
t
> > > documented here.
> > >
> > > Is zero a sane default from a DT binding point of view?
> > >
> >
> > Yes, if property is missing then PWM input is disabled which is
> > equivalent to setting all bits to 0.
>
> So the default should be documented in the bindings?
>

Ye, sure, I can do that.

>
> Daniel.
