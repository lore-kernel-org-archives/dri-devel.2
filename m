Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA25D39410
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF2710F167;
	Thu,  2 Apr 2026 11:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J1/5sBr6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HZF4tNES";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5933E10F0CE
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 11:45:29 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328Rrt7352074
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 11:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tIG2xvgV6IOKPVH2TH1vWUTW9m8rqa2zF9dGwt1d/yA=; b=J1/5sBr6sjQAQF1X
 a74cXMFfGzuJXqIcuemsfPTNjbaEwTExshOiHrevNl+epT++eRB9XzYP2Pd2AzGW
 7uZefAHjQ8VXwOXH+4Lk367UUI1J2XccH4TVoeaDLRlX/7bhczEYqhYKdEfr/g0q
 f2fEdqPVMidG7B+qPBprWzApv6vuJU2g59X3yO49wFLIssDZp6VHjH/ZV8sxm2YV
 Hem+4GxmUHGPd7YdnJo6hmdudA6eH6Vk4S7woTWCk5MZ8Lo57MBq77jIEsaPJnDe
 k3uJHr7rjQx4nmQjlYPmsbWwCO1M7wkecOgMjmoyUZWhAi6PC0qHa35tLa1CtEz4
 3jk/fQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9myh8s3b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 11:45:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4031b86dso26152251cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 04:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775130328; x=1775735128;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tIG2xvgV6IOKPVH2TH1vWUTW9m8rqa2zF9dGwt1d/yA=;
 b=HZF4tNESnfe5fZZC3CCWYv8rkR4CshCr97LsmFuIe6U0RuG9n1Gy0ENYHl5PWCLLdh
 8850osu6iJlhChdBuRNCJBEgNUm2uE8pmnXESrJuD6J0THIlfkU3rdPGdIxw5R4bCMaf
 PSE6cOSpPz6j6VsFaGS7lVmjadTJh+yhpSJqaQh5tBdAkbYhefhsLjgGL/Oe6w2DmDF5
 kHN9UO6KXtYryiOXkYD/LjJ6aQUqFQDbj9t5FWYg8571GPx5n6sXbGz4O4aN7QyQIPz1
 fzy7h4YFb6a6pKRQ7+bfXF1s1tKjoDKqEOjUoOZH/KBmod5zjWTkwL9ytN98/CXny775
 UBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775130328; x=1775735128;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tIG2xvgV6IOKPVH2TH1vWUTW9m8rqa2zF9dGwt1d/yA=;
 b=QcrurW2OBDqr18Lt4ZiU3j8mI9o8XdUgWAy6DCKiAF0YuJqhSentAYbIES4OjWUg2l
 O17bH0duQu1RbFjGWvd2QhZ3LyZM2qC6vrMX7GFhOUtppnBrF7gVO8bLuX19/47xoDFE
 hnDccoM0ITC9zXAkMW2b2Nj6Hdu6EdYRcQ61zSsMDDQm49mJAwU6IoIt6/XBv2Jfplq+
 TUeHRUPQ9kzFIx6Vav7LYgAUZIpzXbT0kHqlRVK7fd3m4cF5eGxNj+th+7qKSCAhhNPW
 oQeI+BU7WtniiMDnmC/65psgn4V2AkAf5THhYwhxmz3moTfAnSsmztRKUpbUVWtAHMvS
 i5Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEktH2xuEJeiANoCkKKZUww1VBaSMjxcQ0vZ9qb/gcdfQ7QUqxW+hZxTKCQXODeUMdkDxRtRlZhqs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZRhgQ5Vm0pCzYoIL003Ljtp1IvE+V9yyrgZqvqowmRqoye5Cx
 yKXr9sdg+BYWsfcgcICWx0Hb2z2f1rbpnpnLl4ohU+2JoS/gL0mLrX1K/qTqZDpQeJekq2b+jY9
 k9jilfkCoFYLapsAQyHbVbrwBYxw4XduS2K4SO3VrBFhmG2ahex60tx2DFwpj+CQhi9lXrOI=
X-Gm-Gg: ATEYQzyt3dCSc7CIfsce/VwFsTfBJtrbXGHFbEJLT3ro84hy8wxr0AgHlf1Vft7m7KG
 uFJCIuqg9GgfQGdyagn06cMzsODU8+tZrP/hLItP5tZvLTSRBrOsjnWziTUtR6dVDWPHFTG+BUy
 MOpg5JQiewPEpSnO5OvaNhwV1AzRdcVDe+qo6285j6aWcZQR141+dqSGfrubqgxaFoIVIrpnZ9x
 8s9PEcgLMTEQ+poaHKH51mjUawtfcH6lXbDWcdtNLeGaaBqPY+wHTf3XpjWuwdS1eb7U3oGtCvU
 qJOX2DmEsMvdGMBqaGyUqMKhih2/AwTJULHvxnvYkaG3ieYIyLffG8ICNLbW8aodZHa4yZFq8wt
 4bARZQezdV+tdMiVUd2vBRBWevSChqEtp4hpKoXpGUDq4
X-Received: by 2002:a05:622a:134e:b0:506:a289:fd3c with SMTP id
 d75a77b69052e-50d3bba7d2cmr94103121cf.17.1775130327599; 
 Thu, 02 Apr 2026 04:45:27 -0700 (PDT)
X-Received: by 2002:a05:622a:134e:b0:506:a289:fd3c with SMTP id
 d75a77b69052e-50d3bba7d2cmr94102661cf.17.1775130327185; 
 Thu, 02 Apr 2026 04:45:27 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a567bfasm141614635e9.0.2026.04.02.04.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 04:45:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 13:45:12 +0200
Subject: [PATCH 1/7] dt-bindings: display/msm: dp-controller: Correct
 SM8650 IO range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-dts-qcom-display-regs-v1-1-daa54ab448a3@oss.qualcomm.com>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
In-Reply-To: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yFoXFf2bQiJ8Irz9zLQs16efGTfbjry6Zus7oX6VYmk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpzlbMhaJlM5JSVwMAALvqVmHKm9lLQ7xjs1HiS
 iEBdOIN3+WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCac5WzAAKCRDBN2bmhouD
 1zPED/9uDSc7TddNfSBSa5SWFEv/4EVT6Qmk3soyDZgCj6SzW/PH7ZIfz+9wOXzTvM9FhVf1ldI
 D94hrE1cMkDDPMS+wezFoGs8zkRtjW1eVjTafmWZqAepC4s7tEyG/cHDX3hQkB/yBqtl7SiBCPi
 3tHpZfK3T6LmZdF6sgiEnF8aROykBqJT7yn8dCz9uxl2oFjsT0YLu7dpc8B1uzPXmvnp/0YChxm
 zs9p5cHFj9g6FiOK68HbbZcECHWqSyRa4zfankyNOLiA7G80PoSEW+lGRCOEL5DonyvndapfTuC
 p/TUUsoxvNOE7pjVPQobYRY32aI2Vh8Agq1uF7QzoEic8hN+2J/gj7//dN29ilh7oagIms2zMNo
 Z0bkqJWwlN1ftBk/vB02aQJGPNZlXg+RQ1pBmbMq/8n7wL04Xt3Bhob2xgU/zCNLAVEIACYV5hN
 c6XDSCH+v93rmL4NgOZVqyOMiFfRxTKaUrXUOuH2vwzgxgUfHPqki8uW86ZuBc/XX/73ZBXuY7l
 j1rRXwIgWTwtrXcmc8zqOlq4F9Xys5AbXmUN3VjdXzUw6NDSTFy7kJ78IBO1sSqKGksZEgq60Ta
 nVqCTZDsVNAdh0DSTp0gNbgmF2HT0FoSqUhqZ+jbi+dg8VvnQjcC8szOYr9lXc97QTpdR6KOL/c
 d5OT0KoOM2N4xTQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 0a7Mhg6BCtHv9S_5bj9IIkolVCajPeKe
X-Proofpoint-ORIG-GUID: 0a7Mhg6BCtHv9S_5bj9IIkolVCajPeKe
X-Authority-Analysis: v=2.4 cv=JII2csKb c=1 sm=1 tr=0 ts=69ce56d8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=LQzgrBLVQjxtG0neiToA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwNSBTYWx0ZWRfX1yGvUe7dPweh
 q1IXt45Ghqw+i5J8G4Nvgq5Fgg9Uc/WQKKnw51LmCt/aKlXNpIl2nEdMylnhJ0NjY99qeZAS+Jf
 RqEgsVDrt/UgIUMc2CJ5uo/4c8dTangHLa5gW3/zK/AUgfUyFZxHlUGqcpblEZH+2xpevzTjZKK
 ejFwT28gMJUM9WAPS9BOlQOcdQIIO3Z8Ad9NwacHcebDADDxttOTHCkLd9b/FKfyTlpaSzsQBiV
 JJxnRrlundCH8wkZDTUhP6LeSjJnQAw0V33b1RRoogzmDN19J/6IihthlcpcPFxw9qs89predYS
 UhAHEqDOsKGAbw4FW9KVlmEoHDie/kykiMzGAZyz6vPyQxelHEVxyZTEj+kyePejd3/M2/RNE/O
 5ZeFq0x3AADWAXWqfcQlIOety7Z+UPKH6TqtnAevPbuDd0MAAygXMMVKodW3wQ5nXe8HSkFmxRw
 oCpeprRwLaXerzlFFyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020105
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

DP on Qualcomm SM8650 come with nine address ranges, so describe the
remaining ones as optional to keep ABI backwards compatible.  Driver
also does not need them to operate correctly.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/display/msm/dp-controller.yaml           | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 8239adb7f7d3..e4f17d29343b 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -277,7 +277,6 @@ allOf:
               - qcom,sc8180x-dp
               - qcom,sdm845-dp
               - qcom,sm8350-dp
-              - qcom,sm8650-dp
     then:
       properties:
         reg:
@@ -290,6 +289,24 @@ allOf:
           minItems: 6
           maxItems: 6
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8650-dp
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 9
+        clocks:
+          minItems: 6
+          maxItems: 6
+        clocks-names:
+          minItems: 6
+          maxItems: 6
+
   - if:
       properties:
         compatible:

-- 
2.51.0

