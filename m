Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45801C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AEAC10E50A;
	Tue, 18 Aug 2026 18:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kBjeSahK";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C134410E06C
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 18:58:49 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-4a46a53abc9so192354b6e.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 11:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787079529; cv=none;
 d=google.com; s=arc-20260327;
 b=repINTytOnCoFdVQnqQtCaZERmv7uF/4Uw0Hz/F0/onkTwVXVywv2/4FzwN+TJbNGB
 Q8dhonu8G/oDqiULYGSZAZ0EBPOARF4SmHkE4fBqI2hStK4Oy5sQwxQPa3/Mh87JyKDn
 CcAvWlHkS0vAzVa65Nvsfyx9Nkmd/K77h2tgs8UhL0iMb+me40OT2ungGEH0JHhEFi7N
 sck5C3jKgQM7D1NAccZ06QbXMliH0y4aP+lC1sd8YWfpzmPyn0cga4xcHbT2hx+f0XCP
 HS3UKKG0uy9qPCTVPXam6H6xuZnVWWO58f/1uguDBQR0eb1CMt9XqF5MokPVVg3CQ+yR
 lPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9BSkI8G8ihTCxIT7mAPP/NBqIKcGAH08sndQ9lGa/eA=;
 fh=R16lfjKzB4qmCMkYjPBvUW2WsbawCLqQ3MVuZT5cMd4=;
 b=LQsN8R4bmD38j/nUae9/308Xin2BV6Az3h36mgh/iw8rs0F7r16xgIveoF4GJypGsa
 7/u7BlvbhAMQV0oGM0DR6TEIBMgM5E6dN/47vsFIcyfIsLOxJdHxoEeeIIJsK6IEDNza
 +1kYltlch9ZUTlW/TQ1eTwD9AOjFWJxnnGHRk2YDQeW5uKhDomk3zk/S7OlzHRSGItrp
 IO0wuydek852pRUjWpTC7rFwqK20m0otiEqSLKoLVElzC7zeDGBMOHk4k7aEMaA2GYdJ
 ViBqJ2m03F8QaiQp52zW2Cw5fA9cNTQV2bD4eVyZwIVF6tO0Ej5pistvONDkAAkz2iuh
 juqg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787079529; x=1787684329; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9BSkI8G8ihTCxIT7mAPP/NBqIKcGAH08sndQ9lGa/eA=;
 b=kBjeSahKxrvLAjXJEDb9JMv5HcnxJjqvWrGJ5F00tM58O84Z2lfrPSLWXP/JZthzzt
 i8U966Z0vtMo+99Bfhtg3hE0R9wZH4nqYxNq7p2cjl56G89t77+7RzYZS9GPnC2NRAmw
 2mAs3n4VeLUuIOGScMLOklSVOOO3RkBFiqWq/0KXNGb5+czyBC6ELHTz/1qUB76Ycnip
 B6I14jq4gmCvBGwsCCK/KTicLbPUsjh+eyR/9AAd8qK/iSD9ySD4DD+JQrgekhnu9PDO
 kgpF3Ej2FfJ67kCeAC+/uRdH3TVcvWdXZKvDlCc/zLnbw9E5ldpykEUqYdKHpIVAfh5a
 sB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787079529; x=1787684329;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9BSkI8G8ihTCxIT7mAPP/NBqIKcGAH08sndQ9lGa/eA=;
 b=JnN1qw8i8Oq3L6rrHD7aDyDMLmAp/q5UvtrRpjXot6nkwsQCKmr4xDm8QaN9sgnyZP
 jk3YCtrnTkb3v5zD0MRWLTWNaSFLwgUb5Jgox7Jd1i40n+X0too09JNI/3CXiFg3zIZe
 +eRpkDRWiU/BgrMnc7reecEPRoTHGVFMI9bdJFHNAQxFESEPKCQV+we9VDcnLGG/D+mY
 z3DbpeueJVqbWSyshwlJy5s07BbNnvyZf4KoM+9z7x5WJKYIvlCK+YdC1bQ5cU8Di78w
 pGnSJ4SlwPRz9FN2ZEqSXnyecRXtn1p1EFypopSn2YKjEL8m2/KOUsB0RCPTTeT9Se8U
 /tnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaU/iRuypS1kCQevcBGEu+LkCZcwMeyLU/Qq3XyCOxWvZ7fUc6nuqoxvE/7cdnT4Qx7MoC6oOQFfM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDCzaX/ASGtp6aTqFJQkpDQDinY3f9G4B2NG6ESi/uQOnG1Ovo
 hkyn3d5fAwTorrA9vot+xOWJMtl4PZXCQsk9XM4c5UPkLzWRnx8e0fStnhy9UhTV3wjkzmbmYZz
 oWE1TEbff5C8Mu/pfjh462nksuXjvu4c=
X-Gm-Gg: AR+sD12I86qeSoV7ouEck1bRn+T/dzayfa520getgnjSfFvuBltEgUXT5EDXctrCUnt
 Zv9lGkqjZu4bVZuYLDJmRUVtU0MBcp2YSmWGnZAkkAHEOUISGRKra7MmhhPEQLBJezo59E5b1Ap
 2K8i8dkH/+6lF1OTC10Y++/7SgNF6DfKEvYlgw4bctYbgiM+z82R6kq02FDOMAnZIMBOHNdOv8i
 Uc4VaMdviuhPwuI1/Ki4dKa/xNT+XENZp0NCuwsOHBW0LxkRZ8h5IfSClSKGH5xw0e7Bt1dJiUr
 f5lOyWoEKdtb6rkKfxNj0lYcn6rzXVDua2XBawBrCH/JjvFBubUJru3zKrmcJugQ16obryzSk/Z
 rPRM=
X-Received: by 2002:a05:6808:1245:b0:4a3:26b5:7c3a with SMTP id
 5614622812f47-4b241cf770dmr26917515b6e.15.1787079528776; Tue, 18 Aug 2026
 11:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
 <20260818080626.30430-3-amit.barzilai22@gmail.com>
 <aoQZqnbqoiOw6MKt@ashevche-desk.local>
In-Reply-To: <aoQZqnbqoiOw6MKt@ashevche-desk.local>
From: Amit Barzilai <amit.barzilai22@gmail.com>
Date: Tue, 18 Aug 2026 21:58:37 +0300
X-Gm-Features: AcwNN1X07bZnaFjODTfP2-I0pIQ46TZIiUc18MtLrsRAuThX19xt2MqlCsToMtw
Message-ID: <CAOEgbEpLGAiPRTvyogFdDYXdVrMjogFv=R4FFGwnQ4RpCvHCeA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] drm/ssd130x: Change SSD133X color format to RGB565
 from RGB332
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 18, 2026 at 11:37=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > +     /*
> > +      * Horizontal address increment, normal SA,SB,SC (e.g. RGB) sub-p=
ixel
> > +      * order, COM split odd even and 65k (RGB565) color depth.
> > +      */
> > +     u8 remap =3D SSD133X_SET_REMAP_COM_SPLIT |
> > +                FIELD_PREP(SSD133X_SET_REMAP_COLOR_DEPTH_MASK, SSD133X=
_COLOR_DEPTH_65K);
> >       const u8 cmds[] =3D {
> >               2, SSD133X_SET_MASTER_CURRENT, 0x06,
> >               3, SSD133X_SET_COL_RANGE, 0x00, ssd130x->width - 1,
> >               3, SSD133X_SET_ROW_RANGE, 0x00, ssd130x->height - 1,
> > -             /*
> > -              * Horizontal Address Increment
> > -              * Normal order SA,SB,SC (e.g. RGB)
> > -              * COM Split Odd Even
> > -              * 256 color format
> > -              */
> > -             2, SSD13XX_SET_SEG_REMAP, 0x20,
> > +             2, SSD13XX_SET_SEG_REMAP, remap,

Fair point, there is no downside to marking a variable that shouldn't chang=
e as
const. I'll change it in v5.

Thanks for the speedy reviews.
--
Thanks,
Amit
