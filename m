Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BDBCD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 09:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4FE10FC02;
	Fri, 29 May 2026 09:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FiHzMU9g";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D1510FBF5
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 09:40:09 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304ec41197bso436127eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 02:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780047609; cv=none;
 d=google.com; s=arc-20240605;
 b=HbJrxtZ5H+d9ZXTN+VHo7Hb1E8QxjCyHINxCsntk1KWmile2uhkutoGwA4e2h7UlWP
 o228qKSxy/gkoleDaCzN05dQ+tCdFB9f32ZCZCcUpZyIUaDhP9iN2jGG10T03do5rlWo
 fv/tVQrbhXf6CMcpkbJWRiB5ol4uOGotUrgaRIB/2nnUYLQ5eSPW8GVNlCkGy1UOr/7w
 DvN0mWwla1yIuEQy1B53bKlyJsAWsJ2+5bEL4jrQp+sxC5dxmMVrvyYmxswFqaAO6tro
 lQCIj7Hbdwo/+Im9ZfhC2U2k60sBy76E3lY4DLn+uoexCetn7+0irZ82O57FuLF6LuQz
 M9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CNp8LY64my7Ot0qUd7egC8x+n5gTs/XUD+GWS+UeAxA=;
 fh=0IiwRNAWpw2eRISpE8Q11a1jehlUU3zlF0gEhumxRHQ=;
 b=ZGTTmuN5e2L7xZVCwSBUM8/9Em1kHFkYvT4MxBPUJgPgcDEUHPxUDcZyM5CM96QK46
 38cScbU8Iu4IqwJhLxCm0seQRktus+w+VAz1FPeUvaCNEL6OQtGKZW/sA0+znEvhQ1DR
 Hlal+RKtQHzZCrwcuXb178B3w1I9b+5UdvBbTwCq4LlE8lnzCfYxe5BQOPViCjUYSxJZ
 d73qqqwoHMAh57smhOOVbw3hUW2opGUrD2rARKEAiW3IYop/PFoTimg3FHuTU3//705s
 6vT/JtOpG0c4tKgZap+2q71SJQvxeGWb7r/yuEZySCXf1/C2/LU9tYfD1GiTIBjyge63
 M5cA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780047609; x=1780652409; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNp8LY64my7Ot0qUd7egC8x+n5gTs/XUD+GWS+UeAxA=;
 b=FiHzMU9gXxoHBk6T8Cq0Tr1cEz01egFzEdjlwgroZw4gBNAAV1FTE06B5RzSA3ygWV
 kruy9OCBm1mdiYacZsE0KDvrxu6UDWKs8TaSffqr2aoemuD7ypZ+6JjbcVmUqaxJzYwk
 FdacEzsGdzxP6Qi9bTz6Vo5zaq6DqB7OdjEqU/Rytw0GZLb2YS/FEs5lH3qTCTTAZ2yk
 Gj2OVxVmbNoDiUfp8X7LZnr7WXZDf64I/xXSn0JktLpSrOj8MmiAeBkZOi4Sf8bEK9QV
 DP3zzE3u+VzbGvCULtlxawIGf+hGjx5solAYPuQDcM+5R4nr5aAMLeoFY+vfcbOCOn1a
 lnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780047609; x=1780652409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CNp8LY64my7Ot0qUd7egC8x+n5gTs/XUD+GWS+UeAxA=;
 b=nexfFziFrjLFYqbmTFlppUZcCkrWORCfCs3S64m5WH8nAMo4cP7hY9w+AuttMD495V
 8j1QjlmYugvKH4VOszF4rgdUcoSHLjfx77CYWE7jWXii4p7fWaOhakGNLMoMp88kkX/w
 USY87O3sTd8EbzoBC43lfSRdizCaY4uguRIoeJ2xhTlvtSVGqCj0EwqBP7gVS2qI5CQZ
 j6T7hW70K7b2yQDKG8SGzT6tUIfHaPEeYz8MP551qGUXd1fuD8Qxyq3otpDDYuojzAwn
 IakwQTjlnfj4mL/vveAQqhWCFsmwpSJoTBDybEUMjYlfMsm5+iaVFhNPi0S7A8JuVibI
 6KMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ97vhEBgIiG9WexaPGfirfhO9UxlLCbF43AbT+NdPYydOX9fwnq9RsVwg1pJqwSNCNO+AuPR+gdnIY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXZBqtwgk+2EddvMKrVHmfTme45sCfUo4q6me4DgAZtqur/Ybl
 nIfka0a5ZKZVJ4sQ5FXkXRG3hRFvpxUgO8K1WPikaetxVuxMhyMHj7awLSfkeck5FsYkDpySzRK
 MN1AU4isu9PQmFPOSR9gBOMAFZyWPICg=
X-Gm-Gg: Acq92OGEgonB+Fz9BjngqNub3Ch3sGZIjI9M9285AX3C10n+oki8QEU9Xh6YZQaYySa
 Jk2SOia3ybmXkOCt9+ibY6VoFRjdqm8CPzPXuPACZit3cBZfIrVZ/wkD34eYRUkuHYqg6b2X3mZ
 4KGODAk21REVcpUqoLE29mmoQFU0E7p7B4oSTFhhBaQQSBoxQEPS2bDAc0alinIts68rikzzeQS
 gjLD9LK4RFRdS5mfHRe72ZeIdn9cFsdKfe2huzei2eMwucBvKumKANkV6Sq5d2FzzVJS7HrggFx
 DRJpqY6bQvao6QilltQ=
X-Received: by 2002:a05:7300:371e:b0:304:d75b:f5df with SMTP id
 5a478bee46e88-304eb1f674amr920610eec.19.1780047608587; Fri, 29 May 2026
 02:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-3-clamor95@gmail.com>
 <20260528155001.2bcb7003@jic23-huawei>
 <CAPVz0n0qCekQVGGyAyBuYv+RKC6bpydYBLJNGfPrgTYjtOJOuA@mail.gmail.com>
 <20260529100819.1823ebb3@jic23-huawei>
In-Reply-To: <20260529100819.1823ebb3@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 12:39:56 +0300
X-Gm-Features: AVHnY4KxytPKwIfHLJ8T1GXio2-Gko93x1b9EqyHTERy5U5OnXbey3uFJfFakx8
Message-ID: <CAPVz0n0VHdUo5oHdALgcerLsykdz-2n7c+jxYHrMOV7Ra5x_qQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mfd: lm3533: Convert to use OF bindings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
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

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 12:0=
8 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, 28 May 2026 18:03:31 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D1=87=D1=82, 28 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
17:50 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, 28 May 2026 16:51:19 +0300
> > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > >
> > > > Since there are no users of this driver via platform data, remove t=
he
> > > > platform data support and switch to using Device Tree bindings.
> > > > Additionally, optimize functions used only by platform data.
> > >
> > >
> > > At least the IIO ones would have made much the same amount of sense f=
or
> > > dt, just that they weren't having in the first place. I'd prefer that
>
> Gah. I write gibberish after too much reviewing.  having/helping!
>
> > > as a precursor patch to make the rest much more readable.
> > >
> >
> > I can add you preferences into this commit, I don't mind.
> >
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > >
> > > I only looked in detail at the iio bit. A few changes requested.
> > >
> > > > ---
> > > >  drivers/iio/light/lm3533-als.c      |  95 ++++------
> > > >  drivers/leds/leds-lm3533.c          |  51 ++++--
> > > >  drivers/mfd/lm3533-core.c           | 268 ++++++++++--------------=
----
> > > >  drivers/video/backlight/lm3533_bl.c |  52 ++++--
> > > >  include/linux/mfd/lm3533.h          |  51 +-----
> > > >  5 files changed, 212 insertions(+), 305 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3=
533-als.c
> > > > index 99f0b903018c..cbd337b73bd9 100644
> > > > --- a/drivers/iio/light/lm3533-als.c
> > > > +++ b/drivers/iio/light/lm3533-als.c
> > >
> > > > @@ -714,59 +720,33 @@ static const struct attribute_group lm3533_al=
s_attribute_group =3D {
> > > >       .attrs =3D lm3533_als_attributes
> > > >  };
> > > >
> > > > -static int lm3533_als_set_input_mode(struct lm3533_als *als, bool =
pwm_mode)
> > > > +static int lm3533_als_setup(struct lm3533_als *als)
> > > >  {
> > > > -     u8 mask =3D LM3533_ALS_INPUT_MODE_MASK;
> > > > -     u8 val;
> > > > +     struct device *dev =3D &als->pdev.dev;
> > > >       int ret;
> > > >
> > > > -     if (pwm_mode)
> > > > -             val =3D mask;     /* pwm input */
> > > > -     else
> > > > -             val =3D 0;        /* analog input */
> > > > -
> > > > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, val, =
mask);
> > > > -     if (ret) {
> > > > -             dev_err(&als->pdev->dev, "failed to set input mode %d=
\n",
> > > > -                                                             pwm_m=
ode);
> > > > -             return ret;
> > > > -     }
> > > > -
> > > > -     return 0;
> > > > -}
> > > > -
> > > > -static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
> > > > -{
> > > > -     int ret;
> > > > -
> > > > -     if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTO=
R_MAX) {
> > > > -             dev_err(&als->pdev->dev, "invalid resistor value\n");
> > > > -             return -EINVAL;
> > > > -     }
> > > > -
> > > > -     ret =3D lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_SEL=
ECT, val);
> > > > -     if (ret) {
> > > > -             dev_err(&als->pdev->dev, "failed to set resistor\n");
> > > > -             return ret;
> > > > -     }
> > > > +     device_property_read_u32(dev, "ti,resistor-value-ohm",
> > > > +                              &als->r_select);
> > > Does this have a default?  If so the pattern we've recently be settin=
g on for IIO
> > > is
> > >         if (device_property_present(dev, "ti,resistor-value-ohm"))
> > >                 ret =3D device_property_read_u32();
> > >                 if (ret) //corrupt property in some fashion
> > >                         return ret;
> > >         } else {
> > >                 //set default
> > >         }
> > > If there is no default then check it unconditionally.
> >
> > default value is LM3533_ALS_RESISTOR_MIN and if no property is present
> > clamp will ensure that als->r_select will be set to
> > LM3533_ALS_RESISTOR_MIN
>
> I don't see that default in the binding doc and relying in the 0 being cl=
amped
> isn't particularly readable - I'd set it explicitly.
>

Oh, ye, my bad. Schema enforces one of props to be present and if pwn
is present then resistor is ignored. What if I move resistor reading,
clamping and conversion under !als->pwm_mode check? Then resistor must
be present and hence must be checked unconditionally.

Additionally, I can comment original lm3533_als_setup with #if 0
#endif then git formatting will be much cleaner and easier to review,
and once we all come to result I will just remove entire commented
block and Lee can pick clean commits.

>
> >
> > >
> > > >
> > > > -     return 0;
> > > > -}
> > > > +     als->r_select =3D clamp(als->r_select, LM3533_ALS_RESISTOR_MI=
N,
> > > > +                           LM3533_ALS_RESISTOR_MAX);
> > > > +     als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * als->r_select)=
;
> > > >
> > > > -static int lm3533_als_setup(struct lm3533_als *als,
> > > > -                         const struct lm3533_als_platform_data *pd=
ata)
> > > > -{
> > > > -     int ret;
> > > > +     als->pwm_mode =3D device_property_read_bool(dev, "ti,pwm-mode=
");
> > > >
> > > > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > > > +     ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF, als->pwm_m=
ode ?
> > > > +                         LM3533_ALS_INPUT_MODE_MASK : 0,
> > >
> > > That's ugly.  Better as
> > >
> > >         ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF,
> > >                             als->pwm_mode ? LM3533_ALS_INPUT_MODE_MAS=
K : 0,
> > >
> >
> > Yes sure, just followed 80 char limit.
> >
> > > Though if there wasn't a layer hiding the regmap, it could just have =
been
> > >
> > >         ret =3D regmap_assign_bits(lm3533->regmap, LM3533_REG_ALS_CON=
F,
> > >                                  LM3533_ALS_INPUT_MODE_MASK, als->pwm=
_mode);;
> > >
> > > which would have been nicer.
> > >
> > > I'm not particularly keen on the swashing of the helpers being in a p=
atch
>
> smashing.  (this definitely wasn't my best effort at English!)
>
> > > that is about switching the binding type as feels largely unrelated.
> > > Should really have been a precursor, easier to review patch.
> > >
> >
> > Removing of lm3533_update layer is not the scope of this patchset.
>
> Understood.  I'm fine with just the refactor you are doing brought out as=
 a precursor
> patch.
>

I have looked into removing wrappers too. That seems to be less a
hassle that I anticipated, so I will include regmap switch in the v2.

> >
> > >
> > > > +                         LM3533_ALS_INPUT_MODE_MASK);
> > > >       if (ret)
> > > > -             return ret;
> > > > +             return dev_err_probe(dev, ret, "failed to set input m=
ode %d\n",
> > > > +                                  als->pwm_mode);
> > > >
> > > >       /* ALS input is always high impedance in PWM-mode. */
> > > > -     if (!pdata->pwm_mode) {
> > > > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select)=
;
> > > > +     if (!als->pwm_mode) {
> > > > +             ret =3D lm3533_write(lm3533, LM3533_REG_ALS_RESISTOR_=
SELECT,
> > > > +                                (u8)als->r_select);
> > >
> > > Same applies here. Mostly an unrelated change as the only thing switc=
hing that
> > > is related to the patch is one parameter.
> > >
> >
> > Removing of lm3533_write layer is not the scope of this patchset.
> >
> > > >               if (ret)
> > > > -                     return ret;
> > > > +                     return dev_err_probe(dev, ret, "failed to set=
 resistor\n");
> > > >       }
> > > >
> > > >       return 0;
> > >
> > > > @@ -852,25 +825,28 @@ static int lm3533_als_probe(struct platform_d=
evice *pdev)
> > > >       indio_dev->channels =3D lm3533_als_channels;
> > > >       indio_dev->num_channels =3D ARRAY_SIZE(lm3533_als_channels);
> > > >       indio_dev->name =3D dev_name(&pdev->dev);
> > > > -     iio_device_set_parent(indio_dev, pdev->dev.parent);
> > >
> > > I'm not sure why this was there in the first place.  Hence not sure i=
f it
> > > is safe to remove.
> > >
> >
> > This is directly related to OF conversion. The iio_device_set_parent
> > bound indio_dev to parent, and it causes problems with OF now since
> > als output has its own node and binding it to parent if wrong. Same
> > story for backlight and leds btw.
>
> Is there any risk anyone was using the canonical path to get to the iio d=
ev?
> /sys/bus/platform/devices/..../iio\:deviceX
> This is technically an ABI change be it a subtle one.
>

Linux kernel has no users of this driver, and it is in "stale" state
for more then 2 years (maybe even longer). I have cc'd Johan Hovold.

https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/

This this 2 y. o. discussion and there were no actions ore movements.
I assume this driver in its current form has no more users. This does
not mean that it cannot be revived though.

>
> >
> > >
> > > > diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.=
c
> > > > index 45795f2a1042..d707d43d5526 100644
> > > > --- a/drivers/leds/leds-lm3533.c
> > > > +++ b/drivers/leds/leds-lm3533.c
> > >
> > > >
> > > >       led->cb.dev =3D led->cdev.dev;
> > > >
> > > > -     ret =3D lm3533_led_setup(led, pdata);
> > > > +     device_property_read_u32(&pdev->dev, "led-max-microamp",
> > > > +                              &led->max_current);
> > >
> > > I'd prefer explicit setting of the default to be visible before this,=
 or
> > > the property_present pattern I mention in the IIO review above.
> > >
> >
> > clamp will ensure that led->max_current will be set to
> > LM3533_LED_MAX_CURRENT_MIN regardless if it it present
>
> As above, I'd prefer it set explicitly.
>

I understand your position and I am not denying it for ALS part, but
LEDs don't belong to IIO subsystem and different subsystem maintainers
may have drastically different preferences and requirements (ugh, PTSD
in its full glory).

> >
> > > > +     led->max_current =3D clamp(led->max_current, LM3533_LED_MAX_C=
URRENT_MIN,
> > > > +                              LM3533_LED_MAX_CURRENT_MAX);
> > >
> > > I didn't look any further (busy day!)
> >
>
