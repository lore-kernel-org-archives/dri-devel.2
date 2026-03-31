Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A243DE7E34C
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046CB10F41E;
	Fri,  3 Apr 2026 08:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HwO6u2B5";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16EE810EB9E
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 21:07:55 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-82cd70febc7so1029560b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774991274; cv=none;
 d=google.com; s=arc-20240605;
 b=YYvhEmX/h+KXaCgtwzRolIQeeeIz4oIynJXi0kXMwZq4txdPz3jEfOQcjXXiLOYu+W
 BFJW56NW7OXm2FpWpAuZYZ0NtQCiRdY7oxktsRyucd7WGb2D+8xV5RXhORQmGinsna5y
 ao4YYAAb1yOj2z2pm8+LrgOb02E/LasGGL8uBhxMjCpw7fmpKTQYeWdHPXQ9ms9Y9bKj
 yuBUrzn8J8Fmo+A9/07Zt2g9J4iH9auuTuqMseQK5Q+Aropj7OTDFiiUrIkchBdRuIXL
 YY7yICTU/E81Y9sqjMLkO4xHCiODc7hlXeeHniN+RRmFF0C+5IlubhzBtyYBLVCz3jrd
 a8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LscFjkh+l9ddg4kSso5o+8jXTr2rO8Fq6oEpYPWyUeE=;
 fh=JDAzQwPDG5TCGAr5yNXf248c4c0uuGSOsomLmzQH1to=;
 b=Pqe+gkCqrZXeiPdDASSU2fANdpRKSBlX5i1QxFRC/2/oEfU5vZwS8188g2xIihj/Og
 29ExcXn4mThqxgCypokzuBBHcgMdHS4kEmGcYN9VcGnxIrifx9EPCjajFeiHJdGq1eM5
 xmf7UoNGqYllcf0wLO+vuqUv7OFIlj0WfHSS0e9ATRtHXzutA8l1ZfyvBdvfy5zieneI
 IpS6SM0E8bkCnOqnoHGKVfM42PuTnfkxIf6LvSf1ePLYbbB6e7l0tn5w3k1IOE33xZ0Y
 ESuOqWnjzB42iHaY/+OsYpbYMBG0rkGlqtxZxnGmyX59e8uoSujNX5RqCKQLsRzOv+8Q
 Z3VA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774991274; x=1775596074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LscFjkh+l9ddg4kSso5o+8jXTr2rO8Fq6oEpYPWyUeE=;
 b=HwO6u2B5jX90MqejFbBt1qUZm57IsMs5973cB5ngQRX7OWMxsnB0aYKrk7Kij+DC7+
 FA7FIGfHQqJ4Hac1bWvmEtRIWAey1Ene1Y19xLDplAxwd8KtUbWPI7fzie7zM6YdGqBo
 dvbtwXCd/xv8O98bbnwB3miqLmhIIDhUCHggCnTLphE5LBdWsdUsDu0hdBJAumLA20R4
 r9QV+yVnmdxNc704v76V/W584JKjDegii40vWQWmTSTxKjeTlV5//04aW4hra6Ym86TM
 oPYPB7ivZW7d/8TNQA6Xbdbws263wBCYgjErAgdrXCD52zWYvfFHQYK5092AAbYFp9KW
 shIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774991274; x=1775596074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LscFjkh+l9ddg4kSso5o+8jXTr2rO8Fq6oEpYPWyUeE=;
 b=NIWTFVTd167uhyhXZ7rDA6oK+AOleuellzAfeOr0j5kVd6KYys88ZLtW4lmusmsdYE
 jCwkstKKzSsoYJLiEOtCU2HEszMdIR01Bsp1UQOUhjjeMQzzrIDph9ff67m5CQKWVEbw
 PrPlaffNqpjG2QESLAcxPPRalKwSEuyxPcKYjND3aNXsWh+3PDpQ/4wi+6S4VG+50xd5
 GrnNTocbY8SYRBKcfKQRoYu3OQcEVQ9NmEUt64JfL3uIBjfVS9EHQfK1mjG9UjoOa1Ca
 bSNM5Gf1DXkadrifzmC0JKiJhQwwiwgxnS68qyVRvc3Hgk0EXgGN4B3I8Osjn446YOW3
 s7cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDQu+DliumeKAPUiMP2tP67bGa+WhWkCtHZvOJzcRXQ47qeaDvHwthMNBiCTtzDClO3FOd8XnMytQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3Vfu3V3XjbGtVF8jvT7OWYrJzoGI4PG+gZfL8FNbStptp8bhq
 sOGxULxKIw1n8HOPXLxHoUIdbc1GwxaobaxvKPG5+STDiXHoWwvt7PCivMlDd27Mr7U44to6tda
 g0eO+aRv5nOCtWs9J4K4TkTe6jKQPriM=
X-Gm-Gg: ATEYQzyJbUmIwUCBvoWgXrXkbv6Gzl1/bMh8JJ8yhjCOOcrqpTKcP6ypp+M44Txto2G
 dcp7s4gKKrkAYYswowYNhQ6boVoLwNFlIOz+QP3IdVuqB/KZ1vjVGqTZyqLO97rnheXMP5/QxvI
 lg31y/Ag4A+QVnGsft9qwHSls9WygY7HWuy2W3cfXdsWHyIRpyA1BSUFqouPBYPRGeBYMfScave
 YtoIIq+fYcru5RuodVb9XREkY1EXfYnVrdYeadlXhfivMx8orhne1bOzbTBfME6R5EuxPC/M31N
 5MwnTt2ukUN1Z/YMSqmXkUGdqrzd2YFXZXpjnwO8JZxezqY=
X-Received: by 2002:a05:6a00:2ea9:b0:82c:ded1:2610 with SMTP id
 d2e1a72fcca58-82ce8b1fe93mr1001953b3a.56.1774991274325; Tue, 31 Mar 2026
 14:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260330224503.548284-1-gabrielsousa230@gmail.com>
 <01989c65-1e1e-4f78-ac88-a1c76961b3c3@amd.com>
 <CADnq5_N6bzHTQJjS6__-Fmp15fASUw3C5DG1uNvZgkxCRtFkcw@mail.gmail.com>
In-Reply-To: <CADnq5_N6bzHTQJjS6__-Fmp15fASUw3C5DG1uNvZgkxCRtFkcw@mail.gmail.com>
From: Gabriel Almeida <gabrielsousa230@gmail.com>
Date: Tue, 31 Mar 2026 18:07:43 -0300
X-Gm-Features: AQROBzDGaJSE7g8TIGu84P6ew_qmFqtT2AN2h2XMiDqqUEfZH1TGcQ1AFosKawo
Message-ID: <CALsHKmUeB3=H9=Nq=+jOvtmwXxSg=wtHrASZNvVVPQwpyem2ug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: deduplicate register access and helper
 routines
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

Hi Christian and Alex,

Thank you both for your feedback.

I understand that there can be differences between these functions due to
different macro values across hardware generations. I admit that I didn=E2=
=80=99t
fully take that into account in this patch.

Among the functions I modified, `program_aspm` and `common_sw_init` seem
to have identical behavior regardless of those macros, so I thought they
could be good candidates for shared helper functions. That said,
`common_sw_init` is currently only identical across NV, SOC21 and SOC24,
so I=E2=80=99m not sure if you would consider it generic enough for such us=
e.

Regarding `read_indexed_register`, I=E2=80=99m still uncertain due to the u=
se of
the `RREG32` macro. From what I=E2=80=99ve seen so far, it appears to behav=
e
consistently across these implementations, but I may be missing some
subtleties.

Also, when Christian mentioned =E2=80=9Cmove them a layer up=E2=80=9D, do y=
ou mean moving
these helpers into an existing common file such as `amdgpu_device.c`
instead of introducing a new file like `amdgpu_common.c/h`? I can rework
the patch accordingly and drop the new files if that is the preferred
approach.

I can also incorporate Alex=E2=80=99s suggestions regarding naming and lice=
nsing.

Given these points, I=E2=80=99d like to better understand which direction y=
ou
would prefer for this change.

Thanks again for your time and guidance.

Best regards,
Gabriel Almeida


Em ter., 31 de mar. de 2026 =C3=A0s 10:31, Alex Deucher
<alexdeucher@gmail.com> escreveu:
>
> On Tue, Mar 31, 2026 at 7:34=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 3/31/26 00:45, Gabriel Almeida wrote:
> > > Some helper functions are implemented multiple times with identical
> > > logic across different source files.
> >
> > And that is at least sometimes completely intentional.
> >
> > Background is that different headers are included which define macros w=
ith different values for each HW generation.
> >
> > >
> > > Extract these implementations into a shared helper file
> > > (amdgpu_common.c) and update existing code to reuse them.
> >
> > Please don't when they are functional identical then move them a layer =
up instead of messing up the backends.
> >
> > Regards,
> > Christian.
> >
> > >
> > > This simplifies the codebase and avoids duplication without
> > > changing behavior.
> > >
> > > No functional changes intended.
> > >
> > > Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/Makefile        |  2 ++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_common.c | 42 ++++++++++++++++++++=
++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_common.h | 12 +++++++
>
> I think amdgpu_common_helper.c/h would be better.
>
> > >  drivers/gpu/drm/amd/amdgpu/nv.c            | 38 +++-----------------
> > >  drivers/gpu/drm/amd/amdgpu/soc15.c         | 31 ++--------------
> > >  drivers/gpu/drm/amd/amdgpu/soc21.c         | 38 +++-----------------
> > >  drivers/gpu/drm/amd/amdgpu/soc24.c         | 29 ++-------------
> > >  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      | 21 ++---------
> > >  8 files changed, 72 insertions(+), 141 deletions(-)
> > >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
> > >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/am=
d/amdgpu/Makefile
> > > index 6a7e9bfec..84cce03d7 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > > @@ -69,6 +69,8 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_reg_access.o a=
mdgpu_doorbell_mgr.o amdgpu_kms
> > >         amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o am=
dgpu_dev_coredump.o \
> > >         amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o am=
dgpu_ip.o
> > >
> > > +amdgpu-y +=3D amdgpu_common.o
> > > +
> > >  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
> > >
> > >  amdgpu-$(CONFIG_PERF_EVENTS) +=3D amdgpu_pmu.o
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_common.c
> > > new file mode 100644
> > > index 000000000..34ade6f63
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
> > > @@ -0,0 +1,42 @@
> > > +// SPDX-License-Identifier: GPL-2.0
>
> This should be MIT
>
> > > +#include <linux/module.h>
> > > +
> > > +#include "amdgpu.h"
> > > +#include "amdgpu_common.h"
> > > +#include "mxgpu_nv.h"
> > > +
> > > +uint32_t read_indexed_register(struct amdgpu_device *adev,
> > > +                              u32 se_num, u32 sh_num, u32 reg_offset=
)
> > > +{
> > > +       uint32_t val;
> > > +
> > > +       mutex_lock(&adev->grbm_idx_mutex);
> > > +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > +               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffff=
fff, 0);
> > > +
> > > +       val =3D RREG32(reg_offset);
> > > +
> > > +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > +               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff,=
 0xffffffff, 0);
> > > +       mutex_unlock(&adev->grbm_idx_mutex);
> > > +       return val;
> > > +}
> > > +
> > > +void program_aspm(struct amdgpu_device *adev)
> > > +{
> > > +       if (!amdgpu_device_should_use_aspm(adev))
> > > +               return;
> > > +
> > > +       if (adev->nbio.funcs->program_aspm)
> > > +               adev->nbio.funcs->program_aspm(adev);
> > > +}
> > > +
> > > +int common_sw_init(struct amdgpu_ip_block *ip_block)
>
> Please prefix each of these functions with amdgpu_common_helper_
>
> > > +{
> > > +       struct amdgpu_device *adev =3D ip_block->adev;
> > > +
> > > +       if (amdgpu_sriov_vf(adev))
> > > +               xgpu_nv_mailbox_add_irq_id(adev);
> > > +
> > > +       return 0;
> > > +}
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_common.h
> > > new file mode 100644
> > > index 000000000..314b3506b
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> > > @@ -0,0 +1,12 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
>
> This should be MIT
>
> Alex
>
> > > +#ifndef __AMDGPU_COMMON_H__
> > > +#define __AMDGPU_COMMON_H__
> > > +
> > > +uint32_t read_indexed_register(struct amdgpu_device *adev,
> > > +                              u32 se_num, u32 sh_num, u32 reg_offset=
);
> > > +
> > > +void program_aspm(struct amdgpu_device *adev);
> > > +
> > > +int common_sw_init(struct amdgpu_ip_block *ip_block);
> > > +
> > > +#endif
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/am=
dgpu/nv.c
> > > index 7ce1a1b95..cf8052c73 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > > @@ -29,6 +29,7 @@
> > >
> > >  #include "amdgpu.h"
> > >  #include "amdgpu_atombios.h"
> > > +#include "amdgpu_common.h"
> > >  #include "amdgpu_ih.h"
> > >  #include "amdgpu_uvd.h"
> > >  #include "amdgpu_vce.h"
> > > @@ -354,29 +355,13 @@ static struct soc15_allowed_register_entry nv_a=
llowed_read_registers[] =3D {
> > >         { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
> > >  };
> > >
> > > -static uint32_t nv_read_indexed_register(struct amdgpu_device *adev,=
 u32 se_num,
> > > -                                        u32 sh_num, u32 reg_offset)
> > > -{
> > > -       uint32_t val;
> > > -
> > > -       mutex_lock(&adev->grbm_idx_mutex);
> > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffff=
fff, 0);
> > > -
> > > -       val =3D RREG32(reg_offset);
> > > -
> > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff,=
 0xffffffff, 0);
> > > -       mutex_unlock(&adev->grbm_idx_mutex);
> > > -       return val;
> > > -}
> > >
> > >  static uint32_t nv_get_register_value(struct amdgpu_device *adev,
> > >                                       bool indexed, u32 se_num,
> > >                                       u32 sh_num, u32 reg_offset)
> > >  {
> > >         if (indexed) {
> > > -               return nv_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> > > +               return read_indexed_register(adev, se_num, sh_num, re=
g_offset);
> > >         } else {
> > >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_AD=
DR_CONFIG))
> > >                         return adev->gfx.config.gb_addr_config;
> > > @@ -511,16 +496,6 @@ static int nv_set_vce_clocks(struct amdgpu_devic=
e *adev, u32 evclk, u32 ecclk)
> > >         return 0;
> > >  }
> > >
> > > -static void nv_program_aspm(struct amdgpu_device *adev)
> > > -{
> > > -       if (!amdgpu_device_should_use_aspm(adev))
> > > -               return;
> > > -
> > > -       if (adev->nbio.funcs->program_aspm)
> > > -               adev->nbio.funcs->program_aspm(adev);
> > > -
> > > -}
> > > -
> > >  const struct amdgpu_ip_block_version nv_common_ip_block =3D {
> > >         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> > >         .major =3D 1,
> > > @@ -965,12 +940,7 @@ static int nv_common_late_init(struct amdgpu_ip_=
block *ip_block)
> > >
> > >  static int nv_common_sw_init(struct amdgpu_ip_block *ip_block)
> > >  {
> > > -       struct amdgpu_device *adev =3D ip_block->adev;
> > > -
> > > -       if (amdgpu_sriov_vf(adev))
> > > -               xgpu_nv_mailbox_add_irq_id(adev);
> > > -
> > > -       return 0;
> > > +       return common_sw_init(ip_block);
> > >  }
> > >
> > >  static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
> > > @@ -984,7 +954,7 @@ static int nv_common_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
> > >                 adev->nbio.funcs->apply_l1_link_width_reconfig_wa(ade=
v);
> > >
> > >         /* enable aspm */
> > > -       nv_program_aspm(adev);
> > > +       program_aspm(adev);
> > >         /* setup nbio registers */
> > >         adev->nbio.funcs->init_registers(adev);
> > >         /* remap HDP registers to a hole in mmio space,
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd=
/amdgpu/soc15.c
> > > index b456e4541..a6b91363d 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > @@ -28,6 +28,7 @@
> > >  #include <drm/amdgpu_drm.h>
> > >
> > >  #include "amdgpu.h"
> > > +#include "amdgpu_common.h"
> > >  #include "amdgpu_ih.h"
> > >  #include "amdgpu_uvd.h"
> > >  #include "amdgpu_vce.h"
> > > @@ -401,29 +402,12 @@ static struct soc15_allowed_register_entry soc1=
5_allowed_read_registers[] =3D {
> > >         { SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
> > >  };
> > >
> > > -static uint32_t soc15_read_indexed_register(struct amdgpu_device *ad=
ev, u32 se_num,
> > > -                                        u32 sh_num, u32 reg_offset)
> > > -{
> > > -       uint32_t val;
> > > -
> > > -       mutex_lock(&adev->grbm_idx_mutex);
> > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffff=
fff, 0);
> > > -
> > > -       val =3D RREG32(reg_offset);
> > > -
> > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff,=
 0xffffffff, 0);
> > > -       mutex_unlock(&adev->grbm_idx_mutex);
> > > -       return val;
> > > -}
> > > -
> > >  static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
> > >                                          bool indexed, u32 se_num,
> > >                                          u32 sh_num, u32 reg_offset)
> > >  {
> > >         if (indexed) {
> > > -               return soc15_read_indexed_register(adev, se_num, sh_n=
um, reg_offset);
> > > +               return read_indexed_register(adev, se_num, sh_num, re=
g_offset);
> > >         } else {
> > >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_AD=
DR_CONFIG))
> > >                         return adev->gfx.config.gb_addr_config;
> > > @@ -695,15 +679,6 @@ static int soc15_set_vce_clocks(struct amdgpu_de=
vice *adev, u32 evclk, u32 ecclk
> > >         return 0;
> > >  }
> > >
> > > -static void soc15_program_aspm(struct amdgpu_device *adev)
> > > -{
> > > -       if (!amdgpu_device_should_use_aspm(adev))
> > > -               return;
> > > -
> > > -       if (adev->nbio.funcs->program_aspm)
> > > -               adev->nbio.funcs->program_aspm(adev);
> > > -}
> > > -
> > >  const struct amdgpu_ip_block_version vega10_common_ip_block =3D
> > >  {
> > >         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> > > @@ -1284,7 +1259,7 @@ static int soc15_common_hw_init(struct amdgpu_i=
p_block *ip_block)
> > >         struct amdgpu_device *adev =3D ip_block->adev;
> > >
> > >         /* enable aspm */
> > > -       soc15_program_aspm(adev);
> > > +       program_aspm(adev);
> > >         /* setup nbio registers */
> > >         adev->nbio.funcs->init_registers(adev);
> > >         /* remap HDP registers to a hole in mmio space,
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd=
/amdgpu/soc21.c
> > > index fbd1d97f3..586d62202 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > > @@ -27,6 +27,7 @@
> > >
> > >  #include "amdgpu.h"
> > >  #include "amdgpu_atombios.h"
> > > +#include "amdgpu_common.h"
> > >  #include "amdgpu_ih.h"
> > >  #include "amdgpu_uvd.h"
> > >  #include "amdgpu_vce.h"
> > > @@ -306,29 +307,12 @@ static struct soc15_allowed_register_entry soc2=
1_allowed_read_registers[] =3D {
> > >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> > >  };
> > >
> > > -static uint32_t soc21_read_indexed_register(struct amdgpu_device *ad=
ev, u32 se_num,
> > > -                                        u32 sh_num, u32 reg_offset)
> > > -{
> > > -       uint32_t val;
> > > -
> > > -       mutex_lock(&adev->grbm_idx_mutex);
> > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffff=
fff, 0);
> > > -
> > > -       val =3D RREG32(reg_offset);
> > > -
> > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff,=
 0xffffffff, 0);
> > > -       mutex_unlock(&adev->grbm_idx_mutex);
> > > -       return val;
> > > -}
> > > -
> > >  static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
> > >                                       bool indexed, u32 se_num,
> > >                                       u32 sh_num, u32 reg_offset)
> > >  {
> > >         if (indexed) {
> > > -               return soc21_read_indexed_register(adev, se_num, sh_n=
um, reg_offset);
> > > +               return read_indexed_register(adev, se_num, sh_num, re=
g_offset);
> > >         } else {
> > >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_A=
DDR_CONFIG) && adev->gfx.config.gb_addr_config)
> > >                         return adev->gfx.config.gb_addr_config;
> > > @@ -470,15 +454,6 @@ static int soc21_set_vce_clocks(struct amdgpu_de=
vice *adev, u32 evclk, u32 ecclk
> > >         return 0;
> > >  }
> > >
> > > -static void soc21_program_aspm(struct amdgpu_device *adev)
> > > -{
> > > -       if (!amdgpu_device_should_use_aspm(adev))
> > > -               return;
> > > -
> > > -       if (adev->nbio.funcs->program_aspm)
> > > -               adev->nbio.funcs->program_aspm(adev);
> > > -}
> > > -
> > >  const struct amdgpu_ip_block_version soc21_common_ip_block =3D {
> > >         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> > >         .major =3D 1,
> > > @@ -912,12 +887,7 @@ static int soc21_common_late_init(struct amdgpu_=
ip_block *ip_block)
> > >
> > >  static int soc21_common_sw_init(struct amdgpu_ip_block *ip_block)
> > >  {
> > > -       struct amdgpu_device *adev =3D ip_block->adev;
> > > -
> > > -       if (amdgpu_sriov_vf(adev))
> > > -               xgpu_nv_mailbox_add_irq_id(adev);
> > > -
> > > -       return 0;
> > > +       return common_sw_init(ip_block);
> > >  }
> > >
> > >  static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
> > > @@ -925,7 +895,7 @@ static int soc21_common_hw_init(struct amdgpu_ip_=
block *ip_block)
> > >         struct amdgpu_device *adev =3D ip_block->adev;
> > >
> > >         /* enable aspm */
> > > -       soc21_program_aspm(adev);
> > > +       program_aspm(adev);
> > >         /* setup nbio registers */
> > >         adev->nbio.funcs->init_registers(adev);
> > >         /* remap HDP registers to a hole in mmio space,
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd=
/amdgpu/soc24.c
> > > index d1adf19a5..f9341c0e4 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/pci.h>
> > >
> > >  #include "amdgpu.h"
> > > +#include "amdgpu_common.h"
> > >  #include "amdgpu_ih.h"
> > >  #include "amdgpu_uvd.h"
> > >  #include "amdgpu_vce.h"
> > > @@ -132,31 +133,12 @@ static struct soc15_allowed_register_entry soc2=
4_allowed_read_registers[] =3D {
> > >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> > >  };
> > >
> > > -static uint32_t soc24_read_indexed_register(struct amdgpu_device *ad=
ev,
> > > -                                           u32 se_num,
> > > -                                           u32 sh_num,
> > > -                                           u32 reg_offset)
> > > -{
> > > -       uint32_t val;
> > > -
> > > -       mutex_lock(&adev->grbm_idx_mutex);
> > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffff=
fff, 0);
> > > -
> > > -       val =3D RREG32(reg_offset);
> > > -
> > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff,=
 0xffffffff, 0);
> > > -       mutex_unlock(&adev->grbm_idx_mutex);
> > > -       return val;
> > > -}
> > > -
> > >  static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
> > >                                          bool indexed, u32 se_num,
> > >                                          u32 sh_num, u32 reg_offset)
> > >  {
> > >         if (indexed) {
> > > -               return soc24_read_indexed_register(adev, se_num, sh_n=
um, reg_offset);
> > > +               return read_indexed_register(adev, se_num, sh_num, re=
g_offset);
> > >         } else {
> > >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_A=
DDR_CONFIG) &&
> > >                     adev->gfx.config.gb_addr_config)
> > > @@ -455,12 +437,7 @@ static int soc24_common_late_init(struct amdgpu_=
ip_block *ip_block)
> > >
> > >  static int soc24_common_sw_init(struct amdgpu_ip_block *ip_block)
> > >  {
> > > -       struct amdgpu_device *adev =3D ip_block->adev;
> > > -
> > > -       if (amdgpu_sriov_vf(adev))
> > > -               xgpu_nv_mailbox_add_irq_id(adev);
> > > -
> > > -       return 0;
> > > +       return common_sw_init(ip_block);
> > >  }
> > >
> > >  static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block)
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/=
amd/amdgpu/soc_v1_0.c
> > > index 709b1669b..2f77fb0b6 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > > @@ -21,6 +21,7 @@
> > >   *
> > >   */
> > >  #include "amdgpu.h"
> > > +#include "amdgpu_common.h"
> > >  #include "soc15.h"
> > >  #include "soc15_common.h"
> > >  #include "soc_v1_0.h"
> > > @@ -184,31 +185,13 @@ static struct soc15_allowed_register_entry soc_=
v1_0_allowed_read_registers[] =3D {
> > >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
> > >  };
> > >
> > > -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device =
*adev,
> > > -                                              u32 se_num,
> > > -                                              u32 sh_num,
> > > -                                              u32 reg_offset)
> > > -{
> > > -       uint32_t val;
> > > -
> > > -       mutex_lock(&adev->grbm_idx_mutex);
> > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffff=
fff, 0);
> > > -
> > > -       val =3D RREG32(reg_offset);
> > > -
> > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff,=
 0xffffffff, 0);
> > > -       mutex_unlock(&adev->grbm_idx_mutex);
> > > -       return val;
> > > -}
> > >
> > >  static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *ad=
ev,
> > >                                             bool indexed, u32 se_num,
> > >                                             u32 sh_num, u32 reg_offse=
t)
> > >  {
> > >         if (indexed) {
> > > -               return soc_v1_0_read_indexed_register(adev, se_num, s=
h_num, reg_offset);
> > > +               return read_indexed_register(adev, se_num, sh_num, re=
g_offset);
> > >         } else {
> > >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_A=
DDR_CONFIG_1) &&
> > >                     adev->gfx.config.gb_addr_config)
> > > --
> > > 2.43.0
> > >
> >
