Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481D3C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B77110EDD9;
	Tue,  8 Sep 2026 22:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I2EKQ3cV";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D5110EDD7
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:24:26 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396673bd281so891952a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 15:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788906266; cv=none;
 d=google.com; s=arc-20260327;
 b=T/pJS7DbsYWuowKYNi4no9haNd7LnW4gjhJneeHZGtl72DjoAA/GfchhdDWWI38rPP
 J2kWkbFon8pwz0eoh/8mLua1g60Q/3ZtqAuZdZgSpslbmJlFzFVNWa5z2a0iqEIsp/8X
 wsYTjIaC4D6UHxrwSdfvookL3ZhMMelVbFJSU5jBL8HnziZxL6zie950toiet9X/E/gf
 /f66z+IppEn0Z1lgVOmbLYWEtDhYIu4A/bijXfN5cQOr7wf4Go/VvSjSzI1qmyR9EBQT
 8/RCYabrgt9OJ36EJMzkF9TOkuRin7tBdEbmeLkOzLYpjSAg0WR3FGsU+74+pttnBL+z
 ulBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U8EkFagfl9uinl9KRuv/CDvRS8wFSFBw+B4s084qWz4=;
 fh=Xx1HHD2gUR+qV2nMSffZaP/kZuoijXsPSRTJ07MExHo=;
 b=IsmWYjazkukDR+cSy4rZ2fXTZSdXMSixu6qMm0bX0BDZzRD4/V5En92Trg/ULKh4dS
 er66aCvE3cHanDqzpyOw+4vRpoMfZvwE/E66NNRUu16VQCDvILQBOiJ2HX9bKO8b6jpu
 OtnkT2o5FuCdau78Yj59LffX6meNso+lALhHAHoe8gajT3tRxo2C3CPCzLPvE6vJCY4P
 TWu5w6C8nO320RPaRW5J5+iCYCU/Py0e9ES9L9c+UmcVbPFSUlr8ua6ZBML3VE0adl82
 14faY6o0W3jRueez/OP91zwBMlJ7dp8CFp8AoTuWP2K5xWo0PxNagi1/0mn14Gz2oFbp
 k3Zg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788906266; x=1789511066; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U8EkFagfl9uinl9KRuv/CDvRS8wFSFBw+B4s084qWz4=;
 b=I2EKQ3cVlOwr1ONDOBAqVdab+MR2h9NEvqmVmuvFq5Eckef27ltwqQPVNF8UK6E54M
 ByDNKNSvj6J/SiDoJZmOfLO9eesJs5YqMZ8NhfKMf2w0x4jqzmbb8ogd1ewDbYVWNFu+
 eUBjH9vMkc1qlzl/zLH/vXhQE1emrtnJQpL61Z8tlGyYbadZYDB/F2F4aTqs1zk+KWFJ
 JmwuW88V4Iy43cp6JhLy7RIvVjVDgRbH2I4nK98743MszrYLIdHwSQKzbJR7ZTlmmkNZ
 3MmmkCF7yz6Fiv2yN6NkqaEEWPbGCxn0KD9XDKh8alcG/QbHut8BJWrT14e8m2AehR3r
 zQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788906266; x=1789511066;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U8EkFagfl9uinl9KRuv/CDvRS8wFSFBw+B4s084qWz4=;
 b=s41I8JqtnESr2K4Iapgkev3zqonEBLRVob9NhPnD1fVrH+euvTACNrcMr1uxoLEXZm
 ukejjU3X+/fGZ6EIRuucgPMyytoVD+4la8fFt9wqRpoEmOJeOYmUyuZH8SBwahJKAI7g
 bBHTZvCGOt3Ctao0fqa3+kraper4GJt4mA/7h5skWu/jInvA6MGFxDr7Bp5Mv0lnXhwU
 9c+MjSaMRKLDGd3tdD6xagsYXod3hw76nrYfcCrygPStIBkTdzCZk7bQoudOXD/oUvTE
 ASJzz5UDDfLy7bWLRgIA0pcFQhQwrWj0UOmrGZoVCM8OiDlKJeMXdl9NdfqqUuYsFXU8
 uauQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUx3R0Uf/WFxOopN5IVeuNeMkG8oIVsuzG2vLLgV+R5JRybrgHCKzeW9ZzetCj04hmMWm6As7doVc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l0l+C8hLB+ehtKKwmix3VymlCjseWLtRRFEIbvmv072R3UxB6e
 H3+3tzHpl3gxgKgToLZBwJKDdJKAH+JqmPUdwU/lfP1QmejUKIsiIyG5pvx7DyTTM/RTf5CKh9N
 6r1D9tsdPx0na5GYI6mU80yXCKsTkLnw=
X-Gm-Gg: AYBFou2yQlKvNhE77pN69c0qJ+ugXvndIpDKYRIQGq+SnC1ij7Do5AymnwtVy0I5G5+
 PVOp3Z8PQ/DUDEGAHccBUDEm34R4+Rscy30Ta6LT8Utfr9NBjRKWQHx9fSW36ZMK9V6q4XHCnbY
 rmiGe4T8Y50NM2uFMjUmRLgJxf4sgg8qCKVgu0QISGPnfIL8JYYDFdgt6bPcXIt8ZMxB9cecIXp
 CYgQ8gQNkqm8fSFBu05+7fwbmt9AxvwDEUuK0ntMm6yJM0BSOl6aCdIPncrzG5mfGM8R78PlXJg
 bhn6s8I6ctBNs66OsJHZZ4ZndqsRjgMytxw2lpxEY/Ig9oUNREfqOwqcBjTsmhqjpmVWgZu1JX5
 J
X-Received: by 2002:a17:90b:4b41:b0:398:bad2:c0f with SMTP id
 98e67ed59e1d1-39b3d8310d0mr23157347a91.5.1788906266333; Tue, 08 Sep 2026
 15:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
 <CACu1E7GGdxTOsn+MRDT+7Guhjs-DDkZVx0Yet=RTxgQ4CNCKhw@mail.gmail.com>
 <CACSVV00BtmA0CotRucd8jG=cQLQw0YmLKEkTOV70qHBx=sG0sA@mail.gmail.com>
 <fl5uoffoh3gyod3f6jxgze33ut4jj4ttmgivtyoa5oykbt2aqp@rkktjz4yh4ll>
 <CACSVV03ShOw8D8d-5gDPYdzH3_Hp7EMz2CdfA3x08pCKAtw57g@mail.gmail.com>
 <CACu1E7H9KsUU=dV+iwQPOOX62+V8S5xstFf2LXhzeE7oSb3V4A@mail.gmail.com>
 <xq2q6jazk2a5atfthzwktn7qhrinxg4duhdxg22qrutgdycbwb@47nosxhcqloz>
 <6s7mwjzglv5slukj73glmshe4gwfyh6cvimxyeyn6l4r46lkpv@74mpfroj23xi>
In-Reply-To: <6s7mwjzglv5slukj73glmshe4gwfyh6cvimxyeyn6l4r46lkpv@74mpfroj23xi>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 8 Sep 2026 18:24:14 -0400
X-Gm-Features: AcwNN1UV5foMtL6xVJAa6TgZb3_vfx9LKjXxP4r4sT9_mlJ6kDTMt-VInvhka9I
Message-ID: <CACu1E7G8K+7ACJfArtVOGMDVbO+A3GEmghHBurXXCsDvdteJ+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: keep the GPU timestamp monotonic across
 power collapse
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: rob.clark@oss.qualcomm.com, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Tue, Sep 8, 2026 at 11:49=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Sep 08, 2026 at 06:26:22PM +0300, Dmitry Baryshkov wrote:
> > On Tue, Sep 08, 2026 at 11:09:17AM -0400, Connor Abbott wrote:
> > > On Tue, Sep 8, 2026 at 10:51=E2=80=AFAM Rob Clark <rob.clark@oss.qual=
comm.com> wrote:
> > > >
> > > > On Tue, Sep 8, 2026 at 4:41=E2=80=AFAM Dmitry Baryshkov
> > > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > >
> > > > > On Mon, Sep 07, 2026 at 04:20:43PM -0700, Rob Clark wrote:
> > > > > > On Thu, Aug 27, 2026 at 9:07=E2=80=AFPM Connor Abbott <cwabbott=
0@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Aug 27, 2026 at 7:13=E2=80=AFPM Dmitry Baryshkov
> > > > > > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > > > >
> > > > > > > > The always-on counter behind MSM_PARAM_TIMESTAMP sits in th=
e GPU power
> > > > > > > > domain on a4xx, a5xx and the GMU-less a6xx parts, so it res=
tarts from
> > > > > > > > zero whenever the GPU is powered up again and the timestamp=
 reported to
> > > > > > > > userspace jumps backwards. On an a702 six reads three secon=
ds apart all
> > > > > > > > land in the 500..1200 tick range, stepping backwards twice,=
 and on an
> > > > > > > > a530 the OpenCL device timer conformance test fails because
> > > > > > > > clGetDeviceAndHostTimer() returns an end time below the sta=
rt time.
> > > > > > > >
> > > > > > > > Save the counter in the suspend path of the affected genera=
tions, while
> > > > > > > > the GPU is still powered, and add the accumulated ticks to =
the value
> > > > > > > > reported to userspace.
> > > > > > >
> > > > > > > This is useless because the entire point of clGetDeviceAndHos=
tTimer()
> > > > > > > (and the similar thing in Vulkan) is to match what the GPU it=
self
> > > > > > > returns, and now you've broken that by adding an offset.
> > > > > >
> > > > > > Just to clarify, the timestamp needs to match what UMD reads di=
rectly
> > > > > > from hw in various different ways (timestamp queries, shader_cl=
ock,
> > > > > > etc)..
> > > > > >
> > > > > > If we can _restore_ the value (ie. write the hw reg) on resume,=
 that
> > > > > > would be ok.. but it doesn't look possible.
> > > > >
> > > > > Yes, a quick check shows that all relevant registers are write-ig=
nore.
> > > > >
> > > > > > Otherwise I guess we need
> > > > > > some scheme where an offset value is stored in memory somewhere=
, and
> > > > > > some coordination with userspace to add the offset in various
> > > > > > different paths.  But the kernel shouldn't be adding the offset=
 to
> > > > > > what it returns to userspace itself.
> > > > >
> > > > > Ack, thanks for the explanation. I tried to match what kgsl was d=
oing.
> > > > > It reads the GPU timers directly from the GPU, but for the CPU ti=
mers it
> > > > > reads the value from KGSL driver which accumulates the offset.
> > > > >
> > > > > If I understand you correctly, we need to export the offset to th=
e
> > > > > userspace via some extra page (like vdso) and let Mesa read it. C=
orrect?
> > > >
> > > > Yeah, it doesn't look like there is an existing GPU_READONLY && !AP=
RIV
> > > > BO we could re-use, so I think we need to create a new global (TTBR=
1)
> > > > "vdso" BO which is read-only to the GPU but otherwise accessible to
> > > > IB1+, along w/ MSM_PARAM_VDSO for UMD to query the address of this =
BO.
> > > > (And update msm_mapping test in igt to validate that it is read-onl=
y.)
> > > >
> > > > (I'm not married to the name "vdso" but not creative enough this
> > > > morning to think of something better)
> > > >
> > > > I'm a bit curious if kgsl handles this differently.. maybe there is
> > > > something I'm missing.  But somehow timestamps need to agree betwee=
n
> > > > what is read on the GPU and what is read on CPU.
> > > >
> > > > BR,
> > > > -R
> > >
> > > I think the kgsl timestamp offset stuff was only added for the new
> > > A750+ CX GMU counter which is not read-only. We do need to port that
> > > over to drm/msm. If the offset is applied for older GPUs, it's
> > > probably another case of kgsl not bothering to keep support for older
> > > GPUs in newer branches.
> >
> > I've been looking at the kgsl drivers from msm-3.18 / 4.4 as those
> > kernels targeted MSM8996/98.
>
> If I understand correctly, for those GPUs glGetInteger64v(GL_TIMESTAMP)
> reads the ALWAYSON perf counter through IOCTL_KGSL_PERFCOUNTER_READ. The
> perfcounters are all saved on suspend and summed towards the current
> value read from HW.
>
> --
> With best wishes
> Dmitry

I think GL_TIMESTAMP just wasn't ever exposed. The equivalent GLES
extension GL_EXT_disjoint_timer_query was written by Qualcomm, and it
explicitly allows zeroing on suspend/resume. IIUC it also doesn't use
the perfcounter, it probably submits a dummy job and reads
kgsl_cmdbatch_profiling_buffer::gpu_ticks_queued.

Connor
