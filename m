Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29474CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 848B010EA10;
	Wed, 10 Jun 2026 14:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o6Pja300";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE7A10E9E9
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:35:32 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304f0039c02so12353225eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102132; cv=none;
 d=google.com; s=arc-20240605;
 b=gYNqju40qD7YDDy3gXFyxbcUMNpyBkNrlJqEhxUjeVfE1Wybt8qIM0OTCe6B7I0h8X
 kXakCNkZnL63RCEqYcpJUgQwcEBLCtCVV3hQpVgOgOBR5wQ4DSE4dWBNZ4ktDFGoW7hz
 QO+eP2vakch1Sj9JndjmiDJKQI7V7PW35tVJdQVHtrJX+sQ6aagWSboQsgasaSzMqf3O
 EqHdWJGrQGrTbZKXDUtB7k4Ko4sPSFOOupOUJNXfPi3wVoaNI3pNFn5xKiTeeMeMhknI
 PGdN21AjNP0QLzoS7XUoylj4IOE0mC8CgR7JFYz48WJ42kmtuHvriHfXPar/hGzn2/I3
 diDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5u4rWfzB/dXcaizEq3FSq09DXlW+GebEr04lNWgXuHI=;
 fh=OLIO9U7iYosMVmh8ivU4p0v/Rq/nWuJ5jIafxSJ/ozk=;
 b=LpCrFwf7yy2+uXkdGeB61oWCdJDXWeK67NEjuRB45HGUfQrrEVFa3Ren3Aqzlz2yuQ
 QiQ7790ZdvzbeA2Tb8NyISGMFq2DlikoudOSH5AOfXKdp/upqGNSTHs+7jml4cMmJZu+
 sOei9jyoL2Yt2Lv/dMh+oQxTsiUcmLE5wbpFKcVqZ1LddlfK3DGTXc7UfMNzZvYju6ki
 yESKD8LGo8JRVdqIRpUG37fkNu1A3EXyW284ZiHHydDXEofRcJQZtYUYjV4OSKU8dzWJ
 wbFDRaI445sfYKv9KZAsj6RWI5d0LGsm1J9QFGTM2X13ov98BBSk9B6XXGyW2mBVKcH8
 TFOQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102132; x=1781706932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5u4rWfzB/dXcaizEq3FSq09DXlW+GebEr04lNWgXuHI=;
 b=o6Pja30079h8zgDWZ3IwqULChFqV2ppzUWwkE+JpRxsipPC/oD13EqeYzCRpkw069a
 aOoDm7Ilnavw0mtZs2hKMyqjqffkvgS4VNYdpAQquiUSTbcy0NqBqYyBv4iSFiqgxI6w
 erMg9onFXHpHXixE56ijnLnWceTIWGxXVSUoMEnKe3N55etIvN//7ToofTYibbeXx9nf
 67+Ls3Rl1ypPDQxl2InEojvLW0iYJNM/yBa/b627ewPaHPrUGUWQqk/zi6VTCDbWEY0m
 cQJWABXVGB8v6vcDs4NWybysgBcg7CZcojhOMXw0ubrwmj4kPtBWRoMjRI2lDDH1mU3r
 I4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102132; x=1781706932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5u4rWfzB/dXcaizEq3FSq09DXlW+GebEr04lNWgXuHI=;
 b=Gy9mfbk0jGsAZ5ZJhDe0zwFro5GlMdXTfD/gQWLTyeGlM9TJQQf5PQFwfx8VC4v2DC
 CnO4k30P2d8c8xcVjigz7mffhTg3L/ziNWcsRVv+RRWzdmdhxZ+qeYPHCw8aFWscYTLU
 dxbyYFE8NqwKTN88EzL9K/fcJnzjumIPpPfJiByDCUr1BJREWV3h6Q+n6hCnWau6/2Nt
 XQLRx6TPmweBbXUyCP5iLRsGNm25W0Rdfuc09esdcahr2SLfvVKA4GaxOwZyL8PJ/oII
 21YkNuZy2X1a3/oWQQBoebLC3+LJ7JkmwFsk0D6L3git7tCZvpZFC8G/ldVvKilBqL7p
 rcwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cAopi9g/8Sl6JoWiphY3RmtIivvXl+DWU1pGPKi/NOAQwZ6omFvbn8uVWI09Hm0TVSUu7dwVpqe4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4bBOaitTijY+gi1KvfgrKK0MDBq+4xv9M/uXI2XdxWvcWskA7
 xQHHjnrhI3H7fNO0FE0DouPA14rG3FSa1pxilqENS4YRfS0Jedp8WwX+1QGThE/Jc4bF8PLP2eb
 QJSJLweAs5IeK+ZUm1aEPUheun71rNhI=
X-Gm-Gg: Acq92OHt86DO3ZuxCgqToP+tjRWiryoFffcwrawvX/+CleYf/4uJlmciYFJJuoK696n
 v6xVWP8wVd37/I1KcOT/kmpA8nHA75H5STItRwg7I6i9grCJHFWWB1eeUmrGqRHlZAJgL4c1sf/
 CvlmyQMtApSE8CunLlIYg5rl3XP0jFTxiiAO6q0WSStuMpRjZP7gBVVtBtWACsbSHLb9pQEjbbv
 Ro8UqqDdrK7N+EKLu/UmH6EMGUUWVXPLDnefPzZq7sBoc32HJrX2N/d0l9D+tHAHZ2xEU1xBH0b
 Jae40AGAlnQCTM+NuWs=
X-Received: by 2002:a05:7301:4186:b0:2ef:9961:27fa with SMTP id
 5a478bee46e88-307d62ddc77mr6085557eec.18.1781102131738; Wed, 10 Jun 2026
 07:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-6-clamor95@gmail.com>
 <aihlDGNZRuHI-vMR@ashevche-desk.local>
In-Reply-To: <aihlDGNZRuHI-vMR@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:35:20 +0300
X-Gm-Features: AVVi8CeF2WtE8NAfRo3Ry4_ONFpQ60FlY7Ry_ggOsna45f4Sc2pO4GqWSxBW8Fo
Message-ID: <CAPVz0n17uAvpyuF5_E1L49eoz8LvHULE0-SVjJpHvu4veWWjEQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] iio: light: lm3533-als: Remove redundant pdata
 helpers
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

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:10=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:29AM +0300, Svyatoslav Ryhel wrote:
> > The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
> > used only in lm3533_als_setup. Incorporate their code into
> > lm3533_als_setup directly to simplify driver readability.
>
> Use func() when referring to a function in the commit message.
>

I must have missed, thanks.

> ...
>
> >  static int lm3533_als_setup(struct lm3533_als *als,
> >                           const struct lm3533_als_platform_data *pdata)
> >  {
> > +     struct device *dev =3D &als->pdev->dev;
> >       int ret;
> >
> > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > +     ret =3D regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
> > +                              LM3533_ALS_INPUT_MODE_MASK, pdata->pwm_m=
ode);
> >       if (ret)
> > -             return ret;
> > +             return dev_err_probe(dev, ret, "failed to set input mode =
%d\n",
> > +                                  pdata->pwm_mode);
> >
> >       /* ALS input is always high impedance in PWM-mode. */
> >       if (!pdata->pwm_mode) {
> > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> > +             if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> > +                 pdata->r_select > LM3533_ALS_RESISTOR_MAX)
> > +                     return dev_err_probe(dev, -EINVAL,
> > +                                          "invalid resistor value\n");
> > +
> > +             ret =3D regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR=
_SELECT,
> > +                                pdata->r_select);
> >               if (ret)
> > -                     return ret;
> > +                     return dev_err_probe(dev, ret, "failed to set res=
istor\n");
> >       }
> >
> >       return 0;
>
> Wondering if it would be better to
>
>         /* Bail out when in PWM-mode */
>         if (pdata->pwm_mode)
>                 return 0;
>
>         /* ALS input is always high impedance in PWM-mode. */
>         ...
>
> as the above changes almost every line in that conditional.
>

This is a decent idea, thank you!

> --
> With Best Regards,
> Andy Shevchenko
>
>
