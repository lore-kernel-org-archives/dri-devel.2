Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E6DC44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A9C10ED37;
	Tue, 14 Jul 2026 13:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jjOdgnSW";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C161110E06E
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:31:20 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-388b404ea89so904943a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035880; cv=none;
 d=google.com; s=arc-20260327;
 b=JkfUU4kw5w+xQcds2BnYafRPeHraIDiAV8U6ru3YpU035ADpBOdbwpX6wjKJ2DVALU
 dLj9PgTKXNYHMNzdr1SQGHk3AiKkZVoYuzyWAj4Rma2+ETYJs9zq12rXfJt8+Mjzmkqx
 XV6n1Vl/MdCzqDB9FRVO+sTOj06130YH1bly4FR7f78jv0Vzsaf7W/sKUGxTVvtwSytM
 Q19ABj4KeJ54B1GGhTjPR8NnXWgqG5F1xAg9p8QzezNohin03z43yGY1QvT6sA8p+yvw
 EYjz+vxie1DFAH48H7tuFcjvd84uKAlHppmTRN9OBDH/4VBbTZhMtQxzDMte6zt8Q5Is
 tR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kLfW8NpBLmGd5rRr/q7P+WdrGpDQQoBNPKO5OnQCHQk=;
 fh=j+L9txZgxOVqgRlJQ5feLffBFFOogV2nzZvEg8W81JA=;
 b=n+KaMfIxhIkElhOFJo1sSG0/WUcxo/MY2hyroMMn+6RtuICDZDHS9vg/ectaiBYBKZ
 J31v9d7uF2t8VQ428eA8qw0BgjqUVYBYmR1ek5XJglwh499JMDL9ZQwCSga/ObQam9YF
 qGsuunz0qFgsS70Vyz/W45hDD6oxEUqz0UIsOGxs/U44Rl5lxWzRk5Syh7TEnPETqZM7
 lFmnv6ku2lUjSv2CuuOQv5bE2QkxuRU8VEqAflRZSEbFCZyj+Rd4MFTILAHV3qEM2ICp
 +IlHkZrumgaNkJDeo0s87czyzztrWBfTOHsN/pPW2kSEIeoKC0yfl9WB/dml7gfiGXdj
 ph6w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784035880; x=1784640680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kLfW8NpBLmGd5rRr/q7P+WdrGpDQQoBNPKO5OnQCHQk=;
 b=jjOdgnSWlLfs9ntwuZj6+EuInCTUzWWmcAtPnSF1bHc5/KrNaEmdJuao/OtBAsvLCs
 nBonsOGC8zkFBtOHSE4aggrJw5l4qnaYUGHO8a95AwCl6FrypQ/SlyrwY7Lu7KWefSCy
 OqlElpqpy7tPhllcprFMe0jG40IVBMgvnzF1OHvYo8FWRMde+2cCTBki5nOWSWVUgp3e
 dq8KhJPr+vNLZ76Eqybt9nY7fGZPa3epOwbQlNpwFGQyhsh2A6ZC31UUcvCQqxiVZ1IO
 WpqyBxWlBlHEBizT/qZviGF11BFd92lgvSI/WGdgS55+znlM0NNWAoDbRRW3Sz2f/jyj
 aP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784035880; x=1784640680;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kLfW8NpBLmGd5rRr/q7P+WdrGpDQQoBNPKO5OnQCHQk=;
 b=tFMCH5E4C7vVUWn/wcopfwITI7fCMyM4zihLtHijzdGFnLs5IqjP0HV/QmzK5Q9xI3
 cS3P3cgm5AJaNPS6HLxxIdu/RUwkm6DjGUOxlTgjmIOT3PuRbdiHM5Oc1VxVcPA98FJN
 T/LDtJSk1lETzewwGb+WfJA9d5CAm2XFD5+WQGhh6SpKYdweTW+0wfJmYUUiDU5Es11i
 yEUhSdsuDeouF7zE8YorXtRWYr4Mqiqcrk98A6F5ZZuFnNIglbwIiRc5zQvX8eBJNsql
 jnFkfxor4ck2+9qivZeTwHKAbXZWxZCtU/UqfOjUOhiiw7tjIMeKTN6G/wY/g/2BmS0C
 8vhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOUNyser56GqE+2iJDBZcc1p14hEA1uqSgyIGd4fzNj96OcUAeGLH4CFyjNO88VB3xForsV/66jc0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwilfowaN3ToNO3GKR/ExnGShC2u+qcL9A3OLcElUWiFoJwHg0/
 ylSzb1o/Kq1a+j77fvfhaIH+U6MhSSZQ9wrMWMbHO57OEGlzQ3TJbSSBQvrj0EzGN9ygbVpQ0W9
 lWcjqUwqPxzEjXb80bfoAf39nClX3+5o=
X-Gm-Gg: AfdE7clkaykFCe5GEi3qbuy8lxV4Gn5noWy4AaFOHOVZnCz+MoajGKGZ70/yrzckfuc
 CLR5Z6gGoAAQcMqJbw1ELTMMEvJbT9tjhRE4TR91+Hp1oC+2FyxeludKoxektOoq6CHRUG2cVnL
 LQV7E/GE5nqfw038uBHNmYx55Fx7uF61oFELXHSbEAvkMiQUuc6ZAxsUkUmLLAsLc0X609lbrO7
 c+5/Rm1oeVQweqdKH4ppg56CZ2xsCKW7aMHWccbyXf1LyIBoyKffiegRNW78JBoZbzCogIHsaVF
 CwsjURrH9SRJeFK3TX46jPNbO0fiolN1bSKOr2im
X-Received: by 2002:a17:90b:5607:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-38d13c60530mr18215292a91.5.1784035880304; Tue, 14 Jul 2026
 06:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-6-clamor95@gmail.com>
 <akeHC-OA8tqM941f@hovoldconsulting.com>
In-Reply-To: <akeHC-OA8tqM941f@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:31:08 +0300
X-Gm-Features: AUfX_mxzYxEuGLMctIZqZIdW8wmxIrFK1WcO0C4FctuVUcu9qYtJIaIs5OSxe4o
Message-ID: <CAPVz0n2DPia=nfvd3W-rHy91OvZNO6jdSczT7kyvH-G138KJyg@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] iio: light: lm3533-als: Remove redundant pdata
 helpers
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-fbdev@vger.kernel.org
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

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:55 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:22AM +0300, Svyatoslav Ryhel wrote:
> > The lm3533_als_set_input_mode() and lm3533_als_set_resistor() functions
> > are used only in lm3533_als_setup(). Incorporate their code into
> > lm3533_als_setup() directly to simplify driver readability.
>
> That's a debatable claim.
>

Adding helpers to wrap custom regmap wrappers seems redundant twice.

> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/iio/light/lm3533-als.c | 56 ++++++++++------------------------
> >  1 file changed, 16 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-=
als.c
> > index a9af8e2b965f..69bac1b202f1 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
>
> > -static int lm3533_als_setup(struct lm3533_als *als,
> > -                         const struct lm3533_als_platform_data *pdata)
> > -{
> > -     int ret;
> > -
> > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > +                        pdata->r_select);
> >       if (ret)
> > -             return ret;
> > -
> > -     /* ALS input is always high impedance in PWM-mode. */
> > -     if (!pdata->pwm_mode) {
> > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > +             return dev_err_probe(dev, ret, "failed to set resistor\n"=
);
> >       return 0;
> >  }
>
> There's nothing hard to read about the above. To the contrary the logic
> is more obvious this way.
>
> You also remove the high-impedance comment for no good reason.
>

Removing one level of indentations without obscuring readability is
always a good idea.

> Johan
