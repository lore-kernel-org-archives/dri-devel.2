Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945A9C44501
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 23:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47E110E4F2;
	Sun, 12 Jul 2026 23:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S3Q8MKfS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nnde6vt7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9978810E2A3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:37 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CNUbPY3944510
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7OH0dMJbAYsX/NxCZpvO87/XNimscPPU2oAe0uYMNYQ=; b=S3Q8MKfSlYue5KQy
 ySvNzmcjHKbff/VTAALKI/HxbTC2LlaR6vyYojV9x1OA7JLPnVKX9ryf4e2b6SKH
 HQJjVjXWMKpUqMOrWyQyMmaXoNsuUaMJ0f3o72IetjDRM5mmffB1EtVly+ZPiAKS
 Sqn5XZcnYuoD1TxGqY4dJmVfTnafqDYDitCe7dd8F7dc5bdjmqpj3CQ/aMoYxAwQ
 FTG4DCVzRHSevUwvbfoPzaOimgMHj/qyFp/nRnIC0YVO9p/y4KmZiJR7C5qBcM7F
 L6upAOmslnx6Bo+L3pd87i3uHWVh2FIy75YkOVFpZyghRQyhTSW9PJo2OQ7jy6D9
 o0cKgQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr3mkx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso52371651cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 16:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783899996; x=1784504796;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7OH0dMJbAYsX/NxCZpvO87/XNimscPPU2oAe0uYMNYQ=;
 b=Nnde6vt7+1vfjG1Xi9xBldU5zdDF4X3opn8hA/VxVsvvV/nS5jz8v4RjfncHHmIJ+i
 34KgOMe7v1x92YCk/0qtDluPu92m95YS1p5MiiA4ugvOGXpLZ6tI7hMK0IrIsrl/DXPp
 2FS8toRYXYMQ2KsgZQJKztmNlWNZdVpnOETF2iAwe0vQswj48gkJwI43/gjT8CkNpXjt
 Vcf/1QrGNfoQlJ3IDxSeoJfRP+893bXGBlJ6mcQA1X05bGnZu4bWBkbaVXLzEH4ht01K
 fIIG547asbKlBSKTUSx4X4iNDRXUDYMXhxLnZ73urtbjRZNOgj/kZC9jq+yITZL9/bSU
 +jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783899996; x=1784504796;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7OH0dMJbAYsX/NxCZpvO87/XNimscPPU2oAe0uYMNYQ=;
 b=ddg3IpkL7phMSTskvLJ1ojWYmjAhHFqoKTuf59Dc9CCZ5w1XzNvE+cGxXIrFFxBqgQ
 IaagfOoCmSVNzoEBvqfcE0+RgJqhLQlcNhABUHSrSC1rZ8IoH8fQGg+Egl+mm85CMDBo
 iu/99VKEYKZMoIMTQu7aiYG947cMI0KiW4/nqSne+akyVH+BkxF3JlOYpNAuslhIvEcU
 bHaLe38zV5KEIP+w2csbsBChsaEqg1avLfnddhWjEeDAHNa/S9qzw23wDcFDfNT2o+j/
 WAb/uOm8RLPFsr2lBDE8V/BvOts83ryQsnoTFa8VWlaBMRpXt+YzdAnCtSVbDKRNkrj/
 hi9A==
X-Gm-Message-State: AOJu0YwExPoE6mh52R2GL6KV0Y0p07IGS8gAvVIkZ5zh/5eRKq8vPlK5
 eTYC4A4Mbdir4JsznhzRRd5XRJy297ClDQYnWBHE/bYQMK1GzzvIHUpAbGNqtEchcU/oxtweM9e
 mFiOGdFId9nJp3J5zGbNw/a+KoK21vKhlbfldVFKiHIUTfncAkM9E3QaRqqU4HJHwgtOGz6I=
X-Gm-Gg: AfdE7ckvMPwZneqsF14rxpAK1B2rr+zuvVX20ctWvIiHepDz8yNpSA911q3GWm734pH
 xF+q1zBu4PSsB6OWZxTAO6YSefx5Rn6Tj1CExbISlN8Ps1SrbC7VuRSVQnk7p3CUKAt3V9Ebf/3
 og2IYQNOk71kvh2u9ZsmF4H0+wHJ/KnT1ZoHx1oHuQBatVMXain+6Gpt504gz9ootM9zUUuGelm
 tC5laD8UKvHEoSK2ZHkEA9Xv9vItCgvF7IZWWs/ollC+sELyxDcNk8jlwwEnoqsITxSAyj3AoL7
 6l909I+152iJj9PSQxyqoXIQxxvk1XSY5c6pKR2O6SbT6sjo8VWaCtlizonpOGvpqqPJEttHNLW
 p/5Gkb557kp/RP/nhE35wVylwIsw9SqIp6UM2W3aTmgZh4Z4FbSSMDSCz5sRyPekfn8pI/CPXHP
 2JuVV75TJMpyAsh4veEjX6k4hu
X-Received: by 2002:ac8:5a51:0:b0:517:96f0:5658 with SMTP id
 d75a77b69052e-51cbf0ab5admr69702871cf.14.1783899996053; 
 Sun, 12 Jul 2026 16:46:36 -0700 (PDT)
X-Received: by 2002:ac8:5a51:0:b0:517:96f0:5658 with SMTP id
 d75a77b69052e-51cbf0ab5admr69702731cf.14.1783899995542; 
 Sun, 12 Jul 2026 16:46:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01ca54e25sm2368093e87.30.2026.07.12.16.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 16:46:33 -0700 (PDT)
Date: Mon, 13 Jul 2026 02:46:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "open list:DRM DRIVER for Qualcomm display hardware"
 <linux-arm-msm@vger.kernel.org>, 
 "open list:DRM DRIVER for Qualcomm display hardware"
 <freedreno@lists.freedesktop.org>, 
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/dpu: fix parameter name in
 dpu_core_perf_adjusted_mode_clk kernel-doc
Message-ID: <hzu2yj4b7xgedp7kf7zadg6wd5okkjsxjxwevy5m7asatghe45@ehyf3qffb5u4>
References: <20260530201342.10538-1-rosenp@gmail.com>
 <u5ozkmhq3ll4pfhvxl63ezf5dtgz25lvrwmpk6u7ofccnjicw7@skim2jft2cyp>
 <CAKxU2N9tizK6xbzscbeLHs4noLj5X1Dk8SRog5yHkLnkFBW0zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9tizK6xbzscbeLHs4noLj5X1Dk8SRog5yHkLnkFBW0zA@mail.gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfXyzye02Qh/iXP
 8G0PdkOe3DQ7rxrU3YGqndMlqfqgiFddChb4dHSiof6UcNvez/babfPjkH394xzYiCoAL+3i0q7
 pPuaEZS/l5ve+65/lrF5smuX4U1f5rs=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a54275d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=6b2mnDnH5lO7q6rXjrcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: SS9Bl8RjJeKsjFOHUa5mkvOvHKGgtz_c
X-Proofpoint-ORIG-GUID: SS9Bl8RjJeKsjFOHUa5mkvOvHKGgtz_c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfX+J5U+AufCu4E
 DwsUuvz2TFkaK4M8SbgmnJPtlTxEThvwqK1lGlNBGGPMq3lqhsDeqKYi/vOduORsiydydEBWvX7
 IuOKerrk0oD6YneHewj7SqrTo6YednnHSo4R+gJ+5/c/lLlCBZCQbkKEjIoJY3+RHol58ATGNqz
 ia62cwqpN94/Ki1t2cUuRb9u3h14at7La8haqrHENHi0B5Ce/WbkjD7v/udN72IcWQgj4aVUc6f
 6t+iAX/Sm8Yh76HkyMT80qmnljZO3f2yUn77Mfr7oW1icvYPdFkn0j6t+DuD+Xh0tcZsx0B2qLa
 VeJc912HE39gqwHJrPm6AmWTKx6OWPK1kw26WrYu3220Lflqje0mU7SxI9jpIRht3lxDDAeUVD2
 o5ZHa2tw0Ddztw2nn4rnoSJr9XdxGdgFy6fkme0t5WNSaeDxJpRHVhT9r8I9LUjem0qi+lghJ7c
 C3zrDGVU6HXt8LGvODQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120257
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

On Sun, Jul 12, 2026 at 12:19:59PM -0700, Rosen Penev wrote:
> On Sun, Jul 12, 2026 at 2:37 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Sat, May 30, 2026 at 01:13:42PM -0700, Rosen Penev wrote:
> > > The kernel-doc referred to @crtc_clk_rate but the actual parameter is @mode_clk_rate.
> > >
> > > Assisted-by: Opencode:Big-pickle
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Fixes: 62b7d6835288 ("drm/msm/dpu: Filter modes based on adjusted mode clock")
> Is a v2 needed?

No

> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
