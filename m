Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA3ECD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709FA10EE75;
	Tue,  2 Jun 2026 10:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kFu7932F";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C5DC10EE75
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:18:33 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-304e58292d3so392103eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 03:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780395512; cv=none;
 d=google.com; s=arc-20240605;
 b=UPngSKyV32nfYwB4gC6hQ/SBO4BxhXuO4htmg8X/GFejZuqbpZ7wEFfUQuA73NdzbM
 Ctb/dXGeNH0kjJII1a7ACD9aBYHvWs5oCb2+NDylg41jPzXDxCKkrWcMmtt6WUmYzNj8
 4TLvX654c1gJ1KK6NKSgE0g5XFIYU1JX8Y3srSax5P8ZIcLRBmxHSlbhPzlAI7RdzjYm
 vfhGQu0RJos8W/tZadCCjuqDO8sXYZRrSfYtZFwwWDsFiumIs0Euy6n6qvGC9b8WxLiW
 ykXVlGbV2uu2KyXZCjHoZRtYXQMASZPvkWOFg1Mz1tnYRWGUiWFpxvzn9w0lyP/UxCdf
 Gvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OFZUuzZ+0IS+9EDZyoznNJZXjuYIGtdVqC67r/Z0ScE=;
 fh=jNECQw3sbOScT6PXwQBgReIrL1aljr4yukUHKUtjgJc=;
 b=T1jGzJymHHZVNmpwGnksHgsqPTipqxDjMXa5f861XGaPEJnW9SsBDFmO25arOusAx3
 5hSXdaplujSzWyBoi8JtUPtWEV8R4ikvUJvT+7dRFEFHOz4fb2YqfdhyaxnDHNCfoUo6
 qKMSvUbldPrd0oYfT9btAbOWTnQYOZ0ORL37gqVbSRrQby0mETryFjKZaFASBBb7tAJ5
 +5YwNXa4njWYQ0Vwz93CcMcR74p9lUnV3a/RelJ8ElriJRIw4wMd0ugiKkyXZJtLPpqw
 1sGKV32AFzlexCdv8phLw/b7Fd9Iuca5IheonciAwHYFw2uH2Km4KsO/qtyzCoylnPGF
 dSCg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780395512; x=1781000312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFZUuzZ+0IS+9EDZyoznNJZXjuYIGtdVqC67r/Z0ScE=;
 b=kFu7932FmItfH2wdBQiYBePggbXa+89Wcv4aZgzomJSaEzNJ8uiZyQo6kSk7oVBKhM
 FrOaE+mxWvsi7c6QtjRLYzfbK5fVo+Rl8LOUU7DpmojjpsejoABou2Z3aP0Q1mri/snC
 85ghTpgFrCACJZxXUza6X34r9RbdxGxqhnWIOh24fW8LDbFAPsil9RhXIIZE8uAG/n2V
 B86O2FmAegFpjhWyYETjD1PnAAZa/36hhRqTtopE7dCPEh+Ok4Q+v4mMa1bbnJk6IbR+
 7oUlUpAvjIgFe6+2KSmLGi2KTyBmh4wMQxf6NJR/vo7kpf+RilEBsRfRO7BoFtcZm1Sg
 7mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780395512; x=1781000312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OFZUuzZ+0IS+9EDZyoznNJZXjuYIGtdVqC67r/Z0ScE=;
 b=JRq0J1/DRiwd4vQ6LmmFU3Io+KpiUrC1S6ofii5H9rdUe115h1G8kIWB0OrTUe2Jzp
 XGZGG9A4G2JSVUaWSpXMvOjI3qLN1E35SfZdyTDLVd8wxANuY7RdVILCxW4qGW/YT+wQ
 IyLRHRxqieoCTWA9Ao+WseRhTQUu42qVvQ3kgCmntnlhX8goVGN/TVdULxurfrg8kXfB
 luph99vrdfiR+yfxlwZEKkktY+xTE4Y9KeXwDsBamQQpUKYG9k2L6ZURHE5p8otL4IoK
 MnK0NaOHR3uzHT38ccoy42/CUNUbS/NVgljCYeHgSZWojY3UwarMN6xNU7y62bRjFT16
 hSjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9g3m1yUslplKRdanB/09M17f4vhwnIqbA4NgOnMAUAC/igWX0P919eISUCYmT1aNy6mZzQDl2UF4c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzm5DlEnMWdoIooJUGVbaN+dqGECynfNXLP5+JobOQgdzwoUAx5
 HdETebCqvo+piYuTl4+huVff0BB1Adnj7PAEBsM7Z5XgNI78GYaFN7bTT1Ki3RhWOO6JpJPsNRU
 g0cvBs4zgvNmZ0XZEVMS3+lpXlPWU2T4=
X-Gm-Gg: Acq92OEN2Ivz2ztU7rAJqwa1Hi5kYKLI2FGKO8CsEJpVghOEX45brInMiPRwWFN3hcX
 B+JRJOS8DkFLVvfMtZF3H+ty1LbTk0qXIUj8Tz24WzwjLlQVFSMNlB7EtOwPq+iGkDQHiQyQEuQ
 lNncB+P9OPetz3qEeamiOQVHDFP21iqPxsMN+Jx5m8SV68PJCzwGhNnRi/TUKZhtQ4w6fWt2i+M
 4APcjam+LiFbkHVAz86T1Vd8qD0gbJNXXYTSQWArUcMlzHQkNqd8G6nBd3rS5WtirxHCIZ2zg5I
 CdwSZTt0Qut9yEsOjb/MsD2049+0Ww==
X-Received: by 2002:a05:7300:5726:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-304fa523d3amr7629148eec.3.1780395512175; Tue, 02 Jun 2026
 03:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-3-clamor95@gmail.com>
 <ah6O1h8SPwjf3rV1@ashevche-desk.local>
In-Reply-To: <ah6O1h8SPwjf3rV1@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 13:18:20 +0300
X-Gm-Features: AVHnY4JHC1yQblwim_AIT-fQGP6xAd5YIyw3Q9PUntQ6X-j1sNWq1k3TeFJP-_c
Message-ID: <CAPVz0n2vRFMKagLP+Ssq7n0ECp4_4mT6k7Bo9z=rxrSNCfCRKg@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] mfd: lm3533: Remove driver specific regmap
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:05=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Jun 01, 2026 at 06:18:22PM +0300, Svyatoslav Ryhel wrote:
> > Remove driver-specific regmap wrappers in favor of using regmap helpers
> > directly. The wrappers are mostly equivalent to the standard helpers, w=
ith
> > two exceptions: regmap_read requires an unsigned int pointer, and
> > regmap_update_bits has the mask and value arguments swapped. These
> > differences were accounted for and adjusted accordingly.
>
> We refer to functions as func(), exempli gratia, regmap_read().
>

Noted.

> ...
>
> > static int lm3533_als_get_current(struct iio_dev *indio_dev, unsigned c=
hannel,
> >                                                               int *val)
> >  {
> >       u8 zone;
> > -     u8 target;
> > +     u32 target;
> >       int ret;
>
> While at it, move towards reversed xmas tree order
>
>         u32 target;
>         u8 zone;
>         int ret;
>

Noted.

>
> ...
>
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_ZONE_INFO, val,=
 mask);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_ZO=
NE_INFO,
> > +                              val, mask);
>
> It's better to replace this to use _set_bits()/_clear_bits() or even move=
 from
> the above conditional (not in this context) to _assign_bits().
>

I will take a look.

> ...
>
> >       else
> >               val =3D 0;        /* analog input */
> >
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, val, mask=
);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CO=
NF,
> > +                              mask, val);
>
> Ditto.
>
> >       if (ret) {
> >               dev_err(&als->pdev->dev, "failed to set input mode %d\n",
> >                                                               pwm_mode)=
;
>
> ...
>
> >       /* Make sure interrupts are disabled. */
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_ZONE_INFO, 0, m=
ask);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_ZO=
NE_INFO,
> > +                              mask, 0);
>
> _clear_bits().
>
> >       if (ret) {
> >               dev_err(&als->pdev->dev, "failed to disable interrupts\n"=
);
> >               return ret;
>
> ...
>
> >       u8 mask =3D LM3533_ALS_ENABLE_MASK;
> >       int ret;
> >
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, mask, mas=
k);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CO=
NF,
> > +                              mask, mask);
>
> _set_bits()
>
> >       if (ret)
> >               dev_err(&als->pdev->dev, "failed to enable ALS\n");
> >
>
> ...
>
> >       u8 mask =3D LM3533_ALS_ENABLE_MASK;
> >       int ret;
> >
> > -     ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, 0, mask);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CO=
NF,
> > +                              mask, 0);
>
> _clear_bits()
>
> >       if (ret)
> >               dev_err(&als->pdev->dev, "failed to disable ALS\n");
>
> ...
>
> >       else
> >               val =3D 0;
> >
> > -     ret =3D lm3533_update(led->lm3533, LM3533_REG_PATTERN_ENABLE, val=
, mask);
> > +     ret =3D regmap_update_bits(led->lm3533->regmap,
> > +                              LM3533_REG_PATTERN_ENABLE, mask, val);
>
> _assign_bits() and so on...
>
> >       if (ret) {
> >               dev_err(led->cdev.dev, "failed to enable pattern %d (%d)\=
n",
> >                                                       pattern, enable);
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
> We don't need to keep 'extern' for ages.
>

I will no inflate this patchset further

> >  extern int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb,
> >                                                               u16 imax)=
;
> >  extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val)=
;
> > -extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u8 *val=
);
> > -
> > -extern int lm3533_read(struct lm3533 *lm3533, u8 reg, u8 *val);
> > -extern int lm3533_write(struct lm3533 *lm3533, u8 reg, u8 val);
> > -extern int lm3533_update(struct lm3533 *lm3533, u8 reg, u8 val, u8 mas=
k);
> > +extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *va=
l);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
