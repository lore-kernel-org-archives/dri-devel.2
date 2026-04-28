Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A40AFF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 20:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C4410E38A;
	Tue, 28 Apr 2026 20:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fdiA/DKN";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C51910E38A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 20:59:42 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12dca45c95fso239682c88.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777409982; cv=none;
 d=google.com; s=arc-20240605;
 b=XWxJT44eJyYk4x7Dub14T4KNkpOzgwniQTP8/YiIw2d1JlxQnvPi/SNlqs5siWeWKw
 gOJhAcYWqUJxyvG59yRSAwqXpg0XFK2zQeHfhCRm/Pj3X2uDbxALMqpaqAZKSb3POuvV
 fUsTyT1XG5dRiiRFjeziwkS3Mz9o78AIHiTNf2Sujf5/SYf3mzVkhTz0h5GEgxgSrrPc
 ccgrU8m/XBAS+xP6qkgD2lBcuSjzkxhblYtkrYjVOY/fCvl4SPbwxeuCHUd2uyL2obKt
 YiYH10PZod0W4pjK46ykeX6ks7ubkdJl1Iuf+fp1cMmbz38Mkz4iRde7CV9y3bGMPeid
 esPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Dd2PviXpTrO61GEMEfbf5WqfAv6KopI9Qa5OnOzf8yg=;
 fh=FPtcM82pMRML9g2dXQrSOrRt6qRU/s8k33WKcwOmmdw=;
 b=V8xZFA7mtxTnokvveCl1h7XSIajPrFbaqngKo0uocxj88QbKsfrjIS7DE2WT46y6p0
 NUvAZufZRQ0RJNxPqT2ruFdB70FwtgdYrkEUWYSAmiUB+10byrtByhw8QJKzHQZE6TXy
 RMJcGOBtu7fkMBbmSZ8TeoAIqOdJ6Dwleo0v6maXrvxZZtX30UhYo2oIzynSW7ASpbg0
 ikMunsKIZY/ID8sxsKfjjLwoRFfxhrScDpC10Cyq5ohR6owxOSJ5jOygHaLWL+mzaSVR
 +qt9AF4UU5ClRs039lvkH/XwZZPOkrlrrVkqKfev5FBTzLWlcMvdy8d4nci9N2Hd/+NQ
 2TIQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777409982; x=1778014782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dd2PviXpTrO61GEMEfbf5WqfAv6KopI9Qa5OnOzf8yg=;
 b=fdiA/DKNOyxjk/C6KuoJx/sZ6X3zGHUT2KCAH8UtzakvELRwJwk7yK0waMQT689L3z
 oe4eS0K4F4uoRZdDw/dvgkiH56z0rzmZ+/Cg6s/o7JeNdGczBwvQe7pobUen5WkP7m2x
 LDgY0JZVIIuQlrWrLtw9Df84tqT/VguPRGwrKGPzxw6wxspolIXHuVa4mKLRJeJbCLnC
 +bhS0T9qFKm4CK3V3KAvLiIqWxPOLcOzZEWAH7No0eRBitVmnBqye4Vr7ZhbEiEBjkXf
 GWEyZujYD7yy4R9UZYLBD4E8b+M8QEuK95kvg9m3Uy2FXnRQZkIIcV16uxibT+VsCET3
 tsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777409982; x=1778014782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dd2PviXpTrO61GEMEfbf5WqfAv6KopI9Qa5OnOzf8yg=;
 b=PhecSCZqyNWr7b9NbZf1WQw+NaTSAvFJ6CcR9EPTbALSofmMuuFoMlk7gILwUKDdg+
 4CQfjbi44Niud0vJElajb8gOzJQbI9Yp91Z8CxMAj/TpxyPejjnz93keIHXW2F/PksHc
 UErvmZ6zbcpGxzHK7VQfni2eVEeOdLkn9PISgfKqoB3yFR67HnmoBRKarIn5UKUanMQP
 qu94YYfkUzNB9Zq/n12jzOJ7/yAPcqLl65Rlp2yD3sIPfY3WJNheVkYw8lDphjfgq2Nd
 rTWR7bm14Lg3pW7Xxkuiw6ONtVvzqWzI5ZuXQVD5HtgRbDvyacgFLnRLLKz0Qu8Xmdlo
 e96w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RVAB4EOIBf5P3wN8eahBLLV7jBAxw7iNFc44xZxH8HpBLn7cQNKUuNbc5Enp8362LAqaLGc+qqwU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxS6LUB9YCscwFlQkZSYwwJhw9yeuctY5+y14SuO5+EfUEFkupS
 epRI4OJIdv6kDRnxnuikZfUFfFY+3dUvWlSG5Cwpm9b9rmKC8KxeQIDWkT83NsX1mu0U3sCyusv
 VdJg+/qLj2QLaRpoihKR4L9B83b4DIoU=
X-Gm-Gg: AeBDievmIYlSRiXNbADwNYVqD/hrWCZy7cDEq4NZ9W/Ydr2nOewU3qavgk0OSe2T/Z/
 k3buB31FRTR3tHEmXawtVllwuUkcZ71/3uU7P/RzxQgkAgoEPKFPvLJIo4NiUs7JiazZURqMGaJ
 L4ilKhEVOiARRVydhh5/ffbhVuEE8zCRx7NmyGNiK9kYA17EXxKnlE3F6+gl710jzgsqusfpYae
 sDfxI0ijOvfYm5I/QZaE6stG6HdQpEl9BU6U2hm9QpHO0peQ9tErgl0WOA/QRqIUmM8DlqHkjVE
 sLn4rs1pI/yUZFlrLK3fg9+Gfca5+8B4cw3rNua+3x/d+4YK/cNY3p1GeFQrFuInZiug8qnbuYA
 4/tW5
X-Received: by 2002:a05:7022:6290:b0:128:e6e2:0 with SMTP id
 a92af1059eb24-12ddd54e7d0mr1034535c88.6.1777409981634; Tue, 28 Apr 2026
 13:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260427183854.672967-1-rdunlap@infradead.org>
 <9ad1c4bd-6f12-41b6-b6a0-979a0de32e16@amd.com>
In-Reply-To: <9ad1c4bd-6f12-41b6-b6a0-979a0de32e16@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Apr 2026 16:59:29 -0400
X-Gm-Features: AVHnY4Kc4F9tFfSbmQ-2NALAJAvwPREYCp2svP_K4DjkjWDSZGPqhSdOB4c-VgA
Message-ID: <CADnq5_OSHYyEgpZzMjUzQX804a=zb3DPkkn1J3R-Q5W70_QLrQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: amdgpu{_reset}.h: fix all kernel-doc
 warnings
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
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

Applied.  Thanks!

On Mon, Apr 27, 2026 at 3:09=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 4/27/26 20:38, Randy Dunlap wrote:
> > Fix all kernel-doc warnings in amdgpu.h and amdgpu_reset.h:
> > - Use the struct keyword for kernel-doc struct comments.
> > - Use the correct enum names in enum amd_reset_method.
> >
> > This eliminates these warnings:
> >
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:477 cannot understand
> >  function prototype: 'struct amdgpu_wb'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
> >  'AMD_RESET_METHOD_LEGACY' not described in enum 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
> >  'AMD_RESET_METHOD_MODE0' not described in enum 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
> >  'AMD_RESET_METHOD_MODE1' not described in enum 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
> >  'AMD_RESET_METHOD_MODE2' not described in enum 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
> >  'AMD_RESET_METHOD_LINK' not described in enum 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
> >  'AMD_RESET_METHOD_BACO' not described in enum 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
> >  'AMD_RESET_METHOD_PCI' not described in enum 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
> >  'AMD_RESET_METHOD_ON_INIT' not described in enum 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
> >  '@AMD_RESET_LEGACY' description in 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
> >  '@AMD_RESET_MODE0' description in 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
> >  '@AMD_RESET_MODE1' description in 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
> >  '@AMD_RESET_MODE2' description in 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
> >  '@AMD_RESET_LINK' description in 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
> >  '@AMD_RESET_BACO' description in 'amd_reset_method'
> > Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
> >  '@AMD_RESET_PCI' description in 'amd_reset_method'
> >
> > Also move the enum to amdgpu_reset.h and eventually only forward declar=
e
> > it in amdgpu.h. (Christian)
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > v2: I moved the enum to amdgpu_reset.h and then #included amdgpu_reset.=
h
> >     in amdgpu.h. The simpler method causes build errors.
> > v3: rebase and resend
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   42 ------------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |   69 +++++++++++++++-----
> >  2 files changed, 58 insertions(+), 53 deletions(-)
> >
> > --- linux-next-20260427.orig/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ linux-next-20260427/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -464,7 +464,7 @@ int amdgpu_file_to_fpriv(struct file *fi
> >  #define AMDGPU_MAX_WB 1024   /* Reserve at most 1024 WB slots for amdg=
pu-owned rings. */
> >
> >  /**
> > - * amdgpu_wb - This struct is used for small GPU memory allocation.
> > + * struct amdgpu_wb - This struct is used for small GPU memory allocat=
ion.
> >   *
> >   * This struct is used to allocate a small amount of GPU memory that c=
an be
> >   * used to shadow certain states into the memory. This is especially u=
seful for
> > @@ -538,44 +538,6 @@ struct amdgpu_allowed_register_entry {
> >       bool grbm_indexed;
> >  };
> >
> > -/**
> > - * enum amd_reset_method - Methods for resetting AMD GPU devices
> > - *
> > - * @AMD_RESET_METHOD_NONE: The device will not be reset.
> > - * @AMD_RESET_LEGACY: Method reserved for SI, CIK and VI ASICs.
> > - * @AMD_RESET_MODE0: Reset the entire ASIC. Not currently available fo=
r the
> > - *                   any device.
> > - * @AMD_RESET_MODE1: Resets all IP blocks on the ASIC (SDMA, GFX, VCN,=
 etc.)
> > - *                   individually. Suitable only for some discrete GPU=
, not
> > - *                   available for all ASICs.
> > - * @AMD_RESET_MODE2: Resets a lesser level of IPs compared to MODE1. W=
hich IPs
> > - *                   are reset depends on the ASIC. Notably doesn't re=
set IPs
> > - *                   shared with the CPU on APUs or the memory control=
lers (so
> > - *                   VRAM is not lost). Not available on all ASICs.
> > - * @AMD_RESET_LINK: Triggers SW-UP link reset on other GPUs
> > - * @AMD_RESET_BACO: BACO (Bus Alive, Chip Off) method powers off and o=
n the card
> > - *                  but without powering off the PCI bus. Suitable onl=
y for
> > - *                  discrete GPUs.
> > - * @AMD_RESET_PCI: Does a full bus reset using core Linux subsystem PC=
I reset
> > - *                 and does a secondary bus reset or FLR, depending on=
 what the
> > - *                 underlying hardware supports.
> > - *
> > - * Methods available for AMD GPU driver for resetting the device. Not =
all
> > - * methods are suitable for every device. User can override the method=
 using
> > - * module parameter `reset_method`.
> > - */
> > -enum amd_reset_method {
> > -     AMD_RESET_METHOD_NONE =3D -1,
> > -     AMD_RESET_METHOD_LEGACY =3D 0,
> > -     AMD_RESET_METHOD_MODE0,
> > -     AMD_RESET_METHOD_MODE1,
> > -     AMD_RESET_METHOD_MODE2,
> > -     AMD_RESET_METHOD_LINK,
> > -     AMD_RESET_METHOD_BACO,
> > -     AMD_RESET_METHOD_PCI,
> > -     AMD_RESET_METHOD_ON_INIT,
> > -};
> > -
> >  struct amdgpu_video_codec_info {
> >       u32 codec_type;
> >       u32 max_width;
> > @@ -1373,6 +1335,8 @@ int emu_soc_asic_init(struct amdgpu_devi
> >  #define RBIOS16(i) (RBIOS8(i) | (RBIOS8((i)+1) << 8))
> >  #define RBIOS32(i) ((RBIOS16(i)) | (RBIOS16((i)+2) << 16))
> >
> > +#include "amdgpu_reset.h"
> > +
> >  /*
> >   * ASICs macro.
> >   */
> > --- linux-next-20260427.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> > +++ linux-next-20260427/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> > @@ -46,6 +46,47 @@ enum AMDGPU_RESET_SRCS {
> >       AMDGPU_RESET_SRC_USERQ,
> >  };
> >
> > +/**
> > + * enum amd_reset_method - Methods for resetting AMD GPU devices
> > + *
> > + * @AMD_RESET_METHOD_NONE: The device will not be reset.
> > + * @AMD_RESET_METHOD_LEGACY: Method reserved for SI, CIK and VI ASICs.
> > + * @AMD_RESET_METHOD_MODE0: Reset the entire ASIC. Not currently avail=
able for
> > + *                          the any device.
> > + * @AMD_RESET_METHOD_MODE1: Resets all IP blocks on the ASIC (SDMA, GF=
X, VCN,
> > + *                   etc.) individually. Suitable only for some discre=
te GPU,
> > + *                   not available for all ASICs.
> > + * @AMD_RESET_METHOD_MODE2: Resets a lesser level of IPs compared to M=
ODE1.
> > + *                   Which IPs are reset depends on the ASIC. Notably =
doesn't
> > + *                   reset IPs shared with the CPU on APUs or the memo=
ry
> > + *                   controllers (so VRAM is not lost). Not available =
on all
> > + *                   ASICs.
> > + * @AMD_RESET_METHOD_LINK: Triggers SW-UP link reset on other GPUs
> > + * @AMD_RESET_METHOD_BACO: BACO (Bus Alive, Chip Off) method powers of=
f and on
> > + *                   the card but without powering off the PCI bus. Su=
itable
> > + *                   only for discrete GPUs.
> > + * @AMD_RESET_METHOD_PCI: Does a full bus reset using core Linux subsy=
stem
> > + *                   PCI reset and does a secondary bus reset or FLR,
> > + *                   depending on what the underlying hardware support=
s.
> > + * @AMD_RESET_METHOD_ON_INIT: Does a device reset during the driver in=
it
> > + *                   sequence.
> > + *
> > + * Methods available for AMD GPU driver for resetting the device. Not =
all
> > + * methods are suitable for every device. User can override the method=
 using
> > + * module parameter `reset_method`.
> > + */
> > +enum amd_reset_method {
> > +     AMD_RESET_METHOD_NONE =3D -1,
> > +     AMD_RESET_METHOD_LEGACY =3D 0,
> > +     AMD_RESET_METHOD_MODE0,
> > +     AMD_RESET_METHOD_MODE1,
> > +     AMD_RESET_METHOD_MODE2,
> > +     AMD_RESET_METHOD_LINK,
> > +     AMD_RESET_METHOD_BACO,
> > +     AMD_RESET_METHOD_PCI,
> > +     AMD_RESET_METHOD_ON_INIT,
> > +};
> > +
> >  struct amdgpu_reset_context {
> >       enum amd_reset_method method;
> >       struct amdgpu_device *reset_req_dev;
> > @@ -56,6 +97,20 @@ struct amdgpu_reset_context {
> >       enum AMDGPU_RESET_SRCS src;
> >  };
> >
> > +struct amdgpu_reset_control {
> > +     void *handle;
> > +     struct work_struct reset_work;
> > +     struct mutex reset_lock;
> > +     struct amdgpu_reset_handler *(
> > +             *reset_handlers)[AMDGPU_RESET_MAX_HANDLERS];
> > +     atomic_t in_reset;
> > +     enum amd_reset_method active_reset;
> > +     struct amdgpu_reset_handler *(*get_reset_handler)(
> > +             struct amdgpu_reset_control *reset_ctl,
> > +             struct amdgpu_reset_context *context);
> > +     void (*async_reset)(struct work_struct *work);
> > +};
> > +
> >  struct amdgpu_reset_handler {
> >       enum amd_reset_method reset_method;
> >       int (*prepare_env)(struct amdgpu_reset_control *reset_ctl,
> > @@ -72,20 +127,6 @@ struct amdgpu_reset_handler {
> >       int (*do_reset)(struct amdgpu_device *adev);
> >  };
> >
> > -struct amdgpu_reset_control {
> > -     void *handle;
> > -     struct work_struct reset_work;
> > -     struct mutex reset_lock;
> > -     struct amdgpu_reset_handler *(
> > -             *reset_handlers)[AMDGPU_RESET_MAX_HANDLERS];
> > -     atomic_t in_reset;
> > -     enum amd_reset_method active_reset;
> > -     struct amdgpu_reset_handler *(*get_reset_handler)(
> > -             struct amdgpu_reset_control *reset_ctl,
> > -             struct amdgpu_reset_context *context);
> > -     void (*async_reset)(struct work_struct *work);
> > -};
> > -
> >
> >  enum amdgpu_reset_domain_type {
> >       SINGLE_DEVICE,
>
