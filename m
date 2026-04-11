Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3998FF3ED5C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 19:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D3F10E1A4;
	Sat, 11 Apr 2026 19:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J9amTR2h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jKqjvI6N";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F4610E1A4
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 19:31:34 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B4BQ3s653112
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 19:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6jGq1cep9dDOqvyGq6eOZiEY
 7tjRsV3zKEwANXCL77Q=; b=J9amTR2hddKzv6jc7d0DH/YQer/bCrR2bOGJCcjv
 C19gaQP2oYatzCk3jqcTd1p+L3lBXBMhtCuJaSWgBtt4W5dec/axPfhoDApauU2e
 PkDY1w5aNoFx++4QiPjcNvG2nsltRKRgBfBspclRK+HzWrMwvGruTWqZEctvX7+j
 /sNORKkB6A+Lfratdz2YAKPMhnePeqs5XL2gQhiH8yTrAKnWeDeiWVTDieYlA28B
 9t0xj+e4QjgGInVj4TqD44Qe+cZbRqr3DiIHH0sdmgWyWhS4ct12mvCm+0xGjMVs
 wF8o/FIFP61yPyKDpXzYJHUCjn0hDqcO+vZvc9l3DCGxfQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff2b98s0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 19:31:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b6f869676so59442621cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775935893; x=1776540693;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6jGq1cep9dDOqvyGq6eOZiEY7tjRsV3zKEwANXCL77Q=;
 b=jKqjvI6Nk4DOwcqwGqWkJDEyGFlfFY6DNR/iN6cGDTrHU+qKJ8B+Le9W1smSXwskTG
 OkOmo1mBUD4PURvlhHKLe5via5IypNjRaJPjeMGY/lSkefzeorzyMCh0wLnW2mZGKcVd
 aJelJHCvst9kG19DM7/Knd4tozysMgB2o7+X3K6B04IYHJZ6a4yMQJY+OTb15bfTtRag
 TpNImQ3r1zhfk3eHU4VB8JC/hj+vtiRvPxgk0uNrAogWB/cLTtRhvizg2MhNFESEYcp0
 UEsQ2jG+XoYpcmjbvS4UixJmhzGE9oSEed0popLcXlqpEOEjmakY8oKMAxIN8HsTIIx4
 OsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775935893; x=1776540693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6jGq1cep9dDOqvyGq6eOZiEY7tjRsV3zKEwANXCL77Q=;
 b=hfTOZYrHHGUgb8UbASBinGUrFQVGR2fS9qnjDgstQSPdN3yPTnj0XYhOaD+5R2LrcY
 /v7dkGGfYozNQc378+/I6rgkCxuj6Hy6c6QG12aeh8AxYQTritBY+PlSF35r91Ea9H/9
 8D0ytVzNtBl1rqUtgQxYG0FmXvvAooXoKDcfT9xIxeg1hMUWjgDbZvtTkg6YtlEQQeFv
 OIi0XFnP1onMqGRdPyu1kW4i+krhtP+zKSe/AHUxhDNuvpUmdd38E3TDEnrkyPyYh6Q/
 tWoTmoMpH45p6MZHQV5cJUIc+ZCOQYtEs8A4dT4CDYBUM7Qc+ywTf7OkDVCjyryDMzp/
 nDvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF2o0b4geXuaPVBpHLdHhMLVOsYJN7BQAGdnACZT04NjEau+8a9CSzoG/mmgohZyGjZwVXaYrgCac=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSrX5qAo/Uf3BlAZV9c9UWheUN0wQNQrq0fFkTpqk4FuO7SDdV
 S/yO/Z0GXI8G412IlOmNvxfusdy+Us1qnQuqa6e1IllrmFJmoSojCyfWvWtfSKAGiJrrk7np6BH
 aPaVfZjPBR/NLAEfxfodV5dgNL5NliMcCdoXq0YUuneu0y6Ejt+yQnaYPzLhQJnowBbxPaic=
X-Gm-Gg: AeBDieuNFCx8FDctTcyaDm8FqCy16nZ2dqxoilpl7Z/2wp3l/AkUeNfIN0NhlTsm+Dr
 B8HsPhclHdfXFOR23h878ti9x0vO482EMKbcTk1jwUmXrbpJhCH0V8BsNf4jMjOqQ1tcHbhOCI4
 /X3xto9IX7sn/cL3I4gcg++X5Ylz9mMgAexWzCdblZ2N+Dqiw97alZi/I2AOeFTgcjgXYR7XSAb
 js7T6lmZbw/bqA5f9ZEAEfdT0oCEpEsx0R3JYyXGYUXRNhKLdkEGzgK3YeWnP3O3gDQEbMObqf/
 SOETW1+Bs4pPRcD3HZ8YjcF458Xa4lMhv2dfC/Gg2On2VKbKEuidfSrRdVWwujO6CNhs/vc7Rhc
 w6U4mAD+Ug9klBsA4JFjDrVDXxyqTIDLR8RCokHhNiNMsmoUKj56VLsqiiLMzvbAtQY7EI2rm4R
 H0DBR227eU2ZMdVKDMOQss8eYfTw0w17AXjQI=
X-Received: by 2002:ac8:5f54:0:b0:509:2858:3c63 with SMTP id
 d75a77b69052e-50dd5add6c7mr120692881cf.23.1775935892850; 
 Sat, 11 Apr 2026 12:31:32 -0700 (PDT)
X-Received: by 2002:ac8:5f54:0:b0:509:2858:3c63 with SMTP id
 d75a77b69052e-50dd5add6c7mr120692591cf.23.1775935892426; 
 Sat, 11 Apr 2026 12:31:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeef3620sm1572151e87.57.2026.04.11.12.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 12:31:31 -0700 (PDT)
Date: Sat, 11 Apr 2026 22:31:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 32/39] drm/msm/dpu: initialize encoders per stream for
 DP MST
Message-ID: <jkzpb7qb3uqr4f2zs3tkerxsciwtsx645zmktuhxrbni36auwn@hpeqy7jqhc4l>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-32-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-32-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE3NSBTYWx0ZWRfX31uKuHf2WMbv
 X9grTdXE4r9BIh6ISuduAmSoQYKgo5Hbsdct/ck3FRjoEGmMlEY1WWpeOvGXnCJ8Ytjy5n3gzt1
 FvRRswmV0mRqEvHzTr39f9s+SkY01SRtyo4GKJC02L05h1BUuZa7d6AhHNhEjDrcT0auMCvz9c0
 kcQODECf1h0k2MUk545jzSMqNYA9LeRNYhz8WkHD/SISgO06YBKAUjwUuAnChNFVykSXxIEvvBZ
 jVzaasaqUiRdRWbP4FMUqoE1nBBijlipcfP7DKo8bD+ZP/GDuAwz90qtS2Gmz4p0BovFgLiBiqs
 mlVBIcMQsEJZHTQis5LTDryI2vcTjPznENB4rEjZDtfotNVF28irtwJVwFdZeKZ4YohqTHxwd/y
 v3fMWvXGZ7ScjExn8qL6MyGyIS8iVnm8lPdDDM9eMrI/9+GsEganjak4OPU3US8HylIVDSF5p08
 766pt88N/coerWO3kCw==
X-Proofpoint-GUID: SPLLgc0gu2Ts8BvVIbL9sxVRnFWTFaod
X-Proofpoint-ORIG-GUID: SPLLgc0gu2Ts8BvVIbL9sxVRnFWTFaod
X-Authority-Analysis: v=2.4 cv=W4gIkxWk c=1 sm=1 tr=0 ts=69daa195 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=VXUz8XiNEC3FGRHiCkkA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110175
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

On Fri, Apr 10, 2026 at 05:34:07PM +0800, Yongxing Mou wrote:
> Simply initialize MST encoders for MST-capable DP controllers, and
> introduce msm_dp_get_mst_max_stream to query MST streams.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 14 +++++++++++++-
>  drivers/gpu/drm/msm/msm_drv.h           |  7 ++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
