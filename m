Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2764AFF513B
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE2310E4C5;
	Tue,  7 Apr 2026 20:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kKn6CQ3A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z1CIuLga";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0972610E4BA
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 20:40:33 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637J73kH263342
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 20:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=eDdQtZi4zIkOM6jZvBLzWLb6JDx+ro8vaCLvZnKD8FQ=; b=kK
 n6CQ3AW6Ye+/nsztC3ZZY36LtC2mjE82Odd6oO/Ixmx4WkolnXEQtuQA6gPfD/ZL
 pLGqIrTlK8IYXLjQuJLwUwibFhz8UvLUPoydv7a7dzun65MgRaJ3Sz62r8d2Jr5+
 jr5IN8uM6hU0Cy/++dOMM5BylY7SAZuSiCPVFd2aTncj+UXutpu7inhkmGwTSk7J
 QdItnnBbiiPEDFyMVLtcL3cyuH8pPb4CaTEeHQqCJWbRoEbAUyLwzuiK52Kb5aaQ
 H82Z44K8RNkYZdLZ8xHmEn33t/VrUNIS7V81zM8ZPS6YZITTsvkjWE1MVPVARAwf
 IH9Wk1TGQOm0Ufg8vavA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7t208qb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 20:40:32 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-46f85ce99f8so2777253b6e.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 13:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775594432; cv=none;
 d=google.com; s=arc-20240605;
 b=AgzfiA0+HUSdRKZTl2TpLQim1+YCkuVKB7thKe9I4R3MKIi6EuqhiW1lFXibJ7Fsph
 hjySWxtO8eZrjWc9hR41J3kR6lfRl9p3KWAMO+WrVifbH52m6f0dcwQwtmFBn60SsOIC
 U4bTnV7WFS9/WIE2qnDbRmqcQdBqz7fW8Mh/uvwt+YuOvItvsWcY1L6xVsUF4VGV5Pgo
 TVShJO1dUrE7Vn58P+4Clvej0QmBw1EluGfGlW0gPDSgNdGhumGEJdsMyvPTYSrNJjVt
 xtmi0OlqhozLAQhdw1uWakgSymGbT71rri4M3sVrP3ICOqMbhyBTmpvVGDiYg6Jsacjj
 tgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=eDdQtZi4zIkOM6jZvBLzWLb6JDx+ro8vaCLvZnKD8FQ=;
 fh=DmH6yNLPFH47IrAo50AiEGiBNFMlYydTVz0aPo6ZTzE=;
 b=BbuTJtlrt0lfp4Pa2AdtUpKZD/Vh3oMUrSz8phzqukmGc0GB1wPZQCQvuXWGVSjXFv
 FjN+Uw4Kh2VVqKLi7AUfGVl5kSlXMqWfx/Voz4grCaj4qU7a2n4Mn9UlV9lmRNJQQCrX
 sykwQeCeoyu8H9IyXc+HvR3SxSUntg3GvOv+lZezFElAT7l+fZJLlBRiCuOTCITC/zuz
 SdEtQsNM4S1KlCsbKFgDnceR532xcn9xong6o91Dv3rtby6yoiy3UqO7khveDCNEiL/a
 oLnyJw8JptxJ7ZHKyekczYMFPkukO1fzSdeampPGIjV0FwTWujk4kX4Fi4eVDGfqE8EE
 QPXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775594432; x=1776199232;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eDdQtZi4zIkOM6jZvBLzWLb6JDx+ro8vaCLvZnKD8FQ=;
 b=Z1CIuLgaNNxBa9SjTD6UuR3Mhr88afFMwyQK6ct1xLtMGjT40FQNPAKi0NTk351Wgk
 l2Oy89pt3qSeDs4eDPCXZTgJ4hs6rXT3CLK4fpyUo/4EH470HLBGDCI2Vcg4b5ZiwY3G
 OIPrxVx2GLCoM5GRPSxwAfkFGg/I2sGDXDZeYOWpvK6WbfFZaEgQNaDk/Np0EGqiMMP2
 TFvOEUdaHGPj5uhjSqB+X1IAfROFxvQDzcGFibmKESWNah/AjaOXatkXI7UNvMDmGgFT
 tTRwPrCVvSacIMP/+6HaQ5msfycdItt5s8dluozmcBjXVQs3aVVh3LYWvi+tOzGoYwv6
 2HLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775594432; x=1776199232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eDdQtZi4zIkOM6jZvBLzWLb6JDx+ro8vaCLvZnKD8FQ=;
 b=FvNRujeGzteZyMWR4IyXXi4Ee6d2KVKGA9iJntKIUmNUWrz+UXEGBOhwXg5HKqYnr3
 tcN1PN+mkj1cwY5IlMsnXRSTTJaQmjIRgHRjFy4Lv0kVHvY/Zjuod4N5gmHN0Q+JX7Jx
 20GJ+LQg4odee983TSgb87alZRBlRB8zoaraDQgbYguV2jKQmAqpUSbJMa6Gvqw27cm6
 SBzO0Lz8dFAigykpeMMvRP5FOF9K15N9mPMWWdYMRQOKNtn3J0POrc9UlJeA6Rk6o/uv
 scFdudGzWq4bXG3MonNHZ7WG2JEFpG+oEExFiYMNm3JiluQaLz8yeA0bQszdYliVR7sz
 TvLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/LGt7B+HNXTZLcPuvJZAkQ8o6vANRzEQHTR+ZxEYKyYEdKoMQKph87/c6kP9arUnic3nE0uFalzg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3sXPGn4UnurjSSS6lHFpYoihgVvcGv5eHcdDRLn0c5Hq0T8wN
 U/bwpUE6r9Fz+B+iRRx+OWanZOGKmLtGLmAr3hVxUwvZbAJH0J+MoIYe5XsSVzHRsiP/uF9NwrZ
 LKGLutW7HpzzrxrBgTQb4rrIUOUAj9b98G/0DNInjTiVWa6m+ym8LtokQ4pVSqTP7NxJGb1GJMz
 o1CtuAqFN2VOnC0kh92MhyefdBlh3VrU+cdrAFgkoWoHyB1Q==
X-Gm-Gg: AeBDieswAXvmTkUDWNgoj/E1PFH9uZdtfO/jHaVwRlQdPqqse0zp+yvHo02LIa3vBOs
 m+4YOJw7wIKCsjD41gPohCs4aJkSI2b+YsLokMITQvi5hK6DBCaXcUqKYi8AjisCuk60NwAOW98
 iG1IAv8484OWvozf5eX617cn5jLGu3Bf5z+fZYzsUeGLqHl897j80ob1xY6dwXq+Wl4tUnFMjRI
 Eu2TB72YxSLZLzJgJWy3JbUI0HVm0MmFD3efw==
X-Received: by 2002:a05:6808:c1d7:b0:450:b361:f48f with SMTP id
 5614622812f47-46ef55faa17mr9955300b6e.5.1775594431746; 
 Tue, 07 Apr 2026 13:40:31 -0700 (PDT)
X-Received: by 2002:a05:6808:c1d7:b0:450:b361:f48f with SMTP id
 5614622812f47-46ef55faa17mr9955266b6e.5.1775594431249; Tue, 07 Apr 2026
 13:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260407-adreno-fix-ubwc-v2-1-7ff73624635e@oss.qualcomm.com>
 <d56c1af1-af46-44f9-a048-2b3f22529307@oss.qualcomm.com>
In-Reply-To: <d56c1af1-af46-44f9-a048-2b3f22529307@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 13:40:20 -0700
X-Gm-Features: AQROBzBnWlyD55m71MFh5m55BMthxQsSiClL1SKz4CrVhTWkfURZGhxdGQ3tXgE
Message-ID: <CACSVV026TjQTNUhxHxavgS8YH0vS68RGe+--zQCLrwndeOfXMA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/adreno: fix userspace-triggered crash on
 a2xx-a4xx
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=De0nbPtW c=1 sm=1 tr=0 ts=69d56bc0 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=YoPDWM_fg-As0N3Yj50A:9 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4NyBTYWx0ZWRfX0esv2KS2VM7m
 e+/x1ZOmtgXoHp3df7zt5OXLwaZREC2oGHJ5o0oVo2D6R5y0c3Ig/NHOWbinB2V+OE4BSmDC0mM
 T6mYSmiej4/pn/xdPqh2VyP0AsAoGO/SxCdWUYRQjzj8Tle3K3uzkvyTYekFmlK/foFbcBcwJ4q
 U3DBjVBtNqdBEEYIg3qT/Nt25HIKkO4wPql8Sj+oksC2ta7ZLY+67FxpkD7L9qzXBjpzYbjpae4
 6xPQ8CvenYQ7ctNbMxQIdAqAP+Fg+5MuuopAn6kSOyZDHRBcggQEJFsGRYq29xGbh0tjQ78j5G5
 NY9CO5rKlGTQmjdcG4iQHOufw4Z/FSTEP2AfEBYibNwVrbk88aTN+HtPspmFZ54KgxxCrsKCsAG
 1eMQ6V8X2RztZMZoVfXzGEpY8ewMP56HeONq1BmqtQrozv748FvsHDN/uHlvkppI2XlAa/3Ws/Y
 hqxBHTS3fK0AwZ/DzHg==
X-Proofpoint-ORIG-GUID: ysFfYQzpUhEzk_sA8WOk3GOWaUk78mTZ
X-Proofpoint-GUID: ysFfYQzpUhEzk_sA8WOk3GOWaUk78mTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070187
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

On Tue, Apr 7, 2026 at 12:17=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> On 4/7/2026 8:53 AM, Dmitry Baryshkov wrote:
> > Before a5xx Adreno driver will not try fetching UBWC params (because
> > those generations didn't support UBWC anyway), however it's still
> > possible to query UBWC-related params from the userspace, triggering
> > possible NULL pointer dereference. Check for UBWC config in
> > adreno_get_param() and return sane defaults if there is none.
> >
> > Fixes: a452510aad53 ("drm/msm/adreno: Switch to the common UBWC config =
struct")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>
> -Akhil
>
> > ---
> > Changes in v2:
> > - Changed adreno_get_param() return -ENOENT for affected params (Rob)
> > - Link to v1: https://patch.msgid.link/20260407-adreno-fix-ubwc-v1-1-bb=
2b09450b87@oss.qualcomm.com
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/=
msm/adreno/adreno_gpu.c
> > index d5fe6f6f0dec..34e4ab43b0f6 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -426,15 +426,21 @@ int adreno_get_param(struct msm_gpu *gpu, struct =
msm_context *ctx,
> >               *value =3D vm->mm_range;
> >               return 0;
> >       case MSM_PARAM_HIGHEST_BANK_BIT:
> > +             if (!adreno_gpu->ubwc_config)
> > +                     return -ENOENT;

maybe use:

    return UERR(ENOENT, dev, "no ubwc")

?

I've been trying to add UERR() to things to make it easier to debug
from userspace why the kernel returns various errors.

Otherwise, lgtm

BR,
-R

> >               *value =3D adreno_gpu->ubwc_config->highest_bank_bit;
> >               return 0;
> >       case MSM_PARAM_RAYTRACING:
> >               *value =3D adreno_gpu->has_ray_tracing;
> >               return 0;
> >       case MSM_PARAM_UBWC_SWIZZLE:
> > +             if (!adreno_gpu->ubwc_config)
> > +                     return -ENOENT;
> >               *value =3D adreno_gpu->ubwc_config->ubwc_swizzle;
> >               return 0;
> >       case MSM_PARAM_MACROTILE_MODE:
> > +             if (!adreno_gpu->ubwc_config)
> > +                     return -ENOENT;
> >               *value =3D adreno_gpu->ubwc_config->macrotile_mode;
> >               return 0;
> >       case MSM_PARAM_UCHE_TRAP_BASE:
> >
> > ---
> > base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
> > change-id: 20260407-adreno-fix-ubwc-6a2564710e21
> >
> > Best regards,
> > --
> > With best wishes
> > Dmitry
> >
>
