Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC94FF588CA
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D6110E669;
	Mon, 20 Apr 2026 14:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LnbDqKgi";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E4E10E66B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 14:13:59 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2daaab98000so202403eec.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 07:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776694439; cv=none;
 d=google.com; s=arc-20240605;
 b=SWUBukdR62+t/Fz5nsrGX3k5Z5WnS6fYmG2Xgilk819hMyQqgCgfSOuicXIflgLagc
 7Ur4ewhXH0RgysSHeKlY1PSoXJtoMFD15DqQbUtD/Os93Ei3pR/yYuOddF+VxQRrBiNr
 G5kMhWAlX9CMk+/x3d37vXgKnQ5d3Lg6htKDi7iFi04/8P6el5fpDTsz98/l5YBnYN/z
 PC2HaSBbLwhpCcwHHepbAgRbVuhAw/pcW7AeozQjAiEc35Knu1Rk68C3g2hcjwcj6My4
 DD1SGWKzzGCFaQVQDPdH99LNEyxOLYUGwAjJCLe3gygPGO3ptrSDUE4jMEw9W83R5F91
 Xadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SzgUBzAC2o0e5IwzPk2aEBcPIfZB4ZYpORnpK8lh66E=;
 fh=dwZkwo/5TOEGnDDXJQqmFSnIs806OYqxYnzQjLqiZxY=;
 b=LIu5TvANFXUT2cvUdSHTMCtOCAq08p1lE1XMdxw1xl1vStztgYSgL4rFYTBkTwGcFB
 x+h1dsMVNCO1hD5WlPW577Clc57L9XSEHFK6YB6J3rdlwbWGQ4nD3+Ec3SVrdj7jl4Sj
 kSsEEd3Y2moPUUQsrApoYwzEI8lqL6P5/0IscmpbvWopu4fsbUZoiVcmoRRcaRJ6veT4
 u5LyuxIoxDA1P1SI4rDDArTXIfZcaXkXNpWbAonL12CCwmSnt1PRZ6SEHQTJHHQXQvjJ
 l4k4TOlDkhK9ly77PZkRAkqhaahD5DtOloIWDFsOuSzCYOzkRFv1vCVDttB97aeJPs52
 Gt3A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776694439; x=1777299239; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzgUBzAC2o0e5IwzPk2aEBcPIfZB4ZYpORnpK8lh66E=;
 b=LnbDqKgiGrndxNVJti7Ge16wGm+/hHexjcjdJjPgZn+fGDpOguH/YMG3P+eXeTP8FS
 kxAGL11lye+zgQt5WnWVWpQGs7EaRGoiyyp7xD98rE10pBURw7OA+iu6nPJjf1S/QVZ6
 29QepGYY6ush0+1l/6pjmNIu3ncpqvQhIub9EKzEWBcvk/BX3fsNepGWOKR2CQ7cv/JD
 5GQ8tUk4XW3QfxpU0Oty/Ox9PHiRKqQ9Kh8XWHsCq+YR6po7GPxrdbkad2x2LHzIIgma
 xFEtsw6ebF3/wpvmavvPI+RfotpBeNH2iInxdjySx6WMXsjFT3fULShUlcjij7dSu/KY
 v77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776694439; x=1777299239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SzgUBzAC2o0e5IwzPk2aEBcPIfZB4ZYpORnpK8lh66E=;
 b=ThjUJn98wkKWN9L6CarQGIUlfFm/h7xf+1hr8bOlLHLB/gtKGeuvmIOwfLuVZ0ZKHv
 9+uva5ZQG/x5U0ma3CGiOqyf8J9zAedT7/M7TEDwszuk8+4gL/iWk++99ZIcLAWjZ+Sy
 b71tQwX9WuovvwCpvOKtKYNXXGPP1uLXAiq7R10YiqI0rKld1ZyCtKVJ3H0IqO6zDuYG
 SkABokXjFdb9ezpmAvFnAhwUO7BeB8Tj5wZC8zNC2AZKS3719yA/X9bxAQau1gCbRvPi
 aUzKNp4AIMWxt9rIcvNWMet+NfuFz7GmGdKX0qGZHT+327VzGAl+GDAaLsLBlnscqQVs
 dlew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nellMQH4kW3okut3dquFT/vXNEfN0pFRmR2XxU+QY4X9CmyU82GfVWdyHAQ/PJFHalSv9uwU7ET4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRGEADK01IDstEUTMolDu2v0kcJEdQ7sNQPj1wwIIvMRESkv65
 FtaL/WvNEaJozRUPDZRYQpo/6uaRusENlJ6Oet+0bmbZnx6oFx9OrML6n/NiA0gZijQLlUk9T3e
 d+3oSlAkWcBK2ztFn7/qJdIuSw7piXjI=
X-Gm-Gg: AeBDies86x2prQdKtz+lU9TfL0BrZnjxKXwGdbOp6B29Ao/SFZkdKmquR/9SdGyBj/8
 EBZl7iux83GoYg+oYf2mR3KMa66/Cj2lWP5dPLUV5MIuU8bfYcK1oDb5DUDe+3l42obQ8jyhBN1
 jpqpddJOzRF6YzBNXseiZLsJLjiQsC3UawOq+YmC+RurE79OqsaJ21Q9i25EwSy3CeI83RgLKJZ
 BNncETSwL8nDccDn62llu1FpE/bjtwhgirVRv1JsphakOghhYob1T/D31vlCywg2pY2SK0il5On
 0UASNCRYYENXvkOLrZzkg6uPH/OQNnzTYag1b0fxBDG46ih+Kqg3Mxaj8aSNsDiA9ruqZmlqXAj
 lLhyb
X-Received: by 2002:a05:7022:6889:b0:124:af80:9d0c with SMTP id
 a92af1059eb24-12c73d26cc4mr2635816c88.0.1776694438767; Mon, 20 Apr 2026
 07:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260417213221.937722-1-mjgajda@gmail.com>
 <43120d24-2b69-4038-9540-dc204c75a14d@amd.com>
In-Reply-To: <43120d24-2b69-4038-9540-dc204c75a14d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Apr 2026 10:13:47 -0400
X-Gm-Features: AQROBzDE_MPDw_jDdkeLrsu71yoHraxPuk43vC4IBtnWXH1xEiFdYBv6eUf2-co
Message-ID: <CADnq5_OwGSGzSAZp=H1P2N+iePiVND9+1CD3Zf34oC5E8zzcwQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: allow unprivileged read of GC_THROTTLE_STATUS
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: mjgajda@gmail.com, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, dri-devel@lists.freedesktop.org
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

On Mon, Apr 20, 2026 at 5:13=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/17/26 23:32, mjgajda@gmail.com wrote:
> > From: "M. Gajda" <mjgajda@gmail.com>
> >
> > GC_THROTTLE_STATUS is a read-only hardware status register present on a=
ll
> > RDNA GPU generations (GFX10/11/12).  It reports the state of the GFX
> > thermal throttle finite state machine:
> >
> >   FSM_STATE    [3:0]  non-zero =3D GPU currently being throttled
> >   PATTERN_INDEX [9:4]  active throttle duty-cycle pattern
>
> Mhm, according to AMDs internal register documentation that one is not av=
ailable everywhere.
>
> My educated guess is that there is actually some SMU function you should =
call to get this information.

This is already available via the smu metrics table.  I suspect this
register is probably just a scratch register anyway since it's FW
which handles the clocks, not the HW and as such, I'm not sure it
would even get updated.

Alex

>
>
> > The register is never written by the driver.  No side-effects occur on
> > read.
>
> Oh that is not correct at all. Reads can have tons of side effects all th=
e way to a spontaneous system reboot!
>
> > Add it to the per-ASIC allowed_read_registers[] tables so that
> > unprivileged userspace can query it via the AMDGPU_INFO_READ_MMR_REG io=
ctl
> > (libdrm: amdgpu_read_mm_registers(3)).
> >
> > This enables monitoring tools such as radeontop to display GPU thermal
> > throttle status without root privileges -- information of the same
> > sensitivity class as GPU temperature, which is already exposed via the
> > AMDGPU_INFO_SENSOR_GPU_TEMP sensor ioctl.
>
> Yeah, but that one asks the DPM functions to talk to the SMU to get the r=
equested data.
>
> That is clearly something completely different.
>
> Regards,
> Christian.
>
> >
> > Register offsets per generation:
> >   GFX10 (RDNA 1/2): mmGC_THROTTLE_STATUS  0x2032  BASE_IDX 0
> >   GFX11 (RDNA 3):  regGC_THROTTLE_STATUS  0x1b0a  BASE_IDX 1
> >   GFX12 (RDNA 4):  regGC_THROTTLE_STATUS  0x1b1c  BASE_IDX 1
> >
> > Source: drivers/gpu/drm/amd/include/asic_reg/gc/
> >   gc_10_3_0_{offset,sh_mask}.h, gc_11_0_0_{offset,sh_mask}.h,
> >   gc_12_0_0_{offset,sh_mask}.h
> >
> > Public ISA documentation:
> >   RDNA 1: https://developer.amd.com/wp-content/resources/RDNA_Shader_IS=
A.pdf
> >   RDNA 2: https://www.amd.com/content/dam/amd/en/documents/radeon-tech-=
docs/instruction-set-architectures/rdna2-shader-instruction-set-architectur=
e.pdf
> >   RDNA 3: https://docs.amd.com/v/u/en-US/rdna3-shader-instruction-set-a=
rchitecture
> >   RDNA 4: https://docs.amd.com/v/u/en-US/rdna4-instruction-set-architec=
ture
> >
> > Signed-off-by: M. Gajda <mjgajda@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/nv.c    | 6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/soc24.c | 6 ++++++
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdg=
pu/nv.c
> > index 7ce1a1b95..80594c793 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -352,6 +352,12 @@ static struct soc15_allowed_register_entry nv_allo=
wed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1)},
> >         { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS)},
> >         { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
> > +       /*
> > +        * GC_THROTTLE_STATUS (offset 0x2032): read-only thermal thrott=
le FSM.
> > +        * FSM_STATE [3:0] !=3D 0 indicates the GPU is currently being =
throttled.
> > +        * Defined in gc_10_3_0_offset.h / gc_10_3_0_sh_mask.h
> > +        */
> > +       { SOC15_REG_ENTRY(GC, 0, mmGC_THROTTLE_STATUS)},
> >  };
> >
> >  static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u=
32 se_num,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/a=
mdgpu/soc21.c
> > index fbd1d97f3..8c2472bd0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > @@ -304,6 +304,12 @@ static struct soc15_allowed_register_entry soc21_a=
llowed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STALLED_STAT1)},
> >         { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STATUS)},
> >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> > +       /*
> > +        * GC_THROTTLE_STATUS (offset 0x1b0a): read-only thermal thrott=
le FSM.
> > +        * FSM_STATE [3:0] !=3D 0 indicates the GPU is currently being =
throttled.
> > +        * Defined in gc_11_0_0_offset.h / gc_11_0_0_sh_mask.h
> > +        */
> > +       { SOC15_REG_ENTRY(GC, 0, regGC_THROTTLE_STATUS)},
> >  };
> >
> >  static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev=
, u32 se_num,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/a=
mdgpu/soc24.c
> > index d1adf19a5..617ee0a4d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> > @@ -130,6 +130,12 @@ static struct soc15_allowed_register_entry soc24_a=
llowed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STALLED_STAT1)},
> >         { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STATUS)},
> >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> > +       /*
> > +        * GC_THROTTLE_STATUS (offset 0x1b1c): read-only thermal thrott=
le FSM.
> > +        * FSM_STATE [3:0] !=3D 0 indicates the GPU is currently being =
throttled.
> > +        * Defined in gc_12_0_0_offset.h / gc_12_0_0_sh_mask.h
> > +        */
> > +       { SOC15_REG_ENTRY(GC, 0, regGC_THROTTLE_STATUS)},
> >  };
> >
> >  static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev=
,
> > --
> > 2.51.0
> >
>
