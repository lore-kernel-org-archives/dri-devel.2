Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA2CCA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 17:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A987E10E2B3;
	Mon,  5 Oct 2026 17:18:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a2t8d2Bf";
	dkim-atps=neutral
Received: from mail-dy2-f33.google.com (mail-dy2-f33.google.com
 [74.125.229.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCAB910E2B3
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 17:18:43 +0000 (UTC)
Received: by mail-dy2-f33.google.com with SMTP id
 5a478bee46e88-3510f6f130bso1677969eec.3
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 10:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791220723; cv=none;
 d=google.com; s=arc-20260327;
 b=LVnudPHjR5yRiXgEPI5cgcrjdUHTsjV3szKQ6ygvma2d7PUJqHtPMduitb6V3UcgEh
 hOmwEgi6kVU27OI6r9MH/B2Hl1YA61ubZJp7E6hSujTGGQz8LqeGs+KLstPrj3SealQl
 gQMKW1bMv0gLWGFevqEwMsZQSPnrNQqaMlDKmanhFH8XS1JxhpcZJTahqlrGdhLH0opI
 LoxpmgPhLu8I7bO45NRqrCVwuYGVWuWbXieeBH+EoDh4R+F8EazUYM/Dpja5MfOfrad/
 SDQgmidqfV2f3z3CByAg+esAZ/fP+w7GD3YogyueQ8PEKniSYjZhAVL0/iM76b2adjZG
 kqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FJFeJtfT8/aRZATxwvI0/pPdKdSmPKSztHUwOt17NCQ=;
 fh=A6rXyUPVcCC6XrR+zgQcp+1bitagzbzBj06z8GLtE8c=;
 b=Igxx6Ju4phfvvcSPac27XvOulyf8/LiGs90i7NR13O9v9yWt4MqHMpgvVPqwsT2dkz
 ghzc8aQ3veRWPI7SBUJ2+Hj5e6DQGA0Ql5IEu7YYD3/auxbnpFxPx3YwTaCYe4awMMyX
 DQaKCL1cuORAXPchLopl4w0ujs+N4jU6KVyUjwednC5ubhtL2z9/+f6+DLKEf/P7mf5s
 EeSuCx454RlD20jAEjOrVVUupx9MsvNYUJvXUpDjRRg+eAcuWW0X9LJl5zkrHTXHRbA+
 a0/7Jka2By79p2ftuw8OAsFAwvrM2TZ+ndLEarNXX0HhmSusZHh0AZB8Dm1a4wr4q2Sn
 YuGQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791220723; x=1791825523; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FJFeJtfT8/aRZATxwvI0/pPdKdSmPKSztHUwOt17NCQ=;
 b=a2t8d2BfMhp4sOErldA9P6oFpoKHq4kH1tAvldNdL0VqeEcEPU5SdOFpLCI9dq4n9I
 QIDa1gqSm9ND0rm4YVNDO8n5CKICup/5neqenSBQhZAIPP2DGY9oRPZjVQqLLSZaY9tK
 duHbVS6voQv4iWIOqnLhtHbLjjND9x2CKumdrlxLP+aCRTG5ZlgQGL9Jf+/6rdUonRpN
 dMEDWYfEMecdFx4WkH5OOWTUaAlEF2iMgo//qDnJmbZLt/R37q9KXjhCiFXVmqdCuM31
 ITvfntjKoWE7LYIzXEyB+x7K9LLIBEaecZIbRv/1RP/Fu2/l96cwLKeQ1dqIXxZ1mDF9
 htRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791220723; x=1791825523;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FJFeJtfT8/aRZATxwvI0/pPdKdSmPKSztHUwOt17NCQ=;
 b=eZwu+M9OVsy/0tBjhFinAzm21Iv/M9zERlxXUY1pJc1YydkWANqnk/Q4vW4YR4TBDx
 wixos2zwdWgz8AabW0QOnuXL4pHrAOapTi1xpVYNiWAf4CJGf2aPU7VMl4IoLOLxGW/D
 fivkHgslORhvkqzTMuNxiD7vlVjgk9UjRLxpA+tXfTUIPP/uiHQyQqrJNEiSoD7okOix
 j228hBPjMZTBCkHqPjh6oIpbfeaVRnd2Rqt6zOZCP0252+f99UqXuDbONXMxrlr7fWSh
 jcBnK31FkTSSwu2lheT86utOYTjeq41vhidIfTrICAqlLoy/JgRpzdql2ETtYlBgdk7P
 ypFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4LF43iMKZ/6gEJE2ECdQrji7bbb43xkvkgeDHIEKWuSMRmA3HzFqWz018ebFjLNuNVOfV5Y3t3vU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lsheHJDyfn8d7Bh5HeTa6bwvZlExbccdRwdU8AA1hjPlkPNKI5
 k/84DJKoCySBd0mESQq5kFiT2px//cltVtDoGq5e59lsgcZL8nZyz/qCB6POynoJD7ZWFbH2G7w
 c9Kc29IaklPk/m7ZUYEBYzlxNKau7Xu4=
X-Gm-Gg: AYBFou28yS/fg21ABWcfQ9+iWyGGw/RD5Q3do54YLbmFeHX8T914hfQk+DBeKIepxFC
 U3GcKslO/ISBqF50WAHmiMK69Bm/YTaJF0qvad66//ThNfMOEBHeT2VG2fhBaVHQ+G7FTfz3RJG
 2YYA3kSpShOs5LsJKF4UPkr5/8u44Ia3g5ZlONtB0sb5k6uY55E5ND3U7IqhsG91pB7I3i49EYJ
 0baC15wA6gkqxObWtIjH+U4fWawzVHYwZLoQTZu+hOFNFZeUrffq00EsS/sZKpHC/bSm3HpNxY4
 RLjlqn83fPd3xRTR+gEKYQSc+y2m1Kn0GQwxei7wpn7Qu+6PwGr25ZlOsOBdGwf2Y7TZ7tAPKAY
 9xGwTrLkV1LAF
X-Received: by 2002:a05:693c:87d1:20b0:34c:1bc7:bcb with SMTP id
 5a478bee46e88-34f159887a3mr13944123eec.22.1791220722737; Mon, 05 Oct 2026
 10:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20261004164121.193514-1-clamor95@gmail.com>
 <20261004164121.193514-3-clamor95@gmail.com>
 <asPVmbvyslGgEsjk@aspen.lan>
In-Reply-To: <asPVmbvyslGgEsjk@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 5 Oct 2026 20:18:31 +0300
X-Gm-Features: AclHuK8sdu976map0XQTAXXmXCzthY8nwPjOHGJ7oTbO_2PaU56B3jQ1t93eAwE
Message-ID: <CAPVz0n29+1yOO0i057RdpUAu+z85hhnm9GGaHkqgf5XW1SPfeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mfd: aat2870: Convert to use OF bindings
To: Daniel Thompson <danielt@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
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

=D0=BF=D0=BD, 5 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:51=
 Daniel Thompson <danielt@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Oct 04, 2026 at 07:41:20PM +0300, Svyatoslav Ryhel wrote:
> > Conversion of the AAT2870 driver to use OF bindings requires a few comp=
lex
> > changes that should be done simultaneously.
> >
> > The AAT2870 essentially provides two functions via child devices:
> > backlight and regulators. Both functions are fairly self-sufficient and
> > may not be populated on the final board. Consequently, the MFD
> > registration API was replaced with of_platform_populate(), and each
> > sub-device was given its own compatible string.
> >
> > Additionally, aat2870-core utilizes an enable GPIO. Obtaining this GPIO
> > was converted to use modern gpiod/OF helpers, allowing the redundant
> > aat2870_enable() and aat2870_disable() helpers to be removed.
> >
> > The aat2870-regulator driver was updated to register each of the four L=
DOs
> > from a dedicated OF node.
> >
> > The aat2870-backlight driver was changed to populate all required
> > properties from a dedicated Device Tree node. Its channel map was updat=
ed
> > to use u8 instead of int. Furthermore, because the maximum current is n=
ow
> > parsed as an absolute value rather than an enum entry, the calculation =
and
> > application of the maximum current were updated accordingly.
> >
> > All of the changes above allow platform data to be removed entirely.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/mfd/aat2870-core.c            | 115 ++++++--------------------
> >  drivers/regulator/aat2870-regulator.c |  76 ++++++++++++-----
> >  drivers/video/backlight/aat2870_bl.c  |  55 ++++++------
> >  include/linux/mfd/aat2870.h           |  95 +--------------------
> >  4 files changed, 111 insertions(+), 230 deletions(-)
> >
> > [snip]
> >
> > diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backl=
ight/aat2870_bl.c
> > index 8b790df1e842b..933a8f728f66a 100644
> > --- a/drivers/video/backlight/aat2870_bl.c
> > +++ b/drivers/video/backlight/aat2870_bl.c
> > @@ -15,11 +15,19 @@
> >  #include <linux/backlight.h>
> >  #include <linux/mfd/aat2870.h>
> >
> > +/* Backlight has 8 channels, each bit represents one channel */
> > +#define AAT2870_BL_CH_ALL    0xff
> > +
> > +/* Backlight current magnitude (uA), 450uA current is eq to 0 */
> > +#define AAT2870_CURRENT_MIN  450
> > +#define AAT2870_CURRENT_MAX  27900
> > +#define AAT2870_CURRENT_STEP 900
> > +
> >  struct aat2870_bl_driver_data {
> >       struct platform_device *pdev;
> >       struct backlight_device *bd;
> >
> > -     int channels;
> > +     u8 channels;
> >       int max_current;
> >       int brightness; /* current brightness */
> >  };
> > @@ -30,7 +38,7 @@ static inline int aat2870_brightness(struct aat2870_b=
l_driver_data *aat2870_bl,
> >       struct backlight_device *bd =3D aat2870_bl->bd;
> >       int val;
> >
> > -     val =3D brightness * (aat2870_bl->max_current - 1);
> > +     val =3D brightness * aat2870_bl->max_current;
> >       val /=3D bd->props.max_brightness;
>
> What is the purpose of max_brightness?
>
> Normally it is used to limit brightness but max_current is already doing
> that. Is it just being used to reduce the number of steps in the
> brightness scale (and if so, why is that useful)?
>

This is the original driver behavior; I did not modify it.

The AAT2870 backlight intensity is regulated by the Main Backlight
Current Magnitude register. It has 31 steps from 450uA (0) to 27.9mA
(31), so even setting max_current to 0 will not disable the backlight.
The max current value may be limited for some configurations, which is
why this property exists.

The max_brightness property determines the maximum number of steps the
backlight can have and is mapped to the available current range
provided by the hardware. The backlight is controlled in steps, not in
uA.

>
> >
> >       return val;
> > @@ -42,7 +50,7 @@ static inline int aat2870_bl_enable(struct aat2870_bl=
_driver_data *aat2870_bl)
> >                       =3D dev_get_drvdata(aat2870_bl->pdev->dev.parent)=
;
> >
> >       return aat2870->write(aat2870, AAT2870_BL_CH_EN,
> > -                           (u8)aat2870_bl->channels);
> > +                           aat2870_bl->channels);
> >  }
> >
> >  static inline int aat2870_bl_disable(struct aat2870_bl_driver_data *aa=
t2870_bl)
> > @@ -96,24 +104,12 @@ static const struct backlight_ops aat2870_bl_ops =
=3D {
> >
> >  static int aat2870_bl_probe(struct platform_device *pdev)
> >  {
> > -     struct aat2870_bl_platform_data *pdata =3D dev_get_platdata(&pdev=
->dev);
> >       struct aat2870_bl_driver_data *aat2870_bl;
> >       struct backlight_device *bd;
> >       struct backlight_properties props;
> > +     u32 max_brightness =3D 0;
> >       int ret =3D 0;
> >
> > -     if (!pdata) {
> > -             dev_err(&pdev->dev, "No platform data\n");
> > -             ret =3D -ENXIO;
> > -             goto out;
> > -     }
> > -
> > -     if (pdev->id !=3D AAT2870_ID_BL) {
> > -             dev_err(&pdev->dev, "Invalid device ID, %d\n", pdev->id);
> > -             ret =3D -EINVAL;
> > -             goto out;
> > -     }
> > -
> >       aat2870_bl =3D devm_kzalloc(&pdev->dev,
> >                                 sizeof(struct aat2870_bl_driver_data),
> >                                 GFP_KERNEL);
> > @@ -140,18 +136,18 @@ static int aat2870_bl_probe(struct platform_devic=
e *pdev)
> >
> >       aat2870_bl->bd =3D bd;
> >
> > -     if (pdata->channels > 0)
> > -             aat2870_bl->channels =3D pdata->channels;
> > -     else
> > -             aat2870_bl->channels =3D AAT2870_BL_CH_ALL;
> > +     aat2870_bl->channels =3D AAT2870_BL_CH_ALL;
> > +     device_property_read_u8(&pdev->dev, "skyworks,channels", &aat2870=
_bl->channels);
> >
> > -     if (pdata->max_current > 0)
> > -             aat2870_bl->max_current =3D pdata->max_current;
> > -     else
> > -             aat2870_bl->max_current =3D AAT2870_CURRENT_27_9;
> > +     device_property_read_u32(&pdev->dev, "led-max-microamp", &aat2870=
_bl->max_current);
> > +     aat2870_bl->max_current =3D clamp(aat2870_bl->max_current, AAT287=
0_CURRENT_MIN,
> > +                                     AAT2870_CURRENT_MAX);
> > +     aat2870_bl->max_current /=3D AAT2870_CURRENT_STEP;
> >
> > -     if (pdata->max_brightness > 0)
> > -             bd->props.max_brightness =3D pdata->max_brightness;
> > +     /* If max-brightness property is missing or set to zero, use chip=
's max value */
> > +     device_property_read_u32(&pdev->dev, "max-brightness", &max_brigh=
tness);
> > +     if (max_brightness)
> > +             bd->props.max_brightness =3D max_brightness;
> >       else
> >               bd->props.max_brightness =3D 255;
>
> IIUC max_current can be zero (since AAT2870_CURRENT_MIN <
> AAT2870_CURRENT_STEP). Since that means aat2870_brightness() will
> always return 0 then there might need to be a special case
> max_brightness for this case.
>
>
> > @@ -181,9 +177,16 @@ static void aat2870_bl_remove(struct platform_devi=
ce *pdev)
> >       backlight_update_status(bd);
> >  }
> >
> > +static const struct of_device_id aat2870_bl_match_table[] =3D {
> > +     { .compatible =3D "skyworks,aat2870-backlight" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, aat2870_bl_match_table);
> > +
> >  static struct platform_driver aat2870_bl_driver =3D {
> >       .driver =3D {
> >               .name   =3D "aat2870-backlight",
> > +             .of_match_table =3D aat2870_bl_match_table,
> >       },
> >       .probe          =3D aat2870_bl_probe,
> >       .remove         =3D aat2870_bl_remove,
>
>
> Daniel.
