Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD88C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B69D310E4F4;
	Fri, 17 Jul 2026 20:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZHl6nAEW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b32ZytvC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2AFE10E4F4
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:41:59 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtMRk2989908
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hj9k/hn+4mYiUHK6HA/S0PAPXL5EHORkZMZGm7VAmsA=; b=ZHl6nAEWI3hupkUA
 RSklRR+dgpPQifepZ+uCiNbc/lwwhV9sXYZ2JsPr4nannzsEyudc3hLYcZ+dKuRI
 fsH7hrYvDaOmeHqRN1YgIx80p6Q1rdI9yjYvdZ7a2Caa4fh6CyjWvxPOeT5yDVUz
 o+sUhfF6o3IAP6Pvq5sd8se77yVU6+f6JMM6yQZFTJFbeCDZ+k2zsTVUg3HZ7YA9
 /PwO/Bm1jSfoKDJIZhaWnAQQaxb1nQgF4ZC56/+hAtxgr7QpR0nfmWdxqkUtSIfu
 pgcSIm/DOf1yW2S3XozgVCwOiUlQWF8VRSqIANpYJCMuvARJFOa0zxa3yQqytlRF
 GZzmvQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffd3aurct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:41:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so2113442a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784320918; x=1784925718;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hj9k/hn+4mYiUHK6HA/S0PAPXL5EHORkZMZGm7VAmsA=;
 b=b32ZytvClb1j1cp627OmF3YFIPDfpbHr3Qu9O1cxiAtvEVmUd9iFGQ3CNBCTMY0qkY
 Q5n9/4PnYo6kJU4aBuQFatwxqUJZCjkF0P95K01JIMrkNuvAbq6guMGEJYzpmIrIe/D8
 DWD3CPo4XMDpG2S6UQFwH+tHolV+gVFttxUzFKEA0/17E3HVb0No7K2kc8KZK6bnEXap
 9iLsx6QM07dp9c7S5AHTqxzIuLIoSB11r6jeO32KdYFXPmmMO8ow8bygOd3jLx4vwp0S
 0Wf1GvJrXjHjiJHF8vY4d7fzKnMYh8UJiVL9Pd7aEt/8OhQK4CogGvxzsGYODTa3AqNj
 w+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784320918; x=1784925718;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hj9k/hn+4mYiUHK6HA/S0PAPXL5EHORkZMZGm7VAmsA=;
 b=s+R0nwhAdJ4T31Ki8YVXgBTr2bgc7lW/Hxr2THpaBXO6Zr+WK5r10BheifgRHidqhD
 bE9XJl7vxWJfADpR4PrTnoiSC5eSiiiLBPpDWK3nMAr8BVfektOzElj51s6R/NDQnR2o
 di9/MNN211OnAVNRc5xTMD+rKFztGha3KEPz1kW+zr2iQswbAsi2PK3Xu95kF+L+JvUe
 heSlN197r2d24+5jmHujUW1g2c9/+HeKDwbV/makHZOai4yaF0XtOIQq4CACcuJL7fh/
 +4vChB6zGLwMjFpOSmsLceGpggATyv98MAj6sbQjcgEmFTsIvOVKJKdPYx/AKQsTG7pX
 hr0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHJYqU2WYO/JLYk0vH36HwmKBgdf2OB3EX1ui2rehJNhsvPpNLwipPuylNprppZLTvVGspw9bHjQM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyilcbX++DGZFsXgfbTNUQPz0b+ikKfV7kudjlJT1OkausXMlTW
 ix0XUmCYse4aR+U55ZK4PKBBmo92BWehumSeVzKvu9sRft8b9QNYviQDqn9dscbpq08ogeKv0k0
 bzh0Ak3U0Fe6ctgv8bRaFS1mj2QfXga8RKD2T1rPifQWXH1oMm8+ytuvjBGJDngHL+zt7hag=
X-Gm-Gg: AfdE7ckGvDlXHQKsCJalZtbW+fB1kCwcGt99so8s66NYykEpWmUEXTgGOvM9ZE20hjb
 tAAJFzoGIKkmjiDbpi33hNYljDoSuZC1pFQ8TZGsdW/GbZ6iGiyEbUIbsWfjN5KVsqMJ90wRkdC
 inJsojflDrngPEiM7P6KzXwEynDMJ+TENmbIalq+TTcTT7vxzhGFirmcCj+LY453dnFw4xpVPAO
 sUASy9yNHMbsx8T0bJQLN197eay9qb5oP+M9LQ86X5RBMtwjse2KJ4MKDT6a4NPf87Vzq1PxzbC
 +1l8Pw0OQQOK4F7UkpvLUCrq8vDseZrtWKB8ip25h00an+b+kHQn5MT9ZKeesUiF9zBHb/fsqrE
 5Q5qREQ3fyqnAo74eppd1niYz
X-Received: by 2002:a17:90b:4c8e:b0:38d:a8be:a592 with SMTP id
 98e67ed59e1d1-38e4b43cccamr3944726a91.19.1784320918458; 
 Fri, 17 Jul 2026 13:41:58 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8e:b0:38d:a8be:a592 with SMTP id
 98e67ed59e1d1-38e4b43cccamr3944683a91.19.1784320917831; 
 Fri, 17 Jul 2026 13:41:57 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:41:56 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:26 +0530
Subject: [PATCH v2 1/9] drm/msm/a6xx: Fix RBBM_CLOCK_CNTL3_TP0 value in
 a730_hwcg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-1-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=1299;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=7exucDpQz56UUOX/GS72C0Nnz1GCp2aiTngaIPcMmkY=;
 b=59JZ+AiPbO7Um2ErH7yj1zS6z8HAFQqgcXTIpwOre8CaO2cTECbjzx98rAS+Oug8orhhgR49a
 K3NAhQOAEYCBdkiHjRWR8HaW5ARAVWD3vALuGFL4Nw0BCXXBQAVBjGF
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfXzSK3OAM+6abr
 rcuH9MwYt42QzS34BCQLcKGgH2mvAbaWS5//NLIhzJdYQEkQC6DrBoemlkbKMi0mO4TD+KglZIi
 bJ7en4XQ4ANpqRKq0jgZjsS4b0bj2H8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX6oEV9AzWG5SE
 yiLZ3m2YC/pkG1HPEmCAxsG4La2sgs0ZJZxJ7FQeGAMyZzpOl17qzziZO5lQhp7j3inj83PPaLe
 0Gk0ofex9l9XBxsAg4AHB/lbXROw6aPSxqkHnIW/1ak4ov8W4qnvaNQHls1WK82A/oXH+78UCjh
 sYMgaZW0h2rqlraC5SWPepm26jchssMJA6rQZ1eymc94ocJa2pQGZ0eWrw89DiZl8+x+wADRrSF
 FIsOn6nvdrwg2VtDtGUXxTl4Y7vuX2Zpddvc5NrdiD6XW9i0ttg/8wpWv+ozjO5ZHneyT6qL0HT
 fa8ICdiWwCNGMQ2I+PdtYDJHZwUNw+8TFtxrivxR+sRexFNzDD/n0SgCuylD5MyR8T98u3PcSfp
 vyNAtpymp4TX8GVoZpcMgUGEMr/XmVzW4H67c+EmEmmNBJ0EbfVh5xPRmnpYeYyJLT9a+SAg9K4
 ieV4U0biNyoNMauzrLw==
X-Proofpoint-GUID: KbLbgioMRYgVMiHGrYPOcxtb0mFrF7Jr
X-Proofpoint-ORIG-GUID: KbLbgioMRYgVMiHGrYPOcxtb0mFrF7Jr
X-Authority-Analysis: v=2.4 cv=e/M2j6p/ c=1 sm=1 tr=0 ts=6a5a9397 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Vf0ozLlH3VOCCO7dkaEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170212
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

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

The RBBM_CLOCK_CNTL3_TP0 entry in a730_hwcg has bits[19:16] set to 2
(clock gating enabled for that TP0 stage). As per the latest
recommendation, clear this nibble to disable clock gating for this
particular stage.

Fixes: 9588d2f860a4 ("drm/msm/a6xx: Add A730 support")
Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 3e6f409d13a2..a98d550b72d0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1199,7 +1199,7 @@ static const struct adreno_reglist a730_hwcg[] = {
 	{ REG_A6XX_RBBM_CLOCK_DELAY_SP0, 0x00000080 },
 	{ REG_A6XX_RBBM_CLOCK_CNTL_TP0, 0x22222220 },
 	{ REG_A6XX_RBBM_CLOCK_CNTL2_TP0, 0x22222222 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22220222 },
 	{ REG_A6XX_RBBM_CLOCK_CNTL4_TP0, 0x00222222 },
 	{ REG_A6XX_RBBM_CLOCK_HYST_TP0, 0x77777777 },
 	{ REG_A6XX_RBBM_CLOCK_HYST2_TP0, 0x77777777 },

-- 
2.54.0

