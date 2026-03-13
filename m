Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA37B105F79F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5658610EBC8;
	Fri, 13 Mar 2026 12:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RZTuO7kW";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aTpznzGt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 975A610EBC6
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:08:50 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DC02BW4140725
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ppInlw+PpBT
 aE16b9MZfivnywOUUI3oPkZlM/KnSAN0=; b=RZTuO7kWH3LiHb8Q7BQ4dnKdIyM
 GfGwzPi6+c/Rt2hfcU0RqfFn1V+nh/dlnC98O0FV/Ejc2OE8rUdouff51jqRzU/0
 KD8kzpJrgPeswp7jy4/wuUW7n8wdvO9zmELO5aFYAPN8X4tyIS4bv9briinNRK7S
 PZoXHUBM3B0hvjCTu3MwnJmL+giWZOf68PdFgk5lhKzNnRQqaRbvbQZniddbqXm6
 EXazBDK7lfQwJqK8zFvFT9SlX4HWaK5jAtIHVsy/3xltTm2p5Eo9qWp+qP3DJE8b
 yn4Y0r0Qbmi8zGxqtZsWA2Y2W8sYymV0Yr7H9fnZuZSH4PFphhv4h4mKSCg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvbn29fs7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:08:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35a0ee0fed2so1646990a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773403729; x=1774008529;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppInlw+PpBTaE16b9MZfivnywOUUI3oPkZlM/KnSAN0=;
 b=aTpznzGt4wnteOb6gpRBAqS4ZF6ieom8jM9YMkz8d341sVEWn2Q+CGm03o3bbfLpAY
 NlTRoCpvlsxRNtLNeEVJrOmx4BVzCVYe+JkDsOvTiCYwZPNUtRg8C9PKuCfaeAmNzqEf
 uN+CgOEr1FVrHBUU+3TsF1LccCMsVoy20W6gPGzxNaRL7BIzXQFnBoa4rGfzCrsnAZix
 mUr+k5MO+ChhVGHdMsY6YLeF4F3AzaNcjqyFR278qKaRNrQ6w1z3ztd0srDRKpAxrWkk
 jcC6+8G368niScGLwEVfdHGpGHHzCHVt16odLyb/Dfx4OZqW5zUHF4XAv64PsrkJfyUm
 LzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773403729; x=1774008529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ppInlw+PpBTaE16b9MZfivnywOUUI3oPkZlM/KnSAN0=;
 b=pHaHjphy9UsHvNXXisS0obJwlIljRBjFxP+05CD8UU9lFuNV3QSrvuRpQqTVFI6DAp
 E37PYkN7MBDi74h94ZSGlWM0f7ofzHhZdZ5U65uJQY0xWNZHl8nU0Y8zDzBY0H2XuGMt
 8loOiVoUhAjTJE79xZekI819aN33SPk9HIwpC8HRXQVcdVf4EAZpI19aEcAtSPMgl5Y+
 vVVanhdIl32iBwvm1wNyLRBoSVujJ/RbgVbSguMmadfLdrfMqujc/mM4mjowQNHHEMVL
 6J7U0eB/NlTTT12cBxEHQ9cSctcwmZtMNeJOGMeezYHsglRbHgAVuR8/BB5P2PwUjZPC
 ZDVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr7nsrfn+UHgKWekU7dwTFQgbO7snBS9rR+o71KC7f1bOW3Jvx06w4hCcGhLUa07Zj/51qo/lxNIs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4+94vQSob5cAm3N2NcqTRGhAxHApnPh0XeObcmAfSmqbWS53z
 CyA7+Pgp3sgKbKl12AhoY5f0fMKKM+B0xE53DxkMAZf3L+ZyIn92mBRN8Z61WIfZFOvd4N94C5z
 32zc81i/3zSTODmpJb0ZqBwldh90HkWVxN8niqw2cZXZo524gZPNSGbPZ/OTmL4xSdrNt1cU=
X-Gm-Gg: ATEYQzwJM4EpD5vJOt6EBUyCCiOCuy2BIzsC2porN1aHiU2d4Ai32hG2EotOcfk8hNd
 oD6HtZEE0UnCTMNESqyyNjiawSJSA+rXhRc7UU4X96G2bYucx5SCLjsVdb3Bvb+vj6u8giB9HOP
 K4/84pFP+8fccOLlTNquNjx9dafQvWveyVLepNconY8xxxXoHhNzpEcqT+NcyBJ+qGiLtSg8mVp
 oX+uAKlHZSiAT8BmE30RO0bscgPYHLbbvYmpZ+MfIrTa6oIDjf6HmzflLDpF/WxdSIgx93+eV+9
 qoFGcn3VBS14F5PyVlU8TRJTGem4REEzrz4dYqPGyGb03/3bwQ3GY0b2drh3QcUXykiTiIagaOe
 kOYU/Z5bCMPeTI+WoQI8PZ27HRqIofkRFG9rz5hyu2jyFOCRQweVKHg+xpbtoMciTKCYK+R2NuQ
 dyohXIvTm423xDhxysBa/lf2Jl+9a47erogoOA
X-Received: by 2002:a17:90b:1c08:b0:359:8c01:66f with SMTP id
 98e67ed59e1d1-35a2205880bmr2758122a91.28.1773403729307; 
 Fri, 13 Mar 2026 05:08:49 -0700 (PDT)
X-Received: by 2002:a17:90b:1c08:b0:359:8c01:66f with SMTP id
 98e67ed59e1d1-35a2205880bmr2758095a91.28.1773403728845; 
 Fri, 13 Mar 2026 05:08:48 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e18f0asm8421945a91.1.2026.03.13.05.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 05:08:48 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 mani@kernel.org
Subject: [PATCH V5 2/5] dt-bindings: remoteproc: qcom,
 sm8550-pas: Add Glymur CDSP
Date: Fri, 13 Mar 2026 17:38:11 +0530
Message-Id: <20260313120814.1312410-3-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
References: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2AHNmbGN0QNRr4CdSLNFKWwlqO2JedpM
X-Proofpoint-GUID: 2AHNmbGN0QNRr4CdSLNFKWwlqO2JedpM
X-Authority-Analysis: v=2.4 cv=ZKfaWH7b c=1 sm=1 tr=0 ts=69b3fe52 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=BVTLK7zpd-CcKl8eL14A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NiBTYWx0ZWRfX4QvUZVy9Q7si
 C/lHBPUrHm6BszpY9pgmOpIF1qIYz4dpu9gpkLJAsIXAtk/s0o2dqzUtGRVpZlG5eX0njsXlqU1
 K3PIfCIzedcBSrCl8Jy7A01erG6pQnxL5h1LIWxmoJizjyjkk1lRtSK7Yn38S0SAEY4X8XQPOzr
 b07E1jDNEajeSJvKsEqaODMj65NNBIl+g2HRDMj94GU3HCqBAvfR4Gwb9xHPg5EUTA32viBoR+V
 uqjF7KZkp/kEaRLsKHYxjU4Oicp75HqW0+PiTGN/85ZBz3Cg1OJBbXvKAspOfwKs3BSRoFoK2P8
 9XJ3pk9IoameooStbJQlvnOWtooW7gnBt9ejxW35G55qv6aWQOL5T1a057NW/Fv8qvsD/LZYIYp
 uybUNiLK9uPyWKOE/EAtXc1/AgKn+rW+00vP0PgP93PdhJjw88X6ytx9R1GbuHxGA5W9vDbUMqv
 4EOT4Px/ZoiMuQ59S1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130096
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

Document compatible for Qualcomm Glymur CDSP PAS which is compatible
with SM8550 SoC except for the one additional interrupt ("shutdown-ack").
Similar to the Qualcomm Kaanapali SoC, "global_sync_mem" is not managed
by the kernel so it remains unlisted.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 .../devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index fb6e0b4f54e8..6a29d239ef41 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -35,6 +35,7 @@ properties:
           - const: qcom,sm8550-adsp-pas
       - items:
           - enum:
+              - qcom,glymur-cdsp-pas
               - qcom,kaanapali-cdsp-pas
           - const: qcom,sm8550-cdsp-pas
       - items:
@@ -103,6 +104,7 @@ allOf:
           contains:
             enum:
               - qcom,glymur-adsp-pas
+              - qcom,glymur-cdsp-pas
               - qcom,kaanapali-adsp-pas
               - qcom,kaanapali-cdsp-pas
               - qcom,sm8750-adsp-pas
-- 
2.34.1

