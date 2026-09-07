Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57BCC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 23:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1266210E083;
	Mon,  7 Sep 2026 23:20:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UZTdbrzt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="chIeuL8T";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5819F10E054
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 23:20:57 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687KlBQa949503
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 23:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=0kXpsFkhTZTYWV+8wLjoGpwSIYOZnfZDtRnu3dzmks8=; b=UZ
 Tdbrzt+oEj3L4P1sex6z7RsHWfouNMFpj0q2giCKwZfZ5WCw9k9R2whHio8prHku
 gaWM7tbWB46sO+m2k7ZDddAPodDstUk2jjay73Fq94ZdpeezjLC9w/2npPTAtTzG
 EL0rmmVwN5rQGBYR0GXT1tiFpnwF/CYqdJr5zoBHkdcgjiJ06Sc5WNJubElxv2Te
 j7xFIYZd/C8nd0wPRG2lJdtLWTm38IRxU7LGn0D99qzc6HJkYQJUIZwRtpIVktAA
 8HuWYJwVAIOBuwAk6Yg8ux6/WgtLxY5F49/GfhhGVx6YLvBcLcvudbOgs13pSE9J
 ffU81UA7W1YqMR5XhJFw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwgt9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 23:20:55 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7ead32f5c6aso3180451a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 16:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788823255; cv=none;
 d=google.com; s=arc-20260327;
 b=oAuV9rm70fR5ea4+8casF3GFDEt+PLIs9mYqnFua1llS1DDfT1pCwoSUi1glFyV3oK
 fNRIV6BVM0zkqTwooasDOgq8E8y5uGpl70/ySAgjlv9pTvBEOkERry1ZLPsWJR8nrowi
 rPgiCYyl9tBqX6M5a9sk3cmUWv3qOqlByIR2zRUPpR/wTczwKTPbxcwFaQ5ZOjgbTH1I
 YFWu7qPJ1uIISZkqcnzprQfQtb9EY3JcdwIeRni6gtGGyTF8PJnMFfmAijXM92A+JrlI
 8Fg/qVZmAPIUlRQN9AQIlpj23Yq1ilXhs76KETEDyoWqYlV/xfIhDOs82V8br30EH/GA
 3oPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=0kXpsFkhTZTYWV+8wLjoGpwSIYOZnfZDtRnu3dzmks8=;
 fh=+jhIVfGCeDy+vNOtZs5FMpYvB5LbfpUHiPLXAG6YrYo=;
 b=Exfd4WaM2bwd74A/XtSbUuuI7kq9nAmQgu6oDVQZrao2RXZWgDCJu+kmek6bLn0I/K
 qnvVxyyAIfG6q0uDEfHtneeYySmpuA3QK+cjdsRzT4WjE8W0XFkR7VLXsQlI4Ru7DPbB
 r4NisiW3oKk9rJIAE3g6nwKjSzHmv6PrZwDyX0AzkkNu50eOa8pjueDl3T3nhomNA6Q4
 +IcbPjf8NKKRA4PfBSyCjpIq2sOSx9Pf6v7fnObVuRAYQ5RBsXpsST/9UbCJ/1A70kBe
 k7V3jR59xljVLmeB77M+ndxFJQRe8fz5w+lHxMcIzIIXmak/G31nJHYAvLezgrfn2S3u
 C/yw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788823255; x=1789428055;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0kXpsFkhTZTYWV+8wLjoGpwSIYOZnfZDtRnu3dzmks8=;
 b=chIeuL8TK+3CmGtgnLFHyG4WZJZaRWq0xtn9/yuGc3DOhscyIroR4Ji992FPgsTDqp
 QK05FDoqvrR1/wDIgBREttjJ2BmdAKxJCoJemJ/hHs2O+S8pupCtovenGmF4e4NfEmJv
 8dgNxH4cAiYQ/F1euDIAbcdqyM4Ya9t3DIL5mI0gp55ihX0FEyzqx1GMLOzK+O6UL3ik
 KdM+JYrtYcvW3D1eLa1lUxGHVoDVPqYsVA2GdyFTkHnnsuWxO00k21eX3ywRfAe+O52s
 MHSP12sET/PGGhb/BAOHSiWBPQfCMzhWfQNM15Erue/8sMcHfLoEXCvARtYCF+B2nb4Z
 tXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788823255; x=1789428055;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0kXpsFkhTZTYWV+8wLjoGpwSIYOZnfZDtRnu3dzmks8=;
 b=Tw9sOMvkO3hpacLMMJFESGYYxYLKYA1VREf3fw8Rk9a3/bBm3w9hd8AmO817ineHTv
 JyXdZU9DS6povZxyCQeq1bwuKiM6E+T/P3I4u4xpuewbV+0/0So9lf7aFjqWADkxjljN
 7ifGnrlXPpgBR8Q0l87gFAR0uWv1994s/ycqi0CQJcp0lM8fGDBd4emGmiPAoPjEZE3E
 2KJsRbKsqRdRHxn2qt27YB1FKtHqhLcGyPl7Ge92An4+CniYu8hN91G/2HzevRhcIvhi
 osJmkgwL4+PcA5VR40yrEHDhj88sn4OZptmSVGmOa06j0yJ9Ja0rZF3HELighVlIs4T8
 7n5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxW+Te3YeiWI9OkdsBedd1kriTG8+5BAjm4o3/e5v7h/dDCUyKsPp2t4+JUSD+iyVjDQdwBrYaqPnQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lO02NjdpEc9gBxfZ4Q23rSvU9bU+4sMyaxVLPsatKgkAXL4+gH
 RCaYKFjtJar96/O09zmyMQDMVnerWOS4GZzVGSXdgJJU3d6aWBADj7GAlZ4UCVwOMGq+KDe76aZ
 j32vlQQWC7h/upl7Vu6o7NZo1s+5xaCusVP6UzegREj76l49GwbkG/MAI1wm3Po4ryxailxbNdU
 uP56kkXV4PDq3qKeQ5qw9vfsDc+dvb1O/wCKbbnzxckP6zkw==
X-Gm-Gg: AYBFou1rZ/TdiAG+2+90JGcMTuyLQkN8Kx/EoWc3kULbj87c37j8vcZtNqWoH/+Ngr6
 uCn7H4ERLrZgOtvWLHyQL6aV7U9VTTbieXrmJxxE7peAD3TgBjRfwOTcrB4zR74cYw/OeYjLNjz
 7oP4rCLhRNDlCTrDUYg2P63LvpNF+U8Fo+BMlVi0IzYCnEIF/iF9fqm/bW
X-Received: by 2002:a05:6820:4b03:b0:6b1:d1cb:cd6 with SMTP id
 006d021491bc7-6b6fcfd9588mr14080510eaf.23.1788823255175; 
 Mon, 07 Sep 2026 16:20:55 -0700 (PDT)
X-Received: by 2002:a05:6820:4b03:b0:6b1:d1cb:cd6 with SMTP id
 006d021491bc7-6b6fcfd9588mr14080488eaf.23.1788823254758; Mon, 07 Sep 2026
 16:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260828-b4-adreno-timestamp-v1-1-273525da144c@oss.qualcomm.com>
 <CACu1E7GGdxTOsn+MRDT+7Guhjs-DDkZVx0Yet=RTxgQ4CNCKhw@mail.gmail.com>
In-Reply-To: <CACu1E7GGdxTOsn+MRDT+7Guhjs-DDkZVx0Yet=RTxgQ4CNCKhw@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 16:20:43 -0700
X-Gm-Features: AcwNN1Vjgj-tYHtj6eTbg-Hki5u63lIX48kQkMC8BVBIy_zhePixhFmWvWpwWWw
Message-ID: <CACSVV00BtmA0CotRucd8jG=cQLQw0YmLKEkTOV70qHBx=sG0sA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: keep the GPU timestamp monotonic across
 power collapse
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6a9f46d7 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=hd7ZCrGOQM2Qc8NPfv8A:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDI1NyBTYWx0ZWRfX7ehkzLmVCl5T
 yX2P6cvgO7OSKT6A0cumFI5bD9eikOs4k6wfu2xxsm8oS5KIZCjbITjf5YFBbYYQBsLwn6R++ra
 Zc0EBD19Ot3tdplsyLks1/IvTOrIFx0nk5JdCF7tgTChV9T6Cx8gFWOlVU+ORcdfNMxG8KNAgFP
 D/KY6KS7ptBDfkley//TBB3MRM73cyBG+hlnszu7JLJvDGABlRibOLXOkFvhZuj8vUK1gKViSdq
 dvds66dLXlSUt2Tf64oGQZJh/JB1yTP6/AmNDyV/uYIiGNBzsWpYikx0S0SwYPYBbvZTFw9wUms
 SSHHkL72+en6diaM5BEcVw5SLOZIptzbNJytTZIYC1ECX/Lud8Siy6jATp4x/SmS1xudHBvkkBU
 Qm0VhNatTvMGNb2T0M9SPZWkcDIlK0yjyhn+giheyBAr2t9rET8om5RSh18ZwPniEQ5JQYPhnlN
 SGNSSmNwEc06lrE5Q5g==
X-Proofpoint-ORIG-GUID: enA-BRu-4tvxAyujGrlGKfFIozNhT-PD
X-Proofpoint-GUID: enA-BRu-4tvxAyujGrlGKfFIozNhT-PD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDI1NyBTYWx0ZWRfX/9ZneB83vkF6
 VtVtRXUJdKbOODl4qun8LVAi2LGAkY+9O8+7ZJnYTosQYEWLaxf9rWXGgjNnDxxK5OY3AfKlv7g
 J6iU7MUUKkCqdwLYHes+MWVTm4s0ZQ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_06,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070257
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Aug 27, 2026 at 9:07=E2=80=AFPM Connor Abbott <cwabbott0@gmail.com>=
 wrote:
>
> On Thu, Aug 27, 2026 at 7:13=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
> > domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from
> > zero whenever the GPU is powered up again and the timestamp reported to
> > userspace jumps backwards. On an a702 six reads three seconds apart all
> > land in the 500..1200 tick range, stepping backwards twice, and on an
> > a530 the OpenCL device timer conformance test fails because
> > clGetDeviceAndHostTimer() returns an end time below the start time.
> >
> > Save the counter in the suspend path of the affected generations, while
> > the GPU is still powered, and add the accumulated ticks to the value
> > reported to userspace.
>
> This is useless because the entire point of clGetDeviceAndHostTimer()
> (and the similar thing in Vulkan) is to match what the GPU itself
> returns, and now you've broken that by adding an offset.

Just to clarify, the timestamp needs to match what UMD reads directly
from hw in various different ways (timestamp queries, shader_clock,
etc)..

If we can _restore_ the value (ie. write the hw reg) on resume, that
would be ok.. but it doesn't look possible.  Otherwise I guess we need
some scheme where an offset value is stored in memory somewhere, and
some coordination with userspace to add the offset in various
different paths.  But the kernel shouldn't be adding the offset to
what it returns to userspace itself.

BR,
-R

> Connor
>
> >
> > Assisted-by: LLM
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> > The always-on counter behind MSM_PARAM_TIMESTAMP sits in the GPU power
> > domain on a4xx, a5xx and the GMU-less a6xx parts, so it restarts from z=
ero
> > whenever the GPU is powered up again and the timestamp userspace reads
> > jumps backwards.  Accumulate what the counter reached before each suspe=
nd
> > and add it to what is reported afterwards.
> >
> > Measured on an a530 and an a702; the GMU parts keep their own counter a=
live
> > and are left alone.
> > ---
> >  drivers/gpu/drm/msm/adreno/a4xx_gpu.c   |  2 ++
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  2 ++
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  3 +++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 +++++++++-
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  3 +++
> >  5 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/ms=
m/adreno/a4xx_gpu.c
> > index 6392126f48f2..7d9dd9460f5b 100644
> > --- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
> > @@ -593,6 +593,8 @@ static int a4xx_pm_suspend(struct msm_gpu *gpu) {
> >         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> >         int ret;
> >
> > +       adreno_save_timestamp(gpu);
> > +
> >         ret =3D msm_gpu_pm_suspend(gpu);
> >         if (ret)
> >                 return ret;
> > diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/ms=
m/adreno/a5xx_gpu.c
> > index f1df2514c613..c5552f1085e0 100644
> > --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > @@ -1423,6 +1423,8 @@ static int a5xx_pm_suspend(struct msm_gpu *gpu)
> >                 gpu_write(gpu, REG_A5XX_RBBM_BLOCK_SW_RESET_CMD, 0x0000=
0000);
> >         }
> >
> > +       adreno_save_timestamp(gpu);
> > +
> >         ret =3D msm_gpu_pm_suspend(gpu);
> >         if (ret)
> >                 return ret;
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/ms=
m/adreno/a6xx_gpu.c
> > index f9de9329dee3..106cc2ac55ff 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -2252,6 +2252,9 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
> >
> >         trace_msm_gpu_suspend(0);
> >
> > +       /* only the GMU-less parts come here, and their counter is in t=
he GPU */
> > +       adreno_save_timestamp(gpu);
> > +
> >         a6xx_llc_deactivate(a6xx_gpu);
> >
> >         msm_devfreq_suspend(gpu);
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/=
msm/adreno/adreno_gpu.c
> > index 3370cd44382f..f83960b31901 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -226,6 +226,13 @@ adreno_iommu_create_vm(struct msm_gpu *gpu,
> >         return vm;
> >  }
> >
> > +void adreno_save_timestamp(struct msm_gpu *gpu)
> > +{
> > +       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > +
> > +       adreno_gpu->timestamp_offset +=3D adreno_gpu->funcs->get_timest=
amp(gpu);
> > +}
> > +
> >  u64 adreno_private_vm_size(struct msm_gpu *gpu)
> >  {
> >         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > @@ -398,7 +405,8 @@ int adreno_get_param(struct msm_gpu *gpu, struct ms=
m_context *ctx,
> >         case MSM_PARAM_TIMESTAMP:
> >                 if (adreno_gpu->funcs->get_timestamp) {
> >                         pm_runtime_get_sync(&gpu->pdev->dev);
> > -                       *value =3D adreno_gpu->funcs->get_timestamp(gpu=
);
> > +                       *value =3D adreno_gpu->timestamp_offset +
> > +                                adreno_gpu->funcs->get_timestamp(gpu);
> >                         pm_runtime_put_autosuspend(&gpu->pdev->dev);
> >
> >                         return 0;
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/=
msm/adreno/adreno_gpu.h
> > index 114a40f79ef3..db080a6d515c 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > @@ -207,6 +207,8 @@ struct adreno_gpu {
> >         uint16_t speedbin;
> >         const struct adreno_gpu_funcs *funcs;
> >
> > +       u64 timestamp_offset;
> > +
> >         struct completion fault_coredump_done;
> >
> >         /* interesting register offsets to dump: */
> > @@ -610,6 +612,7 @@ static inline int adreno_is_a840(struct adreno_gpu =
*gpu)
> >  /* Put vm_start above 32b to catch issues with not setting xyz_BASE_HI=
 */
> >  #define ADRENO_VM_START 0x100000000ULL
> >  u64 adreno_private_vm_size(struct msm_gpu *gpu);
> > +void adreno_save_timestamp(struct msm_gpu *gpu);
> >  int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
> >                      uint32_t param, uint64_t *value, uint32_t *len);
> >  int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
> >
> > ---
> > base-commit: 140b13475302601368c0cf4e193e66126a49feb3
> > change-id: 20260828-b4-adreno-timestamp-f4c846391b97
> >
> > Best regards,
> > --
> > With best wishes
> > Dmitry
> >
