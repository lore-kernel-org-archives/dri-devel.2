Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CBBCD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8532F10E3DB;
	Tue,  9 Jun 2026 14:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DKksWpRE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C4i/rjA1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA3610E408
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 14:25:48 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659ClKWY652176
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 14:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=71usq3gq9cQd20fa0B4ebJpRi6XgL/ygSODcBJ05MzM=; b=DK
 ksWpRER/65TvGrHF3rlGHwzKvIuDSSLx/mG597yof91G1+dfUrTixwDzyoqgWd9M
 9bbNN4D+erDTUKzkbyfASWo0uCm+9aiLucefczklDjcE+FQoq3jcSq1XEl2IdrKH
 ye3De7hcd3xWmLgsA7eRvIj2nbHrVzfKfk8hjN2d0OHmBfUT8j6CL0CAynl4ysSz
 hqM9oM1xUBT2YuclYOPvk25OuNEtJJiudbV4HX46vWpicmL5Q+P0X13FfT6gFfK0
 HojplJ8YHo5CHe7Ju6EWstsB8HRmqtSOirqf5wGoZoEbBsgQ/s0JAE9of5qhHP9P
 MNGdpONz0JLUkBSQvXtQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0sspyf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 14:25:47 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e60737a964so10805858a34.3
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 07:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015147; cv=none;
 d=google.com; s=arc-20240605;
 b=j8fXvwPqpa47uVwHWP6kD2DWTjH7m+uHWo8H+Luzisw8r+sNeRA6ETkb6SHgqLVszN
 bhVMcXbAXvinmSc4En0eE4CAxFCLAUOXfjwMYxg3YkUkg5Rn0Cg2fREh9aXE5DJt6e1m
 FCLeZ9+MyyC2Pxm751r01wpRo/a01GS2t2Zi6VwmY9ioGNT/3hGgSjeXStwABjV2Lcr+
 QcohuAwiHxA9zmYpbfneSMVqK02RYDa0ipAxNabEaCHIzPsdQRiVQRFnN8i+QFpcBjlD
 Mdxj3wr1UrZG+yw2Vvi47zdIkip/U11/GU5RIrsYwtwuSEIfTAiReVl97QyZW31GHw4Q
 dJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=71usq3gq9cQd20fa0B4ebJpRi6XgL/ygSODcBJ05MzM=;
 fh=bL52AfjuEoAvsjZtoO7sIIfuUiyKOJcMEyebwI9MYgI=;
 b=K9k6nKRANv1AaIxtUrTkRcItZehpvw91LLwj7Z/fuxTgmgtFSXJdI8syI3Tbn4sRsh
 AKxBIiGBVOA9UyVb5jlT4PGx8R8teYhIUp+N9e1QXWroquavFNQT7SmY/uLCEkFSx11s
 dwBbfCV5rJ61JdC9TtlDYaJKJmmR4MKSCh3h8x4+uyerD9ALk23zMV0nDSQC/J1+MZ1R
 0gfxmU3XGHXQNRpnS2wYjPhYH0GM+xxgl1BXelDA620Y6IBkN0uaBTSeGgknuQNyiz1H
 XkEIo1/hZ5fJvCVvjQluwE47HdEoLsqtld0QplepLfLgBb4Q465vgsYeCfvvHQBUkGdt
 6Egw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781015147; x=1781619947;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=71usq3gq9cQd20fa0B4ebJpRi6XgL/ygSODcBJ05MzM=;
 b=C4i/rjA15sO9/DSJGS35ySscbQklUQrWIVgn7Khwy0ZgC8CxnBmhzqiwaF0CVRQ9ID
 5y5GJNZfwHjSHWd7+YQBwaD0DoTO9Fmogpq4V4HalI4Rho1s9cqsTJuI3Y6Ddqt3zMdw
 f/fJAoQNTYMiKggYPsAlQ4EaYuSNCjv1Ciz3eI0A95BFqlkvqYQ+uHM6TB5I4YYNDyAP
 rKnqMEfPlC7DzqcJn0Mytrd5bPfdzK5DrRTbBuNXaYT1lNoYcqIM+x14kx6D4bH+ly8N
 ukRLrYKfASaBRx8UP0m+bj3Gsgr30RUUkwArlIQRu4/K2VFqVGvqbS8haturihzo4ncA
 t0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015147; x=1781619947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=71usq3gq9cQd20fa0B4ebJpRi6XgL/ygSODcBJ05MzM=;
 b=QDimtgwZRiBc9sRrUfom9FTMQ3FUZvfeb6OWfazJEIsPY/NHzz4o1PfxFEeztcSgXx
 rs4tpipNT4NMoO6+lbtHC2rkRXjK0v3m5yDR4XIjRi9GNLx6vHFx5QSU6gpjgJV4UMwe
 AgpiVQ8X2OLCeD8H0JmkfqFxtg+hWMwXRoZuqFA3trK1mM1fseCiTwiMtFz75rdfUutf
 q8fj9ygJ0n3B1dmE0s1fVRzjHPG9YyrVnSQOIIex0ciFM2Gl04jiIV7PP3IWn29km9TQ
 aXcUT8KPz66+c2+9xJ9W3KCD6ZbZp1WBVdBqtULidRrrIB37132oQuLXvWFUgQKmRLAT
 buNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+Zn1uBP7hkokdWEYnJMIq+mE3qFTZ+iZ5/48cvrWlrk1cJ0LQt25XxIfqmMoKzor0TzVdJFOmgpw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6HkhVjehwMJ3yipdC92gV5tKlTlFNYeClaGeKl0YooqDN2oU4
 YIMcqw4h4Ub8jMqvdlzwmzxpDTk/k9VxzFz5+eE/Ql28tamq2VRL6V1PahmzitpXBX5fiCZjI+t
 EAbmfGCUrDBazNt137mrGF16O+oJP/TpQUeS6qGviSJ7ldXcXRblEunucT3xHUsm/5B9hw4uchB
 9ySNzE+gN0oQKpy9jXDVCSHauSB4C3qRRBEWFarIU6u+7HXA==
X-Gm-Gg: Acq92OFfMgblQqJJDvkGeBoILJlTZ5RqffvkUXyZKUQzG/aoMwFbxSlfTsrF26mYMmD
 8rWzA4uFwP8JZ27p3w4usoMLy8XZFwVw346BDVbLhaNJVoO4Oo4DrAu/ozT/J23z0MaUaicLTNs
 V/2ZBTD/pgtEQg7F+hzbvQ88hsyHzpAi2Ij6zWC4/xjbPmTaJUheYVgENjqYJtYjJ9LceCQNHBK
 RMjuXu/Bn2zTuhAbY+/0effLJFygtAyos9BuHwy3ab3/MPG
X-Received: by 2002:a05:6830:4995:b0:7dc:c338:d23d with SMTP id
 46e09a7af769-7e70c9f3c8bmr14276674a34.14.1781015147099; 
 Tue, 09 Jun 2026 07:25:47 -0700 (PDT)
X-Received: by 2002:a05:6830:4995:b0:7dc:c338:d23d with SMTP id
 46e09a7af769-7e70c9f3c8bmr14276638a34.14.1781015146571; Tue, 09 Jun 2026
 07:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
 <20260605-assorted-fixes-june-v1-5-2caa04f7287c@oss.qualcomm.com>
 <CACSVV01dbQcjE+nTic+9R4VfCtNGvpwODH8BMZi8B7LFtcCCfQ@mail.gmail.com>
 <49b8530f-24d3-4201-b22c-0f8eaea9f4e0@oss.qualcomm.com>
 <CACSVV00vFNZDCN24wSdffZFRWpijb53qbX_-3b09ny4noa7-Mw@mail.gmail.com>
 <d153235f-ffec-4fee-87b2-6008f26d7014@oss.qualcomm.com>
In-Reply-To: <d153235f-ffec-4fee-87b2-6008f26d7014@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 07:25:35 -0700
X-Gm-Features: AVVi8CfIb0biAtmV6jQ1d_iFduyokQv33M85_Lef8QpAnVhMcGBgRaq9DvmuxOo
Message-ID: <CACSVV02_Yh21Ld5NX6Z6iaG0sfTGseOD5S9X_avSC=7RAfNt6w@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzNyBTYWx0ZWRfX6gASyAD3AnMV
 8oGIJJ7ZtoOAfQpHkarI8CrtZWRCWI+4/3642kA2VmlTY2MWymFnqh5njH04N2VA39gRW6YwZzN
 Zlyr4QqYM1DcIZjdzzSMkqbzlmrNsb2dF4OumKS7rJGiQC9wt7qxeFT/eCOHGr7R9DbyUaqohyU
 TBpoCyapk5VXGXftDognrXx0pzHi/KWdh1AepD14DbKQrm9180AFY79FSs/ixs03iB31ohb34iS
 N5rq8tzXkbROiUyymq3btt8+MwjomlujmxBBInmCf+hMQHnjBm3/6iLNpnnMNDnKFjqCs1JDPFL
 1AXFd511Hvlj9at+WbflOn7HUmEA2n43yZxbe+JCpbr0Ey2ooPznZPBVZczSgO7pAwIVy96Ma7x
 pU7MBkTGHRD98f4OWnupL6UeD0uSSbDKpNZimi2dwFCCbNllc0r0rEkOqSq6wXMf3GtF/HuV6Rq
 9sNZon8McquFvsTvBQQ==
X-Proofpoint-ORIG-GUID: pD0xb_LurggrW5PNiA2Z9ov9FbJ4YpGd
X-Proofpoint-GUID: pD0xb_LurggrW5PNiA2Z9ov9FbJ4YpGd
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a28226b cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=AGxqfbsocd9TTLaiNUcA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090137
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

On Tue, Jun 9, 2026 at 6:09=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcomm=
.com> wrote:
>
> On 6/9/2026 5:50 AM, Rob Clark wrote:
> > On Mon, Jun 8, 2026 at 2:55=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qual=
comm.com> wrote:
> >>
> >> On 6/5/2026 12:20 PM, Rob Clark wrote:
> >>> On Thu, Jun 4, 2026 at 1:10=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qu=
alcomm.com> wrote:
> >>>>
> >>>> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> >>>>
> >>>> Once a hang is triggered by the msm_recovery test, the gpu error irq
> >>>> remains asserted and triggers an interrupt storm. In the worst case,
> >>>> this IRQ storm lands on the CPU core where the hangcheck timer is
> >>>> scheduled, blocking it from running. This eventually leads to CPU
> >>>> watchdog timeouts.
> >>>>
> >>>> To fix this, mask the gpu error irqs during msm_recovery test and
> >>>> enable them back during the recovery.
> >>>>
> >>>> Fixes: 5edf2750d998 ("drm/msm: Add debugfs to disable hw err handlin=
g")
> >>>> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> >>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >>>> ---
> >>>>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 5 +++++
> >>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++++-
> >>>>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 5 ++++-
> >>>>  drivers/gpu/drm/msm/msm_gpu.c         | 2 ++
> >>>>  4 files changed, 15 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm=
/msm/adreno/a5xx_gpu.c
> >>>> index 2c0bbac43c52..f1df2514c613 100644
> >>>> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> >>>> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> >>>> @@ -1275,6 +1275,11 @@ static irqreturn_t a5xx_irq(struct msm_gpu *g=
pu)
> >>>>                 status & ~A5XX_RBBM_INT_0_MASK_RBBM_AHB_ERROR);
> >>>>
> >>>>         if (priv->disable_err_irq) {
> >>>> +               /* Turn off interrupts to avoid interrupt storm */
> >>>> +               gpu_write(gpu, REG_A5XX_RBBM_INT_0_MASK,
> >>>> +                              A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_T=
S |
> >>>> +                              A5XX_RBBM_INT_0_MASK_CP_SW);
> >>>> +
> >>>>                 status &=3D A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
> >>>>                           A5XX_RBBM_INT_0_MASK_CP_SW;
> >>>>         }
> >>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm=
/msm/adreno/a6xx_gpu.c
> >>>> index 8b3bb2fd433b..9a4f9d0e1780 100644
> >>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>>> @@ -1911,8 +1911,11 @@ static irqreturn_t a6xx_irq(struct msm_gpu *g=
pu)
> >>>>
> >>>>         gpu_write(gpu, REG_A6XX_RBBM_INT_CLEAR_CMD, status);
> >>>>
> >>>> -       if (priv->disable_err_irq)
> >>>> +       if (priv->disable_err_irq) {
> >>>> +               /* Turn off interrupts to avoid interrupt storm */
> >>>> +               gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, A6XX_RBBM_I=
NT_0_MASK_CP_CACHE_FLUSH_TS);
> >>>>                 status &=3D A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
> >>>> +       }
> >>>>
> >>>>         if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
> >>>>                 a6xx_fault_detect_irq(gpu);
> >>>> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm=
/msm/adreno/a8xx_gpu.c
> >>>> index 9e44fd1ae634..0f6fd35bd587 100644
> >>>> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> >>>> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> >>>> @@ -1211,8 +1211,11 @@ irqreturn_t a8xx_irq(struct msm_gpu *gpu)
> >>>>
> >>>>         gpu_write(gpu, REG_A8XX_RBBM_INT_CLEAR_CMD, status);
> >>>>
> >>>> -       if (priv->disable_err_irq)
> >>>> +       if (priv->disable_err_irq) {
> >>>> +               /* Turn off interrupts to avoid interrupt storm */
> >>>> +               gpu_write(gpu, REG_A8XX_RBBM_INT_0_MASK, A6XX_RBBM_I=
NT_0_MASK_CP_CACHE_FLUSH_TS);
> >>>>                 status &=3D A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
> >>>> +       }
> >>>>
> >>>>         if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
> >>>>                 a8xx_fault_detect_irq(gpu);
> >>>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm=
_gpu.c
> >>>> index 9ac7740a87f0..48ac51f4119b 100644
> >>>> --- a/drivers/gpu/drm/msm/msm_gpu.c
> >>>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> >>>> @@ -552,6 +552,8 @@ static void recover_worker(struct kthread_work *=
work)
> >>>>                 msm_update_fence(ring->fctx, fence);
> >>>>         }
> >>>>
> >>>> +       priv->disable_err_irq =3D false;
> >>>
> >>> Ok, so we rely on recovery to re-enable the error irqs..  that is
> >>> probably ok, given the intended purpose of the debugfs file.  And,
> >>> well, it is debugfs.  But why do we clear disable_err_irq here?
> >>
> >> Now that we are updating the IRQ mask register which won't reset until
> >> there is a gpu suspend, its side effect will be felt even after
> >> userspace deasserts the debugfs knob, potentially into the next
> >> testcase. This is different from the older behavior. So, I felt it wou=
ld
> >> be better to reset this flag during the recovery, considering
> >> msm_recovery is the only user of this knob, afaiu.
> >
> > Hmm... maybe debugfs writes should just immediately update the irq
> > mask (if the gpu is powered)?
>
> That needs some plumbing in adreno func table to program the register.
> We can do that if you prefer that, but is it an overkill for this usecase=
?

Yeah, that is why I didn't suggest it earlier.  But stealth re-enable
of err irqs makes the behavior harder to reason about, which I
dislike.  I guess it works now because msm_recovery only does a single
hang-test w/ hw error irq's disabled.  But from userspace PoV it seems
natural to expect error irq's to remain disabled until writing debugfs
again.

Since it is about debugfs and a single igt test, maybe it is just best
to document that this is how it works.

Or, would it be reasonable just to update the irq mask in gpu->submit()?

BR,
-R


> -Akhil
>
> >
> > BR,
> > -R
> >
> >> I should have explicitly called out this new behavior of disable_err_i=
rq
> >> in the commit text, but I forgot.
> >>
> >> -Akhil.
> >>
> >>>
> >>> BR,
> >>> -R
> >>>
> >>>> +
> >>>>         gpu->funcs->recover(gpu);
> >>>>
> >>>>         /* retire completed submits, plus the one that hung: */
> >>>>
> >>>> --
> >>>> 2.51.0
> >>>>
> >>
>
