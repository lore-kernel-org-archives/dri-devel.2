Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3256410F9307
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA66C10EBE2;
	Tue, 31 Mar 2026 21:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NXN73vRP";
	dkim-atps=neutral
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A5F10EBC6
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 21:21:46 +0000 (UTC)
Received: by mail-ua1-f44.google.com with SMTP id
 a1e0cc1a2514c-9539989c024so158060241.2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774992105; cv=none;
 d=google.com; s=arc-20240605;
 b=SNizIOiTzgEc/6sJHI170VK57+zNEI0GdAGgEHun16DOk60wlvPjnJnoq6Itb9FEoM
 S6YKjoZOW76YlUEOKdDCM8nkCdy/sb6k4gW9mVNoGIeBCCZZbPAvQZaVGVoV4Kl+jrxD
 8xY1/sPDIbOf5u7MlzS/ap0gJmjzwIL9U+xap9q6ZlkYiT1rIbXoha7yyuiT1qfw0hiQ
 BEiLMA5g2dVOvOsISEvupE7uTIFqJB+zRfatIqG/BdSEpOb4/7uVfT/LGpMj0IHKKM26
 7JJeEH9GFfaTwEJ7A80CdbKyo3NmX76QXJoM4Zvgi/gofwj87dd/qZji+n4W2IWyLQCs
 LI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ndd9Z34WEZDYMcbXqD8LvOCpynn9LLCRPEd7kPtLwxA=;
 fh=ski6QRrxPOS/llDsvCJOiQYHF/Gp2+kTSoox4MfHgqY=;
 b=Vy99QRKs3Av72KW7jlCMS4qxneGnLW49YLTS/CX0b4i3UUnw8aAs7qHRAgpBCVP/yK
 SBFjchfxMlsfKekSvGAkhthpKtWmkWVTUMJTokabTj3hZNygcIY1WH9P+KB7AoIeN7Kn
 ZG63apm1YUf++PLeVIOal/Qhit3TMYjBhlAsUqAHWE90iCAEsi6HjEykMgo63FSFEjoY
 Jm3aSTchwgowYOPuvFsZouvK6uSSPSX49rzoRkWSeMP/S/3eDNBA0nzTNFWDEeryU5yD
 qs6XZmVlzvcoT98SU+W4zpBz8otRfzpiCJMKznWIjemvNImOii1td88hrU0Euh3ZcVWh
 aj2g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774992105; x=1775596905; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ndd9Z34WEZDYMcbXqD8LvOCpynn9LLCRPEd7kPtLwxA=;
 b=NXN73vRPzd29RVeY5IvfMygI37KzITu+HveksAowUoQgCrQGM2gWYDkmjorywJCZQa
 Yfo/D0NmI5bWyb88pPiNMLbDiCRCrmUy1LmDYUGgnEi+IWGeW/d83ErdscZNh4ASHRPR
 75cRHdQn6voFXqfMT4FV5kNFJOUP+vCWtda/ACJBKKxaXFks60G5Yty46bwHMr9NszIB
 hsm8q5FwJIquGX8Sxs4d2fZ8wBFeVD9hOi8AJCHTC/plvKsJEyoW3oSHsVRu8XipS7CC
 iMZtBgSZp3zhyjHfjVh+CnelW2ff2JIQXrK2/ocFLW8OmMxF4eZyG/D/TmMKQDr06bq/
 PNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774992105; x=1775596905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ndd9Z34WEZDYMcbXqD8LvOCpynn9LLCRPEd7kPtLwxA=;
 b=hK++1YbnCz/m7gEJZ1X+OtbFRMttIozqDF7GEDlu7a3/7RIpvY/NUfL/wmwtswusx8
 IBkDBN4ko2jar4G8vyIG8fwQXpuKBgNgqUNzEo9Uxs/hnuYnnKNeuBI3tu5w73wQjcnW
 pfZJ+V6/xDa9eIMnGwVBMLK3JpxaNrZdWGSvugI6bnWtdMKnMDZ7u3FPKs+3cxqPMkD/
 NGa2Yr1XztlMG6DfGcAoDbE4pmJn0RAnNcB90ZOnLhIj/oFlB6KO3gSH0tjJvd+P3Gxv
 I3f6lkHIIh6tE3sLTGKJk/87j+IBzFFmTGn1XOgyi1w70/ao3vSZ/8Egbrut/KpnOXms
 EpzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUckFqHeDG9VouFsXV8tn7mateDcze66iLtAWRRYAHCwG6pMj3W30nxIeRWoBRGumAOwxjSL4WJVPM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4VrMssbkpb+2H83eDvn5kyM93haI5KGUo5iwOWervw/wcafVA
 s1miTsh/QsHfIEQrqwUoTVwqMuaz8fkII5wJ71ODv2ivKSSa3BkHDr8VE/lQx13ha/wzBs9a2jY
 lNpaUNDVMAk26PoXQQPQJQERcVq7f/vI=
X-Gm-Gg: ATEYQzznicdcX55W6h7LgJv3S05ZbNV+tt3V+3a8aXxqb3q1z5sIfRIWKcr5xBV9z+i
 scfBtMVwKI0hHyfym5hpRTdEMSLMQqUtKuzpiwhBNlUYBWERwxgo/+WCEwDW+5due9Ct9brN9bl
 0XGiCeO7Z0bxnVeshGQQKJyzxpvHnMUhHNwQBWjEo6enkCJXYt/OGSH0T58vn5iKfaFD4PpTCle
 HrPD+tjYCUygXfCIiZfN28SLH3uPW/+Y8koNj3ymtI1G1Iq5q2xgyRPfrOt5Q2RbljR5YVvhN2+
 FdcON2qPNQlNqmJpUlaldYO0NqLDafEwQvDb6yEq40MLNumN9FqxL+SAQBxZHhN0iarQycMlPUd
 2TGqR
X-Received: by 2002:a05:6102:3124:b0:602:b87a:3524 with SMTP id
 ada2fe7eead31-605681d3b8bmr124908137.8.1774992104828; Tue, 31 Mar 2026
 14:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260330224503.548284-1-gabrielsousa230@gmail.com>
 <01989c65-1e1e-4f78-ac88-a1c76961b3c3@amd.com>
 <CADnq5_N6bzHTQJjS6__-Fmp15fASUw3C5DG1uNvZgkxCRtFkcw@mail.gmail.com>
 <CALsHKmUeB3=H9=Nq=+jOvtmwXxSg=wtHrASZNvVVPQwpyem2ug@mail.gmail.com>
In-Reply-To: <CALsHKmUeB3=H9=Nq=+jOvtmwXxSg=wtHrASZNvVVPQwpyem2ug@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 17:21:31 -0400
X-Gm-Features: AQROBzD1UR-7HftbCZHmPUQD-2oJPdvHQjuh-tpBm0G09Ba9mWs_j3BjfoLD1VQ
Message-ID: <CADnq5_Pf841oeJAwhLp=1Y_tOWmEX+gyhDW06Z=qr+FR4x4JEw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: deduplicate register access and helper
 routines
To: Gabriel Almeida <gabrielsousa230@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
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

On Tue, Mar 31, 2026 at 5:07=E2=80=AFPM Gabriel Almeida
<gabrielsousa230@gmail.com> wrote:
>
> Hi Christian and Alex,
>
> Thank you both for your feedback.
>
> I understand that there can be differences between these functions due to
> different macro values across hardware generations. I admit that I didn=
=E2=80=99t
> fully take that into account in this patch.
>
> Among the functions I modified, `program_aspm` and `common_sw_init` seem
> to have identical behavior regardless of those macros, so I thought they
> could be good candidates for shared helper functions. That said,
> `common_sw_init` is currently only identical across NV, SOC21 and SOC24,
> so I=E2=80=99m not sure if you would consider it generic enough for such =
use.
>
> Regarding `read_indexed_register`, I=E2=80=99m still uncertain due to the=
 use of
> the `RREG32` macro. From what I=E2=80=99ve seen so far, it appears to beh=
ave
> consistently across these implementations, but I may be missing some
> subtleties.

You are correct.  the RREG32 and WREG32 macros are the same on all chips.

>
> Also, when Christian mentioned =E2=80=9Cmove them a layer up=E2=80=9D, do=
 you mean moving
> these helpers into an existing common file such as `amdgpu_device.c`
> instead of introducing a new file like `amdgpu_common.c/h`? I can rework
> the patch accordingly and drop the new files if that is the preferred
> approach.

I think something like  amdgpu_common_helpers.c is fine, although
thinking about it more, I think the program_aspm() function should
probably end up in amdgpu_nbio.c as something like
amdgpu_nbio_program_aspm().  read_indexed_register() could probably go
in amdgpu_device.c as amdgpu_device_read_indexed_register_helper().
And finally I'm not sure it's worth breaking out common_sw_init() as a
separate function.  Maybe drop that change.

Alex

>
> I can also incorporate Alex=E2=80=99s suggestions regarding naming and li=
censing.
>
> Given these points, I=E2=80=99d like to better understand which direction=
 you
> would prefer for this change.
>
> Thanks again for your time and guidance.
>
> Best regards,
> Gabriel Almeida
>
>
> Em ter., 31 de mar. de 2026 =C3=A0s 10:31, Alex Deucher
> <alexdeucher@gmail.com> escreveu:
> >
> > On Tue, Mar 31, 2026 at 7:34=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> > >
> > > On 3/31/26 00:45, Gabriel Almeida wrote:
> > > > Some helper functions are implemented multiple times with identical
> > > > logic across different source files.
> > >
> > > And that is at least sometimes completely intentional.
> > >
> > > Background is that different headers are included which define macros=
 with different values for each HW generation.
> > >
> > > >
> > > > Extract these implementations into a shared helper file
> > > > (amdgpu_common.c) and update existing code to reuse them.
> > >
> > > Please don't when they are functional identical then move them a laye=
r up instead of messing up the backends.
> > >
> > > Regards,
> > > Christian.
> > >
> > > >
> > > > This simplifies the codebase and avoids duplication without
> > > > changing behavior.
> > > >
> > > > No functional changes intended.
> > > >
> > > > Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/Makefile        |  2 ++
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_common.c | 42 ++++++++++++++++++=
++++
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_common.h | 12 +++++++
> >
> > I think amdgpu_common_helper.c/h would be better.
> >
> > > >  drivers/gpu/drm/amd/amdgpu/nv.c            | 38 +++---------------=
--
> > > >  drivers/gpu/drm/amd/amdgpu/soc15.c         | 31 ++--------------
> > > >  drivers/gpu/drm/amd/amdgpu/soc21.c         | 38 +++---------------=
--
> > > >  drivers/gpu/drm/amd/amdgpu/soc24.c         | 29 ++-------------
> > > >  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      | 21 ++---------
> > > >  8 files changed, 72 insertions(+), 141 deletions(-)
> > > >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
> > > >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/=
amd/amdgpu/Makefile
> > > > index 6a7e9bfec..84cce03d7 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > > > @@ -69,6 +69,8 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_reg_access.o=
 amdgpu_doorbell_mgr.o amdgpu_kms
> > > >         amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o =
amdgpu_dev_coredump.o \
> > > >         amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o =
amdgpu_ip.o
> > > >
> > > > +amdgpu-y +=3D amdgpu_common.o
> > > > +
> > > >  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
> > > >
> > > >  amdgpu-$(CONFIG_PERF_EVENTS) +=3D amdgpu_pmu.o
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_common.c
> > > > new file mode 100644
> > > > index 000000000..34ade6f63
> > > > --- /dev/null
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
> > > > @@ -0,0 +1,42 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> >
> > This should be MIT
> >
> > > > +#include <linux/module.h>
> > > > +
> > > > +#include "amdgpu.h"
> > > > +#include "amdgpu_common.h"
> > > > +#include "mxgpu_nv.h"
> > > > +
> > > > +uint32_t read_indexed_register(struct amdgpu_device *adev,
> > > > +                              u32 se_num, u32 sh_num, u32 reg_offs=
et)
> > > > +{
> > > > +       uint32_t val;
> > > > +
> > > > +       mutex_lock(&adev->grbm_idx_mutex);
> > > > +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > > +               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfff=
fffff, 0);
> > > > +
> > > > +       val =3D RREG32(reg_offset);
> > > > +
> > > > +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > > +               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xfffffff=
f, 0xffffffff, 0);
> > > > +       mutex_unlock(&adev->grbm_idx_mutex);
> > > > +       return val;
> > > > +}
> > > > +
> > > > +void program_aspm(struct amdgpu_device *adev)
> > > > +{
> > > > +       if (!amdgpu_device_should_use_aspm(adev))
> > > > +               return;
> > > > +
> > > > +       if (adev->nbio.funcs->program_aspm)
> > > > +               adev->nbio.funcs->program_aspm(adev);
> > > > +}
> > > > +
> > > > +int common_sw_init(struct amdgpu_ip_block *ip_block)
> >
> > Please prefix each of these functions with amdgpu_common_helper_
> >
> > > > +{
> > > > +       struct amdgpu_device *adev =3D ip_block->adev;
> > > > +
> > > > +       if (amdgpu_sriov_vf(adev))
> > > > +               xgpu_nv_mailbox_add_irq_id(adev);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_common.h
> > > > new file mode 100644
> > > > index 000000000..314b3506b
> > > > --- /dev/null
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> > > > @@ -0,0 +1,12 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> >
> > This should be MIT
> >
> > Alex
> >
> > > > +#ifndef __AMDGPU_COMMON_H__
> > > > +#define __AMDGPU_COMMON_H__
> > > > +
> > > > +uint32_t read_indexed_register(struct amdgpu_device *adev,
> > > > +                              u32 se_num, u32 sh_num, u32 reg_offs=
et);
> > > > +
> > > > +void program_aspm(struct amdgpu_device *adev);
> > > > +
> > > > +int common_sw_init(struct amdgpu_ip_block *ip_block);
> > > > +
> > > > +#endif
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/=
amdgpu/nv.c
> > > > index 7ce1a1b95..cf8052c73 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > > > @@ -29,6 +29,7 @@
> > > >
> > > >  #include "amdgpu.h"
> > > >  #include "amdgpu_atombios.h"
> > > > +#include "amdgpu_common.h"
> > > >  #include "amdgpu_ih.h"
> > > >  #include "amdgpu_uvd.h"
> > > >  #include "amdgpu_vce.h"
> > > > @@ -354,29 +355,13 @@ static struct soc15_allowed_register_entry nv=
_allowed_read_registers[] =3D {
> > > >         { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
> > > >  };
> > > >
> > > > -static uint32_t nv_read_indexed_register(struct amdgpu_device *ade=
v, u32 se_num,
> > > > -                                        u32 sh_num, u32 reg_offset=
)
> > > > -{
> > > > -       uint32_t val;
> > > > -
> > > > -       mutex_lock(&adev->grbm_idx_mutex);
> > > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfff=
fffff, 0);
> > > > -
> > > > -       val =3D RREG32(reg_offset);
> > > > -
> > > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xfffffff=
f, 0xffffffff, 0);
> > > > -       mutex_unlock(&adev->grbm_idx_mutex);
> > > > -       return val;
> > > > -}
> > > >
> > > >  static uint32_t nv_get_register_value(struct amdgpu_device *adev,
> > > >                                       bool indexed, u32 se_num,
> > > >                                       u32 sh_num, u32 reg_offset)
> > > >  {
> > > >         if (indexed) {
> > > > -               return nv_read_indexed_register(adev, se_num, sh_nu=
m, reg_offset);
> > > > +               return read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> > > >         } else {
> > > >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_=
ADDR_CONFIG))
> > > >                         return adev->gfx.config.gb_addr_config;
> > > > @@ -511,16 +496,6 @@ static int nv_set_vce_clocks(struct amdgpu_dev=
ice *adev, u32 evclk, u32 ecclk)
> > > >         return 0;
> > > >  }
> > > >
> > > > -static void nv_program_aspm(struct amdgpu_device *adev)
> > > > -{
> > > > -       if (!amdgpu_device_should_use_aspm(adev))
> > > > -               return;
> > > > -
> > > > -       if (adev->nbio.funcs->program_aspm)
> > > > -               adev->nbio.funcs->program_aspm(adev);
> > > > -
> > > > -}
> > > > -
> > > >  const struct amdgpu_ip_block_version nv_common_ip_block =3D {
> > > >         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> > > >         .major =3D 1,
> > > > @@ -965,12 +940,7 @@ static int nv_common_late_init(struct amdgpu_i=
p_block *ip_block)
> > > >
> > > >  static int nv_common_sw_init(struct amdgpu_ip_block *ip_block)
> > > >  {
> > > > -       struct amdgpu_device *adev =3D ip_block->adev;
> > > > -
> > > > -       if (amdgpu_sriov_vf(adev))
> > > > -               xgpu_nv_mailbox_add_irq_id(adev);
> > > > -
> > > > -       return 0;
> > > > +       return common_sw_init(ip_block);
> > > >  }
> > > >
> > > >  static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
> > > > @@ -984,7 +954,7 @@ static int nv_common_hw_init(struct amdgpu_ip_b=
lock *ip_block)
> > > >                 adev->nbio.funcs->apply_l1_link_width_reconfig_wa(a=
dev);
> > > >
> > > >         /* enable aspm */
> > > > -       nv_program_aspm(adev);
> > > > +       program_aspm(adev);
> > > >         /* setup nbio registers */
> > > >         adev->nbio.funcs->init_registers(adev);
> > > >         /* remap HDP registers to a hole in mmio space,
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/a=
md/amdgpu/soc15.c
> > > > index b456e4541..a6b91363d 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > > @@ -28,6 +28,7 @@
> > > >  #include <drm/amdgpu_drm.h>
> > > >
> > > >  #include "amdgpu.h"
> > > > +#include "amdgpu_common.h"
> > > >  #include "amdgpu_ih.h"
> > > >  #include "amdgpu_uvd.h"
> > > >  #include "amdgpu_vce.h"
> > > > @@ -401,29 +402,12 @@ static struct soc15_allowed_register_entry so=
c15_allowed_read_registers[] =3D {
> > > >         { SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
> > > >  };
> > > >
> > > > -static uint32_t soc15_read_indexed_register(struct amdgpu_device *=
adev, u32 se_num,
> > > > -                                        u32 sh_num, u32 reg_offset=
)
> > > > -{
> > > > -       uint32_t val;
> > > > -
> > > > -       mutex_lock(&adev->grbm_idx_mutex);
> > > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfff=
fffff, 0);
> > > > -
> > > > -       val =3D RREG32(reg_offset);
> > > > -
> > > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xfffffff=
f, 0xffffffff, 0);
> > > > -       mutex_unlock(&adev->grbm_idx_mutex);
> > > > -       return val;
> > > > -}
> > > > -
> > > >  static uint32_t soc15_get_register_value(struct amdgpu_device *ade=
v,
> > > >                                          bool indexed, u32 se_num,
> > > >                                          u32 sh_num, u32 reg_offset=
)
> > > >  {
> > > >         if (indexed) {
> > > > -               return soc15_read_indexed_register(adev, se_num, sh=
_num, reg_offset);
> > > > +               return read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> > > >         } else {
> > > >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_=
ADDR_CONFIG))
> > > >                         return adev->gfx.config.gb_addr_config;
> > > > @@ -695,15 +679,6 @@ static int soc15_set_vce_clocks(struct amdgpu_=
device *adev, u32 evclk, u32 ecclk
> > > >         return 0;
> > > >  }
> > > >
> > > > -static void soc15_program_aspm(struct amdgpu_device *adev)
> > > > -{
> > > > -       if (!amdgpu_device_should_use_aspm(adev))
> > > > -               return;
> > > > -
> > > > -       if (adev->nbio.funcs->program_aspm)
> > > > -               adev->nbio.funcs->program_aspm(adev);
> > > > -}
> > > > -
> > > >  const struct amdgpu_ip_block_version vega10_common_ip_block =3D
> > > >  {
> > > >         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> > > > @@ -1284,7 +1259,7 @@ static int soc15_common_hw_init(struct amdgpu=
_ip_block *ip_block)
> > > >         struct amdgpu_device *adev =3D ip_block->adev;
> > > >
> > > >         /* enable aspm */
> > > > -       soc15_program_aspm(adev);
> > > > +       program_aspm(adev);
> > > >         /* setup nbio registers */
> > > >         adev->nbio.funcs->init_registers(adev);
> > > >         /* remap HDP registers to a hole in mmio space,
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/a=
md/amdgpu/soc21.c
> > > > index fbd1d97f3..586d62202 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > > > @@ -27,6 +27,7 @@
> > > >
> > > >  #include "amdgpu.h"
> > > >  #include "amdgpu_atombios.h"
> > > > +#include "amdgpu_common.h"
> > > >  #include "amdgpu_ih.h"
> > > >  #include "amdgpu_uvd.h"
> > > >  #include "amdgpu_vce.h"
> > > > @@ -306,29 +307,12 @@ static struct soc15_allowed_register_entry so=
c21_allowed_read_registers[] =3D {
> > > >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> > > >  };
> > > >
> > > > -static uint32_t soc21_read_indexed_register(struct amdgpu_device *=
adev, u32 se_num,
> > > > -                                        u32 sh_num, u32 reg_offset=
)
> > > > -{
> > > > -       uint32_t val;
> > > > -
> > > > -       mutex_lock(&adev->grbm_idx_mutex);
> > > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfff=
fffff, 0);
> > > > -
> > > > -       val =3D RREG32(reg_offset);
> > > > -
> > > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xfffffff=
f, 0xffffffff, 0);
> > > > -       mutex_unlock(&adev->grbm_idx_mutex);
> > > > -       return val;
> > > > -}
> > > > -
> > > >  static uint32_t soc21_get_register_value(struct amdgpu_device *ade=
v,
> > > >                                       bool indexed, u32 se_num,
> > > >                                       u32 sh_num, u32 reg_offset)
> > > >  {
> > > >         if (indexed) {
> > > > -               return soc21_read_indexed_register(adev, se_num, sh=
_num, reg_offset);
> > > > +               return read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> > > >         } else {
> > > >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB=
_ADDR_CONFIG) && adev->gfx.config.gb_addr_config)
> > > >                         return adev->gfx.config.gb_addr_config;
> > > > @@ -470,15 +454,6 @@ static int soc21_set_vce_clocks(struct amdgpu_=
device *adev, u32 evclk, u32 ecclk
> > > >         return 0;
> > > >  }
> > > >
> > > > -static void soc21_program_aspm(struct amdgpu_device *adev)
> > > > -{
> > > > -       if (!amdgpu_device_should_use_aspm(adev))
> > > > -               return;
> > > > -
> > > > -       if (adev->nbio.funcs->program_aspm)
> > > > -               adev->nbio.funcs->program_aspm(adev);
> > > > -}
> > > > -
> > > >  const struct amdgpu_ip_block_version soc21_common_ip_block =3D {
> > > >         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> > > >         .major =3D 1,
> > > > @@ -912,12 +887,7 @@ static int soc21_common_late_init(struct amdgp=
u_ip_block *ip_block)
> > > >
> > > >  static int soc21_common_sw_init(struct amdgpu_ip_block *ip_block)
> > > >  {
> > > > -       struct amdgpu_device *adev =3D ip_block->adev;
> > > > -
> > > > -       if (amdgpu_sriov_vf(adev))
> > > > -               xgpu_nv_mailbox_add_irq_id(adev);
> > > > -
> > > > -       return 0;
> > > > +       return common_sw_init(ip_block);
> > > >  }
> > > >
> > > >  static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
> > > > @@ -925,7 +895,7 @@ static int soc21_common_hw_init(struct amdgpu_i=
p_block *ip_block)
> > > >         struct amdgpu_device *adev =3D ip_block->adev;
> > > >
> > > >         /* enable aspm */
> > > > -       soc21_program_aspm(adev);
> > > > +       program_aspm(adev);
> > > >         /* setup nbio registers */
> > > >         adev->nbio.funcs->init_registers(adev);
> > > >         /* remap HDP registers to a hole in mmio space,
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/a=
md/amdgpu/soc24.c
> > > > index d1adf19a5..f9341c0e4 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> > > > @@ -26,6 +26,7 @@
> > > >  #include <linux/pci.h>
> > > >
> > > >  #include "amdgpu.h"
> > > > +#include "amdgpu_common.h"
> > > >  #include "amdgpu_ih.h"
> > > >  #include "amdgpu_uvd.h"
> > > >  #include "amdgpu_vce.h"
> > > > @@ -132,31 +133,12 @@ static struct soc15_allowed_register_entry so=
c24_allowed_read_registers[] =3D {
> > > >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> > > >  };
> > > >
> > > > -static uint32_t soc24_read_indexed_register(struct amdgpu_device *=
adev,
> > > > -                                           u32 se_num,
> > > > -                                           u32 sh_num,
> > > > -                                           u32 reg_offset)
> > > > -{
> > > > -       uint32_t val;
> > > > -
> > > > -       mutex_lock(&adev->grbm_idx_mutex);
> > > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfff=
fffff, 0);
> > > > -
> > > > -       val =3D RREG32(reg_offset);
> > > > -
> > > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xfffffff=
f, 0xffffffff, 0);
> > > > -       mutex_unlock(&adev->grbm_idx_mutex);
> > > > -       return val;
> > > > -}
> > > > -
> > > >  static uint32_t soc24_get_register_value(struct amdgpu_device *ade=
v,
> > > >                                          bool indexed, u32 se_num,
> > > >                                          u32 sh_num, u32 reg_offset=
)
> > > >  {
> > > >         if (indexed) {
> > > > -               return soc24_read_indexed_register(adev, se_num, sh=
_num, reg_offset);
> > > > +               return read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> > > >         } else {
> > > >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB=
_ADDR_CONFIG) &&
> > > >                     adev->gfx.config.gb_addr_config)
> > > > @@ -455,12 +437,7 @@ static int soc24_common_late_init(struct amdgp=
u_ip_block *ip_block)
> > > >
> > > >  static int soc24_common_sw_init(struct amdgpu_ip_block *ip_block)
> > > >  {
> > > > -       struct amdgpu_device *adev =3D ip_block->adev;
> > > > -
> > > > -       if (amdgpu_sriov_vf(adev))
> > > > -               xgpu_nv_mailbox_add_irq_id(adev);
> > > > -
> > > > -       return 0;
> > > > +       return common_sw_init(ip_block);
> > > >  }
> > > >
> > > >  static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block)
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/dr=
m/amd/amdgpu/soc_v1_0.c
> > > > index 709b1669b..2f77fb0b6 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > > > @@ -21,6 +21,7 @@
> > > >   *
> > > >   */
> > > >  #include "amdgpu.h"
> > > > +#include "amdgpu_common.h"
> > > >  #include "soc15.h"
> > > >  #include "soc15_common.h"
> > > >  #include "soc_v1_0.h"
> > > > @@ -184,31 +185,13 @@ static struct soc15_allowed_register_entry so=
c_v1_0_allowed_read_registers[] =3D {
> > > >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
> > > >  };
> > > >
> > > > -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_devic=
e *adev,
> > > > -                                              u32 se_num,
> > > > -                                              u32 sh_num,
> > > > -                                              u32 reg_offset)
> > > > -{
> > > > -       uint32_t val;
> > > > -
> > > > -       mutex_lock(&adev->grbm_idx_mutex);
> > > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfff=
fffff, 0);
> > > > -
> > > > -       val =3D RREG32(reg_offset);
> > > > -
> > > > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > > > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xfffffff=
f, 0xffffffff, 0);
> > > > -       mutex_unlock(&adev->grbm_idx_mutex);
> > > > -       return val;
> > > > -}
> > > >
> > > >  static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *=
adev,
> > > >                                             bool indexed, u32 se_nu=
m,
> > > >                                             u32 sh_num, u32 reg_off=
set)
> > > >  {
> > > >         if (indexed) {
> > > > -               return soc_v1_0_read_indexed_register(adev, se_num,=
 sh_num, reg_offset);
> > > > +               return read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> > > >         } else {
> > > >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB=
_ADDR_CONFIG_1) &&
> > > >                     adev->gfx.config.gb_addr_config)
> > > > --
> > > > 2.43.0
> > > >
> > >
