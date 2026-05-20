Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485A2CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D83410F098;
	Wed, 20 May 2026 14:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XRRu2pFL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zhf3v/vI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1FF10F094
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:39:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9nmhc447958
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CB8T1emnrevojF2cKkmEFlZH
 3rH2mv4BWl9K76S5teM=; b=XRRu2pFLvV1i1L8d9IFf4YSdLLM7DnYroN6S1FbE
 ekhxTz9y9+dkXOqZUw9c0D09oWGluUQR6WGUaa+4Gj8JJmD7HmopXYXqk2cxtFw7
 8klkfTI6OARW2LX+f20pga9a3HLhbiBxjYC2cnGqfkPM1iSzii2pslpji/gkf1vJ
 FoAJFYJahHb9FMydcPvUrSI/qD/vsvjaIrxbcKgZ+9+BeKWXZfbEE1y86ROOVNer
 nq3K8N7EGokJSVAKk2WedRvTEDAcsAbW7v9JonoMKPUnmVBr+N22q1KWXSOMue2q
 H8LMfEUncVb90kpUK+OxDGOVgM/Gk0xr8ObDg0FTKuGs3A==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9anrh2hk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:39:17 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-95d1b7487caso9849200241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779287957; x=1779892757;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CB8T1emnrevojF2cKkmEFlZH3rH2mv4BWl9K76S5teM=;
 b=Zhf3v/vILopkASMJqP688d8UsJJJpfKoj9mLtmKCqmHah9aLCi1F7XNjDeLfdn9zwz
 MmuoAjuI7VEZgz88TDC5oofctBA0vbnpI6lEJxgw5MG0oYtrpbGEi44491eueZwEkSWn
 4uKyujFMYQP1hls4fQT4JJ22/5GOsUxED0EXEJ13WP/J95tvyvFXnZjBWnXWM7XcclUX
 PdgCcqImUnpjic2wkyx9Qcol8pa+sMkIuRs3TQLAtAp6WjM9wBWc7IVHCqbzFSwWmNXJ
 fHznVwfXG/15vG5becIrwtvdBolF1rdisj27t6HXEZkGZMyx3Z2t1n/p6c0dxISYnEPC
 QxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779287957; x=1779892757;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CB8T1emnrevojF2cKkmEFlZH3rH2mv4BWl9K76S5teM=;
 b=BW+KpFFAR5/rU5d4RPOKzEfbVduSfzlbvA2Rdg6oZrdBxeyDwgVaNdZdIHGDYO9ZTx
 KQ6fJplvH2bQL0kE9OXj2heWsL1VnOqG/J0AGOX/5NjvwJReHUG5rbuWfs4+2idOpQmY
 YBtFIwronZxh/Dd441D9cCjGI4sf1d/Sqei5IqYA04YexN9ljNkSLGwoOwUKQadwePGZ
 1xr7dcrrCg6TYcL4SEH9ilAX2ezj5qI73ZAQ+uZJ+II8MeJdqIUe5L5HQAKqNzLLQLWa
 M4ImZNqn03xpKeV9fkBdKqtcN5XQuRS7nM198AYd8YioIEWFnACReb4xOIJNu/9hAPJZ
 y+WA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nN4WnsCZddQqhy2lmrZMrTTb5p1MkP8Pg1WZcIObDJlH7/gDOQClmrVmrQ+vdjAJ5nvmfYKgO/nY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzv/DYxlOTXRO45U1tjB+GfDvMIu6p6PFf2diSSW0IweYY4zIRU
 vs0hevrZJTXk86JA5Sox5aAC9FHqd0Z5dPXet5drq0uVtG3Utgvl8lAgBx4Z9BVMjW8zncda5Tm
 hc0YKRUDnHEo4GKpJlH5R7mAapvRUXJUWF0fVduIwcFcK2ArjuHTv/EJlqPEV1u3hB4trhtI=
X-Gm-Gg: Acq92OGczlzVYVyFyO3uTgduot0spMEvqF6MjyCXPFIiYfczse925iUBknHAzoSj7Wn
 eJGeT+PcKHM9XxDRS8cHEDMkLZ7vuXDs6ffw/o85UYRXVXpa4G0YDttIzrnhqG6XACpAGLVEfpS
 0m/OQeh0Z3M6hxiYS2wmODRoFGXQEz83q/ONGB1YUnvwGUCYaKLc8ycofp/XFNJQEH3x7KDp8u5
 E4WrgQzqebdwPjYidckPcFwl5slgejOHmWleiFWmhzU16R3wSlCWxl9jw07/RhJzRdVFTWF8AJh
 ysDmDz7lCZrr2fa/zgx/i5PtFwByyCK0XhBb4t1GpQgT6K5jFW4uSdnWRdjv/nQnj5/NtJmNUdx
 325sr/9q19E7vXVbRXP5tp0W9JWbUFyZAbfzt2UClBldEltW8f0iMQA8tG3RGp1HX55qDBZIf3v
 E6mXke+LyTHRRxAQzmFjLkpAP4P9rskLw/I70=
X-Received: by 2002:a05:6122:e149:b0:56b:9b7b:83e7 with SMTP id
 71dfb90a1353d-5760bfc839dmr14426077e0c.7.1779287957251; 
 Wed, 20 May 2026 07:39:17 -0700 (PDT)
X-Received: by 2002:a05:6122:e149:b0:56b:9b7b:83e7 with SMTP id
 71dfb90a1353d-5760bfc839dmr14426011e0c.7.1779287956748; 
 Wed, 20 May 2026 07:39:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c8b2sm4997493e87.17.2026.05.20.07.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:39:15 -0700 (PDT)
Date: Wed, 20 May 2026 17:39:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/29] drm/msm/adreno: use version ranges in A8xx UBWC
 code
Message-ID: <osxjtbbpymn32jp4ntntzucelpzmyo6wqe7xy3kpvmekq2khln@thtrwk3z4vvh>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
 <20260507-ubwc-rework-v4-19-c19593d20c1d@oss.qualcomm.com>
 <28dd74fb-ebdc-438c-8624-6b8fa0657e40@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28dd74fb-ebdc-438c-8624-6b8fa0657e40@oss.qualcomm.com>
X-Proofpoint-GUID: 6X6rUdyZ4FiFn8C9mNYIBnfhkNXPYZQ-
X-Proofpoint-ORIG-GUID: 6X6rUdyZ4FiFn8C9mNYIBnfhkNXPYZQ-
X-Authority-Analysis: v=2.4 cv=UuJT8ewB c=1 sm=1 tr=0 ts=6a0dc795 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=KmzWl_YmvbXQvTfoh20A:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MiBTYWx0ZWRfX11wQQNgbmylU
 r2Enu9rD5/6JUebCNicOHkz7q1EXRY8Zf4l1zyAHzqnDu2/2x5UVUzJYTHTPAxvgSUXcMc5K5ZG
 EIAlFj82XZlGgkBSG+5Emp18coCfwKS+HxvEAHjgKyIHk4A4XE7vupGx1iJHh1N2zyYbvywDL1G
 LJ1tkmzQgPA0vj4g3mGixvvSfDaq2RycEmve0iItRxrmwb5nor1QSwV73PwS0J1DdoNTRRw3WXK
 pojELgRpr2uEx+eTOTawO6dBDbeynZX2a1eC9iSuiaxl3tBzWyso/nWaN48o9qyouPClBy5M5sO
 AsRNtjuaN4at0eyQ6F05bhB2EXiRJwxlWQlforSAO2w2ofq4R5GTbNgJgqHQK74dWq+0M8iDi20
 HirXGJW/793OVSB8tQu4r4+2qf7J0laNUS7+FmetWtquJzwOzYJ7tRC4txvTy2wlg413YXKVutl
 zfbu+q2ujo8VJOME+kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200142
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

On Fri, May 08, 2026 at 12:06:09PM +0200, Konrad Dybcio wrote:
> On 5/7/26 3:03 PM, Dmitry Baryshkov wrote:
> > In order to simplify handling of UBWC minor revisions (like 3.1 or 4.3)
> > use version ranges instead of a case switch.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 32 +++++++++++++++-----------------
> >  1 file changed, 15 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> > index 5c73a9ebb22b..29d559fe4683 100644
> > --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> > @@ -286,26 +286,24 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
> >  	u32 hbb, hbb_hi, hbb_lo, mode;
> >  	u8 uavflagprd_inv = 2;
> >  
> > -	switch (ubwc_version) {
> > -	case UBWC_6_0:
> > +	if (ubwc_version > UBWC_6_0)
> > +		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);
> > +
> > +	if (ubwc_version == UBWC_6_0)
> >  		yuvnotcomptofc = true;
> > -		rgb565_predicator = true;
> > -		break;
> > -	case UBWC_5_0:
> > -		rgb565_predicator = true;
> > -		break;
> > -	case UBWC_4_0:
> > -		rgb565_predicator = true;
> > -		fp16compoptdis = true;
> > +
> > +	if (ubwc_version < UBWC_5_0 &&
> > +	    ubwc_version >= UBWC_4_0)
> >  		rgba8888_lossless = true;
> > -		break;
> > -	case UBWC_3_0:
> > +
> > +	if (ubwc_version < UBWC_4_3)
> 
> < 4.3 specifically, or if (4.x)?

4.3 as far as I know.

-- 
With best wishes
Dmitry
