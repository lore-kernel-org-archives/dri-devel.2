Received: from smtp.lore.kernel.org (ip-10-30-226-214.us-west-2.compute.internal [10.30.226.214])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D360705CA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qQh/kKro
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE4ACCF2E6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D89A410E8EE;
	Mon, 19 Oct 2026 14:55:21 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C343010E8B5
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:55:15 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3550c917fd3so2622760eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:55:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792421715; cv=none;
 d=google.com; s=arc-20260327;
 b=bE2IfdN0CFiE6pKILfTpXdYvmzQD2ifboqbIvl1wFdW1tznhTbfy+42OrARyz6jTdG
 23/H7dzXxcW8xgUr4HJ3b9DNcpanXRi6/2T8/IicvCE9iRY5ap8WuFXJidNRChmnTR5Y
 1QHE4RCB1KJfw9VSH8dEGHszx64XozFuzmJXKB6K34r9EZZysv5h+OgiiK9LuchMfReW
 Rgcn3CcF3c9CafasC1wP5xzY34IEZMHXaBmXXmx8Q8XG8Py5IWCEuNFC0yKAg07C64IV
 82VCuKjgs1+OEVJG/Lv05bC7kZNwGUKWNhmWr9vLglxDPfcFGN73Q8HbGUN71j4uzwSQ
 OnQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1JVa4anZLJXOQzT6DdFCFiAtwNU6Km/IK3O7kS1gknE=;
 fh=KVpCXgdAb0PS47rcTBnRaTo21rZQ8hOl/NFeucYNBEs=;
 b=oQGYgi2phebRE/HFL4e0plk0pe7aI5kv6bMflMFKQNjeP1Od/8+8V8QoEDVsuBN1vi
 ymsdDHH8m9Naqx9f5HihzxaraVQ+uVmZKWIyGzqOHoqz9rPhBBQKfUtuKhWcdMkIJgFS
 g+1XSbOZjbGtpyekS5/ivEIuDgxQaFcso8AT2rl9bM3EiZgG7RVMtKqFu8CbceNwQcgX
 k5Xz3ESZYkcY7JmwxIJgHK7x+xUbslWSyJj3IqQCLdj83HpQO/GomL3i89Lzkvq1JjHx
 mXkgp2/WWAqMPvv9gMC+o26hfKU4brVPlzQmqLpQ9UyuuRUmMv9RSCDFet91Zl9InYlg
 sX4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792421715; x=1793026515; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1JVa4anZLJXOQzT6DdFCFiAtwNU6Km/IK3O7kS1gknE=;
 b=qQh/kKrol56Tf/A6v+1u5W5FWVGEw088AYEZ2R3yzfHhTr1Aoy2oIekvjLyMGTzS2l
 uZ/ZbOec0Et9P6RP+pl8raDfvXVWs6I60uaYVbT8oN3uQ3tjiq/9J1iuZK3MalvnYPWx
 zMVPFPDvPa/rnfL8OCoX5MSDx9PYftdDPM5ySkXkHYqZgWPo0GD3AZQynKWN/rynWgtk
 FHrEeqN1KB86vPSt87tcHMGudtx/s4DCkVtYDNRrc5oScbtldze9aWqv2yVSM8fgzVYC
 NprBJd7pSm9HuI3CEWvChNyS36/4AwZ+zeypyf1i9n/jZf1Up1v07WHQgQCY7mQw7c1N
 LWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792421715; x=1793026515;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1JVa4anZLJXOQzT6DdFCFiAtwNU6Km/IK3O7kS1gknE=;
 b=1zEj58K3++TMSSLnNonP+oDTvIVCuZdpykBRzVq1RlCDggl0AnNzfE2YWhBWYljsB+
 g3cdpHQ/crDYuohXf6EhXe4KO8mD1sxLedDk0xQN/evZSNYdw6os2sOAbsmsN3ef6/IF
 1uZR4woP+zRPkRyUJq6JGXV1YAoepfqqppLuqLy0qzAsiUg/Fu2Zn+IUiBzcYKaay43s
 8jeOlsOrQK+qm0vGrx3qjxQFhXiMsKGed7nFutxAoxfEZdac1Tqu3LJuvILDAHoyQJHW
 aYa06MnxkHpbSyWMSW9ZHu75aI/nSSKWQoS2Z5kfACxi9s/8SSidmrEV0n1FF2Lc+Nix
 0NNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqLGB5kuz+c8HARRxWwZVtyvRM5tdU8f93N2YrampHU8e3S/26Adxlyu1nF2v+CIn2PC6u/P4hCAk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIgD7yVCbNYkL6KOWgnXT5n1haPDhEX9NF+G2yhzEgDDHlUJxjO
 MonzLxhrAPyFTPapyEw0LrszHZp6amHYfK9st5GjnTB5shjGOZGuNwMDhnSFh4FCVv6xz+Zmbb+
 bh/FbU3MRkhTqiSvVapcfZ9EBwcB0jFI=
X-Gm-Gg: AYBFou3gJIs6F0/yK5A+WZeNFbxqaf5kLLvbf5cX9OtIw/MHRXZNNrJQWnE0yGr1sKs
 E+fkdsxcWVivNGRSdjxbTpqSke2qkxwYkvyR1e9Fq6wD74W/TaGuCLoWrC5ZpvgGs1/71kROHsv
 I7YaVP4WwzL3A5tWXFn4cAF7TIoYDnwEM+/3v4ujoGGOJ155tCvGgefsWYPwHyoEYw1Rto8jCY3
 9gINdnt5DG1Tlp0V04kwvtgIbmwnzWkxAZOF6u95ttw6903gljgMDtViXK0igCZ9zUSQQAHp5+X
 2VXJwS97uVpiyvxKGg2QOMyGh7hqSWs5o7I11dUSBmICy8JbMCQBkHDkq1rd5EL2Map5VRCj2VJ
 43hNrFisZAy3I
X-Received: by 2002:a05:693c:87ca:b0:35b:c1d2:eab9 with SMTP id
 5a478bee46e88-361a2e3d3abmr10553103eec.39.1792421714834; Mon, 19 Oct 2026
 07:55:14 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-3-clamor95@gmail.com>
 <179198332384.839288.13126529382772558553@kernel.org>
In-Reply-To: <179198332384.839288.13126529382772558553@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 19 Oct 2026 17:55:03 +0300
X-Gm-Features: AclHuK-mou-LoaLS3qywfc3GD7SbgOiLXnwqTE0Jl9qjYTR1SQVKYSakF-bo474
Message-ID: <CAPVz0n14BhmK4P-tqnt6AMrAh=W-HPoBbP0ztdOrRd_JocRSqQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mfd: aat2870: Derive brightness steps from max
 current
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
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 19 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:4=
4 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Wrong subject line.
>

What do you mean by "Wrong subject line"? Specify.

> Please review, explain or fix the Sashiko review(s).
> If this is a set, this request includes the other patches too.
>
> > The AAT2870 allows only 32 steps of brightness, with this amount define=
d
> > by the maximum supported current. Remove the need for max_brightness by
> > calculating the allowed number of steps from the maximum current.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/video/backlight/aat2870_bl.c | 30 ++++++++++------------------
> >  1 file changed, 10 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backl=
ight/aat2870_bl.c
> > index 8b790df1e842b..eb686e315921d 100644
> > --- a/drivers/video/backlight/aat2870_bl.c
> > +++ b/drivers/video/backlight/aat2870_bl.c
> > @@ -24,18 +24,6 @@ struct aat2870_bl_driver_data {
> >       int brightness; /* current brightness */
> >  };
> >
> > -static inline int aat2870_brightness(struct aat2870_bl_driver_data *aa=
t2870_bl,
> > -                                  int brightness)
> > -{
> > -     struct backlight_device *bd =3D aat2870_bl->bd;
> > -     int val;
> > -
> > -     val =3D brightness * (aat2870_bl->max_current - 1);
> > -     val /=3D bd->props.max_brightness;
> > -
> > -     return val;
> > -}
> > -
> >  static inline int aat2870_bl_enable(struct aat2870_bl_driver_data *aat=
2870_bl)
> >  {
> >       struct aat2870_data *aat2870
> > @@ -69,10 +57,11 @@ static int aat2870_bl_update_status(struct backligh=
t_device *bd)
> >       dev_dbg(&bd->dev, "brightness=3D%d, power=3D%d, state=3D%d\n",
> >                bd->props.brightness, bd->props.power, bd->props.state);
> >
> > -     ret =3D aat2870->write(aat2870, AAT2870_BLM,
> > -                          (u8)aat2870_brightness(aat2870_bl, brightnes=
s));
> > -     if (ret < 0)
> > -             return ret;
> > +     if (brightness) {
> > +             ret =3D aat2870->write(aat2870, AAT2870_BLM, (u8)brightne=
ss - 1);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> >
> >       if (brightness =3D=3D 0) {
> >               ret =3D aat2870_bl_disable(aat2870_bl);
> > @@ -150,10 +139,11 @@ static int aat2870_bl_probe(struct platform_devic=
e *pdev)
> >       else
> >               aat2870_bl->max_current =3D AAT2870_CURRENT_27_9;
> >
> > -     if (pdata->max_brightness > 0)
> > -             bd->props.max_brightness =3D pdata->max_brightness;
> > -     else
> > -             bd->props.max_brightness =3D 255;
> > +     /*
> > +      * The maximum number of brightness steps is determined by the ma=
x current.
> > +      * The aat2870_current enum maps directly to the allowed brightne=
ss steps.
> > +      */
> > +     bd->props.max_brightness =3D pdata->max_current;
>
> What happens if 'pdata->max_current' is 0?  Above, we fall back to
> AAT2870_CURRENT_27_9 when assigning 'aat2870_bl->max_current'.  Shouldn't=
 this
> use 'aat2870_bl->max_current' instead, and if 'aat2870_bl->max_current' i=
s no
> longer used anywhere else, should it be dropped from 'aat2870_bl_driver_d=
ata'?
>

Resolved in v4

https://lore.kernel.org/lkml/20261019100930.110954-1-clamor95@gmail.com/

> >
> >       aat2870_bl->brightness =3D 0;
> >       bd->props.power =3D BACKLIGHT_POWER_ON;
> > --
> > 2.53.0
> >
>
> --
> Lee Jones
