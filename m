Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654C2CA5FC4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F0310E0EF;
	Thu,  1 Oct 2026 01:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BFybK985";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TiuQgrHy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A5410E02A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 01:53:53 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910jbXF1141511
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 01:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ELY0MAexpJN5nAc7xQCugLeq
 mITlBQ49lgtYS6jx4WU=; b=BFybK985dnk2qMD2cqvw8uheP/PpAJzPE4KcvHIN
 9sXb3AE9HlVjsOpelNmfJWqhNtNE9lJ6unrSjlnqxB9z20yDLnnSBTaBbtdl/R7i
 h6BQIcnp/BSzHRt+a+SspPu9djzfRurnd/tch7qrDnNqt337Gc1+RStcUPIqTycG
 QhyAXvR0dplXjQiR3efluOVvIzK3qWh2h1D3QBYIxFt9gkaDqbChUymRaQBh+6R2
 mTgQXTH31LbdAKSi2dRu7NLQ7hC6GOir9xZGazg5SVWQYV5kAjAx3Sk5JAFFqunS
 racw7j9O811KmOyrB7ZdOatf7mJqYtnSRbuWY525WMMa9g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh58jhr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 01:53:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5ab5c136so813868985a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790819632; x=1791424432;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ELY0MAexpJN5nAc7xQCugLeqmITlBQ49lgtYS6jx4WU=;
 b=TiuQgrHyvN7suZ3MtokB0cSftdx/0+PAtSkOPlGptreDamsFqHTkID+B1EeVHLf33i
 KVrir66M/dw2SAhtrwVI513d0cYuL38utk0NHdVJ0KWNd6wtD/7PEYLqgRoydtiGiu6T
 9yTEZycY4azwFtEUtsLbvwaVzbd8USJWnCH83e9XxEofPHF9p/sDrR5MEQ0d5fPweWjv
 dBvVX/2oiX+nWtA3NjqpMajWH6UDIuSflntZyOdW3kw9JLwFF6hr3mSleNLrRw1iNqz2
 5mqVXN3/pXmhXPICj4gboH8aSDyTMQrWD2m9v71dPUChxZEGEec0cwPV/JM1um+4nGKK
 LGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790819632; x=1791424432;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ELY0MAexpJN5nAc7xQCugLeqmITlBQ49lgtYS6jx4WU=;
 b=KeZZxa6EHL5mF32WHcOI8m3jvGiisJ7dgmlQ573zFKJ+sgFOBbyRyuN4AKSg8V5wnU
 /A7zdJ/t7SkgyAeSaYkZbrutWI2QRZ2f+XnWUAZ8iX4N7FPRTvYfwZuWgP9ITT7rRb+S
 4049GR0P5GGYfbLrvQKDw9x3Wo6/J6uht3gbrXysVdAZOFTYwgGmrMjqlRkDfLPbUJnW
 AhRi4jJyM9nWJck65TB+/wl812bQEMWvEQxYiLFkoPRvgxEX0+y5kPv5yWcVT4c2vlqf
 PIQkLtYjsISY2/snrozhuSM0W9RN5kcaJhFZCxK0PuC1VgYWxBM6V1Im0J+Xhf4Fn2UG
 u+jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9u9VdGqlyyhmHhPHKLNYif0Tv95MNZu/JHGHqSY/NQh/YVDLIMxDDttqTtG3Bl9lGdD3BCVYatCQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lJwkQkCSuxq6160pRtW3IGNo0xJu/UH00V44QPPmiRInfMPzm2
 Ak8uJJjWd/xVeEGnc5d6u5B7Zy/nxlDhRIz5X30cuhh2EXvxKhm7b1ld41aJmP49w1qbe8mwhch
 bXkRCEyCvf1RaYaP5NK4NsLucwAsG06cd7Lu9SSrJoI2oW7AkVjn8GoR6JityznZK7015co4=
X-Gm-Gg: AYBFou24nboZm9bHyR1497r7KYcmPrkbzysJHShYUHUdDWbbMZUNXVBXWb1KmQOSpUz
 1oqJpAedGVZP3tKqlq6Af64pdzcSFheUoR3ytwyBnGsp7skrhuDvj2P+WrTKwK5RZ93t+qLvUg3
 Htj8by051ykwFPEZ1c8g7XRa0a97CvNBDWiPYj1u5EFPjShbRdVDs796DRbgOhBnCYWytkx6MJk
 85GPFSi5XskaDBeSyijdq40NR0NYhrVLC9T3Cv/DAuz8125qpKX2mKo9kPVIjz30Yu7zGoyTwL0
 vtq+BxmGHVyF5+Ow6S5/xGrrvFDR68bP+MnC5JqGEn5wioP53hdgfBY7mlQ5YXQnIsAlOq9SlaN
 +yQGygz6VSeKITy39hCERyjNutHk7GxsByLE1zfmvJRKLJitPJJuGMb27LMDNV3rChEPYPzCHAt
 32pCxz9PGEa1BX
X-Received: by 2002:a05:620a:1a20:b0:93b:d7a0:d9de with SMTP id
 af79cd13be357-93ca975f4edmr618618785a.56.1790819632025; 
 Wed, 30 Sep 2026 18:53:52 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:93b:d7a0:d9de with SMTP id
 af79cd13be357-93ca975f4edmr618616285a.56.1790819631575; 
 Wed, 30 Sep 2026 18:53:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fbeffbsm341983e87.68.2026.09.30.18.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 18:53:50 -0700 (PDT)
Date: Thu, 1 Oct 2026 04:53:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a5xx: don't read the GPMU registers on GPUs
 without a GPMU
Message-ID: <5ibc3ap35a75ovwrhyeq2qrc55qo6zx43tsp2s5obyukzlivhw@n5tgfcsslxrv>
References: <20260920-a5xx-no-gpmu-v1-1-714200254f76@oss.qualcomm.com>
 <1eca3b55-fce3-4a39-9e0d-2c6d1fcd6a86@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eca3b55-fce3-4a39-9e0d-2c6d1fcd6a86@oss.qualcomm.com>
X-Proofpoint-GUID: dqs4f3aC4DgoYd_qyi4c6_HpzsB7mneq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX073mfScOfXAv
 7BOmJlbjNLUemGX6P7mLhzQB04pS0dQJNmK0ASEnQ358mUh3UJ6Yb/SXWwFXKQFO2VJei3qtx3N
 0Hikf9/W0lEgRpmvUGa0gdU/zOhf+OA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX1s3P4i90104l
 h1L0Jdm1E4H2i1yk29w8QYTkr6UnS5Gm2ae9EHdItCREC1vBG3rHROTVac6j/AP6o8J9Xv7pHkj
 QHMDkow251JuSfJjlbX0H2WtHrkpG8PPefMt/DurbQ1Au2u6/kPI646IB+KGol2kniD/jJh1x4b
 3WlAg5AgygQ4oYIUvttWy5anOXDlpE6BoECYSnoCAeM0B0AOG55HMp3ozKiU/7tyyMmoi731aKw
 xcSAT+0M48TCNYvg7547tdqARsK0guaP0yxE++rzKLV9qU3+ApTA575X2+y5ntH7h8zdTxOAyaA
 NXFQmwOtjjpfeMw7tkWz6ccGtjPrs4ZVpORKkw1wudNZJED/lC5RCk/pbue0vTPGndm7OTLWoT3
 U0mNZRraNqL2RvDv1hxijeCO9dR0Yo8/4sdsHZ7fSIYy3BNr2qEK+e6LGO5nyGrLnWAtvNo1wBV
 EAmfpH4SkgT8jbpVNYQ==
X-Authority-Analysis: v=2.4 cv=NuxE4MdJ c=1 sm=1 tr=0 ts=6abdbd31 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=B_4pYxvsXjM4UyOe-28A:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: dqs4f3aC4DgoYd_qyi4c6_HpzsB7mneq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010007
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

On Mon, Sep 21, 2026 at 09:40:35AM +0200, Konrad Dybcio wrote:
> On 9/20/26 1:08 PM, Dmitry Baryshkov wrote:
> > Only a530/a540 have a GPMU.  On the other a5xx parts, reading the
> > 0xa800-0xac60 GPMU aperture during a crashdump resets the board -- on
> > sda660 (a512) a GPU hang thus reboots the SoC instead of recovering.
> > 
> > Split the GPMU block into its own array and collect it only when a GPMU
> > is present.
> > 
> > Fixes: e20c9284c8f2 ("drm/msm/adreno: Add support for Adreno 510 GPU")
> > Assisted-by: LLM
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 49 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 46 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > index 5d96b8f63156..3974aaf6fd33 100644
> > --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > @@ -1337,9 +1337,14 @@ static const u32 a5xx_registers[] = {
> >  	0xE800, 0xE806, 0xE810, 0xE89A, 0xE8A0, 0xE8A4, 0xE8AA, 0xE8EB,
> >  	0xE900, 0xE905, 0xEB80, 0xEB8F, 0xEBB0, 0xEBB0, 0xEC00, 0xEC05,
> >  	0xEC08, 0xECE9, 0xECF0, 0xECF0, 0xEA80, 0xEA80, 0xEA82, 0xEAA3,
> > -	0xEAA5, 0xEAC2, 0xA800, 0xA800, 0xA820, 0xA828, 0xA840, 0xA87D,
> > -	0XA880, 0xA88D, 0xA890, 0xA8A3, 0xA8D0, 0xA8D8, 0xA8E0, 0xA8F5,
> > -	0xAC60, 0xAC60, ~0,
> > +	0xEAA5, 0xEAC2, ~0,
> > +};
> > +
> > +/* GPMU registers, only valid on parts with a GPMU (a530/a540) */
> > +static const u32 a5xx_gpmu_registers[] = {
> > +	0xA800, 0xA800, 0xA820, 0xA828, 0xA840, 0xA87D, 0xA880, 0xA88D,
> > +	0xA890, 0xA8A3, 0xA8D0, 0xA8D8, 0xA8E0, 0xA8F5, 0xAC60, 0xAC60,
> > +	~0,
> >  };
> 
> I'm not sure if there are holes in these ranges in the hw, but msm-3.18
> (8998 kernel) simply has:
> 
> 0xA800-0xA8FF
> and
> 0xAC60-0xAC60
> 
> (both ranges inclusive)

Yes. However these tables list registers to dump. We don't need all GPMU
registers (and even if we do, it should be a separate patch).

-- 
With best wishes
Dmitry
