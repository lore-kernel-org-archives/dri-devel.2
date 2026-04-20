Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45688F5A8A6
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8660E10E745;
	Mon, 20 Apr 2026 18:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A8J+JVIP";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D8110E745
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 18:25:57 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12db205ca0bso2039c88.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 11:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776709557; cv=none;
 d=google.com; s=arc-20240605;
 b=grA9uclh/1auFuZfCbhl3mLs7svF7pNitjsMDT+1GgN8AhH7ZFETmEVVgrJohQlo0l
 lq7t8L7OSpLuzkbLPoZeRvdyh+HxQoOFw+RuZnwWjZwR47hCNRipOKIYvS6TEAkHPpgI
 3xh/lx4sm6MwpeHfO4qwfvFuoUluoQX5iSxV/zy+PZ2gqm5aZglrSXelPkpfwWhM99Px
 jqKMhp9mUd7rp8h/o5Ff/8eMFY4UeZspOXj/rEc/Dw8/3DnlOEEfNPX5/YLjupgeurPc
 D1IDB+9X0ftLGENV+2ILfKvTRb0sO0JjR8lVdjF5rzj1SVGIwsU+oLuoWOXHRtm+CSnW
 GK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ll8ksnvPbMoZ0pcpFNyIxwP9oCQG0FleIEZaqqENELs=;
 fh=L0ubSvWRLb2WkTpS/UNXCpKcSXC/HyXHlgQCNZlT9PY=;
 b=TGIrBx+h4mYwqiNqVuzGwYmzY2bG85NPOCXUcK6EzCjSJ4C98xM+oyrG0vJj92Vi9u
 B78SJPwrPTWa6rE/l8nQWBShUfIbcbP85zqOAVSbVXaCP2oZv+2V+YRB5qbjqVyscR+m
 8AS3z9DkxbOk8StSV9THXj7P3rJlX8vM7GViO/qMlEuuZfAWIB6POcUSLTKIRMNt4oa5
 339u8tGqOztJfu2e4zJKqAOzcF0Ah+iznPsOdugDp7Kx+e8SL29t4WdnQuvouewYlj8e
 ZTm+osi5copoqMytfdySdFwM68Luuz51E0398jJahoXmWcsUKKkaoDJoeYdyQ/ETXrLg
 qkNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776709557; x=1777314357; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ll8ksnvPbMoZ0pcpFNyIxwP9oCQG0FleIEZaqqENELs=;
 b=A8J+JVIPVheUNvMrhajR/auzAqEf27+kE3FLFBSJA6W4C7kC9mSt38vDJItA1ChS5L
 hE1DvA6d0yrqH7GDq8Ct3iQcfjyCkPu4ak/TrrNvYfqEcprMJ/DO+LJx2VNvsu5E0HJY
 RtFM8DIJbOGGhI6NoUcF9oK0EtXiznyPL1vAkg800V6VV+WBEQwOhrlRdgv8HSGwJdNz
 hVueoTqGbnibARBsIr2LYbmw6rMrSAxNaxQ0ghMWM3UMgI+eWUzSS6NyY67We6ZPlDvM
 8iy4vhlDpClmcSsFaFiQYGhmPUBFmsFh4zmTSCj6zF58llhgo63Q47RQidWV/G5hzm1W
 XXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776709557; x=1777314357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ll8ksnvPbMoZ0pcpFNyIxwP9oCQG0FleIEZaqqENELs=;
 b=qngFgZkxtOKs7A3F7dz58spHdOEGbKHMpQa/MlUN2ZNjiVwjDbqt6G974IOSiGfdtl
 IvtjZ1o6h4LY5O/CXiLnzLqVYgd5xKRLMhMwGjBcMcxBhbxEMOxg7vlzRgW8iOMZp0W5
 fzSKUx2UsbdECsnl6lZbaMhRUD4T5hvRPdKA+TdHQj//bpktx8UIh4N8A+aFRzXk75n2
 lAFLT03p67Gh6ZRzjcvnIb9YoJhEbeBlSbDypEQAKZWk8Zsti14fXIgdP0qvhilkJcBF
 77aOVCOcYRAzjfVdSYW5LtYjQf0DTsaHwHGEQfWAeAXNTojUROVadttR+0e2KAJiPhyL
 5KiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GgnQ3tHqVTVNZD8sowM7fwO2Uak7I6t6WrJDOkb0AOj+/bRWflT9zX5FFKYmYfMCy+oFzRTd/JhM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBtserhEeHpHQBPCw+HYyOF9UN2X51BAXe/+760aQSExslCggh
 fKu4DKnUq5o07jWVAISnknz+p2VpoVVnN2kVnKZf7SRaPlGNh/++3aPOuE7LGQtdT+EGGn+2915
 6rK801Wj48PoplXkttrgPNK7PfS/PzIs=
X-Gm-Gg: AeBDietYvWp9nsmdhI9Ht2M52Rn9O5uxvEJlCWrz84J/b+G2ailHoJzEU/fJ/Ig0RqD
 PLRms50Gm7Fcv184As7N9kanJiPYAOp3tgoMQq4xepXazuKOTPzwzPltcYqXuDARvL/vkASMM0F
 oNldIAFlbi3W6QcMzkVytDIn1xR7BdmUy93gD0dS3KYHhImImxGl6bGuWePam0C/YdMUzPMUK1S
 B9RucA4n1DNjkYV/W0kxvE5wVJcbDTdx65jMX1d1+5HJFbl4D44gbCrTY28ahOLY194fCNPamzy
 0KXwwEyO9WLZI0pV6CsX9LMUyC0WZtBrGXTv8IwcO0COZSsjLdDyLCb7EWQtvF7vAP+dDdtrnJ3
 YAiP/
X-Received: by 2002:a05:7022:2522:b0:127:def:dd72 with SMTP id
 a92af1059eb24-12c73f659d5mr3172128c88.2.1776709557036; Mon, 20 Apr 2026
 11:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260420032858.10286-1-giovannauchoa@usp.br>
 <CADnq5_P2+OqDtmhwOAuM9QsOFi8D45QA+=XOCqJ1vbMbjVQJCg@mail.gmail.com>
 <7eb86bbd-d875-474c-a052-176f6d00ad79@amd.com>
In-Reply-To: <7eb86bbd-d875-474c-a052-176f6d00ad79@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Apr 2026 14:25:45 -0400
X-Gm-Features: AQROBzCBkFSu8-7ovz--1PKvlN9duqiAxtV0sxbUeXzkFd6sZ-ac1Hlzwtyd2y8
Message-ID: <CADnq5_MTSC4ehVTOaeJ2ui3LwD8=em1+Kgu7yCh68aLgXa1dKQ@mail.gmail.com>
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

On Mon, Apr 20, 2026 at 2:23=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Wait a second Alex, this patch actually doesn't make sense at all.
>
> The code is only common for a subset of SDMA engines and so shouldn't be =
moved into a common handler.

It still reduces duplication across the chips where it is shared.  I
can kind of go either way on this.

Alex

>
> Regards,
> Christian.
>
> On 4/20/26 20:18, Alex Deucher wrote:
> > Applied.  Thanks!
> >
> > Alex
> >
> > On Mon, Apr 20, 2026 at 9:09=E2=80=AFAM Giovanna Uchoa <giovannauchoa@u=
sp.br> wrote:
> >>
> >> Move the amdgpu_sdma_process_trap_irq handler from version-specific
> >> implementations (cik_sdma, sdma_v2_4, sdma_v3_0) to the common SDMA
> >> module (amdgpu_sdma). This eliminates code duplication and centralizes
> >> the trap interrupt handling logic, which is identical across all SDMA
> >> versions.
> >>
> >> Update the trap_irq_funcs in each version-specific module to reference
> >> the common handler implementation.
> >>
> >> Signed-off-by: Giovanna Uchoa <giovannauchoa@usp.br>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 ++++++++++++++++++++++
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ++
> >>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 43 +----------------------=
-
> >>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 42 +----------------------
> >>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 42 +----------------------
> >>  5 files changed, 47 insertions(+), 124 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_sdma.c
> >> index 321310ba2..4f15334ce 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> >> @@ -147,6 +147,47 @@ int amdgpu_sdma_process_ecc_irq(struct amdgpu_dev=
ice *adev,
> >>         return 0;
> >>  }
> >>
> >> +int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
> >> +                                    struct amdgpu_irq_src *source,
> >> +                                    struct amdgpu_iv_entry *entry)
> >> +{
> >> +       u8 instance_id, queue_id;
> >> +
> >> +       instance_id =3D (entry->ring_id & 0x3) >> 0;
> >> +       queue_id =3D (entry->ring_id & 0xc) >> 2;
> >> +       DRM_DEBUG("IH: SDMA trap\n");
> >> +       switch (instance_id) {
> >> +       case 0:
> >> +               switch (queue_id) {
> >> +               case 0:
> >> +                       amdgpu_fence_process(&adev->sdma.instance[0].r=
ing);
> >> +                       break;
> >> +               case 1:
> >> +                       /* XXX compute */
> >> +                       break;
> >> +               case 2:
> >> +                       /* XXX compute */
> >> +                       break;
> >> +               }
> >> +               break;
> >> +       case 1:
> >> +               switch (queue_id) {
> >> +               case 0:
> >> +                       amdgpu_fence_process(&adev->sdma.instance[1].r=
ing);
> >> +                       break;
> >> +               case 1:
> >> +                       /* XXX compute */
> >> +                       break;
> >> +               case 2:
> >> +                       /* XXX compute */
> >> +                       break;
> >> +               }
> >> +               break;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  static int amdgpu_sdma_init_inst_ctx(struct amdgpu_sdma_instance *sdm=
a_inst)
> >>  {
> >>         uint16_t version_major;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_sdma.h
> >> index 2bf365609..ca4fd94ac 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >> @@ -203,6 +203,9 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_=
device *adev,
> >>  int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
> >>                                       struct amdgpu_irq_src *source,
> >>                                       struct amdgpu_iv_entry *entry);
> >> +int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
> >> +                                    struct amdgpu_irq_src *source,
> >> +                                    struct amdgpu_iv_entry *entry);
> >>  int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instan=
ce,
> >>                                bool duplicate);
> >>  void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/cik_sdma.c
> >> index 120da838a..1bf1af633 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> >> @@ -1141,47 +1141,6 @@ static int cik_sdma_set_trap_irq_state(struct a=
mdgpu_device *adev,
> >>         return 0;
> >>  }
> >>
> >> -static int cik_sdma_process_trap_irq(struct amdgpu_device *adev,
> >> -                                    struct amdgpu_irq_src *source,
> >> -                                    struct amdgpu_iv_entry *entry)
> >> -{
> >> -       u8 instance_id, queue_id;
> >> -
> >> -       instance_id =3D (entry->ring_id & 0x3) >> 0;
> >> -       queue_id =3D (entry->ring_id & 0xc) >> 2;
> >> -       DRM_DEBUG("IH: SDMA trap\n");
> >> -       switch (instance_id) {
> >> -       case 0:
> >> -               switch (queue_id) {
> >> -               case 0:
> >> -                       amdgpu_fence_process(&adev->sdma.instance[0].r=
ing);
> >> -                       break;
> >> -               case 1:
> >> -                       /* XXX compute */
> >> -                       break;
> >> -               case 2:
> >> -                       /* XXX compute */
> >> -                       break;
> >> -               }
> >> -               break;
> >> -       case 1:
> >> -               switch (queue_id) {
> >> -               case 0:
> >> -                       amdgpu_fence_process(&adev->sdma.instance[1].r=
ing);
> >> -                       break;
> >> -               case 1:
> >> -                       /* XXX compute */
> >> -                       break;
> >> -               case 2:
> >> -                       /* XXX compute */
> >> -                       break;
> >> -               }
> >> -               break;
> >> -       }
> >> -
> >> -       return 0;
> >> -}
> >> -
> >>  static int cik_sdma_process_illegal_inst_irq(struct amdgpu_device *ad=
ev,
> >>                                              struct amdgpu_irq_src *so=
urce,
> >>                                              struct amdgpu_iv_entry *e=
ntry)
> >> @@ -1270,7 +1229,7 @@ static void cik_sdma_set_ring_funcs(struct amdgp=
u_device *adev)
> >>
> >>  static const struct amdgpu_irq_src_funcs cik_sdma_trap_irq_funcs =3D =
{
> >>         .set =3D cik_sdma_set_trap_irq_state,
> >> -       .process =3D cik_sdma_process_trap_irq,
> >> +       .process =3D amdgpu_sdma_process_trap_irq,
> >>  };
> >>
> >>  static const struct amdgpu_irq_src_funcs cik_sdma_illegal_inst_irq_fu=
ncs =3D {
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/=
amd/amdgpu/sdma_v2_4.c
> >> index 93ec52c1f..545077897 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> >> @@ -1035,46 +1035,6 @@ static int sdma_v2_4_set_trap_irq_state(struct =
amdgpu_device *adev,
> >>         return 0;
> >>  }
> >>
> >> -static int sdma_v2_4_process_trap_irq(struct amdgpu_device *adev,
> >> -                                     struct amdgpu_irq_src *source,
> >> -                                     struct amdgpu_iv_entry *entry)
> >> -{
> >> -       u8 instance_id, queue_id;
> >> -
> >> -       instance_id =3D (entry->ring_id & 0x3) >> 0;
> >> -       queue_id =3D (entry->ring_id & 0xc) >> 2;
> >> -       DRM_DEBUG("IH: SDMA trap\n");
> >> -       switch (instance_id) {
> >> -       case 0:
> >> -               switch (queue_id) {
> >> -               case 0:
> >> -                       amdgpu_fence_process(&adev->sdma.instance[0].r=
ing);
> >> -                       break;
> >> -               case 1:
> >> -                       /* XXX compute */
> >> -                       break;
> >> -               case 2:
> >> -                       /* XXX compute */
> >> -                       break;
> >> -               }
> >> -               break;
> >> -       case 1:
> >> -               switch (queue_id) {
> >> -               case 0:
> >> -                       amdgpu_fence_process(&adev->sdma.instance[1].r=
ing);
> >> -                       break;
> >> -               case 1:
> >> -                       /* XXX compute */
> >> -                       break;
> >> -               case 2:
> >> -                       /* XXX compute */
> >> -                       break;
> >> -               }
> >> -               break;
> >> -       }
> >> -       return 0;
> >> -}
> >> -
> >>  static int sdma_v2_4_process_illegal_inst_irq(struct amdgpu_device *a=
dev,
> >>                                               struct amdgpu_irq_src *s=
ource,
> >>                                               struct amdgpu_iv_entry *=
entry)
> >> @@ -1159,7 +1119,7 @@ static void sdma_v2_4_set_ring_funcs(struct amdg=
pu_device *adev)
> >>
> >>  static const struct amdgpu_irq_src_funcs sdma_v2_4_trap_irq_funcs =3D=
 {
> >>         .set =3D sdma_v2_4_set_trap_irq_state,
> >> -       .process =3D sdma_v2_4_process_trap_irq,
> >> +       .process =3D amdgpu_sdma_process_trap_irq,
> >>  };
> >>
> >>  static const struct amdgpu_irq_src_funcs sdma_v2_4_illegal_inst_irq_f=
uncs =3D {
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/=
amd/amdgpu/sdma_v3_0.c
> >> index 3fde9be74..b3eab4e11 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> >> @@ -1373,46 +1373,6 @@ static int sdma_v3_0_set_trap_irq_state(struct =
amdgpu_device *adev,
> >>         return 0;
> >>  }
> >>
> >> -static int sdma_v3_0_process_trap_irq(struct amdgpu_device *adev,
> >> -                                     struct amdgpu_irq_src *source,
> >> -                                     struct amdgpu_iv_entry *entry)
> >> -{
> >> -       u8 instance_id, queue_id;
> >> -
> >> -       instance_id =3D (entry->ring_id & 0x3) >> 0;
> >> -       queue_id =3D (entry->ring_id & 0xc) >> 2;
> >> -       DRM_DEBUG("IH: SDMA trap\n");
> >> -       switch (instance_id) {
> >> -       case 0:
> >> -               switch (queue_id) {
> >> -               case 0:
> >> -                       amdgpu_fence_process(&adev->sdma.instance[0].r=
ing);
> >> -                       break;
> >> -               case 1:
> >> -                       /* XXX compute */
> >> -                       break;
> >> -               case 2:
> >> -                       /* XXX compute */
> >> -                       break;
> >> -               }
> >> -               break;
> >> -       case 1:
> >> -               switch (queue_id) {
> >> -               case 0:
> >> -                       amdgpu_fence_process(&adev->sdma.instance[1].r=
ing);
> >> -                       break;
> >> -               case 1:
> >> -                       /* XXX compute */
> >> -                       break;
> >> -               case 2:
> >> -                       /* XXX compute */
> >> -                       break;
> >> -               }
> >> -               break;
> >> -       }
> >> -       return 0;
> >> -}
> >> -
> >>  static int sdma_v3_0_process_illegal_inst_irq(struct amdgpu_device *a=
dev,
> >>                                               struct amdgpu_irq_src *s=
ource,
> >>                                               struct amdgpu_iv_entry *=
entry)
> >> @@ -1601,7 +1561,7 @@ static void sdma_v3_0_set_ring_funcs(struct amdg=
pu_device *adev)
> >>
> >>  static const struct amdgpu_irq_src_funcs sdma_v3_0_trap_irq_funcs =3D=
 {
> >>         .set =3D sdma_v3_0_set_trap_irq_state,
> >> -       .process =3D sdma_v3_0_process_trap_irq,
> >> +       .process =3D amdgpu_sdma_process_trap_irq,
> >>  };
> >>
> >>  static const struct amdgpu_irq_src_funcs sdma_v3_0_illegal_inst_irq_f=
uncs =3D {
> >> --
> >> 2.53.0
> >>
>
