Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C56BCD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0914110FD1D;
	Fri, 29 May 2026 11:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WnqhstJq";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B23D10FD1D
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:02:56 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-304c520fe9aso4998674eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 04:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780052575; cv=none;
 d=google.com; s=arc-20240605;
 b=RmYES57VYqQdt62eZPu+ParsaO60OuDs7QI+tm8xPz4GJ4aUXf2xvX0tbbaQ3miHuq
 2YSIKuA+Si67VAL6U5Ulmiik9MZHAqGNtO4KfPjSq5jhoFHtURsoxNmmzyoSVwWMCeYM
 GZReiywK3ZWWHOFXwRhuUaXC6+fvazwUc526Pk9fwuHDwl6H33B6bbh4nf8g20SD9I+2
 n1dOYyan1rEIT3IbO6aLg6grZm04Nh1ZHN9WA4eEk60N3tBNwu6dd5MnWVyTDZ7T1EZW
 ikOuOkuY8YbcwN2WQkS8LqMa8CfUV+NVvjlKOSEvC6E3+pWc6/usYlJAAnfrn/HkThj7
 gF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qf0EPFsEMgv7RinRHJC8+FSrNX+a+vtz20v10EwyVsU=;
 fh=DdqnBHHMpWZGNEKVstsL5QeJCfODrqiIH9s+HrstPbw=;
 b=UyX/WWRBLJL5wEZGem6+jR92iOm/9IhW/a9eFUDAbYiy5aPhkFs/2SSTTv39Z9Hvx2
 8P6lRC8v4oVBhzGqA3TLbOyvMWDZf1KC6f0YNmhhIQo7KxsEmQtfE0m6eEuE6bVgEwHu
 B6kzyVjdyr64m/hRA/sd7VF/xP+GiJm9iEZASS9zNxRiy1kLlX2KVd+iTrGUOoC9l1oe
 bu2/TzYpYa2TXFF/AjKLCTdpTJL6DyKO0e8ULFeC76gnNDLlPjTgGYa62kX6PuZizEig
 BVaxD/FZvmI0kquHoRVH2XxbJ/VTh88eOXerVE/x0kYVeMZUsQHbKs3vHCUVqMbsg/hx
 uYWA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780052575; x=1780657375; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qf0EPFsEMgv7RinRHJC8+FSrNX+a+vtz20v10EwyVsU=;
 b=WnqhstJq5d5Nx9tUge98mJKlWs4iclezCmSmE/z8tVNd41lXC/sd+jX+CGxNdPRLYW
 lj068KLbM3Wn9SxwpNXvR2x5N+XCHCeoHk0dabUn0Kf1R5mG8nFJeL+M/lQMJF2wZDa9
 aqXF0ZUHKE7ADOMGspr61Gf6g1VzkBm3PIs0XxH+QSy7hksw73LnhG+T/4m2I79v6L6N
 TRDw9R9ZgG7TZlSK7GfG1N02BnTdlch+GxLeRVd3xAhqIvRWJgTFZOF5J5ueD0Z8zUWs
 bjFL8bIxzGNqPSWjoTvsKIpi9a49VvrpAzdrlBLpvcOMyIyEZ5xhy52Q7aJXghfU4sv7
 uWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780052575; x=1780657375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qf0EPFsEMgv7RinRHJC8+FSrNX+a+vtz20v10EwyVsU=;
 b=dZPOfgmgoV1DiT+TsvJGv9zC9ApV2g9QEu9ZJLXRXLgcIkwKvA3H37JadX/4I0PM2r
 jhXJ966zbIaEuGXmjUyx/OkdPH5QfTb74mzPb1M1Y87z6DlrGpPL6g/U6hV2LdST+Xcf
 DaUa40FfQeg82Ekst6i0Yfp+iuNHgGcpx2q0RgUlp1EbYCZINyn2/wXaQa9OGD8ByPK3
 df6aqGVpkZhjQ/83ouhmYEfp5f11lJ8q0cBJJi0Kzxmy01ziyiqSKpDe57zI8pIrpehf
 9I+ZZ4tmlNusn6s6AoWqnREma4r8UCjL9zJtqGrh6+6H93lGKW6ETAyKj7hoG5o5sNz0
 6TIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mDu3ADrbwj8vnIsJigL+qDwpV+MPIlYwjj+qde7zMOqsaDXmuMNBD6ZsX80O/VQt1gNgMOrxMJEU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyB6QQTpD1TOgtxlm74d0Co3evmcFNELGBXPhr+VchtSGVarq31
 FmhfBZU29Kgf2BVUIbVRJZoGBoeZe3AMW0duwNmEyCF8mQsyEfF8JADeL432oGSU3c3wCqZGh3W
 GnA2b5oohQIoGRalQh4t3M9z3zcFbaXU=
X-Gm-Gg: Acq92OFwkUZqZphHHMbpTmSS4s9TE60qZ4BxLLs6wzxa1XOVR0nozVg6/zgAvPqJv5W
 l3Mav6tx04V1Rlch8GZ3lBm5br6kFiPmPOkaALYa518l2KKVmJU8KlO8uQfySInQiRDnrwAc0jY
 CA5NJTBKpVx0Ky+LVI52wI9tCiM87VnCWRjEbeis3K2unO90qmsRi4l6tv2uYyAp2MI6DSinZ/9
 o4PRulvj1Es7JJbsE9M4zqOhONvv4AeYkIjefkdMkwB0D6G4Kday91cMpNsmGrTePi2fZfJ5ZfR
 ataaPzrFQIkeqDEVnI4=
X-Received: by 2002:a05:7301:5f89:b0:2f1:6252:f8fe with SMTP id
 5a478bee46e88-304ead9c0a3mr1051392eec.3.1780052575098; Fri, 29 May 2026
 04:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-3-clamor95@gmail.com>
 <20260528155001.2bcb7003@jic23-huawei>
 <CAPVz0n0qCekQVGGyAyBuYv+RKC6bpydYBLJNGfPrgTYjtOJOuA@mail.gmail.com>
 <20260529100819.1823ebb3@jic23-huawei>
 <CAPVz0n0VHdUo5oHdALgcerLsykdz-2n7c+jxYHrMOV7Ra5x_qQ@mail.gmail.com>
 <20260529114828.5a87c732@jic23-huawei>
In-Reply-To: <20260529114828.5a87c732@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 14:02:43 +0300
X-Gm-Features: AVHnY4JFkCjq5u7WpABFbger7MZKVNNC_WAp1_zpv0s6179IZSDqS5525lREGVM
Message-ID: <CAPVz0n1u0z35rP8vUKjAzW_mrPm9yeMjK_-nKbyctUvQik6ECw@mail.gmail.com>
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

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:4=
8 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, 29 May 2026 12:39:56 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
12:08 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, 28 May 2026 18:03:31 +0300
> > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > >
> > > > =D1=87=D1=82, 28 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=
=BE 17:50 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Thu, 28 May 2026 16:51:19 +0300
> > > > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > > > >
> > > > > > Since there are no users of this driver via platform data, remo=
ve the
> > > > > > platform data support and switch to using Device Tree bindings.
> > > > > > Additionally, optimize functions used only by platform data.
> > > > >
> > > > >
> > > > > At least the IIO ones would have made much the same amount of sen=
se for
> > > > > dt, just that they weren't having in the first place. I'd prefer =
that
> > >
> > > Gah. I write gibberish after too much reviewing.  having/helping!
> > >
> > > > > as a precursor patch to make the rest much more readable.
> > > > >
> > > >
> > > > I can add you preferences into this commit, I don't mind.
> > > >
> > > > > >
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > >
> > > > > I only looked in detail at the iio bit. A few changes requested.
> > > > >
> > > > > > ---
> > > > > >  drivers/iio/light/lm3533-als.c      |  95 ++++------
> > > > > >  drivers/leds/leds-lm3533.c          |  51 ++++--
> > > > > >  drivers/mfd/lm3533-core.c           | 268 ++++++++++----------=
--------
> > > > > >  drivers/video/backlight/lm3533_bl.c |  52 ++++--
> > > > > >  include/linux/mfd/lm3533.h          |  51 +-----
> > > > > >  5 files changed, 212 insertions(+), 305 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light=
/lm3533-als.c
> > > > > > index 99f0b903018c..cbd337b73bd9 100644
> > > > > > --- a/drivers/iio/light/lm3533-als.c
> > > > > > +++ b/drivers/iio/light/lm3533-als.c
> > > > >
> > > > > > @@ -714,59 +720,33 @@ static const struct attribute_group lm353=
3_als_attribute_group =3D {
> > > > > >       .attrs =3D lm3533_als_attributes
> > > > > >  };
> > > > > >
> > > > > > -static int lm3533_als_set_input_mode(struct lm3533_als *als, b=
ool pwm_mode)
> > > > > > +static int lm3533_als_setup(struct lm3533_als *als)
> > > > > >  {
> > > > > > -     u8 mask =3D LM3533_ALS_INPUT_MODE_MASK;
> > > > > > -     u8 val;
> > > > > > +     struct device *dev =3D &als->pdev.dev;
> > > > > >       int ret;
> > > > > >
> > > > > > -     if (pwm_mode)
> > > > > > -             val =3D mask;     /* pwm input */
> > > > > > -     else
> > > > > > -             val =3D 0;        /* analog input */
> > > > > > -
> > > > > > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, v=
al, mask);
> > > > > > -     if (ret) {
> > > > > > -             dev_err(&als->pdev->dev, "failed to set input mod=
e %d\n",
> > > > > > -                                                             p=
wm_mode);
> > > > > > -             return ret;
> > > > > > -     }
> > > > > > -
> > > > > > -     return 0;
> > > > > > -}
> > > > > > -
> > > > > > -static int lm3533_als_set_resistor(struct lm3533_als *als, u8 =
val)
> > > > > > -{
> > > > > > -     int ret;
> > > > > > -
> > > > > > -     if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RES=
ISTOR_MAX) {
> > > > > > -             dev_err(&als->pdev->dev, "invalid resistor value\=
n");
> > > > > > -             return -EINVAL;
> > > > > > -     }
> > > > > > -
> > > > > > -     ret =3D lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR=
_SELECT, val);
> > > > > > -     if (ret) {
> > > > > > -             dev_err(&als->pdev->dev, "failed to set resistor\=
n");
> > > > > > -             return ret;
> > > > > > -     }
> > > > > > +     device_property_read_u32(dev, "ti,resistor-value-ohm",
> > > > > > +                              &als->r_select);
> > > > > Does this have a default?  If so the pattern we've recently be se=
tting on for IIO
> > > > > is
> > > > >         if (device_property_present(dev, "ti,resistor-value-ohm")=
)
> > > > >                 ret =3D device_property_read_u32();
> > > > >                 if (ret) //corrupt property in some fashion
> > > > >                         return ret;
> > > > >         } else {
> > > > >                 //set default
> > > > >         }
> > > > > If there is no default then check it unconditionally.
> > > >
> > > > default value is LM3533_ALS_RESISTOR_MIN and if no property is pres=
ent
> > > > clamp will ensure that als->r_select will be set to
> > > > LM3533_ALS_RESISTOR_MIN
> > >
> > > I don't see that default in the binding doc and relying in the 0 bein=
g clamped
> > > isn't particularly readable - I'd set it explicitly.
> > >
> >
> > Oh, ye, my bad. Schema enforces one of props to be present and if pwn
> > is present then resistor is ignored. What if I move resistor reading,
> > clamping and conversion under !als->pwm_mode check? Then resistor must
> > be present and hence must be checked unconditionally.
>
> Sounds good.
>
> >
> > Additionally, I can comment original lm3533_als_setup with #if 0
> > #endif then git formatting will be much cleaner and easier to review,
> > and once we all come to result I will just remove entire commented
> > block and Lee can pick clean commits.
>
> No don't do that.  If you flatten the two helpers as a precursor patch
> then the changes in here will be easier to review anyway.
>

By "flatten the two helpers" you mean incorporate
lm3533_als_set_input_mode and lm3533_als_set_resistor into
lm3533_als_setup first and then convert it to use DT? I am asking,
just to be sure.

> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > -     return 0;
> > > > > > -}
> > > > > > +     als->r_select =3D clamp(als->r_select, LM3533_ALS_RESISTO=
R_MIN,
> > > > > > +                           LM3533_ALS_RESISTOR_MAX);
> > > > > > +     als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * als->r_sel=
ect);
> > > > > >
> > > > > > -static int lm3533_als_setup(struct lm3533_als *als,
> > > > > > -                         const struct lm3533_als_platform_data=
 *pdata)
> > > > > > -{
> > > > > > -     int ret;
> > > > > > +     als->pwm_mode =3D device_property_read_bool(dev, "ti,pwm-=
mode");
> > > > > >
> > > > > > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > > > > > +     ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF, als->p=
wm_mode ?
> > > > > > +                         LM3533_ALS_INPUT_MODE_MASK : 0,
> > > > >
> > > > > That's ugly.  Better as
> > > > >
> > > > >         ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF,
> > > > >                             als->pwm_mode ? LM3533_ALS_INPUT_MODE=
_MASK : 0,
> > > > >
> > > >
> > > > Yes sure, just followed 80 char limit.
> > > >
> > > > > Though if there wasn't a layer hiding the regmap, it could just h=
ave been
> > > > >
> > > > >         ret =3D regmap_assign_bits(lm3533->regmap, LM3533_REG_ALS=
_CONF,
> > > > >                                  LM3533_ALS_INPUT_MODE_MASK, als-=
>pwm_mode);;
> > > > >
> > > > > which would have been nicer.
> > > > >
> > > > > I'm not particularly keen on the swashing of the helpers being in=
 a patch
> > >
> > > smashing.  (this definitely wasn't my best effort at English!)
> > >
> > > > > that is about switching the binding type as feels largely unrelat=
ed.
> > > > > Should really have been a precursor, easier to review patch.
> > > > >
> > > >
> > > > Removing of lm3533_update layer is not the scope of this patchset.
> > >
> > > Understood.  I'm fine with just the refactor you are doing brought ou=
t as a precursor
> > > patch.
> > >
> >
> > I have looked into removing wrappers too. That seems to be less a
> > hassle that I anticipated, so I will include regmap switch in the v2.
>
> Ah ok. Even better.
>
> >
> > > >
> > > > >
> > > > > > +                         LM3533_ALS_INPUT_MODE_MASK);
> > > > > >       if (ret)
> > > > > > -             return ret;
> > > > > > +             return dev_err_probe(dev, ret, "failed to set inp=
ut mode %d\n",
> > > > > > +                                  als->pwm_mode);
> > > > > >
> > > > > >       /* ALS input is always high impedance in PWM-mode. */
> > > > > > -     if (!pdata->pwm_mode) {
> > > > > > -             ret =3D lm3533_als_set_resistor(als, pdata->r_sel=
ect);
> > > > > > +     if (!als->pwm_mode) {
> > > > > > +             ret =3D lm3533_write(lm3533, LM3533_REG_ALS_RESIS=
TOR_SELECT,
> > > > > > +                                (u8)als->r_select);
> > > > >
> > > > > Same applies here. Mostly an unrelated change as the only thing s=
witching that
> > > > > is related to the patch is one parameter.
> > > > >
> > > >
> > > > Removing of lm3533_write layer is not the scope of this patchset.
> > > >
> > > > > >               if (ret)
> > > > > > -                     return ret;
> > > > > > +                     return dev_err_probe(dev, ret, "failed to=
 set resistor\n");
> > > > > >       }
> > > > > >
> > > > > >       return 0;
> > > > >
> > > > > > @@ -852,25 +825,28 @@ static int lm3533_als_probe(struct platfo=
rm_device *pdev)
> > > > > >       indio_dev->channels =3D lm3533_als_channels;
> > > > > >       indio_dev->num_channels =3D ARRAY_SIZE(lm3533_als_channel=
s);
> > > > > >       indio_dev->name =3D dev_name(&pdev->dev);
> > > > > > -     iio_device_set_parent(indio_dev, pdev->dev.parent);
> > > > >
> > > > > I'm not sure why this was there in the first place.  Hence not su=
re if it
> > > > > is safe to remove.
> > > > >
> > > >
> > > > This is directly related to OF conversion. The iio_device_set_paren=
t
> > > > bound indio_dev to parent, and it causes problems with OF now since
> > > > als output has its own node and binding it to parent if wrong. Same
> > > > story for backlight and leds btw.
> > >
> > > Is there any risk anyone was using the canonical path to get to the i=
io dev?
> > > /sys/bus/platform/devices/..../iio\:deviceX
> > > This is technically an ABI change be it a subtle one.
> > >
> >
> > Linux kernel has no users of this driver, and it is in "stale" state
> > for more then 2 years (maybe even longer). I have cc'd Johan Hovold.
> >
> > https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
> >
> > This this 2 y. o. discussion and there were no actions ore movements.
> > I assume this driver in its current form has no more users. This does
> > not mean that it cannot be revived though.
>
> So, just to check, are you a user of this code or is this more trying to
> help out with old code?
>

I am not insane enough to get myself into all this conversion if I did
not need it. This is one of 2 remaining gaps in support of LG
P880/P895 I own and support. I would really like to finally mainline
all the patches I have locally since maintaining them becomes quite
troublesome with time and additional patches layering on top.

> Jonathan
>
> >
> > >
> > > >
> > > > >
> > > > > > diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3=
533.c
> > > > > > index 45795f2a1042..d707d43d5526 100644
> > > > > > --- a/drivers/leds/leds-lm3533.c
> > > > > > +++ b/drivers/leds/leds-lm3533.c
> > > > >
> > > > > >
> > > > > >       led->cb.dev =3D led->cdev.dev;
> > > > > >
> > > > > > -     ret =3D lm3533_led_setup(led, pdata);
> > > > > > +     device_property_read_u32(&pdev->dev, "led-max-microamp",
> > > > > > +                              &led->max_current);
> > > > >
> > > > > I'd prefer explicit setting of the default to be visible before t=
his, or
> > > > > the property_present pattern I mention in the IIO review above.
> > > > >
> > > >
> > > > clamp will ensure that led->max_current will be set to
> > > > LM3533_LED_MAX_CURRENT_MIN regardless if it it present
> > >
> > > As above, I'd prefer it set explicitly.
> > >
> >
> > I understand your position and I am not denying it for ALS part, but
> > LEDs don't belong to IIO subsystem and different subsystem maintainers
> > may have drastically different preferences and requirements (ugh, PTSD
> > in its full glory).
> >
> > > >
> > > > > > +     led->max_current =3D clamp(led->max_current, LM3533_LED_M=
AX_CURRENT_MIN,
> > > > > > +                              LM3533_LED_MAX_CURRENT_MAX);
> > > > >
> > > > > I didn't look any further (busy day!)
> > > >
> > >
>
