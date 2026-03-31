Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6E6109B467
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B0AA10E988;
	Tue, 31 Mar 2026 13:31:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GobHsh9a";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B6210E988
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:31:08 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-128bae6a35aso225169c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 06:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774963867; cv=none;
 d=google.com; s=arc-20240605;
 b=jJ7sk+gEvWUf3Ua78Rmlmvnw5y3LJwsGlDJU5l6Qj/Eh8BeoHhVippqWY06Jgho56b
 X9A2Ko1VKIBUQaqdrybyPKMdTut1Hzowu1XtNFwM6a2hRrnXFKlK+GgjLnLUfnuvdtn/
 dvC9DdnyLm3AijNeRZsZYriGbv+m07dFz58YXC4zGsRHqxMpt6nKDLq3lt4VoBFG8dbK
 xT78epvCTfHjBdAyLsGhpAaQI3JtSYP+SIh6cYmBkGrWk0o7AOkUwqWCCHI6hQtOHaGG
 7EmXUxT8KRUGfZu2ylhMZuIldL10krYxqOyzX15VrUhaDODNe5dX0hTkS+oqsVZSD5nd
 ZR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CKnxxuPt7xVeL78mPhkR/266iTwlZuB0T+L5N9bN2ko=;
 fh=jUcPV2Yd4GBewSqmYFiD01eDmM8JjY5spejEjhIqyWs=;
 b=iaVLMon1yh2RctwIXwqbIqwQYhIoDi1nHuG+KLB8UYJIv2j/3SzeDJKrtuwn3/piJv
 Kc0cFs27M76+lgHW2gUQ/AZLm7fXxmJVD1RTVk91avvcLevpvmtpNXinVKniGIle7qs0
 5Q7oaz67lQEiLsaghlJ5h8qp+ebrubno/1Ka6+OkGEOv3n0TvBD5wuHqUzw0zpBm7sU7
 LmtTK+oU6AmyjwEt4Nn28Lq94+IDDU2Jiq/tEo0/JcLA99zMLst7B7r1IBaDOSpd6IBD
 1O/ruQIpIM1OVW7L7k3eiSk6cIdlGlK8+ODC0dZ+lRKXrdvyBaz0gSBos8UVbfDAX0j1
 9QAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774963867; x=1775568667; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKnxxuPt7xVeL78mPhkR/266iTwlZuB0T+L5N9bN2ko=;
 b=GobHsh9ai1Tkdl3pbhjXGN86YJH63G19DNQGqhq03OvUCX52TRhX0l4UISB/lYl10E
 xOpDFwLZbLP+L8R03mNoZmw46Wohw3g/wHaPeNhVMnCAf4adkzrZ7eGNmz6LaB78Bdg8
 uGJXZUEkIYK9yTJbS2ZuhOX2bXYtdihBM2I7ywzko0/fKhBYICsonrwLh1l87YYLRM00
 DWplEtiM5EB++kpXibkqUcwfBzbJPcPk5M7LLrqAgmci/g7TlqQHzhzU5mMlY7UqVpg7
 gBne1oEkOzIBbMg2SagO9e+n5xZ1j7LBMK99++C/ZrWgMwkeuaBlFXzqjJgu6jzC8qFd
 XkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774963867; x=1775568667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CKnxxuPt7xVeL78mPhkR/266iTwlZuB0T+L5N9bN2ko=;
 b=PtXIqjBgpE4r/RXQYJvW7uK7cs/fEfNaeSernUeFYmQantWHsX0NIT+w9OKhyiVbkC
 eDHKbbk5TynzATyaA3Ic5fOuWbsraQOPURlNS5gdok3g3qjBdnRO18Pv/in9xm34sGT4
 Jiut1BdILzvXz+sLwyiVe0AHZYpoAUs5tCRIqs7JbfQSPd/tTYsixKQ3F4dKNVSFhL4r
 s0pGyNOnnujW+eQZWuHc7frYWUwYZneXu1+RfMIADlMNthzSIlBm958nFVGxQtx17/Vv
 TeAF68xkZqWSbTqQrcSpm3zBiYJFt30dSNmp/tEGMAn72WKwzbcFuSiEVWq/qO04KSaI
 dMiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyJFiCSx1fr9xTZh0XNohwoCkyGMXeICRyCwDYIPU0HIJw+MN1gTL8Ibk1GMsDY/wfJqGyO+HWuuk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDsU94lGkBkZBPQmuo+BO0dRmh8KWzrWpRHI2MDhdikoZ3aG71
 XQf8waPsGUVMVR37+i/c4X5qwjGd02M9swTINC4lJ2IwZJ0yeIdJg8TvBST6kcoeB/v+DcGGNbY
 PDxzzXZiX7LWDU3xOpJ3yi1hLFurPHZY=
X-Gm-Gg: ATEYQzzsy6sq7EiRCCG5Sc1FC4nrRyrXRabW10LYbk/HgS0dVibeQO39JqU+zRg/dbC
 o3bLiDsQ0XQBc0vQrbGhDvIQY0ddhFLLFOma2bJfcgDlbM3CLgrhFEzmNcDov+1rj/p+hJDlhds
 Awxq82ZPzYUXC5/vT5w3gWfG6UwRSIeK3fiFXPyVJ/4qhpowQDZ978KW/Gtn/r7vWJ3crSdIPfU
 NMOiLzMnmQVxkn3qcAxQLLfUpoSbUtIDd2S756aCIe2D69rx0xKPbfwPC3AVTHS1KCX3dF5os/X
 5GRWUz+qMhEFe8CPS6pQ1SqapfmmRdVraUjHu0K6U17VT1bmI8gYst3bBbWVIkNovgkoxA==
X-Received: by 2002:a05:7022:4387:b0:128:d279:b8ea with SMTP id
 a92af1059eb24-12ab28f3a8amr4386866c88.5.1774963867255; Tue, 31 Mar 2026
 06:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260330224503.548284-1-gabrielsousa230@gmail.com>
 <01989c65-1e1e-4f78-ac88-a1c76961b3c3@amd.com>
In-Reply-To: <01989c65-1e1e-4f78-ac88-a1c76961b3c3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 09:30:55 -0400
X-Gm-Features: AQROBzCih4ihgjH9jVyAp7rQmVXl4lcb8__K_hTKMUei1aK_aJLkaIo41UNjvIo
Message-ID: <CADnq5_N6bzHTQJjS6__-Fmp15fASUw3C5DG1uNvZgkxCRtFkcw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: deduplicate register access and helper
 routines
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Gabriel Almeida <gabrielsousa230@gmail.com>, alexander.deucher@amd.com,
 airlied@gmail.com, 
 simona@ffwll.ch, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Tue, Mar 31, 2026 at 7:34=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 3/31/26 00:45, Gabriel Almeida wrote:
> > Some helper functions are implemented multiple times with identical
> > logic across different source files.
>
> And that is at least sometimes completely intentional.
>
> Background is that different headers are included which define macros wit=
h different values for each HW generation.
>
> >
> > Extract these implementations into a shared helper file
> > (amdgpu_common.c) and update existing code to reuse them.
>
> Please don't when they are functional identical then move them a layer up=
 instead of messing up the backends.
>
> Regards,
> Christian.
>
> >
> > This simplifies the codebase and avoids duplication without
> > changing behavior.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/Makefile        |  2 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_common.c | 42 ++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_common.h | 12 +++++++

I think amdgpu_common_helper.c/h would be better.

> >  drivers/gpu/drm/amd/amdgpu/nv.c            | 38 +++-----------------
> >  drivers/gpu/drm/amd/amdgpu/soc15.c         | 31 ++--------------
> >  drivers/gpu/drm/amd/amdgpu/soc21.c         | 38 +++-----------------
> >  drivers/gpu/drm/amd/amdgpu/soc24.c         | 29 ++-------------
> >  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      | 21 ++---------
> >  8 files changed, 72 insertions(+), 141 deletions(-)
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/=
amdgpu/Makefile
> > index 6a7e9bfec..84cce03d7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > @@ -69,6 +69,8 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_reg_access.o amd=
gpu_doorbell_mgr.o amdgpu_kms
> >         amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdg=
pu_dev_coredump.o \
> >         amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdg=
pu_ip.o
> >
> > +amdgpu-y +=3D amdgpu_common.o
> > +
> >  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
> >
> >  amdgpu-$(CONFIG_PERF_EVENTS) +=3D amdgpu_pmu.o
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_common.c
> > new file mode 100644
> > index 000000000..34ade6f63
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
> > @@ -0,0 +1,42 @@
> > +// SPDX-License-Identifier: GPL-2.0

This should be MIT

> > +#include <linux/module.h>
> > +
> > +#include "amdgpu.h"
> > +#include "amdgpu_common.h"
> > +#include "mxgpu_nv.h"
> > +
> > +uint32_t read_indexed_register(struct amdgpu_device *adev,
> > +                              u32 se_num, u32 sh_num, u32 reg_offset)
> > +{
> > +       uint32_t val;
> > +
> > +       mutex_lock(&adev->grbm_idx_mutex);
> > +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > +               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffffff=
f, 0);
> > +
> > +       val =3D RREG32(reg_offset);
> > +
> > +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > +               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0=
xffffffff, 0);
> > +       mutex_unlock(&adev->grbm_idx_mutex);
> > +       return val;
> > +}
> > +
> > +void program_aspm(struct amdgpu_device *adev)
> > +{
> > +       if (!amdgpu_device_should_use_aspm(adev))
> > +               return;
> > +
> > +       if (adev->nbio.funcs->program_aspm)
> > +               adev->nbio.funcs->program_aspm(adev);
> > +}
> > +
> > +int common_sw_init(struct amdgpu_ip_block *ip_block)

Please prefix each of these functions with amdgpu_common_helper_

> > +{
> > +       struct amdgpu_device *adev =3D ip_block->adev;
> > +
> > +       if (amdgpu_sriov_vf(adev))
> > +               xgpu_nv_mailbox_add_irq_id(adev);
> > +
> > +       return 0;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_common.h
> > new file mode 100644
> > index 000000000..314b3506b
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */

This should be MIT

Alex

> > +#ifndef __AMDGPU_COMMON_H__
> > +#define __AMDGPU_COMMON_H__
> > +
> > +uint32_t read_indexed_register(struct amdgpu_device *adev,
> > +                              u32 se_num, u32 sh_num, u32 reg_offset);
> > +
> > +void program_aspm(struct amdgpu_device *adev);
> > +
> > +int common_sw_init(struct amdgpu_ip_block *ip_block);
> > +
> > +#endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdg=
pu/nv.c
> > index 7ce1a1b95..cf8052c73 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -29,6 +29,7 @@
> >
> >  #include "amdgpu.h"
> >  #include "amdgpu_atombios.h"
> > +#include "amdgpu_common.h"
> >  #include "amdgpu_ih.h"
> >  #include "amdgpu_uvd.h"
> >  #include "amdgpu_vce.h"
> > @@ -354,29 +355,13 @@ static struct soc15_allowed_register_entry nv_all=
owed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
> >  };
> >
> > -static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u=
32 se_num,
> > -                                        u32 sh_num, u32 reg_offset)
> > -{
> > -       uint32_t val;
> > -
> > -       mutex_lock(&adev->grbm_idx_mutex);
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffffff=
f, 0);
> > -
> > -       val =3D RREG32(reg_offset);
> > -
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0=
xffffffff, 0);
> > -       mutex_unlock(&adev->grbm_idx_mutex);
> > -       return val;
> > -}
> >
> >  static uint32_t nv_get_register_value(struct amdgpu_device *adev,
> >                                       bool indexed, u32 se_num,
> >                                       u32 sh_num, u32 reg_offset)
> >  {
> >         if (indexed) {
> > -               return nv_read_indexed_register(adev, se_num, sh_num, r=
eg_offset);
> > +               return read_indexed_register(adev, se_num, sh_num, reg_=
offset);
> >         } else {
> >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_ADDR=
_CONFIG))
> >                         return adev->gfx.config.gb_addr_config;
> > @@ -511,16 +496,6 @@ static int nv_set_vce_clocks(struct amdgpu_device =
*adev, u32 evclk, u32 ecclk)
> >         return 0;
> >  }
> >
> > -static void nv_program_aspm(struct amdgpu_device *adev)
> > -{
> > -       if (!amdgpu_device_should_use_aspm(adev))
> > -               return;
> > -
> > -       if (adev->nbio.funcs->program_aspm)
> > -               adev->nbio.funcs->program_aspm(adev);
> > -
> > -}
> > -
> >  const struct amdgpu_ip_block_version nv_common_ip_block =3D {
> >         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> >         .major =3D 1,
> > @@ -965,12 +940,7 @@ static int nv_common_late_init(struct amdgpu_ip_bl=
ock *ip_block)
> >
> >  static int nv_common_sw_init(struct amdgpu_ip_block *ip_block)
> >  {
> > -       struct amdgpu_device *adev =3D ip_block->adev;
> > -
> > -       if (amdgpu_sriov_vf(adev))
> > -               xgpu_nv_mailbox_add_irq_id(adev);
> > -
> > -       return 0;
> > +       return common_sw_init(ip_block);
> >  }
> >
> >  static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
> > @@ -984,7 +954,7 @@ static int nv_common_hw_init(struct amdgpu_ip_block=
 *ip_block)
> >                 adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev)=
;
> >
> >         /* enable aspm */
> > -       nv_program_aspm(adev);
> > +       program_aspm(adev);
> >         /* setup nbio registers */
> >         adev->nbio.funcs->init_registers(adev);
> >         /* remap HDP registers to a hole in mmio space,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/a=
mdgpu/soc15.c
> > index b456e4541..a6b91363d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -28,6 +28,7 @@
> >  #include <drm/amdgpu_drm.h>
> >
> >  #include "amdgpu.h"
> > +#include "amdgpu_common.h"
> >  #include "amdgpu_ih.h"
> >  #include "amdgpu_uvd.h"
> >  #include "amdgpu_vce.h"
> > @@ -401,29 +402,12 @@ static struct soc15_allowed_register_entry soc15_=
allowed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
> >  };
> >
> > -static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev=
, u32 se_num,
> > -                                        u32 sh_num, u32 reg_offset)
> > -{
> > -       uint32_t val;
> > -
> > -       mutex_lock(&adev->grbm_idx_mutex);
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffffff=
f, 0);
> > -
> > -       val =3D RREG32(reg_offset);
> > -
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0=
xffffffff, 0);
> > -       mutex_unlock(&adev->grbm_idx_mutex);
> > -       return val;
> > -}
> > -
> >  static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
> >                                          bool indexed, u32 se_num,
> >                                          u32 sh_num, u32 reg_offset)
> >  {
> >         if (indexed) {
> > -               return soc15_read_indexed_register(adev, se_num, sh_num=
, reg_offset);
> > +               return read_indexed_register(adev, se_num, sh_num, reg_=
offset);
> >         } else {
> >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_ADDR=
_CONFIG))
> >                         return adev->gfx.config.gb_addr_config;
> > @@ -695,15 +679,6 @@ static int soc15_set_vce_clocks(struct amdgpu_devi=
ce *adev, u32 evclk, u32 ecclk
> >         return 0;
> >  }
> >
> > -static void soc15_program_aspm(struct amdgpu_device *adev)
> > -{
> > -       if (!amdgpu_device_should_use_aspm(adev))
> > -               return;
> > -
> > -       if (adev->nbio.funcs->program_aspm)
> > -               adev->nbio.funcs->program_aspm(adev);
> > -}
> > -
> >  const struct amdgpu_ip_block_version vega10_common_ip_block =3D
> >  {
> >         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> > @@ -1284,7 +1259,7 @@ static int soc15_common_hw_init(struct amdgpu_ip_=
block *ip_block)
> >         struct amdgpu_device *adev =3D ip_block->adev;
> >
> >         /* enable aspm */
> > -       soc15_program_aspm(adev);
> > +       program_aspm(adev);
> >         /* setup nbio registers */
> >         adev->nbio.funcs->init_registers(adev);
> >         /* remap HDP registers to a hole in mmio space,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/a=
mdgpu/soc21.c
> > index fbd1d97f3..586d62202 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > @@ -27,6 +27,7 @@
> >
> >  #include "amdgpu.h"
> >  #include "amdgpu_atombios.h"
> > +#include "amdgpu_common.h"
> >  #include "amdgpu_ih.h"
> >  #include "amdgpu_uvd.h"
> >  #include "amdgpu_vce.h"
> > @@ -306,29 +307,12 @@ static struct soc15_allowed_register_entry soc21_=
allowed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> >  };
> >
> > -static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev=
, u32 se_num,
> > -                                        u32 sh_num, u32 reg_offset)
> > -{
> > -       uint32_t val;
> > -
> > -       mutex_lock(&adev->grbm_idx_mutex);
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffffff=
f, 0);
> > -
> > -       val =3D RREG32(reg_offset);
> > -
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0=
xffffffff, 0);
> > -       mutex_unlock(&adev->grbm_idx_mutex);
> > -       return val;
> > -}
> > -
> >  static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
> >                                       bool indexed, u32 se_num,
> >                                       u32 sh_num, u32 reg_offset)
> >  {
> >         if (indexed) {
> > -               return soc21_read_indexed_register(adev, se_num, sh_num=
, reg_offset);
> > +               return read_indexed_register(adev, se_num, sh_num, reg_=
offset);
> >         } else {
> >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADD=
R_CONFIG) && adev->gfx.config.gb_addr_config)
> >                         return adev->gfx.config.gb_addr_config;
> > @@ -470,15 +454,6 @@ static int soc21_set_vce_clocks(struct amdgpu_devi=
ce *adev, u32 evclk, u32 ecclk
> >         return 0;
> >  }
> >
> > -static void soc21_program_aspm(struct amdgpu_device *adev)
> > -{
> > -       if (!amdgpu_device_should_use_aspm(adev))
> > -               return;
> > -
> > -       if (adev->nbio.funcs->program_aspm)
> > -               adev->nbio.funcs->program_aspm(adev);
> > -}
> > -
> >  const struct amdgpu_ip_block_version soc21_common_ip_block =3D {
> >         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> >         .major =3D 1,
> > @@ -912,12 +887,7 @@ static int soc21_common_late_init(struct amdgpu_ip=
_block *ip_block)
> >
> >  static int soc21_common_sw_init(struct amdgpu_ip_block *ip_block)
> >  {
> > -       struct amdgpu_device *adev =3D ip_block->adev;
> > -
> > -       if (amdgpu_sriov_vf(adev))
> > -               xgpu_nv_mailbox_add_irq_id(adev);
> > -
> > -       return 0;
> > +       return common_sw_init(ip_block);
> >  }
> >
> >  static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
> > @@ -925,7 +895,7 @@ static int soc21_common_hw_init(struct amdgpu_ip_bl=
ock *ip_block)
> >         struct amdgpu_device *adev =3D ip_block->adev;
> >
> >         /* enable aspm */
> > -       soc21_program_aspm(adev);
> > +       program_aspm(adev);
> >         /* setup nbio registers */
> >         adev->nbio.funcs->init_registers(adev);
> >         /* remap HDP registers to a hole in mmio space,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/a=
mdgpu/soc24.c
> > index d1adf19a5..f9341c0e4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/pci.h>
> >
> >  #include "amdgpu.h"
> > +#include "amdgpu_common.h"
> >  #include "amdgpu_ih.h"
> >  #include "amdgpu_uvd.h"
> >  #include "amdgpu_vce.h"
> > @@ -132,31 +133,12 @@ static struct soc15_allowed_register_entry soc24_=
allowed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> >  };
> >
> > -static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev=
,
> > -                                           u32 se_num,
> > -                                           u32 sh_num,
> > -                                           u32 reg_offset)
> > -{
> > -       uint32_t val;
> > -
> > -       mutex_lock(&adev->grbm_idx_mutex);
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffffff=
f, 0);
> > -
> > -       val =3D RREG32(reg_offset);
> > -
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0=
xffffffff, 0);
> > -       mutex_unlock(&adev->grbm_idx_mutex);
> > -       return val;
> > -}
> > -
> >  static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
> >                                          bool indexed, u32 se_num,
> >                                          u32 sh_num, u32 reg_offset)
> >  {
> >         if (indexed) {
> > -               return soc24_read_indexed_register(adev, se_num, sh_num=
, reg_offset);
> > +               return read_indexed_register(adev, se_num, sh_num, reg_=
offset);
> >         } else {
> >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADD=
R_CONFIG) &&
> >                     adev->gfx.config.gb_addr_config)
> > @@ -455,12 +437,7 @@ static int soc24_common_late_init(struct amdgpu_ip=
_block *ip_block)
> >
> >  static int soc24_common_sw_init(struct amdgpu_ip_block *ip_block)
> >  {
> > -       struct amdgpu_device *adev =3D ip_block->adev;
> > -
> > -       if (amdgpu_sriov_vf(adev))
> > -               xgpu_nv_mailbox_add_irq_id(adev);
> > -
> > -       return 0;
> > +       return common_sw_init(ip_block);
> >  }
> >
> >  static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/am=
d/amdgpu/soc_v1_0.c
> > index 709b1669b..2f77fb0b6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > @@ -21,6 +21,7 @@
> >   *
> >   */
> >  #include "amdgpu.h"
> > +#include "amdgpu_common.h"
> >  #include "soc15.h"
> >  #include "soc15_common.h"
> >  #include "soc_v1_0.h"
> > @@ -184,31 +185,13 @@ static struct soc15_allowed_register_entry soc_v1=
_0_allowed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
> >  };
> >
> > -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *a=
dev,
> > -                                              u32 se_num,
> > -                                              u32 sh_num,
> > -                                              u32 reg_offset)
> > -{
> > -       uint32_t val;
> > -
> > -       mutex_lock(&adev->grbm_idx_mutex);
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffffff=
f, 0);
> > -
> > -       val =3D RREG32(reg_offset);
> > -
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0=
xffffffff, 0);
> > -       mutex_unlock(&adev->grbm_idx_mutex);
> > -       return val;
> > -}
> >
> >  static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev=
,
> >                                             bool indexed, u32 se_num,
> >                                             u32 sh_num, u32 reg_offset)
> >  {
> >         if (indexed) {
> > -               return soc_v1_0_read_indexed_register(adev, se_num, sh_=
num, reg_offset);
> > +               return read_indexed_register(adev, se_num, sh_num, reg_=
offset);
> >         } else {
> >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADD=
R_CONFIG_1) &&
> >                     adev->gfx.config.gb_addr_config)
> > --
> > 2.43.0
> >
>
