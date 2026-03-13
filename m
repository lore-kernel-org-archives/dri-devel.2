Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67006105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EBD210EC69;
	Fri, 13 Mar 2026 14:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mcWSI0h5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NI9OIUQH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0A810EC68
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:26:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DBeRlF3229800
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=UrKQhgpAedlMnHwgHifVtQ34
 FWYLdmDi753Ssg/d0SE=; b=mcWSI0h5FfX6Ja2d2EHxMhok+LBJr0zCglH0omCw
 Zx2YlhXSPI9GoW6P3A5pEOmIpruxiI6H2UIcFJ9TZ8QC8WFMOHLwMwc2QQuRjDAk
 bkiOmOaSEfaH7K2wI76AyORfszEwgslCFEDiL6ykZo3hq7DA8fOIwK06PRASNarJ
 Qnc7M58ICSjogKoHQ2zEw6cxr0FmqiWcUkG+AUycj9N5shshppyXsBBihzQ1AWSf
 Cid9lQ36qBOiGgAvIYYWQyN++3HE9IgtgSIRibmPReBZjrAchWZm5QdSSS1CICO6
 wlmJ0WYIVJt1K90LP6BEslNC89z9j6pIVQUQrLlFEWKHaA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7jhh7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:26:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd80bea54dso1288245285a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773412005; x=1774016805;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UrKQhgpAedlMnHwgHifVtQ34FWYLdmDi753Ssg/d0SE=;
 b=NI9OIUQHy+feST/jsceB1PshcoDm1aihnuE4A7pyE7kBfzYa/eo8j04x/C+RL4UJmA
 telLs8DKkHRsjz4fu1L09ROZWFVci8//1MSgelNJZpMdBRA8Bv5uLi7nqT6JG2cvCw4Z
 NiJn8B3/jckIk9vHr7j9L8v60I3DLQeacUxFYPxyMRKVAYLCwzP6ZAoGoIucd+EO76qN
 k2gT/5YmvgrZFXfeWytOWTEj6K38LpVrbikEtWuUcyQRhjk72f0hV7GRL2WsnTetMTDG
 e2lnC+Kdo5oE95gZQNi+DVRtgOj5axziT57B9JchsA9qy8kohdGnCncf+FgEeh9dvaE+
 DoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773412005; x=1774016805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UrKQhgpAedlMnHwgHifVtQ34FWYLdmDi753Ssg/d0SE=;
 b=biCiK7VL+cBT15eBZH5MwkAw5ohyACvE8aUomfoT+xeYqBp11d31QPKwjh3qNYZE4h
 kOOimZVOIktUfgPEPPEuLsvsqPNVGAuqnNowHH8E7kXCAd1R7q6eQgbR3h07zaDGDrwX
 a4YMxP8KWA6vFmPRRAAbkzx0tFgKqi5FPeAQVQoe/rVA5k4anblPeGTyHbmtPawDxbCv
 8e6T8ZL4TJa3mMp6jUilsk5vrIYc+GIdRNU9I3mfB0FGHVMQspejrLyFywKRa18kcecu
 ckpL/nCPF5WLDKph375Nrt4GLjqttRkdRYqHDPNJ46VA+uGjm7NuychLwCkDp8R2iyLB
 wpAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnqi+Mgu/knkSefAqQnEZnOccq0C3IwqfUNV2x4A492R5BiYZ+0V+MVR0yv8yY+aP838rkYMLvrto=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZwvci/t8Evcqv331vxJhqZhy1DIfIY2NAZfYdkmtrGo6o2nsR
 j7d9SwVso/kQLHqqNPGAk0I4E+8hZ0/MC3MXtnKp7fbcAIja02UkE8e/AIhQAo0tjN4JiIAHmS9
 QGSl+bc3bu1L2jhAsQNpBz65VMh2RzuQoTdDfMHtT8YHpB9PQOoheRMOCxXnc61z4GRjCogc=
X-Gm-Gg: ATEYQzxEVQQ/+qXt0Um7rz/uxi8fhZp3DpxawAER/Z4HzEncpsSJFDb+i4EtfDc76O+
 adRU6Mu0RLxgzz3VWCUBmw9AziGUqgEqiRomtTp0EsZykFKuBs9u33+5YmPTO0X9ihUWPaATp4O
 /DWMaMKY724jtmBlp4zpZCGGqzE1HWK+gdxQqH+7AVcPelfIVOkqapih6dC0zQa+eTPyt/v37yd
 sZ0cU6xRbMPUU1JVFJqDZWm2pIpNchXk3xoEoQsOu40WCTzgYjmFY7ZHZKN5/qjmRrOgBknHzx1
 GhnECuXkr24DpYk7KA+mOMZIlNhzBBfW20DVr20b4j9rij6fllK0w0q/3gkPZcbBcC86kWJQzVl
 lpqJjLnzLswCwrGK4hHT9d6ENSMlHdP/b1tu+gPJxAjtWoGQ6gtX7FPE8JqpNCxnWl97k19Sf1Y
 FfuGWRKYcl2kUs+4XfIi3Czngx1FP/pI1f94k=
X-Received: by 2002:a05:620a:2954:b0:8ca:7b14:16d2 with SMTP id
 af79cd13be357-8cdb5b25e8dmr454965685a.50.1773412005099; 
 Fri, 13 Mar 2026 07:26:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2954:b0:8ca:7b14:16d2 with SMTP id
 af79cd13be357-8cdb5b25e8dmr454958885a.50.1773412004447; 
 Fri, 13 Mar 2026 07:26:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38a96565ecbsm1001551fa.41.2026.03.13.07.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:26:43 -0700 (PDT)
Date: Fri, 13 Mar 2026 16:26:41 +0200
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
Subject: Re: [PATCH v3 17/27] drm/msm/mdss: use new helper to set amsbc
Message-ID: <uahvm7kvu2vi6o6mwznn5eqzqqscxmfetl4c3q3xa2eryg6ode@ltxfpjmqbrrt>
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-17-b7e8f800176a@oss.qualcomm.com>
 <19b36a86-12c7-4710-8f80-5e27c9c00e3c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b36a86-12c7-4710-8f80-5e27c9c00e3c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: v6q97hfDxJwTFxgZ9m6Hsyk3IOCXj-Ex
X-Proofpoint-GUID: v6q97hfDxJwTFxgZ9m6Hsyk3IOCXj-Ex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExNCBTYWx0ZWRfX+Scir3P4bCDW
 0BreGb42Dqh6tvfmIIChBDhHums47Jrg2dgDMkVCvKs4hmXQgamHYwA8zAv0VGPJrmEd76Js9kU
 a1ouwlUzpJRDIVBPlo3igfpyrR6OCkBOKPcRaFywBcFyDIcoDDRTXj8QRBuiH3Ez3/5K5wAMPz/
 Eumq762qDbB2ccQ7Gz1eSa+7jUmP6pGFFDfvEll+whrNWAEI6c13vVl5I0CuqA7bdFIORWqXs18
 9Zt2Jb4SUs0dlB11mescZiXe3dM9fedwi+QY239vHEiGZFk4D7hjcrTab8Ho5IPw7gzFenFa1wf
 4y5KIvQFLIYgg62QzrllNbumC2WMLYMyR7uh/f1wr3HzACLRqpIRT8kNI16Wsi/J4zJCYUpa1A3
 sww8G0pMgi5/4ATY3wMES4C7YAZYOuVW2SYAGotCnblcEi0Gte3jaxtb57ggeoILp7oOqVfMvB7
 hALW6Xq/IE2iKQwfqkQ==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b41ea6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=ffw7P2BtgO-SoTFsxwAA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130114
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

On Fri, Mar 13, 2026 at 11:19:59AM +0100, Konrad Dybcio wrote:
> On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
> > Use freshly defined helper instead of checking the UBWC version
> > directly.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_mdss.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> > index ca59bcdde7b2..04efc29f38cd 100644
> > --- a/drivers/gpu/drm/msm/msm_mdss.c
> > +++ b/drivers/gpu/drm/msm/msm_mdss.c
> > @@ -188,7 +188,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
> >  	if (qcom_ubwc_macrotile_mode(data))
> >  		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
> >  
> > -	if (data->ubwc_enc_version == UBWC_3_0)
> > +	if (qcom_ubwc_enable_amsbc(data))
> >  		value |= MDSS_UBWC_STATIC_UBWC_AMSBC;
> 
> I know it's already there, but fwiw downstream doesn't seem to be
> concerned with toggling AMSBC in MDSS (perhaps incorrectly?)

Downstream enables it only for the cases where encoder and decoder
use exactly UBWC 3.0. This is not completely correct as the bit doesn't
exist for MDSS 6.x+. For 5.x this is equivalent to the code from the
patch: enable AMSBC if targeting UBWC >= 3.0 (because MDSS 5.x don't
support UBWC 4.0 or higher).

> 
> Konrad

-- 
With best wishes
Dmitry
