Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FE2C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554DE10F59E;
	Thu,  9 Jul 2026 12:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O6rS3nmz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CJa+ZOv3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E24110F59E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:36:35 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669BNJwC1667669
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 12:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=xdIlinKU5FAEo1uLB0/ZFmCi
 ZXJJuqBJRmfImIhYZg4=; b=O6rS3nmzmgD8yWcpWDYlUrD+K3ETcv5guS4jJMxv
 IH51cSRFJzGGlIVGmmobEk5oxOwMaTw9tO/SisKZGqLb14ywsBupLEUt30A+3Txt
 GywaJJvLn6jjQ4qrJggqIUcfaUJIPAIeeDg2dsRRtqMWgxZempBAUfO7WxynHPSV
 xyyqhp8bJ/pVytzXP7aUwdGVx3o0CMFTaqs5CNFU4Nqc1ovDgGLn5kTwycyz3G0m
 cVJlQocrPSmRQThVhhH4X4dFEAElebCCvJT/G/R3mwt9wDIt3pYTDa6eNVoYIZnO
 w6pJkt7Ul3XRSIzsoFKgyBXdC0Kyd+jouI/A+sJJUU9qZw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6kr9t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 12:36:34 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9693b69c4f4so794920241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783600593; x=1784205393;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xdIlinKU5FAEo1uLB0/ZFmCiZXJJuqBJRmfImIhYZg4=;
 b=CJa+ZOv3snhc+LVLVKheMNXBIBbaaVcUVnReVrL6X2fckPxVVu48IB9IjII1LD8NPJ
 By7ldhHoR/M7yYf6du2YtNWNAK2+hv+3GJcuMDGREx/xaYaShNpuF4RXUjt6tiDLUL++
 vv/TZx0YIhgp91sJSpXZYPq/jhfLUEVDAXr9DDIb8xjGE8BRIVx/A+bFC5iybBK/TupE
 IR4vfckrGbH5HhhmNEoPBPzD7pIYph+sOLhLKRQqsC/n4fJVbyEGEE/DWnmYel9QtGlV
 ao/SsctN2P1lUl/P8HVGWE7HO/PmNzZHODqFTH4P16TVjCN2TMCetS71iTENvC4+9ar4
 17aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783600593; x=1784205393;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xdIlinKU5FAEo1uLB0/ZFmCiZXJJuqBJRmfImIhYZg4=;
 b=Ryr0Eb3PgH5c0J0/GlTvF4XkVskzoVHT+1Dd5Wq+b+thR9kXIbecV9kX3Xak1Newba
 K4DY1lUNtzLfzQ0eXh7rn0pPxM3ZZZ6G3TNKhjQxUteh4yYYPR03ykYPrvcgfhmZdq3o
 YrLtkAjSkb3LByFkAj5i4FRtjSIGa6wTsNEsnmYxSQYfasYi3TVBjtZmZ9ACorhRCUW2
 aqgoDfZYznbeW1YyAMS4fdJXU5ZN6yyMvRTb6qFg7GbSqKLTo+OSE60Y6aflEfiqcMdU
 GMx7GWro+mHARnQnYn7ADFP3lF6yLgT5uAunLhF8CoNAePPoK6MqtgWy6YqIQfHVs6fs
 /VJA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/qX7vCuF8YCjv6xo75p1QZIVeFbw/ZQVA9p26dT43iHMqQveIYAiLDDoDEGaMqia2+6ZGK3siB9c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJocEVSP0kIKounqk8Q4Ek2LvBNYP8AOgFUI3MsfY+uKs31ojn
 iyc91LTNPe3NHR7oF6PCzgm4iwpuDCA8pEYwQWKcCwVja+Sa/JQjMctdGZSIIdhcUKlTSJm6EGa
 pkbevTHj55U6NC/Yyc3NZLEyLdSqh+LUXq5a+4IQmWgpSRSHuRz+rRszR/vr1mtiYWiikiwU=
X-Gm-Gg: AfdE7clalO89DabpaclUGA2X/YC1PTC0OnavSHhsEVKhSJHhJlBpsVZkO7ZSiweDnwl
 PZG5kgOS5L+j9/JkHZYGR9vRY2FaPzrCsSWDL4VfTIzjKH1ScOQhSnGC5VQ222FFYZdpm+6cfjp
 ykqK3AwPzLE6RPwWDhg/GurpGjZUI6diplN5+zSEojijQ0pS+1JWdE+qoVDxrknzHnLUdnlG9fU
 PIlCLmqwBGnWVqF+vvJJqSvCtMqcdxfLYeKXrxg9S2P56azNF0tIsD7GOUVhfmpJRsaENMTLRHD
 1ZvI1zfWayxmOiS4Yup1WXshjEivwaWhCf8KAqWHDUYwWrSbrmWjel0LSVsHLmZYMsMjKiUQFgD
 1+IUi40mEORmIprH87TJDnxYKorxGkYja1zw0pghdFwUpGY1i1auO8msS3u/halpPL1MzOuucLP
 0eeQ9pSgSj0K8/A1cfFr2snW8M
X-Received: by 2002:a05:6102:370e:b0:73e:9fae:584c with SMTP id
 ada2fe7eead31-744e005ea3amr4369256137.19.1783600593415; 
 Thu, 09 Jul 2026 05:36:33 -0700 (PDT)
X-Received: by 2002:a05:6102:370e:b0:73e:9fae:584c with SMTP id
 ada2fe7eead31-744e005ea3amr4369241137.19.1783600593007; 
 Thu, 09 Jul 2026 05:36:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b13542sm3154271fa.11.2026.07.09.05.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:36:31 -0700 (PDT)
Date: Thu, 9 Jul 2026 15:36:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, abhinav.kumar@linux.dev,
 freedreno@lists.freedesktop.org, jesszhan0024@gmail.com,
 linux-arm-msm@vger.kernel.org, lumag@kernel.org,
 marijn.suijten@somainline.org, robin.clark@oss.qualcomm.com,
 sean@poorly.run
Subject: Re: [PATCH 47/60] drm/msm/dpu1: Convert to atomic_create_state
Message-ID: <vvzexupy7ptk6hqq5vkh5mhqh5iv7doplnhsjsf2x6xuimlav4@457x6ummsmcn>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-47-302d986fe5f0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-47-302d986fe5f0@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEyMiBTYWx0ZWRfX5fXmUZYifseB
 Fpfdl9mX5ENrf5bs8xV07fDu3JRfgTL+ft3sIJimUwiICj0gn9MSK8pCQkEN/ETxBh0WqdGsrGb
 YapVuvNZVMXK8O/d4Bh+EJOWSYUFro8=
X-Proofpoint-GUID: f2rF1K_-exnWTXoz1kQLcE2zdtYSXxMQ
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4f95d2 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=mVv-3nkEeNymqhpJ9RMA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: f2rF1K_-exnWTXoz1kQLcE2zdtYSXxMQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEyMiBTYWx0ZWRfX7Ani9Gh/3yoy
 dZgiNe8dGnXNuCzN+IemDmcH5h0mkE/27HmBdezAwL8sWu5Pa9d9qOk4+8BrO3TpecNKT4fuYAy
 cqp1iFfsO+z7Nl2lUQV1Ag98nUJeVMr3CCznjbqf/irrb8Inp4+2YwBRSrZNmWLTQloWbzA1cQM
 JqRel7DSpDNXPGcAl9H+74wIA7qHoqU85ANOZyigiMC1dOlvTgIVkOL9ZxDcIUs+pOnxKhVDA7g
 tXfH++nPzwmDRdxVqyYoEA6e3pJjjBRf1zBf4Ycwj2UMFPqruxU5oatfTxOeaQAFgb0M8z9wZSn
 gznTCzYkAG6+4gpiTMySRXT5Isr0M+MyJKrLW5Gn1LWHFUXzIBf04dxr45s9NPwhwf9gjo5IEpa
 OGqCdNpt1t37fhXkC48/OCKu8u5f/Gk/7q+df6hnQ37SpI0RnNhBjtk/9xyP41QCEco3nm0VmBF
 bxAE9jlM+YAFA9Jp7zQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090122
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

On Thu, Jul 09, 2026 at 01:51:13PM +0200, Maxime Ripard wrote:
> The plane reset implementation creates a custom state
> subclass, but only initializes a pristine state without resetting any
> hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
> 
> The conversion was done using the following Coccinelle semantic patch:
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


Ack to merge it through drm-misc

-- 
With best wishes
Dmitry
