Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FCCCD98DE
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53AF310E516;
	Tue, 16 Jun 2026 00:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LA9/oC2S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X+c4BANJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41FD10E516
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:56:59 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0Nx1N091274
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1kbaM76E9XIMD3rRvXUXjCdg
 vz/AxED9u3Llq8yAVaY=; b=LA9/oC2SG+bp/2vSC+T5fzx9421r2DAAaLl7vYxz
 5gVHBtNNd61dUXxs+P2hgXdQKwhII/PoVX9+LOmFK2TACn0bv3phWGb9O2G1tSFu
 0XKm98eBi5wBxbGMv8NnmJcXsN/FCMmNEKxK9jKd+qjreQJ6IIhL8nRbon8fvdvz
 FWtK6yg1qIIDlB1xOI4IxB0u6/I/Jdjna/QcrjRtOlui2t0vwfV+S429YTzNiiuK
 tGPx/9CgYRamLstltjtBA6crY3Wi+5zdSqF5fDk0OJwD9wEZxer6xX6WR26ZUnDH
 SWkQO5fvFF2aqg/RGrVZXaDVR5kKdPPLVw1GdMniOg+o9A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete9840jh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:56:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157f1be083so681826785a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781571418; x=1782176218;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1kbaM76E9XIMD3rRvXUXjCdgvz/AxED9u3Llq8yAVaY=;
 b=X+c4BANJlcq0nbWhwhZMM+VYjKZ7XJMetnS0LBT1kd0CypYZNQk54MStvgXtSiV6MA
 1yqgKxAvXjP4A+fWc51a1fxoFJCHo0UR8zoN0ftE5RVFdlTphfid2tjNfEuOW7gNN1Hg
 YBAsUvvzrYsV8GCwRg0jLxDus/R9wSvlm2vvXzS3ojZA/qxsR+cx7K7kOmkF3Ga9i9J6
 07AfS/9e62aOljftbg2idyC54Sz2BL5/OezPIEvoXZh1WE6Pe6X0eJ0BcKk3z3Qjbm56
 nhIJA3Eg7zCOxhA0Bncti2PnJWSs0zR81rny/THJbeBc+qIknYE5bTYf69BwlPxOI4BD
 I7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781571418; x=1782176218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1kbaM76E9XIMD3rRvXUXjCdgvz/AxED9u3Llq8yAVaY=;
 b=kGyi6tahDD8owTsje3Kmr4ReiyRJI6n0rakPcz8ZOXMZN5iJ5bTYjOB8uSMBibPLrr
 7RnYTDmqdU6wyTUsohvJNUMUQ6Y3txL7fLy6BC7DEVYqcbl+SJilM/HaZ1Zh0W3yTU1+
 r9yOJvvo1os5FUVsbjjLzIBrdj5ek2jnnbMVPlOBT7shIEdq46OFMqSR4q6y14YgZYdZ
 s0OHVJDFR3qPzCyDwE9HucDxEsMiTQAuVPrlVPQdTpvoglfpVagSzZ8mrziv4RqQKjP4
 ZlB21MFVxWsDalDyhA9JX5Jfzc9LPKe3oBccD78PusNOdb/8O8XjDSeCswRZ1aVN/gKv
 aXiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3kmvuV/lQU0DDkoue1CppMO4ueXW3DKiULVcskwVNopOJv8Ydar1/gBazMwick1rRAU6mm72R7Z4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzOVm+a4wh9KP5r+A+n0LJftKvRBPF8jPLN2gNHlsFMGRuv1JE
 qKf89idcldwz1Cv6/rqimBBOYP0qJOO25/pN4qx5b1xyn5GtYXBjnqUuty03+931lc0tlB048Yy
 nsCpGDf2XCRJwKX+GR05G7IPMFBXqruQH9iqiRRFvp7y4/RHaVw8GXQkBcDX/wMgs6Mqjl9Y=
X-Gm-Gg: Acq92OG5rOCaV/ey3k1trS/i0YJFpGXVW0GHreTrxb/PN76CMEaL/plpFsMFrRMojcC
 6dnmkVcCMKvPIe47MVdbnwMK8O4EeTJ43pptrKTeaA+kugCDRX1gQGksYg/ynZgM64CtdU3Mh8p
 zpVVwSsVvFFWPqawRgqrmWFwVzgYl3PQZDSpHFGR62Cb/2KHduEDTfVTrHsBRDA8t+4x403HoPf
 NwPQRC69cCov1epuD+SjGnKyWQ7MYVZJ6ZJflFaVS6wR7Xcyan4e4Xt7eMayZ15JuWJxlZaMNYS
 m/4glvywLJ+7YREAQ5/PTwigb+Q1xaOsyrYv3Vo6ulzXZS7bBPBUgE0ida1ge+zHdyzWZ74CyqV
 NSk6V65AaCpdWQ77FiYW4V+AZ22hm3iGRJQRb5pXHo3W7MyrssB6OwXKD6R7FGKKEqkIgBAgjyb
 i04zcZvR0f2qgmYzuon7QYb2vZUVFbnldzsrU=
X-Received: by 2002:a05:620a:258f:b0:915:d5cd:8ce5 with SMTP id
 af79cd13be357-91c24579d0cmr350393285a.20.1781571418321; 
 Mon, 15 Jun 2026 17:56:58 -0700 (PDT)
X-Received: by 2002:a05:620a:258f:b0:915:d5cd:8ce5 with SMTP id
 af79cd13be357-91c24579d0cmr350389685a.20.1781571417856; 
 Mon, 15 Jun 2026 17:56:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad3d51f20fsm925671e87.61.2026.06.15.17.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 17:56:55 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:56:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] drm/msm/adreno: Add support for A704 GPU
Message-ID: <yldxcxtrdgsh7c5s5llnoobdmgnass6spyty6mg6yfvcrype7j@xhgga6vafd7n>
References: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
 <20260615-shikra-gpu-v2-2-2f2d1347c3fb@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-shikra-gpu-v2-2-2f2d1347c3fb@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a309f5b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=EcFSykfY_HSBU6426B8A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: P65RAuYbnFsJb-r1XUsyXHKtMtwhwPPb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfX8TQWVvDOo1ud
 D20DMKb7YD4CAAlJur5IQbyYPTby/jJ7420vDuWunRKj8b4zfWxYa2zYcws5maeWl30brhBodAW
 mXnhpdiT23L3puH4kNxXQC+aQ2M+6/Q=
X-Proofpoint-ORIG-GUID: P65RAuYbnFsJb-r1XUsyXHKtMtwhwPPb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfXwoHROoxsaRbr
 cdB5u1kRQaUwD0Vpr5EWA0aCTO2OrjaeMQok+3BZ/u44jYDR0U1wFvQjJsJnnOEzYOyvC4ZIXSL
 10RmSuKnvPvMr31VqhlEwghSUyMK89zASo2Np3KFcxVuu9M5nR2mPcjEFyrPn1d/46HT4/NtKE0
 8gLs8n5mR1EthskbZ8Pomz4ehMLYdv/tK8i62skNhOAjhFZmxFxKGAtf/1/MWtmSwaigR4kXJHI
 XoHY90ME3NvQep//pY0hMXGsFjQLgECs+RqmkJespUp8akOrAlxo+7i/HOSfX9YlOsXDhh/lhoz
 0dlZZIm3vn0Lbf3dAZtGgnjF6g906FWE5Cg34EzOAYlgL9c4LBzURo80N9ewPsaf571Gsf8zSJj
 /wghK4kGLM4low1CFKlB9IdK+qjMCAvQjxntvIwN+dk9s7NnO26dwoYbFU+WsMFDMhtBt7Rroli
 VQd8RcQvg3cXg1Ds6Ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160006
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

On Mon, Jun 15, 2026 at 03:02:58AM +0530, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very
> minimal changes. The only KMD facing difference is the chipid and the
> zap firmware which is specified via devicetree.
> 
> Just add the new chipid to enable support for A704 GPU in Shikra.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
