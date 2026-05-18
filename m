Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3B2CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 12:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B972E10E258;
	Mon, 18 May 2026 12:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X2XRQ2MT";
	dkim-atps=neutral
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59E910E39F
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:58:56 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-651c5d525f6so2227532d50.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 05:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779109136; cv=none;
 d=google.com; s=arc-20240605;
 b=BGQgVCYyAMAT09NA6j4AFIponDRnm3dBSBfgMIXBELmUzhN/pheHnhE+16uhTuQuIG
 25E+zdtIDkzhNEQyeZZfuXa9TlXzX9hL8VBagKELhwwUjWNZxQgq6cqMOUoNJiUlxIJ2
 WPe95FlRBG84XQiHAsYBM1EA7VWGBm0mDKdx5P6iJ30AV7Cy+yLeHNiLj+T1QrD4TwAI
 DlzBulUGTzdVOnASvozQz+cQVBMEqjs412VwmGFgZsVAeiOCh8zolRZyVcJN4djiSePy
 ujGA8TD/TYkgEImfeuRatcHk7kfgG7Nc6OumjkbIdknZ3PV1nKUOIxBVRSEXU0aZWOWh
 S3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=43XOKwod7lkr/JFAt6gp70bo5/ubw+AmY3hOZjjU4ZM=;
 fh=Fe04e7B12CaLWZTFf04cHmLWdVtAIO+9eYjncnJ7AxE=;
 b=fs8NDYGiRMMn8DdcfGwsfsjsOJLbU5qb8SfnDyLBF1OxYbhcz/t5+2I75/n6Edc/kY
 rzv0IgUoAhlTipuP4Z7/iuWH9XqtHMwhrVdv+aP3i4xfJpXMec5Qq8p+5/Q4nQgsxojE
 KqaTVx723I/+BqC7RkvLJwPY5HEUQJhod7pEVPe22qYAJjhH7R/wCNTvOQ+ZfP2EHmA1
 be7DV4PWw0FfgsaQ/p2nCsp80X3rT6UXtO3BfxGHy45Sg+5ATXQiG1+mQKxwoPZSkBP8
 DLyR/hROmgcRFLeCwpGP6gjl/tJZp95ak/qXDDiesOyHFO7+C9S/btLnUuEKAXvhMkkr
 atAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779109136; x=1779713936; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43XOKwod7lkr/JFAt6gp70bo5/ubw+AmY3hOZjjU4ZM=;
 b=X2XRQ2MTg0NwuFT5QOtDs0fhgj9z6xI2JtcB6sUTUK6qhZ45faAvTcH3G6NOfhud25
 TYOGhmGlJeTsA/k+yR1OsMSD+uD/MBXYvJ6647HuGmhoUwytaZLtPta2+Hm/VX4UsO+M
 fW6K6HM2R6g6xfzSpaEoHLERIrlGUtuDI9AYi6f3Vb8UwW8iIk//IynrGSSfj9oLVwDX
 RRa9djoVddZucDpOH28pyDEjcHpaiJuKgtXKEA536es+rpRLYQWM8ezwZQP4WTyQ0/BV
 HfhR8Fgbq5hnCODrgnUkrjfnw968hJlI4fzvlXQZvThAQQaTKocCG1xu3OUvJKFSOZYN
 9FWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779109136; x=1779713936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=43XOKwod7lkr/JFAt6gp70bo5/ubw+AmY3hOZjjU4ZM=;
 b=dE34NLuaCEnOO/u3nPUvBAs5xAwxZhlAXKVMSEJeB31laa7UbNLhowdKYNttlySV7u
 sw4mdnQct+SP866bzhLnNYY4RlLBujOatLLcZ+FManH6jpw5yFSdVKhZjQrx0m45mLCP
 7S52w+uc59Xf+NY3uVT7oM2CW0REzmRMZHXjtW6BErXYwLb5n0uchlsUL4PHqLvkQ2PX
 zn3M/zr7RcGKbH5tQkYvlF3X77yM7NNlNJ0dp//AJkSE3KcpMQvBZezHyD1GuvAFWtFN
 dx/ZKqrqY1J1OfYS5l+L4HTNYXXNxFI+uwhW/Ox+ADVx5yg5gnyi6snPY7bJtM1oUENp
 M9mA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6X/LE1ar2pC0BivlDvtm3LbSIcnKbs/0GBUC9oPvEJ1Sb7/NGU9bm6+T2vSNHuHkak0JAQMtaq3M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztM4lwWc9VgvEJP5n6CHQhOqwrub88hCQhNDktCnF3rXl6NPtb
 9qetihWIHwPIC+D39GIJIUL/UJ8vl6xbzzBrEEJET5/Noz6LLsyOWwoBgABY4PpXiC+U6E7wj1M
 0u5RVY/RAGDcKBkTMgVmTDpUQdjTnbH8=
X-Gm-Gg: Acq92OGWqfLeshuvgt6wD2RVm2TpG3NHt98RVO++vvQpDjlLjKD17hTgAL+P0tigsUC
 AL++GRjQmPOmxr9aJpBLuu3bZbEr/cir/8i5zw9TgLSxmfqC3XUvsjuvfuqTp+3eqBEUcGV+0fp
 HBylBaAoukcYq1A8rOxlhkRmbC0bXGrUb4+6iJKTZ5Ss9tY9XNyNc06s8/Jtp85MfHQfte1Rcb6
 aOPtI4ovY3Q+g8/peFk1PqGv4Y4X+F7e4wYVDLc3wHPqXuJInq4GGt1+yUZyvgnExgAKnqFth5W
 2RW85SnFtsi7iSYC9VjxKAjH75rDSWWYs6qTBo173PB7hWm0
X-Received: by 2002:a05:690e:1589:20b0:64a:ce9a:ace2 with SMTP id
 956f58d0204a3-65e228a2c9amr12243832d50.56.1779109135713; Mon, 18 May 2026
 05:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <c6c91de9-a34b-4b50-a3c1-d42bf7631f8e@amd.com>
 <CAHijbEUzWZC4GAMU6YGV42gOYkrQaMZZPiwS4Erb4H1J-fh_8Q@mail.gmail.com>
 <69dcbcc1-da58-4d34-bfb0-5c8d33b75d59@amd.com>
In-Reply-To: <69dcbcc1-da58-4d34-bfb0-5c8d33b75d59@amd.com>
From: Julian Orth <ju.orth@gmail.com>
Date: Mon, 18 May 2026 14:58:44 +0200
X-Gm-Features: AVHnY4LKZxHnUpuDd83fvxh1z7FeQsObNJnWqmF56ZyeBHGI_r4jDsz0bjbgq4Y
Message-ID: <CAHijbEWqc2+kSkk3i_LxB2PQ6XwUetw1UkdUdXJfdv3zgKd1kA@mail.gmail.com>
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

On Mon, May 18, 2026 at 2:41=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/18/26 14:02, Julian Orth wrote:
> > On Mon, May 18, 2026 at 1:58=E2=80=AFPM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/16/26 13:06, Julian Orth wrote:
> >>> This series adds a new device /dev/syncobj that can be used to create
> >>> and manipulate DRM syncobjs. Previously, these operations required th=
e
> >>> use of a DRM device and the device needed to support the DRIVER_SYNCO=
BJ
> >>> and DRIVER_SYNCOBJ_TIMELINE features.
> >>>
> >>> There are several issues with the existing API:
> >>>
> >>> - Syncobjs are the only explicit sync mechanism available on wayland.
> >>>   Most compositors do not use GPU waits. Instead, they use the
> >>>   DRM_IOCTL_SYNCOBJ_EVENTFD ioctl to perform a CPU wait. Being tied t=
o
> >>>   DRM devices means that compositors cannot consistently offer this
> >>>   feature even though no device-specific logic is involved.
> >>
> >> Well the drm_syncobj is a container for device specific dma fences.
> >
> > Not necessarily. The DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL ioctl attaches
> > some kind of dummy fence that is already signaled. I don't believe
> > this is device specific. That is also the path that llvmpipe would
> > use.
>
> Yeah I feared that.
>
> This is the wait before signal path and if I'm not completely mistaken th=
at one is not supported by a lot of compositors.

I believe this is supported by all compositors.

>
> The last time I looked for GPU support the compositor needs to spawn a se=
parate thread for each client to support this approach.
>
> It could be that we have eventfd integration for that as well now, but in=
 that case you could give the compositor an eventfd instead of a drm_syncob=
j fd in the first place.

Yes, all compositors use the DRM_IOCTL_SYNCOBJ_EVENTFD ioctl to wait
async for the timeline point to materialize and/or be signaled. The
wayland protocol was the motivation for that ioctl.

>
> So as far as I can see using drm_syncobj for software rendering really do=
esn't make sense, eventfd is a much better fit for that use case.

Using eventfd has some disadvantages:

- We've just added syncobj support to vulkan:
https://github.com/KhronosGroup/Vulkan-Docs/issues/2473#issuecomment-444611=
7280.
For eventfd we would not only have to add yet another extension, that
would realistically only be exposed by llvmpipe, but also every
compositor and every client would have to support both extensions.
- Similarly, a new wayland protocol would need to be designed to
support sync over eventfd.
- Eventfd does not support timeline semantics. Meaning that you would
have to send two eventfds over the wire for each commit, one for the
acquire point and one for the release point. Whereas with syncobj you
only need to send two integers per commit.

I don't see the advantage when drm_syncobj already does everything we need.

You seem to believe that compositors would not be ready for this and
from that perspective I can understand your apprehension. But I can
assure you that compositors are already fully set up to support all of
the usecases I've described: The wayland protocol requires the
compositor to support wait before signal.

>
> Regards,
> Christian.
>
> >
> >>
> >> What could be possible instead is to pass an eventfd into Wayland, but=
 that is something userspace needs to decide.
> >>
> >>> - llvmpipe currently cannot offer syncobj interop because it does not
> >>>   have access to a DRM device. This means that applications using
> >>>   llvmpipe cannot present images before they have finished rendering,
> >>>   despite llvmpipe using threaded rendering.
> >>
> >> Yeah, but that is completely intentional. You *CAN'T* use a dma_fence =
as completion event for llvmpipe rendering. See the kernel documentation on=
 that.
> >>
> >> What could be possible is to use the drm_syncobjs functionality to wai=
t before signal, but that has different semantics.
> >>
> >> Regards,
> >> Christian.
> >>
> >>> - Clients that do not use the Vulkan WSI need to manually probe /dev/=
dri
> >>>   for devices that support the syncobj ioctls in order to use the
> >>>   wayland syncobj protocol.
> >>> - Similarly, clients that want to use screen capture have no equivale=
nt
> >>>   to the WSI and are therefore forced into that path.
> >>> - Having to keep a DRM device open has potentially negative interacti=
ons
> >>>   with GPU hotplug.
> >>> - Having to translate between syncobj FDs and handles is troublesome =
in
> >>>   the compositor usecase since syncobjs come and go frequently and ne=
ed
> >>>   to be cleaned up when clients disconnect.
> >>>
> >>> /dev/syncobj solves these issues by providing all syncobj ioctls unde=
r a
> >>> consistent path that is not tied to any DRM device. It also operates
> >>> directly on file descriptors instead of syncobj handles.
> >>>
> >>> The series starts with a number of small refactorings in drm_syncobj.=
c
> >>> to make its functionality available outside of the file and without t=
he
> >>> need for drm_file/handle pairs.
> >>>
> >>> The last commit adds the /dev/syncobj module. I've added it as a misc
> >>> device but maybe this should instead live somewhere under gpu/drm.
> >>>
> >>> An application using the new interface can be found at [1].
> >>>
> >>> [1]: https://github.com/mahkoh/jay/pull/947
> >>>
> >>> ---
> >>> Julian Orth (12):
> >>>       drm/syncobj: add drm_syncobj_from_fd
> >>>       drm/syncobj: add drm_syncobj_fence_lookup
> >>>       drm/syncobj: make drm_syncobj_array_wait_timeout public
> >>>       drm/syncobj: add drm_syncobj_register_eventfd
> >>>       drm/syncobj: have transfer functions accept drm_syncobj directl=
y
> >>>       drm/syncobj: add drm_syncobj_transfer
> >>>       drm/syncobj: add drm_syncobj_timeline_signal
> >>>       drm/syncobj: add drm_syncobj_query
> >>>       drm/syncobj: fix resource leak in drm_syncobj_import_sync_file_=
fence
> >>>       drm/syncobj: add drm_syncobj_import_sync_file
> >>>       drm/syncobj: add drm_syncobj_export_sync_file
> >>>       misc/syncobj: add new device
> >>>
> >>>  Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
> >>>  drivers/gpu/drm/drm_syncobj.c                      | 374 +++++++++++=
+++-----
> >>>  drivers/misc/Kconfig                               |  10 +
> >>>  drivers/misc/Makefile                              |   1 +
> >>>  drivers/misc/syncobj.c                             | 404 +++++++++++=
++++++++++
> >>>  include/drm/drm_syncobj.h                          |  21 ++
> >>>  include/uapi/linux/syncobj.h                       |  75 ++++
> >>>  7 files changed, 795 insertions(+), 91 deletions(-)
> >>> ---
> >>> base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
> >>> change-id: 20260516-jorth-syncobj-d4d374c8c61b
> >>>
> >>> Best regards,
> >>> --
> >>> Julian Orth <ju.orth@gmail.com>
> >>>
> >>
>
