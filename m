Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9163BC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F0710E166;
	Sun,  5 Jul 2026 08:15:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KvAciPTo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RsRYhR4F";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D8D10E165
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:15:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664LdCOv4105582
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KNyCxijy9WsR1AOyIAocOM9RR1P64I7j0GHUMuAw51k=; b=KvAciPTo2opHuKFN
 hIdWUJNugTqAmpZnAo3usxfYZVs/0s23fjArjmpVvW9KWQAS+qXw6UxcUIinpVVL
 du5M7pS9upROlpHBDsp6SOwIRLMw525dbjpGq76d9GLofEEAT1a5IPL1r0I+duQV
 Qxq+jSCOg3Z2SPd+poj7m2ZD4Sbhcd8OlKWfXpU6p5nkcsHgrOk3S1QQSrUk84LB
 qmfTZJHNBaZlxPCa0y0WkBFW5RrTJTpfc1gMjSyZEscAsF9PwfeEK2I5I6t8rU1A
 ckuuruQOHoKwR1uiuiEnp0dX8rReYP1ctx0kxpm8CS2newYWi2m1RMGpQYgJvRTe
 XOisJg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3aaq4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:15:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc77a6943eso26491735ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783239310; x=1783844110;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KNyCxijy9WsR1AOyIAocOM9RR1P64I7j0GHUMuAw51k=;
 b=RsRYhR4FJskR9i/KXYi3a/fB9yZs/zoH6UvEn2lW3eAOUSgR0vYZOPfvhdzqHWwiXy
 awJIKek3ueHcKOWQwHkskvll4SIc4MTwQT59ayd/m4qEHVVphOMU083SNfT3H1uyvqW7
 UmlC0H7/zZWigErkG3mJGmgEj8UTq+nt9iXFTxLG2vNT1jJgMGlKs2EbniMCsrsrjxXk
 CVDfdEiczvnjsqR2bcDiFKiIDNORbKgPIIvRtwEIqwJ9GjQvps90LskW1S3G81uC0WT5
 9+9mm/f7DyIS7/erILw8rbF2fZioPFZg8t1E5jUp4zaKw0kERoFcAZ5efeQGoQ2KkPkL
 rUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783239310; x=1783844110;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KNyCxijy9WsR1AOyIAocOM9RR1P64I7j0GHUMuAw51k=;
 b=fIHN3SBlb4XrvlGJN57YSlf4t5EGmy5wAADMQpS1+eY794TUa+XEOXc0JGfae8kxK8
 JnPPULMBcXxNGNpBN9jJOhxImwqEFDHaz8YEBeGL3cHvJ1qiABmwxXe/NzQlkYxs5E5Z
 kTKhDCzIrBqwNziap3xW29wLv5qCzkOsx8IHLcS3uVUQue/lq4e9tTk5gdrUNwH02ktV
 W3QNxmnpELvq3D0dRhrUfaoHdY/sfXibIhPhfERQ+mHvLD71IAGZsTL6GznMnTQ3JWGO
 UvfAzRdmZDq2zFN6+BCcp9uzlXZA5IolLOsCYhApUWbUkWyJMkQU5Yi8DCKG5bfp7rEz
 yv4g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWSSW50asf7uJWoBEQztDzuUkLjCZoq30bob17yGmHxv9HMt9mjvBVvEmdVU/zb1oraRmYgUQvJE8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYTPVHZaczf6dBUxaNh/GJJi5NQQvDiMELqFb8YNkDDWAUM6mQ
 h/ElubBmIwinSLae8kPzyxvrXeSTJMlpjGiOFaljS9KDB5nmsDAtf3GPty+j2cQEMi6e9tJYdf2
 Vn7RtxCeqCLyI0yHcy5oOxHOCrz/nVY9KHHkDx36lxgIPX/ChaQZ8NJi1Ct0M8hXWNZ/dvAQ=
X-Gm-Gg: AfdE7clz1YLQy/WMpuCpYqPbAxKneky5wIy78pxGRK1DdSWa419yUAa2F+yIF029dWv
 VTv2igDVddgPxpObvByyWtXJZB4NrIJTsONezuGFqm9+UkqgpwBNXRr9XSFMz/p8v/cNf09dm4Y
 LDWg0vLYRlHAQBJORZZGPsfInILDsHNGSM3SEbvkA3GQIeAtwfPzZAELUNNMTSFhZRjb6+Iue2n
 ZzEYI3Oo+GxX1Y+D8c5kRPVT5tE+Iq8VyFg21lK/C/7QM9EL7x44kEGfyJPkNXT+V7z0yLhr1T9
 9ca5I+bxRRtH3yj6W0IilkYXV1EYXmkQvy9AusYe+N5eYQ0KalJDOxVJ/HiBcTAl7VYHkk6T6DO
 1+T7Teb+VJdcUuy2scgnOiiGxY/8zT+cZIJY=
X-Received: by 2002:a17:903:94d:b0:2ca:ca48:c380 with SMTP id
 d9443c01a7336-2cbb9f17242mr60484235ad.47.1783239310009; 
 Sun, 05 Jul 2026 01:15:10 -0700 (PDT)
X-Received: by 2002:a17:903:94d:b0:2ca:ca48:c380 with SMTP id
 d9443c01a7336-2cbb9f17242mr60483705ad.47.1783239309320; 
 Sun, 05 Jul 2026 01:15:09 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:15:08 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:19 +0530
Subject: [PATCH 4/8] dt-bindings: arm-smmu: Document GPU SMMU for Eliza SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-4-c9f1354dbd29@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=1118;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=LaExk5CcIsnQobdkf+tB0TGQXJcIbfm+LHR//18ybOQ=;
 b=VCe5OcUC+YrAxAUSyCuNQqTb0M7+on6Cxws1+B96zvqSXIOvBEXu8K5mbkAmqcoJ/obMc4EbB
 40gj+Ln37yCAo6AFTXP4OAT10Srm2ogRfoYXQqUulwYf1GqRudc9cNY
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX5qQqVemxE4gQ
 rWmGNffMGXfwPvMYOizhLBfef1WKvc/NmjOa+sU8NXisjIdXkBbMzsGMrAuuwmwm2p+VgUlQOBW
 beHeFG8ghpIVB+KNMO+AdX7gAQormF8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX+jQegsiNjoHh
 XhTwDWUnMRCzzq4ysTycmmBMYR6ZSctCs0BMtNtJXnByiDyLEfrhze2ePZcJ61mXRPv+N1qwb9d
 zQvUu3du84j5J9Or8f51ih+bfknx7i+73Sy79DtcrszrIWIceGF7X6hl4fg+5NXTOfPqz9RKWuJ
 t9Ombh5jNyT/ioizyKeUsvOqnswyEUkUAOpAsSrA05By98/64mDkCcSsJjI2Q60SftB7e5iAmbL
 9ROBYDvEQWmHNMKRf6ET13A5uqkf+wtRdTCTaurUIq0VoRt91DqUQVPEvBCC2bz4OHhUhEo0C5+
 XpvP1hsJwOckqbpmwNbw7DSvMC7vU9FngGm3Buyj01xYxTxP5U/usJK3M09koOBLiM/+9J7ez+5
 CWLLGyulGpQ6lWe2d0znCENys+TNq4fsXkHgUh6AOJIi/A4xSxonnR8QblEDnbNJNYz+LU19epe
 cYWBULDbBORwETV/c0Q==
X-Proofpoint-GUID: OI26uBD4S6zw4Y2p-CuiQWz3kRjS-ngN
X-Proofpoint-ORIG-GUID: OI26uBD4S6zw4Y2p-CuiQWz3kRjS-ngN
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4a128e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050082
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

Add specific compatible strings to document the GPU SMMU present
in the Shikra SoC.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..ed556683817c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -95,6 +95,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
               - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
@@ -570,6 +571,7 @@ allOf:
         compatible:
           items:
             - enum:
+                - qcom,eliza-smmu-500
                 - qcom,glymur-smmu-500
                 - qcom,hawi-smmu-500
                 - qcom,kaanapali-smmu-500

-- 
2.54.0

