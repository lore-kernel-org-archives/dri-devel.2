Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24573CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7A810EDDB;
	Mon,  8 Jun 2026 07:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LkjzvS6F";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DwhO9UP4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FEA10EDDA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:02:05 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586OuOS2832996
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 07:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4SqlhiCUHy+ItpDoHiIxZ33OiGVmsHhLICsi3glIWBc=; b=LkjzvS6F7bXJ4tOj
 C3sz8nXDmROsAjh5QWk5fvuhZV5SLFkwDQvzt0TCTge6v4ZKqKcUJLhgTbKLu18L
 2K3oLpCpzUVIDkr3ZiHDTWSh0kba4+pgsRlOMWAysVBu4equjwoNOrwDysludr8t
 fEiZKyP+h7wEPWLKLYOOEpqCGqEN+KFlUo7o5+4EtvSVAJWMCO+UH+kwFF73dw3Y
 j8/uYDV6FDzQD+/3FkraiDFTR2j18C02fzoRXrSXpVEmCDuOtGGpPBVVY/GxaqoW
 hYqSlMXaizdn3WewH4Dp3UkNPrryCB2tu/sFrHOPPy+TSy4BNEsX3f3ogRti26Fi
 cTuekA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmreev9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 07:02:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c85edbb10dfso2158302a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780902124; x=1781506924;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4SqlhiCUHy+ItpDoHiIxZ33OiGVmsHhLICsi3glIWBc=;
 b=DwhO9UP4CKHnBrXE7RxWfRlc001S7D29cJ21J5me+tcdYZ10fqU6u4/kFTyG0Vqxqi
 6NhY7qe7RgGbbskcJTqJjQcWA+TYy9/SQnf94d/gOG27vuXBW2PP//BlJAqGJzqcKahs
 mrRjaqfmXqUU9+G07OTAQTHOSj10f7aSHfi/Vk0qDyxvsYpFDrCms6mpy80A3T8GaiVn
 A36BQDfR903j+ebawtSUC5YOlmEqgZmpgFGHvJRHVbljq6CDGqAkAmZeQHc83KechCHV
 WrPRz0yQBVfHWXpD51xVmgsOQjdyeWvE7duvDOwOI07cGZHMMB7ckErWjgPL+czrU7EA
 w4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780902124; x=1781506924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4SqlhiCUHy+ItpDoHiIxZ33OiGVmsHhLICsi3glIWBc=;
 b=agYQbriLVerkYN572n/jo4MW/OCjbjGdz1Radzkhb/SBxjUSkGlCoAdepldUFQMM5n
 5M0bNnX1yNxyfZpet729lLowBhoYiNNl/QQ/+8wIlBVlJDw6D8dUWC8Ge3i7K5lbC5Ak
 Hi0r0IN7HYOHqnESkSE+n7kXjyfgeADyDbsVm6QbsadLZ9wiyPxfKlNLThoFKUAOErf3
 IkBDdyVhJPh28rmh35TPzeXAWem1FlAib0/CGZV4Xod0CtujMoQhr891KrJfCX/uXPJh
 k2DLAUS2giF0TA4MbndeJtQOqCk/zFIX+6haRrwg7rqIXwqrJfQzcMGutOOBQYap6X9l
 cdRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eJy4yXq4NFWxMCvZVoVME3/YNCZ0HW4AwsMoO+B2N1bEyl8kOwJeTZEAFFUYRk9n/RWgBiRK0O/M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5tZsnlmq4j2ScdKKF49ZfWYp7rggINle6gN9fB6gyddzfVZ1C
 7B2EyFt9uVqwuk3+I+rFp8brr8MmcbEdJ7X8kR1P1TLzaylm4kgTS8sE904IxL52pdp3WVOgLCh
 kZuQnThzRvgwWfMyftTxK8zeK2k0fBxeNsid5hyUpuWsdiFkBtL6sCb+yIY2Mzyt0e3nUaa4=
X-Gm-Gg: Acq92OF5NJI43dvHGhIUhrT70wgn3pS2oS2AFQ+v/zPYiPv/5IBz1BKx6nQqwL5o/qL
 l39Ef8iFevRJb718AEDxYiDN8pL1weR/xloeu3kxGxQzGNZrRMEce5C+T7/flGe/MmQ2yLlke81
 lF0pl0GJNMg4wpfys5xQaK9oJ8R4gfg5nfnB4yRNeZGj79F3gauGlpu6IiwozwuIDcKQFMtcqZQ
 nMdals1R7aj5Xv3EuCW5tT+C0Rc79+hIHPAJBttXDkM1djbUu/szsf/V1sw8x4hBQDghggqht7B
 acse1/+5VYQml/ORixhk2yQ/cvCptMFlydaqCPwfFVSYYit2I0mdlj+RImhDUGs6sXDppOsEJCX
 TT8rdISSQ606Y3IDybCXmkwWzR/Rxg9XfTGGGxLZiDFQp0C7VTJtq7sClH8I=
X-Received: by 2002:a05:6a21:6b8c:b0:3b3:3506:cf3f with SMTP id
 adf61e73a8af0-3b4d39ea8d8mr11958846637.1.1780902123819; 
 Mon, 08 Jun 2026 00:02:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b8c:b0:3b3:3506:cf3f with SMTP id
 adf61e73a8af0-3b4d39ea8d8mr11958792637.1.1780902123334; 
 Mon, 08 Jun 2026 00:02:03 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c86151154a8sm6267723a12.22.2026.06.08.00.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 00:02:02 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:31:42 +0530
Subject: [PATCH v4 1/2] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
References: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780902106; l=3783;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=f/sCFDjTgatU0BGy4aowz36ZzDRGX9hyPbW8Spw3VEo=;
 b=3x+ZlUOf+wBvB+AHBU7fiuERNwbEV6hSQI9aySyJjZAyO4j5aINgHa5ClzJ3B/FdpAky6FC31
 e7ARgDXnF/bBbGnNPhCthcBG2EpS3e8W1qCplKY/8LUfa9o4nFpoBd7
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX2csCFaDuZWSd
 o8laYIFHxd/q38oyc224nXLOUG5tcegf10H44p+pzsFrQiU3Cf/qvSyArNueR5UgZiYjB3HKf6A
 NPtDSrnngChrctpCPksCcgl2fkHW6e4lyXDvFGrohEmhyazFE1TjfMeJV2LQejVb/6ent8IAHvw
 PUHD60B1wCiN0LG35IxMWOmCnCFPpvqSNboRfR7pBwYMHsWL8qk0rVbdV/i1jdAnxw90FqqeMMG
 Q6QEhtL83Jjmt23L63qRxe6Oy9mgdPkAk7TcoSMhYvUPMv9CP4tG4Nmm8fvnWXbSRN5rw5RdcEl
 IT7o8wIVDlvki77/w9IhV+noFjwzkjM6pFRzBhu04BHCgitvcDWKruUrnMXRulBdypzFB0z3pJ5
 Vz0yyqowHajJ439Ewkl3wT4iVqs03iHUpPquhpcVGbDfiER6HKVuIaCRDFXj5v6K4BynLURgrjY
 oqgWkGy9ROeDzqJSkMw==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a2668ec cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=OEkpyX7SRU1z48_sfK4A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7fcWnZATlAJITUcFoJ0jVD5Sezao1JJR
X-Proofpoint-ORIG-GUID: 7fcWnZATlAJITUcFoJ0jVD5Sezao1JJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062
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

Shikra reuses the same MDSS/DPU 6.5 hardware as QCM2290. Extend
the existing qcm2290 bindings to cover Shikra by adding fallback
compatible chains for MDSS, DPU and DSI controller nodes rather
than introducing a separate binding file.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 .../bindings/display/msm/dsi-controller-main.yaml     |  4 ++++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml        |  6 +++++-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml       | 19 ++++++++++++-------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index dbc0613e427e..fd0834d09ad6 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -47,6 +47,10 @@ properties:
               - qcom,sm8650-dsi-ctrl
               - qcom,sm8750-dsi-ctrl
           - const: qcom,mdss-dsi-ctrl
+      - items:
+          - const: qcom,shikra-dsi-ctrl
+          - const: qcom,qcm2290-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
       - items:
           - enum:
               - qcom,qcs8300-dsi-ctrl
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
index be6cd8adb3b6..034d3df8d247 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
@@ -13,7 +13,11 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    const: qcom,qcm2290-dpu
+    oneOf:
+      - const: qcom,qcm2290-dpu
+      - items:
+          - const: qcom,shikra-dpu
+          - const: qcom,qcm2290-dpu
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index bb09ecd1a5b4..49a7b5c4c678 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm QCM220 Display MDSS
+title: Qualcomm QCM2290 and Shikra Display MDSS
 
 maintainers:
   - Loic Poulain <loic.poulain@linaro.org>
@@ -12,13 +12,18 @@ maintainers:
 description:
   Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
   sub-blocks like DPU display controller and DSI. Device tree bindings of MDSS
-  are mentioned for QCM2290 target.
+  are mentioned for QCM2290 and Shikra targets. Shikra uses the same MDSS/DPU/DSI
+  hardware as QCM2290 (DPU 6.5) and shares the same register layout.
 
 $ref: /schemas/display/msm/mdss-common.yaml#
 
 properties:
   compatible:
-    const: qcom,qcm2290-mdss
+    oneOf:
+      - const: qcom,qcm2290-mdss
+      - items:
+          - const: qcom,shikra-mdss
+          - const: qcom,qcm2290-mdss
 
   clocks:
     items:
@@ -52,7 +57,8 @@ patternProperties:
 
     properties:
       compatible:
-        const: qcom,qcm2290-dpu
+        contains:
+          const: qcom,qcm2290-dpu
 
   "^dsi@[0-9a-f]+$":
     type: object
@@ -60,9 +66,8 @@ patternProperties:
 
     properties:
       compatible:
-        items:
-          - const: qcom,qcm2290-dsi-ctrl
-          - const: qcom,mdss-dsi-ctrl
+        contains:
+          const: qcom,qcm2290-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object

-- 
2.34.1

