Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AB4C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F20EB10F71C;
	Thu, 24 Sep 2026 21:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JWo81Lwn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RXHwZTeo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DC410F71C
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:10 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdiWH2302224
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lF+gxAigVU/m7+ElKGvkX2R4rXm0TJ6E4w3e3hNT648=; b=JWo81Lwn9dgoai0l
 c3dcqR8PoR6qSuPZqqmIpd4AewqohFeYIuLTUqiigi6pTZ5dGbSWvWtbhn3YuoX9
 QYNYjcck32v7N9kYlEVuz+6RKq/TbyX4Pc08cfX1Bfxg8sn1HELDQFFijgzGhP5R
 DP6aDbzMbTgKF3zFe/XWDP4udG/RZCxrWF6yOwAX0gNqnN/Asi9mfOrPfY5Q4Whi
 JviuNifySegKu8srVkbLlKvxGzn50wn8yfktuBbPxjWDJru9HtPuWhV5CThF1/yD
 9Ql6p879dWrSIcpd6pDOlX93/OjLc/lIOzMoUJJUr4AYKA8QJZG7sx/+43N3fiOJ
 N6qEhQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1t7tp1n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:09 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1437272611eso426245c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790284508; x=1790889308;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lF+gxAigVU/m7+ElKGvkX2R4rXm0TJ6E4w3e3hNT648=;
 b=RXHwZTeo6ebhX8Z+nYvTmhYrV2P+tTuXu/njKvf0nhynz4T4PjOfk3nyxoWup1Wrdh
 Dk79DoQFOyN4/NBiNc+6HNXv2hysqZGLyb0yNB/nOiLFbyPQ7JQNed/NL9u7DFh6Egl6
 PsryMJW/4zfP0T65hIlY1WHn5B+qB4hMOvrBJhf+U2mKHlUWPWMo50EhHLmqTTgzhRQD
 jDsPUNHWL5RJ3nodnXEiTUFUiXgFknhkgfh8HaaTz5fhUHk2Pa1KMOtJwSDVtBb6cYFP
 WwkvKABBlKS3frRubNGyw07SJfxW+CemHowfBHgvOonrQfWQpqFbIrQ1m3/TNsRKMfEO
 vkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790284508; x=1790889308;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lF+gxAigVU/m7+ElKGvkX2R4rXm0TJ6E4w3e3hNT648=;
 b=ysFT64s9rS5UU1IYoZGjWX8ErZbA/tv6tKYbv9BoXqJBzzbCsPBvOajyM4QSt3VaX9
 hLRPqieUY+YwcSBAY6Cl5vAdHkPirwlDM0hZOJLk7OrVBlhv1uNKwTpzsceyBK1rIXEh
 4FBiQWYgoEPebTuAR+W4wyeoej3lAT1cs2NGsU4OowZLeoxiGQKTBGacedrz2Ployftc
 NrwYdpI2mgeCKUGeVec1dBAZXfVdqKJ13k9eSZkm4OpW4riacFeQr1uPxHtozvbTYiSG
 oRJUlSfqNVkHZwV5KYaHXOzb/9EBCOOrrdpzJPr1hBLjFVEUQqjhQuecHc7twOhV47/n
 i3ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVV+HM6c/NaprJIG5xOMXFS6PnpIgNvHzRtg7ew7BVqHCsuG1Zi2a4TD6MN6stUIxmbNUFyohyB9Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kFeds0htPGXeWYz19mc9XYaMQJsuzeSoMGk7YtiP1PyP7Rswl8
 7LGub2Jk7Te7rv0prZ+SIoe6BNpPaRjAC99mXnZUTTx0YEsZTiCiNpMo3TaukhJfOfg1NnVw6VE
 YvRmtvknVCJZLEBiA+ZHbXx14ByeU/mEhGifQxnKEBzbK/Wf1G49D0LzWjbp1pLgXqv1QI7k=
X-Gm-Gg: AYBFou11vd7ps5HhaJoTklbHBuKaaYiPm1vwsgMuh3ptfxE9bn6RRaJ2CHdK449ttfT
 t61aeh/4JhE912Y+GkWarsfclKAoEXvW+l4vQxxLEvgfjdDBgbgmkppLxzsh4awkwnynYVqtmXO
 uyYCJZOHPpQtRNVqWGy6ED85ijJ3T0mQcJL02cz9Ym+XwwjlCNY5mByl8c5trF5ajKb/25rkQVA
 XD7XUmvTQA5bf7z3C1b/VFW0maesEmE0pSwljSJIHBs2sGJSTi458IH83Jp6VwPV8swOvnT+OkD
 zApJfVix8HASG9aQ4DHFeCpwwFw0YWIscf0TYH4tDqPzyACS9CeLachAj3gOBVb6Q4xTcg91p8B
 orl05N8Ak8RlckeEVZs5RBt0=
X-Received: by 2002:a05:7022:b042:10b0:138:243e:ceb1 with SMTP id
 a92af1059eb24-145ee31fed2mr65437c88.6.1790284508157; 
 Thu, 24 Sep 2026 14:15:08 -0700 (PDT)
X-Received: by 2002:a05:7022:b042:10b0:138:243e:ceb1 with SMTP id
 a92af1059eb24-145ee31fed2mr65395c88.6.1790284507526; 
 Thu, 24 Sep 2026 14:15:07 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acc47ab8sm1323776c88.6.2026.09.24.14.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:15:07 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 02:44:32 +0530
Subject: [PATCH 1/5] dt-bindings: display/msm/gmu: Fix Glymur's compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-mahua-gpu-v1-1-0fa0bfd8d315@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
In-Reply-To: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790284491; l=990;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vBx0R2OyV72sf5hsevsW2+Rls3EglXdhI1k1nSVuKVw=;
 b=sgeiFAd9eIvzTIRaCGvOXP7QXyzoG2PvcI6ipCqovTmf+AMrfQxvG26DpaeVHwXfRp06f9lvo
 2HniJHHfi7JCjVQLPBPiEIypVgcvuJKemQwCT1LP+M78btqDHWmAdph
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: Bu_meUkdW94RSVSBzEBHyxxTEESgKHN_
X-Authority-Analysis: v=2.4 cv=U/MHnuru c=1 sm=1 tr=0 ts=6ab592dd cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=RKY47XI1zMLZdt3AztIA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfXwTO05K2kNY90
 EioMhKC064eZadPaIZJkrEITKdOiYEFZexGLNX5HdsE8I2lwjDAA5j9KCgGKFr1CbuDIhbO/nM6
 wEWAz6HOSiWQ1iLzWORYGmqxKTvs8U5KowDEn89myNhqpfGp6scES6148+xTuc5/moVS8tx87/N
 6sjPfcZNi5L7kFt6cLbszyZHB1Cp/V/jdjmt92o7KeTIiLLAFSTrlMkx9mtyiKICcaBtvmHCKOa
 b2m2DXCQStWReBYyOUAvDBtEHBjD64TyE9ErmR3/AHdcQBPtfOQsKFsnQylDsOuwvyTqhDKykPt
 7FSkKW2r86/Kc9rsHYsm2RkiODOXyP0Rx/hV32wZnw+zXej60NjWJ2v7oRPOoRPXNZaGN6Eb16a
 LnpcNOvKTm+W5R1k1KrzIAmcXVYxWvzV6q5+WsePIhS/y49+210BceSFEVbpacENzm2hiYdW1rK
 pffwEAa6C47QVNPv52Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfX/sKM7nIivez4
 p72fo8pKzjsXM/s94QcZMJLawUdp/Yj4kQD2witHOpDz08YbROeZfC4zVs1AscHVSIsgL6+PdG/
 U44vPjv9INSSjgw7PH7FOIpRTot09uE=
X-Proofpoint-ORIG-GUID: Bu_meUkdW94RSVSBzEBHyxxTEESgKHN_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240086
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

The Glymur GMU compatible string was incorrectly documented as
qcom,adreno-gmu-x285.1. Fix it to use the correct string
qcom,adreno-gmu-x290.1.

Fixes: 7bc29d5fb6fa ("dt-bindings: display/msm/gmu: Add Adreno X2-85 GMU")
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 9e459f12ce3f..f22661447e7c 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -363,7 +363,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,adreno-gmu-x285.1
+            const: qcom,adreno-gmu-x290.1
     then:
       properties:
         reg:

-- 
2.55.0

