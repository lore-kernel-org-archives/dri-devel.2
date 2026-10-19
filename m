Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999060820EA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L7S/xHDf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CDFE10E6C5;
	Mon, 19 Oct 2026 14:56:22 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFD110E6C5
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:56:16 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-35f036b17easo117480eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792421775; cv=none;
 d=google.com; s=arc-20260327;
 b=J/Hj+Mq49oOd3V8gPAkJdoJeOQkjKj2QoB+BLb1g2GCVL5Q2YZITkNuK0pyCwVClqA
 fDt/SPFuZf7k4+OaCOzBu+DW2bG5zD1YzmyTAQ41ymT5Ofr/51sGLnKjhOMVkvVpioHD
 H0c9fsrD6p6B3FF8+zq5BIlXZa2u8z96M2zu7yXId04HEjlBRFbDv5G7uYCIcJFgjJtc
 ldlYTxnAM5E0gTm1fvqemxBprvQdd3t/8f8o7NoQe8a/fUHslLNd4fK4c+OqwxnngLtk
 Avwm3Mzlah5ixeTlF99mshKC1uktFBtC+KQkboCmZzo5eqTAMW5fVmSg4n48aaHY/Rfc
 P22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kQLz+XfAveV/B4k+ADa75qLK4k5ajQjrtzEnIHfPNDU=;
 fh=xKRc1gwbizKH2NGcMOJvrC22FDNaUJwCHhrSYNxJycQ=;
 b=X2ZRyIENBr9W5PsxUrmdDYJ1IgdVagIcya+gLf91bZNKO4S8xmcvqZz9NWJuxuzoHm
 9z7pHq+m1wWLo5p8o6xUhiuyr75wirFzE63ddSValafGbX8c7yFhEDyGvKlLsW7dIEXJ
 ADTXv/FC0ZJB4qhsCR1/5+EiQksvbxFSrOB+D67dVZtZ98ijskWkzYwMnO3mwALZCLk9
 PCXVfh+rq8h0e/ti1Gwod7/SLWt2dx5a39DTRME3WLwXIrfywgC1rzwqHTaq8zV7/AeP
 /i2Pnm188viluchQRKIYl/kvxgjGIJhioGajbdtjYqAM91pBUUzCeIGs0UBtNgGpt7Cx
 oJZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792421775; x=1793026575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kQLz+XfAveV/B4k+ADa75qLK4k5ajQjrtzEnIHfPNDU=;
 b=L7S/xHDfttzrLWM+cwn/yxgVltfrnQVPYv7wd62vQfkpCYDPeH3D9GKGotmYPy2jZI
 +1o4Zfrm9PhsqDSDUmy0rp7KjoYTuu1pzoHP7GdaYHyLI6zyC/uGf+hOG4OhGyvsRXpB
 hIaysP6W3ZilX+wpVz5L2mTBWhW6565mLm/c5ZrttA7a8FdSUKBpNYWCL8vLSzbkBGxI
 CzOLP7mthbUwzM+JXZ52HFHZxYkG2AbdFPR8zguUWgghXEuF5DnlehfUJUhiSYqldFno
 XogPLG59EKRExvaSMQ3NKKwSy/M5d8IYxLLCBlrhWKC5NFTizlqT64YC29+qEjb+YEp1
 6PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792421775; x=1793026575;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kQLz+XfAveV/B4k+ADa75qLK4k5ajQjrtzEnIHfPNDU=;
 b=G7CpLtDpj4GcNV+AKGEwXzyv8pqduDa3oYxbDKcXK3P4PIFm8wMTwBPOpvNVc101l5
 wb8NFbtl/k8KaJ7i3JodCp5KMMn4N98f0u46T8BGCjDHhgJUjKhaVjZkZB5acroXRb9w
 lvnScu/L98i26up/uXjXGJYCg+ATdfvCYSCin7uN/RVHYEjEZ0X1Cgns5WVPwUz6O96Z
 7jAfGdq7Ks4Fhq4rPjV/ji9ypA5BWm9/WLXrFc0UWoQ+pXwGqwPYArmx0Tq7/8ruP2eX
 y0G8ha7924Ae+UE7MM6PKG4Se78Hf14nQ3nuf/SU/KHKgp3+NqYJnWePF7FkdS4txtsA
 BisA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzc1xB5Q+YmwEni0iFD2SekJK0+3YWlq+4T28xBeoia3DmlA24DQTjba3MJr0xNuQVsn+Ex2vawOTU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIzNRj0+EiGOCSwf8m8Mftua7sNFs5rUO2RfAxkj+6KVwjq6eci
 BTnXrt57lJJ21P80mSG1bpQ1x9fMyemyrZX+A3x6RCI8ToqwcEZFFYmgMkH9SnwBlczICWlTo6/
 9HcHjlvBAi8Tj5UC/ymZSuf5zEKLP+N0=
X-Gm-Gg: AYBFou2mKK6tOARfKiYgCFRRzrH3t/edy1GbXyHTytvNBBVa/G7rCC42rc7rVaUBhS3
 oKNIOmRpFJlKrBXw0phR9It1Mwbf97Db/nQ9tlVcjjij0iVNJgGLijJ2w4TKsznfF6kB1150tJe
 9akjcqm44CjIEVbVrIPGZXowBI8FksbMXjwvbafCHxaguOe2ct1Y6vnrykxmqd0G8xtFKlCBMre
 74gEhJ3xw+CP89cA8ZZ9Yh5XWOZu1zxJrCvPsTgG8FH3gd60pvwJArRBJdiBlAxdos2WyJGemKt
 yELk5bpSstwOviNH+lpIEt2Zjmbo9pAqq6HKlkGb1TuDJIdHNEW877IKx6x5Rts8TjDHxhwGIPa
 +xgk2eujXT+c0LDRaux+P4W0=
X-Received: by 2002:a05:693c:20d2:10b0:356:7ddb:2e54 with SMTP id
 5a478bee46e88-361a2349f61mr12825749eec.29.1792421775026; Mon, 19 Oct 2026
 07:56:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-4-clamor95@gmail.com>
 <179198329794.839288.10569542357230656958@kernel.org>
In-Reply-To: <179198329794.839288.10569542357230656958@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 19 Oct 2026 17:56:02 +0300
X-Gm-Features: AclHuK-So1fk-SufXF9ELHqjLzJsGlTnieaKofgBf88_CnYDM-h4bTkcCd70Qok
Message-ID: <CAPVz0n3cfh3LcYwARJ-5gkvQZj3cPVG8XGwH+YkPaOrW36cJ-A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mfd: aat2870: Convert to use OF bindings
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 19 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:5=
1 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, 13 Oct 2026, Svyatoslav Ryhel wrote:
>
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
> > from a dedicated OF node using modern regulator framework.
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
> >  drivers/mfd/aat2870-core.c            | 115 +++++--------------
> >  drivers/regulator/aat2870-regulator.c | 159 +++++++++++---------------
> >  drivers/video/backlight/aat2870_bl.c  |  51 +++++----
> >  include/linux/mfd/aat2870.h           |  95 +--------------
> >  4 files changed, 121 insertions(+), 299 deletions(-)
> >
> > diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
> > index 0d56cd6fbc6a5..909c14ee60323 100644
> > --- a/drivers/mfd/aat2870-core.c
> > +++ b/drivers/mfd/aat2870-core.c
> > @@ -16,8 +16,15 @@
> >  #include <linux/gpio/legacy.h>
> >  #include <linux/mfd/core.h>
> >  #include <linux/mfd/aat2870.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/regulator/machine.h>
>
> Since we are moving away from legacy GPIO and MFD APIs here, does it
> make sense to replace '<linux/gpio/legacy.h>' and '<linux/mfd/core.h>'
> with '<linux/gpio/consumer.h>'?
>

Sure

> > +struct aat2870_register {
> > +     bool readable;
> > +     bool writeable;
> > +     u8 value;
> > +};
> > +
> >  static struct aat2870_register aat2870_regs[AAT2870_REG_NUM] =3D {
> >       /* readable, writeable, value */
> >       { 0, 1, 0x00 }, /* 0x00 AAT2870_BL_CH_EN */
> > @@ -61,34 +68,6 @@ static struct aat2870_register aat2870_regs[AAT2870_=
REG_NUM] =3D {
> >       { 0, 1, 0x00 }, /* 0x26 AAT2870_LDO_EN */
> >  };
> >
> > -static struct mfd_cell aat2870_devs[] =3D {
> > -     {
> > -             .name =3D "aat2870-backlight",
> > -             .id =3D AAT2870_ID_BL,
> > -             .pdata_size =3D sizeof(struct aat2870_bl_platform_data),
> > -     },
> > -     {
> > -             .name =3D "aat2870-regulator",
> > -             .id =3D AAT2870_ID_LDOA,
> > -             .pdata_size =3D sizeof(struct regulator_init_data),
> > -     },
> > -     {
> > -             .name =3D "aat2870-regulator",
> > -             .id =3D AAT2870_ID_LDOB,
> > -             .pdata_size =3D sizeof(struct regulator_init_data),
> > -     },
> > -     {
> > -             .name =3D "aat2870-regulator",
> > -             .id =3D AAT2870_ID_LDOC,
> > -             .pdata_size =3D sizeof(struct regulator_init_data),
> > -     },
> > -     {
> > -             .name =3D "aat2870-regulator",
> > -             .id =3D AAT2870_ID_LDOD,
> > -             .pdata_size =3D sizeof(struct regulator_init_data),
> > -     },
> > -};
> > -
> >  static int __aat2870_read(struct aat2870_data *aat2870, u8 addr, u8 *v=
al)
> >  {
> >       int ret;
> > @@ -196,22 +175,6 @@ static int aat2870_update(struct aat2870_data *aat=
2870, u8 addr, u8 mask,
> >       return ret;
> >  }
> >
> > -static inline void aat2870_enable(struct aat2870_data *aat2870)
> > -{
> > -     if (aat2870->en_pin >=3D 0)
> > -             gpio_set_value(aat2870->en_pin, 1);
> > -
> > -     aat2870->is_enable =3D 1;
> > -}
> > -
> > -static inline void aat2870_disable(struct aat2870_data *aat2870)
> > -{
> > -     if (aat2870->en_pin >=3D 0)
> > -             gpio_set_value(aat2870->en_pin, 0);
> > -
> > -     aat2870->is_enable =3D 0;
> > -}
> > -
> >  #ifdef CONFIG_DEBUG_FS
> >  static ssize_t aat2870_dump_reg(struct aat2870_data *aat2870, char *bu=
f)
> >  {
> > @@ -332,9 +295,7 @@ static inline void aat2870_init_debugfs(struct aat2=
870_data *aat2870)
> >
> >  static int aat2870_i2c_probe(struct i2c_client *client)
> >  {
> > -     struct aat2870_platform_data *pdata =3D dev_get_platdata(&client-=
>dev);
> >       struct aat2870_data *aat2870;
> > -     int i, j;
> >       int ret =3D 0;
> >
> >       aat2870 =3D devm_kzalloc(&client->dev, sizeof(struct aat2870_data=
),
> > @@ -348,60 +309,29 @@ static int aat2870_i2c_probe(struct i2c_client *c=
lient)
> >
> >       aat2870->reg_cache =3D aat2870_regs;
> >
> > -     if (pdata->en_pin < 0)
> > -             aat2870->en_pin =3D -1;
> > -     else
> > -             aat2870->en_pin =3D pdata->en_pin;
> > +     aat2870->en_pin =3D devm_gpiod_get_optional(&client->dev, "enable=
",
> > +                                               GPIOD_OUT_HIGH);
> > +     if (IS_ERR(aat2870->en_pin))
> > +             return dev_err_probe(&client->dev, PTR_ERR(aat2870->en_pi=
n),
> > +                                  "Failed to get EN GPIO\n");
> >
> > -     aat2870->init =3D pdata->init;
> > -     aat2870->uninit =3D pdata->uninit;
> >       aat2870->read =3D aat2870_read;
> >       aat2870->write =3D aat2870_write;
> >       aat2870->update =3D aat2870_update;
> >
> >       mutex_init(&aat2870->io_lock);
> >
> > -     if (aat2870->init)
> > -             aat2870->init(aat2870);
> > -
> > -     if (aat2870->en_pin >=3D 0) {
> > -             ret =3D devm_gpio_request_one(&client->dev, aat2870->en_p=
in,
> > -                                     GPIOF_OUT_INIT_HIGH, "aat2870-en"=
);
> > -             if (ret < 0) {
> > -                     dev_err(&client->dev,
> > -                             "Failed to request GPIO %d\n", aat2870->e=
n_pin);
> > -                     return ret;
> > -             }
> > -     }
> > -
> > -     aat2870_enable(aat2870);
> > -
> > -     for (i =3D 0; i < pdata->num_subdevs; i++) {
> > -             for (j =3D 0; j < ARRAY_SIZE(aat2870_devs); j++) {
> > -                     if ((pdata->subdevs[i].id =3D=3D aat2870_devs[j].=
id) &&
> > -                                     !strcmp(pdata->subdevs[i].name,
> > -                                             aat2870_devs[j].name)) {
> > -                             aat2870_devs[j].platform_data =3D
> > -                                     pdata->subdevs[i].platform_data;
> > -                             break;
> > -                     }
> > -             }
> > -     }
> > +     gpiod_set_value(aat2870->en_pin, 1);
>
> Is this needed when 'devm_gpiod_get_optional()' already requested the pin=
 with
> 'GPIOD_OUT_HIGH'?
>

I will check, most likely it is not. I will adjust in v5.

> >
> > -     ret =3D mfd_add_devices(aat2870->dev, 0, aat2870_devs,
> > -                           ARRAY_SIZE(aat2870_devs), NULL, 0, NULL);
> > -     if (ret !=3D 0) {
> > -             dev_err(aat2870->dev, "Failed to add subdev: %d\n", ret);
> > -             goto out_disable;
> > +     ret =3D devm_of_platform_populate(&client->dev);
> > +     if (ret) {
> > +             gpiod_set_value(aat2870->en_pin, 0);
> > +             return dev_err_probe(&client->dev, ret, "Failed to popula=
te cells\n");
> >       }
> >
> >       aat2870_init_debugfs(aat2870);
> >
> >       return 0;
> > -
> > -out_disable:
> > -     aat2870_disable(aat2870);
> > -     return ret;
> >  }
> >
> >  static int aat2870_i2c_suspend(struct device *dev)
> > @@ -409,7 +339,7 @@ static int aat2870_i2c_suspend(struct device *dev)
> >       struct i2c_client *client =3D to_i2c_client(dev);
> >       struct aat2870_data *aat2870 =3D i2c_get_clientdata(client);
> >
> > -     aat2870_disable(aat2870);
> > +     gpiod_set_value(aat2870->en_pin, 0);
> >
> >       return 0;
> >  }
> > @@ -421,7 +351,7 @@ static int aat2870_i2c_resume(struct device *dev)
> >       struct aat2870_register *reg =3D NULL;
> >       int i;
> >
> > -     aat2870_enable(aat2870);
> > +     gpiod_set_value(aat2870->en_pin, 1);
> >
> >       /* restore registers */
> >       for (i =3D 0; i < AAT2870_REG_NUM; i++) {
> > @@ -436,6 +366,12 @@ static int aat2870_i2c_resume(struct device *dev)
> >  static DEFINE_SIMPLE_DEV_PM_OPS(aat2870_pm_ops, aat2870_i2c_suspend,
> >                               aat2870_i2c_resume);
> >
> > +static const struct of_device_id aat2870_match_table[] =3D {
> > +     { .compatible =3D "skyworks,aat2870" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, aat2870_match_table);
> > +
> >  static const struct i2c_device_id aat2870_i2c_id_table[] =3D {
> >       { "aat2870" },
> >       { }
> > @@ -444,6 +380,7 @@ static const struct i2c_device_id aat2870_i2c_id_ta=
ble[] =3D {
> >  static struct i2c_driver aat2870_i2c_driver =3D {
> >       .driver =3D {
> >               .name                   =3D "aat2870",
> > +             .of_match_table         =3D aat2870_match_table,
> >               .pm                     =3D pm_sleep_ptr(&aat2870_pm_ops)=
,
> >               .suppress_bind_attrs    =3D true,
> >       },
>
> --
> Lee Jones
