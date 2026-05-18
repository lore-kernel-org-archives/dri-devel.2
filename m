Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07369CD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0619310E9BF;
	Mon, 18 May 2026 19:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XP4jn4lZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F67SI+Jw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190EF10E9D7
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:31 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64ICLCDs1890433
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Xuhe6ygR1yI
 ktoZp9sFxJLTtkjCvrYy2WoD60aoQU8w=; b=XP4jn4lZg0eGMGnb3Q1Oan5wdhV
 cTt8vbwIl28me/s/cNJQ3cUBD2vzFFFXhk3nSYcNaCvAfb1RF8lTUmbKnkapf+hq
 dTTuLcj1N37QMhBkWOyyZXXTXEsQCUsGQHD3LdXwuLPUx/J2PCyJVPArfLQRbiOP
 2ZGj8ulF4dxMO3Tf5RxbldcDo9iMHHGIEG8+Z1Jy/MJobustdyrTaRPJVw0A8pv/
 VgfwScaDiwNivBREFe/XQX92VTGWGDeMZJS9tB8ZKQYZUVP86AQYJXPSpCTjjNVi
 MdF1bvYAdbz4J1Hd4yYK/oA1dkNXIc+tuQRkvS/o6a/1YMequgrFTXK564w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82pw1k4n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b9fe2d6793so69423785ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779131310; x=1779736110;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xuhe6ygR1yIktoZp9sFxJLTtkjCvrYy2WoD60aoQU8w=;
 b=F67SI+JwKBB4n9ADSNAlxGTAKpYPhiECCa+VfslFoMv/MzqEjKXPeMOQREaW6WCvcS
 +DNbTX+UzR9DKS46sbmTEN7//d/Zr1yBcDF3DTeucs2Lgs5Jp+N5uGAo8H1tD30JDSgi
 p1r8WnsM0y37LoT1114LGwqHF1cyfDXWdfDi0J8aSJaCFLe9m4gAz8AmWlHy9A1ivjZa
 niYf7RKMnckFGwAhNw3ZHMbMoHXBYqGPmkd4OBfn2NRdj3i+Rn9kf1fhbx4um0nNIRZI
 EWuQ9lKhTzNEFq1U9sYY2dtriKbu2EA+xZfChnutG5MdE054TIs9s4Y7ZZplr5VmGrUX
 I02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779131310; x=1779736110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xuhe6ygR1yIktoZp9sFxJLTtkjCvrYy2WoD60aoQU8w=;
 b=rcGUgIkm8hKJqdXAe15KAXvGN/5e9Xx3DVry/OLWahDHZFiC37S3V0osu+jbBFtmq2
 U+Cnpxj0t+V0x4Vndk5grGlLqbQnF3eOHNjaoD9Ux00+kAApN9lt1Pu+ow9WFovQxvKh
 rK4aCKrhqCLzK58FboSx3GCp4AkGdqIqx2BfsWb93L42/gEV2GaZLa41Ry2QZlQwz9gX
 Bxs1kzM9q792vZLZtPvZG8UYRKdQiGweRKbUf2yx/8W3yEgSwjJrTbt9LHAMj8nZLHfM
 NoNdNQgpb8WD0Jq8XicXD0qYtHL0nQ9CUHxqkHy5NqfIyp7iArr5ocjCH39wXrbDQqgv
 zteQ==
X-Gm-Message-State: AOJu0Yz+lOhvNVgczKjAh1z0eUNh2nS+HCaSQ2D+nR/9EtgkqNUoHbO+
 MI3RIwm/3LxANchVh8aDDmiZLpHYmxJjBNzYgt8msL/HVruGzlcn464zMjYa5kIwKlWqzExZPys
 gFEWt0VZiep8u95T8o9KrQYOtdszgwVG3SEXTNU5iyOt0J6xXrg3o+uksVSDoNVhhgclhpWRNLZ
 UvJkM=
X-Gm-Gg: Acq92OEtnk3f/3FDOJ8t+xxE9c5o0arLdaDqmGTWtuCHJjVG0a/9PjzrLZbTAJRGsvk
 uyzUf1ZCsjCWQ9xkeEakFa8JjZgEUXdP/pmLllMAlNeTFUF2uuuzSeBGRtQCZJuhmcTgUBHQiAH
 KwpOavvD6GGfVJKY/D3L033KguVFfiAx4gKoR3DsF4OCY3jrgI3TSv7lyi5/losGtn6lwL2iy49
 uu2qG/+vKnqAetrcj0fMzg6IgZn4AAAHLcxSDv2HLY9hhuPw7iXFfa0gJ7wMvTkVtLVBom37u2W
 p/EupIst9GtQc6Dgzj4PcEa650Mouy4qQ+UQC8LgFBOfSYp9LxWUTLW++k1oBERRv/Mh0lzHYHw
 t5J9qQ0oBwhD5iWcUR7+dFcG5KRaoARJn
X-Received: by 2002:a17:903:328e:b0:2b4:5931:bc4c with SMTP id
 d9443c01a7336-2bd7e7caa36mr123418675ad.15.1779131309835; 
 Mon, 18 May 2026 12:08:29 -0700 (PDT)
X-Received: by 2002:a17:903:328e:b0:2b4:5931:bc4c with SMTP id
 d9443c01a7336-2bd7e7caa36mr123418395ad.15.1779131309401; 
 Mon, 18 May 2026 12:08:29 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d11cbdesm158941575ad.71.2026.05.18.12.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:08:29 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 14/16] drm/msm/a6xx: Increase pwrup_reglist size
Date: Mon, 18 May 2026 12:06:41 -0700
Message-ID: <20260518190735.16236-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a6AAM0SF c=1 sm=1 tr=0 ts=6a0b63ae cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=bkW2Msa_OoTtud3PmHQA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4OCBTYWx0ZWRfX2iLkqq6WNR6o
 BFu525T2VNpuR20Gc8ae7JtZeHGCn3zKIiPxUxgKs+zOCft0J1+9dgFkCijooHfjP0KeptfnpQ/
 S63UjXycBXJ/LBWwl2+eZnoezh22TVJA8GuU0JDlV5doCSHghV22NmiXVP8lP8ZuQ2ct2lalPvw
 +j0fP1xgWg4Pmq+hu8ERG8GDbmp8iIq9ilZq99oycpPY/CHzIa1GBVHBT/5mB4bCuUNgDXK2Fdb
 8whJhKYhOgv+F75l+7EaBnb6GjPvMwHKGRI1okNrlAB6nWc9q22bNeYlznC52Xb6yYX8qoNJ2H5
 T5Y6u7u4UfH8t/LBcutWgV9mth8OyRLvUfPBj5hDNPUL3/x/4Ezo5fKbLWOhyN+GejpicouELFc
 ra1ujhit5QK8SdIE4N0e3sACKXJtRqyu5dJGk5kifUP4Hg8EH6fOGXE8WuD2NiSRb7+wZiIJcwB
 Wi2dfFZGO/gAZX75CLQ==
X-Proofpoint-GUID: hB6ZP6UgJsfkJvGfiDUwL19sRAiHrtbX
X-Proofpoint-ORIG-GUID: hB6ZP6UgJsfkJvGfiDUwL19sRAiHrtbX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180188
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

To make room for appending SEL reg programming.  Without increasing the
size, we would overflow the pwrup_reglist at ~190 counters on gen8.
Or possibly fewer, considering that some gen8 counter groups also have
separate slice vs unslice SELectors.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a329d20033d7..61c6b0e781ce 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1183,7 +1183,7 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
 		msm_gem_object_set_name(a6xx_gpu->shadow_bo, "shadow");
 	}
 
-	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, PAGE_SIZE,
+	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, 2 * PAGE_SIZE,
 							 MSM_BO_WC  | MSM_BO_MAP_PRIV,
 							 gpu->vm, &a6xx_gpu->pwrup_reglist_bo,
 							 &a6xx_gpu->pwrup_reglist_iova);
-- 
2.54.0

