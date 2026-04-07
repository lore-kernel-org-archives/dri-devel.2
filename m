Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5FCEDB7CA
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 07:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D70210E34D;
	Tue,  7 Apr 2026 07:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="meyUFXrX";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C147810E305
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 00:59:23 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-82a893d289bso1886040b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 17:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775523563; cv=none;
 d=google.com; s=arc-20240605;
 b=U2KZGKBWOoMc/yVPXcIcPK1m/p77OGUrDd194kdQAX7qlhZh77t6juUN3EYQBgafaY
 n1cm+mPVx/Cj+JUiuauJLfRGfMAh4FnfGdHTbDfSq3Yig6KiJt2kn8osVU/9Lyj8FSgc
 aYwJG0mSaigBgB3/krtrwSipRtQkuls4xmX6kWZMj2gjPIx29tgq7hGgNS816Mix0XCJ
 o68lyrKpKo9sWS4W7PoTEVgbDiwgxIbR37BAm5QkSEe+hNXcE+p5u2jm7EM3fqsO9i6L
 nMHroLbVhjdqm09NdRGiQGrozf3mM8iyZPH1CT46ruUDRaGesAkqKtPg0BdLbvRfDB/j
 7mxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6QmMjRqyoV0SFMDHfCFFbh4R9qmzLTG4qB0Z0d+Cd74=;
 fh=hDjnJ0s7IAVFHu9Y4nkTbxb1lVN8FaO0FMddrlBrC+Y=;
 b=Et6CtlerrpCBUwOINFNuHCHuFeOd9x6mKPOzqAT8W6TFvizwGTDz4CQOO6otAKv0z3
 GLOUtj/IIFApsRyM08CyeIm59zMhWQXlH4xI5qKKhGxioBuHOssEvcCEMeYGwxFVCvht
 m2J76PGHH9/SIb0vU1DTrcRRrjb60ZQmkMvXmFZOpEQsuHKWkkNCCL5bwtzTHagOPF2+
 UVIqFwcCL4iYy3zMeAyK3qvEOopsZkevKIGxdR0xvhOcGSUnU5Uw3F4upTfnqMof3HhY
 UmxCzvCdUtlf0A3wHaGr5wHyv1KlAPuH7seDL0ktwzgNAHEBuuEUI8bDHXkslKgvkBIu
 tgIg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775523563; x=1776128363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QmMjRqyoV0SFMDHfCFFbh4R9qmzLTG4qB0Z0d+Cd74=;
 b=meyUFXrX40rQs+RzQ4k9Zw87L473rZvB2sNJUrvkpo/UwwMjeScZGiEzUd0c71VFrI
 bae4Jg1AYU+WyUe2Bvq426IP9dKDMndZF1bT5TrT9HowHWodMA/t+f4yTEMI6vLaofVw
 poDiUE1EfnmLVmsI/Y2nmKN/bRpPHI+G87Ywe6iUdSBaxmKxfmY2CT8yOYJqSIhUgxZy
 cCq/KkdWHA/ICkBnjUSGKswYRgBWsO8//a5WuVoonry3KafgdcDxAxQ8JJwlwvrbWESQ
 mP6by8h5sSTymQolIRdYsDBe6DAITeRsWIQcikAYtD4rnFgdQ+r97eNn3X/vMnQikV7R
 cKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775523563; x=1776128363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6QmMjRqyoV0SFMDHfCFFbh4R9qmzLTG4qB0Z0d+Cd74=;
 b=TSAoU8rWtZuNQyy2kkx6Lwu8rwGk+zyR0K4MPx4wthXgfl/OVt6RxhFcjdWkoSZGN5
 qzcLjGRtI+v1+v9/mpWvV9NOwfybSMAC4eF7PoybZoEFKHdTA/ExVnalCjBHVv8NGlbB
 V4pCh/drpg0C/QPl2YdgvH/nbz6T1JEVtpZX6+gkGgf7yyJbNo83WJfqkXIimrK88N/R
 gB6M4G162EFELV88gr8iIfTQkdUWZ64VYUUp89ypnxhlpMqGU2J+RG1kbmCZHzpncT0L
 w7VVWmN3nFNBEWjCONp/yjko+yD9w5rm3Fbfr4SP4Hr7AX+uJkOJvs2zn722nLZ2GVHB
 nxsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoyJHHp7Nalb6revtY2WL67gXMuBytFJ9KM8P3VJYGwEY0NLruiEOyC3/8LXR5APzocd+yHi/OVmc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7LMJIm9vM2Vw+u6B0DRVSjG6MGIFEDjnWgchkkGzad+FNW+76
 yk/vTpFZlEl/KPca1s7ztTR4ZK0kYUEKkalgcn+VSjw4Efzfsz9pbluUQSwr+k07QswyJNtsQfN
 AuS0lz0QbriKmQYuNlaWwp3hHXr/pNSS2hNKJcVc=
X-Gm-Gg: AeBDiesNwgDWCg1Sp47b/uB9S11VENELIBEVcg9x63rVcTtc+59hrATin4Ng56NxztP
 qxkZI7V5egSaoF0WosNLrzKIJNf9aoHusqlrW2cmRLJ6oNcRYYUtVC91a8Ku3YeV0gYgNzF/Gwe
 fBdCWjSeEyUF/ofmkYliNeKiz/oQlJnXo8H+QLncjbfTEAxMyaiWqL9gwc/YQMKWxbDFKYhq/D7
 UTeHkZIq8xPG2r2F4QVHz1UxeX4IPB8yKWjTkKUD43F3tZ/G6uublaYh9wEpk1laqsUT3jnWU8p
 qmn/eb1X8jDCyUTx7jCFN9+pv8kvxjTHGN/aL94=
X-Received: by 2002:a05:6a00:418e:b0:829:809e:8977 with SMTP id
 d2e1a72fcca58-82d0dbbabe9mr14058590b3a.49.1775523563008; Mon, 06 Apr 2026
 17:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260330224503.548284-1-gabrielsousa230@gmail.com>
 <01989c65-1e1e-4f78-ac88-a1c76961b3c3@amd.com>
 <CADnq5_N6bzHTQJjS6__-Fmp15fASUw3C5DG1uNvZgkxCRtFkcw@mail.gmail.com>
 <CALsHKmUeB3=H9=Nq=+jOvtmwXxSg=wtHrASZNvVVPQwpyem2ug@mail.gmail.com>
 <CADnq5_Pf841oeJAwhLp=1Y_tOWmEX+gyhDW06Z=qr+FR4x4JEw@mail.gmail.com>
 <11e4daaa-0f1e-4fd4-b435-d2fa9d058869@amd.com>
 <162848f7-ee9f-4bac-83e8-84863081dc60@amd.com>
In-Reply-To: <162848f7-ee9f-4bac-83e8-84863081dc60@amd.com>
From: Gabriel Almeida <gabrielsousa230@gmail.com>
Date: Mon, 6 Apr 2026 21:59:11 -0300
X-Gm-Features: AQROBzCT90vAADVehvSm-H5oj3vBKLsMR-Ip8pY5530fFJQpP5rg8oZbgympGXA
Message-ID: <CALsHKmV2rsZ9qZ+Mncr-1qhnPZWYrH9OVqMnCdYtAMFr7v_RrA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: deduplicate register access and helper
 routines
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 alexander.deucher@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 07 Apr 2026 07:41:20 +0000
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

Hi all,

First, thank you all for the feedback and help.

Based on all the messages, I'll change the patch as follows:
- Move read_indexed_register function to amdgpu_reg_access.c and
rename it to amdgpu_read_indexed_register
- Move program_aspm function to amdgpu_nbio.c and rename it to
amdgpu_nbio_program_aspm
- Remove the change in common_sw_init function
- Delete the proposed amdgpu_common file

Does it look good to you?

Best regards,
Gabriel Almeida

Em qua., 1 de abr. de 2026 =C3=A0s 05:21, Christian K=C3=B6nig
<christian.koenig@amd.com> escreveu:
>
> On 4/1/26 08:58, Lazar, Lijo wrote:
> >
> >
> > On 01-Apr-26 2:51 AM, Alex Deucher wrote:
> >> On Tue, Mar 31, 2026 at 5:07=E2=80=AFPM Gabriel Almeida
> >> <gabrielsousa230@gmail.com> wrote:
> >>>
> >>> Hi Christian and Alex,
> >>>
> >>> Thank you both for your feedback.
> >>>
> >>> I understand that there can be differences between these functions du=
e to
> >>> different macro values across hardware generations. I admit that I di=
dn=E2=80=99t
> >>> fully take that into account in this patch.
> >>>
> >>> Among the functions I modified, `program_aspm` and `common_sw_init` s=
eem
> >>> to have identical behavior regardless of those macros, so I thought t=
hey
> >>> could be good candidates for shared helper functions. That said,
> >>> `common_sw_init` is currently only identical across NV, SOC21 and SOC=
24,
> >>> so I=E2=80=99m not sure if you would consider it generic enough for s=
uch use.
> >>>
> >>> Regarding `read_indexed_register`, I=E2=80=99m still uncertain due to=
 the use of
> >>> the `RREG32` macro. From what I=E2=80=99ve seen so far, it appears to=
 behave
> >>> consistently across these implementations, but I may be missing some
> >>> subtleties.
> >>
> >> You are correct.  the RREG32 and WREG32 macros are the same on all chi=
ps.
> >>
> >>>
> >>> Also, when Christian mentioned =E2=80=9Cmove them a layer up=E2=80=9D=
, do you mean moving
> >>> these helpers into an existing common file such as `amdgpu_device.c`
> >>> instead of introducing a new file like `amdgpu_common.c/h`? I can rew=
ork
> >>> the patch accordingly and drop the new files if that is the preferred
> >>> approach.
> >>
> >> I think something like  amdgpu_common_helpers.c is fine, although
> >> thinking about it more, I think the program_aspm() function should
> >> probably end up in amdgpu_nbio.c as something like
> >> amdgpu_nbio_program_aspm().  read_indexed_register() could probably go
> >> in amdgpu_device.c as amdgpu_device_read_indexed_register_helper().
> >
> > For the grbm register access one, consider keeping it in amdgpu_reg_acc=
ess.c
>
> Yeah I wanted to suggest something similar.
>
> In general the driver code files are mostly organized like this:
>
> * amdgpu_drv.[ch]       Code for the whole driver, e.g. module_init and c=
o.
> * amdgpu_device.[ch]    Code for a specific adev instance.
> * amdgpu_$ip.[ch]       Code for this specific HW IP which is independent=
 of the HW generation (e.g. amdgpu_sdma.c)
> * $ip_$version.[ch]     Code for a specific IP in a specific HW generatio=
n (e.g. sdma_v6_0.c)
> * $HW_gen.[ch]          Code for a specififc HW generation (e.g. cik.c or=
 soc15.c....)
> * $whatever.[ch]        Code for interfacing with kernel subsystem, featu=
re, task, whatever (e.g. amdgpu_ttm.c, amdgpu_cs.c...)
>
> So when you have some common functionality that should either go into amd=
gpu_device.c or amdgpu_$ip.[ch].
>
> Regards,
> Christian.
Thanks for sharing this with me. I wasn't aware of this organization,
and it will be very helpful to understand it.
>
> >
> > Thanks,
> > Lijo
> >
> >> And finally I'm not sure it's worth breaking out common_sw_init() as a
> >> separate function.  Maybe drop that change.
> >>
> >> Alex
> >>
> >>>
> >>> I can also incorporate Alex=E2=80=99s suggestions regarding naming an=
d licensing.
> >>>
> >>> Given these points, I=E2=80=99d like to better understand which direc=
tion you
> >>> would prefer for this change.
> >>>
> >>> Thanks again for your time and guidance.
> >>>
> >>> Best regards,
> >>> Gabriel Almeida
> >>>
> >>>
> >>> Em ter., 31 de mar. de 2026 =C3=A0s 10:31, Alex Deucher
> >>> <alexdeucher@gmail.com> escreveu:
> >>>>
> >>>> On Tue, Mar 31, 2026 at 7:34=E2=80=AFAM Christian K=C3=B6nig
> >>>> <christian.koenig@amd.com> wrote:
> >>>>>
> >>>>> On 3/31/26 00:45, Gabriel Almeida wrote:
> >>>>>> Some helper functions are implemented multiple times with identica=
l
> >>>>>> logic across different source files.
> >>>>>
> >>>>> And that is at least sometimes completely intentional.
> >>>>>
> >>>>> Background is that different headers are included which define macr=
os with different values for each HW generation.
> >>>>>
> >>>>>>
> >>>>>> Extract these implementations into a shared helper file
> >>>>>> (amdgpu_common.c) and update existing code to reuse them.
> >>>>>
> >>>>> Please don't when they are functional identical then move them a la=
yer up instead of messing up the backends.
> >>>>>
> >>>>> Regards,
> >>>>> Christian.
> >>>>>
> >>>>>>
> >>>>>> This simplifies the codebase and avoids duplication without
> >>>>>> changing behavior.
> >>>>>>
> >>>>>> No functional changes intended.
> >>>>>>
> >>>>>> Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> >>>>>> ---
> >>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile        |  2 ++
> >>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_common.c | 42 ++++++++++++++++=
++++++
> >>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_common.h | 12 +++++++
> >>>>
> >>>> I think amdgpu_common_helper.c/h would be better.
> >>>>
> >>>>>>   drivers/gpu/drm/amd/amdgpu/nv.c            | 38 +++-------------=
----
> >>>>>>   drivers/gpu/drm/amd/amdgpu/soc15.c         | 31 ++--------------
> >>>>>>   drivers/gpu/drm/amd/amdgpu/soc21.c         | 38 +++-------------=
----
> >>>>>>   drivers/gpu/drm/amd/amdgpu/soc24.c         | 29 ++-------------
> >>>>>>   drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      | 21 ++---------
> >>>>>>   8 files changed, 72 insertions(+), 141 deletions(-)
> >>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
> >>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm=
/amd/amdgpu/Makefile
> >>>>>> index 6a7e9bfec..84cce03d7 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> >>>>>> @@ -69,6 +69,8 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_reg_access.=
o amdgpu_doorbell_mgr.o amdgpu_kms
> >>>>>>          amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.=
o amdgpu_dev_coredump.o \
> >>>>>>          amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.=
o amdgpu_ip.o
> >>>>>>
> >>>>>> +amdgpu-y +=3D amdgpu_common.o
> >>>>>> +
> >>>>>>   amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
> >>>>>>
> >>>>>>   amdgpu-$(CONFIG_PERF_EVENTS) +=3D amdgpu_pmu.o
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_common.c
> >>>>>> new file mode 100644
> >>>>>> index 000000000..34ade6f63
> >>>>>> --- /dev/null
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
> >>>>>> @@ -0,0 +1,42 @@
> >>>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>
> >>>> This should be MIT
> >>>>
> >>>>>> +#include <linux/module.h>
> >>>>>> +
> >>>>>> +#include "amdgpu.h"
> >>>>>> +#include "amdgpu_common.h"
> >>>>>> +#include "mxgpu_nv.h"
> >>>>>> +
> >>>>>> +uint32_t read_indexed_register(struct amdgpu_device *adev,
> >>>>>> +                              u32 se_num, u32 sh_num, u32 reg_off=
set)
> >>>>>> +{
> >>>>>> +       uint32_t val;
> >>>>>> +
> >>>>>> +       mutex_lock(&adev->grbm_idx_mutex);
> >>>>>> +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> >>>>>> +               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xff=
ffffff, 0);
> >>>>>> +
> >>>>>> +       val =3D RREG32(reg_offset);
> >>>>>> +
> >>>>>> +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> >>>>>> +               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffff=
ff, 0xffffffff, 0);
> >>>>>> +       mutex_unlock(&adev->grbm_idx_mutex);
> >>>>>> +       return val;
> >>>>>> +}
> >>>>>> +
> >>>>>> +void program_aspm(struct amdgpu_device *adev)
> >>>>>> +{
> >>>>>> +       if (!amdgpu_device_should_use_aspm(adev))
> >>>>>> +               return;
> >>>>>> +
> >>>>>> +       if (adev->nbio.funcs->program_aspm)
> >>>>>> +               adev->nbio.funcs->program_aspm(adev);
> >>>>>> +}
> >>>>>> +
> >>>>>> +int common_sw_init(struct amdgpu_ip_block *ip_block)
> >>>>
> >>>> Please prefix each of these functions with amdgpu_common_helper_
> >>>>
> >>>>>> +{
> >>>>>> +       struct amdgpu_device *adev =3D ip_block->adev;
> >>>>>> +
> >>>>>> +       if (amdgpu_sriov_vf(adev))
> >>>>>> +               xgpu_nv_mailbox_add_irq_id(adev);
> >>>>>> +
> >>>>>> +       return 0;
> >>>>>> +}
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_common.h
> >>>>>> new file mode 100644
> >>>>>> index 000000000..314b3506b
> >>>>>> --- /dev/null
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> >>>>>> @@ -0,0 +1,12 @@
> >>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>>
> >>>> This should be MIT
> >>>>
> >>>> Alex
> >>>>
> >>>>>> +#ifndef __AMDGPU_COMMON_H__
> >>>>>> +#define __AMDGPU_COMMON_H__
> >>>>>> +
> >>>>>> +uint32_t read_indexed_register(struct amdgpu_device *adev,
> >>>>>> +                              u32 se_num, u32 sh_num, u32 reg_off=
set);
> >>>>>> +
> >>>>>> +void program_aspm(struct amdgpu_device *adev);
> >>>>>> +
> >>>>>> +int common_sw_init(struct amdgpu_ip_block *ip_block);
> >>>>>> +
> >>>>>> +#endif
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd=
/amdgpu/nv.c
> >>>>>> index 7ce1a1b95..cf8052c73 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> >>>>>> @@ -29,6 +29,7 @@
> >>>>>>
> >>>>>>   #include "amdgpu.h"
> >>>>>>   #include "amdgpu_atombios.h"
> >>>>>> +#include "amdgpu_common.h"
> >>>>>>   #include "amdgpu_ih.h"
> >>>>>>   #include "amdgpu_uvd.h"
> >>>>>>   #include "amdgpu_vce.h"
> >>>>>> @@ -354,29 +355,13 @@ static struct soc15_allowed_register_entry n=
v_allowed_read_registers[] =3D {
> >>>>>>          { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
> >>>>>>   };
> >>>>>>
> >>>>>> -static uint32_t nv_read_indexed_register(struct amdgpu_device *ad=
ev, u32 se_num,
> >>>>>> -                                        u32 sh_num, u32 reg_offse=
t)
> >>>>>> -{
> >>>>>> -       uint32_t val;
> >>>>>> -
> >>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
> >>>>>> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> >>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xff=
ffffff, 0);
> >>>>>> -
> >>>>>> -       val =3D RREG32(reg_offset);
> >>>>>> -
> >>>>>> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> >>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffff=
ff, 0xffffffff, 0);
> >>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
> >>>>>> -       return val;
> >>>>>> -}
> >>>>>>
> >>>>>>   static uint32_t nv_get_register_value(struct amdgpu_device *adev=
,
> >>>>>>                                        bool indexed, u32 se_num,
> >>>>>>                                        u32 sh_num, u32 reg_offset)
> >>>>>>   {
> >>>>>>          if (indexed) {
> >>>>>> -               return nv_read_indexed_register(adev, se_num, sh_n=
um, reg_offset);
> >>>>>> +               return read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >>>>>>          } else {
> >>>>>>                  if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmG=
B_ADDR_CONFIG))
> >>>>>>                          return adev->gfx.config.gb_addr_config;
> >>>>>> @@ -511,16 +496,6 @@ static int nv_set_vce_clocks(struct amdgpu_de=
vice *adev, u32 evclk, u32 ecclk)
> >>>>>>          return 0;
> >>>>>>   }
> >>>>>>
> >>>>>> -static void nv_program_aspm(struct amdgpu_device *adev)
> >>>>>> -{
> >>>>>> -       if (!amdgpu_device_should_use_aspm(adev))
> >>>>>> -               return;
> >>>>>> -
> >>>>>> -       if (adev->nbio.funcs->program_aspm)
> >>>>>> -               adev->nbio.funcs->program_aspm(adev);
> >>>>>> -
> >>>>>> -}
> >>>>>> -
> >>>>>>   const struct amdgpu_ip_block_version nv_common_ip_block =3D {
> >>>>>>          .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> >>>>>>          .major =3D 1,
> >>>>>> @@ -965,12 +940,7 @@ static int nv_common_late_init(struct amdgpu_=
ip_block *ip_block)
> >>>>>>
> >>>>>>   static int nv_common_sw_init(struct amdgpu_ip_block *ip_block)
> >>>>>>   {
> >>>>>> -       struct amdgpu_device *adev =3D ip_block->adev;
> >>>>>> -
> >>>>>> -       if (amdgpu_sriov_vf(adev))
> >>>>>> -               xgpu_nv_mailbox_add_irq_id(adev);
> >>>>>> -
> >>>>>> -       return 0;
> >>>>>> +       return common_sw_init(ip_block);
> >>>>>>   }
> >>>>>>
> >>>>>>   static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
> >>>>>> @@ -984,7 +954,7 @@ static int nv_common_hw_init(struct amdgpu_ip_=
block *ip_block)
> >>>>>>                  adev->nbio.funcs->apply_l1_link_width_reconfig_wa=
(adev);
> >>>>>>
> >>>>>>          /* enable aspm */
> >>>>>> -       nv_program_aspm(adev);
> >>>>>> +       program_aspm(adev);
> >>>>>>          /* setup nbio registers */
> >>>>>>          adev->nbio.funcs->init_registers(adev);
> >>>>>>          /* remap HDP registers to a hole in mmio space,
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/=
amd/amdgpu/soc15.c
> >>>>>> index b456e4541..a6b91363d 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >>>>>> @@ -28,6 +28,7 @@
> >>>>>>   #include <drm/amdgpu_drm.h>
> >>>>>>
> >>>>>>   #include "amdgpu.h"
> >>>>>> +#include "amdgpu_common.h"
> >>>>>>   #include "amdgpu_ih.h"
> >>>>>>   #include "amdgpu_uvd.h"
> >>>>>>   #include "amdgpu_vce.h"
> >>>>>> @@ -401,29 +402,12 @@ static struct soc15_allowed_register_entry s=
oc15_allowed_read_registers[] =3D {
> >>>>>>          { SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
> >>>>>>   };
> >>>>>>
> >>>>>> -static uint32_t soc15_read_indexed_register(struct amdgpu_device =
*adev, u32 se_num,
> >>>>>> -                                        u32 sh_num, u32 reg_offse=
t)
> >>>>>> -{
> >>>>>> -       uint32_t val;
> >>>>>> -
> >>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
> >>>>>> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> >>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xff=
ffffff, 0);
> >>>>>> -
> >>>>>> -       val =3D RREG32(reg_offset);
> >>>>>> -
> >>>>>> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> >>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffff=
ff, 0xffffffff, 0);
> >>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
> >>>>>> -       return val;
> >>>>>> -}
> >>>>>> -
> >>>>>>   static uint32_t soc15_get_register_value(struct amdgpu_device *a=
dev,
> >>>>>>                                           bool indexed, u32 se_num=
,
> >>>>>>                                           u32 sh_num, u32 reg_offs=
et)
> >>>>>>   {
> >>>>>>          if (indexed) {
> >>>>>> -               return soc15_read_indexed_register(adev, se_num, s=
h_num, reg_offset);
> >>>>>> +               return read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >>>>>>          } else {
> >>>>>>                  if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmG=
B_ADDR_CONFIG))
> >>>>>>                          return adev->gfx.config.gb_addr_config;
> >>>>>> @@ -695,15 +679,6 @@ static int soc15_set_vce_clocks(struct amdgpu=
_device *adev, u32 evclk, u32 ecclk
> >>>>>>          return 0;
> >>>>>>   }
> >>>>>>
> >>>>>> -static void soc15_program_aspm(struct amdgpu_device *adev)
> >>>>>> -{
> >>>>>> -       if (!amdgpu_device_should_use_aspm(adev))
> >>>>>> -               return;
> >>>>>> -
> >>>>>> -       if (adev->nbio.funcs->program_aspm)
> >>>>>> -               adev->nbio.funcs->program_aspm(adev);
> >>>>>> -}
> >>>>>> -
> >>>>>>   const struct amdgpu_ip_block_version vega10_common_ip_block =3D
> >>>>>>   {
> >>>>>>          .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> >>>>>> @@ -1284,7 +1259,7 @@ static int soc15_common_hw_init(struct amdgp=
u_ip_block *ip_block)
> >>>>>>          struct amdgpu_device *adev =3D ip_block->adev;
> >>>>>>
> >>>>>>          /* enable aspm */
> >>>>>> -       soc15_program_aspm(adev);
> >>>>>> +       program_aspm(adev);
> >>>>>>          /* setup nbio registers */
> >>>>>>          adev->nbio.funcs->init_registers(adev);
> >>>>>>          /* remap HDP registers to a hole in mmio space,
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/=
amd/amdgpu/soc21.c
> >>>>>> index fbd1d97f3..586d62202 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> >>>>>> @@ -27,6 +27,7 @@
> >>>>>>
> >>>>>>   #include "amdgpu.h"
> >>>>>>   #include "amdgpu_atombios.h"
> >>>>>> +#include "amdgpu_common.h"
> >>>>>>   #include "amdgpu_ih.h"
> >>>>>>   #include "amdgpu_uvd.h"
> >>>>>>   #include "amdgpu_vce.h"
> >>>>>> @@ -306,29 +307,12 @@ static struct soc15_allowed_register_entry s=
oc21_allowed_read_registers[] =3D {
> >>>>>>          { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> >>>>>>   };
> >>>>>>
> >>>>>> -static uint32_t soc21_read_indexed_register(struct amdgpu_device =
*adev, u32 se_num,
> >>>>>> -                                        u32 sh_num, u32 reg_offse=
t)
> >>>>>> -{
> >>>>>> -       uint32_t val;
> >>>>>> -
> >>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
> >>>>>> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> >>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xff=
ffffff, 0);
> >>>>>> -
> >>>>>> -       val =3D RREG32(reg_offset);
> >>>>>> -
> >>>>>> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> >>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffff=
ff, 0xffffffff, 0);
> >>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
> >>>>>> -       return val;
> >>>>>> -}
> >>>>>> -
> >>>>>>   static uint32_t soc21_get_register_value(struct amdgpu_device *a=
dev,
> >>>>>>                                        bool indexed, u32 se_num,
> >>>>>>                                        u32 sh_num, u32 reg_offset)
> >>>>>>   {
> >>>>>>          if (indexed) {
> >>>>>> -               return soc21_read_indexed_register(adev, se_num, s=
h_num, reg_offset);
> >>>>>> +               return read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >>>>>>          } else {
> >>>>>>                  if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, reg=
GB_ADDR_CONFIG) && adev->gfx.config.gb_addr_config)
> >>>>>>                          return adev->gfx.config.gb_addr_config;
> >>>>>> @@ -470,15 +454,6 @@ static int soc21_set_vce_clocks(struct amdgpu=
_device *adev, u32 evclk, u32 ecclk
> >>>>>>          return 0;
> >>>>>>   }
> >>>>>>
> >>>>>> -static void soc21_program_aspm(struct amdgpu_device *adev)
> >>>>>> -{
> >>>>>> -       if (!amdgpu_device_should_use_aspm(adev))
> >>>>>> -               return;
> >>>>>> -
> >>>>>> -       if (adev->nbio.funcs->program_aspm)
> >>>>>> -               adev->nbio.funcs->program_aspm(adev);
> >>>>>> -}
> >>>>>> -
> >>>>>>   const struct amdgpu_ip_block_version soc21_common_ip_block =3D {
> >>>>>>          .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> >>>>>>          .major =3D 1,
> >>>>>> @@ -912,12 +887,7 @@ static int soc21_common_late_init(struct amdg=
pu_ip_block *ip_block)
> >>>>>>
> >>>>>>   static int soc21_common_sw_init(struct amdgpu_ip_block *ip_block=
)
> >>>>>>   {
> >>>>>> -       struct amdgpu_device *adev =3D ip_block->adev;
> >>>>>> -
> >>>>>> -       if (amdgpu_sriov_vf(adev))
> >>>>>> -               xgpu_nv_mailbox_add_irq_id(adev);
> >>>>>> -
> >>>>>> -       return 0;
> >>>>>> +       return common_sw_init(ip_block);
> >>>>>>   }
> >>>>>>
> >>>>>>   static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block=
)
> >>>>>> @@ -925,7 +895,7 @@ static int soc21_common_hw_init(struct amdgpu_=
ip_block *ip_block)
> >>>>>>          struct amdgpu_device *adev =3D ip_block->adev;
> >>>>>>
> >>>>>>          /* enable aspm */
> >>>>>> -       soc21_program_aspm(adev);
> >>>>>> +       program_aspm(adev);
> >>>>>>          /* setup nbio registers */
> >>>>>>          adev->nbio.funcs->init_registers(adev);
> >>>>>>          /* remap HDP registers to a hole in mmio space,
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/=
amd/amdgpu/soc24.c
> >>>>>> index d1adf19a5..f9341c0e4 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> >>>>>> @@ -26,6 +26,7 @@
> >>>>>>   #include <linux/pci.h>
> >>>>>>
> >>>>>>   #include "amdgpu.h"
> >>>>>> +#include "amdgpu_common.h"
> >>>>>>   #include "amdgpu_ih.h"
> >>>>>>   #include "amdgpu_uvd.h"
> >>>>>>   #include "amdgpu_vce.h"
> >>>>>> @@ -132,31 +133,12 @@ static struct soc15_allowed_register_entry s=
oc24_allowed_read_registers[] =3D {
> >>>>>>          { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> >>>>>>   };
> >>>>>>
> >>>>>> -static uint32_t soc24_read_indexed_register(struct amdgpu_device =
*adev,
> >>>>>> -                                           u32 se_num,
> >>>>>> -                                           u32 sh_num,
> >>>>>> -                                           u32 reg_offset)
> >>>>>> -{
> >>>>>> -       uint32_t val;
> >>>>>> -
> >>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
> >>>>>> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> >>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xff=
ffffff, 0);
> >>>>>> -
> >>>>>> -       val =3D RREG32(reg_offset);
> >>>>>> -
> >>>>>> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> >>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffff=
ff, 0xffffffff, 0);
> >>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
> >>>>>> -       return val;
> >>>>>> -}
> >>>>>> -
> >>>>>>   static uint32_t soc24_get_register_value(struct amdgpu_device *a=
dev,
> >>>>>>                                           bool indexed, u32 se_num=
,
> >>>>>>                                           u32 sh_num, u32 reg_offs=
et)
> >>>>>>   {
> >>>>>>          if (indexed) {
> >>>>>> -               return soc24_read_indexed_register(adev, se_num, s=
h_num, reg_offset);
> >>>>>> +               return read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >>>>>>          } else {
> >>>>>>                  if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, reg=
GB_ADDR_CONFIG) &&
> >>>>>>                      adev->gfx.config.gb_addr_config)
> >>>>>> @@ -455,12 +437,7 @@ static int soc24_common_late_init(struct amdg=
pu_ip_block *ip_block)
> >>>>>>
> >>>>>>   static int soc24_common_sw_init(struct amdgpu_ip_block *ip_block=
)
> >>>>>>   {
> >>>>>> -       struct amdgpu_device *adev =3D ip_block->adev;
> >>>>>> -
> >>>>>> -       if (amdgpu_sriov_vf(adev))
> >>>>>> -               xgpu_nv_mailbox_add_irq_id(adev);
> >>>>>> -
> >>>>>> -       return 0;
> >>>>>> +       return common_sw_init(ip_block);
> >>>>>>   }
> >>>>>>
> >>>>>>   static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block=
)
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/d=
rm/amd/amdgpu/soc_v1_0.c
> >>>>>> index 709b1669b..2f77fb0b6 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> >>>>>> @@ -21,6 +21,7 @@
> >>>>>>    *
> >>>>>>    */
> >>>>>>   #include "amdgpu.h"
> >>>>>> +#include "amdgpu_common.h"
> >>>>>>   #include "soc15.h"
> >>>>>>   #include "soc15_common.h"
> >>>>>>   #include "soc_v1_0.h"
> >>>>>> @@ -184,31 +185,13 @@ static struct soc15_allowed_register_entry s=
oc_v1_0_allowed_read_registers[] =3D {
> >>>>>>          { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
> >>>>>>   };
> >>>>>>
> >>>>>> -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_devi=
ce *adev,
> >>>>>> -                                              u32 se_num,
> >>>>>> -                                              u32 sh_num,
> >>>>>> -                                              u32 reg_offset)
> >>>>>> -{
> >>>>>> -       uint32_t val;
> >>>>>> -
> >>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
> >>>>>> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> >>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xff=
ffffff, 0);
> >>>>>> -
> >>>>>> -       val =3D RREG32(reg_offset);
> >>>>>> -
> >>>>>> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> >>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffff=
ff, 0xffffffff, 0);
> >>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
> >>>>>> -       return val;
> >>>>>> -}
> >>>>>>
> >>>>>>   static uint32_t soc_v1_0_get_register_value(struct amdgpu_device=
 *adev,
> >>>>>>                                              bool indexed, u32 se_=
num,
> >>>>>>                                              u32 sh_num, u32 reg_o=
ffset)
> >>>>>>   {
> >>>>>>          if (indexed) {
> >>>>>> -               return soc_v1_0_read_indexed_register(adev, se_num=
, sh_num, reg_offset);
> >>>>>> +               return read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >>>>>>          } else {
> >>>>>>                  if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, reg=
GB_ADDR_CONFIG_1) &&
> >>>>>>                      adev->gfx.config.gb_addr_config)
> >>>>>> --
> >>>>>> 2.43.0
> >>>>>>
> >>>>>
> >
>
