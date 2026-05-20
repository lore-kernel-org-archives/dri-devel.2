Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DD0CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 12:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0353B10E4BF;
	Wed, 20 May 2026 12:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="Whq6NoHV";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A903110E52E
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:33:41 +0000 (UTC)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 5CB1F32BA43
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:33:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1779280420; bh=QAPUhSFoYr4bUaOZROL9kMB0XxGMQA2LYNnfIiF3fpc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Whq6NoHVvcJFXcYunt2by+cUOjwnj5qoXA3T2bsBSlE6re6nm2tCRX78zTQiUSpeT
 Z8gqcl0bxQkQ04sGGDoPKApr8jQhjYnMz4tnNztA/QPBCQO6WtOYx+H20DWNn0LWe/
 7RADW8TNKcBmaYESpnHv0/JYuQiiWxCcf7S6OCqalQxhVc2kZjAO3zDKdCKBlvx3BC
 Nui2oS88fh84B2/uTjK6axPUV0cIkLquf0d/bY8IKHQm9Md3fc1iJ/hcZpK1PY+YvN
 k3LQqb2/h6ZPn1RpEdanRdFYpQdwMG9QWuz4OFrJG0avYWo3hpZ2yf/qrRiD0R91W1
 qiumSiHGDGc+g==
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-65c7a459105so5055858d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 05:33:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9TYGxw0l7d7GVLMJf5SvysetzuY8Me9pHAhCgGuKB3fyt7nCuA1QNjXwqTuvdiD0CR0/2OV3Gf72Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbOAB9dgM85FdctRQ2fsuPtFWS4Dael0fw4mZvZNL7hAR6V7Tk
 povzAJ2C+AH9sO7nnDYijxrBXsrN0Mss5ch9dBABzlOveA6SNfAoXADv/Cul3uXKi1p1t4Olcde
 hT+2KlATYANZXSVoUVvDRtA5S7dJu9XI=
X-Received: by 2002:a05:690e:1c05:b0:65e:9e71:7942 with SMTP id
 956f58d0204a3-65e9e718592mr625005d50.37.1779280418541; Wed, 20 May 2026
 05:33:38 -0700 (PDT)
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
 <CAFZQkGz=UJqaJ_eTwKBy1pAg5xL+PLibh7W1vYf7JD7Jrx-LZQ@mail.gmail.com>
 <53edf0b5-e733-4b96-87d7-3307275500c0@amd.com>
In-Reply-To: <53edf0b5-e733-4b96-87d7-3307275500c0@amd.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Wed, 20 May 2026 14:33:26 +0200
X-Gmail-Original-Message-ID: <CAFZQkGxpPm081Fz8UtDuBA1PKD42+9YDA+cc6fbSpfawXwu9+g@mail.gmail.com>
X-Gm-Features: AVHnY4Jgk8foYzRi5plZzxfmXsVMwh3FA7NaYflBHH8P8EN0Be3BzPmLSUlyKpc
Message-ID: <CAFZQkGxpPm081Fz8UtDuBA1PKD42+9YDA+cc6fbSpfawXwu9+g@mail.gmail.com>
Subject: Re: [PATCH 00/12] misc/syncobj: add /dev/syncobj device
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Julian Orth <ju.orth@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
 wayland-devel@lists.freedesktop.org, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
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

Am Mi., 20. Mai 2026 um 10:08 Uhr schrieb Christian K=C3=B6nig
<christian.koenig@amd.com>:
> Well I would say the other way around is a pretty common use case.
>
> In other words the compositors uses the internal GPU for composing and di=
splaying the picture. And the client uses the external GPU for fast renderi=
ng.
Sure, but that's not what I'm talking about.

> > - the buffers from the client stay valid
>
> Buffers from the hot plugged GPU don't stay valid. Accessing CPU mappings=
 either result in a SIGBUS or are redirected to a dummy page.
Again, not what I wrote about. The buffers are on the integrated GPU.

> > - the syncobj stays valid on the client side
> > - the syncobj becomes invalid on the compositor side
>
> Nope that's not correct. The syncobj itself stays valid even if you compl=
etely hot plug the device.
>
> It can just be that the fences inside the syncobj are terminated with an =
error.
What about eventfd created for a point on the syncobj?

Another (future) problem with hotplugs will be if the sync file hasn't
materialized for the timeline point when the device is hotunplugged,
since there can't be an error on the fence if there isn't one. Or
could userspace somehow set an 'artificial' fence with an error in
that case?

> > "invalid" there means either
> > - the acquire point of the client is marked as signaled, before
> > rendering on the client side is completed
> > - the acquire point of the client is never signaled. Since the
> > compositor waits for the acquire point, the Wayland surface is stuck
> > forever
>
> Both of those would be a *massive* violation of documented kernel rules f=
or hot-plugging which could lead to random data corruption and/or deadlocks=
.
>
> If you see any HW driver showing behavior like that please open up a bug =
report and ping the relevant maintainers immediately.
If there are no error codes with syncobj yet, then to userspace, the
latter behavior is exactly what we get, isn't it?

> When a hotplug happens all operations of the device should return an -ENO=
DEV error, even when exposed to other devices/application through syncobj o=
r syncfile.
Okay, that at least gives us a way to fail imports somewhat
gracefully. Normally, failing to import a syncobj is a fatal error in
the Wayland protocol.

> One problem is that only syncfile allows for querying such error codes at=
 the moment, we have patches pending to add that to syncobj as well but we =
lack a compositor with support for that as userspace client.
As long as the error case can be detected with an eventfd,
implementing that in KWin shouldn't be a challenge.

> Well the question here is if the device the compositor is using or the cl=
ient is using is gone?
>
> If the client device is hot removed the compositor should be perfectly ca=
pable to import the syncobj.
>
> If the compositor device is gone then you don't have a device to display =
anything any more, so generating the next frame doesn't seem to make sense =
either.
>
> What could be is that you want the compositor to be kept alive even when =
the display device is gone to switch over to vkms or whatever so that a VNC=
 session or other remote desktop still works.
There are two GPUs in the example I gave. The compositor can use both
for rendering (in cosmic-comp's case) or switch between them (what I'm
trying to do with KWin), or use one device for rendering, and another
for importing the syncobj.

> >>>>> 3. It removes the need to translate between syncobjs fds and handle=
s.
> >>>>
> >>>> That's a pretty big no-go as well. The differentiation between FDs a=
nd handles is completely intentional.
> >>> Could you expand on why it's needed? For compositors, the handle is
> >>> just an intermediary thing when translating between file descriptors.
> >>
> >> Well what we could do is to add an IOCTL to directly attach an syncobj=
 file descriptor to an eventfd.
> > That would be nice.
>
> Take a look at drm_syncobj_file_fops and how drm_syncobj_add_eventfd() is=
 used. Adding that functionality shouldn't be more than a typing exercise.
Yeah, this patchset already adds that functionality (on the new device).

> Do I see it right that this would already solve most problems in the comp=
ositor side?
Skipping the syncobj handle step would only reduce the amounts of
ioctls the compositor does, but afaict it wouldn't solve any
compositor problems. At least not as long as it's still tied to a drm
device.
For device hotplugs, the only new thing we need for correctly handling
syncobj is a way to receive errors on the eventfd.

A device-independent way to create and use syncobj would still be
useful to us though, both to simplify the compositor and to improve
the software rendering use cases.

- Xaver
