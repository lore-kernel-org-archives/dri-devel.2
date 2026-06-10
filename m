Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D467CCD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365EE89FA5;
	Wed, 10 Jun 2026 14:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cjXAHSKi";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E4BF89FF9
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:45:40 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-3075ce9c05aso919284eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102740; cv=none;
 d=google.com; s=arc-20240605;
 b=k3X4x9fKsClhIKhccItqSqEaxSQ7j5yqzkMDgySrcD980fVrt+vOzjPzvsyKDvugbQ
 f3yuTF6CN3DuzyzhK9RtwKJWQxUCxqEXYWof4O0V9IpTLoK7lhe6gWpyEvFm03x7BURb
 T+unPuvovZyPnFvSt6bFpH5qOGYOzTTaKIR7nPRer78RzbXrQZMebX3lkpOReE29IJLR
 C+OBDrKoZNRf+j0WPBh+f6GPbAmhOxU05tp25ElWAkVQk4sPjNIeRg2ITCuD4OrdG+3Y
 OL+S7xBzduBjGviU+kiM8uoB3tq8sL27R7+PCet77V4of2iNfCUGqpnQceHRdfEfOFBw
 Quhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c9jdnGhl8zT/c5+VTx28YYMOorOCQjdA4WuOVZ2PMo0=;
 fh=7EMu4DvGTL9LkmiyLwKBcoSDjMXew9YgsMx8YvitqBE=;
 b=gCd1rh6Cg7Ud13M2JIt/he38413ywlGRwVLndGPco9VntNG58BMMx/w0PU97MWkFzO
 IRye98+3FQgGMRItZbUrf5p+e9gIdXKNbD158qTchUhNoEEVuKYrl55RbCnqOjXa0cjn
 p4uvqoLa/tZ2xIubC0OhZqFTJyYmSTAZCNQL/rg28ywA12tIeuyCrai7cSA/p1tBhEgB
 mghsXJv48xqRE7ZWY2ZLPCcnDFBAT3zGSsiGHR1UB33eM3qYiyaaphgWRmOo2l0QYbDY
 4Ym5TpaVexmqcay6FzWazPJ2dAiuj2qjEL3t4uauH6l+3AZmlgg5cZD9ZuwRn+J7wN3q
 R+rA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102740; x=1781707540; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9jdnGhl8zT/c5+VTx28YYMOorOCQjdA4WuOVZ2PMo0=;
 b=cjXAHSKimh17s0f3HqlGCStBFCtoeylZhrRrEqKlin4ihceUeeY2bHzWJY4MIDTTVp
 Oey9vtztavOE0KbeGUnskc4hQG78GtEfVBOojSGnitkThEqHZNvQ/c5SphrBHJzFk+KZ
 f2JSxGUrdZcwEd4zHrJObh+iUPrIad8Ho54Stn/TP80ZtUWgkeKT8ASaX8ynHwZzikDO
 rdOxsqT+rygFNIeoYhlzmVc7m3cjjHPnu1jXESPeZ8tPSiqTEhMfm/FJopHL1sXvjD+q
 UI/Xe5wf6gDar73SatRcS3LjYHJUVy6Rxk2lwd4nau3jyYjzziK4rWieOp8SY9v5dr6/
 xJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102740; x=1781707540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c9jdnGhl8zT/c5+VTx28YYMOorOCQjdA4WuOVZ2PMo0=;
 b=ctKR/X5/c0nm2LBnGySSplbib6Kg/OpTDL8TD1W4mPZZpx8tgb8q0vr41QDMONCDCs
 1esi1TP7dSh0diJAZ5cxenu2S7Gp7lfp1MnPrWtzVRuL3355jJL22ds1MM+DisNVZl6A
 Me0k4fqtZIR2ShGQm37VblisuqQrrk7Lb4KuNEbWEFq7wTaqYVVEF30dfFZm5+qQEjR2
 b8ueUiKnDPSJkZTIZq8CIeuM4reXG86qdjFK0k49VL722daTzEd9kV8S0F3kmBUTdCuf
 Lz7MPw+QAsXNiPj0sWNmwLkjZTcB5KTSh7KlG6VHVPPmOUJr+85yRJMfWkT4nsT4NVgt
 Wukg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9H8FUsp2AXBM1SUeTNSlSY4LiWrUK5DYyulU1YjTQsmTnGeDBgqEFWsUDItfhEcMvXPh12C3a7qxY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjT3Qpk7MPupwbxuC1QAoB6P7kQ5Jx7fLehouSODort6sYNUPZ
 +FYaaa+aFkkSwAphqJadrYQDthqrFQuVM4zm72FGH5qRtQOORRotv1GXLHqBKx3EAyYnehTGp7v
 a0WAm+ghW1OBZFSwBhx5/PGdvJDMrj4U=
X-Gm-Gg: Acq92OG+DNMThrA4MP4h+Zr3gEwJrFQxX98Qlj3/lfvhkpyCLFutbW1bPuJ14n7qo4m
 E/ZxcyBSjkunP7aOUbuol+thpbdKvZpr2NTB3agHm15r+PhFA174SI/FcxHy/p0XiZlszBg8ObP
 RXTlyUcpHbhoN/7SBLxJ5XF9lhnRT7EfuseQ0CB9F3pJvG4XcCfghAkrqimV5lL+8YSMJdcAQ8V
 FfqfJJDMQ+62dlfT/vnnDiDnHOgF5SzxR7aEikfbhe+07tyKJYrsfEnxiutQveUCfCjdn4NhRxy
 0xrFQnPKVFec4hb6+I8=
X-Received: by 2002:a05:7300:4307:b0:2ce:3aa1:d39b with SMTP id
 5a478bee46e88-3077b1e1921mr16407205eec.20.1781102739833; Wed, 10 Jun 2026
 07:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-15-clamor95@gmail.com>
 <aihoH9Pmzufa9pnE@ashevche-desk.local>
In-Reply-To: <aihoH9Pmzufa9pnE@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:45:28 +0300
X-Gm-Features: AVVi8CdnB8ApS2xg5kxxnd98RqCsR1fmVPgPcGfJlrd3mQBMI1CAmZLqR9DFIrc
Message-ID: <CAPVz0n0m+i7wexfC0BWwvdOuJxDk_=x+EpxEbNmoHN1AsEmfNg@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] video: leds: backlight: lm3533: Support getting
 LED sources from DT
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:23=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:38AM +0300, Svyatoslav Ryhel wrote:
> > Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> > defined in the device tree.
>
> ...
>
> >  static int lm3533_led_setup(struct lm3533_led *led)
> >  {
> > -     int ret;
> > +     u32 output_cfg_shift =3D 0;
>
> No need to assign the default to this.
>

This is a personal preference, compiler will optimize it if this is not nee=
ded.

> > +     u32 output_cfg_val =3D 0;
> > +     u32 output_cfg_mask =3D 0;
> > +     int ret, i;
>
> No need to add 'i'.
>

This is personal preference as well. There is no strict rule that
iteration variable must be defined strictly in the for loop.

> > +     if (led->num_leds) {
> > +             for (i =3D 0; i < led->num_leds; i++) {
>
>                 for (unsigned int i =3D 0; i < led->num_leds; i++) {
>
> > +                     if (led->leds[i] >=3D LM3533_LVCTRLBANK_MAX)
> > +                             continue;
> > +
> > +                     output_cfg_shift =3D led->leds[i] * 2;
> > +                     output_cfg_val |=3D led->id << output_cfg_shift;
> > +                     output_cfg_mask |=3D OUTPUT_LVLED_MASK << output_=
cfg_shift;
> > +             }
> > +
> > +             /* LVLED1, LVLED2 and LVLED3 */
> > +             ret =3D regmap_update_bits(led->regmap, LM3533_REG_OUTPUT=
_CONF1,
> > +                                      output_cfg_mask << OUTPUT_CONF1_=
SHIFT,
> > +                                      output_cfg_val << OUTPUT_CONF1_S=
HIFT);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             /* LVLED4 and LVLED5 */
> > +             ret =3D regmap_update_bits(led->regmap, LM3533_REG_OUTPUT=
_CONF2,
> > +                                      output_cfg_mask >> OUTPUT_CONF2_=
SHIFT,
> > +                                      output_cfg_val >> OUTPUT_CONF2_S=
HIFT);
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> ...
>
> > +     if (led->num_leds > 0) {
> > +             ret =3D device_property_read_u32_array(&pdev->dev, "led-s=
ources",
> > +                                                  led->leds, led->num_=
leds);
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "failed to get led-sources\n"=
);
> > +                     goto err_deregister;
> > +             }
> > +     }
>
> This and other pieces may benefit from local variable
>
>         struct device *dev =3D &pdev->dev;
>
> defined at the top of the function.
>

Yes, but this would require an additional patch, which I will not add
to this already overinflated series.

> ...
>
> >  static int lm3533_bl_setup(struct lm3533_bl *bl)
>
> As per above.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
