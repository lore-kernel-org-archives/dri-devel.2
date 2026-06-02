Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C44DCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A52113A7A;
	Tue,  2 Jun 2026 14:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VelYQ4VB";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8ABF113A7A
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 14:29:06 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304d555293aso8094015eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 07:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780410546; cv=none;
 d=google.com; s=arc-20240605;
 b=YdmgwyfZ0Dru1TWBPSMlZne7Zm003mMNeUE+qLAWtohm2GprCj762Z1F0LjbBLG6pa
 M8XsMtPRGhsHs+kqDzbsnC4NvydPmcdHq9wH4jZuqDeoVb5reEEbMH3hh6kdM4vi75yQ
 /vubYztf8MevvL7lIc4ZC8gim2NiXP4QQjQmYtY6/xrdTPeqsWzELzeUnd3TOkJho46A
 62VFpPAQe+ovzu50YYTnE4VPgyoT7OQvov+OfhpbrbIDehBqrvd/4JRKDPsQcd3UjcEf
 pELUv/SAO/RTj+4kukTkAiCQOWgo3Mt9k+zwZjRJWpt3us5bLP6739X9trm3L9J9Xnfb
 OHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kpwFh2a0/oyZBOiJkQQQ7Xbyt/Uy5rqSD9KPnvxrM2g=;
 fh=GZtcuL4kGa0+PMiXFUkI+uHk4PQpeJ7DBtzBQyQZAjc=;
 b=bzIQlPD9SCq8DNclkT9moaKmsg3Pntmm6HHK3RQ5qj0/Y+vssqKSngTAqcAwHikJy3
 AYRqdtzopVLOuk4gEi6Zu6pQp0hony+i61zGf0JxT4QB+t6qYXPI9I2kY2xc8k2KA2W8
 AyZUm0MxAEXNyMEwanuL3K0GNWHzc3r88WoTkRUvnLruc+cXoXqT4IFMXWk40V3/oGsW
 vbTACb09TO+bQjPsHKd3lfgL2A12JAHNh3bLwHMH6frN9sRFjTgGXFxUJTHjr8L9Z8PQ
 HLyKF6EpHdQRUNw00dlKCWdtPwthRG8IHRyc/1S+hf9vf+rYBbHioc9sXazRZeverr4o
 Q8tg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780410546; x=1781015346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpwFh2a0/oyZBOiJkQQQ7Xbyt/Uy5rqSD9KPnvxrM2g=;
 b=VelYQ4VBNKa8tdv2Z/ne54twHNjiBiL1HKfkyMpwRbE7IIEZGtGletmAdJYQ6nUMV8
 tO1wWCsJIQ6CZAkWf5lPA89JPqGjmK+61TMysn5tAe609kGr1edt86zHinn5jNBkLRnP
 fVRJnqzvWpUPPNxyNDPur3yUU1VCt973g0w7AwRSWklgk+UTNAOZ1e8lPPHkY8pamem9
 L2tCCydX49CYk2qtwdw8/hStrele4y3dYjXZlry/60yScBIWxSh8GGT0twepms2KpUm6
 2kSKo+saLmqNKKi46zTIXvKaQRJNAKRdsx1bYOA6TiAQe1osjT8epYvs6guGoey/ONiu
 U2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780410546; x=1781015346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kpwFh2a0/oyZBOiJkQQQ7Xbyt/Uy5rqSD9KPnvxrM2g=;
 b=d98mySufWG70O9wWwpcvTDUH94Gaehqx/kPzyNx8+g5dFCkZugasZ1gcZQgu04janK
 npEQ5R4qMafhKASCWy5QHYpSp4aVN+EMI8fYVHMobDLfGxP0WqDPFd0EeZRvofuVSYVz
 vWtNAP7o5bYoholJTjplgt9nJevt+8TQsT+dEtCscXWqeMdAzNf8IsNZHkw4uCQTH+Q8
 CO23taLtWozi35A1TvNYuGGPvl9LWfWC6dF5PpohjUgOfgyiUsMxIBFdfSoS9bZK5q+L
 vfqe2nSZg3LhpnFAW4TRw+ZhGORdq2N9dzfUHYQylbzLQuVihnUhryZ9aLIO+RdkIKlG
 g+sg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8E154AMLSgMn0oLzOM8GFHQ/tkGXk1g5QoWzOssEW4tDAVfZx3kf8HuJKI40He9ve02nLaKFpeA1A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxB/UzzLSuPgclfOy/58QrtaFJBZAtGGxdKzO9v+e2H1AZ3P+XG
 x6ZelzjA7oU3m80Yj4osTJ0Q840E5vs/R+9/53LTGAjP/XG+5sLJbvNbX4vpxZ3YSsf5RTcdkte
 CSWJyeHvPk8Zur6lURrCZiCHlMx1DbUo=
X-Gm-Gg: Acq92OGeP8XV1PN/xzgFlkDfLHRI4JfN7N0ah8f+xR9mCCMN+6P7Ut3MxuNujpMjG1L
 dUnxuUgzfq16Cs4tQde+ICuftuZycnVFO2tCVwBbWoGd/hl7dN+h+FbGQQ3TgctPZj3zWiEqxul
 wzHqvkUTMRtxiG129cDJzqnoiPgRgJgGUBwbPYnyJKAqQMBVuK2tpQx8IRaAipYvUlNxZwn0bM+
 3962Nq36omeXHyFko3w/+uv4DKiPsfuzN/NIBHt9D06TMvPgGdSYkKBtPs8IIIFD+u3kq57wmFS
 2Gj7ekovZiZW/FpjJD8=
X-Received: by 2002:a05:7301:1f0d:b0:304:e20e:f5c9 with SMTP id
 5a478bee46e88-304fa6ab9d9mr8316247eec.31.1780410546079; Tue, 02 Jun 2026
 07:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-6-clamor95@gmail.com>
 <20260602144640.433b4d35@jic23-huawei>
 <CAPVz0n1r97d8-uzhPGBx0LFSp75A3_2mMXDQQ30utT-6NtpHNA@mail.gmail.com>
 <20260602152019.078cc40e@jic23-huawei>
In-Reply-To: <20260602152019.078cc40e@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 17:28:54 +0300
X-Gm-Features: AVHnY4IAAmHJnZ7jdhhpGUMZSGLBbZqFDtuCT4UKpkopc5zewTxJykItA13TvMY
Message-ID: <CAPVz0n0D+97TqZD+003z40vGK_gtnNv5v8iGyc8NYekLdHg58A@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 17:20=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, 2 Jun 2026 16:50:16 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 1=
6:46 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Mon,  1 Jun 2026 18:18:25 +0300
> > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > >
> > > > Since there are no users of this driver via platform data, remove t=
he
> > > > platform data support and switch to using Device Tree bindings.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > >
> > >
> > > > index 52136ca1abc9..55b35467a722 100644
> > > > --- a/drivers/iio/light/lm3533-als.c
> > > > +++ b/drivers/iio/light/lm3533-als.c
> > > > @@ -16,16 +16,19 @@
> > > >  #include <linux/module.h>
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/mfd/core.h>
> > > > +#include <linux/mod_devicetable.h>
> > > >  #include <linux/platform_device.h>
> > > > +#include <linux/property.h>
> > > >  #include <linux/regmap.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/uaccess.h>
> > > > +#include <linux/units.h>
> > > >
> > > >  #include <linux/mfd/lm3533.h>
> > > >
> > > >
> > > > -#define LM3533_ALS_RESISTOR_MIN                      1
> > > > -#define LM3533_ALS_RESISTOR_MAX                      127
> > > > +#define LM3533_ALS_RESISTOR_MIN                      1575
> > > > +#define LM3533_ALS_RESISTOR_MAX                      200000
> > > >  #define LM3533_ALS_CHANNEL_CURRENT_MAX               2
> > > >  #define LM3533_ALS_THRESH_MAX                        3
> > > >  #define LM3533_ALS_ZONE_MAX                  4
> > > > @@ -57,6 +60,9 @@ struct lm3533_als {
> > > >
> > > >       atomic_t zone;
> > > >       struct mutex thresh_mutex;
> > > > +
> > > > +     bool pwm_mode;
> > > > +     u32 r_select;
> > > >  };
> > > >
> > > >
> > > > @@ -411,7 +417,7 @@ static ssize_t show_thresh_either_en(struct dev=
ice *dev,
> > > >       int enable;
> > > >       int ret;
> > > >
> > > > -     if (als->irq) {
> > > > +     if (als->irq > 0) {
> > > >               ret =3D lm3533_als_get_int_mode(indio_dev, &enable);
> > > >               if (ret)
> > > >                       return ret;
> > > > @@ -716,30 +722,34 @@ static const struct attribute_group lm3533_al=
s_attribute_group =3D {
> > > >       .attrs =3D lm3533_als_attributes
> > > >  };
> > > >
> > > > -static int lm3533_als_setup(struct lm3533_als *als,
> > > > -                         const struct lm3533_als_platform_data *pd=
ata)
> > > > +static int lm3533_als_setup(struct lm3533_als *als)
> > > >  {
> > > >       struct device *dev =3D &als->pdev->dev;
> > > >       int ret;
> > > >
> > > > +     als->pwm_mode =3D device_property_read_bool(dev, "ti,pwm-mode=
");
> > > > +
> > > >       ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_AL=
S_CONF,
> > > >                                LM3533_ALS_INPUT_MODE_MASK,
> > > > -                              pdata->pwm_mode ? LM3533_ALS_INPUT_M=
ODE_MASK : 0);
> > > > +                              als->pwm_mode ? LM3533_ALS_INPUT_MOD=
E_MASK : 0);
> > > >       if (ret)
> > > >               return dev_err_probe(dev, ret, "failed to set input m=
ode %d\n",
> > > > -                                  pdata->pwm_mode);
> > > > -
> > > > +                                  als->pwm_mode);
> > > >
> > > >       /* ALS input is always high impedance in PWM-mode. */
> > > > -     if (!pdata->pwm_mode) {
> > > > -             if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> > > > -                 pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
> > > > -                     dev_err(&als->pdev->dev, "invalid resistor va=
lue\n");
> > > > -                     return -EINVAL;
> > > > -             }
> > > > +     if (!als->pwm_mode) {
> > > > +             ret =3D device_property_read_u32(dev, "ti,resistor-va=
lue-ohms",
> > > > +                                            &als->r_select);
> > > > +             if (ret)
> > > > +                     return dev_err_probe(dev, ret,
> > > > +                                          "failed to ger resistor =
value\n");
> > > > +
> > > > +             als->r_select =3D clamp(als->r_select, LM3533_ALS_RES=
ISTOR_MIN,
> > > > +                                   LM3533_ALS_RESISTOR_MAX);
> > >
> > > If we are getting garbage from DT I think I'd rather error out that p=
aper over
> > > that problem.  So similar to before, check valid value and if not fai=
l probe
> > > so that hopefully someone goes and fixes it!
> > >
> >
> > sure
> >
> > > > +             als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * als->r=
_select);
> > > Why do we need this when we didn't before?  The range checks are the =
same
> > > so it smells like it shouldn't need transforming. I'd also rather we =
didn't do
> > > rewriting of the meaning of r_select like this.  Just use a local var=
iable for
> > > the intermediate result.
> > >
> >
> > before pdata passed resistor value as actual register value, not we
> > are getting the actual resistance in ohms from the tree and must
> > convert it into register value.
>
> ah. I missed the change of values.  Can you make them explicitly now _OHM=
S or something
> along those lines rather than reusing the macro name for a different thin=
g.
>

Acknowledged.

> >
> > > >
> > > >               ret =3D regmap_write(als->lm3533->regmap, LM3533_REG_=
ALS_RESISTOR_SELECT,
> > > > -                                pdata->r_select);
> > > > +                                als->r_select);
> > > >               if (ret)
> > > >                       return dev_err_probe(dev, ret, "failed to set=
 resistor\n");
>
