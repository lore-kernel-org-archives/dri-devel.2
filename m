Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEE0CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 10:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F4810FC67;
	Fri, 29 May 2026 10:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S5XP5flk";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F1E10FC67
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 10:08:02 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-304d8e3bb72so140201eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 03:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780049282; cv=none;
 d=google.com; s=arc-20240605;
 b=W/Go/bC56LLBZGmZgXA7WQAUoG/vAXRMc6+pcwUMusQoJ4VQlrC4t2Z0Tsh0UT05s6
 4AjJyzqF7WMioSqbh9BwDkDS/G7hThQorP5/Xy2h6D8u9YFjXv/6iW0ap4fDQ0qZw5Xq
 IlD+cQDExVUFjd9HlznitvvkmzU96GwG7zoS348XD2hkZI4VjVdue6SUXWIi2l+qYOWO
 Wv6FCc97bI2x6c5/DusMq08FUUSg33kQfrXs354fCrCXZqRtEoUqYHOV/v470pTy+g0b
 YIcX30YqxOhLvF02tNnX3a52N8zmdLMmrcYnFWqiSx6GsZEzotBAGqJ9SA1Tfse9o9/V
 I8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kFYmm3B1m2K2OFAsTX7e06En+33NHgtZEIHcXjaWAp4=;
 fh=4GL2ohCW+KSv9UY7Sc6TG9KU+D0l18ubVMlwT5Fm+54=;
 b=EPda+v/FMDt21Xjz4t++JMTkYp9OdOsm5CZCXYqVLiQHNwtC62gtouG/vrn56fct8I
 eWbw8gUuu40c9B4pByB1KIEOiAsdMmu3An96z47V1tfj8/FshFoROMI1uRj/jxFied0h
 S6nTfH9KucVzbsCx62IPguzOJvA7Ts+JdDmzunHAYPxSykqg736XmVNzBVn8GFfzGiLv
 B0QkBARk1FE3CIj7HyV/MEwLbchaNTVmXW18fY/Te3DSRtng4uBpKar9E3CV0uvvr0k8
 pvoGjkQ7pU+Da5SzjK+BNwCvPYHoGedoa07NHSw2sbDSUDjrap+jWFTJEdw9vKwcTWmj
 h8rg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780049282; x=1780654082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kFYmm3B1m2K2OFAsTX7e06En+33NHgtZEIHcXjaWAp4=;
 b=S5XP5flk5EMCr7UbPEe4llbqdB/d9TNHX4T+CkbYZlA1I8g3gpw6IQf/RQnulcvp4j
 ZRJSH5AwkJ64Ha3O1Dob9fUy878HGaA2/YQBNYDWDVW/w9cWerQnW54qwebPfH1Z4Igs
 mv0mF9is5UVSi8SgP3pn/QjByMaLL3WLN866XabMTR9KAGiYZYD26lftOljBumG1tkI/
 l/kwcpHN602yjxKcTJAFp7inAzJrhZMTrLdQ2diTAuTlCD5qcl2rMiGgfARJ7nKJX9iL
 7izKHtwxm5f0EJS1ILan9yhRh2qBZ2fknZ8dzGuyzlZgkGxJ12cZpxiXA4O/Sv3UijuQ
 lsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049282; x=1780654082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kFYmm3B1m2K2OFAsTX7e06En+33NHgtZEIHcXjaWAp4=;
 b=LuIKWLiM5LnLaPV3PeyJFEAP1XVpZ1OVOt8mbmjLxvUYL7MppvmhUaB3uhKV3/XMbr
 vVl65hOjlg+vquhXlhzNZ8S3V77sO9eqF3XiGKtDh14RNE/CP7Kvx+vtDO+1/n4svq2U
 OBzSxMsSeuLQkkSA26erX3BjswZ3OnRDlOwn1UEvmeEEhSx9maSYj0Hl7vkX/zUbD5SO
 Pk4CiE+6GKJAjirAXcLk0hsi69hCkhjDBwg8IKIJIFVcgoGjQEnJt/sV7EaJUOy9HZZ6
 VvB2XqsAOmx4yM0gqWAsGStFN8FN0TB3PqoT2hC68SdTeCbUTDnU9qo6Do4WLzY0pWfo
 +jHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sdk/x1iXBeZiGjnBnL6np9fV8ei4R2Jz4mzpFU7O/2gjRGASeHh5tUY1fc2O+o2PMOqw6J40Nn0k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypdKp04mPpeY919R27I9CY96XMjXnlnBdnl9YuKgv23d8EfahL
 ZSLHe2xoQ2UNosSme8J9K05aoTmgbYT8BiEvbyEtJ0+ZTFvoCWjLcOHN099aON4hveWN2uKAQaH
 hQGpTAT/vO6jFn2LMb7HCF0GUBVWsT38=
X-Gm-Gg: Acq92OEvpNoIvZ2oiKLe+a9M4IhcHmdYREXtYIIkSTHq5p/vCy8TLTqzEiELW4L0qR3
 Iz0ti+cAUeaGqdYLWdxFGZD1ZMfhesspcS0UwZUvjlQRP3yMO2K0vXuUCoFzeZa649sq/0NKfR+
 Pcaj27eoZ2qWNpfeMY0Ae94mmNoKGGClga7EOZqRpOuni93QZBOUSR9gRr7FI2pitiMis4p/GIP
 YZP6gU4kVWFD/4UafAN12kCWX2YIUhZxhHwqWOR4eUlw7s70qS00J4ilQ0ZxR25TkOS5ZJaAZXb
 Ht81+IdymspvonlWImA=
X-Received: by 2002:a05:7301:6093:b0:304:aca:35c5 with SMTP id
 5a478bee46e88-304eb228f12mr937539eec.23.1780049281982; Fri, 29 May 2026
 03:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-2-clamor95@gmail.com>
 <ahlhinOh3NxB7FY_@aspen.lan>
In-Reply-To: <ahlhinOh3NxB7FY_@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 13:07:50 +0300
X-Gm-Features: AVHnY4Ju4apl_6PVevGT822qLIzQw2MECBwLZ58e2K1CK8Q_oHMtYlAD2TA9TPk
Message-ID: <CAPVz0n3C8D+amSRkF=Koj6Niu6u8uz4LbMoRYEX32_ECm5-tSQ@mail.gmail.com>
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

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 12:5=
1 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, May 28, 2026 at 04:51:18PM +0300, Svyatoslav Ryhel wrote:
> > Document the LM3533 - a complete power source for backlight, keypad and
> > indicator LEDs in smartphone handsets. The high-voltage inductive boost
> > converter provides the power for two series LED strings display backlig=
ht
> > and keypad functions.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++++
> >  .../bindings/leds/ti,lm3533-leds.yaml         |  66 +++++++
> >  .../devicetree/bindings/leds/ti,lm3533.yaml   | 170 ++++++++++++++++++
> >  3 files changed, 304 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti=
,lm3533-backlight.yaml
> >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-le=
ds.yaml
> >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.ya=
ml
> >
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm3533=
-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lm353=
3-backlight.yaml
> > new file mode 100644
> > index 000000000000..866b0fb8ed04
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backli=
ght.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/ti,lm3533-backlight.=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI LM3533 high voltage series LED strings
> > +
> > +description:
> > +  This is part of the TI LM3533 MFD device. It represents two high vol=
tage series
> > +  LED strings for display backlight controlled by the TI LM3533.
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/leds/backlight/common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,lm3533-backlight
> > +
> > +  reg:
> > +    description: Control bank selection (0 =3D bank A, 1 =3D bank B).
> > +    maximum: 1
> >    <snip>
> > +  ti,pwm-config-mask:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Control Bank PWM Configuration Register mask that allows to conf=
igure
> > +      PWM input in Zones 0-4
> > +      BIT(0) - PWM Input is enabled
> > +      BIT(1) - PWM Input is enabled in Zone 0
> > +      BIT(2) - PWM Input is enabled in Zone 1
> > +      BIT(3) - PWM Input is enabled in Zone 2
> > +      BIT(4) - PWM Input is enabled in Zone 3
> > +      BIT(5) - PWM Input is enabled in Zone 4
>
> This is optional and the drive implements a default (zero) that is not
> documented here.
>
> Is zero a sane default from a DT binding point of view?
>

Yes, if property is missing then PWM input is disabled which is
equivalent to setting all bits to 0.

>
> Daniel.
