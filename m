Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65481CD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D464810FD68;
	Fri, 29 May 2026 11:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EZAddAKd";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F16710FD68
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:06:48 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304c520fe9aso5003789eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 04:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780052807; cv=none;
 d=google.com; s=arc-20240605;
 b=eB1f+6VsIye8VVbP1A/9x3gIHdW0E9o2o9or6SQZniIeEIwAfS7j1aiAkteSlpSFKq
 wQQ/adwQKR1g3hrJ8AwDxmPo7rRCU0+Ui0dHcVAW6W451DUlB2ZwZarDtVbk1IsLJSGJ
 eLlfGbzmOhAK+5dcyjAqGVxAzwS33brUfLAZSUtGuB8NDVs3vzL73DWP8tNwufIsaMsy
 upCZeYbVLJvFJND4w+Ri1vAItMIma1756BWoii6NhH+FDfDIhbuIaFZ+VABv8l7GnsYL
 1ZTqPipLqebTSdQBH0VgfsOTxG/e35nYkbOwZuKzNFuSTVcmKyoMbhuVvMSIci06qWtk
 lOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LmadBKdB4Tf6OOuj36z3zIm/LqobfnTJZ4j9RKZPk70=;
 fh=HJyqgfoWN37RpGBVnAiz0hEewmEZ5n2/brN+ZFKdbhM=;
 b=DGmzb4U/gzHRPGaJdD0OGS8T/vYm5OXP70/OuTlKvsWHB9hsfCKXeUUyinMrDrDXQM
 zfGhviNv5/JXAz04esWDpKwn+32BnRM/wKOc1lZ3pLxY331cUS6cSuvhaGVcSlRa6MDi
 NZz3OW6y3KNUhSwwJ0WH4+YUuGGbr5ehbTVF+dKucgzG1PMko2lwTTceikEhmTJaEOwp
 Y3pkhWzdaMANzpgEKovDDMRe01T0NzLGwHc0HPVZt7633mDt9YY6KWtNnIEk68quD/2F
 lNwo+daAhB7Jru5MR4yibUrBzgs3hYxwjhT7utqJ7d0KGu6IAeA/nsjVkM0FLYMJsc4C
 TX1A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780052807; x=1780657607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LmadBKdB4Tf6OOuj36z3zIm/LqobfnTJZ4j9RKZPk70=;
 b=EZAddAKdannQhNE98S8mJ6SDHh8T2JvktYn/r9v1OiTMG6a+WBXYFg52SWYz3k5T8c
 cDJBFNbkpH0jDvc1E6Z1MjyvrLso4uvk5BBfIVBq//Ky+tgMF90iDKkQnwH8lagFvXbb
 DYd13iikXmG2fRhHpCDDW68lMZxapE3bu6UWrLP10D7uwmjicgSHfaIZWICV+3ME8B2G
 N2JR644Ua27VudrpIrhb8A7ItoqZhRG6t5fP6pu7ibnqzjLF6AyiOp+08ob+92tH/Uw6
 57my0KWJ9GOOZVRopbiWgZrrlNSsoJUb96sg7wnTcRsV+Fljea5YCLD3R9V0rvzTDYvl
 MhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780052807; x=1780657607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LmadBKdB4Tf6OOuj36z3zIm/LqobfnTJZ4j9RKZPk70=;
 b=Js/QmaRtpDMw6f8Ci8iFGBkfhRN4m6uXNioNfB53Ta3zajQ85lnPSBDM7w1mEv1WmY
 BaYem1yHPaYh9jZt4fNFwP767aj1OeOmXni2i4iPCiztjD0RzCnwgo/Bh67MPw2upV9s
 GbUEPA9T/mL6PyAWjyC5m24PftW9Ai2LzLAQHwQDPOUCnBe3rzpks0BdazV5E0bovZ49
 3uTfNSYcFg2NKaTN8Uw0plwh1c10Jvj4Mc/pT+KJNHo/aV2VtSHX39UJzQL333DuZ6WD
 NgHfUBsIfZvM+w0IsNfApNxp6SU4PrBVDCysnx3nfZoLNW3KVFV0rwBspcJSuv9P2nFa
 w5DA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SQ56quKUNgLC/hRXvuQom75OJdt/efV/N01qnjt/iAwWvkKDzNAJ9AnEX30zPYNQOxvrdZP3VFN0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzO09A1c9vLXDnlTUV5+o09bCB00ioVqhc5T9CcU5/lJOpi1kdj
 QJXh5w8rQin7HjKI5YrrpoTLAKhr0IIt7sw/GwcTJU+rNJlSHoloc7PNYsTpef1CZmS8TqF9n8n
 xkSYd3s0dC6EzBF2j5SEluUDiSAkOEis=
X-Gm-Gg: Acq92OHT7DXoy7FG7W49j9C/tr8u4cou9Sq6qZyk6ZsEaVUYRtvu3Kl6lM9OJjxX3cr
 LN6N0LfNjVt7HtSjdUKXgdSb++E2SL6lVYcbnxJtcoevQObSqBuH6Wg7VNNom/5upWA1yNgzqwy
 E3RUr6Dezmcl58o99CEpRJ/ORqhdpJ6bGcloGiaShdGWWkN3RK8qttLgcQTlSXM8pgq2uyrOETP
 xmI2Bk9OmOo2fvY9VP78qrTA3otZP0QO+4yTO9uOJpfX4fjb3w1VUDkjDqBebkxXZUW89QPy4Cr
 +9Umm+2eNuSXIfx9NRE=
X-Received: by 2002:a05:7300:230a:b0:304:c651:bdfe with SMTP id
 5a478bee46e88-304eb0e0873mr1128093eec.17.1780052807341; Fri, 29 May 2026
 04:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-3-clamor95@gmail.com>
 <ahlxvGRVFDFrTUN3@aspen.lan>
In-Reply-To: <ahlxvGRVFDFrTUN3@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 14:06:36 +0300
X-Gm-Features: AVHnY4KaFyk9CM74sBMVnXwM-QNoUHCxCc551JZM8S6RjnbIpb-ePbED6pxRxh8
Message-ID: <CAPVz0n0jXsd2CDhEPkr4bo+n59q3S=bEs5i4Hh4tur60aa2OZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mfd: lm3533: Convert to use OF bindings
To: Daniel Thompson <daniel@riscstar.com>
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

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 14:0=
0 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, May 28, 2026 at 04:51:19PM +0300, Svyatoslav Ryhel wrote:
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
> > Additionally, optimize functions used only by platform data.
>
> The last sentence is a little vague and makes us have to hunt for the
> changes in a relatively large patch. If it is referring to the change to
> common up the init and update code then it's would better to say that
> explicitly!
>

If I understood Jonathan properly, the last sentence will get its own patch=
.

> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/iio/light/lm3533-als.c      |  95 ++++------
> >  drivers/leds/leds-lm3533.c          |  51 ++++--
> >  drivers/mfd/lm3533-core.c           | 268 ++++++++++------------------
> >  drivers/video/backlight/lm3533_bl.c |  52 ++++--
> >  include/linux/mfd/lm3533.h          |  51 +-----
>
> Just one comment for backlight, below:
>
> > diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backli=
ght/lm3533_bl.c
> > index babfd3ceec86..42da652df58d 100644
> > --- a/drivers/video/backlight/lm3533_bl.c
> > +++ b/drivers/video/backlight/lm3533_bl.c
> > @@ -295,13 +293,20 @@ static int lm3533_bl_probe(struct platform_device=
 *pdev)
> >       bl->cb.id =3D lm3533_bl_get_ctrlbank_id(bl);
> >       bl->cb.dev =3D NULL;                      /* until registered */
> >
> > +     name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d",
> > +                           pdev->name, pdev->id);
> > +     if (!name)
> > +             return -ENOMEM;
> > +
> >       memset(&props, 0, sizeof(props));
> >       props.type =3D BACKLIGHT_RAW;
> >       props.max_brightness =3D LM3533_BL_MAX_BRIGHTNESS;
> > -     props.brightness =3D pdata->default_brightness;
>
> Given the big changes to the driver is there any chance of putting a
> good value in props.scale (BACKLIGHT_SCALE_LINEAR or
> BACKLIGHT_SCALE_NON_LINEAR)?
>
> If the difference between 50% and 100% *looks* like 50% then the scale is
> non-linear (since humn perception of brightness is not linear).
>

Yes! But not in  this patch. This patchset has a dedicated patch
implementing linear and non-linear configuration from tree which may
include this configuration as well. No guarantees though, but I will
keep in mind this request. Thanks!

>
> Daniel.
