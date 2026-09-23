Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84927C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D851E10E87B;
	Wed, 23 Sep 2026 10:26:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NZgtCUu1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B63a619/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C7010E87B
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:35 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA2gDF2429446
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wl+seacDctymxAQmXB69/Ucgp0LZ7i+ElrITf9m6VG0=; b=NZgtCUu1PCoyQKbz
 mX3quHrDMUF3vtrKFl6d310tCNd4TZ8o73iFJEjIhySeYNaqNGK8u7mMB0rLBepd
 /1QfPuPCU2uQ8ZLGOoH4QUhQVMESPPlLp3dY3Kl10mZnMzzsR5AX3THQsqq5Ks7w
 107dqrziU6yvERsIP6qT+5C3sFGx7TGFy2/gYyIBBIE25icccrHUMXm68Zqp9Xkw
 OXOSiArSq+zLdo7u6fQoktemYO9gy7LE1qxFYxusk1rwdbBKpZ+979i8Cjffi9N+
 7MoAFP1MxyVLbeQJtVbzaVD8c4K1g93xpWbN3H5umj9e/2DWGyRfcHrs5nginM1U
 oALdyQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv9bqh21y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:34 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-144f706e063so543765c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159194; x=1790763994;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wl+seacDctymxAQmXB69/Ucgp0LZ7i+ElrITf9m6VG0=;
 b=B63a619/fc9L3bzzKtQlspXwGr80n4JFp0Uh15AC4e3AIaY/BJs46J2mR8iASPST6Q
 a+3i+KMiPaHe13PExwcKZx/SS8ZIkwU/UDMVQlBG+/2lQyIsHIHs5BnVF3f7apsg54bc
 kmnIcBXdggzSy7tN1OHHqmRdCr7ocWEAcvoZqIwCLQaq7nN3qEoywZijRbLJ7KZ8GmS+
 Myl6WMz8QHUEIK97IApYpQkTEnpotRPGaYczC3oiSQEjIXZYFrHnuAoaIdBw0hJyxs4P
 rebPeQ10wfrqv/JHBZNpK4uE4nqIsQPPEt9fZe73VIf9y6pL4drTOG62jDS2DE/9vGqu
 PvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159194; x=1790763994;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wl+seacDctymxAQmXB69/Ucgp0LZ7i+ElrITf9m6VG0=;
 b=oEQgAgcDJ3eFsN7tOGZqXUz6iPOrIt2P9zIaGzNOLUkeY6TTUeHfYyulkNElFR0Ts9
 UqeTzydjoB2509WHDvoixz0KBRLiXZTozE3LaOef0Lalurr82pU2SRkyzDmQ92CMCbiJ
 iAaLWrQXXzUyToc+OUt3seF01oItTStB/pONpqgSBY/60T8tXSCE9a0LHmmF8qo8j/m2
 Cjs7dfFX8mmxKXriNT7JDz2r0Ep81MF5pmY1vveOBTVOTwuKaQvrI0m5Og+yVfDeYDkC
 km8RVGCDA6fOL/7eGpSV/9WwJKpEpmQwZMNFO0zd+rBAzJlUOFsPZpfnTs5mbtwCzdcb
 H+Zw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBedEqTkpltatVOQrDY5ulyuC2PBVZHEuW5viLm+iZi+ZxIPgnN/1vtvrA6yuihEFkrZPIv5WoVtQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nnenRurSAnTkkFUeqHvCE+n7MijR4219QzED/FMcXjVbqbJXoz
 hyZZ7xNAX1Wy8E+XLwBjPGPulib5kXHOv1tXL7E6CCnjElZ4EBAqSSonom4c7yfq/IZm/NiWphF
 /qpKT14z3EnohkwTVEjWTo+e7dORkuQWc6FmXt21v8xgRvvfcXcqM6qyOdpdHDZQGqgBtNNg=
X-Gm-Gg: AYBFou39aRFeHl4Cl4MpzpTPwRKUdy10cljdXXkNvdYAC2crk5mxrHDOqFAbo20bsNw
 Htt3SbppcOl5pN1j2K8SzKm2uOIsM0J8Mu6BqOfcOQHegmoiCV6Vi6N13elG48+IlGq7UgTuqNY
 AIOB76iHb5Ua5l1eSPquHaSeDXd/VBkALh7fTjDEdqvQDaWgFmr+1VPsUEe1hoX1hhraaEzwac4
 Wz08P1BZiXIkVvxTFApJVBM50+kzvJ8uL7quef/3O/EByX3nNxAxW0jBv6Btakt+qG/zBjFy/XV
 6XIVT3+3RnGHWKQDyCGvwJzURYr2f7D7cqcyKWpPvRZC9PyaN8VTM/zxORJ2NypUKcbkRPm7Bip
 NlFxVOj4RqGdZEbGHne/PhxSIUpERBkPdjA==
X-Received: by 2002:a05:7022:f90b:b0:136:4bbe:9524 with SMTP id
 a92af1059eb24-144ef0be192mr2107192c88.10.1790159193670; 
 Wed, 23 Sep 2026 03:26:33 -0700 (PDT)
X-Received: by 2002:a05:7022:f90b:b0:136:4bbe:9524 with SMTP id
 a92af1059eb24-144ef0be192mr2107158c88.10.1790159193036; 
 Wed, 23 Sep 2026 03:26:33 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:26:32 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:55:43 +0530
Subject: [PATCH 03/15] drm/msm/a6xx: Fix RPMH dependency votes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-gpu-v1-3-0c3c79a1a470@oss.qualcomm.com>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=1636;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=enyT8E+9AK26apYvWRrZ3yOlEE4CZOhJwCOlmwsJANs=;
 b=TM3drMHi0LUTT3rpKITA1yUMYkFSZ9baLFTe9nVutJch5tXY+aeUWa9EiMkQbSti9C6ozXpii
 JgQbn6qY5AcCZp00eIAT5DK8UQqAO2P7qIFPk3aYEhIZ26EavKJmxuP
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: QF7mUKUjBATSst2EEDqI8ulfrG_bf1f0
X-Proofpoint-ORIG-GUID: QF7mUKUjBATSst2EEDqI8ulfrG_bf1f0
X-Authority-Analysis: v=2.4 cv=WZuZ+EhX c=1 sm=1 tr=0 ts=6ab3a95a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=eKBiAfeFZ4O-hnR0X2wA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX4DpSkm3GponJ
 1Jx3r0n8xbAvRxNxjU7uOFIEDpYCshoc1mVb45q44PxTdgYKUx54MLtzwkigYUdKUCwAKnbTlq9
 foBBkaHvSYBfmXRnSTwWbGAWV3mRHUQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX7LlIQE/iTJr6
 pTl0DZpVtTkVn9a7CytzG20kw6o4p9Y6Lw5Fl3nVIjTHBxuboFVVoVMw+gxwtN1G0hrgY/cNGbh
 JlPL3A+VlybhOYx9K/v4c07xKC7t/8l6wE0+3haYl3sq2FGGeqe/AImmlLbTum3JdB69Mo7t9F8
 BO2kkoWUKi5QbZYeCFlvIzL6bC6EIrhjQFLEE2JSzop8Q02WKI3Be55dodK0GxYelabGWTD4TYh
 FG0mzrbzUnBLT7EBFzG3Nj2AmtmSvcYZA9PP0nw/+v6uuQtdcEfUu1EkrQ9n4ljP0Vv6MHGyCfl
 Te1imwTTiq1Az5b9mAEsIZSgEOQJo0FqIH3NqAoBQ5BtGu/R4oPV/tz9TxIKH6SbyQadniHkozx
 YLKp4uFCstZFfpGRjPj+YdBj5/YSlOHZdkBUhYTq4ZCPDKIxDzTyGdM5hzp7AGXTXGqWemMPN8I
 if8bFGqtq5+/JpABs6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230041
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

a6xx_gmu_rpmh_dep_votes_init() iterates the GPU frequency list
(gmu->gpu_freqs) but was passed gmu->dev to resolve each frequency to an
arc level. This results in generation of incorrect dependency votes
table. To fix this, pass gpu->pdev->dev, which owns the GPU OPP table.

Also, reorder the dependency vote init to improve clarity.

Fixes: 06cfbca0e1c6 ("drm/msm/a6xx: Share dependency vote table with GMU")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index d072646093a1..161b360bf3eb 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1868,13 +1868,13 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
 	ret = a6xx_gmu_rpmh_arc_votes_init(&gpu->pdev->dev, gmu->gx_arc_votes,
 		gmu->gpu_freqs, gmu->nr_gpu_freqs, "gfx.lvl", sec_id);
 
+	ret |= a6xx_gmu_rpmh_dep_votes_init(&gpu->pdev->dev, gmu->dep_arc_votes,
+		gmu->gpu_freqs, gmu->nr_gpu_freqs);
+
 	/* Build the CX votes */
 	ret |= a6xx_gmu_rpmh_arc_votes_init(gmu->dev, gmu->cx_arc_votes,
 		gmu->gmu_freqs, gmu->nr_gmu_freqs, "cx.lvl", "mx.lvl");
 
-	ret |= a6xx_gmu_rpmh_dep_votes_init(gmu->dev, gmu->dep_arc_votes,
-		gmu->gpu_freqs, gmu->nr_gpu_freqs);
-
 	/* Build the interconnect votes */
 	if (info->bcms && gmu->nr_gpu_bws > 1)
 		ret |= a6xx_gmu_rpmh_bw_votes_init(adreno_gpu, info, gmu);

-- 
2.55.0

