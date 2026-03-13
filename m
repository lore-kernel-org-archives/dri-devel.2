Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46196105F79F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A579510EBCE;
	Fri, 13 Mar 2026 12:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQc0ea7+";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wq9M271Z";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 153DC10EBCB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:08:56 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D9B35m3906278
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vzyNvMFuHZ7
 AMRTGu9dBLqXG9QjRaM8aJeviwp6Cqpg=; b=KQc0ea7+xFkNCvTc1sqhiDGgInW
 El+EDA3XwW7aKi8IDIBlCEb0F8ax/k8rNtZqEYtYoc9n68+pGe3k1WoLGLO0xxxf
 HF4T1j83NT3SgJj8fRJQnBW+d+LdkI6VeOX35CoUFdDizFbU42AFxJotisG8ftPU
 DaNnoxmEJ0ZJt0i899isg3MNL+QeY7RKgA/TniPHZK8CDDVC3QWXLANjrA9Z6xBY
 VKIb7ZIv04/oZ3JHyMbhyGBADYkJbLxo0F7DKNtEZBHk3Ob+Enp2LTAjotxJjL+B
 8whwR9Fytmox4wgvsseJjRBFRPo+NOLlCGSTktqFfMuQ+2Uo7C0V5x0isAA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvfqs8j3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:08:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35a21d5246fso971416a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773403734; x=1774008534;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzyNvMFuHZ7AMRTGu9dBLqXG9QjRaM8aJeviwp6Cqpg=;
 b=Wq9M271ZD8yBq3uSw4znm61LEruziee+qqmTjdi5shj7yyMdPF9MyviTpZAx9m0lt5
 vvEWpl8bz98zCbvTO/BWaRDy6fb8DaYRNDoBmghURKWylZPxehEg+mt559NNvuSaeIli
 B14qFcJ73mQCUVp/U/cFemAkjSkc/Br7skQhlKeY4qMARcHTByBOm02heW6TnO+rs12e
 jkQZyYd1J67YmLEKFMHRxmbbypg6VwlL19aSrKJqlpnx9fEOKspAAhMsogfmuMSGMCVY
 d/lQaj0IuziDr4Uvlpgwv5tNqqmZoqKrdDz47p8kL1FZEDc7RUupSkvjdhlXl4Wv1/QV
 YmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773403734; x=1774008534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vzyNvMFuHZ7AMRTGu9dBLqXG9QjRaM8aJeviwp6Cqpg=;
 b=EcRG+/gp02Mw0+E6etc0t8SIbD0VmaWjxTzDyDj0sB0GWdPNN1NNkVrAzokzUk1uBQ
 QEcE1wmB0cIJedSQlSd8hTxjHY0ZR27bNKQmsEqRyqF/BtOOkZSf+54lHf3vBi5PcrYb
 oUYwJkAOffyG7WpuzVilsldnbPRiaexX0mh/3sJRfb4DP/GEfYC5hJi5pC9Nlftf5riO
 SbWHDZ8+PxeypnQmF+Re/X947lpswnpwWaybYNA4AO4i7vOHv58Z/IXSE9qP/GSEpW1R
 1P0kCvjeB8KA1ViaEULX2kak4i7XTvxgsgMaJZfAVMjUYkdthPxsZ92OBaGRNXJqB+pX
 cFXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmT35W5yYO1znq7qtpjbU6/tM0/LKumh01RtXGD5Y9xJL4OIugCVVgMAlM5zMNCJbPuNScuX4QP8g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8SAD8NUY56RZNZiyloEN0+ImBk8Bfy+zFL6grFNjfl841jyjH
 PWDH6QpdAyoz1Xfnl6z7f++mo+PXJF3NKCCCj644xzBKRD58gK/qeA2RwL1k5Nh/IRrAXPDnUYd
 cXj04dENMZcD6TQh3rvcep0q1hmmNKdBRGF/W9A8q1L9lgcW9a9RhI6EohdEcYLqEgJ5y7hY=
X-Gm-Gg: ATEYQzwPM7sbtbw2VIBYq1QytnzxBHBUYTbn6oRL0mQXWTm6iG1YPoqmb4yDrsEVSbF
 sznFtGpdXaLfq6Ii+pFg3TPqlFIGyt3oatcDMj9G18UKUVhdahHb44EQcSYwggUuXMiLE4EdpP8
 k6Jjh8o9MGSLjflVk4cDqK6SIk4cCZt2RlAinxOjS7Qr+J8jSPFZ3xaOA4rkSLw7FpM6X+q/hU8
 zQbCndJjCTBxLtBqCWu8I4/fR31Hv7t/3hT8jTfCZY+cfDLcnuHqrCXL/8CLsNnEtMDclNPWW1y
 hvoCMLAhgCd7Nlllijn30PJx7n4E6XU8/NYLNToL91QulhjPUuYX16sqJ7ArX8dvWjGWUXP2NsT
 oUSo7AP4XH5Yw4xb8b5cgc4fBforDdQOwUYV6C3MO6A51/40zpdT6V6JGm/4Zafqa+sNZWE/2hI
 sWjmAEXksAUwGnsxt5JweonKMMq/5OwPSFoEKR
X-Received: by 2002:a17:90b:2683:b0:359:8d2e:6f79 with SMTP id
 98e67ed59e1d1-35a21f6874bmr2855197a91.14.1773403734118; 
 Fri, 13 Mar 2026 05:08:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2683:b0:359:8d2e:6f79 with SMTP id
 98e67ed59e1d1-35a21f6874bmr2855173a91.14.1773403733623; 
 Fri, 13 Mar 2026 05:08:53 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e18f0asm8421945a91.1.2026.03.13.05.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 05:08:53 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 mani@kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V5 3/5] dt-bindings: misc: qcom,
 fastrpc: Add compatible for Glymur
Date: Fri, 13 Mar 2026 17:38:12 +0530
Message-Id: <20260313120814.1312410-4-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
References: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: khii0vjeFedRn7a11KQPFBh0OIGQUXnW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NiBTYWx0ZWRfX5NFm1P3o1tPW
 nvCDEy5R/EfVwJJxEIy5DT2btQ50PBIW+piSUztgqmnxB04OajVKe+TLeww6TGFN/N9GBP3X7qJ
 U8I7BVKy1BHO9R+ZGNjcAUOnpEB4LveQOgL+dHAH+wHLM8MOHQOcBWS7lwgpa1+Hr1S/CPqnunl
 zZ4vxvgRihOZeKH/ORyf7V28NsLqFWdx0lTrclgqyn99Tm3mBiSqJLNPAgVSs5CzI+cRSGbDUMS
 C32Gg3lHsnfE7jHI1XtHnG1vSoOuvNwQUWAZZu7CYVxFFhrnyiqJnmF0Imj1b7o7txYrAStZxPu
 NDkpDcQbgv9RO8IZGCyu1xi2RHMTPoosudD63wAev+sU9d+APMq/diyu5QMu341sMU7ceIysv7+
 qek5cYWoVEEjeoYUUxcq1qUGaGfR25Qtx0UXxrwmW8bNuObeUHsXxkrMVwqZBOJX80F/6lYrpKG
 MM2R3WlrFYvCrz7SmDA==
X-Proofpoint-GUID: khii0vjeFedRn7a11KQPFBh0OIGQUXnW
X-Authority-Analysis: v=2.4 cv=GoNPO01C c=1 sm=1 tr=0 ts=69b3fe57 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=z2LoTb0XuyLmHK_nd1IA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
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

Document compatible for Qualcomm Glymur fastrpc which is fully compatible
with Qualcomm Kaanapali fastrpc.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/misc/qcom,fastrpc.yaml        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index d8e47db677cc..ca830dd06de2 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -18,9 +18,14 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,kaanapali-fastrpc
-      - qcom,fastrpc
+    oneOf:
+      - enum:
+          - qcom,kaanapali-fastrpc
+          - qcom,fastrpc
+      - items:
+          - enum:
+              - qcom,glymur-fastrpc
+          - const: qcom,kaanapali-fastrpc
 
   label:
     enum:
-- 
2.34.1

