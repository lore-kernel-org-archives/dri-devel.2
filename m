Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3765CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 10:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D6710FCEA;
	Fri, 29 May 2026 10:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RcmXz2eJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0E610FCEA
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 10:48:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B2DCB41A74;
 Fri, 29 May 2026 10:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2F21F00893;
 Fri, 29 May 2026 10:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780051720;
 bh=IANqlFtCzIw3GljQUv2sPx7JsQM7CwojrRvHLqwmyl0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=RcmXz2eJQZwVulgIIkCTYoQ0c8dgOJL85lQwMJXAL8HuzHlCjYZDjRkkhstqTZtqv
 QejNJ85wxWujfuLlzzpF2ub9Ep0D1ZSVmlkwiKyNoFLTVMD6el15W10K0MxMzyJJJJ
 rdJlWBIWSfKce5PtrAQ4djc0c8LTYZHF96gSmCvueADoLfNckdN9oAw86nZtzTKtSJ
 lB9y/9eo2EBz+7zC84/7M+IAef3KBrC4VCUlz8Zx4u0zaGkG0MFvRIlNbLKsOyZouX
 tGbvWPKJL0T59SD8uuKpSrK2nmAUztcU65jtxCnOAIpVEZjH7ZpetapTBxI+EQix96
 PY5d+S1uP0Kow==
Date: Fri, 29 May 2026 11:48:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mfd: lm3533: Convert to use OF bindings
Message-ID: <20260529114828.5a87c732@jic23-huawei>
In-Reply-To: <CAPVz0n0VHdUo5oHdALgcerLsykdz-2n7c+jxYHrMOV7Ra5x_qQ@mail.gmail.com>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-3-clamor95@gmail.com>
 <20260528155001.2bcb7003@jic23-huawei>
 <CAPVz0n0qCekQVGGyAyBuYv+RKC6bpydYBLJNGfPrgTYjtOJOuA@mail.gmail.com>
 <20260529100819.1823ebb3@jic23-huawei>
 <CAPVz0n0VHdUo5oHdALgcerLsykdz-2n7c+jxYHrMOV7Ra5x_qQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 29 May 2026 12:39:56 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 12=
:08 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Thu, 28 May 2026 18:03:31 +0300
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > =20
> > > =D1=87=D1=82, 28 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=
=BE 17:50 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5: =20
> > > >
> > > > On Thu, 28 May 2026 16:51:19 +0300
> > > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > > > =20
> > > > > Since there are no users of this driver via platform data, remove=
 the
> > > > > platform data support and switch to using Device Tree bindings.
> > > > > Additionally, optimize functions used only by platform data. =20
> > > >
> > > >
> > > > At least the IIO ones would have made much the same amount of sense=
 for
> > > > dt, just that they weren't having in the first place. I'd prefer th=
at =20
> >
> > Gah. I write gibberish after too much reviewing.  having/helping!
> > =20
> > > > as a precursor patch to make the rest much more readable.
> > > > =20
> > >
> > > I can add you preferences into this commit, I don't mind.
> > > =20
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com> =20
> > > >
> > > > I only looked in detail at the iio bit. A few changes requested.
> > > > =20
> > > > > ---
> > > > >  drivers/iio/light/lm3533-als.c      |  95 ++++------
> > > > >  drivers/leds/leds-lm3533.c          |  51 ++++--
> > > > >  drivers/mfd/lm3533-core.c           | 268 ++++++++++------------=
------
> > > > >  drivers/video/backlight/lm3533_bl.c |  52 ++++--
> > > > >  include/linux/mfd/lm3533.h          |  51 +-----
> > > > >  5 files changed, 212 insertions(+), 305 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/l=
m3533-als.c
> > > > > index 99f0b903018c..cbd337b73bd9 100644
> > > > > --- a/drivers/iio/light/lm3533-als.c
> > > > > +++ b/drivers/iio/light/lm3533-als.c =20
> > > > =20
> > > > > @@ -714,59 +720,33 @@ static const struct attribute_group lm3533_=
als_attribute_group =3D {
> > > > >       .attrs =3D lm3533_als_attributes
> > > > >  };
> > > > >
> > > > > -static int lm3533_als_set_input_mode(struct lm3533_als *als, boo=
l pwm_mode)
> > > > > +static int lm3533_als_setup(struct lm3533_als *als)
> > > > >  {
> > > > > -     u8 mask =3D LM3533_ALS_INPUT_MODE_MASK;
> > > > > -     u8 val;
> > > > > +     struct device *dev =3D &als->pdev.dev;
> > > > >       int ret;
> > > > >
> > > > > -     if (pwm_mode)
> > > > > -             val =3D mask;     /* pwm input */
> > > > > -     else
> > > > > -             val =3D 0;        /* analog input */
> > > > > -
> > > > > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, val=
, mask);
> > > > > -     if (ret) {
> > > > > -             dev_err(&als->pdev->dev, "failed to set input mode =
%d\n",
> > > > > -                                                             pwm=
_mode);
> > > > > -             return ret;
> > > > > -     }
> > > > > -
> > > > > -     return 0;
> > > > > -}
> > > > > -
> > > > > -static int lm3533_als_set_resistor(struct lm3533_als *als, u8 va=
l)
> > > > > -{
> > > > > -     int ret;
> > > > > -
> > > > > -     if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESIS=
TOR_MAX) {
> > > > > -             dev_err(&als->pdev->dev, "invalid resistor value\n"=
);
> > > > > -             return -EINVAL;
> > > > > -     }
> > > > > -
> > > > > -     ret =3D lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_S=
ELECT, val);
> > > > > -     if (ret) {
> > > > > -             dev_err(&als->pdev->dev, "failed to set resistor\n"=
);
> > > > > -             return ret;
> > > > > -     }
> > > > > +     device_property_read_u32(dev, "ti,resistor-value-ohm",
> > > > > +                              &als->r_select); =20
> > > > Does this have a default?  If so the pattern we've recently be sett=
ing on for IIO
> > > > is
> > > >         if (device_property_present(dev, "ti,resistor-value-ohm"))
> > > >                 ret =3D device_property_read_u32();
> > > >                 if (ret) //corrupt property in some fashion
> > > >                         return ret;
> > > >         } else {
> > > >                 //set default
> > > >         }
> > > > If there is no default then check it unconditionally. =20
> > >
> > > default value is LM3533_ALS_RESISTOR_MIN and if no property is present
> > > clamp will ensure that als->r_select will be set to
> > > LM3533_ALS_RESISTOR_MIN =20
> >
> > I don't see that default in the binding doc and relying in the 0 being =
clamped
> > isn't particularly readable - I'd set it explicitly.
> > =20
>=20
> Oh, ye, my bad. Schema enforces one of props to be present and if pwn
> is present then resistor is ignored. What if I move resistor reading,
> clamping and conversion under !als->pwm_mode check? Then resistor must
> be present and hence must be checked unconditionally.

Sounds good.

>=20
> Additionally, I can comment original lm3533_als_setup with #if 0
> #endif then git formatting will be much cleaner and easier to review,
> and once we all come to result I will just remove entire commented
> block and Lee can pick clean commits.

No don't do that.  If you flatten the two helpers as a precursor patch
then the changes in here will be easier to review anyway.

>=20
> > =20
> > > =20
> > > > =20
> > > > >
> > > > > -     return 0;
> > > > > -}
> > > > > +     als->r_select =3D clamp(als->r_select, LM3533_ALS_RESISTOR_=
MIN,
> > > > > +                           LM3533_ALS_RESISTOR_MAX);
> > > > > +     als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * als->r_selec=
t);
> > > > >
> > > > > -static int lm3533_als_setup(struct lm3533_als *als,
> > > > > -                         const struct lm3533_als_platform_data *=
pdata)
> > > > > -{
> > > > > -     int ret;
> > > > > +     als->pwm_mode =3D device_property_read_bool(dev, "ti,pwm-mo=
de");
> > > > >
> > > > > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > > > > +     ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF, als->pwm=
_mode ?
> > > > > +                         LM3533_ALS_INPUT_MODE_MASK : 0, =20
> > > >
> > > > That's ugly.  Better as
> > > >
> > > >         ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF,
> > > >                             als->pwm_mode ? LM3533_ALS_INPUT_MODE_M=
ASK : 0,
> > > > =20
> > >
> > > Yes sure, just followed 80 char limit.
> > > =20
> > > > Though if there wasn't a layer hiding the regmap, it could just hav=
e been
> > > >
> > > >         ret =3D regmap_assign_bits(lm3533->regmap, LM3533_REG_ALS_C=
ONF,
> > > >                                  LM3533_ALS_INPUT_MODE_MASK, als->p=
wm_mode);;
> > > >
> > > > which would have been nicer.
> > > >
> > > > I'm not particularly keen on the swashing of the helpers being in a=
 patch =20
> >
> > smashing.  (this definitely wasn't my best effort at English!)
> > =20
> > > > that is about switching the binding type as feels largely unrelated.
> > > > Should really have been a precursor, easier to review patch.
> > > > =20
> > >
> > > Removing of lm3533_update layer is not the scope of this patchset. =20
> >
> > Understood.  I'm fine with just the refactor you are doing brought out =
as a precursor
> > patch.
> > =20
>=20
> I have looked into removing wrappers too. That seems to be less a
> hassle that I anticipated, so I will include regmap switch in the v2.

Ah ok. Even better.

>=20
> > > =20
> > > > =20
> > > > > +                         LM3533_ALS_INPUT_MODE_MASK);
> > > > >       if (ret)
> > > > > -             return ret;
> > > > > +             return dev_err_probe(dev, ret, "failed to set input=
 mode %d\n",
> > > > > +                                  als->pwm_mode);
> > > > >
> > > > >       /* ALS input is always high impedance in PWM-mode. */
> > > > > -     if (!pdata->pwm_mode) {
> > > > > -             ret =3D lm3533_als_set_resistor(als, pdata->r_selec=
t);
> > > > > +     if (!als->pwm_mode) {
> > > > > +             ret =3D lm3533_write(lm3533, LM3533_REG_ALS_RESISTO=
R_SELECT,
> > > > > +                                (u8)als->r_select); =20
> > > >
> > > > Same applies here. Mostly an unrelated change as the only thing swi=
tching that
> > > > is related to the patch is one parameter.
> > > > =20
> > >
> > > Removing of lm3533_write layer is not the scope of this patchset.
> > > =20
> > > > >               if (ret)
> > > > > -                     return ret;
> > > > > +                     return dev_err_probe(dev, ret, "failed to s=
et resistor\n");
> > > > >       }
> > > > >
> > > > >       return 0; =20
> > > > =20
> > > > > @@ -852,25 +825,28 @@ static int lm3533_als_probe(struct platform=
_device *pdev)
> > > > >       indio_dev->channels =3D lm3533_als_channels;
> > > > >       indio_dev->num_channels =3D ARRAY_SIZE(lm3533_als_channels);
> > > > >       indio_dev->name =3D dev_name(&pdev->dev);
> > > > > -     iio_device_set_parent(indio_dev, pdev->dev.parent); =20
> > > >
> > > > I'm not sure why this was there in the first place.  Hence not sure=
 if it
> > > > is safe to remove.
> > > > =20
> > >
> > > This is directly related to OF conversion. The iio_device_set_parent
> > > bound indio_dev to parent, and it causes problems with OF now since
> > > als output has its own node and binding it to parent if wrong. Same
> > > story for backlight and leds btw. =20
> >
> > Is there any risk anyone was using the canonical path to get to the iio=
 dev?
> > /sys/bus/platform/devices/..../iio\:deviceX
> > This is technically an ABI change be it a subtle one.
> > =20
>=20
> Linux kernel has no users of this driver, and it is in "stale" state
> for more then 2 years (maybe even longer). I have cc'd Johan Hovold.
>=20
> https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
>=20
> This this 2 y. o. discussion and there were no actions ore movements.
> I assume this driver in its current form has no more users. This does
> not mean that it cannot be revived though.

So, just to check, are you a user of this code or is this more trying to
help out with old code?

Jonathan

>=20
> > =20
> > > =20
> > > > =20
> > > > > diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm353=
3.c
> > > > > index 45795f2a1042..d707d43d5526 100644
> > > > > --- a/drivers/leds/leds-lm3533.c
> > > > > +++ b/drivers/leds/leds-lm3533.c =20
> > > > =20
> > > > >
> > > > >       led->cb.dev =3D led->cdev.dev;
> > > > >
> > > > > -     ret =3D lm3533_led_setup(led, pdata);
> > > > > +     device_property_read_u32(&pdev->dev, "led-max-microamp",
> > > > > +                              &led->max_current); =20
> > > >
> > > > I'd prefer explicit setting of the default to be visible before thi=
s, or
> > > > the property_present pattern I mention in the IIO review above.
> > > > =20
> > >
> > > clamp will ensure that led->max_current will be set to
> > > LM3533_LED_MAX_CURRENT_MIN regardless if it it present =20
> >
> > As above, I'd prefer it set explicitly.
> > =20
>=20
> I understand your position and I am not denying it for ALS part, but
> LEDs don't belong to IIO subsystem and different subsystem maintainers
> may have drastically different preferences and requirements (ugh, PTSD
> in its full glory).
>=20
> > > =20
> > > > > +     led->max_current =3D clamp(led->max_current, LM3533_LED_MAX=
_CURRENT_MIN,
> > > > > +                              LM3533_LED_MAX_CURRENT_MAX); =20
> > > >
> > > > I didn't look any further (busy day!) =20
> > > =20
> > =20

