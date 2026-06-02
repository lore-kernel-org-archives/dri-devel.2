Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C667CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 081E810F15E;
	Tue,  2 Jun 2026 13:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YJZ4GyQf";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FA410F15D
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 13:50:28 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304545f5206so15600573eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 06:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780408228; cv=none;
 d=google.com; s=arc-20240605;
 b=gG8Opdnqh5da+XrsHbm1AVbob1xYfxvLtwbt7aK5iDaenXwNQ4dz+Fk3EhG/R7rr7m
 ehKMYrz1cyiwT75q/eEwsfVK3j+prVjoedc+tJaQEqjKnYaA3TdfrHACmQVhLTMsb2Yn
 B20tZjhlj71a+VWJE+x9AenxviCpFj5idpntJCrSgUCWoEVrUxYYa99/KDAaLRpCsW+p
 7VR8hgu21EHMw/hxDtPMIRGL5EIDHOQeudA8XRXucUtFGsTXYq2qvyb2aTb6z1fpfp//
 COpLV/LWaIEWuj7veAY5Bu0uOkEzBzXKEnOQXMSMWILPaf7fyxEIpKmQZIUhVImw9wPj
 ZI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JXMEIdkpX0PMnnSFu3HxJtEnPHLXb+fgf1w6HULmKpc=;
 fh=lwVExsUo3pJCCJfTboJtpBiinNWLnbx0aV1Gcd2qstQ=;
 b=KG4F8Q/6KglrYcHEioJAbozYOIVt/rxjnxCKGDsKLFW4m4HpA3zdznMnXMIvqJAU+g
 rM7duIMyWMYgjiYoiqLJXLRMSt+LjVMSUXjxc5XIggsLDFtBrvqdIpsdTybszlprN/3S
 /KCqWmxuAr9nnf4bwNJcoK940hd6zUJ9Cei+/LUVqhd1qNaXkj6ZZY8eF43K2yxGdZlo
 jJulZ1Xl927TNkjtaxkr7tmUiq0YUDyG2PhXOxDbcrfKNv9v6TWUPorag4LpwtZi9PTW
 I+WTXQfdn2c2W6F8ZmUQohFSn3ZTL25lzdBDP8HmNGlHiCgXJceb4Bcqlg6XzIvAQXpD
 ckmA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780408228; x=1781013028; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXMEIdkpX0PMnnSFu3HxJtEnPHLXb+fgf1w6HULmKpc=;
 b=YJZ4GyQfRmGYsa1O4Iln9WOeoD/4TPQFsKqSNfZ/qoIZLqTHe8yU9DuAm3DP4WQ3Zd
 Of/y/N6Tyg3rheVZu/oijxWnLLMpsZL/WN99E2XSmCxPNKUIKh72Qj7mh+bbdQGK8EZS
 5MyziPseHqqo1LDo/MBlwoFznZUHOpUayaAD9iACgZaakkId6LGbjTpbH+bZGYf95gPf
 bjZmOe8gzwNfkgqbxNdUNn7gPjFUiE5rel/W9c0aH2OSx1Wu0jSeG20HSbMKM0aD3gcR
 +WbOciq2FQH8bhgaJvU7sMAQ00gNJHnYh3jM0Ix65Jwgv7AA3lK6Z0KFzIygXTO+RUM2
 klwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780408228; x=1781013028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JXMEIdkpX0PMnnSFu3HxJtEnPHLXb+fgf1w6HULmKpc=;
 b=q+zQWdzn5echLquUXdmzGMCR92M8Jn92jNIlFGmjm6jp5e29zv77SXojrYLs9DAtOV
 C5IAYIaybAdILGzDVvbRNdYJaPtC+ooenm7cBgKNDksmvuCm4OhpDAb0Zkl6xzlEjfP0
 06zbRs0fEKS9WNOwf38VQj5mGzDEg//1iP2Lh3lTMYvV8DJp0PC+Uo04K4vYDojvZdD9
 xdnH5saJZ4H1MCGZEqHJ5Y8uzYrLPHMJ8zjRjPdCW9d99BBHFkMGW5//eEBwEz8SPl5i
 XxvBMHhG8TSRK/sVaTx5Vzg7E+fy2ubnTQ4ypugwbn/7tfHy3UxgJY6OC2nqdqROaCMK
 NKUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JFkuEhxgrIaWVnV+VVDybppNL5UIzCAupK73YED079BUTkcpatSOMTeUVpIuitBZQiMGWP4GQ03o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIxxQEqpxn3vdJZPPTV9CnbojRtlDmLDxWkJkWfYS1MQPzbzAv
 qWYQDr2IY3T5IGtmLgvNQvFY/+DNaD+q2Bq5Y9rA5ms+F84NDuLJ5+tu47VSh6UF1Q96Uh+94OU
 A/THlVpBHU1HBMVAub/TYDwNu9wIDz8A=
X-Gm-Gg: Acq92OFDSwMRlxCgCVAAQhPOe3IJk4Lmhi7dXXHwj4bJ2bDmFb38F8ZsMezcGF2doCG
 dRRWUvd6UsmAYm6SdFDH7ABLbbtH+Wt++pZlZW2ndhq9HiE1gbVdrGyNVX9mUo1M14OYxzLTBNm
 pE1Qu2WkNllG6y9zusREKhWPHxltPmKgPuNiz9yGWHPT/JXeqrngUPaEnTHjj68eIaSlXwTn4XW
 cXcvUerzPPK2yGj1qaNvJpdYJk9mh0kRTjtVTTuHW6lM+mhB3Iwc5ZBIxnt+psW10HynqBp8xod
 AG3UyLrxcGfZXBL5Dhc=
X-Received: by 2002:a05:7301:1f0d:b0:2ed:e14:42e9 with SMTP id
 5a478bee46e88-304fa693628mr8033250eec.34.1780408227938; Tue, 02 Jun 2026
 06:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-6-clamor95@gmail.com>
 <20260602144640.433b4d35@jic23-huawei>
In-Reply-To: <20260602144640.433b4d35@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 16:50:16 +0300
X-Gm-Features: AVHnY4KYcv6nkoqF49he0KoddQyJUPiBV8YuVyKK6U5KG-s9hQUTG1_wCFFBKFE
Message-ID: <CAPVz0n1r97d8-uzhPGBx0LFSp75A3_2mMXDQQ30utT-6NtpHNA@mail.gmail.com>
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16:46=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon,  1 Jun 2026 18:18:25 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
>
> > index 52136ca1abc9..55b35467a722 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
> > @@ -16,16 +16,19 @@
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/mfd/core.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/units.h>
> >
> >  #include <linux/mfd/lm3533.h>
> >
> >
> > -#define LM3533_ALS_RESISTOR_MIN                      1
> > -#define LM3533_ALS_RESISTOR_MAX                      127
> > +#define LM3533_ALS_RESISTOR_MIN                      1575
> > +#define LM3533_ALS_RESISTOR_MAX                      200000
> >  #define LM3533_ALS_CHANNEL_CURRENT_MAX               2
> >  #define LM3533_ALS_THRESH_MAX                        3
> >  #define LM3533_ALS_ZONE_MAX                  4
> > @@ -57,6 +60,9 @@ struct lm3533_als {
> >
> >       atomic_t zone;
> >       struct mutex thresh_mutex;
> > +
> > +     bool pwm_mode;
> > +     u32 r_select;
> >  };
> >
> >
> > @@ -411,7 +417,7 @@ static ssize_t show_thresh_either_en(struct device =
*dev,
> >       int enable;
> >       int ret;
> >
> > -     if (als->irq) {
> > +     if (als->irq > 0) {
> >               ret =3D lm3533_als_get_int_mode(indio_dev, &enable);
> >               if (ret)
> >                       return ret;
> > @@ -716,30 +722,34 @@ static const struct attribute_group lm3533_als_at=
tribute_group =3D {
> >       .attrs =3D lm3533_als_attributes
> >  };
> >
> > -static int lm3533_als_setup(struct lm3533_als *als,
> > -                         const struct lm3533_als_platform_data *pdata)
> > +static int lm3533_als_setup(struct lm3533_als *als)
> >  {
> >       struct device *dev =3D &als->pdev->dev;
> >       int ret;
> >
> > +     als->pwm_mode =3D device_property_read_bool(dev, "ti,pwm-mode");
> > +
> >       ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CO=
NF,
> >                                LM3533_ALS_INPUT_MODE_MASK,
> > -                              pdata->pwm_mode ? LM3533_ALS_INPUT_MODE_=
MASK : 0);
> > +                              als->pwm_mode ? LM3533_ALS_INPUT_MODE_MA=
SK : 0);
> >       if (ret)
> >               return dev_err_probe(dev, ret, "failed to set input mode =
%d\n",
> > -                                  pdata->pwm_mode);
> > -
> > +                                  als->pwm_mode);
> >
> >       /* ALS input is always high impedance in PWM-mode. */
> > -     if (!pdata->pwm_mode) {
> > -             if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> > -                 pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
> > -                     dev_err(&als->pdev->dev, "invalid resistor value\=
n");
> > -                     return -EINVAL;
> > -             }
> > +     if (!als->pwm_mode) {
> > +             ret =3D device_property_read_u32(dev, "ti,resistor-value-=
ohms",
> > +                                            &als->r_select);
> > +             if (ret)
> > +                     return dev_err_probe(dev, ret,
> > +                                          "failed to ger resistor valu=
e\n");
> > +
> > +             als->r_select =3D clamp(als->r_select, LM3533_ALS_RESISTO=
R_MIN,
> > +                                   LM3533_ALS_RESISTOR_MAX);
>
> If we are getting garbage from DT I think I'd rather error out that paper=
 over
> that problem.  So similar to before, check valid value and if not fail pr=
obe
> so that hopefully someone goes and fixes it!
>

sure

> > +             als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * als->r_sel=
ect);
> Why do we need this when we didn't before?  The range checks are the same
> so it smells like it shouldn't need transforming. I'd also rather we didn=
't do
> rewriting of the meaning of r_select like this.  Just use a local variabl=
e for
> the intermediate result.
>

before pdata passed resistor value as actual register value, not we
are getting the actual resistance in ohms from the tree and must
convert it into register value.

> >
> >               ret =3D regmap_write(als->lm3533->regmap, LM3533_REG_ALS_=
RESISTOR_SELECT,
> > -                                pdata->r_select);
> > +                                als->r_select);
> >               if (ret)
> >                       return dev_err_probe(dev, ret, "failed to set res=
istor\n");
