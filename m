Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2042CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51D5B1121BD;
	Wed,  3 Jun 2026 15:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FR7PSlyO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YbS9/Akr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD481121BD
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:00:24 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6539vTPW2368080
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 15:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uBhEfdW/m0+frpWlSOZbFsnd5JIPo2zwXhwrIyotka0=; b=FR7PSlyOJkWGIVkP
 s6K5xuZO8708Qske/MsZj0ohP7hQzcNJPNb20Hx54i3AeK6MWJ1LU6PTti3NXgDJ
 0R2wBcwfzbNy76tZjRzRkiIQMcmzPZDf3I+sDeMlabw9gVD4tPx0j53IFckySyXt
 9LljQR8atd5o24uTbjtFePW3cSKsUxJyDJ/mgF0fEvKo0a480VjSIljfHHeAC1Dn
 tJ0FskdFCcfF3usxaFdRegGWE0S/wZZj5q66dXsfm53CjicBEY6foMUh2NBPhUzx
 5wOpdzPs+EGPt/2x7FxbQO25m3SsQp0uN0vcOGpN9ObPB7K6S2VUQDExk4P2xfD8
 XWGtNA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejj3gh6dy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 15:00:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c858e0cbca3so2165206a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780498822; x=1781103622;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uBhEfdW/m0+frpWlSOZbFsnd5JIPo2zwXhwrIyotka0=;
 b=YbS9/Akr9Ksu5IAI39KakVn85I/YLmVwXTetaDL6fIgE5p/6EfToLxX3Zr+mZUVyUQ
 IiIW14GZluHqTKiuEgFJtdINIBRR12YCVTos8ejjLRN+YjhqlQByvCUhVr0ed9R6fdhc
 VP3zlEqt9KfXNK4UPIiCW+Z1xy+m3MXvaFvpZNrelQgigjUbhFUNFypiHQ+G1JrfTejT
 ZyJK83CunWzh+7aRU5Fif2jSCMW8p1gdrmsaAH1KWxZD6nhpvo/2wdeJgPg6wwL3+NCt
 grf5lm+1vFF1PbA4KYYghY9mOWIZqZwNVzERKNqM5s0NTRkP2V3VcRSdeZDbeGRXpcxc
 gGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780498822; x=1781103622;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uBhEfdW/m0+frpWlSOZbFsnd5JIPo2zwXhwrIyotka0=;
 b=Y5yQwvo+QuocSzErvhOhKN+Mv9au9BbG6Awd82wIsa7Zi2rv41992ahETpEp13y8fX
 hXxHnN0FwFp08eu36lKnPO7UF3R0dyheMhYlXUpRXevD+ktvotoyAZN4uhabFkXuR9d1
 g/NnDR+paZXJghStfE1PJ24Xpuq+iSKctsC4hb3GK3GETxEs4cFpgw3ptEMbSJQtb2z7
 Pi45EpCop+xo6J0xgGUt+b5oGAJxiaVGAg8XxwVsvPHJsBZIBHRkdXM3DBfTXqw13ef4
 Ex+YD18i/N+P/YiGqpN+hDCUxQbo/tI+v0maazbYSOBnOmCUw0dNv29gKdod71XdJWFG
 YTsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8I+JhGXzs6E3xZfsNIg6jcB/yXDSX48iSW47j71XRd/uUwkUq7QSrsuALB8tkvGXrtHUjtwNf1Vqk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJwYjIqXqnZlfIVshBgQcOI6lkOgx+6siPVgO5X+bObif3nWi/
 TyJlTU0ui17XFoCOTy11uUQ5tRjxSbD7Aj4/g7r3qKHtuNliGcF0m3HEEjqbHZEYQpKaY36u+TD
 4fZweI7Syw84Du56snwLAavIgcuYcXHDQiHsrb4SU6u5hE3lqrXEOByCgXaNvtsQtOre1H2Q=
X-Gm-Gg: Acq92OHrTxirIngEOs80L4ap3Hmw9MJeQVpwr8jxTd8r1cpTmKy8Q7sTv+E1IDznzuK
 jF82+Ijx5eJDneDiHRpzZKQZ8hK7FGEX54RzXVVxXCvo3oao6IR7m1839ptnk26lv9sy20Q2hNB
 I9c3oGvybeHMK80f6CSjnCksD2E1vbI4Mmd879pzNucq9bmrio+2cElYIgE5+S/mfQkHhgxmJJy
 XrsN+2DEOnLlPsuYf++XiXBxes8qdgeDqA1K4FjOEGQ7Kb9KsOqudu5CYmom736PXEjMvLoaP1N
 2SpjVK3seJ3ETmww0BviapqvuQJ/yfq0eKllpH4j3o09M7YOoahmmG2hkOTN/mInoVe8kYBLcbg
 BtdXdM9TIX0u6O5d9Y7jifvSXj+e52GLOPWYoBku32vZyOWb6ElPT/RPrtkg=
X-Received: by 2002:a05:6a00:c90:b0:83f:2568:d45f with SMTP id
 d2e1a72fcca58-84284f5f588mr3805646b3a.23.1780498821408; 
 Wed, 03 Jun 2026 08:00:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:c90:b0:83f:2568:d45f with SMTP id
 d2e1a72fcca58-84284f5f588mr3805562b3a.23.1780498820755; 
 Wed, 03 Jun 2026 08:00:20 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282882170sm3747409b3a.30.2026.06.03.08.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:00:20 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 20:29:30 +0530
Subject: [PATCH 5/5] iommu/arm-smmu: Add qcom,shikra-mdss to Qualcomm SMMU
 client tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-shikra-display-v1-5-aeac1b94faa7@oss.qualcomm.com>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
In-Reply-To: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780498770; l=1873;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=oR2yHxswddj6quJTdd+FGIgKIDMApsb7sGBB9OxVs9c=;
 b=slT7W/f52dq5AGO2+1rwtTo0T6c9Jbsdja/oVrv6fulBjy7AdNAx6Ybfd6TtE7V8hPTZoRf2Z
 IBvqNqxSNY+BT8jWJynyp5mtqdDgum45kTsfs7dMaj99ai7z9uACjZl
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0NCBTYWx0ZWRfX8aPHRKlaU4v8
 zMMsVKYH5CtTzXE9eLy1hpPyVyEHGvdhaDfGqUlia0erWEylF187TO4a5YRlzhhYuN5Mfq51rjF
 ++bzW1tbpugLhNG6zhhyc9JBxorlNLAFa1mWmvhVUi+TpCZsa4y50k0KUqdkadHwzW6BXCD0xOO
 2glbCFvdZFsEkZBTs4UEIC6Bv9Ig+5IYu3lLtLE3jsXCQOHasQ4aqv9LjmYsgavABj/kjr9jMoL
 bR9CqCNIjmLnDoXJJi9EPh1cKs0eDHYWJk7m102vBTM9G0EMRC2GucqHMh9asglsP6kPmYnUiXN
 9E8Jd6kT1oiLO0E9wD02RYv+xVbV876p0Iqbz/PRx8SCgXwko/QrMKQThDhhkApO+JOzfn5Rsh6
 SZXBqERL/zRxGFHHDnFcptiwvVTG+xxPdhj9f1qOWMAqNZRTKH0SkaE3pdksyQacdR59oSWSsH1
 GCl89l4LaFJMJemSxQg==
X-Proofpoint-GUID: RlZ9ihFCTrOKLwv17-ysNdXrBr8kd1Ss
X-Proofpoint-ORIG-GUID: RlZ9ihFCTrOKLwv17-ysNdXrBr8kd1Ss
X-Authority-Analysis: v=2.4 cv=UvhT8ewB c=1 sm=1 tr=0 ts=6a204186 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=WiTR6ph8kncRzgk6yhEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030144
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

Register the Shikra MDSS display subsystem in both the SMMU ACTLR
client table (for TLB prefetch tuning) and the SMMU client match table.

Shikra MDSS uses qcom,shikra-mdss as its sole compatible string, so
explicit entries are required — there is no fallback to qcom,qcm2290-mdss
to fall back on. The prefetch settings mirror qcm2290-mdss
(PREFETCH_SHALLOW | CPRE | CMTLB) as Shikra shares the same display
hardware block.

No entry is needed in qcom_smmu_impl_of_match: Shikra's apps_smmu
carries qcom,smmu-500 as a fallback and is covered by the catch-all
entry there.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index e2c914fccd6f..3dfee947e2c9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -45,6 +45,8 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
 			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
 	{ .compatible = "qcom,qcm2290-mdss",
 			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,shikra-mdss",
+			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
 	{ .compatible = "qcom,sa8775p-mdss",
 			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
 	{ .compatible = "qcom,sc7280-mdss",
@@ -410,6 +412,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,qcm2290-mdss" },
+	{ .compatible = "qcom,shikra-mdss" },
 	{ .compatible = "qcom,sar2130p-mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
 	{ .compatible = "qcom,sc7180-mss-pil" },

-- 
2.34.1

