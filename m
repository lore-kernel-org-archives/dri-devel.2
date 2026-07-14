Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB9EC44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B0710ED90;
	Tue, 14 Jul 2026 14:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BbIJWPnP";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F0210ED81
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:33:23 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493e8d4f4dcso34011815e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784039602; x=1784644402; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yqr76+rJ8iwHayK7NjLGqhPMmOMQyjm2NesJQTgS2Xo=;
 b=BbIJWPnP9vCuzwkxQkKEuYhMbDQTiIizlVldn6YyqunhxFd/JItfTsxMjaV+YQ1f+C
 19RxEor9ZJY4nUq5ZBa0P+OWyXKv/3F5edK8VSTsHFut3nwNaoSc0cbQcIaXvZI/rUOx
 DumLFwCNhd22Im6ZiWoNdRYWA8nOkthZ1mEfLdyOVbrTLaP5I58brzLABbNgm440ZVRn
 rsNj9gTJKjEusQGwe/ALzumZg/8YyEhu4KH8RsstzH2Ape6td6gLxrw3kaSEO4pkt2OO
 KMu5aMRNwuVwPb5W5BdgsSB8a3uPc4iZix1AMy1lK2QeN9jMOMEWGiqw3onvnBavXyJW
 9OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784039602; x=1784644402;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yqr76+rJ8iwHayK7NjLGqhPMmOMQyjm2NesJQTgS2Xo=;
 b=dtwIwZos7nrt3EFvWJFRAp4kykV6yyrSW+rBRRhVwrJlIswmKO0QUMB+g/PbhuICJQ
 066MdY0R8ferjIVfBJUzwrKary8dPH9IB3eQQ6jodoU4rAaILDINXfxybIIMbH8DpzWN
 QSZO55CqKbq9X3A4dpiU6O0xK15oe+gA9DK/K9ChELl8GTzSUBf97wP5nJpE4CB/fibl
 QF5bvH3SF8aHahZ37X8vsMlpcthY6gGfA05agRlc3ZIKL8gIw/Xd3Fmbwm7jiKckDkY8
 MmQK8aV//kCDQmxmd+myBVnAqugCBaIFfSalgbl0KKquZUztf+agl3VHb976x86ccqUk
 RcKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpznKPj42UPrcNDHhZKywnUYTcsCqscPBNu8jV0jGDOnh1NUdxJSNDvybh+i4yhb6tnAllfoKuKqdc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2vRlVxqeY12nYJQS0LGJCXKIkggBLDiHlVP22J27SrhrPwQtT
 gDrVMe8ggQ3OPRfSnuhzZG2dOWUL8Mh0p/3jVnJLu+BFgE661+9m0IfD
X-Gm-Gg: AfdE7cn4jMkfti1R3mhHhO8QdfWuFXC5ZBROmlPNbXf71OvYuWeMLUoWva6Z6rMePUe
 Ao1Sx51I8NlRXTg0ZzqLWRapYXQ/49wI8wi43HKF4vkOjH/wGwjVtmkL2LAGS1XoXxp33vo+nt9
 MPDPTOzv9vFroeEtzqiOiFJtzk05yqmWJzIYRhYMCI/JHO7fZOjt5ST5DYdY0Lebchh1o4o8bWX
 DVa0EndpF+WvGz4w8gHmN3kgSKDHYnSKQuKfXz/Vg9Pj7gKSkGDYoYCcndv21slq4MSmEFw8w/4
 gTv/dpdsdHn0NlwXfarKKMa6FUnpmyA90UFFLWoGKs2PIE7pc8PtxN5zUDUlAfMhRqC95Ylai0E
 QZuup+yKSnVFZsG8ywFbOCxMI2r0ywC5YDpGBcp5kuAWKNE+y0Vpq5PWDmrej33WXQ1LLodZORX
 ThWK8AYAAqJzGvY8/FSw/tmxQ983XWJljFaBgdTL19webEDn1CJg==
X-Received: by 2002:a05:600c:3e1b:b0:493:e890:9e0b with SMTP id
 5b1f17b1804b1-493f883157bmr144382565e9.26.1784039601550; 
 Tue, 14 Jul 2026 07:33:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2e0f165sm270374515e9.0.2026.07.14.07.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:33:20 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:33:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: =?UTF-8?B?5a+/5p+P6IO9?= <shoubaineng@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey
 <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, Sandeep Patil
 <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla
 <srini@kernel.org>, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dma-buf: dma-heap: don't publish fd before
 copy_to_user() succeeds
Message-ID: <20260714153319.07b2b1e1@pumpkin>
In-Reply-To: <CAGCp47zPkd6MWcMpxobphJp6giufpnJL46iFQMt9p76gb7OtKA@mail.gmail.com>
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
 <20260714114654.3885457-1-shoubaineng@gmail.com>
 <20260714114654.3885457-2-shoubaineng@gmail.com>
 <20260714141359.7758575d@pumpkin>
 <CAGCp47zPkd6MWcMpxobphJp6giufpnJL46iFQMt9p76gb7OtKA@mail.gmail.com>
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

On Tue, 14 Jul 2026 21:38:07 +0800
=E5=AF=BF=E6=9F=8F=E8=83=BD <shoubaineng@gmail.com> wrote:

> Hi David,
>=20
> Thanks for the feedback.
>=20
> The concern is not just about the EFAULT return =E2=80=94 it's about the =
race
> window between fd_install() and copy_to_user().  Once fd_install()
> returns, the fd is immediately observable by other threads in the same
> process (via /proc/self/fd, SCM_RIGHTS, etc.), even before
> copy_to_user() has a chance to fail.  The triggering condition is a
> deliberate mprotect() flip, not a corrupted heap.

That is what makes doing the close wrong.
But that is a program aggressively trying to hit the timing window,
not a normal program that has managed to pass an invalid pointer.
The most likely reason for a real program passing an invalid pointer
is a corrupted heap (assuming the stupid coding errors are fixed).

It is really no different from the sockopt code that receives
SCM_RIGHTS messages.
In that case once you've removed the FILE from the socket (or similar)
you really don't want to have to put it back because the write to the
sockopt buffer or length field fails.
The chance of correctly reverting the kernel state is small - and won't
be tested.

	David

>=20
> The fix itself is small and follows the standard kernel idiom:
> get_unused_fd_flags() reserves the fd without publishing it, so the
> window between reservation and install is entirely under kernel control.
>=20
> Baineng
>=20
> David Laight <david.laight.linux@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=BA=8C 21:14=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > On Tue, 14 Jul 2026 19:46:53 +0800
> > Baineng Shou <shoubaineng@gmail.com> wrote:
> > =20
> > > DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into the
> > > caller's fd table via dma_buf_fd() -> fd_install() before
> > > dma_heap_ioctl() copies the result back to userspace.  If the trailing
> > > copy_to_user() fails, userspace never learns the fd number, but the
> > > fd (and the underlying dma-buf reference) are already visible to
> > > other threads in the same process and are leaked for the lifetime of
> > > the process.
> > >
> > > The obvious "close it on the failure path" fix is unsafe: once
> > > fd_install() has run, another thread can already dup() the fd, send
> > > it via SCM_RIGHTS, or close() it and let its number be reused, so a
> > > subsequent close_fd() from the ioctl path can operate on an unrelated
> > > file.  This was pointed out by Christian K=C3=B6nig on v1 [1]. =20
> > ...
> >
> > My 2c:
> >
> > The other option is just to leave it as a 'problem for user space'.
> > No reasonable program is going to handle the EFAULT return by doing
> > anything other than exiting.
> > Even getting an EFAULT is really an indication that the application
> > is already in a real mess - most likely with a badly corrupted heap.
> >
> > Anything else leaves error recovery code in the kernel that is pretty
> > much never executed and open to a variety of bugs.
> > While the recovery here is probably ok, there are some sockopt calls
> > where it is all more complicated.
> >
> >         David
> > =20

