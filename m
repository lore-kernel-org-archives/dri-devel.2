Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2628C44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9C010E0A6;
	Thu,  9 Jul 2026 18:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXBqxrOa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HNnFkvkm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EDD10E0E5
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 18:42:45 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXBik2327902
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 18:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=; b=WXBqxrOaqkH3Gwi7
 ynIky3z5jsmrx6eW1ol8QXMfbBkHdq0Fo/t1FgDFME6hbvhhLUC3XFMsrar/swQJ
 FOQOjeFamd2ipwcVMyQnGiI5i0MkkINOC2QQqMTb2ei0OMkVCMzWB5f5A2rzC5O5
 8b6hyFb/D5Fic+DbEa/aax+aXxDqQz6Q94skVrr+LfXNp+sW0C+MmsrWUDMntbKD
 lu6cyJWPNtmdqTJKnZ0ON8c0W+wpJA6kcnMcMNvQpTJs6i4ToEIpmO8pAcIhQ6+i
 9ubALVyFK/yMyZ5llIbwQ3/ObPzRPtWItKkS4Y/e/Aj97o/JPSKz+Op0ipn4pbhC
 46qdVg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24rq15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 18:42:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3810e5c5871so311718a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783622564; x=1784227364;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=;
 b=HNnFkvkmJdEH6WubsCICKpI07vBLvQkY8ATmn1P9+qNXKVd3gctFtxmuh0iAzv8+z6
 I9J8fLIv6agURR4j4cmXyp5oGy2Thl+iDKqpS9Cvl57d4tHZp0TxlTa6Z/0KdpPUeF9w
 YjRTtiGysIVd+So85td3qg1IZhTKyjNdUMNIlk4tOUgV7skY4qbctlPKwIqNAcg3otzv
 pw2vmlC8T91Cluwo3WFlP5nhi3Lh4Vrp0QqJMScgPu3LZjGsrAbTQoaDRQcgFJtI94DI
 0t6cU5mXUjQ+eSM+mlsqZmWih+nXOFSKLDVV7Hnte2rxC80sRlw00zcv5pKNzGwXMqTF
 BEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622564; x=1784227364;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=;
 b=OmaQiNWZpRIbrLBVraJuyyCkxVj5RIG50QkMbYykkxbqbvXDCCA90jv1IqDmNChyLb
 8JxJ2x+qz/GPuO3Bw8Rusw60ZDqBqrCB1XBjBulZaHHn21O1Rvp5tyOsZvKnpLeS9jEk
 DP0eOKLFLAUR+Zsvug5KLFfx0uhpR33QcqDbPbOuLigLv9TLtKRcaqresLQQOB5IyYXF
 is1YRK/5J6XB0304EuUYW3Mv4mUzwm6nwsS8bINcAtICL4M+ySeTJu1HFXVkCA6IBHat
 y2CcKcmrDQ+Td50U+DOJGxVw4cXcnpsFebRw8uL+9GVHrwZP/cbRnAAu/ffgW5naqOAd
 Qjpg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoaxWljctx0ALWNVs/ldZv77OzjYLUzhIXu1A1ci+5//wCtBlPgVc/mKhPzD9TQ5l3NSsRTLvoX7Os=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyU3QLZvYu1e/xMWw+c3Al+sS3jXwN3eikeDD0cgkrpG8fujh/J
 nHQHc0Mea0xRkDLOwrBLKU0vt1CH0q5AJ1KyqZGreeCMNjNFpxOiJGdETzeTwFkYUfnP8YwGb5e
 wOw3aydekyCm9hcSXwyYxEHHUNsfpncY7z6TM89sT4nc9Jtr52IvineW5K8beo9Uvqwm5Gc0=
X-Gm-Gg: AfdE7ckGkca4y0skMYT3AIM3sWY5C76qUjgB/OiSaxf3jsbREPXdc+lyohknNcUZQLE
 VRCHyoU9Y2gDxj9ymlyc+xjLJaKe0sMRDf95pIVdKz5gE3clUiZihXZ6SWmUsB6zvvLXUImERlf
 PNz8HVZ+yjj622P3CJO60OSXfGpOK4q4H4QMRD+7ZTA09iNiOsxzC6nJ5VRe46XGOyGTvY2QgDl
 YgiRXQrxzbcbP8acZv8gtP/3atmw6mG4yd0p9l4mV/0XQRnMji7JejLtnAiVBJ03m7kw2DGQDA2
 w+AKF2ZlRKUYST7f8mrDhFzUBjtw3LH35aYm7vbkjNSvIqBysoh608rxEgm4b34TowM66zV/Nf9
 QqTSGD2ABR6VNFcXYYXaRDusP8iY/RNj3MRo=
X-Received: by 2002:a17:90b:4d8d:b0:37f:db06:229c with SMTP id
 98e67ed59e1d1-38942f7105cmr7852570a91.22.1783622564153; 
 Thu, 09 Jul 2026 11:42:44 -0700 (PDT)
X-Received: by 2002:a17:90b:4d8d:b0:37f:db06:229c with SMTP id
 98e67ed59e1d1-38942f7105cmr7852522a91.22.1783622563682; 
 Thu, 09 Jul 2026 11:42:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 11:42:43 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:01 +0530
Subject: [PATCH v6 2/7] dt-bindings: display/msm/gpu: Add support for A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-shikra-gpu-v6-2-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=919;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=e0reXjU4841qQsB76OT4bfKmGmY/z//RRWVRYHDWGzM=;
 b=U1bXBRrZl0X7p4f7phkaOBLRRIm0dBDAxAxqeraekRPEoZjymcovUAG/9AJRQPrN14gyQCzS0
 cOS+uX42ydIBnzzAcoCdQhe1IOFCJGt5PmboodpVnhVnhZ62hx9ApLI
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: sZ7Io6W-2nU0XPyW_UtnkwPAjsIe2CZY
X-Proofpoint-ORIG-GUID: sZ7Io6W-2nU0XPyW_UtnkwPAjsIe2CZY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfXw3UIJu0CCwyZ
 BG/LwMzIBW1F3qQxVgOurLXCGJYAFnghEvxyVviWmMQK6X+GmdF8XBDWJw5FZK+M01BJuhNG8Z2
 POs4t1hdGxXcC5D88KgxwBM/+fbPXc0=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a4feba5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=0BLMfrXV4dllX2mv9u4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfX+sz5hSBsBrmV
 VWfTvIwhZ96a8Pg3mqS6C5mztDXxm91wCoih65DuZNClHJQ/qB7yD5eFXEa10pu9Tmf3IsKqrs1
 XaKpl4ZCanQ+jwgbUHPhmsLAZF//PQZG38HTSguFpWtHzeU4BEo70tPG1ZFHAcoDM7js1kbJWv0
 1xg4JZ+YL8cpW7o51Nx/YGqSNJ/JQO5E4MCZE0rg4VL8A/UR1uH39crqaX7Srz8uJ3Kf4kAGXDR
 9Oyec0+8FAA2KqwVZu2UJxce6al07xqnTROq4Qc7oz/xUhAJPPCGn6GGx+a6t44Nd6Ml6hOf3sm
 +o06GVmadpyVWZNMftVUni9mZGp9zBCisUVbFkZIPZyH6nWGDBWt18HCzATIkRj+hDN+reTXl5r
 fVV7kIRVX1ghF/qriba2ibqTjS7rOeouqDJES7I2l0k7z3BOuejT/GcyOX6VZ/WdqYWxNy4aPsz
 VziuampjGoz/dGqjKYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090184
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found Shikra SoC is an IP reuse of A702 GPU with very
minimal changes.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..8e648bfb3b23 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -353,6 +353,7 @@ allOf:
               - qcom,adreno-610.0
               - qcom,adreno-619.1
               - qcom,adreno-07000200
+              - qcom,adreno-07000400
     then:
       properties:
         clocks:

-- 
2.54.0

