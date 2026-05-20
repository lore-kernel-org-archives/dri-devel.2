Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D326CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 11:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF58710F037;
	Wed, 20 May 2026 11:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CUNjW+Xn";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FB6C10F037
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 11:46:14 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-65c5361142fso4643794d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 04:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779277573; cv=none;
 d=google.com; s=arc-20240605;
 b=ExdYLLmKa0UmeHJrMVO9WjNTJEDfEd537Y0Tq78uxsOBXpysQJwMX/r+seAnsPOD5r
 wwblx3jzSRijeQovOWoYLljT+hSllOooUPAB9anNin8RCX/orJYn+UlPUCMQazwMwzAN
 LAL7q9RP2/bY3d341MloJKaAezBQUuT8o4D/B86gta23AxM5ZrAU7F9C+04UzT3Jtftv
 mrON5UI0c9WblJwKsm05ppMvINZmhVPWEKC1yFJp3yfMxM/J40fxcTT5phgww7am0I8f
 YerQAy/aEclTv+4lfTByIhEIikM8qxvoeR2UeDHdRXOVHgwdqkxo9SP32JDEth54osKK
 JQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mwQC2VpgPcAOO/eSiXMuOlKGLERJ6tVL0QZy3DdZeqg=;
 fh=A/gFn5Yvc6wLdmF1YmKhJuAWSViQkJeS4/0hEtsaQz4=;
 b=FQHx0Dumuel6Yds52vkZcfnkiowy89XP1nyRtnfOXPocSP8AnjxqR4Db39Rhj49Vcz
 0ZAh+oLq145yONp5X4cCLJ1CXaEtaOrQpG1uK8/xUmH0GChqlW5RVTY2oopVhgejPb3w
 Hh/wqHWie5DuUT98UHPjWGCPBIo9LRQaZe9C95tToVt8Rrd+AyNVC3FfwtJ67waOPNeG
 Cvhz39oIWTJNlEzo8xqTdWcSHNhoIutQz+L4th8PdoBEo1md7MHl/loCukGcO1MdurJS
 QvJkNGuruH2n7S5XxZniIpznqd22HH4aYdAGQ7ngubSsUjA7SbhyZXEl5skM8hkh6w8N
 6U8Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779277573; x=1779882373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwQC2VpgPcAOO/eSiXMuOlKGLERJ6tVL0QZy3DdZeqg=;
 b=CUNjW+XnEBgVVfQvAKPOxvedXFtFePG3MBZtTQYyLzXPtzNhuTjH3c4hreo5dMMbx8
 yMoQzt6WzpFJ2i1bzdz2CAG1m6P4ApSlgyjopV/n0k0cDluULzZ3ikGJXYY7ZyliMVtr
 j8SnMf9Ukd6NP+bIJXV2t/MwKTzjCeFssRCvcAnWo9B+6HCKBWqTQ4/6oByPqc4Hs3a0
 Nf4r3w8BzWaW6QiHOE3qWt3uSoc8PT/JRpHpEwSGMZHXEEMH+rm5vhXGMp0/d8TYgpU1
 uwLAtNCa+jN71xmtxCZUce+XjEcNxwTTSk7DA0ygTc/jNXnpI2cs5frzbQyWR73Ob8dl
 b2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779277573; x=1779882373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mwQC2VpgPcAOO/eSiXMuOlKGLERJ6tVL0QZy3DdZeqg=;
 b=n6ZgN1GTxTy5CqbC9r9sEq/rcgVcrEYf0HEHbU4I2rvVd1goCs6GYpvqfIG9MBu7lY
 2/wlMyvivu1ozOYlGpQyoZs5DLuxpkV5zEibShY1Pg5SM2xoWXMsUazPnQd2hKuqdgFO
 SYKH9mA3FFkBZ0KidEA/He/jQSJK/XNY2Vb8xlLCFdIeaDaH0b+0gdB5lJhxU2bWeHlp
 JaghPp8O0tUsIdJzdv86QW+2FCD9yJilcgb1vUj9kE0Mhdcq/1j1Qsw6JTnx0aJ1ZDuh
 /1qU9kqpK0y8GWDxeD9OzI4TgfS8DvmIWzEurCWHsB7QgZoWJtzcAB+avWiuFM/SBzSP
 XYJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Y3NO0PRGeD3PqQSQ7T4hR8lukNFjxw46m3c+0eATuJCFLDuWkVkzd9vHFSWWz2MXWtvbbyX9xPCQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8MwBr1QmZAzHh55OpqQN0/q3QVJWJyYgu/aa/SAi17Tcf24Th
 rvO9/s8SVfIdXBjFQCaZyoOwIimKPFruAT1SD+pNZzw/v4N4EQ0wHeYVRjTXG+/hbMofERe/6Dv
 1LGuY2hU66VlxXWQbuaER/iq99JqZ2kk=
X-Gm-Gg: Acq92OFjvLleYfoThLw9oMkb34rZaNX4Pc093bRfPZZseNaKdnAB6Kk00KijgiLNo6f
 Sx7lzCYqFtbXTdr4d2JpWVfvNbQYBdwLlQIJKrg9ovBIeTJ3OO0uaRJmrtdcP5+rRwUhcSbVbhA
 l/2GYtH9ZAJ9jdJ0OuRHoFu3cDx9YXYjBugM0+yYzF8qFS8p3P9FqhZIQmxAClcdNJhfQZyYc82
 iT9KPjpUQ/HltODFZQRb36VnnG5RmCmA16boBbAkgtm7nqHXV7ttEKqE1r0o2CbuxCIUaTiBm1w
 opY8EJKEPWqG/u7x42ZEg1qHYfVtUQKO3hr9WYpZFx5tXfjq
X-Received: by 2002:a05:690e:1487:b0:65e:4b06:f89b with SMTP id
 956f58d0204a3-65e4b06fd2cmr14416343d50.51.1779277572905; Wed, 20 May 2026
 04:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <c6c91de9-a34b-4b50-a3c1-d42bf7631f8e@amd.com>
 <CAHijbEUzWZC4GAMU6YGV42gOYkrQaMZZPiwS4Erb4H1J-fh_8Q@mail.gmail.com>
 <69dcbcc1-da58-4d34-bfb0-5c8d33b75d59@amd.com>
 <CAHijbEWqc2+kSkk3i_LxB2PQ6XwUetw1UkdUdXJfdv3zgKd1kA@mail.gmail.com>
 <38551bfe-75e1-4978-b57d-adc43cebc85e@amd.com>
 <CAHijbEWHp960qvZFoK7+9ppHAqkAR7=UQhtMUccqWzGd_pFPQA@mail.gmail.com>
 <5ee6d5af-ac48-41d7-a19f-e08a3c5b7d19@amd.com>
 <CAFZQkGwmeipZnvmBkcE7KhvUSMkSE=fzLBZtiMyhv3mM04Vudg@mail.gmail.com>
 <dff60378-4e47-4753-8878-feec6e1c2690@amd.com>
 <385a4d4f-fe22-41a7-8d4b-4dc6bc9930d3@mailbox.org>
 <1e94106a-f72e-447e-9885-2d2cc8f8e722@amd.com>
In-Reply-To: <1e94106a-f72e-447e-9885-2d2cc8f8e722@amd.com>
From: Julian Orth <ju.orth@gmail.com>
Date: Wed, 20 May 2026 13:46:00 +0200
X-Gm-Features: AVHnY4JZYLaQrAuUqg_r9R4xrt_7B8lof_FLZgmpinm1lpd54PV11HWLkp9qJk4
Message-ID: <CAHijbEWSnwm5_uTAbRDYOkMFwu+X3_xGHxjHyK-XeaO15KTGOQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] misc/syncobj: add /dev/syncobj device
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Xaver Hugl <xaver.hugl@kde.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
 wayland-devel@lists.freedesktop.org
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

On Wed, May 20, 2026 at 1:21=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/20/26 10:13, Michel D=C3=A4nzer wrote:
> > On 5/19/26 18:00, Christian K=C3=B6nig wrote:
> >> On 5/19/26 17:31, Xaver Hugl wrote:
> >>> Am Di., 19. Mai 2026 um 15:29 Uhr schrieb Christian K=C3=B6nig
> >>> <christian.koenig@amd.com>:
> >>>>> 1. This series makes the ability to manipulate syncobjs available
> >>>>> independently of attached hardware.
> >>>>> 2. It makes it available under a consistent path /dev/syncobj.
> >>>>
> >>>> Exactly that is a big no-go. This has to be under /dev/dri.
> >>> FWIW udmabuf is also under /dev directly, but I don't think any
> >>> compositor developer would complain about a different path.
> >>> What are the rules for that? Could this simply be put in /dev/dri/syn=
cobj?
> >>
> >> The syncobj are actually the DRM specific way of doing things. The gen=
eral kernel wide way is to use sync files (see drivers/dma-buf/sync_file.c)=
.
> >>
> >> But there has already been tons of problems with those sync files. E.g=
. they doesn't support your use case at all since they don't have wait befo=
re submit behavior.
> >>
> >> So there are already ways to do this, but the Linux kernel so far told=
 everybody that this is forbidden. The DRM syncobj wait before signal funct=
ionality is much better, but then basically the second try to do this.
> >
> > I'm not quite sure what you're getting at here, just to be clear though=
:
> >
> > While the syncobj Wayland protocol extension supports wait-before-submi=
t behaviour at the Wayland protocol level, it doesn't need or cause wait-be=
fore-submit behaviour for DMA fences in the kernel. The usual rules apply t=
o fences attached to syncobj timeline points. The wait-before-submit behavi=
our at the Wayland protocol level comes from allowing submit before a fence=
 is attached to the acquire timeline point.
>
> Yeah I know. I'm one of the people who came up with the idea of doing wai=
t before signal this way in the drm_syncobj.
>
> What I wanted to say is that a lot of people used the dma_fence to implem=
ent wait before signal before and got a bloody nose from that.
>
> > (It took me a while to realize this distinction, before which I mistake=
nly thought the kernel's DMA fence rules would prohibit wait-before-submit =
behaviour at the Wayland protocol level as well)
>
> This is what surprised me.
>
> The drm_syncobj implementation solved the wait before signal for the kern=
el, but my last feedback was that we basically just moved the issue to user=
space and Wayland compositors would have quite some overhead to implement i=
t correctly.
>
> That compositors now use eventfd to simplify that was news to me but make=
s totally sense in hindsight.
>
> But anyway, we need to somehow simplify the drm_syncobj -> eventfd usage =
in the compositor.

That is not the only usage in the compositor. Compositors use all of
the following operations on syncobjs:

- creating syncobjs
- waiting for points synchronously
- signaling points without a sync file
- querying points
- transferring sync files between points
- exporting sync files
- importing sync files

Which you can see by looking at the userspace code linked in the cover
letter. Bypassing the handle in one ioctl would gain compositors
nothing since they would still have to convert to handles and manage
their lifetime for all other ioctls.

> That requirement is perfectly justified and avoiding importing the drm_sy=
ncobj fd into any DRM driver should actually be really easy to implement.

That is what this series does.

>
> Regards,
> Christian.
