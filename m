Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72889F5A8AB
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D2FA10E753;
	Mon, 20 Apr 2026 18:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CC8j42ew";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6365B10E752
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 18:35:54 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c1161232dso137059c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 11:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776710154; cv=none;
 d=google.com; s=arc-20240605;
 b=F7x1x0tEU6FUFpqR244Kjd6Lz/sp3OGH1Cn3revY72NN6PcsT7IfzrrDWgGa1v1lWv
 NvsOrPb7zzZcY42VgkaALNFQfI5DtO+AuHc8g00TOTFKFgIKXkZ/2/TCl8KKXQyHJv3x
 U4kyFRJ4aHCeQgiJXoV8cqD3uc/6nRsYdMdpZvF/TAnKnztrHiW+RiTf+c0km5OtRABy
 w8QVLW23mVp3rvToajgyVlqLB4vOoc5hI+gnjmW7fZTAgBR6/CA8+plKbAqgh/REslGm
 V75cafBvdzuSdmfRn5jbtRq01GA3Y9E26C+m1wDtX/sNUGD89RhCbb7qFPNfYeqNx2oh
 vrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uxBm15eIKaXf6CUs+pV/AMJ0q6nJrZkgFaiTVCD3ZSE=;
 fh=SXsiUze2oS89J+XE7XtsCQjwEfGTazIoBIf7xcdRR4s=;
 b=JYi0aUO2hV6mOWg6MlQnZfikAxlYhaQLlfS3V+7WFrqwO7K6eOLMGxGJWgeNkE1gnv
 usMMCvmEN8Imxwl4LFpYVXcaNnMLm9CQW5Tj1YExFOU20tif3Ll7mM9HFdg1NVujvUZc
 ebDPCRDJ8VXYGWqYrYKckoxValHzS2Chy5aYkLI7wAmel0hBUbdaBkWrL1uIOMfwf78W
 WCp9hL8EHxCLZeUUR8QS7fmS38SQocGcppFhvchLhipXE8ubiIpWk68ZQkZu2Tm8nOny
 Yro0M32fnXfURfKQ5IqYl4/KXiDgxNcZ503a8wOAYoreWYWn6goEoIn5desH7sfK3cV9
 Fztg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776710154; x=1777314954; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxBm15eIKaXf6CUs+pV/AMJ0q6nJrZkgFaiTVCD3ZSE=;
 b=CC8j42ewJxW4dxsXSxgNPfFLfBa8FIIp39H6bnynQVGZ34MafE5Kkv8rk2TMOJJQPs
 GV2CtsUQGv8PcWJUBrxwgC867uhxytMJTUYMkPGHxz7bNTxyl71SHiTRR8ztuVOSnz9f
 uz9KmEnaK1Jjm4uyNJoGbHFGGQJ0hJkJDt+3eBadsV0MjjJg/XzWlqgmG6gyEJdi6M1f
 VywAJjQKK7qqys8Byl/77Gou4RUero6Or1PiF2mGOnt61TwZpfQF/F6kotbebLNwDvfD
 QFDOWGyK2M5DxLKOs6PgXAFKwCmP9aanl5O5DScCE7hiw19kCc2W5sZlivEsoymwlWzj
 Pbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776710154; x=1777314954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uxBm15eIKaXf6CUs+pV/AMJ0q6nJrZkgFaiTVCD3ZSE=;
 b=sdUBSRvlAGy2bOLni+sLFkRmpxgJJVHxNQUtVaupkX1A0bprHNdLdfBG7mq4OCLvjK
 e0ySo2ZGSWyEaZhzFf0FyCNJO/ob/Lp+n5ygMJkN+2ttBuOF6CsGRe0+6Y/ZlHH6rEfN
 Mzhqulm63sDsZ4+kNqrOWcaLJDmsiV/mSQAikJpV44wTe/uZe7s3uzAdH+ov1E18l5gZ
 5jMQ+IubttVelfPMfvqOM63vCyod6OMfDiwvj9lYi2u1xAOZRq12wrMjsFXdddlFxIgN
 jCwWPEUnTh4//hBpZCGXVMmqUoQGKDJdBhHLu23YILA7LRGcnmXkGULVDsSWPTs7e4G4
 ofUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sCtsSDROonGXTX9gtRqs58Z0L/fnfP2+6OoJ8pPfeopfpzulqBYFtomU04+tO5JFML+SoKG0V/N0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywF1eXzuaT6eOYDdMqF7k2AgTcD1eFHVomgOTA2goYWA0RTGA0
 r1ivNJw+SArZE2RZk+tt2CLlA8OvB1xiBMpauv5LqI+lQC7g+pmI5yMxFDpNBddmd1iwo3av6oZ
 JaC73zLuT5J+X9HoTzfFQZz+0PY56zduyrw==
X-Gm-Gg: AeBDieu8tqc4HW0N9UCHqeXYb1ehRgQ2SUvM9gT5Bij7S2MNWmgH7FscHai3LIOljk+
 mymqb+HWJqSga69/ZYPAyUPKi6l1WNKEh71MvFk+EVkGh//1/ri9ooE4JpMIWMyq3pjoVk/54dz
 icNgV2sof+YCeBpfhwRzZlk85u7gRDXrcxq2epkES4ypAUhf7qnMW64F0sfUyKmfT/RFo9pCx34
 sprx2IUh0Vj1accaV+fu9230TWZIUxv2KjS2GvMedFCkcnNd0QZILoODR6xX6c1n2CeBeH1PiJ1
 84Hz43fdHQq7J+5PaNWbVYNfHn2e2yq+/UPzPNIhJy+09Q1OYnS1UM+SV4oTFqJ/Uhrl6h82Bqw
 iaPm9
X-Received: by 2002:a05:7022:170a:b0:12c:8cd7:d463 with SMTP id
 a92af1059eb24-12c8cd7dbb7mr537251c88.2.1776710153607; Mon, 20 Apr 2026
 11:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260420032858.10286-1-giovannauchoa@usp.br>
 <CADnq5_P2+OqDtmhwOAuM9QsOFi8D45QA+=XOCqJ1vbMbjVQJCg@mail.gmail.com>
 <7eb86bbd-d875-474c-a052-176f6d00ad79@amd.com>
 <CADnq5_MTSC4ehVTOaeJ2ui3LwD8=em1+Kgu7yCh68aLgXa1dKQ@mail.gmail.com>
 <5d32ad1b-5788-44b1-bb21-5f37891b6c82@amd.com>
In-Reply-To: <5d32ad1b-5788-44b1-bb21-5f37891b6c82@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Apr 2026 14:35:41 -0400
X-Gm-Features: AQROBzDaY6bQVpjMQIxONLXzyMK-efKdJyvL4BEtf4GywhSubDDUeq7eI5HH7Ug
Message-ID: <CADnq5_P7mGBw21FYTfZwaff+3G6Ddj1wkCTKOU=LRLaVgF4ZAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: consolidate SDMA trap IRQ handler
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Giovanna Uchoa <giovannauchoa@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
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

On Mon, Apr 20, 2026 at 2:31=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/20/26 20:25, Alex Deucher wrote:
> > On Mon, Apr 20, 2026 at 2:23=E2=80=AFPM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> Wait a second Alex, this patch actually doesn't make sense at all.
> >>
> >> The code is only common for a subset of SDMA engines and so shouldn't =
be moved into a common handler.
> >
> > It still reduces duplication across the chips where it is shared.  I
> > can kind of go either way on this.
>
> Well it was your decision when we started amdgpu that we don't want to do=
 this and as far as I can see it is still the right thing to do.
>
> We have avoided tons of issues with that approach since the code is indep=
endent per generation and modifications doesn't automatically affect all of=
 them.
>

Fair enough.  Patch dropped.

Alex

> I mean we can clearly cleanup the code, the DRM_DEBUG() is just superflou=
s since we have a general tracepoint for IRQs and I think we can reduce the=
 switch case to just an if. E.g. something like:
>
> u8 instance_id, queue_id;
>
> instance_id =3D (entry->ring_id & 0x3) >> 0;
> queue_id =3D (entry->ring_id & 0xc) >> 2;
> if (instance_id <=3D 1 && queue_id =3D=3D 0)
>         amdgpu_fence_process(&adev->sdma.instance[instance_id].ring);
>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >> On 4/20/26 20:18, Alex Deucher wrote:
> >>> Applied.  Thanks!
> >>>
> >>> Alex
> >>>
> >>> On Mon, Apr 20, 2026 at 9:09=E2=80=AFAM Giovanna Uchoa <giovannauchoa=
@usp.br> wrote:
> >>>>
> >>>> Move the amdgpu_sdma_process_trap_irq handler from version-specific
> >>>> implementations (cik_sdma, sdma_v2_4, sdma_v3_0) to the common SDMA
> >>>> module (amdgpu_sdma). This eliminates code duplication and centraliz=
es
> >>>> the trap interrupt handling logic, which is identical across all SDM=
A
> >>>> versions.
> >>>>
> >>>> Update the trap_irq_funcs in each version-specific module to referen=
ce
> >>>> the common handler implementation.
> >>>>
> >>>> Signed-off-by: Giovanna Uchoa <giovannauchoa@usp.br>
> >>>> ---
> >>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 +++++++++++++++++++++=
+
> >>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ++
> >>>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 43 +--------------------=
---
> >>>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 42 +--------------------=
--
> >>>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 42 +--------------------=
--
> >>>>  5 files changed, 47 insertions(+), 124 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_sdma.c
> >>>> index 321310ba2..4f15334ce 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> >>>> @@ -147,6 +147,47 @@ int amdgpu_sdma_process_ecc_irq(struct amdgpu_d=
evice *adev,
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> +int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
> >>>> +                                    struct amdgpu_irq_src *source,
> >>>> +                                    struct amdgpu_iv_entry *entry)
> >>>> +{
> >>>> +       u8 instance_id, queue_id;
> >>>> +
> >>>> +       instance_id =3D (entry->ring_id & 0x3) >> 0;
> >>>> +       queue_id =3D (entry->ring_id & 0xc) >> 2;
> >>>> +       DRM_DEBUG("IH: SDMA trap\n");
> >>>> +       switch (instance_id) {
> >>>> +       case 0:
> >>>> +               switch (queue_id) {
> >>>> +               case 0:
> >>>> +                       amdgpu_fence_process(&adev->sdma.instance[0]=
.ring);
> >>>> +                       break;
> >>>> +               case 1:
> >>>> +                       /* XXX compute */
> >>>> +                       break;
> >>>> +               case 2:
> >>>> +                       /* XXX compute */
> >>>> +                       break;
> >>>> +               }
> >>>> +               break;
> >>>> +       case 1:
> >>>> +               switch (queue_id) {
> >>>> +               case 0:
> >>>> +                       amdgpu_fence_process(&adev->sdma.instance[1]=
.ring);
> >>>> +                       break;
> >>>> +               case 1:
> >>>> +                       /* XXX compute */
> >>>> +                       break;
> >>>> +               case 2:
> >>>> +                       /* XXX compute */
> >>>> +                       break;
> >>>> +               }
> >>>> +               break;
> >>>> +       }
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>>  static int amdgpu_sdma_init_inst_ctx(struct amdgpu_sdma_instance *s=
dma_inst)
> >>>>  {
> >>>>         uint16_t version_major;
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_sdma.h
> >>>> index 2bf365609..ca4fd94ac 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>>> @@ -203,6 +203,9 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgp=
u_device *adev,
> >>>>  int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
> >>>>                                       struct amdgpu_irq_src *source,
> >>>>                                       struct amdgpu_iv_entry *entry)=
;
> >>>> +int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
> >>>> +                                    struct amdgpu_irq_src *source,
> >>>> +                                    struct amdgpu_iv_entry *entry);
> >>>>  int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 inst=
ance,
> >>>>                                bool duplicate);
> >>>>  void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm=
/amd/amdgpu/cik_sdma.c
> >>>> index 120da838a..1bf1af633 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> >>>> @@ -1141,47 +1141,6 @@ static int cik_sdma_set_trap_irq_state(struct=
 amdgpu_device *adev,
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> -static int cik_sdma_process_trap_irq(struct amdgpu_device *adev,
> >>>> -                                    struct amdgpu_irq_src *source,
> >>>> -                                    struct amdgpu_iv_entry *entry)
> >>>> -{
> >>>> -       u8 instance_id, queue_id;
> >>>> -
> >>>> -       instance_id =3D (entry->ring_id & 0x3) >> 0;
> >>>> -       queue_id =3D (entry->ring_id & 0xc) >> 2;
> >>>> -       DRM_DEBUG("IH: SDMA trap\n");
> >>>> -       switch (instance_id) {
> >>>> -       case 0:
> >>>> -               switch (queue_id) {
> >>>> -               case 0:
> >>>> -                       amdgpu_fence_process(&adev->sdma.instance[0]=
.ring);
> >>>> -                       break;
> >>>> -               case 1:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               case 2:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               }
> >>>> -               break;
> >>>> -       case 1:
> >>>> -               switch (queue_id) {
> >>>> -               case 0:
> >>>> -                       amdgpu_fence_process(&adev->sdma.instance[1]=
.ring);
> >>>> -                       break;
> >>>> -               case 1:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               case 2:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               }
> >>>> -               break;
> >>>> -       }
> >>>> -
> >>>> -       return 0;
> >>>> -}
> >>>> -
> >>>>  static int cik_sdma_process_illegal_inst_irq(struct amdgpu_device *=
adev,
> >>>>                                              struct amdgpu_irq_src *=
source,
> >>>>                                              struct amdgpu_iv_entry =
*entry)
> >>>> @@ -1270,7 +1229,7 @@ static void cik_sdma_set_ring_funcs(struct amd=
gpu_device *adev)
> >>>>
> >>>>  static const struct amdgpu_irq_src_funcs cik_sdma_trap_irq_funcs =
=3D {
> >>>>         .set =3D cik_sdma_set_trap_irq_state,
> >>>> -       .process =3D cik_sdma_process_trap_irq,
> >>>> +       .process =3D amdgpu_sdma_process_trap_irq,
> >>>>  };
> >>>>
> >>>>  static const struct amdgpu_irq_src_funcs cik_sdma_illegal_inst_irq_=
funcs =3D {
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/dr=
m/amd/amdgpu/sdma_v2_4.c
> >>>> index 93ec52c1f..545077897 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> >>>> @@ -1035,46 +1035,6 @@ static int sdma_v2_4_set_trap_irq_state(struc=
t amdgpu_device *adev,
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> -static int sdma_v2_4_process_trap_irq(struct amdgpu_device *adev,
> >>>> -                                     struct amdgpu_irq_src *source,
> >>>> -                                     struct amdgpu_iv_entry *entry)
> >>>> -{
> >>>> -       u8 instance_id, queue_id;
> >>>> -
> >>>> -       instance_id =3D (entry->ring_id & 0x3) >> 0;
> >>>> -       queue_id =3D (entry->ring_id & 0xc) >> 2;
> >>>> -       DRM_DEBUG("IH: SDMA trap\n");
> >>>> -       switch (instance_id) {
> >>>> -       case 0:
> >>>> -               switch (queue_id) {
> >>>> -               case 0:
> >>>> -                       amdgpu_fence_process(&adev->sdma.instance[0]=
.ring);
> >>>> -                       break;
> >>>> -               case 1:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               case 2:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               }
> >>>> -               break;
> >>>> -       case 1:
> >>>> -               switch (queue_id) {
> >>>> -               case 0:
> >>>> -                       amdgpu_fence_process(&adev->sdma.instance[1]=
.ring);
> >>>> -                       break;
> >>>> -               case 1:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               case 2:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               }
> >>>> -               break;
> >>>> -       }
> >>>> -       return 0;
> >>>> -}
> >>>> -
> >>>>  static int sdma_v2_4_process_illegal_inst_irq(struct amdgpu_device =
*adev,
> >>>>                                               struct amdgpu_irq_src =
*source,
> >>>>                                               struct amdgpu_iv_entry=
 *entry)
> >>>> @@ -1159,7 +1119,7 @@ static void sdma_v2_4_set_ring_funcs(struct am=
dgpu_device *adev)
> >>>>
> >>>>  static const struct amdgpu_irq_src_funcs sdma_v2_4_trap_irq_funcs =
=3D {
> >>>>         .set =3D sdma_v2_4_set_trap_irq_state,
> >>>> -       .process =3D sdma_v2_4_process_trap_irq,
> >>>> +       .process =3D amdgpu_sdma_process_trap_irq,
> >>>>  };
> >>>>
> >>>>  static const struct amdgpu_irq_src_funcs sdma_v2_4_illegal_inst_irq=
_funcs =3D {
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/dr=
m/amd/amdgpu/sdma_v3_0.c
> >>>> index 3fde9be74..b3eab4e11 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> >>>> @@ -1373,46 +1373,6 @@ static int sdma_v3_0_set_trap_irq_state(struc=
t amdgpu_device *adev,
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> -static int sdma_v3_0_process_trap_irq(struct amdgpu_device *adev,
> >>>> -                                     struct amdgpu_irq_src *source,
> >>>> -                                     struct amdgpu_iv_entry *entry)
> >>>> -{
> >>>> -       u8 instance_id, queue_id;
> >>>> -
> >>>> -       instance_id =3D (entry->ring_id & 0x3) >> 0;
> >>>> -       queue_id =3D (entry->ring_id & 0xc) >> 2;
> >>>> -       DRM_DEBUG("IH: SDMA trap\n");
> >>>> -       switch (instance_id) {
> >>>> -       case 0:
> >>>> -               switch (queue_id) {
> >>>> -               case 0:
> >>>> -                       amdgpu_fence_process(&adev->sdma.instance[0]=
.ring);
> >>>> -                       break;
> >>>> -               case 1:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               case 2:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               }
> >>>> -               break;
> >>>> -       case 1:
> >>>> -               switch (queue_id) {
> >>>> -               case 0:
> >>>> -                       amdgpu_fence_process(&adev->sdma.instance[1]=
.ring);
> >>>> -                       break;
> >>>> -               case 1:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               case 2:
> >>>> -                       /* XXX compute */
> >>>> -                       break;
> >>>> -               }
> >>>> -               break;
> >>>> -       }
> >>>> -       return 0;
> >>>> -}
> >>>> -
> >>>>  static int sdma_v3_0_process_illegal_inst_irq(struct amdgpu_device =
*adev,
> >>>>                                               struct amdgpu_irq_src =
*source,
> >>>>                                               struct amdgpu_iv_entry=
 *entry)
> >>>> @@ -1601,7 +1561,7 @@ static void sdma_v3_0_set_ring_funcs(struct am=
dgpu_device *adev)
> >>>>
> >>>>  static const struct amdgpu_irq_src_funcs sdma_v3_0_trap_irq_funcs =
=3D {
> >>>>         .set =3D sdma_v3_0_set_trap_irq_state,
> >>>> -       .process =3D sdma_v3_0_process_trap_irq,
> >>>> +       .process =3D amdgpu_sdma_process_trap_irq,
> >>>>  };
> >>>>
> >>>>  static const struct amdgpu_irq_src_funcs sdma_v3_0_illegal_inst_irq=
_funcs =3D {
> >>>> --
> >>>> 2.53.0
> >>>>
> >>
>
