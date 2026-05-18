Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321D4CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 12:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A6B10E328;
	Mon, 18 May 2026 12:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iNjPLRGR";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D66510E328
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:03:08 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-65c3ea2ebf7so2495899d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 05:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779105787; cv=none;
 d=google.com; s=arc-20240605;
 b=lWEWhvP7d4/8QN2osjmhSJATABB0mVzVtSpvyX4bw79WchQjHz6KrqG5dFWDJyq5+M
 Jz8WPoy4ZAOF0AUfgQg+OZ3c5sp+2clVSwIb9RaKWOSo2ii4hRD2f4ZmRIQqd3m7rDi+
 Q8KzHKhEbfXMOYhxWMy4xt+fg92gzobhv+Zp1GIirplDhPRfTeCMvuxOQwImus4JFXr0
 gDdzcTQ5/tPJZ5POYWcUiFIayFb57as8YmwCyhaLpaB+KCXZl9ruCDvgEzMuOptvXfDO
 TaOsMfiSZQxA4ruaCRvqGtahTkL+WVc451FwKsHAIFkqC184raUmKJhis5Vckcev6QaH
 ztXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nQfhxPsXqrqiZeeyVw9wkJXgorhextrPmIU5IhGc6HM=;
 fh=RBQwKGrCLYxs9BbZm4d24GYmIRMNtdglDOLost0cmmA=;
 b=TJlCzFJ7dFtZber5sXkQfvnd015ZHs6Clb6ZnWnBunBl0Bt6ghsFMdCOzWCUwD0kZg
 5GJ2JqBxDH4o6mAm0iSN4uWeclcnZE1Mh0qTN9+XZT0vjKBvdQaY8rK2FEUzuVp1pEmV
 l2VEe2CoXFVcK2Vf7o3VzUyKISU6nH23eiptUTOVMICb4cxppQpTUDV2f5B912BW+Szd
 jsjPpPojPSDfYR6j3bWcGoKUYnqU+7mo69wO/S4ASrlPtb582lyM3MRsumSS9ArqkGRK
 zwE9E8ticpkf0cfLKiDjuY/YUlbWlrtrEg6gf5dZCwUR8PJKCz3WBWCEIe3bPSsUFJNR
 MSew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779105787; x=1779710587; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQfhxPsXqrqiZeeyVw9wkJXgorhextrPmIU5IhGc6HM=;
 b=iNjPLRGRejlsQNAF2k1aierMo2pLPZPIlQrccTGliPQJDKfH9oX5Q8pYStJGWDSHHl
 lF9+c9RK1rNmX4PvcBTC7tvLTOWlHg/REoo/ngAMUCk4rZp16LTuDeHXmqzz5PTqTREq
 R7yanW+kmuI6tBOceASaYstE/46KpPKJKK+YgTIjBhKGod73M7Pe4glfp9jcpq6ADTq/
 Tny5n/6vI2DuNig71Pd9lTpPDaEA9DMxumMvcu9SUMwQsBS/jz23VTBSZaLjxaO6F52s
 PZDn48zhhc39wF0lbGTlSXw/DsI4QIUultz39u+NBZ1uuw5eM6IEAHQ3VmbtzkK05bT3
 q89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779105787; x=1779710587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nQfhxPsXqrqiZeeyVw9wkJXgorhextrPmIU5IhGc6HM=;
 b=byGQTpDgYgHJGOETiMwI+JKU7LgIzJkp+yozzq/SXprh5iniTpggRrUsaFxMUJ2GKx
 kjuTuSHVJ7Zzrj8fNVmgtHgjFyoPmmA2iOKvDQixscQt2T7xRHa0nNGCHiX9TtX0L12d
 VD+Gn/M2Tx3FrvH0r/n9yPdEPLekdn/H3LHVv3UyWx4hXBpW9n0lRiMGMcnfBKFfqte8
 +EvEdlDIeuwFGHo/NYy7jFodYEqvck7GigUabyUYkNfm45rPxSTCujksZ8aw7IF61c6r
 Ze2heQWZ+DsNFzq1YmVZU10qFkeQPuteUUZ0xc7euu4ynO6IGJiYG1bMQe2bkHKqmbjF
 xnMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OJKbwjz3AZKS0/15UEjG4teuMEGZjaY3PfoO67SGDwu4d+IixvgGo0Ynu2RouAWIZE/MlvrM5+lo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgztNESM1OKtX/7ttFaMKfvAeQbrOKFPdRMvYuhkfhal1YSvGA
 fEv9c1A6qQVX+uM+7uN+A1mimQM3HK4xBpB9C4VOUvwB92CTm4PuWr1Ucs2YiYGnXUcHk+myhhW
 dIC5LqKt02NR2pmG7wAiNzCY5AceI5Sg=
X-Gm-Gg: Acq92OHVRK2TjAvi8OhF/0KHX5tr2gfSchB7tY7tJW77Xznyc5vqGbtlRp8V+ZBv7a/
 68+qFe+aPm+ET5OJikSu+yfbRF5Dck44PSKtJkNdccVypcM4d0a1Kvvlp2YTvCdOthNYtYOXDzx
 051RHqyXJUR0DFgo/3unRcDEMeCFYLyEb5l0svTYK20gGfyMZetIKgS3Q3x0hdboTuhaskzd474
 MO5D1u0gBSv66KdWVLuZaqEbNE0Fy9rSl4DeMEt1QM2RT4DqesyBvo4cmu5V+/0ok0py/zbn+kx
 pvMpvaFcmK95B6CEOYlwRVS1Qjh3MDu2KZOzktQPe54pf58E
X-Received: by 2002:a05:690e:d4c:b0:64e:d622:9d1a with SMTP id
 956f58d0204a3-65e22663ef0mr13926928d50.4.1779105787361; Mon, 18 May 2026
 05:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <c6c91de9-a34b-4b50-a3c1-d42bf7631f8e@amd.com>
In-Reply-To: <c6c91de9-a34b-4b50-a3c1-d42bf7631f8e@amd.com>
From: Julian Orth <ju.orth@gmail.com>
Date: Mon, 18 May 2026 14:02:56 +0200
X-Gm-Features: AVHnY4KJe2qI5pXNXCOzwBarOTRKtwJTNVIpdIJzUsAV6Iz4wL27sHKB6tNYDng
Message-ID: <CAHijbEUzWZC4GAMU6YGV42gOYkrQaMZZPiwS4Erb4H1J-fh_8Q@mail.gmail.com>
Subject: Re: [PATCH 00/12] misc/syncobj: add /dev/syncobj device
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
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

On Mon, May 18, 2026 at 1:58=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/16/26 13:06, Julian Orth wrote:
> > This series adds a new device /dev/syncobj that can be used to create
> > and manipulate DRM syncobjs. Previously, these operations required the
> > use of a DRM device and the device needed to support the DRIVER_SYNCOBJ
> > and DRIVER_SYNCOBJ_TIMELINE features.
> >
> > There are several issues with the existing API:
> >
> > - Syncobjs are the only explicit sync mechanism available on wayland.
> >   Most compositors do not use GPU waits. Instead, they use the
> >   DRM_IOCTL_SYNCOBJ_EVENTFD ioctl to perform a CPU wait. Being tied to
> >   DRM devices means that compositors cannot consistently offer this
> >   feature even though no device-specific logic is involved.
>
> Well the drm_syncobj is a container for device specific dma fences.

Not necessarily. The DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL ioctl attaches
some kind of dummy fence that is already signaled. I don't believe
this is device specific. That is also the path that llvmpipe would
use.

>
> What could be possible instead is to pass an eventfd into Wayland, but th=
at is something userspace needs to decide.
>
> > - llvmpipe currently cannot offer syncobj interop because it does not
> >   have access to a DRM device. This means that applications using
> >   llvmpipe cannot present images before they have finished rendering,
> >   despite llvmpipe using threaded rendering.
>
> Yeah, but that is completely intentional. You *CAN'T* use a dma_fence as =
completion event for llvmpipe rendering. See the kernel documentation on th=
at.
>
> What could be possible is to use the drm_syncobjs functionality to wait b=
efore signal, but that has different semantics.
>
> Regards,
> Christian.
>
> > - Clients that do not use the Vulkan WSI need to manually probe /dev/dr=
i
> >   for devices that support the syncobj ioctls in order to use the
> >   wayland syncobj protocol.
> > - Similarly, clients that want to use screen capture have no equivalent
> >   to the WSI and are therefore forced into that path.
> > - Having to keep a DRM device open has potentially negative interaction=
s
> >   with GPU hotplug.
> > - Having to translate between syncobj FDs and handles is troublesome in
> >   the compositor usecase since syncobjs come and go frequently and need
> >   to be cleaned up when clients disconnect.
> >
> > /dev/syncobj solves these issues by providing all syncobj ioctls under =
a
> > consistent path that is not tied to any DRM device. It also operates
> > directly on file descriptors instead of syncobj handles.
> >
> > The series starts with a number of small refactorings in drm_syncobj.c
> > to make its functionality available outside of the file and without the
> > need for drm_file/handle pairs.
> >
> > The last commit adds the /dev/syncobj module. I've added it as a misc
> > device but maybe this should instead live somewhere under gpu/drm.
> >
> > An application using the new interface can be found at [1].
> >
> > [1]: https://github.com/mahkoh/jay/pull/947
> >
> > ---
> > Julian Orth (12):
> >       drm/syncobj: add drm_syncobj_from_fd
> >       drm/syncobj: add drm_syncobj_fence_lookup
> >       drm/syncobj: make drm_syncobj_array_wait_timeout public
> >       drm/syncobj: add drm_syncobj_register_eventfd
> >       drm/syncobj: have transfer functions accept drm_syncobj directly
> >       drm/syncobj: add drm_syncobj_transfer
> >       drm/syncobj: add drm_syncobj_timeline_signal
> >       drm/syncobj: add drm_syncobj_query
> >       drm/syncobj: fix resource leak in drm_syncobj_import_sync_file_fe=
nce
> >       drm/syncobj: add drm_syncobj_import_sync_file
> >       drm/syncobj: add drm_syncobj_export_sync_file
> >       misc/syncobj: add new device
> >
> >  Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
> >  drivers/gpu/drm/drm_syncobj.c                      | 374 +++++++++++++=
+-----
> >  drivers/misc/Kconfig                               |  10 +
> >  drivers/misc/Makefile                              |   1 +
> >  drivers/misc/syncobj.c                             | 404 +++++++++++++=
++++++++
> >  include/drm/drm_syncobj.h                          |  21 ++
> >  include/uapi/linux/syncobj.h                       |  75 ++++
> >  7 files changed, 795 insertions(+), 91 deletions(-)
> > ---
> > base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
> > change-id: 20260516-jorth-syncobj-d4d374c8c61b
> >
> > Best regards,
> > --
> > Julian Orth <ju.orth@gmail.com>
> >
>
