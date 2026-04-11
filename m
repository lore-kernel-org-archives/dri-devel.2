Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811A9F3ED40
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 13:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9100B10E20B;
	Sat, 11 Apr 2026 13:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aKLONA1X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FaDVNuFj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E5010E20B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 13:56:28 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B4dtUb3873783
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 13:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=yh2v74eVUgATbTiDREMIszXOd/VRQYJ0x2a0dK2LEFM=; b=aK
 LONA1XnQn8S58xZ6yQNuh39E3l92IVXUwM1nZcRuv7AWROoStf//EvemFWXP2Xre
 9ybdcSeKDaiTFbiSzTJN4joe2BZq2lwdUySOxALEe1RJCWtiXCEgkZhen6abblOA
 7wL0B+ITLZT4gOGH31YivAgkfVeKUDlYAyitIv5TOuUg+Qq36N4a384iDdIUi14U
 Dt+HgsaZt6OSNHW3llg/lTa+A0pvjBoipEysblpr6EdEOYc2uN1XsQYSm1Am4FgD
 rHXMvP21uSmbZyQTK9UCrZmQ5/7hQcx67CH/CraNy6IxS9vZmGGa04C5JI/TUPRq
 eqtKEnidR+tIbbNP7fNw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfffhrrkg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 13:56:27 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-4236c3b8f32so5242455fac.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 06:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775915787; cv=none;
 d=google.com; s=arc-20240605;
 b=IuLP3azm9R8pc5N4XXfwuevZj4UQxzh0QEG1eJ2OZtTQpMFgvuohi+ZZGtAweyoHmR
 jS14h/DoVuvbbdHPlFSMVsdpRbdoUq0xQqddNAY2NajKGJxee4WmAHrZW8FBco28/tvw
 +9+lrQeew3Obfaqn5CE9+T1f9Y7CULHSPTErNs6q6PtNwN5xXqT+e6W3eOSC9ucdeN/h
 scLBaEORitInlNpj63za++KHlgM+nxrCb1yxQDEhmrxotBpKVxe70h6K4nUXLK9q5H08
 tbGJIe+1opkuqIzxafZCqmMkHvCGvI/k7VO9o2yV1R455XBh2WoJgEiU0ox2vosQ1vY3
 TCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=yh2v74eVUgATbTiDREMIszXOd/VRQYJ0x2a0dK2LEFM=;
 fh=qdGGaXMFcoa2GHvaQj2+JbVFf9+bNCd/daxfjHp6j2g=;
 b=gmysfgqi3yPXMUbcRDtqyPrKgLQxbuqNvtPARnxBDLqAJnSsoajkARQWKqpsgCjOzL
 obiMdJohkWt44Zk4XF6kjaLvREyeKpxqVTV6D+LfCUfbe0O8rs1T5uo2OFPuoT636NDC
 HRZnn8PhttemVanOEwZ60Eb7SzUn7qiCRd26Q2rXsLiEwHYh681VF3BtJP4Wj87ZkEbO
 8Wx0lJOIXswUV9LER6p260FemYSs5wgb2tg3AwAJ92ZJRezVWmSW3kODSupurKCcr7hU
 0YZr4xQMsaoYz7DHxwESVj+oAkJKszW1lG6A31VmbeF226/a19LBninSYpLSWvwEkG1K
 FjMg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775915787; x=1776520587;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yh2v74eVUgATbTiDREMIszXOd/VRQYJ0x2a0dK2LEFM=;
 b=FaDVNuFj84POlruPRhWjZRSGxhg692rdLcJI5H7Or/7zxseq03/nQHdk2Ehxezwn1f
 ZELBB9MYtBxaThfZGa+m+nELVilwg0rO3fEMZX5CYfQ22Oltw236N+9qtzzVe5PR1XFy
 zKOG+E8F0HwzYa95tSeIW3E0+c9xVBPzUo1TixHRZW0UtiHMr63RTM4VZUw8lSs6SRPX
 3xJamzi5SEIENCFOCEVlPyholfekF0czrtrnhOTY86KG72BAB66qsQXpmj78TgMszsXd
 GuwuJE1KRpKMxoIFXekUPO+maUZcmjU2ofW043Ay/sna38KriJuk0zw5qZPuUQrkI87H
 HqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775915787; x=1776520587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yh2v74eVUgATbTiDREMIszXOd/VRQYJ0x2a0dK2LEFM=;
 b=UB4YM4BUA7hDJuqh0sHAp2/KOZHSrq6hHdqi7tGG6W8X7GHIJ+h0cUAZX7YvJaw6NV
 mWddXC+VRpnRGj0q1+fPUFO+EVYXK7qcJ2smp4xCOq+obpDB7RTZ0kTZJAUBxDQnybKb
 7Rr2ze0V7SECenR4Cpxp8F2ePqo+NOJx384kw2QXbrejSBUgpj0KYjIY/xH3Ae84J6PT
 mTdlPpi1q3SEanuAnaMJzk/gyCigsp3tn82rphunfFmsj8gadNCCAtILHJrOQsztxA2A
 ySjVSRX6fuLMIebcNLqUkD18pB/dlMt6IZVIYDer9qACy86IxkvLbocWxXOcp9BGTACr
 hg6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZmfaPTenyMbtNKdl2s+yoDYnpEq39GtfMJFVd4U0EntOp4gWiV7kvvXtHy68b4/pBZ06DaV5cRCM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEjWM9i2nyMdUzjeGYfYVKbdXLKrT0HpVxy9S2HR3ef5MXSlEb
 GIQ7gsrzeTlPUeOvIiUPt1kJ2M1miyQdCDwYqWV2SL7Gg9owJRp++4wdmAwoI4nzs4bbJ5i4Enk
 AbantpxetLUZUhHxVIvYMyXOPayTQfATAKNigckxilmIY2gaqME/hu59nuHPDux40Xf4xYTLNQ/
 qj7mUa/3E+5SGJDSrWQrg2dCJYdvmHz84/lT55DbPoM83KNw==
X-Gm-Gg: AeBDies0BS6bBhyhSkvclMqkcNBW6WjmqpWCXfDxN7DQGrSfYRURKUvkx9V/knD+vb0
 7m+4Kv+iL1WW6bmUniRKZFXu1GWBL8g+/naojeS8umeW+72oBONeVXQAWlf0lcbYXCPI2n4DHpW
 yEEWz9m+YsiuXdYxryFA9X/esGm3sZRpbppMJ/7RZD9e1ANewvqZCImrQZuk6xV5nuJbFl0ESrc
 TuReVaXwJj3eHQYoFX94STDHaHSEU3Abx3Z4Q==
X-Received: by 2002:a05:6870:1704:b0:423:b4e9:b8fa with SMTP id
 586e51a60fabf-423bd0ca63fmr5438604fac.23.1775915787015; 
 Sat, 11 Apr 2026 06:56:27 -0700 (PDT)
X-Received: by 2002:a05:6870:1704:b0:423:b4e9:b8fa with SMTP id
 586e51a60fabf-423bd0ca63fmr5438586fac.23.1775915786551; Sat, 11 Apr 2026
 06:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-15-2b53c38d2101@oss.qualcomm.com>
 <07fcf759-b53c-4bc8-8e88-48b82713fecb@oss.qualcomm.com>
In-Reply-To: <07fcf759-b53c-4bc8-8e88-48b82713fecb@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 06:56:15 -0700
X-Gm-Features: AQROBzA-sRqdmBF_muUFAE2zHOFlBaMvdKWe5l0zbT8wwrPZW6ScfJPwLACwsdM
Message-ID: <CACSVV03gr87bJcywyt1wHoaLRaaUJEmKAz3jTmipUt9NGSqbtQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/17] drm/msm/a8xx: Preemption support for A840
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDExOSBTYWx0ZWRfX0MATVsj8hvBy
 8fdbqUJMdtyz7A1Vp4VD8KoDaSUPYnoys6B3SRPsJuecPyJmjR7sVl/yJ7nq1faSfSabAzMEFNW
 QvwdEtlTzvMo289eje2yGa2Kd4h/LjZm4OHHy+STSDexhP2/o+8Oo1IU1ONaUnYYi+5oPbD1SjY
 4nwRr7KYyxd81vihJTDCBMwHw/YoHMxcaKHw3z8p9sWhqprR6wsrq+nYP84YFQIg+NaG+CYET7I
 qIgSH1gXVPHETSLDVz6/qejltTeTjilQkx9bv6vgVOiJJV6dXd3brKGSLCnWIL/MpL2Lj1WzSyF
 WJf66ScRAk6vPHXlBfIMwN0aoc1km148TYVWeQtxFX0wrRQZqhJtA2xDvAGWTC3B1YvOQQdRSAZ
 Ua40mJgAu58OdZ2BxcAhRJpVOcaIK4Khndx6prf3M61rjkgYIYkh1FtrPiMI/ztfIQexuW9InAS
 sybAK/N9Gv0Ibca4Row==
X-Proofpoint-ORIG-GUID: K-0a9SZShMy9cltiIMa1O_bGrxk08sjF
X-Authority-Analysis: v=2.4 cv=FOkrAeos c=1 sm=1 tr=0 ts=69da530b cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=dlYDSFsnk2uCUIF3f14A:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-GUID: K-0a9SZShMy9cltiIMa1O_bGrxk08sjF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110119
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

On Fri, Apr 10, 2026 at 7:22=E2=80=AFPM Jie Gan <jie.gan@oss.qualcomm.com> =
wrote:
>
>
>
> On 3/27/2026 8:14 AM, Akhil P Oommen wrote:
> > The programing sequence related to preemption is unchanged from A7x. Bu=
t
> > there is some code churn due to register shuffling in A8x. So, split ou=
t
> > the common code into a header file for code sharing and add/update
> > additional changes required to support preemption feature on A8x GPUs.
> >
> > Finally, enable the preemption quirk in A840's catalog to enable this
> > feature.
> >
> > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > ---
> >   drivers/gpu/drm/msm/Makefile              |   1 +
> >   drivers/gpu/drm/msm/adreno/a6xx_catalog.c |   1 +
> >   drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |   7 +-
> >   drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |   5 +
> >   drivers/gpu/drm/msm/adreno/a6xx_preempt.c |  77 +--------
> >   drivers/gpu/drm/msm/adreno/a6xx_preempt.h |  82 ++++++++++
> >   drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |  37 ++++-
> >   drivers/gpu/drm/msm/adreno/a8xx_preempt.c | 259 +++++++++++++++++++++=
+++++++++
> >   8 files changed, 389 insertions(+), 80 deletions(-)
> >
[...]
> > diff --git a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c b/drivers/gpu/dr=
m/msm/adreno/a8xx_preempt.c
> > new file mode 100644
> > index 000000000000..3d8c33ba722e
> > --- /dev/null
> > +++ b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
> > @@ -0,0 +1,259 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. =
*/
> > +
> > +#include "msm_gem.h"
> > +#include "a6xx_gpu.h"
> > +#include "a6xx_gmu.xml.h"
> > +#include "a6xx_preempt.h"
> > +#include "msm_mmu.h"
> > +#include "msm_gpu_trace.h"
> > +
> > +static void preempt_prepare_postamble(struct a6xx_gpu *a6xx_gpu)
> > +{
> > +     u32 *postamble =3D a6xx_gpu->preempt_postamble_ptr;
> > +     u32 count =3D 0;
> > +
> > +     postamble[count++] =3D PKT7(CP_REG_RMW, 3);
> > +     postamble[count++] =3D REG_A8XX_RBBM_PERFCTR_SRAM_INIT_CMD;
> > +     postamble[count++] =3D 0;
> > +     postamble[count++] =3D 1;
> > +
> > +     postamble[count++] =3D PKT7(CP_WAIT_REG_MEM, 6);
> > +     postamble[count++] =3D CP_WAIT_REG_MEM_0_FUNCTION(WRITE_EQ);
> > +     postamble[count++] =3D CP_WAIT_REG_MEM_POLL_ADDR_LO(
> > +                             REG_A8XX_RBBM_PERFCTR_SRAM_INIT_STATUS);
> > +     postamble[count++] =3D CP_WAIT_REG_MEM_POLL_ADDR_HI(0);
> > +     postamble[count++] =3D CP_WAIT_REG_MEM_3_REF(0x1);
> > +     postamble[count++] =3D CP_WAIT_REG_MEM_4_MASK(0x1);
> > +     postamble[count++] =3D CP_WAIT_REG_MEM_5_DELAY_LOOP_CYCLES(0);
> > +
> > +     a6xx_gpu->preempt_postamble_len =3D count;
> > +
> > +     a6xx_gpu->postamble_enabled =3D true;
> > +}
> > +
> > +static void preempt_disable_postamble(struct a6xx_gpu *a6xx_gpu)
> > +{
> > +     u32 *postamble =3D a6xx_gpu->preempt_postamble_ptr;
> > +
> > +     /*
> > +      * Disable the postamble by replacing the first packet header wit=
h a NOP
> > +      * that covers the whole buffer.
> > +      */
> > +     *postamble =3D PKT7(CP_NOP, (a6xx_gpu->preempt_postamble_len - 1)=
);
> > +
> > +     a6xx_gpu->postamble_enabled =3D false;
> > +}
> > +
> > +/*
> > + * Set preemption keepalive vote. Please note that this vote is differ=
ent from the one used in
> > + * a8xx_irq()
> > + */
> > +static void a8xx_preempt_keepalive_vote(struct msm_gpu *gpu, bool on)
> > +{
> > +     struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > +     struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > +
> > +     gmu_write(&a6xx_gpu->gmu, REG_A8XX_GMU_PWR_COL_PREEMPT_KEEPALIVE,=
 on);
> > +}
> > +
> > +void a8xx_preempt_irq(struct msm_gpu *gpu)
> > +{
> > +     uint32_t status;
> > +     struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > +     struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > +     struct drm_device *dev =3D gpu->dev;
> > +
> > +     if (!try_preempt_state(a6xx_gpu, PREEMPT_TRIGGERED, PREEMPT_PENDI=
NG))
> > +             return;
> > +
> > +     /* Delete the preemption watchdog timer */
> > +     timer_delete(&a6xx_gpu->preempt_timer);
> > +
> > +     /*
> > +      * The hardware should be setting the stop bit of CP_CONTEXT_SWIT=
CH_CNTL
> > +      * to zero before firing the interrupt, but there is a non zero c=
hance
> > +      * of a hardware condition or a software race that could set it a=
gain
> > +      * before we have a chance to finish. If that happens, log and go=
 for
> > +      * recovery
> > +      */
> > +     status =3D gpu_read(gpu, REG_A8XX_CP_CONTEXT_SWITCH_CNTL);
> > +     if (unlikely(status & A8XX_CP_CONTEXT_SWITCH_CNTL_STOP)) {
> > +             DRM_DEV_ERROR(&gpu->pdev->dev,
> > +                                       "!!!!!!!!!!!!!!!! preemption fa=
ulted !!!!!!!!!!!!!! irq\n");
> > +             set_preempt_state(a6xx_gpu, PREEMPT_FAULTED);
> > +             dev_err(dev->dev, "%s: Preemption failed to complete\n",
> > +                     gpu->name);
> > +             kthread_queue_work(gpu->worker, &gpu->recover_work);
> > +             return;
> > +     }
> > +
> > +     a6xx_gpu->cur_ring =3D a6xx_gpu->next_ring;
> > +     a6xx_gpu->next_ring =3D NULL;
> > +
> > +     set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
> > +
> > +     update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
> > +
> > +     set_preempt_state(a6xx_gpu, PREEMPT_NONE);
> > +
> > +     a8xx_preempt_keepalive_vote(gpu, false);
> > +
> > +     trace_msm_gpu_preemption_irq(a6xx_gpu->cur_ring->id);
> > +
> > +     /*
> > +      * Retrigger preemption to avoid a deadlock that might occur when=
 preemption
> > +      * is skipped due to it being already in flight when requested.
> > +      */
> > +     a8xx_preempt_trigger(gpu);
> > +}
> > +
> > +void a8xx_preempt_hw_init(struct msm_gpu *gpu)
> > +{
> > +     struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > +     struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > +     int i;
> > +
> > +     /* No preemption if we only have one ring */
> > +     if (gpu->nr_rings =3D=3D 1)
> > +             return;
> > +
> > +     for (i =3D 0; i < gpu->nr_rings; i++) {
> > +             struct a6xx_preempt_record *record_ptr =3D a6xx_gpu->pree=
mpt[i];
> > +
> > +             record_ptr->wptr =3D 0;
> > +             record_ptr->rptr =3D 0;
> > +             record_ptr->rptr_addr =3D shadowptr(a6xx_gpu, gpu->rb[i])=
;
> > +             record_ptr->info =3D 0;
> > +             record_ptr->data =3D 0;
> > +             record_ptr->rbase =3D gpu->rb[i]->iova;
> > +     }
> > +
> > +     /* Write a 0 to signal that we aren't switching pagetables */
> > +     gpu_write64(gpu, REG_A8XX_CP_CONTEXT_SWITCH_SMMU_INFO, 0);
> > +
> > +     /* Enable the GMEM save/restore feature for preemption */
> > +     gpu_write(gpu, REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABL=
E, 0x1);
> > +
> > +     /* Reset the preemption state */
> > +     set_preempt_state(a6xx_gpu, PREEMPT_NONE);
> > +
> > +     spin_lock_init(&a6xx_gpu->eval_lock);
> > +
> > +     /* Always come up on rb 0 */
> > +     a6xx_gpu->cur_ring =3D gpu->rb[0];
> > +}
> > +
> > +void a8xx_preempt_trigger(struct msm_gpu *gpu)
> > +{
> > +     struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > +     struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > +     unsigned long flags;
> > +     struct msm_ringbuffer *ring;
> > +     unsigned int cntl;
> > +     bool sysprof;
> > +
> > +     if (gpu->nr_rings =3D=3D 1)
> > +             return;
> > +
> > +     /*
> > +      * Lock to make sure another thread attempting preemption doesn't=
 skip it
> > +      * while we are still evaluating the next ring. This makes sure t=
he other
> > +      * thread does start preemption if we abort it and avoids a soft =
lock.
> > +      */
> > +     spin_lock_irqsave(&a6xx_gpu->eval_lock, flags);
> > +
> > +     /*
> > +      * Try to start preemption by moving from NONE to START. If
> > +      * unsuccessful, a preemption is already in flight
> > +      */
> > +     if (!try_preempt_state(a6xx_gpu, PREEMPT_NONE, PREEMPT_START)) {
> > +             spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
> > +             return;
> > +     }
> > +
> > +     cntl =3D A8XX_CP_CONTEXT_SWITCH_CNTL_LEVEL(a6xx_gpu->preempt_leve=
l);
> > +
> > +     if (a6xx_gpu->skip_save_restore)
> > +             cntl |=3D A8XX_CP_CONTEXT_SWITCH_CNTL_SKIP_SAVE_RESTORE;
> > +
> > +     if (a6xx_gpu->uses_gmem)
> > +             cntl |=3D A8XX_CP_CONTEXT_SWITCH_CNTL_USES_GMEM;
> > +
> > +     cntl |=3D A8XX_CP_CONTEXT_SWITCH_CNTL_STOP;
> > +
> > +     /* Get the next ring to preempt to */
> > +     ring =3D get_next_ring(gpu);
> > +
> > +     /*
> > +      * If no ring is populated or the highest priority ring is the cu=
rrent
> > +      * one do nothing except to update the wptr to the latest and gre=
atest
> > +      */
> > +     if (!ring || (a6xx_gpu->cur_ring =3D=3D ring)) {
> > +             set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
> > +             update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
> > +             set_preempt_state(a6xx_gpu, PREEMPT_NONE);
> > +             spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
> > +             return;
> > +     }
> > +
> > +     spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
> > +
> > +     spin_lock_irqsave(&ring->preempt_lock, flags);
> > +
> > +     struct a7xx_cp_smmu_info *smmu_info_ptr =3D
> > +             a6xx_gpu->preempt_smmu[ring->id];
> > +     struct a6xx_preempt_record *record_ptr =3D a6xx_gpu->preempt[ring=
->id];
> > +     u64 ttbr0 =3D ring->memptrs->ttbr0;
> > +     u32 context_idr =3D ring->memptrs->context_idr;
>
> Shall we declare these variables at the top of the function body?
>

We can use c11 / mixed code/declarations now.  It's actually kinda
required for cleanup.h stuff (which I recommend for new code, where
possible.. I've been using it for PERFCNTR_CONFIG ioctl that I'm
working on, and it makes error path cleanup much more straightforward)

BR,
-R
