Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AF7CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 12:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EED10E764;
	Sat,  6 Jun 2026 12:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ltTRNdpT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ONLZWxXP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3CE10E768
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 12:05:41 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656BHQ6F1312318
 for <dri-devel@lists.freedesktop.org>; Sat, 6 Jun 2026 12:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Tmm2Ib328Lw866l3mCyo24He
 LhB15UJSVOLP+VxiaI8=; b=ltTRNdpT4H5vFoQlpGbxx3tFrPcRX1KiDpm+72ie
 W+XCaR/uxH6FlpwayUAl0/WdR+U8GcW6al1govbweOSp5Cm1/U6LKa09q2Rp+k47
 4GxpsjBVk8Z3yc3xpJLV070id37IK5yZStO7fYH7SZgqCGhCviI+klD6L8vhdcdN
 ETjfojqjPwMlzJ8vF9EZH94eM6n2oFKF3cQEcZsZ2KB9miyuS0BpBtvk/Blq6zUE
 WQ3RsEeO1guf6UdZibEUo58RWVmk62RNWsB7EwzjRenLI8NlsXnighVhP55aw1Lk
 Noe26GDRbL2v0GE0kY9jeAd3FRHiDA9gWJ4ueYfYLeSUdw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w15ar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:05:39 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-963c12f125aso3192614241.3
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780747539; x=1781352339;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tmm2Ib328Lw866l3mCyo24HeLhB15UJSVOLP+VxiaI8=;
 b=ONLZWxXPGH3tSj42NAbVlyUTff+TUWmOZt6Ou+sYXxSWj4cy4j5lKSVqFQFYtGvcZA
 uq3cIbm+fUmGHMdLOix66VAw+7TK8gpNnoIt/YVOc6wZeh5LI67IU7HW/fnWueqAlgLh
 51Ivir3MxqkPCV42hwM2PEubrsIBllycYwYetuqTrq35NRYQ2HuA8/5oOHysJ59Yr6XE
 tc4GLmONUw9M3QvmGOk9t9KRt4gpXIkp9AL/QqjcjaOWUjGGLUBt2Q5unqRBzRyFKJxU
 KTnW1sohpTOJUzdCKO2p/sXxX3+cSZLw94e4SvpGVEm5qUm6jj5SFBYqtQ8FuBajD5+/
 uBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780747539; x=1781352339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tmm2Ib328Lw866l3mCyo24HeLhB15UJSVOLP+VxiaI8=;
 b=dNF3OqG9jpCBkTCML/MaUY27Ok3yVDP48NxP+ESRJjRUIr/sh8WwSMGDe+MTUtjE2o
 wCWQyXx0vldoQSNJRRBjzBhWToZu3iHkLsYe3WigR3Tg5y3ft8AbexnmYZNoD7xTWXRs
 eQKlbfdLG8KAKtY+oZpaSOxjoVSkic2E59P34FImCRTXJh3vrubcnCzp1o+7e/4lYJ+h
 EUs6Vdu9YLEbYd7a7bdJjJy3qjgjd86UcWzTW/cPYC96NbATUK1lupdSFLMe6CoIapom
 jIFH7Ihc28C12jT5YxD0rajcDkkrKs6MV22qj6FPTqVEvDcAZ2PKX7JGslNtHDx2YwkQ
 +oHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oWhjeu9NRQ7NrLMsjH29wG/3CyUB8RXpVnQkDkB4RidbytZYiZeRUlWYrz2bmguIwRqKngEprJb8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzD1SdgzXDekthqwqFsdrxMDFfm/MD1UhndNTbtm5StvcUUwYMQ
 NAykeckP5jDsxBHAx3zb400QhcpWyoKPQuxyHHuzfwI4APEaBslL2Uej/zxBKBazeEUGa70A8Lm
 i6oy+Hyu16Lj54hGSOm0CrfW7GoTczSvIke3JNuWV5mc0vHKeiDr/mZ0Mx1UTt24ifwzvAcE=
X-Gm-Gg: Acq92OGFUuoI7WxSFhiGidRXsscpA/0o1lByi8jlAcWDnJOXRBvLLjV9gCGK6ahcdvU
 /XNL59Wo3qiUOVaXNSLkU5BTsLrGMGSQYqGJHnqv0ZTFzqSHqvMkHffxoF50UwFhcZd8VGT7riL
 JiOYgoPISm9y27I6hgnx4bJsogWAtma5zkZtfOHN8uZ/iBEClzV57P68R7aGyutEc1kRJLEJLZR
 z+RGlb/NvaO/sOFVD2+bTn/By3unpUtn91zarUmg/M0rf55szlk+CenOL8UW6fX+0Q8akg31KGG
 NzyfSS+q2L315tmtYYRTsmx9w3AM1yRa0GClvHPgck1nU6uhMeinDNv8vzrjB/qHJB42S4F1uCk
 1JjY+wmyHwz2Q8syjwUPwf5AyG7Hn+eB87eWeZH1HUyWztba0sW+JyAmawLkRJjQrc9QqMqmsKj
 u+TDCgBDu2TMaFnebrXUcMngcOEeFWQGG7yQCrbOOWkIQ07w==
X-Received: by 2002:a67:e704:0:b0:631:487a:239c with SMTP id
 ada2fe7eead31-6fefc010475mr4141706137.6.1780747538992; 
 Sat, 06 Jun 2026 05:05:38 -0700 (PDT)
X-Received: by 2002:a67:e704:0:b0:631:487a:239c with SMTP id
 ada2fe7eead31-6fefc010475mr4141689137.6.1780747538686; 
 Sat, 06 Jun 2026 05:05:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b8ee219sm2445325e87.15.2026.06.06.05.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 05:05:37 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:05:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] drm/msm/a6xx: Fix A621 GPUCC register list for state
 capture
Message-ID: <tpjwkemfdjl5645dt2mmqkx3yiddptpajrhj7shiuxrwa44ort@q5ldxy6n2afb>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
 <20260605-assorted-fixes-june-v1-4-2caa04f7287c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-assorted-fixes-june-v1-4-2caa04f7287c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: mOfn01xZJlGnviaqRerpdwud8WeuJOKb
X-Proofpoint-GUID: mOfn01xZJlGnviaqRerpdwud8WeuJOKb
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a240d13 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=A5b4bb4LRbl1AOZDjEoA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDExOSBTYWx0ZWRfX84s+/W/Lb6eK
 2lTU15cly33WGdxi7yw1/E6v1sf4bqpkjh4egoXptbhIrA2nOZXO7AMjjxciC0glyqObQDfTgcu
 8u9qdkTJ42PchfyRxp46b9sqdRzkc0ijm0+vfUTFO6T5FGMMzMe3xmfT1ljUtFF9FZuiGmuO1Sj
 cOQi88Otn4M6HPSaYW/YgfOpEN6xrHPsFFEP3AZigJWcDQX9z/QfXE42WXbVQ38U/nGSSptaZfv
 o9PsidoAWwtMR571/GWzqkC64nTmqGMrAVL3MYD/yJ/DjKpii3xnOE43n4GXgqSim+g0eJSaUHi
 5QrcPKgVgEKMLOaN/ssSAHqHTcmpf8BfZeFM8ya6oElJaw1IvF0ZJv52WQwTP4iGoTYddtUWYr1
 P1BPzH3gM2MMY7sHHwWS9vIe1hqB31E7S/U96Q/zsvlwNMZFXG/djSdUd0tx859ksk3fOMC7O/S
 1un6RapvUy6yXuzOGrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060119
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

On Fri, Jun 05, 2026 at 01:38:20AM +0530, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> A621 uses an incorrect GPUCC register list during state capture.
> 
> The existing list matches A623/A663. Rename it accordingly and add a
> dedicated A621 GPUCC register list.
> 
> Fixes: 11cdb81b3c1b ("drm/msm/a6xx: Fix gpucc register block for A621")
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  7 ++++---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h | 12 ++++++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
