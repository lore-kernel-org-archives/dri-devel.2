Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3550BCD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D05112025;
	Wed,  3 Jun 2026 14:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n/kZaWzy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i7BgA0UR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF23A112025
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 14:59:57 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653Ddbhw1956498
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 14:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FHuvTiy0GQmvoxD8SXi2K1/mdcWexwa17cUS/1kagZg=; b=n/kZaWzy+7rupsEH
 dKKhdpNDX2gmHMsQQmIxtQv+1JBkx6YQPTiAAjIkTarEXS9IgJg2mmVh4+VKlrR/
 STUal+Qga1WrbTzBqtFqkU2k/IW5An8fdgdmATThKdmbTRH/fpmVev/zTUViv/Ak
 l2f32rfJWzB/6PdIZLeTIQMNIsL2MP5fCfLJ01S/MCVz178wv+imrML+N01qAFIu
 pGs1GFz3c2+7cWPMV+LPZKEMpkHpseKcDNoplbHjDYpL62GI+3qQLNjqqCtQYJkt
 YLSJ0q6DGL4uIqXuJpIAPwQCdmlfUqafOS82oVgDoVuSn6lH8tx6zSWE/NjNDKha
 Jk3dcQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejfqc1uhm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 14:59:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8422ca754d8so3401035b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780498796; x=1781103596;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FHuvTiy0GQmvoxD8SXi2K1/mdcWexwa17cUS/1kagZg=;
 b=i7BgA0UR8zRDbPUaHyl0qDtmZbSwiZpmPDBgrWUeKTu2Z64VXz71HNd7mXXBxIPwgZ
 cWL4n6yXMjiuLwPnen6wZD6aCRxu3rMaN0P5uGoVd0AYObfhypJKFb9y0XYwbA262JCT
 DNieE1pZvxEAfbs8H2Te4ygCxLLzy4KO4c0m9GfVm8hzDA8h3U3Pw7fah/1DF+l7d6bm
 qkgEo5AS6ORpSO+ZQEwEje0epeysOG5plL/ql8vFyt1vne0z4VozgR/ePb1H2qI976pS
 qc5YYwZuLMJDLZHq9MCqJ9qqMeXaFcFJNaupsgPHGZI6GCjThqCBQNvonn4n1vbgq1VD
 z9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780498796; x=1781103596;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FHuvTiy0GQmvoxD8SXi2K1/mdcWexwa17cUS/1kagZg=;
 b=Y9IRHHqLAR083Q8yZlFTbKYMxOtSxyuWe2dJIsg1tOvZLeKlOKhicso9+8ReWyKLqw
 MlI81umGFp4AUASfLtSGBx24L0DPD35ehny6LpKJLMV+/UNw6xe4CLw6yFMjq+tuBsRZ
 j8I0DXVORrawqehMfbyuV0gq/EUde3Cf/ech+DB2J03KdJ2uD2fYgxEx5OUL8uf1nhJL
 BkFkm9nLygv5Y8pNrpQgO0AVDFHhz2Ah2kHfbkllwHpuOh+qmXYvRuTatn32VABRwzhy
 UdqCloMMd+nEcuKKtnjq1USf47k4Az+euqPKcSrTV3xLKnsqzjwq2O92o/AO67f2bdNl
 8wvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vupQT0PlcSNgVc8MuCWFub1RB/52K8cpJMBRIHbb8q68kP8T9cUVJFUtENHcD6ws413/AOB9A398=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMO0vJ+XLMO3XVexv2Jwa8c7AARwoI1hzMAgmYV9/FsK0yiH1f
 s7cSoMHGI1f50SxJJQQzaz9kNx7WlS6qrfo0/qNskP6qsIkASK/gAUXan1o0H7/T9gys5B07xWZ
 QRf8DnXcuDjv3Cd06tJuHiU75WXIvCofTAKRSu9TfmYfw0XfmjtaZefKM/azbp6hFszIVtm0=
X-Gm-Gg: Acq92OHgUdOFjNSl7saDt+hBuNg5lz4jpbc4Krko4YLpBv7IhgF7l+FO2kPjDxCPXdM
 5TB3Lqi4UOZSgu3KzjIeulVfeUhsoAuX6nwZRSnCWzNaWuoao/GGtttgAkgVfWV2rMildzYNEot
 NyVIavIxWlwjH7u+48cinHaGv911+BP38a1GWwJdJbR4pPYSEci+41qY5hTH7S8KodkiKRYTVQk
 nFV6YDL7SoAO23rzXM3Fi2LCjJIuQqu4l8GaZ+1DPWJ5RBsuyx2jp/0yrpNjyJar6SfUQa96B1v
 BP6ew72zs1brsOgY735MbAuQ5F5P4QG78WXr8dPtUXZ/f3KTqsV+6j6gXAxhkjSjlQdC5hauquT
 VQRsLYXj01jtJeQ/4VgzsRAf9xQgJJiNeUEaDlfc53JXE4m8Dy+ZnbUu2bws=
X-Received: by 2002:a05:6a00:4c8c:b0:842:329e:7635 with SMTP id
 d2e1a72fcca58-84284f8946amr3803894b3a.45.1780498795941; 
 Wed, 03 Jun 2026 07:59:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c8c:b0:842:329e:7635 with SMTP id
 d2e1a72fcca58-84284f8946amr3803860b3a.45.1780498795425; 
 Wed, 03 Jun 2026 07:59:55 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282882170sm3747409b3a.30.2026.06.03.07.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 07:59:54 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 20:29:27 +0530
Subject: [PATCH 2/5] drm/msm/mdss: Add Shikra support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-shikra-display-v1-2-aeac1b94faa7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780498770; l=1977;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=lXWNmEJrXxHXoCAHvxq7qK8w3dDJ4/31/UMC2TNJybs=;
 b=fl8GxWFvvAxL6W8VYehdEukb+WWSYKOdLhDUGdXMeoIWzjnTFGm7XxYarDgwo+rK7e26ilCar
 sbsCIpXoMwLClv7E5wQZVUjKe9/oSpcQ1BsITrMiorkZUzsAClU3cYN
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: VtU8keLXrknVh18UQmSzMPHnSZD5JPNd
X-Proofpoint-ORIG-GUID: VtU8keLXrknVh18UQmSzMPHnSZD5JPNd
X-Authority-Analysis: v=2.4 cv=e602j6p/ c=1 sm=1 tr=0 ts=6a20416c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=IH1-U3DoIKz-FfJ46FIA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0NCBTYWx0ZWRfXyRotVYsTqFOn
 LAwNHuXHSimjXRBng7k95j4shp/u6Ngeq+elVaAICaGvZODndpMQrCEZc2iARLQH1Oq1uLBcu5a
 DjWifrdIBE+5BNz6RvOeBux6tf0UB51nkfxEGV+rf4SniK/YNJdxy64gnZ6/wrFYoHS6OqeI5MT
 1YbjgkvjEv1Pqho178v2NEailX+rRPkOHcm3BBWUckAeJTzT2czIQYRxcA7N09+RXDx6p2E/Ebb
 GBE5LLdIarwr+dfXMIukp1Qt1cOqyWZWwW1FrBMH6r2hCg417NfxxzykfMnDxj8GdczvcFXltdt
 +WzeMejq2Vjh4XFzFqvknxYpIhVXFDvNMYLsDgRkTF52jOesqzl59dTbm/LNvurdD34NNsi3xRe
 AIHtICDSgXUeu/X6msmDmwCXKbIikzZFKPlUoKkJj195wCRekWp3Kbw5xkyNk6XsyxIJ+MHABfb
 /Z2JL98VPfMcBD8k0lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030144
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

Add Mobile Display Subsystem (MDSS) support for the Shikra platform.
Shikra uses the same MDSS and DPU 6.5 hardware as QCM2290, so it
reuses the same AHB clock rate configuration (data_76k8) and DPU
catalog. Register qcom,shikra-dpu in the DPU KMS match table pointing
to dpu_qcm2290_cfg.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 1 +
 drivers/gpu/drm/msm/msm_mdss.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..8abe8ef6fa9a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1496,6 +1496,7 @@ static const struct of_device_id dpu_dt_match[] = {
 	{ .compatible = "qcom,sdm660-mdp5", .data = &dpu_sdm660_cfg, },
 	{ .compatible = "qcom,sdm670-dpu", .data = &dpu_sdm670_cfg, },
 	{ .compatible = "qcom,sdm845-dpu", .data = &dpu_sdm845_cfg, },
+	{ .compatible = "qcom,shikra-dpu", .data = &dpu_qcm2290_cfg, },
 	{ .compatible = "qcom,sc7180-dpu", .data = &dpu_sc7180_cfg, },
 	{ .compatible = "qcom,sc7280-dpu", .data = &dpu_sc7280_cfg, },
 	{ .compatible = "qcom,sc8180x-dpu", .data = &dpu_sc8180x_cfg, },
diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9087c4b290db..03f27e6b0ae7 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -537,6 +537,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sar2130p-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sdm670-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sdm845-mdss", .data = &data_76k8 },
+	{ .compatible = "qcom,shikra-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sc7180-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sc7280-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sc8180x-mdss", .data = &data_76k8 },

-- 
2.34.1

