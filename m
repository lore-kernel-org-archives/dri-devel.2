Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ACECD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0AC710F135;
	Tue,  2 Jun 2026 13:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oXgC7Ybz";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0140B10F135
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 13:45:12 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-137f3cb3f46so63606c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 06:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780407912; cv=none;
 d=google.com; s=arc-20240605;
 b=Cu/AeqmRgBh0fZiButJ6Tnitqgfut8LehEpZst5Jw4Z3Aqlg/Bv4aEj+K85MJSQcLo
 sBvlMenllAjSESJ8SBNcBtQgD7UsMjaAx0r6Gvhlr390hekajOFN22O+w445zf8w1cXt
 t4iQzQ77ntpRmg8sDTWJeeOtF8xvghWWrptpHyqKSBAeReGBU4I1L+DgBXUqsaVQzfMY
 gKH81DC7HhOMGFJydPwMmi9unSPPQO5v2WD2NWUc/gp6EJw4Kws/pacK7skuf1D2IZDJ
 +sYv9oJzmbB229p85sdpIKfhejktJVMuIzyfeZzEnuPtouhTIhpLv3ROOXkpxg/FHydR
 qNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zT4hcJaJAxpNku3U6+68TAPB6S0TflnId/dwWCFEDQY=;
 fh=rzm8mqRK6qTneEUim9MK0dpLzcyTktrI39NvboP7Lt8=;
 b=QmZiBNSfFfDFoOcx0G99IidJd8K2KiVJMv2Z+ckI4Cencpqxm7DaqGqUi2C3/SKLad
 xvYPSXY4s2wiS65v2sLmiKsyzHXXh490wQue02Qg3Y8esN4VV0Kji6XVQZTExMlKTp+9
 mFuofjqYyGa+91vvCqunzsBXgqg2pS66LKIcWRtWnFqhhH5BUV/SwxInH+e4IxwvCaAn
 PdwAh8Zg00d3Q3qZlgf7kl064/1J4YeQNubDKSrj1IhP+l7oNba+lFFLskE+RKs3LUnC
 YzZR+xFzHSynsdwERe5Oy+cY8wUns9oOz3pdnSYrZLCrqJfaew0n3k+qQ8CuawJB+v3V
 3lyQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780407912; x=1781012712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zT4hcJaJAxpNku3U6+68TAPB6S0TflnId/dwWCFEDQY=;
 b=oXgC7YbzsGAoi9hKYdyMZ4MQ4HXlQ58RDO1MkN5UQxkIpFMEFbBe4EgBMbLyAEfzZj
 Jq6e2J/STm/eXpcC5uMYwQX3Hz7RQJeSlETPd+gRzD+QaNC1sax3iDFfj/DgLEfsPW6b
 9s8aWYNk5B2GcpmV6UV8QsHOItzcJ2RL+nLNbBtyyJxJHn+Y1urUByCkR8HHcPdyV640
 efPNmAdB+MO4mPODjSLnZ5HyXy+UgYbrPPLWb2qtDujMNFpodC3JS/cVYCDMkCgEVeO/
 J3l71SibpiK4iP1UppthTHy81Q76IXgrQiNp4Kb+Acln3E0EVQ0EI5HRusyZ4xkO/DDi
 8Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780407912; x=1781012712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zT4hcJaJAxpNku3U6+68TAPB6S0TflnId/dwWCFEDQY=;
 b=CS8S2+wSObXSYgrsUkHep+bfaBgJ2cq0MVprRDuNEteRL38eYncfonUJptYjkGt++P
 zZ3nGyM2dyocQxbbETzRN7JLIb7RrMt4ixuMPruTc1chGcHlwd6eWLOxWbfHq+X/eN8F
 czOAYRcmR5LWqbS93Qr7yp4H0rwwslre7Rzw9NTfBezB+Su+ZGs2YyQpRCi18a20h3v7
 881bz6OdXYgdktiv0t60GOTnRPHaRVUdL4MO+aq+dFiBHi7FmMvKMFcyWdYuLb5P4c8e
 yvy3T+uSJs2MS58UK4DsRDWEKfLVMDdsDL8v8o9jLUh0VIwseGDN0fi8m/0EpoOfyExW
 HCcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xkwX1/9J3ZE2PqNFMD/JwSDgbw9YJwBpZKa81eybeiFyVJk0ZqwSCFL8e+b05lf+ksUgGlc7Tfm4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIGDJ2tvFWsYoQNva04umGdiMqaKWArF7JuNyT8n6qY8KFT/fq
 V9KUfYof35XkQEPBMJtl0rSqLUIZ4i9pud4o1Y07YI0IeGM17hE4+EYhoq5kWfrbMfUewP7l+ut
 TToQIJ16QYe/nIpg/9gaDtYqe6TQGJdU=
X-Gm-Gg: Acq92OFlUBJetZgE7WDjPEhXiXWNi4wfjGhbT2fy9osW+Lx+fP9mTiwT08OmlTApU7F
 qIa8WO+/iRQUFJYcgcC0F4BX86JcVs+q4cR1ZrsHUNTH7OKs39YRBVMhbfFcyyxnRFFbUr54dn+
 cRMBWXASXeXwcPIbUTj7mONZmWRt1qD5oH0ByX6Nj1qkRBzqGYVEADVJCWKFs5y0G07ASo2YSRz
 NwYW/fSyVsQlvwrQprgrA40el4mX7SB2+4gg82dk8ZJlKe2CcMxUE+VErFSmJ/hhxL3Dm7kHCPe
 ShZ/BVm0udmqk3UNn/E=
X-Received: by 2002:a05:7300:724d:b0:304:8366:7456 with SMTP id
 5a478bee46e88-304fa4a97f7mr7197710eec.3.1780407912080; Tue, 02 Jun 2026
 06:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-4-clamor95@gmail.com>
 <20260602144222.7a50a041@jic23-huawei>
In-Reply-To: <20260602144222.7a50a041@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 16:45:00 +0300
X-Gm-Features: AVHnY4LTNpiSYmDW8xnqHecCTvTzpdUFD5jDfC_0pqaKrNHhEcy0XqCOTlsLpZ4
Message-ID: <CAPVz0n3x7KaaoZQAmpX-NCz2QNrhWNQaYFvX3pwS8DLb56bFuA@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] iio: light: lm3533-als: Remove redundant pdata
 helpers
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16:42=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon,  1 Jun 2026 18:18:23 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
> > used only in lm3533_als_setup. Incorporate their code into
> > lm3533_als_setup directly to simplify driver readability.
> Minor stuff inline.
>
>
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/iio/light/lm3533-als.c | 61 +++++++++-------------------------
> >  1 file changed, 16 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-=
als.c
> > index fb61904f110f..52136ca1abc9 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
>
> >  static int lm3533_als_setup(struct lm3533_als *als,
> >                           const struct lm3533_als_platform_data *pdata)
> >  {
> > +     struct device *dev =3D &als->pdev->dev;
> >       int ret;
> >
> > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CO=
NF,
>
> Maybe a local struct regmap pointer given dereferenced in a couple of pla=
ces.
>

sure, why not

> > +                              LM3533_ALS_INPUT_MODE_MASK,
> > +                              pdata->pwm_mode ? LM3533_ALS_INPUT_MODE_=
MASK : 0);
>
> Andy raised this in previous patch but in the interests of being specific
> regmap_assign_bits() is going to be cleaner here.
>

I am currently adjusting accordingly.

> >       if (ret)
> > -             return ret;
> > +             return dev_err_probe(dev, ret, "failed to set input mode =
%d\n",
> > +                                  pdata->pwm_mode);
> > +
> >
> >       /* ALS input is always high impedance in PWM-mode. */
> >       if (!pdata->pwm_mode) {
> > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> > +             if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> > +                 pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
> > +                     dev_err(&als->pdev->dev, "invalid resistor value\=
n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             ret =3D regmap_write(als->lm3533->regmap, LM3533_REG_ALS_=
RESISTOR_SELECT,
> > +                                pdata->r_select);
> >               if (ret)
> > -                     return ret;
> > +                     return dev_err_probe(dev, ret, "failed to set res=
istor\n");
> >       }
> >
> >       return 0;
>
