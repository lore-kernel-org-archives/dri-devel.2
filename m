Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0B1CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E914112D74;
	Sat,  6 Jun 2026 07:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ihCgpgVx";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 298B5112D74
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 07:22:55 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-13721dfd471so3573284c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 00:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780730574; cv=none;
 d=google.com; s=arc-20240605;
 b=hkKvO6dPcKvSc56YXB5DoYpQe4HY0p7a6vVF0XmuquDKwJQXjMs6TQ9C/zl0nMvU19
 +260Hbqfr6NUCvaM5ZZnelg2y1EZ0wzoN9RudVDJwYCc0qrlS6RoPj+YQUnFoqFZ3qd1
 q7MN14OGiCoj/TX8kyGaSoBrU0W9Al260q5NwrPoY+y9dhkzyxhNoTcP8krvmznrNXr/
 bIUqViov+9iDzfsJhKeTtCSrt1zEIaWiLZFf1nGg+51MTGfellOikCfgdIya1kZiYpEN
 1UHYkoxMb+Ovlnkrv5h0bS8yRhNzG8WyICCPucs8OX7tZSG43X326Vx9WV1Z1xa0JeJx
 bx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XNsDZHZrfK8USkMmXJwaiXlbXh0rWP0T8pk6zwRtmPo=;
 fh=AnylROuheLk7PtdkNbFde5iBCdvww2r4dG7odnfZcvE=;
 b=A9QxLxnq4Inqvx5nvPJcd9BV0sqpPh8pXQDN85nQqZ+V/p/4t5wbzX4rh3YncLy5hc
 ECSojg308FZp3xs918DapBsHYNpGkj0cKpnCCtbbHvAKSav3KMbICFs7FrdBvvEzbpYc
 cHmgDEVMd1vCPOii1Ii55VI6sUWv1PAaTIZUY57leopGrmOQyB2ofcxZvvrE28Nk8pjx
 uSCDjqFrQ/WvO/x/9b4ZoTFpgQTGPi7sSHzUC6c8WfzduARUhZLscjA0ztNkg78uu94N
 1txNsvrVCsOPogvhmOrAL/8LgX+tnfWeCsZ7Bj71zAKKaPM4SFjOkN/cOcl24QLQk+g/
 XO/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780730574; x=1781335374; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNsDZHZrfK8USkMmXJwaiXlbXh0rWP0T8pk6zwRtmPo=;
 b=ihCgpgVxcqobcHO+oK4XJdGZpqAVYh27ca1tH9MWcPXQPI/2m/6pmKIHv6saLhhyQD
 awHuQgFF5VMd4BSoXto5EVf9wCs1i43si+QzLf4WxVhBK4LmP3b+iWQ8Oni2clrVgsD+
 FZ2mD8ykC2+mBXGaMn2UCztER/fUCvXjaW0UU2h6ND/OeAgMJRvw7KcLP9D1ou4/tUZN
 pK0bQTvlTpAB4XulCBh+9Yd+g63HN5TeVsaN+4OPRCxOkRtwmq3xsXq8RJESd1l8WbKU
 eonhguWn/GTetOHFZHU6y5vvG8nJi3jCXwzZTmn5hO5D+W3a1O2GFtJzgRngYFQXmBDn
 oXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780730574; x=1781335374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XNsDZHZrfK8USkMmXJwaiXlbXh0rWP0T8pk6zwRtmPo=;
 b=rOyWmLmEX2jE7ooXqivcqr/ZrWppND0520qPPd5dluypiEq+fTBu/Ut52eM76GLISZ
 0iECU+5gsZyiU4pv0+E6v18Gd0a0RPOsX7DudDgi7UxiMJwC4Wx6ms9Yr0fEBcyO6sL9
 Cj4zpJV0VPIY0R2TeNiMfe10FHug3/qXRBkJfOXpSEeij/MRAJd2MG1wiv5QFcNrlG+k
 tE5roa4sN3Y2RLJrG1eRPS2mBXO2je78JOQ/CkEF71Hd+RWAxeHmRDyC7zbgvC0CLbh1
 EYP+hXFTRia31vl0nCDbd7nymLMySTznkNQs0RdQMrSFrI3Upsr5Wss2yEeMeESLcsN1
 oPzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PTG6axLljmHn9uU80+aXOKZ1pQeaVLNFYU5I8ftq4Oe2O24cWqpCdHhOEwesBTPAWNKF+4EGX3R0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyK57r/BMCB+YEYP2jkU3d3IuHNqmCpaIburmQDFZ0Q9eJpC+Qn
 ZhOs1PNLLNYyOc5IoTdrrUhLB2N0Rf5igTIc61c4avzxvae2vjGnGTIbOj2mSUqws7xCBOyQfO9
 97mOGtGWs+khtpUN5acu+n6cZ+d1zwgE=
X-Gm-Gg: Acq92OGkq5TTRvgjHSERNQZwg3Gdkm/tR/p1GuODF6Fgu3lhI/FlHVTIomLTh9j4v6G
 LGJujT5bjrA5nJ8K+rQZiOnrs+318uTIa2yUNFTlZizeaXZttAjbhI5JG4Ou+iw22iQKMXQo2K9
 atppNIqxlyXPhvCIYqr1q+JvZqCaLKN0l9Q0VGGLG3swuz0DKakUwvKksj4Uxaf9H25AQ5v1WPa
 5oeYpFsI+8F5KtsjstaXDlSOHgUpBwKv1IrKcqO7NA3v5Y7hqbnGYW6JJO0KoGdiMnD8nYM7ZOl
 fsXAycBQqF7XA0Ha+7lG39kfYTo5Pg==
X-Received: by 2002:a05:7300:7488:b0:2cb:4b8f:b2bd with SMTP id
 5a478bee46e88-3077af30ab5mr4444661eec.6.1780730574227; Sat, 06 Jun 2026
 00:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-3-clamor95@gmail.com>
 <aiPDzdKuccdLIvlF@ashevche-desk.local>
In-Reply-To: <aiPDzdKuccdLIvlF@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 6 Jun 2026 10:22:43 +0300
X-Gm-Features: AVVi8Ceg74fnSrmdqpxPSKGHcf0CnCmmeoCyMtr9C-KzyjgDa-9lYe4AaFHwWbI
Message-ID: <CAPVz0n2rdgw8Xr3uxVdQGwrHTNFqK4SKQDFU2FEB8LzLwPhQ_A@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] mfd: lm3533: Remove driver specific regmap
 wrappers
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

=D1=81=D0=B1, 6 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 09:53=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:26AM +0300, Svyatoslav Ryhel wrote:
> > Remove driver-specific regmap wrappers in favor of using regmap helpers
> > directly.
>
> I like the idea of this patch. Nevertheless I have some suggestions below=
.
>
> ...
>
> >  {
> >       struct lm3533_als *als =3D iio_priv(indio_dev);
> >       u8 reg;
> > -     u8 val;
> > +     u32 val;
>
> Strictly speaking this should be unsigned int. The regmap API use unsigne=
d int.
>

Yes, though regmap defines only 8 bit to be used so it should not matter

> ...
>
> >  static int lm3533_als_set_int_mode(struct iio_dev *indio_dev, int enab=
le)
> >  {
> >       struct lm3533_als *als =3D iio_priv(indio_dev);
> > -     u8 mask =3D LM3533_ALS_INT_ENABLE_MASK;
> > -     u8 val;
> >       int ret;
> >
> > -     if (enable)
> > -             val =3D mask;
> > -     else
> > -             val =3D 0;
> > -
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_ZONE_INFO, val,=
 mask);
> > +     ret =3D regmap_assign_bits(als->lm3533->regmap, LM3533_REG_ALS_ZO=
NE_INFO,
> > +                              LM3533_ALS_INT_ENABLE_MASK, enable);
>
> In cases like this perhaps leaving mask would be fine and together with

I prefer to remove intermediate variables it the helper allows to
directly pass needed value.

>
>         struct regmap *map =3D als->lm3533->regmap;
>

next patch drops lm3533 so there will be als->regmap which IMHO is
more logical instead of passing entire lm3533 to child devices.

> this be nice one-liner:
>
>         ret =3D regmap_assign_bits(map, LM3533_REG_ALS_ZONE_INFO, mask, e=
nable);
>
> >       if (ret) {
> >               dev_err(&indio_dev->dev, "failed to set int mode %d\n",
> >                                                               enable);
>
> In many cases it won't increase LoC count.
>
> ...
>
> >  extern int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, =
u8 val);
> > -extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, =
u8 *val);
> > +extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, =
u32 *val);
>
> >  extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val)=
;
> > -extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u8 *val=
);
> > +extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *va=
l);
>
> Now they become asymmetrical. Perhaps to replace setters, but be careful =
about
> upper bits.
>

Yes, I have same thoughts. Upper beats should be irrelevant since
regmap should use only fist 8 bits but I will be careful, thanks.

> --
> With Best Regards,
> Andy Shevchenko
>
>
