Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82C2CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FCF10E0F8;
	Fri, 26 Jun 2026 11:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Omj26g/w";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032F810F422
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:58:03 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49249707788so6237785e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 01:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782464282; cv=none;
 d=google.com; s=arc-20260327;
 b=bE5cKTfJBrLbBTRITl1fORnyqosmIRL7V5KOTebyrvnXeEjDcvBgfqpTLAhOiN6JTd
 erKngg0qT+AqCQPE6Vy4l+x8Bhihn5PEdt3i2btVKTUTjN2QGR0nTS+MQKDcimOM0mRj
 ORVBpygyuDFe0bw56OrHaKTKcxwfnv/c5lMAzVVVsXczAw9WhKCp/Ww7MwWaMhzJxJRb
 FmUoDBXDOcSavkaYtE+S6uF2lRPucPFZvNvNKGq9dcbzU5B7hjFoFZcD1Kf1FKIOSEjd
 xeY25LdeeC8ieofmGzzY93O+nN16SJXDatR1h6/rfHvZOkdWSWJt4+n+JxtNIyePOhs3
 Ga+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8mr5BrX28M83c3h69JR5BGflOmg3dbIBV6JMrnAWs44=;
 fh=B5NR2uOMOExKQ/cAU8g9aabSNWHs/7+TDpS9dh2VgNg=;
 b=T8hjybteGI3wjbUiV9l5MJczne2p0sfHniB/JAODdCDYEgtF0znLgEwRn6ONfYKniY
 5UNxud8GjYGzmEFmLTgUD4EP1ENus6ju809yOJmyqocrlN3G4e0lHd8rekymNXIhbvxq
 6i/XRHuuh+aLKlimiewxdmrgotT1k5kWreuOXBH/QVLq+BFY96hd5w1JjL+pvaOEm46k
 N7OuJMHwNcoLBpBNz6zBr45a/L7k59UkMJQClR9ywoVbp8yilGJmfy+OFvvHAK9TICcx
 B6mgY5sLhY9iLJIpPXmuPSt5QRK54utdD+HgRi8wgVadpuOQEWqRWSPGLfX3wGFJ37bb
 SutQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782464282; x=1783069082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mr5BrX28M83c3h69JR5BGflOmg3dbIBV6JMrnAWs44=;
 b=Omj26g/w6W5AebhLOK3u48EgzSShyLyGt+pwrvhahv2gTLgAGeiNESpwborvq6mIvJ
 dsz46IGN02f5LZ0sHqciUvy1TrwaG4Twk9jSEamjdTM/Nc46OPuBFCVif9X1bfucaWPt
 iW3L9kyXdTqGfbLK0CITrcmIXetZ3nyojjHfb7fNbHpimtYA96/XWDnvSogO5dYO6nRr
 6s+uzGT0AFP2eLNhDxi4UibDiSLkQe9XKkBG8s4M4nbCcAQyamaMUW5v6Qd03W7ba/xm
 ehoy5kTT/7E9r2sa7eC5wmY5V5O8ZkPYIT7OiQenELGxXjx2yJDQ1wUicS7AMZ6w1/4U
 z0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782464282; x=1783069082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8mr5BrX28M83c3h69JR5BGflOmg3dbIBV6JMrnAWs44=;
 b=CP3wwm98zxNiJMmGun4m+8Y2vkEy3lk9HQ+vSeydy50RdaTEDElFzZ/7ARQ5IJN12c
 kGzMS04NfW/dAtpiOAeF05s2oDVrzGcKO5HFX0242/zZ4jgyvT2MkFFpdeTpZ188IIK9
 vxRmWe0xpbjP67bbGLJlDHEtuEy3gMYWAj1I0k5mwJeTYrjMETSIRmRfYhYe6zlHGmSI
 RZPNjhLoKpUR4r1USpZ+3qTQPgOE2iMgN3xYvlFGJJ+8VUdLZMb8wsbIctB5RHB0+RA5
 b4K2vSLhpI7eyMoR53FaQ2D6w4qES6Ai1ezlUWCNxA9qEf4ArqEk7RwdMg54FXNLUv4i
 EGBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mBCWZ/Av1hV3L5y9pQNO4H1PE99pem6eKU/iw7oh/ztdv3W9vkgJh1s1m+A1+iXZIa7OzsyDVZnM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUXNwrdKyEzG94Ta5mFo3IW3WkAxlmEEjzSr2zgDwjK320v4go
 krKMgXAsEuf6swLnUpMIEC5/WJFDKM6pOM+RsBlOA6rO4ckSgefbLKYls1ewcpJRg+Np/grn/xw
 lWGDilNA0h9btMrG01Urn/SVc5XDalQA=
X-Gm-Gg: AfdE7clwiFuh+1uWkbxQ1ZmAiC20nam29a+4/2xLePTQfA+d57R/qqj3kys76J7SdWh
 rtLqsHQzjQd36jkttcvOGPvo8/YW0K9bzDCR9sfwdCaVtcSyGoZ8wvcLXyq53/QfOO1bzsa18JP
 xNvVJk/GICQW2eyWphrcPhMygFvHsvpLAtQlTiMxNW+TL9J1LzBIdcqI8S0Ueq3dP1JSaMfbhup
 sV7s9fxS2bf2leRhQVQJrShs8jDaFcrY839OEhC87CLKBMyBziVrF9h76I+hSc8lfY0Xlkk4w==
X-Received: by 2002:a05:600c:8115:b0:492:6df7:942a with SMTP id
 5b1f17b1804b1-4926df7967dmr10375035e9.11.1782464282163; Fri, 26 Jun 2026
 01:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260624073804.4391-1-joyetamdk@gmail.com>
 <ajvAGK-0kCfkThcs@ashevche-desk.local>
In-Reply-To: <ajvAGK-0kCfkThcs@ashevche-desk.local>
From: Joyeta Modak <joyetamdk@gmail.com>
Date: Fri, 26 Jun 2026 14:27:25 +0530
X-Gm-Features: AVVi8CewQ_sfNVDDCLAMxVIytH13-ftRD2ntaqkp8BztMQTvv7FNCKdpjmypRE4
Message-ID: <CAN3JnUCem3Mw17e5D9b-aX58_ZaAvC6GZ-sBPEQfTTTP=o-WHA@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: use ARRAY_SIZE() in NUMARGS macro
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 26 Jun 2026 11:59:44 +0000
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

Thank you for the feedback and the question.

I checked every write_reg() across all fbtft drivers and found that
the largest number of arguments is 129 in write_reg(par,
MIPI_DCS_WRITE_LUT,...)
As COUNT_ARGS() in args.h only supports up to 15, it is not a safe fit here=
.

However, the kernel test robot reported a problem with my
implementation as the __must_be_array() check in ARRAY_SIZE() requires
the array to be a compile time constant expression and thus breaks the
call at several places.(example par->bgr)

I tried to reproduce this locally on my system using both GCC and
Clang with ARCH=3Dum on x86_64 but could not reproduce the build
failure.

Since the original sizeof() based approach had no such errors flagged,
I am thinking of dropping the ARRAY_SIZE() approach.

Any other feedback is appreciated. Thanks again.

On Wed, Jun 24, 2026 at 5:01=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Jun 24, 2026 at 01:08:04PM +0530, Joyeta Modak wrote:
> > NUMARGS() computes the number of arguments by dividing the size of a
> > temporary int array by sizeof(int). Using the standard ARRAY_SIZE()
> > macro is the correct way to count array elements in the kernel, and
> > ARRAY_SIZE() also provides a __must_be_array() compile time check. Ther=
e
> > are no functional changes.
>
> ...
>
> > -#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
> > +#define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
> >
> >  #define write_reg(par, ...)                                           =
 \
> >       ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_A=
RGS__))
>
> What is the maximum parameters .write_register() takes in practice in the
> fbtft drivers? If it's less than or equal to 15, we may use args.h instea=
d.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Regards,
Joyeta Modak
