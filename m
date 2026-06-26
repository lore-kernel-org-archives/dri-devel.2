Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CAEC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F6410F5A5;
	Fri, 26 Jun 2026 13:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eWBBpanG";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C45DA10F5A5
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:41:33 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-492329c5514so4252185e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782481292; x=1783086092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inH5gHgw2GQJ8Jf/udrV2wKYoIHtRnRBi3E4+pGgxJ8=;
 b=eWBBpanGPebMtm4z+gb4Kp0vT8rUldKzyfnXLIuKuXMjSUAOlU0PlKhByT6PB4v3yG
 MCkQ5D0/gwZv+Wm4l+8b9Iv3HZkHMdaYehV4nFstHbVASR2E5Dgu1v0WGxa7k3R9bARR
 2IlIrdUlfLe732LGJUdiFNM6+xxScGnFAK3kv3rUQJms9A9D6lA9nPcv1+vsatl7D90v
 bPTpqfITp92YupmhGYTSU770iY4yuKmjpFZHGUzqGvGefzXFUpReh+m9TYQW6FUmM61q
 6zv8YtgRJEsRcAddghkRcLW51zwgv8eBPF5WMRNGMUlobMO0W2Ut9hqh0ecLCX9p3uL0
 RIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782481292; x=1783086092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=inH5gHgw2GQJ8Jf/udrV2wKYoIHtRnRBi3E4+pGgxJ8=;
 b=jb1aamVMQwc4kuuxrHkx/Xpl6MVLH6FVeCilKHlrIIlnclWsBizt/36z5+A4V8Th0Y
 zo2uP6/gZAWRFbx9fNY4XjHD2NXE5K9RssTuF1hlwxQVckv0OFJqoulpjzipq1Iq3W8r
 /j6lV+tQ5G1fxHLq84T/PfUA2FgD6LkvTcu22DjjMr+XL/etPqBPVZq0skjkclNbqB+Z
 d3wiCELLgedZqdd0Vd/Hh/3IihPEZ4CI7TqmdFyxfaUhfNd8k56igE9q0egklzWxsZuG
 qv37qM5O4P75QrIxiejh24U2gbyb4iSUqzBZR8u26vFY9xbq+xgHyKGw78TUCcViPH5m
 wyCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9E4SdwzfaHvAClFnuo2yNCinVLU3qkM7+K4qSRdqABA1vIV5fKRJNzdQ1EGPO7TfUwRjrhaIkOonI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgjcR1VI4rEJuSbcJD9vtjVYaRux9J67AsRccnJ80Q31In1hLK
 lm4wXM8+208OE63/l8n0yo74evfoPYalzNOpAagjgwC/n8bo1tRofHQmV/E+7znZ
X-Gm-Gg: AfdE7ckElcKMpa5CsQd+6qctFM4UcTtQnqYPx2+Cp48FSbzB3babz7NnohI6PuCA5T3
 TfU1OUBy8IPHjFDJw6IZm3zdmkMM0B9jgsfp/uAIr9zObCetJfx6lNi0j+8QyMZZvc8YYiw6ed0
 K/vq1FRswUWu/jYU9t/s5Z+7xrdO+VuzM9wdCZM5g7+WXEA+1CqvD05mnXYNCJOLNdO/vDIOI+z
 6vYScCJFf6p8x//tTS1UzVeL+EBa4zWT15aHVWe9riweyqjTqDTbIg+soJ5/eOsuOeQZESv1Bgr
 B7XdWZOCOaVTC07yz3sL/6C/GNldVkpNKdbxx1sNCrTNfqMliE4/qF/tqUbgm/iab7s+bTWUKuU
 PdCVo3ltKzexq+kQuKtHqwjkHHaAbIOi4oKWNZNBnm0+VLQ/tRN8mLRY99sK/YrRG3blUGenSc6
 3Nv/voU/GuZmMY/rq0uD+cwZf2xfjGcYkagObeok+JE2ruY1R3fA==
X-Received: by 2002:a05:600c:8519:b0:492:4889:3d18 with SMTP id
 5b1f17b1804b1-4926641a911mr83146765e9.9.1782481291771; 
 Fri, 26 Jun 2026 06:41:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268f7670bsm79114415e9.0.2026.06.26.06.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 06:41:31 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:41:30 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Joyeta Modak <joyetamdk@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, andy@kernel.org,
 gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: use ARRAY_SIZE() in NUMARGS macro
Message-ID: <20260626144130.6e3c924e@pumpkin>
In-Reply-To: <CAN3JnUCem3Mw17e5D9b-aX58_ZaAvC6GZ-sBPEQfTTTP=o-WHA@mail.gmail.com>
References: <20260624073804.4391-1-joyetamdk@gmail.com>
 <ajvAGK-0kCfkThcs@ashevche-desk.local>
 <CAN3JnUCem3Mw17e5D9b-aX58_ZaAvC6GZ-sBPEQfTTTP=o-WHA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 26 Jun 2026 14:27:25 +0530
Joyeta Modak <joyetamdk@gmail.com> wrote:

> Thank you for the feedback and the question.
>=20
> I checked every write_reg() across all fbtft drivers and found that
> the largest number of arguments is 129 in write_reg(par,
> MIPI_DCS_WRITE_LUT,...)
> As COUNT_ARGS() in args.h only supports up to 15, it is not a safe fit he=
re.

That is also a pretty horrid way to write that message out.
The function call itself uses well over 512 bytes of stack.
Then there is all the code to push the arguments.

It really shouldn't be too hard to pass the address of a const u8[]
all the way through to the code that copies the data to the hardware.

I tried to follow the code earlier. The 'common functions' that pretty
much just call back through per-driver functions with names the 'write'
really don't make it easy.

	David

>=20
> However, the kernel test robot reported a problem with my
> implementation as the __must_be_array() check in ARRAY_SIZE() requires
> the array to be a compile time constant expression and thus breaks the
> call at several places.(example par->bgr)
>=20
> I tried to reproduce this locally on my system using both GCC and
> Clang with ARCH=3Dum on x86_64 but could not reproduce the build
> failure.
>=20
> Since the original sizeof() based approach had no such errors flagged,
> I am thinking of dropping the ARRAY_SIZE() approach.
>=20
> Any other feedback is appreciated. Thanks again.
>=20
> On Wed, Jun 24, 2026 at 5:01=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Wed, Jun 24, 2026 at 01:08:04PM +0530, Joyeta Modak wrote: =20
> > > NUMARGS() computes the number of arguments by dividing the size of a
> > > temporary int array by sizeof(int). Using the standard ARRAY_SIZE()
> > > macro is the correct way to count array elements in the kernel, and
> > > ARRAY_SIZE() also provides a __must_be_array() compile time check. Th=
ere
> > > are no functional changes. =20
> >
> > ...
> > =20
> > > -#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
> > > +#define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
> > >
> > >  #define write_reg(par, ...)                                         =
   \
> > >       ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA=
_ARGS__)) =20
> >
> > What is the maximum parameters .write_register() takes in practice in t=
he
> > fbtft drivers? If it's less than or equal to 15, we may use args.h inst=
ead.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> > =20
>=20
>=20

