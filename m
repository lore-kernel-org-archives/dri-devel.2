Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57666CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A3010E9D0;
	Wed, 10 Jun 2026 14:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RmtN/acu";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1178010E9D0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:32:32 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30749947917so2882205eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781101951; cv=none;
 d=google.com; s=arc-20240605;
 b=kDzZXu2jhO8UuMIUfa1G2u+b3l2hUWimxIGgFlWA4yYesMQ5jeXyfOak8bhGfY3ug7
 VtKiYHoqMysDSYa6xSvfzjHGIMzhgKWVJtfnF+AQ4UO7Q4hlnGrAEKe2Xpwxh4qg1dE/
 dDCBMJYSxog9C3tvHF0zS8ETiwcJZJaotS7e8OSgYzGQXuKowcmUaTwDsf/O7H2Uja/u
 by043oqU0/Ocsgt1WWNidsS8u5RB46SqOcNjDwPeDkFlfnfAaHN+WXyD0ovc/qQqBnIY
 zV2GqstyCCHNzcvHXY1vyqhH75PpcIgZDytKT82Pua1oh8BhQ10HfbdwesWgZe6bReUK
 038A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oYlaQ1NUVVCcD2TPrqOfDsKTXd5iB9hu+Glwj3KNaZ4=;
 fh=K7Wf1tp9OqZUbqRS/RKlfLoOpLb/gPsxjLjy3PAO7yU=;
 b=CMh8K4l/A6J/dek+akUO2zMgNjhybhY2Ua5Jl+2awBrW7cn6JphK0z0YgG2PNnz5ij
 ZDapWNUB8j+EziZbrh2sRZ21rLKWDTkMS0La8BgC0byP+Bl9bLsC0i0grXSNXSNLyJTr
 LF1W94SDVCbrxVGI45FycNzlX9AkVFtNArcK12avWEL1mPk6hGYru1eL3TVXJkaQVtkh
 ltH265M+hljb5AitbQuGuai0YFuNhVKB/WWFTr+UsQXYBYUbo/8bxd97fjBEHNAGlXyN
 di6ptv495Q/XvqAfl6KwJab9wAIvtEwsWL4i8ehjqNx6+k3WgSkIHGicpwB87fmoDupd
 HZAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781101951; x=1781706751; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYlaQ1NUVVCcD2TPrqOfDsKTXd5iB9hu+Glwj3KNaZ4=;
 b=RmtN/acuoUl3Fo91tOhQ7kd04Zb2PRXAl9fr7A4ZS9A64xMkmVtwxbMGchZU+PsWEF
 lVxgOUKn0d1JgpT41cRtl62g1fELlh5g6jSOU1/m6BoI5TPbQQovdFc7R+1kkuGQOqHi
 vHmMB5z4e0sGvrPB4XdpdKgMzmCpNw6zhX+R5GAsU0Dv0ion0GyDvAa+SdtNFSBzEJJp
 0tAVF8Zyp99f4HkM8mWpaB73RKoSj6Kdzx0shNot8GkUs5nWxYvz9m5MJbMWxLN7SeXX
 MYg8/zDUx8zSY1r+NYHkEvkobqCh9Z8/4dT421y4IbnxYkI088ltYRb4SgYf/bJtDHaI
 3v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781101951; x=1781706751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oYlaQ1NUVVCcD2TPrqOfDsKTXd5iB9hu+Glwj3KNaZ4=;
 b=raLQkC74SDvzrI2YRPJA0tpPIAFnBwXav+fNGokHPoMwbGkTzaVyXVVoIbujCiHj/w
 8ImuhuHHIkpAqOU0ewvkRJwgBPNDKFd5FBQJzkel8DOxBg0ZrGy0TYZRyCnTruJdie9G
 mZrRfwXEOnxwv3liNEXQanqBzBHeJngRhhZmqIojp2O4cD/GLupc08LUu7UpmB/XsPjQ
 GlzPGZ4SkrXVLsfemPxIOq13u6Mbe0qA8IM0/BFr4HFQY7YkQKUcvQcb7nAoInCZQb+N
 OQZUSp+1EpYHRjqzu8wF1fJZ3Ovovkpzf9ZPdd3P9eEByIpKXzXguoDuN9wd5eeECPXB
 3YbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+w0ghMs6RxTl40zeqV/WbmQcQRCfzdMzoXDrnQhlVQA81FS4A1UXtj+tLUKbI96q9IUe/Yg7tqxD4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+jRvpK/wJyVwsrKCrUnMnJr3zl+1dPSJaYCOup7Q40HofOu8V
 IJSrOjsZJ4EEEtwp/rZtLKr6JAc4jkKBbYtoKbnG1/4phElMvVyUwQfVbNHc1BveKo5R8pVOKPW
 Rq3CE1Z+ZESx+pSQsJlnKmgCdLQuxId8=
X-Gm-Gg: Acq92OEsRkx1tOsYZA9zBdl05lzXsthlKc/Qne9MVKAowZbuQExn29/FCH5brYqTQ/Z
 yrM6sVouAPaSuTB5ZreS6lERqhdj5SqZhBjNfMwbyTjALrrPMq2O5L+OreXelY9KXjkgFxQjj4c
 oMKK8R+qgVkRp8hdQKy6G0qUsZhgR5LJcuteu5KkO8/G0l7ESwMw+ijLundKuMA0QTslPWKoLko
 LgqVif9++xE6nAsFDk6PZbiDrhJPXkCGDC0mRattjW5qM4Nf1DApM0m1GX4y9Nd7RVIiAkpzYVf
 sw0MjxHCMdXA4xE8SLg=
X-Received: by 2002:a05:7300:7304:b0:2be:2cfe:68b7 with SMTP id
 5a478bee46e88-3077b3c7767mr18495535eec.11.1781101951047; Wed, 10 Jun 2026
 07:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-3-clamor95@gmail.com>
 <aiPDzdKuccdLIvlF@ashevche-desk.local>
 <CAPVz0n2rdgw8Xr3uxVdQGwrHTNFqK4SKQDFU2FEB8LzLwPhQ_A@mail.gmail.com>
 <aihjVZ9xvM2BRFu4@ashevche-desk.local>
In-Reply-To: <aihjVZ9xvM2BRFu4@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:32:19 +0300
X-Gm-Features: AVVi8CeI8hlh1GbQ3AYGIMwG28HB2xx8su6lqiYAmfvLYDOtgithK37JF5bkrak
Message-ID: <CAPVz0n1fHWCpHN93v-dKfzGYhvB-dC1E3JgQmXpvfr6bGNLqcA@mail.gmail.com>
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

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:02=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 10:22:43AM +0300, Svyatoslav Ryhel wrote:
> > =D1=81=D0=B1, 6 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 0=
9:53 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > On Sat, Jun 06, 2026 at 07:57:26AM +0300, Svyatoslav Ryhel wrote:
>
> ...
>
> > > > +     ret =3D regmap_assign_bits(als->lm3533->regmap, LM3533_REG_AL=
S_ZONE_INFO,
> > > > +                              LM3533_ALS_INT_ENABLE_MASK, enable);
> > >
> > > In cases like this perhaps leaving mask would be fine and together wi=
th
> >
> > I prefer to remove intermediate variables it the helper allows to
> > directly pass needed value.
> >
> > >         struct regmap *map =3D als->lm3533->regmap;
> >
> > next patch drops lm3533 so there will be als->regmap which IMHO is
> > more logical instead of passing entire lm3533 to child devices.
>
> Still it's longer than map. A local variable may help with making lines
> shorter.
>

Introducing and assigning a local variable for a single use regmap
operation seems excessive especially since next patch removes operator
chaining leaving only als->regmap.

> > > this be nice one-liner:
> > >
> > >         ret =3D regmap_assign_bits(map, LM3533_REG_ALS_ZONE_INFO, mas=
k, enable);
> > >
> > > >       if (ret) {
> > > >               dev_err(&indio_dev->dev, "failed to set int mode %d\n=
",
> > > >                                                               enabl=
e);
> > >
> > > In many cases it won't increase LoC count.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
