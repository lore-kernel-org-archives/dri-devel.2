Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99903CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 00:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B7C10E012;
	Tue,  9 Jun 2026 00:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rq+JHq3F";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FnwYRfT8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5366C10E01F
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 00:20:20 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658NF4uK827455
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 00:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=g/yDs1pWMBxtNUmoY/P6JmCwRYdd15PIPXQOQYf5Em8=; b=Rq
 +JHq3FVu1wtkznk8o8bpLJz7b7J2aytL+ddN7RGjmdy0I4MICe4725LFgbkhf6dr
 wJDgq5T6xWUf8OK5LzzYyu0/0TGQ8kKdsjwVeFsPT++nfTDl6e58aLC50L2nNgkJ
 NjqBzXFL0XRT+u3sRv8+uvzWCTx6hLWlgwaRQTIeQX5vW3Cbqb2RdvhOe5llCwGX
 hLLcxti1WgvSXNF0CMy2eutCl/OLIlzgnC6NL0H97XLftK7XH/RYuEOinThxKSA1
 hmTVrQyK2a4UHilphLIxNrSNab5S+jvGwA5UhWmn5gEi0li8CUM6dhDUQ/DMoCmB
 8gaQy3Rmhh4N4NW126Sw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuptkj7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 00:20:19 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e6eeff3b75so1153033a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 17:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780964419; cv=none;
 d=google.com; s=arc-20240605;
 b=M0UY9AgcADZSnUzFCQnBZ/fyC64AfnXumbhqbN/LpKxD5JAi6sCraRuoPp8J66CoG3
 ND3uFr/4ghiqidAiIIZeM4tCt1KIr/vqanUQr5fdsgCXhL7EIhZFjlT+g1nI/qOHhx24
 K9ZKZ/F4Fp1AAN06Y6QqaahaSpN6DILUl45TUkf15qEnMB7rId7v3XqSODFcQCgrZOpq
 N4QmZKcmpwuUa+cPgNdGuM+OCeqTzM+Yj74NfwUhX1rJCUhFoSKMQMtYZfn6CAREj9QA
 gjJICYAGzo4NN4FLe9DW1Ja+WxGbU2Aj16xMV8czhVYc9w1e454tqLU8I3oncdXWaerU
 aIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=g/yDs1pWMBxtNUmoY/P6JmCwRYdd15PIPXQOQYf5Em8=;
 fh=89NhNmpJBnRoAM8NVaGpAjBNYjlsVwRYT3CX7daE+H8=;
 b=Vak0w5+Yani2fBepG1sVDAfYZwA/ibONiaquXgO8f5irJjdbvePFkbWTgsWu4aQXjG
 ZZlfKuE494C2zvnDe5apcrh/gP2MUHnt9mKr8FmnX09O1W855U7kSVKwruPpsVI0wver
 bUCO5vJzdnhekGadsgJOoaubimSyVSKK1oHvCw13giRPc+7/+XXBTtmBStuyePfJXm/y
 d8DJlH4syYztdC30/NmYGzuNSIazEhQZXZkyXcXyAfO4/4b+RHW0p6YFvk5/Q06TB85N
 XYrT+f6IK4kIPbsF4JbH+u+M2DEeuj57rAMAYWSgh9IHZqJWTgaNfpVOqylKfJcJbbca
 laFw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780964419; x=1781569219;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=g/yDs1pWMBxtNUmoY/P6JmCwRYdd15PIPXQOQYf5Em8=;
 b=FnwYRfT8tlqNnc+aPJVLEPmZerm/EGQDlR3te1dr37SD97ZY6rhFR47Rzl+577UZCT
 gT9D4JJDWEVI8VIo+mSAIqp6GN+uPMV872kiiWeTueFzAwwGpKDkCcja6WPGQVnAUbX/
 wQj3O4xlhhbmvYAhYGX45W7TlNAdmLLOf3ZbzQpLYbazXIS5qUbh1fNZFQuGW4sfOXdR
 sCuYuRwIxwDvdFZn59iOa0p8/MB0WdEb8/R8oDvxzKKAg/fIA6lYrLpD8DGeQAb6lWQG
 9yqMtOR2N4OEnlTIwvDSaHPN+mpk+pv0at6yb0cVqvOhT1A59XZ1R6a3vPbCqRL1qSbF
 y0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780964419; x=1781569219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g/yDs1pWMBxtNUmoY/P6JmCwRYdd15PIPXQOQYf5Em8=;
 b=BKwhsyIoahbwSgQX1BYWXX9W9+Xq68bt8lOnnJyrfABV+qb/SJDBIzEL/634iru89N
 zTcj7BQMVV0Oyo8ABSRi8g3WwglDSob4/bh811U+wIrXWFu5MjGbbdzti7A10UxtGH04
 anGUXZxB7FMHUGCbQRsWTAhuQ4VZG0pHru1cHwtyp3tCEYa2Mr43cnM6Kh6aEuwIrTOt
 BCz3VODSXUXKNG0vaSrGpnUErBEXT/agyq1KQvJBQUrEiwz/5/1cIxAvRoTJU9r6aC5s
 Egedo5eSFKqO/P3Q08nFaLtg4HkORPNnZeRGRUX4I12Jfnb1HEFXZOLd00GQogT3NJDo
 ZLXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GzBES3UkkYUdSwqBk5aypzAeMCOTerJQno841yCAUjeXiaSGoJLxxWp6ScZemF/J4CyjWizv+5F8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIykEox+eJtIS28woZ+7k4mfB2QvQyfBLK9QkDJqSgUoee8krR
 qgbgtVCD+YC4A78kPLYORs2y9GRgPjrIERnutCMFVLVLdTUsLqXIql+I9Y/WT0HngTXzZkThPBB
 mR/WZf/+JSYRf0GSajUvuejejsvvi9LHuvROSwHBvIlQRKpR0JVOC5Vo8LkMKWBVPag9tNA/m7O
 sknoBQ1a8g4MYIHJY79HYCA9X6EOGfXctcaMa9nOEEcBercg==
X-Gm-Gg: Acq92OGVMooqcXOGnImgGuSsFgxrqgkRFYplEpMRiM165/TRfJse/lMAJWfhLHOp2Pe
 ynd7r25kECVtIeb+BhTvCW8belFRWNsTzS65mjaZhzAuUmon3PiZel3NNJDrAGpl6SQgPoEpFDq
 8Y/kMVgQ9C/3SvXg8SmtrQjvtgYMEV6wFymgQIzNClwaQ1tGNOy6vUOBkTB/aT4uz200sxiQHe+
 XD5XSNsdCmZ2Lexe/SJff/roVxXtm/HacgNpzEy7hm9wWbh
X-Received: by 2002:a05:6830:8296:b0:7dc:c4ae:a689 with SMTP id
 46e09a7af769-7e70c5eaf75mr9770674a34.2.1780964418638; 
 Mon, 08 Jun 2026 17:20:18 -0700 (PDT)
X-Received: by 2002:a05:6830:8296:b0:7dc:c4ae:a689 with SMTP id
 46e09a7af769-7e70c5eaf75mr9770646a34.2.1780964418166; Mon, 08 Jun 2026
 17:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
 <20260605-assorted-fixes-june-v1-5-2caa04f7287c@oss.qualcomm.com>
 <CACSVV01dbQcjE+nTic+9R4VfCtNGvpwODH8BMZi8B7LFtcCCfQ@mail.gmail.com>
 <49b8530f-24d3-4201-b22c-0f8eaea9f4e0@oss.qualcomm.com>
In-Reply-To: <49b8530f-24d3-4201-b22c-0f8eaea9f4e0@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 17:20:06 -0700
X-Gm-Features: AVVi8CfiOZ9NY7tYRS9c58-NLdm4EjraYCDbUtRXE__tClgONQ-BJf3lNrzK4V4
Message-ID: <CACSVV00vFNZDCN24wSdffZFRWpijb53qbX_-3b09ny4noa7-Mw@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/msm/a6xx: Fix IRQ storm during msm_recovery test
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: AwE3-_huoSwCwcfm3L1sFHEAmgQjJGHK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAwMSBTYWx0ZWRfX9i7hK5cTEx/f
 ZOCeWS0kfc6KFJzy222siP0amWlN11DKnkTbZIogko4FYap49Z8u3iU4ZDY6fA0uhpmNEAauFOb
 XceF4MRNNtgj8b3cbbK0VHEelkxsubvZ8jm6IJQ1MML41eM4bCyfEBPzK5z7skufa3VAw3BtoB3
 pznPqbkxoXYbRFho29D7ZHgvTUk+uN6288iUjQVv0R3eNUQ7I2AzTSR97CgLKvzfdtzgyTyzC46
 drYRDsc1MUBVfhLxkNgPEpEVGyg9lWblt59Q0RQn08sDONDYlqjPg0FNMHpJBcoXf34jsHTvEGG
 VzVv30e3tMNlzmNHbznwhn/JvT9DSIgjhFF351bRCbmgQ79FhvsgXkIfF+6Gw0WeaYsGCWCcvTc
 O7CSJWYecfGoSG8/uDDdIqFMKDsgJo0X0YuJ7ws9cX0tQPDAiKoERyPuW0h/dpWcMJYDKU+6z0m
 /vpQNDIM0Q+DVcvWMBw==
X-Authority-Analysis: v=2.4 cv=XKAAjwhE c=1 sm=1 tr=0 ts=6a275c43 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=DJ3jTsrCUhykU9xOEzQA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: AwE3-_huoSwCwcfm3L1sFHEAmgQjJGHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090001
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

On Mon, Jun 8, 2026 at 2:55=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qualcomm=
.com> wrote:
>
> On 6/5/2026 12:20 PM, Rob Clark wrote:
> > On Thu, Jun 4, 2026 at 1:10=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qual=
comm.com> wrote:
> >>
> >> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> >>
> >> Once a hang is triggered by the msm_recovery test, the gpu error irq
> >> remains asserted and triggers an interrupt storm. In the worst case,
> >> this IRQ storm lands on the CPU core where the hangcheck timer is
> >> scheduled, blocking it from running. This eventually leads to CPU
> >> watchdog timeouts.
> >>
> >> To fix this, mask the gpu error irqs during msm_recovery test and
> >> enable them back during the recovery.
> >>
> >> Fixes: 5edf2750d998 ("drm/msm: Add debugfs to disable hw err handling"=
)
> >> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> >> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 5 +++++
> >>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++++-
> >>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 5 ++++-
> >>  drivers/gpu/drm/msm/msm_gpu.c         | 2 ++
> >>  4 files changed, 15 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/m=
sm/adreno/a5xx_gpu.c
> >> index 2c0bbac43c52..f1df2514c613 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> >> @@ -1275,6 +1275,11 @@ static irqreturn_t a5xx_irq(struct msm_gpu *gpu=
)
> >>                 status & ~A5XX_RBBM_INT_0_MASK_RBBM_AHB_ERROR);
> >>
> >>         if (priv->disable_err_irq) {
> >> +               /* Turn off interrupts to avoid interrupt storm */
> >> +               gpu_write(gpu, REG_A5XX_RBBM_INT_0_MASK,
> >> +                              A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS =
|
> >> +                              A5XX_RBBM_INT_0_MASK_CP_SW);
> >> +
> >>                 status &=3D A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
> >>                           A5XX_RBBM_INT_0_MASK_CP_SW;
> >>         }
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/m=
sm/adreno/a6xx_gpu.c
> >> index 8b3bb2fd433b..9a4f9d0e1780 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> @@ -1911,8 +1911,11 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu=
)
> >>
> >>         gpu_write(gpu, REG_A6XX_RBBM_INT_CLEAR_CMD, status);
> >>
> >> -       if (priv->disable_err_irq)
> >> +       if (priv->disable_err_irq) {
> >> +               /* Turn off interrupts to avoid interrupt storm */
> >> +               gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, A6XX_RBBM_INT=
_0_MASK_CP_CACHE_FLUSH_TS);
> >>                 status &=3D A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
> >> +       }
> >>
> >>         if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
> >>                 a6xx_fault_detect_irq(gpu);
> >> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/m=
sm/adreno/a8xx_gpu.c
> >> index 9e44fd1ae634..0f6fd35bd587 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> >> @@ -1211,8 +1211,11 @@ irqreturn_t a8xx_irq(struct msm_gpu *gpu)
> >>
> >>         gpu_write(gpu, REG_A8XX_RBBM_INT_CLEAR_CMD, status);
> >>
> >> -       if (priv->disable_err_irq)
> >> +       if (priv->disable_err_irq) {
> >> +               /* Turn off interrupts to avoid interrupt storm */
> >> +               gpu_write(gpu, REG_A8XX_RBBM_INT_0_MASK, A6XX_RBBM_INT=
_0_MASK_CP_CACHE_FLUSH_TS);
> >>                 status &=3D A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
> >> +       }
> >>
> >>         if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
> >>                 a8xx_fault_detect_irq(gpu);
> >> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_g=
pu.c
> >> index 9ac7740a87f0..48ac51f4119b 100644
> >> --- a/drivers/gpu/drm/msm/msm_gpu.c
> >> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> >> @@ -552,6 +552,8 @@ static void recover_worker(struct kthread_work *wo=
rk)
> >>                 msm_update_fence(ring->fctx, fence);
> >>         }
> >>
> >> +       priv->disable_err_irq =3D false;
> >
> > Ok, so we rely on recovery to re-enable the error irqs..  that is
> > probably ok, given the intended purpose of the debugfs file.  And,
> > well, it is debugfs.  But why do we clear disable_err_irq here?
>
> Now that we are updating the IRQ mask register which won't reset until
> there is a gpu suspend, its side effect will be felt even after
> userspace deasserts the debugfs knob, potentially into the next
> testcase. This is different from the older behavior. So, I felt it would
> be better to reset this flag during the recovery, considering
> msm_recovery is the only user of this knob, afaiu.

Hmm... maybe debugfs writes should just immediately update the irq
mask (if the gpu is powered)?

BR,
-R

> I should have explicitly called out this new behavior of disable_err_irq
> in the commit text, but I forgot.
>
> -Akhil.
>
> >
> > BR,
> > -R
> >
> >> +
> >>         gpu->funcs->recover(gpu);
> >>
> >>         /* retire completed submits, plus the one that hung: */
> >>
> >> --
> >> 2.51.0
> >>
>
