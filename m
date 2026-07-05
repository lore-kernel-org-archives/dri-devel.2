Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F8CC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E3510E14B;
	Sun,  5 Jul 2026 08:14:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X9dTxtoQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gPXw87az";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27DE110E14B
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:14:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664M0orX4002650
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qot1YLP4Qw62VVQl33YtNMriD45vwXzabf/W6bmpClc=; b=X9dTxtoQsWPjTwA5
 Gj50OTqt/zygM17ti3yhh7M3q02i2+/8io4M/dCZWKo8aDCDbJFY5L/6IXNX2FtX
 sJ1GN/oXfqwAOrhE2Vv1azlgdptslqSW6CDfwwhWzEtDUKRRNWfACP485i2RDt7M
 HCiCnfm6A82Qix9OrxwmJhAoOQ1ZkGVQJQPaLn6kmdtnMNoXcjqSk/jgt3zgPTFp
 yF3F/SWTe3k+hCZcLnPHb7P+kyBpq92NIfUaY2YND+as39H7W9QTNw+GFpiFBODU
 mK/j76efBSjNZyKLMXsKvt7gXvPupnQYXWn3/ZKgBGUr9iD7HTIvTKawfHZAFp0y
 nzXvLg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txej88w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:14:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-381250979d5so1766102a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783239284; x=1783844084;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qot1YLP4Qw62VVQl33YtNMriD45vwXzabf/W6bmpClc=;
 b=gPXw87azzMTMRj79khchuaGJU2EsDrlQDhCJcozvt9+tTkpQl8nq1QC2q/ComGp1D8
 EQLvWrUX6WWMyp3WmDcgIfLBK8HodXxi8/K7k8vMgpETuTrslgeE7NiB7etg8GZZSVgL
 DWHY9EwuQz5jAvrftoq9Qc9s9W8655N8sJjQ2zM/8PKbShM3b3IfdKkxNNb/vXn0TTbe
 FkqcyDsiIIndd5In7mkzFbyaQmK4IEOaDc3SpcDe4Y8J4uu16MWhpAu6FrmTK59xz/A+
 nXh+N/0XlPwWSddep9mKnzAXc3LIpY+tJ1M9p7pSapJm7lSiucbZHKnpVtvIffgkqxeq
 geNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783239284; x=1783844084;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qot1YLP4Qw62VVQl33YtNMriD45vwXzabf/W6bmpClc=;
 b=CvxZkWTlAM9RAfceujJLk4/465RPM7fqT0/R2kiqN3FtpLoZxoG7OYpZiG9Z0U/l4f
 QR1F35lAs0MJK1zuVHR39YDelyHDN5Wpg7h7qqyVDA4OK93zx5pTxBUfOUozdNx/nEqH
 rT+aftqHpycCNxD7REcSNi0Vdrl/bhRdVJXfO69zgWwLXVpSgxEL7Q181DnTRtB82ppD
 hQjixk05BUU0jR4/5/u7GPNXq4WOFXIhCsUOv/gcmHBoXXVgpkof0p3rIfL1XgvgUplX
 m3ZZqVM2PkGW/kGZNYL3nx7affp9+RRnilFqYexCpjMav1rbo5hQtmg2ax8bi7OiVuzt
 Mh/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RroRL4VUO8LpGnv8pF5vZEfG6t7z5BnOr6/ALjziZGq153i8PyfoTQjqApNFYWkcmaWwOBqhpcsFGY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYKqMSdKAdCDhZ6uhPxYnWfw9Sk2TQfjSvHwxSDI5X+tm5B9Vn
 ga7yLsqX0PJ0vHFNqLcPKuItUDxngDaL1/Btd3VKKC643D+5kQ5uZQryoPMZurRhu837DJfe2ly
 ZvH9yNzC+80AYB41mDdDK8oJ8+Y9MerLfiXwU4e9lgBAElnSxX2MAdG23nyipKULDqtWy7w4=
X-Gm-Gg: AfdE7cn7gDSyfeo8RxaY972W4g6LlFe3A9tjrmApAF7G1tsxwsDZ/eCA1LisepNGiHu
 S1UwigsxyUvTnAj6N9JPLJicxaymygOnLptBwyCGpXyWa+Gkqa7CtndBuxTUWi2/+hOjOAj1BbW
 GYgteB8lJn0nDdasnQ+ksD9ZErnWvVtheV1xeTfxwlQriSHm4+M62Ua020AOejOPRuObuhARkXs
 jVsjK9je6KMEpf8eXA+Z7FpmeNVeKWCik4f7xuWFSkLvdPbvkvmAVJdNU+CI69z3fqFJheS4kpC
 OB+NdL5igAd5HLoOww/iQHzQcwEkMal3JVmU2OKdGEPFtUrc+5m2XgjQgk+xwHudn2feSqVz/jX
 CCX7UsHOY9eql2KltzUSul2ParWVGRnDmrqA=
X-Received: by 2002:a17:902:e74f:b0:2ca:ce92:6e44 with SMTP id
 d9443c01a7336-2cb97e58139mr61841995ad.8.1783239283823; 
 Sun, 05 Jul 2026 01:14:43 -0700 (PDT)
X-Received: by 2002:a17:902:e74f:b0:2ca:ce92:6e44 with SMTP id
 d9443c01a7336-2cb97e58139mr61841665ad.8.1783239283335; 
 Sun, 05 Jul 2026 01:14:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:14:42 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:16 +0530
Subject: [PATCH 1/8] drm/msm/a6xx: Fix RBBM_CLOCK_CNTL3_TP0 value in a730_hwcg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-1-c9f1354dbd29@oss.qualcomm.com>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=1238;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=OoP30nq6efDw/gDTU4tVQRkvylV9nMkq0P7LwxjPzqc=;
 b=K2483gwyhqLi/J7WvjgvqDh88wJZPkPUhmFw5qcCp573LO6/H7fw5XIN7fLqLBDMer82FPplk
 Q5nk2eUH9PNBHF7RtP14pDCYSjIh5szSJQLeY2X1ovfJKHH8/UCoysZ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MyBTYWx0ZWRfX1xxPuZCSD7uC
 Z2JkjjxllH7LkshEnIo+BKikAH/2u2xCtX7E0f1Z+ezVTWISw0MSqL22jvyMBH8MAp612TY4J7e
 wHYSfBzmJ1eOAA9nNQH7G+Gsl2IEj6Q=
X-Proofpoint-GUID: S1y9JG6oLypg-MUJiHCIiyVPW17nI_wC
X-Proofpoint-ORIG-GUID: S1y9JG6oLypg-MUJiHCIiyVPW17nI_wC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MyBTYWx0ZWRfX+fSph90ruWN9
 tiOs6cFbU7EJLHfxoGqYvnUtwqgwVgD8wLQCEq4plOW9oXhEycFC/eXADrho1OOKReUMz9L40/D
 P+jxlHvkA8ke9RrxJXfHGG68n+Cwhh/Xbenh//Wyd6pk+zfRAq6QScDi0/PNXnx/di3A96u70WV
 jwopYRpyS2idDoO8HQfwlwfmZqKsSAlpdS+/sVJrnbIowqD0kQEnBVlLhzry9pRKvR+/VCGjX5w
 YldrgetamxKi5960soGkAbeISd3YfzfQ6Q6z//Tut5qX1060Pv9RfCeTlUi/uktPUqoHeLCO8vh
 KlXl935xNQ2RF/iacoBb2lRCWKyLZMBkCvyZMkJ+GeHllTIWL/1y7Nzk7iKeb3ns+kJPpfhK1++
 sDf8YsTthvkfv/OPPLrXqpFiDKwFPOK2TVfUeSEwVazH2F00a4c669EghB2Frrbnb6PAuArnmUY
 jKjBIKiTbO7ZXGr2DRA==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4a1274 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Vf0ozLlH3VOCCO7dkaEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050083
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

