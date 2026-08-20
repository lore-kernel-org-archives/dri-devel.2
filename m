Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13CEC5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E53410EF7A;
	Thu, 20 Aug 2026 09:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ELk7EzBT";
	dkim-atps=neutral
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C3E10EF7A
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:06:44 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-6b153aa3e7eso29026eaf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 02:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787216803; cv=none;
 d=google.com; s=arc-20260327;
 b=YvA47dT3wOUx9conpwi0rpCn+Srv++pOpXjWx7c8QnIXz/VIEJIwDRmhOMhdMWGtld
 dRqHVBO5p/Nx8d7iqnQ+3yjTf2hZ4G1FviHWZ1uavHRMS0c2B0kjl2iYON+9F0uwmnOn
 x1t/l9UpncYjpVU/ToCJcyXjheXlxK33oThrl66RNCjlg1N95WqQ305u2J8VlXsU++P4
 RNIhdhrbT7hiOXUg/tNg2lQtQP/pjIKMFU6JWllDQI0TVjtNJ5pXcQQkxRc9UvixRu5K
 M+Jz/Eex4ZWq1OxdCNpV/ABiehC8n7v4jLwlLxeOtaCM70o5jGZjUuTxo1Q6jbCDSMEz
 mn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jZGw343WQLjcdulSLn/rOVo1Vms9Oy4obDab4pTbfnI=;
 fh=gp3GFMsCJvdORTyINnby9+F/lk4F6E6sAqCD469991Y=;
 b=fo531THQ6o5HDsMLkJ8vjNvrrhDKh36adjxs2t/D+RXJenkux+AoSXG12Wp7W6s9dC
 meKqZA/6IlNv/enc4alPXO8+AIJIU64ZSo8y5XowQIS/y3LMSa7ogxwp26crZQz6gsC0
 4EkSCj94fCwk9FwZ6Awm2FQogU1RinzNKenoPYrwEKnaL1AJEOJIKwbtXV7KSdLYIajY
 t/lzq2l1kax/QcURCVztYEr5Gjwl9Uvs5Ke/xxfGIkEAX9yrv8c2oczmzrri3QTjvGX4
 U/QffsUeMoL39/r4tZDiHHD4a30ITcgiyTM12xx7Qv+JRhp5QDMCMp771XS9+5Vxg2c+
 x3vA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787216803; x=1787821603; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jZGw343WQLjcdulSLn/rOVo1Vms9Oy4obDab4pTbfnI=;
 b=ELk7EzBTgR2YtvsdmskMbN9tEq7XSk9lh91PAbYcG9iEmb7U6HsdtK+0ml1FklnHMT
 m/kDFHmePnR1Gh1PTAKKJw3RJZgxar8XgBBa/xp34eQqhGVExlGe9TY3g1X6Q+ZXLLJj
 skGb5nUphc2BMDbAIWgL20PTFm/ci2ZrEH5hH2lHC8zeYjjgflLnERQNnH3+RL28G6uB
 cAz13Q09wy6ExxFKdrOFHpUee7xhRDHlkCgjnBylOGCfKLhhjuaao9slJbdVBwA+OBAg
 roveZj0FBqq2QwXKBEzPvHMtONJVQGZ6Kud62GSE+bHINR9O4fmW14n+PPo2noeaHrw0
 sEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787216803; x=1787821603;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jZGw343WQLjcdulSLn/rOVo1Vms9Oy4obDab4pTbfnI=;
 b=EuA9Y827yfLQEJTgHetRmVFQasCkGIgks1HmKOVk1Tm0fQzGxCXnO14WfXEmGXN4Og
 sygCDE4FL65J4V35d1W9M5H2x+8Jyuy9Mq7xcL7yyc4aSXfKAS4VEklVOkku1SuIle+X
 t40ctvkcA5xgJg6gZ/H8Mqd+PwOHUUw41jD2UCLYNxX7bFwaotf+hVvKTvKBkZpPOqr0
 a5g1Ga/k8g19/ewjlC5VtojQvtmHxVZODalqlmJ9v8BDv3+zgElpeUFkuosldBxHZVsn
 idYBG1+WS37dhBAauqm5bgcgvK/eRuA+3O586Y85h84D3VSUwkbfR04VIFjxsDyRHv5n
 FmoA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roz6+LDkWHF2aw+GzRbAx5PE4zh+o+X+dqK1bthcUQ07ZCXEH7pIdTbZbg6v2lMSjJlELcvxF1nwRA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcqxTJCuvAuXGqXdltuEh2ZDWfUSRLVcvRcqtjFMCnkedOJVXe
 53LDGNL/tDAlFgAhbqj4p7Oz129ypXvzgnpNckZ6NsSMTL/SRPQ8nXh66Gps1teLJcPIHZVYgMI
 EX/JDDghppavux5g70EUgexTiR1blH4A=
X-Gm-Gg: AR+sD12PT1Tzwj/Y538XvHjS45e/ZOyUcH1QvWMHn/qoPjOHCWYIkiWatOHFhhbL0Tm
 PvsPBk2WYHfQu3JbXVeIwISmXOrnw14GilLd2xFe4kYTMaWgB0+XBwEpVNw5VH2kkpcrbZQsycp
 r12f8Fn4o4G6yIXDUKBa/434hh9vDGjn5nO4jdgtiuL4TVX2oHVcBIwwyG6+jovW0AgRl+qgfz6
 I1B/UUIPnx5g9VzvgHSbMmwCsrQGl8occIpx0jF/mKpktGcA4vDHt78meTuxOOdZnWkC2RCk6SZ
 0ZGVXj1Ht/k5PCtlXE7DEG8+sBxbZCXEKf86c4//28VWlC3fMhSStjsg8gbPDdEMNID2+lKlikr
 3UF1zuWwv9MpRNw==
X-Received: by 2002:a05:6820:150b:b0:6b0:fc2c:bb27 with SMTP id
 006d021491bc7-6b13c389a65mr9778866eaf.14.1787216803241; Thu, 20 Aug 2026
 02:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
 <20260818080626.30430-5-amit.barzilai22@gmail.com>
 <aoQalR40NMFSg8zS@ashevche-desk.local>
 <CAOEgbEoMOR+WS7TzY5+k6G464uUdp+rHJqvhY+6gRE8nCaT=gQ@mail.gmail.com>
In-Reply-To: <CAOEgbEoMOR+WS7TzY5+k6G464uUdp+rHJqvhY+6gRE8nCaT=gQ@mail.gmail.com>
From: Amit Barzilai <amit.barzilai22@gmail.com>
Date: Thu, 20 Aug 2026 12:06:32 +0300
X-Gm-Features: AcwNN1UjXypJJY9DHbyqP0x-8s0rVO6sgXjrFeaBERe_l4HTjNvbH6uDwpF5QZs
Message-ID: <CAOEgbEq7D4mkie=DUqrE-Q_bN49ekoCFiyB7ihPS5T=A=kCoVw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] drm/ssd130x: Replace positional ssd130x_spi_id[]
 initialization with C99
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

On Tue, Aug 18, 2026 at 10:25=E2=80=AFPM Amit Barzilai
<amit.barzilai22@gmail.com> wrote:
>
> On Tue, Aug 18, 2026 at 11:41=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>
> > >  static const struct spi_device_id ssd130x_spi_id[] =3D {
> > >       /* ssd130x family */
> > > +     { .name =3D "sh1106", .driver_data =3D SH1106_ID },
> >
> > Hmm... Is the comment correct for sh1106?
> >
> > >       /* ssd132x family */
> > >       /* ssd133x family */
> >
> > Overall, what do these comment bring us? Are those families have someth=
ing in
> > common? Because the driver data is unique for each device, so I assume =
it's not
> > that compatible inside even the same families.
> >
> > TL;DR: Perhaps simply drop those comments for once?
>
> Agreed, I'll remove the comments in v5.

Having looked closer, I'd rather keep the comments in v5.

The same grouping comments are used throughout ssd130x.c,
ssd130x-spi.c, ssd130x.h and ssd130x-i2c.c. Dropping them from
ssd130x_spi_id[] alone would leave the driver inconsistent, and
dropping them everywhere is a cleanup of its own rather than
something this series should carry.

The comment is correct for sh1106: ssd130x_variants[SH1106_ID] sets
.family_id =3D SSD130X_FAMILY.

And the families do mean something concrete here. family_id is what
indexes the plane, CRTC and encoder helper vtables and the backlight
ops.
