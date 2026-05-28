Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD98CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D417A10F312;
	Thu, 28 May 2026 15:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W4k3PHhG";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2848410F312
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:03:44 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304e58292d3so240942eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 08:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779980623; cv=none;
 d=google.com; s=arc-20240605;
 b=RT61yUttpajLOrBBlF8f2cNFR72b7GQjdUKuw7yJWg0ORzdW2xyLx0fQsLLF30k6yW
 p93UvLgRiSlhb2IF3HXkV/KX6+gxjJiL2rHoRv6ZzycGd+eWTrV5V3+fOxe12e6f7rII
 Uc8orRKWUHKbWGxx28q/76kNPYOPOlBDrwmILjjFs5+usja6oryDFpnA3XAGq5zR87yS
 WcOq005iSwOJAv/ojj5jY8STUew36t5GdnOvOjbmdG5+H0nVYP1IP40jpkbRD77/XV1K
 06Ax6iRcLccH/8YA3THAeOqhP4YsRuBwXGPMcql26REIAk+w7P2sXvqF2Y7dPB4ltApi
 pfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=999rZWGlrRMiFPTcWjsNb4DI/hC1DrKVLDhSSMIwam0=;
 fh=RJ4uB6dmYTjJUooRJ82hkNB95oeQex4jGy60NMJd2RA=;
 b=K8j2YcIrw+/rWSLjWX7d63EZo2y7zZAMUO3KXs4/XmCNctFCc7KUQif7DAas6pwUt2
 R89r1lp8/4GkFiTvfylFTejE7nHqE837eUPly8XNjBV1u9NCtj5CNvX4jwB9T+sqbSK0
 0/gHFppKzrx5l2wgMOkOFMsfXUF7rDpWOtBApWIZixG8lPMPp+LFqo1P4Bvq9/UGYyh8
 FkUBY2QOcGaA2N4prAvUL61dHJXkq5srGd9ffNx12g0l4KOUb+OqVEpkYKB5dv7KLXyn
 QTU1tmgyMLx5onfY75BioTNctzws7KT4PXXuRPurIUcE2CjNmJK2GA+hPPZikEI88Lgu
 7d5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779980623; x=1780585423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=999rZWGlrRMiFPTcWjsNb4DI/hC1DrKVLDhSSMIwam0=;
 b=W4k3PHhGEwm/OdqATFpzsSO9PJVmZXmjBUjeUfB1I51n0XYQSiAko8aDL//E3f7MZ9
 QhOSslfdw0MYvfwuV0nYnLo9QYsODtiQQuGsUb6HZHwjW06vWS9CArURsPIn55TEs7XU
 8htJmgq3QGiWsm3Rdk/KlQbMyOxg/+hUUBx6NMaBTKdzjS2WZL8KUkM+KkFz3GxU71VF
 S0F1xu+pYbZFFRnwsSVMDjDeimhJ2Ui6ZCPEYqexhcS966ehblmXa78iXVHeDN/IiWWW
 H7Xdfm5bqIOgtC9Th6RNVY9GvlX3btpdMWsOoXTfJy3tkRUtAA2/hDaAAp8NtrCqPqku
 FZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779980623; x=1780585423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=999rZWGlrRMiFPTcWjsNb4DI/hC1DrKVLDhSSMIwam0=;
 b=g0rJE46HQ89p1n1HAnOEO420UmUL71ekXO+zMcBs8T1vSyUgPIeCKEpPpFziObZIJb
 n8ibxNr/3C+r6O+vSBsJWJV60cQQYg0OyZllDEDg7cNUH5rxJhZoptBceqThIQZJJh/1
 FfRo6ObNAEKnWiTMtNH5+nYibHZinlCmn7fGz2Fylni59O3Axar/Ez0JDCuW/mkJwThI
 CsVB6Co3v1hgWUO1Yi5yjIEUGEokOH1BWldUJynd3RLS7Qaaxl4e23WCdK8uFmCQZ+vj
 Gyef8pgR/mKczCl4kE7tEETFvuCvdmcGTIBYPzTjg/K2pSJbZYdsLxN/7wmPM9oAXV7h
 JYgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EGKGzZOx4u+LX6g2LDGNwYRTb+5tOQq8lTCPgfC5/Mvuj//G2FtmNDVyeNrz4kT8+9ucACCAukA8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBIlhw50YuIBFfls8i3igi+wHZ6HXzOptpk+lUTTMSoKWB/Rco
 GbH1G67qk3VEJojlXtz4hvc7UYXQsyVduhx2de36/H9R7GDZ/O8rn07GOp64aT3wg3t+amJJFKp
 18W+gyuYcKdbbNTZUmYFb409OSqQPE+c=
X-Gm-Gg: Acq92OGIe9xfTQzCJCLmTJrjboYPzHelrv3uNtz2x9ietSWvvFzdZX38VcvEvv9YQv9
 npKPeFcn+dcYEC0OLQvhtypR6JzFqmAAXSoNpFIJqOPUYSH0QIUCKYCI1gg4RBNPfx3roJUkjqn
 2FEfVur+b4gy4WE57JViPssEpD6W0vyfbT+piLFyg1ASgwWCPqc6oAmhP5Hvz4ToxGkSLrYl4Sw
 vO56I+WlcrBG3amdX7dsWN1ilZhYnEo+dbb+Ge+8TS5kwJu5Qr+tPL3tEG8MJtjJijVd3zv5QyM
 SSNiNMATecSwOrqHIqk=
X-Received: by 2002:a05:7301:fa04:b0:304:d82f:be10 with SMTP id
 5a478bee46e88-304d82fe55fmr1288739eec.11.1779980623129; Thu, 28 May 2026
 08:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-3-clamor95@gmail.com>
 <20260528155001.2bcb7003@jic23-huawei>
In-Reply-To: <20260528155001.2bcb7003@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 28 May 2026 18:03:31 +0300
X-Gm-Features: AVHnY4JOZH_BBdJBd0wzIDDW2UO693Byl1wIIcPrxkbXcQMPI-6wgD9ANvHg0-o
Message-ID: <CAPVz0n0qCekQVGGyAyBuYv+RKC6bpydYBLJNGfPrgTYjtOJOuA@mail.gmail.com>
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

=D1=87=D1=82, 28 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 17:5=
0 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, 28 May 2026 16:51:19 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
> > Additionally, optimize functions used only by platform data.
>
>
> At least the IIO ones would have made much the same amount of sense for
> dt, just that they weren't having in the first place. I'd prefer that
> as a precursor patch to make the rest much more readable.
>

I can add you preferences into this commit, I don't mind.

> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> I only looked in detail at the iio bit. A few changes requested.
>
> > ---
> >  drivers/iio/light/lm3533-als.c      |  95 ++++------
> >  drivers/leds/leds-lm3533.c          |  51 ++++--
> >  drivers/mfd/lm3533-core.c           | 268 ++++++++++------------------
> >  drivers/video/backlight/lm3533_bl.c |  52 ++++--
> >  include/linux/mfd/lm3533.h          |  51 +-----
> >  5 files changed, 212 insertions(+), 305 deletions(-)
> >
> > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-=
als.c
> > index 99f0b903018c..cbd337b73bd9 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
>
> > @@ -714,59 +720,33 @@ static const struct attribute_group lm3533_als_at=
tribute_group =3D {
> >       .attrs =3D lm3533_als_attributes
> >  };
> >
> > -static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_=
mode)
> > +static int lm3533_als_setup(struct lm3533_als *als)
> >  {
> > -     u8 mask =3D LM3533_ALS_INPUT_MODE_MASK;
> > -     u8 val;
> > +     struct device *dev =3D &als->pdev.dev;
> >       int ret;
> >
> > -     if (pwm_mode)
> > -             val =3D mask;     /* pwm input */
> > -     else
> > -             val =3D 0;        /* analog input */
> > -
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, val, mask=
);
> > -     if (ret) {
> > -             dev_err(&als->pdev->dev, "failed to set input mode %d\n",
> > -                                                             pwm_mode)=
;
> > -             return ret;
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> > -static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
> > -{
> > -     int ret;
> > -
> > -     if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MA=
X) {
> > -             dev_err(&als->pdev->dev, "invalid resistor value\n");
> > -             return -EINVAL;
> > -     }
> > -
> > -     ret =3D lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_SELECT,=
 val);
> > -     if (ret) {
> > -             dev_err(&als->pdev->dev, "failed to set resistor\n");
> > -             return ret;
> > -     }
> > +     device_property_read_u32(dev, "ti,resistor-value-ohm",
> > +                              &als->r_select);
> Does this have a default?  If so the pattern we've recently be setting on=
 for IIO
> is
>         if (device_property_present(dev, "ti,resistor-value-ohm"))
>                 ret =3D device_property_read_u32();
>                 if (ret) //corrupt property in some fashion
>                         return ret;
>         } else {
>                 //set default
>         }
> If there is no default then check it unconditionally.

default value is LM3533_ALS_RESISTOR_MIN and if no property is present
clamp will ensure that als->r_select will be set to
LM3533_ALS_RESISTOR_MIN

>
> >
> > -     return 0;
> > -}
> > +     als->r_select =3D clamp(als->r_select, LM3533_ALS_RESISTOR_MIN,
> > +                           LM3533_ALS_RESISTOR_MAX);
> > +     als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * als->r_select);
> >
> > -static int lm3533_als_setup(struct lm3533_als *als,
> > -                         const struct lm3533_als_platform_data *pdata)
> > -{
> > -     int ret;
> > +     als->pwm_mode =3D device_property_read_bool(dev, "ti,pwm-mode");
> >
> > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > +     ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF, als->pwm_mode =
?
> > +                         LM3533_ALS_INPUT_MODE_MASK : 0,
>
> That's ugly.  Better as
>
>         ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF,
>                             als->pwm_mode ? LM3533_ALS_INPUT_MODE_MASK : =
0,
>

Yes sure, just followed 80 char limit.

> Though if there wasn't a layer hiding the regmap, it could just have been
>
>         ret =3D regmap_assign_bits(lm3533->regmap, LM3533_REG_ALS_CONF,
>                                  LM3533_ALS_INPUT_MODE_MASK, als->pwm_mod=
e);;
>
> which would have been nicer.
>
> I'm not particularly keen on the swashing of the helpers being in a patch
> that is about switching the binding type as feels largely unrelated.
> Should really have been a precursor, easier to review patch.
>

Removing of lm3533_update layer is not the scope of this patchset.

>
> > +                         LM3533_ALS_INPUT_MODE_MASK);
> >       if (ret)
> > -             return ret;
> > +             return dev_err_probe(dev, ret, "failed to set input mode =
%d\n",
> > +                                  als->pwm_mode);
> >
> >       /* ALS input is always high impedance in PWM-mode. */
> > -     if (!pdata->pwm_mode) {
> > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> > +     if (!als->pwm_mode) {
> > +             ret =3D lm3533_write(lm3533, LM3533_REG_ALS_RESISTOR_SELE=
CT,
> > +                                (u8)als->r_select);
>
> Same applies here. Mostly an unrelated change as the only thing switching=
 that
> is related to the patch is one parameter.
>

Removing of lm3533_write layer is not the scope of this patchset.

> >               if (ret)
> > -                     return ret;
> > +                     return dev_err_probe(dev, ret, "failed to set res=
istor\n");
> >       }
> >
> >       return 0;
>
> > @@ -852,25 +825,28 @@ static int lm3533_als_probe(struct platform_devic=
e *pdev)
> >       indio_dev->channels =3D lm3533_als_channels;
> >       indio_dev->num_channels =3D ARRAY_SIZE(lm3533_als_channels);
> >       indio_dev->name =3D dev_name(&pdev->dev);
> > -     iio_device_set_parent(indio_dev, pdev->dev.parent);
>
> I'm not sure why this was there in the first place.  Hence not sure if it
> is safe to remove.
>

This is directly related to OF conversion. The iio_device_set_parent
bound indio_dev to parent, and it causes problems with OF now since
als output has its own node and binding it to parent if wrong. Same
story for backlight and leds btw.

>
> > diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
> > index 45795f2a1042..d707d43d5526 100644
> > --- a/drivers/leds/leds-lm3533.c
> > +++ b/drivers/leds/leds-lm3533.c
>
> >
> >       led->cb.dev =3D led->cdev.dev;
> >
> > -     ret =3D lm3533_led_setup(led, pdata);
> > +     device_property_read_u32(&pdev->dev, "led-max-microamp",
> > +                              &led->max_current);
>
> I'd prefer explicit setting of the default to be visible before this, or
> the property_present pattern I mention in the IIO review above.
>

clamp will ensure that led->max_current will be set to
LM3533_LED_MAX_CURRENT_MIN regardless if it it present

> > +     led->max_current =3D clamp(led->max_current, LM3533_LED_MAX_CURRE=
NT_MIN,
> > +                              LM3533_LED_MAX_CURRENT_MAX);
>
> I didn't look any further (busy day!)
