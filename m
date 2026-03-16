Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170ACF506D9
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7627310E3AA;
	Mon, 16 Mar 2026 14:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhjEHBtx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FnMsDWyc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7107B10E3A1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:28:54 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GCXBhu1622327
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=74yO8b4S84lStu/3hVA6Hz5K
 7prxIWx/s9Fs0CUTS+E=; b=hhjEHBtx5p3dyeruEZdRN4ggAXyN461Gk22VrDN+
 8EelU2nKWqabHDVDUBlfaJtJjTrzDz70MRMsM7wZz/ZUUeOfbpJW05jp3Y7hlWn/
 ixjnpysODldvCgVx5/SWktoEiG6CDvEcELh3x2IHotIk+baK55gX16DudY7XYypm
 4Gqk7TdmWQFX+IiO1iYDHPpjFabchXI6s8m/n2vaiuMANxrjZZVc3hTb1Mf5L3Oy
 wiskPzW5x3vk8ijnY0ye7xKu2kjcZ0bDbXY4XOn7odmuNnlRzCNP2tLWYFcp7d/x
 uJ5kmh21aegCO8axkKF0ze27gAyprb7wKJYOd2YN4YBgSQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxhyege6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:28:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd849cd562so3082088585a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773671332; x=1774276132;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=74yO8b4S84lStu/3hVA6Hz5K7prxIWx/s9Fs0CUTS+E=;
 b=FnMsDWycs0cGglfD3kikB6uNsBGohsO2l1jFUom24zONzCbBwOAOASLs5yMJly41Oh
 LQ/I64D8PQRTOETCInVppnElSn4lE0N3RMoapFfVJdf4ZL2/JQDaM3hLfyzsie5q/Wso
 feXOKwuL2gPrxmIvshXrrXsTOZABbq+UMbFMbYgE3sLwbIsUtiJz2YzMd5dcEcpX8bnS
 ssCSsLnAT5LjiuVAq5MxaVkzXFuoiwYospDDyUlf8y+cKndA9msa/2lpJqMS1twZvTGC
 9ZJPwMQxcLj+RPSt+VRhA4e2k8K9ObKIYcc5bL3KqfZT9x/B8PRUMKpzKDy9mhKSY+In
 Cn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773671332; x=1774276132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74yO8b4S84lStu/3hVA6Hz5K7prxIWx/s9Fs0CUTS+E=;
 b=FQxGeFE0eP+0L4GzSOCLehmzLG8AkAmpRgk/939A6bBzhhgNe7YxTQkjkABnghmAwJ
 xXLDcfV/fiV/Z5KSnI/2rvUUL0UJH0HuDPgETKgDkDlzW2eH0KFjxyr3Ch/HtEJ1TiLt
 H1q0JCmwhZJ7dnVjaHPgOLF/P0QcOYQ4b+s/PwVO0aB+jqYaqdHC8qf0pUm6VQ7YNCxy
 7fTHgfbirNSOI1THQUperWO4CKf0SM7BtR3A0bGWD2BrKJfH29y9G3asCQW7VZ7CKKDx
 ILwu3BVna91/2paxtOhhERy50iJzXuyvhoi5Em6Q/hweR8c7KQP7WNj0ar5aHUONW6aN
 d2Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlYcSgxrWrqdZ8TTKDt3+sCYsSS5I4lAjIPjrPMYCszO3+oqHuKlhz5w71fnQ6W7IOEpciATC4D3A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwA4/+2skvScrdhDLp+0mPYeYL+SrohJQMliqFEzDr/icZ8QctX
 lkaMdhEBO3DSTt9rm5kBP0OvoE9nXtGbMVJYjciqgPHrfkghtOFQTPwO3ckfpEidlkFGze8KTcb
 xIqyTnaZO2/hZadrKpCN124q6Jwc/qNDEWkuQDa4001yr9LsR8GXTkq7aV5Yf7XqEJH0XYdE=
X-Gm-Gg: ATEYQzybAsMW1v6H8Zh10S7ElUCysL62Gd6ur6z0R7rht2unCw5u+o/icgd2zNkZRaZ
 KfcNBa9Ah+GvzukdZmdIw2zzxBQGeDtbYN4Tq3FSiVFruZVsx3l+xfEQsfbdCvMVVQRS790QqbR
 vLDPzmKAnYm4OUChf9fcnLieWSXnCD6+MfKaJfsbB7IRl7aiokbQs8wXqi21iUXBxmGi3PgqYsj
 ZkrlU+PDa5Cvc2C/D8EiOUoe84ugsZ2sasHtMlo20DQQvs1D3sr8qCDhIJmVG1pLUe+D3h21hg3
 aPrakOYCUem9EHfCzcHsCKwAFjYuW34sz8ZLAnKZvzkCgUDQTcsPWMHzChh+ryvQIS+LEAcUxHC
 W3+3ru1gKTYq1lOCDFpD9o5SLSTcedzvcR5a7d/0Uyg1eB79NLMJ+D1s8j2SIG7gpLOPOkqvms6
 /nyKvW+AOYdyO41qzOhl/hjRAKcezWi9Y7OTQ=
X-Received: by 2002:a05:620a:4041:b0:8b2:ed29:f15f with SMTP id
 af79cd13be357-8cdb5a83bcdmr1632416585a.21.1773671331791; 
 Mon, 16 Mar 2026 07:28:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4041:b0:8b2:ed29:f15f with SMTP id
 af79cd13be357-8cdb5a83bcdmr1632411585a.21.1773671331271; 
 Mon, 16 Mar 2026 07:28:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38a67e5f33bsm33396071fa.27.2026.03.16.07.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 07:28:50 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:28:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Fix GMEM_BASE for A650
Message-ID: <6gxzcgwzvqoaqgynwnturjybanjrk2jmmsa3qh3r7vafyyzj44@dfzkd3vigluu>
References: <20260314-fix-gmem-base-a650-v1-1-3308f60cf74c@pm.me>
 <2938aa01-cc1b-4dd8-a4af-45ff8354a061@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2938aa01-cc1b-4dd8-a4af-45ff8354a061@oss.qualcomm.com>
X-Proofpoint-GUID: Ozup2eXEZv0IkWPt31CH8OmtPzfWe1-G
X-Proofpoint-ORIG-GUID: Ozup2eXEZv0IkWPt31CH8OmtPzfWe1-G
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69b813a5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=aLg-ZeeFEV5HabecVkUA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwOCBTYWx0ZWRfX7bsdjlgvaE6H
 lwcRvO3pdWX0ATL6d52tbq1hLBdrmCFNkn8uLOg5MtozNKEEj3gCW4uVobOfB2SgCB6+7q58OEd
 9QLhuSLGjeqkYfvA/8+QekSFf4zQjAF14epNgp5Q+qyMaa1WfO1Efh2r2rsQX6Gmk2xDWeIMGjC
 sNilOfk2lhCpACkeF16IRgJR/X9/rnI1LVVQX97d/57gFRRFLP4ioIN3qOxPgqsFEVhSxGHFIYi
 e3/M8DdNMVjtvudTcj2ilexBIhHNoh3KP7eHBgHp8D+D3wjswzbiesDorVtLQ495mQVjSweFZjp
 S6EKAwix/t/YH7FD3uGPH1sP7N0Two6i7BAIOHpZVF8HfX7wEQNNcRgoD0Yo4sfi8kDGtNST/R8
 CUegxgHA8bi2UyRd0kJb27QsLUY4j5vS0UMeIze3amCGXfA0PBzkMid2Y5jZw/PkVNLtw+mgqwP
 j2aynpmWV+bNRiXkVzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160108
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

On Mon, Mar 16, 2026 at 10:22:44AM +0100, Konrad Dybcio wrote:
> On 3/14/26 5:14 AM, Alexander Koskovich wrote:
> > Commit dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8") changed the
> > GMEM_BASE check from adreno_is_a650_family() & adreno_is_a740_family()
> > to family >= ADRENO_6XX_GEN4.
> > 
> > This inadvertently excluded A650 (ADRENO_6XX_GEN3), causing it to report
> > an incorrect GMEM_BASE which results in severe rendering corruption.
> > 
> > Update check to also include ADRENO_6XX_GEN3 to fix A650.
> > 
> > Fixes: dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8")
> 
> Hm, that commit also changed the value for A730 - Akhil/Rob, should
> that be changed back?

I'd say, I'm also surprised about something being broken for A650. Which
path / stack uses this value?

> 
> Konrad
> 
> > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index d5fe6f6f0dec..0ac3fba5c277 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -376,7 +376,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
> >  		*value = adreno_gpu->info->gmem;
> >  		return 0;
> >  	case MSM_PARAM_GMEM_BASE:
> > -		if (adreno_gpu->info->family >= ADRENO_6XX_GEN4)
> > +		if (adreno_gpu->info->family >= ADRENO_6XX_GEN3)
> >  			*value = 0;
> >  		else
> >  			*value = 0x100000;
> > 
> > ---
> > base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> > change-id: 20260314-fix-gmem-base-a650-cfd9bfcea425
> > 
> > Best regards,

-- 
With best wishes
Dmitry
