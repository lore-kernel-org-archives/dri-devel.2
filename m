Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FECCD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 12:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3FF10E316;
	Mon, 18 May 2026 12:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QDuaIYT4";
	dkim-atps=neutral
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B1610E318
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:10:45 +0000 (UTC)
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-65318dafbcbso2092046d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 05:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779106244; cv=none;
 d=google.com; s=arc-20240605;
 b=kS21UNzup/JIfUpo+YP70QNdozLfngi83NRmMFzbava3sCuiVDXA2dRs48AEQ9Nn6w
 nSylb+zR9uEvaWGObPQugU3EWVRajMER5fEIY+OrjPnVCQYIJ59+hxneYG2R4l9Twfdk
 LaLhZJF2cVN+8/2VhwjO87OMri7jd/L+55kutYs3Cz7NFKdRCQ/927CHQI3JCSrEbhZ8
 frd/FUtjD/yeP8aE+sEzLEtmN6Bl99ubEmB2bi0agagQCOeVsTQqhmxGW2HOIE5aRYNJ
 OZmBl+9xRWK5AUpbt9lId/nXW6NtX0GvSp62ykDky9t/iDySvYbwgOpbr1JlMSdc9sKf
 OHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=plmfWyCAsOyqIGG0vlgzF8PeCBJYS1a4eoMMtlKeDxY=;
 fh=7y1kXAgg1v56mEtX7/Qi/LROTcQkSRq3WI4kQT2MIQc=;
 b=gK6twxx25Aaz2O36Yz4kqUhvKxIGNR5WW+2Lhntb2Ite3yxKVEMSCYqjHB7m/2aY6r
 62s1O2WtWRqoVuB/rL4dFtKPZXRUc/i4Uwq4Os3hMvKM5Uu+ig4TZvTQp3yslmNB64wK
 g7tQnpUu1vakwXT0OmF2ZWf1Cgwy0c+kbKCtTb2Xm+ob/cxSFkv2mwj8/snauVM6+9fm
 78wHJooPkebQ0jokII65EFuu5b/FQPI/ckwG/RFaPmgIqV373qOnzKnPI9jjAzw6QArv
 XT5e97QP6vTM90QntMBuqOl2CF11N9K2cPfDwGJuzC+eizfUv3BZUW1aW+CN9tiKrIab
 vKoQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779106244; x=1779711044; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plmfWyCAsOyqIGG0vlgzF8PeCBJYS1a4eoMMtlKeDxY=;
 b=QDuaIYT4Z5mZZC25cLRdTysXae+sHuKzV9b1PRXeVNTrP/CCGL5DHDEAU3ENJiwz11
 ppleYNAjWYJZWHu6TRK7pv8mLUeo6jqwZyI7feyyEPKxrmZtiF6pxuaFR3mVq4d69NKU
 e7j/LgOrE8spiSYCPGMJG3KRSKgIomn1kHxIGGl9H3RXLm9PGwjO0gQ9rzk3cVOE9NjZ
 T6g2mYzq81Q1VXpdtzHqo/ITz95Wbn/p0c3WyfL64FGGE1iLowieyFq/4WjEgyb5SERD
 /memMh455esnR2eNfHyLnJzNE8Xlm5FfartaRa4oib/70VSTJmc2PIVKjeMm40b6Ioh0
 Z99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779106244; x=1779711044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plmfWyCAsOyqIGG0vlgzF8PeCBJYS1a4eoMMtlKeDxY=;
 b=eIopbPU3P/Cfln6Lko2WWJ18RfVIVK6m8jqVAgaT+fMNAZ3zzACRfJ60OWemwyoj5/
 aS6wpmZcjPubazp0Jy1sSq6PLA5eyNaVr16xuctidfpZWbFUYLAFv4qW45yvIEwzFJl+
 eXgspU3DPmo0yJJt7lDYXc7UJvEVQ+lsQUfHwBHqvd8Y/KTAB6CEdTTNlTiVqH6qP318
 YeYG/1nvTxv1hs6M5s7YqvpLbRNaqIiv7/5pUKY2WRxdcCng6258TumUhLDgb9fTVLMn
 hNPv186oTeR0ix/eRFo+UihoiP8p/cW+tlo7o40k5yL90P0rLkH4FaX7nhegI0GhhNqc
 z+fg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sd5uRMnyrcW4pZ/H23pDMeFWkNy0oIWWo3fvyGGTpSKXF8mZK7PfKrrsCZW+w1D6fZaxT5bOvhhg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySoIRMmmmTTpO8BDr0H3aVT+7OnW1oQZJQfJ3BSTByZWdcG+qr
 556VIdT/HcIPnvhrX3M0qTd3kodQYS9R3hvPDwb91LcW5tOEHUe7p7O+5ms3GuSZqnUWrFPVbEd
 kOYv8fSlYquGgpobPHq5ZqYdqKHrivwk=
X-Gm-Gg: Acq92OFUZFr1Xyj15Jg7vMNaKXLLgJlG/kPDZueAONjOPwbcs/29w7i74k2camP2Y79
 fB8ptr7B/yhM1F9QzB0SOEC9Pcl0P6o+s73rK2hKL7iRqCeG/hFINgesr5e8Equ6Q5+/ziZm/OV
 6iJoR06Pq5VRRVdHZlSO2iwYzYG3B0XEwA6rqw01NYey92GtMfgRoGfLXGA/sx0LLn+MMuacG8B
 rnoCMQlEOW/ey2TUeofS5LWilysuLlk1+BKeSc9pInMKrnSpXy/cosyhaWpux7UZLUnQ+fzw5Yf
 AbNJ1jLhFd+Xj35QUMVdhjJchQjXBCPnVwFr1IR93kPGaKk3
X-Received: by 2002:a05:690e:155c:10b0:65c:6ffb:3023 with SMTP id
 956f58d0204a3-65e226bb1b7mr12444291d50.23.1779106244251; Mon, 18 May 2026
 05:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <20260516-jorth-syncobj-v1-12-88ede9d98a81@gmail.com>
 <8602a990-e557-45e3-8b3a-f9e6aaa00e0d@amd.com>
In-Reply-To: <8602a990-e557-45e3-8b3a-f9e6aaa00e0d@amd.com>
From: Julian Orth <ju.orth@gmail.com>
Date: Mon, 18 May 2026 14:10:33 +0200
X-Gm-Features: AVHnY4KBdbjPR5hSqE8jo8_fs1XgRZ0tFr-EnGkZE_KQTZ7MkglkOsUr24e-C_c
Message-ID: <CAHijbEVvLKki2tx_2xZQTPK2zxaGyj8GxKGf0-Xmtf45-YE7SQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] misc/syncobj: add new device
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

On Mon, May 18, 2026 at 2:06=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/16/26 13:06, Julian Orth wrote:
> > This device makes the DRM_IOCTL_SYNCOBJ_* ioctls available via a
> > dedicated device. This allows applications to use syncobjs without
> > having to open device nodes in /dev/dri, on systems that don't have any
> > such nodes, or on systems whose devices don't support the
> > DRIVER_SYNCOBJ_TIMELINE feature.
> >
> > Wayland uses syncobjs as its buffer synchronization mechanism. Most
> > compositors use the DRM_IOCTL_SYNCOBJ_EVENTFD ioctl to perform a pure
> > CPU wait for syncobj point. DRM devices are not involved in this proces=
s
> > except insofar that a DRM device needs to be used to access the ioctl.
> >
> > Similarly, a software-rendered client might perform rendering on a
> > dedicated thread and use the wayland syncobj protocol to submit frames
> > before they finish rendering. Again, this does not involve DRM devices
> > except insofar ... as above.
>
> That use case is invalid.
>
> Usually drm_syncobj can only be filled with dma_fence objects and it is i=
mpossible to create one of those for software rendering.

That is simply not true. As I wrote above,
DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL can be used with software rendering.

>
> What could be used is the drm_syncobj wait before signal functionality, b=
ut that usually requires special handling on the Wayland/Compositor side wh=
ich as far as I can see doesn't make sense here either.

Commit (to wayland) before submit (rendering work) is fully supported
by the wayland syncobj protocol. No work needs to be done on the
wayland side. In fact, everything that this series enables can already
be done today by opening random /dev/dri nodes until you find one that
supports the syncobj timeline ioctls. This series just makes it
easier.

>
> So the justification to use this for software rendering is very weak. Eit=
her I'm missing something or that is not going to fly at all.
>
> Regards,
> Christian.
>
> >
> > As an added benefit, this device removes the need to translate between
> > file descriptors and handles.
> >
> > Signed-off-by: Julian Orth <ju.orth@gmail.com>
> > ---
> >  Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
> >  drivers/misc/Kconfig                               |  10 +
> >  drivers/misc/Makefile                              |   1 +
> >  drivers/misc/syncobj.c                             | 404 +++++++++++++=
++++++++
> >  include/uapi/linux/syncobj.h                       |  75 ++++
> >  5 files changed, 491 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Docum=
entation/userspace-api/ioctl/ioctl-number.rst
> > index 331223761fff..5e140ae5735e 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -395,6 +395,7 @@ Code  Seq#    Include File                         =
                    Comments
> >                                                                        =
 <mailto:michael.klein@puffin.lb.shuttle.de>
> >  0xCC  00-0F  drivers/misc/ibmvmc.h                                    =
 pseries VMC driver
> >  0xCD  01     linux/reiserfs_fs.h                                      =
 Dead since 6.13
> > +0xCD  00-0F  uapi/linux/syncobj.h
> >  0xCE  01-02  uapi/linux/cxl_mem.h                                     =
 Compute Express Link Memory Devices
> >  0xCF  02     fs/smb/client/cifs_ioctl.h
> >  0xDD  00-3F                                                           =
 ZFCP device driver see drivers/s390/scsi/
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 00683bf06258..c1e7749bd356 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -644,6 +644,16 @@ config MCHP_LAN966X_PCI
> >           - lan966x-miim (MDIO_MSCC_MIIM)
> >           - lan966x-switch (LAN966X_SWITCH)
> >
> > +config SYNCOBJ_DEV
> > +     tristate "DRM syncobj device (/dev/syncobj)"
> > +     depends on DRM
> > +     help
> > +       Creates a /dev/syncobj device node that provides DRM synchroniz=
ation
> > +       objects (syncobjs) without requiring a DRM device.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called syncobj.
> > +
> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index b32a2597d246..9e5deb1d0d76 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -75,3 +75,4 @@ obj-$(CONFIG_MCHP_LAN966X_PCI)      +=3D lan966x-pci.=
o
> >  obj-y                                +=3D keba/
> >  obj-y                                +=3D amd-sbi/
> >  obj-$(CONFIG_MISC_RP1)               +=3D rp1/
> > +obj-$(CONFIG_SYNCOBJ_DEV)    +=3D syncobj.o
> > diff --git a/drivers/misc/syncobj.c b/drivers/misc/syncobj.c
> > new file mode 100644
> > index 000000000000..11ef46ddfeef
> > --- /dev/null
> > +++ b/drivers/misc/syncobj.c
> > @@ -0,0 +1,404 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * syncobj.c - Standalone device for syncobj manipulation.
> > + *
> > + * Copyright (C) 2026 Julian Orth <ju.orth@gmail.com>
> > + */
> > +
> > +#include <linux/fdtable.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/module.h>
> > +#include <linux/uaccess.h>
> > +#include <drm/drm_syncobj.h>
> > +#include <drm/drm_utils.h>
> > +#include <uapi/drm/drm.h>
> > +#include <uapi/linux/syncobj.h>
> > +
> > +static int syncobj_array_find(void __user *user_fds, u32 count,
> > +                           struct drm_syncobj ***syncobjs_out)
> > +{
> > +     u32 i;
> > +     s32 *fds;
> > +     struct drm_syncobj **syncobjs;
> > +     int ret;
> > +
> > +     fds =3D kmalloc_array(count, sizeof(*fds), GFP_KERNEL);
> > +     if (!fds)
> > +             return -ENOMEM;
> > +
> > +     if (copy_from_user(fds, user_fds, sizeof(s32) * count)) {
> > +             ret =3D -EFAULT;
> > +             goto err_free_fds;
> > +     }
> > +
> > +     syncobjs =3D kmalloc_array(count, sizeof(*syncobjs), GFP_KERNEL);
> > +     if (!syncobjs) {
> > +             ret =3D -ENOMEM;
> > +             goto err_free_fds;
> > +     }
> > +
> > +     for (i =3D 0; i < count; i++) {
> > +             syncobjs[i] =3D drm_syncobj_from_fd(fds[i]);
> > +             if (!syncobjs[i]) {
> > +                     ret =3D -EBADF;
> > +                     goto err_put_syncobjs;
> > +             }
> > +     }
> > +
> > +     kfree(fds);
> > +     *syncobjs_out =3D syncobjs;
> > +     return 0;
> > +
> > +err_put_syncobjs:
> > +     while (i-- > 0)
> > +             drm_syncobj_put(syncobjs[i]);
> > +     kfree(syncobjs);
> > +err_free_fds:
> > +     kfree(fds);
> > +     return ret;
> > +}
> > +
> > +static void syncobj_array_free(struct drm_syncobj **syncobjs, u32 coun=
t)
> > +{
> > +     u32 i;
> > +
> > +     for (i =3D 0; i < count; i++)
> > +             drm_syncobj_put(syncobjs[i]);
> > +     kfree(syncobjs);
> > +}
> > +
> > +static int syncobj_ioctl_create(void __user *argp)
> > +{
> > +     struct syncobj_create_args args;
> > +     struct drm_syncobj *syncobj;
> > +     int fd, ret;
> > +
> > +     if (copy_from_user(&args, argp, sizeof(args)))
> > +             return -EFAULT;
> > +
> > +     if (args.flags & ~SYNCOBJ_CREATE_SIGNALED)
> > +             return -EINVAL;
> > +
> > +     static_assert(SYNCOBJ_CREATE_SIGNALED =3D=3D DRM_SYNCOBJ_CREATE_S=
IGNALED);
> > +
> > +     ret =3D drm_syncobj_create(&syncobj, args.flags, NULL);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D drm_syncobj_get_fd(syncobj, &fd);
> > +     drm_syncobj_put(syncobj);
> > +     if (ret)
> > +             return ret;
> > +
> > +     args.fd =3D fd;
> > +     if (copy_to_user(argp, &args, sizeof(args))) {
> > +             close_fd(fd);
> > +             return -EFAULT;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int syncobj_ioctl_wait(void __user *argp)
> > +{
> > +     struct syncobj_wait_args args;
> > +     struct drm_syncobj **syncobjs;
> > +     signed long timeout;
> > +     u32 first =3D ~0;
> > +     ktime_t t, *tp =3D NULL;
> > +     int ret;
> > +
> > +     if (copy_from_user(&args, argp, sizeof(args)))
> > +             return -EFAULT;
> > +
> > +     if (args.flags & ~(SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
> > +                        SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
> > +                        SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE |
> > +                        SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE))
> > +             return -EINVAL;
> > +
> > +     static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_ALL        =3D=3D DRM_SYNCO=
BJ_WAIT_FLAGS_WAIT_ALL);
> > +     static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT =3D=3D DRM_SYNCO=
BJ_WAIT_FLAGS_WAIT_FOR_SUBMIT);
> > +     static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE  =3D=3D DRM_SYNCO=
BJ_WAIT_FLAGS_WAIT_AVAILABLE);
> > +     static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE   =3D=3D DRM_SYNCO=
BJ_WAIT_FLAGS_WAIT_DEADLINE);
> > +
> > +     if (args.pad)
> > +             return -EINVAL;
> > +
> > +     if (args.count =3D=3D 0)
> > +             return 0;
> > +
> > +     ret =3D syncobj_array_find(u64_to_user_ptr(args.fds),
> > +                              args.count, &syncobjs);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (args.flags & SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE) {
> > +             t =3D ns_to_ktime(args.deadline_nsec);
> > +             tp =3D &t;
> > +     }
> > +
> > +     timeout =3D drm_timeout_abs_to_jiffies(args.timeout_nsec);
> > +     timeout =3D drm_syncobj_array_wait_timeout(syncobjs,
> > +                                              u64_to_user_ptr(args.poi=
nts),
> > +                                              args.count,
> > +                                              args.flags,
> > +                                              timeout, &first, tp);
> > +
> > +     syncobj_array_free(syncobjs, args.count);
> > +
> > +     if (timeout < 0)
> > +             return timeout;
> > +
> > +     args.first_signaled =3D first;
> > +     if (copy_to_user(argp, &args, sizeof(args)))
> > +             return -EFAULT;
> > +
> > +     return 0;
> > +}
> > +
> > +static int syncobj_ioctl_reset(void __user *argp)
> > +{
> > +     struct syncobj_array_args args;
> > +     struct drm_syncobj **syncobjs;
> > +     u32 i;
> > +     int ret;
> > +
> > +     if (copy_from_user(&args, argp, sizeof(args)))
> > +             return -EFAULT;
> > +
> > +     if (args.flags)
> > +             return -EINVAL;
> > +
> > +     if (args.points)
> > +             return -EINVAL;
> > +
> > +     if (args.count =3D=3D 0)
> > +             return -EINVAL;
> > +
> > +     ret =3D syncobj_array_find(u64_to_user_ptr(args.fds),
> > +                              args.count, &syncobjs);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     for (i =3D 0; i < args.count; i++)
> > +             drm_syncobj_replace_fence(syncobjs[i], NULL);
> > +
> > +     syncobj_array_free(syncobjs, args.count);
> > +     return 0;
> > +}
> > +
> > +static int syncobj_ioctl_signal(void __user *argp)
> > +{
> > +     struct syncobj_array_args args;
> > +     struct drm_syncobj **syncobjs;
> > +     int ret;
> > +
> > +     if (copy_from_user(&args, argp, sizeof(args)))
> > +             return -EFAULT;
> > +
> > +     if (args.flags)
> > +             return -EINVAL;
> > +
> > +     if (args.count =3D=3D 0)
> > +             return -EINVAL;
> > +
> > +     ret =3D syncobj_array_find(u64_to_user_ptr(args.fds),
> > +                              args.count, &syncobjs);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D drm_syncobj_timeline_signal(syncobjs, args.points, args.c=
ount);
> > +
> > +     syncobj_array_free(syncobjs, args.count);
> > +     return ret;
> > +}
> > +
> > +static int syncobj_ioctl_query(void __user *argp)
> > +{
> > +     struct syncobj_array_args args;
> > +     struct drm_syncobj **syncobjs;
> > +     int ret;
> > +
> > +     if (copy_from_user(&args, argp, sizeof(args)))
> > +             return -EFAULT;
> > +
> > +     if (args.flags & ~SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED)
> > +             return -EINVAL;
> > +
> > +     static_assert(SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED =3D=3D DRM_SYNCO=
BJ_QUERY_FLAGS_LAST_SUBMITTED);
> > +
> > +     if (args.count =3D=3D 0)
> > +             return -EINVAL;
> > +
> > +     ret =3D syncobj_array_find(u64_to_user_ptr(args.fds),
> > +                              args.count, &syncobjs);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D drm_syncobj_query(syncobjs, args.points, args.count, args=
.flags);
> > +
> > +     syncobj_array_free(syncobjs, args.count);
> > +     return ret;
> > +}
> > +
> > +static int syncobj_ioctl_transfer(void __user *argp)
> > +{
> > +     struct syncobj_transfer_args args;
> > +     struct drm_syncobj *src, *dst;
> > +     int ret;
> > +
> > +     if (copy_from_user(&args, argp, sizeof(args)))
> > +             return -EFAULT;
> > +
> > +     if (args.pad)
> > +             return -EINVAL;
> > +
> > +     if (args.flags & ~SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
> > +             return -EINVAL;
> > +
> > +     static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT =3D=3D DRM_SYNCO=
BJ_WAIT_FLAGS_WAIT_FOR_SUBMIT);
> > +
> > +     src =3D drm_syncobj_from_fd(args.src_fd);
> > +     if (!src)
> > +             return -EBADF;
> > +
> > +     dst =3D drm_syncobj_from_fd(args.dst_fd);
> > +     if (!dst) {
> > +             drm_syncobj_put(src);
> > +             return -EBADF;
> > +     }
> > +
> > +     ret =3D drm_syncobj_transfer(src, args.src_point,
> > +                                dst, args.dst_point, args.flags);
> > +
> > +     drm_syncobj_put(dst);
> > +     drm_syncobj_put(src);
> > +
> > +     return ret;
> > +}
> > +
> > +static int syncobj_ioctl_eventfd(void __user *argp)
> > +{
> > +     struct syncobj_eventfd_args args;
> > +     struct drm_syncobj *syncobj;
> > +     int ret;
> > +
> > +     if (copy_from_user(&args, argp, sizeof(args)))
> > +             return -EFAULT;
> > +
> > +     if (args.flags & ~SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)
> > +             return -EINVAL;
> > +
> > +     static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE =3D=3D DRM_SYNCOB=
J_WAIT_FLAGS_WAIT_AVAILABLE);
> > +
> > +     if (args.pad)
> > +             return -EINVAL;
> > +
> > +     syncobj =3D drm_syncobj_from_fd(args.syncobj_fd);
> > +     if (!syncobj)
> > +             return -EBADF;
> > +
> > +     ret =3D drm_syncobj_register_eventfd(syncobj, args.eventfd,
> > +                                        args.point, args.flags);
> > +
> > +     drm_syncobj_put(syncobj);
> > +
> > +     return ret;
> > +}
> > +
> > +static int syncobj_ioctl_export_sync_file(void __user *argp)
> > +{
> > +     struct syncobj_sync_file_args args;
> > +     struct drm_syncobj *syncobj;
> > +     int ret;
> > +
> > +     if (copy_from_user(&args, argp, sizeof(args)))
> > +             return -EFAULT;
> > +
> > +     syncobj =3D drm_syncobj_from_fd(args.syncobj_fd);
> > +     if (!syncobj)
> > +             return -EBADF;
> > +
> > +     ret =3D drm_syncobj_export_sync_file(syncobj, args.point,
> > +                                        &args.sync_file_fd);
> > +     drm_syncobj_put(syncobj);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (copy_to_user(argp, &args, sizeof(args))) {
> > +             close_fd(args.sync_file_fd);
> > +             return -EFAULT;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int syncobj_ioctl_import_sync_file(void __user *argp)
> > +{
> > +     struct syncobj_sync_file_args args;
> > +     struct drm_syncobj *syncobj;
> > +     int ret;
> > +
> > +     if (copy_from_user(&args, argp, sizeof(args)))
> > +             return -EFAULT;
> > +
> > +     syncobj =3D drm_syncobj_from_fd(args.syncobj_fd);
> > +     if (!syncobj)
> > +             return -EBADF;
> > +
> > +     ret =3D drm_syncobj_import_sync_file(syncobj, args.sync_file_fd,
> > +                                        args.point);
> > +
> > +     drm_syncobj_put(syncobj);
> > +
> > +     return ret;
> > +}
> > +
> > +static long syncobj_dev_ioctl(struct file *file, unsigned int cmd,
> > +                           unsigned long arg)
> > +{
> > +     void __user *argp =3D (void __user *)arg;
> > +
> > +     switch (cmd) {
> > +     case SYNCOBJ_IOC_CREATE:
> > +             return syncobj_ioctl_create(argp);
> > +     case SYNCOBJ_IOC_WAIT:
> > +             return syncobj_ioctl_wait(argp);
> > +     case SYNCOBJ_IOC_RESET:
> > +             return syncobj_ioctl_reset(argp);
> > +     case SYNCOBJ_IOC_SIGNAL:
> > +             return syncobj_ioctl_signal(argp);
> > +     case SYNCOBJ_IOC_QUERY:
> > +             return syncobj_ioctl_query(argp);
> > +     case SYNCOBJ_IOC_TRANSFER:
> > +             return syncobj_ioctl_transfer(argp);
> > +     case SYNCOBJ_IOC_EVENTFD:
> > +             return syncobj_ioctl_eventfd(argp);
> > +     case SYNCOBJ_IOC_EXPORT_SYNC_FILE:
> > +             return syncobj_ioctl_export_sync_file(argp);
> > +     case SYNCOBJ_IOC_IMPORT_SYNC_FILE:
> > +             return syncobj_ioctl_import_sync_file(argp);
> > +     default:
> > +             return -ENOIOCTLCMD;
> > +     }
> > +}
> > +
> > +static const struct file_operations syncobj_dev_fops =3D {
> > +     .owner          =3D THIS_MODULE,
> > +     .unlocked_ioctl =3D syncobj_dev_ioctl,
> > +     .compat_ioctl   =3D compat_ptr_ioctl,
> > +};
> > +
> > +static struct miscdevice syncobj_misc =3D {
> > +     .minor  =3D MISC_DYNAMIC_MINOR,
> > +     .name   =3D "syncobj",
> > +     .fops   =3D &syncobj_dev_fops,
> > +     .mode   =3D 0666,
> > +};
> > +
> > +module_misc_device(syncobj_misc);
> > +
> > +MODULE_AUTHOR("Julian Orth");
> > +MODULE_DESCRIPTION("DRM syncobj device");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/uapi/linux/syncobj.h b/include/uapi/linux/syncobj.=
h
> > new file mode 100644
> > index 000000000000..c4068fbd5773
> > --- /dev/null
> > +++ b/include/uapi/linux/syncobj.h
> > @@ -0,0 +1,75 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> > +#ifndef _UAPI_LINUX_SYNCOBJ_H_
> > +#define _UAPI_LINUX_SYNCOBJ_H_
> > +
> > +#include <linux/ioctl.h>
> > +#include <linux/types.h>
> > +
> > +#define SYNCOBJ_CREATE_SIGNALED                      (1 << 0)
> > +
> > +#define SYNCOBJ_WAIT_FLAGS_WAIT_ALL          (1 << 0)
> > +#define SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT   (1 << 1)
> > +#define SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE    (1 << 2)
> > +#define SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE     (1 << 3)
> > +
> > +#define SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED   (1 << 0)
> > +
> > +struct syncobj_create_args {
> > +     __s32 fd;
> > +     __u32 flags;
> > +};
> > +
> > +struct syncobj_wait_args {
> > +     __u64 fds;
> > +     __u64 points;
> > +     __s64 timeout_nsec;
> > +     __u32 count;
> > +     __u32 flags;
> > +     __u32 first_signaled;
> > +     __u32 pad;
> > +     __u64 deadline_nsec;
> > +};
> > +
> > +struct syncobj_array_args {
> > +     __u64 fds;
> > +     __u64 points;
> > +     __u32 count;
> > +     __u32 flags;
> > +};
> > +
> > +struct syncobj_transfer_args {
> > +     __s32 src_fd;
> > +     __s32 dst_fd;
> > +     __u64 src_point;
> > +     __u64 dst_point;
> > +     __u32 flags;
> > +     __u32 pad;
> > +};
> > +
> > +struct syncobj_eventfd_args {
> > +     __s32 syncobj_fd;
> > +     __s32 eventfd;
> > +     __u64 point;
> > +     __u32 flags;
> > +     __u32 pad;
> > +};
> > +
> > +struct syncobj_sync_file_args {
> > +     __s32 syncobj_fd;
> > +     __s32 sync_file_fd;
> > +     __u64 point;
> > +};
> > +
> > +#define SYNCOBJ_IOC_BASE             0xCD
> > +
> > +#define SYNCOBJ_IOC_CREATE           _IOWR(SYNCOBJ_IOC_BASE, 0, struct=
 syncobj_create_args)
> > +#define SYNCOBJ_IOC_WAIT             _IOWR(SYNCOBJ_IOC_BASE, 1, struct=
 syncobj_wait_args)
> > +#define SYNCOBJ_IOC_RESET            _IOW(SYNCOBJ_IOC_BASE,  2, struct=
 syncobj_array_args)
> > +#define SYNCOBJ_IOC_SIGNAL           _IOW(SYNCOBJ_IOC_BASE,  3, struct=
 syncobj_array_args)
> > +#define SYNCOBJ_IOC_QUERY            _IOW(SYNCOBJ_IOC_BASE,  4, struct=
 syncobj_array_args)
> > +#define SYNCOBJ_IOC_TRANSFER         _IOW(SYNCOBJ_IOC_BASE,  5, struct=
 syncobj_transfer_args)
> > +#define SYNCOBJ_IOC_EVENTFD          _IOW(SYNCOBJ_IOC_BASE,  6, struct=
 syncobj_eventfd_args)
> > +#define SYNCOBJ_IOC_EXPORT_SYNC_FILE _IOWR(SYNCOBJ_IOC_BASE, 7, struct=
 syncobj_sync_file_args)
> > +#define SYNCOBJ_IOC_IMPORT_SYNC_FILE _IOW(SYNCOBJ_IOC_BASE,  8, struct=
 syncobj_sync_file_args)
> > +
> > +#endif /* _UAPI_LINUX_SYNCOBJ_H_ */
> >
>
