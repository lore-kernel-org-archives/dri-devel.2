Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E361B106B518
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B5610E22F;
	Wed, 25 Mar 2026 12:22:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hu9JckLz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i8O1ukUi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D635C10E22F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:22:17 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PBGPtp3922774
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=eHIn9NS0KiffR+kOG1GENdB2A7PEdYJt6Dc
 j0vJAwP0=; b=hu9JckLzgxV9D1/XwASg1OCyoW2Piy/+z7cf89BHIJMasg8LZI8
 lirq1Yk8Y3k+O0/5EpFpHV6lLqiImbxrXS67v93A7T+T0Pzhh5bdjekRTV1PADdA
 ozQaYRKqeO1BWEkhoM1YsDP8Jw71TAPcI/XV5XvsJikoBOWD1jSRtT+yxbKtG7AB
 mmKATCnBOz22nbygfGx27UKX4/w5JUTdtSh11EYhAqDRsYnjtngYgP4NZM788h/1
 qLG+mRgmNLoynPaxAuDOQ557x8dBJpWuk0mdg9yK7jNd5tAkj+xxrtXbo+VGwcGc
 FHkAnsxh4jAJgHoXC46GpfA5KV0m9dZLxIg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40rau27w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:22:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b878a8c07so15605251cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774441336; x=1775046136;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eHIn9NS0KiffR+kOG1GENdB2A7PEdYJt6Dcj0vJAwP0=;
 b=i8O1ukUiBK/MmJMrrfoVSbksxiyLMl0NnQaqBZXVrjCpLuLNPGVTezxCFjGkW8LKn6
 Uvnc/NJurCcE3q0HGa9gvN+4BulbIyYB6PpERaESsXPAgotLh6WKAuCrGbr14nLU95wU
 YG1I3lppwWJja/EIawfLFQ06i9ErsYlP4i4VGrdyA9AoDBaopLZpcXNfTwbLwVrlaUKs
 FtxP6xOe/ZTFsL2bVTCLPR9MpBsN7xidndNV1rSHOn0M6sSgjpsQSG5e9trqXJQN6Duf
 VbTqrb57yMdeDpqsbP3qkkD3yLNY0R72HGVUa1plOI/M4Vzz1jsM7HrIQG2+0WzEqfqA
 wnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774441336; x=1775046136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHIn9NS0KiffR+kOG1GENdB2A7PEdYJt6Dcj0vJAwP0=;
 b=sczqcLkBvrVwiBxRv8jG4SeW6MyT+8eug5h8uQCrERfT+ZnwCzswWiHoxChkCvfYH7
 yVEmDmTrAhjIlmvCvAzssHjtRMkOmpcWo4aBkX0QH18k/Ut/3Yfu49Aw4bQSEjeujxyP
 NncTuOKdOn4TS1WqLiHUojp+jc+CP7jAAkP97QaJsqQnNAaNsr8qtxMReElNJjeZY9cW
 eqzu7QrR6juslaF6nbczJNhJSWYVj9CK1nNgpCq/m9gYGc6i8aVBq8RAFdlpfqewpcmZ
 HagMUArzKRqcslT6zDf1QSZFau4jLxK2E8PMwQE/KZmAucWivymRjD2BFLJrZzU0WW5m
 N7qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1EyInjFxY2Y/8CxGcxQW4XKH4eshfaqS/gGpvp4XhBW4TLZKhrUUiPn95lcepgEMc0KNWF1vG4HM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1IYu7H+oJwk+9B9JHYycO9OqoKf1hWOOzflO469J9/OCNavxf
 xq7RsvMn0mhPAt5eglbzDDQjOW1OuWUMIKt0yqIEk1K2hv0OqvdfyoG/7tgPhOCgKDQaxUe4LX7
 JcEFidBb6z+OI4ncWurPiVvbPyJHoyB5rJMrw1f+ysdoH8JtrgjRfXrtB6/EtAs///cCHDsU=
X-Gm-Gg: ATEYQzzzB4YvIkWHPo8DUBP6HzQh7HO16kD5jn8ch1s1Z+WhA/V5Rvp9HhixTaXu+VC
 ALby4z/voXut4lMi2D8g2MYRpVTH4HiyavB5cXQduT/9VpfU9bny5h4il5Hj8SegxM7ktXGsXlp
 /c2yjTS5gHrsuhwqePZbXw3SLTtyihNq/B5sNpeUpV0NBnqh4xOTgCb5Um3jBhFsTBuIl2borir
 hCPhGqQo11hfx3hBT/X8B7sc5yqGC4gLTuVbQYWUVvqUulelht2SdKCrf/p2zkNrUg8tS9tc2wO
 AZpVjAcSwaP/up3lcEnA892dHa/zDvc1/9HXvTtqBqMHcAH12H8GvCn8AaqopvNbReetRUCDpTR
 Kmp0QKIInnujSXWXur7VUT7FWdi5bOagq0pjL
X-Received: by 2002:a05:622a:356:b0:50b:51eb:c353 with SMTP id
 d75a77b69052e-50b80d3aef2mr44187101cf.31.1774441336103; 
 Wed, 25 Mar 2026 05:22:16 -0700 (PDT)
X-Received: by 2002:a05:622a:356:b0:50b:51eb:c353 with SMTP id
 d75a77b69052e-50b80d3aef2mr44186581cf.31.1774441335439; 
 Wed, 25 Mar 2026 05:22:15 -0700 (PDT)
Received: from quoll ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48717346586sm22144265e9.20.2026.03.25.05.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:22:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: display/msm: qcm2290-mdss: Fix missing ranges in
 example
Date: Wed, 25 Mar 2026 13:22:10 +0100
Message-ID: <20260325122209.147128-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=QjvkBHN0Ynt5Jyhs8+7uWPeH0tUdVFEn5b4Dr7UXA5I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpw9Nxm5PL7JhepvBXiMriG4QHuwZe/xicXV/X2
 LdVPi64EcSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCacPTcQAKCRDBN2bmhouD
 18VQD/9L9YY50PR5LIozttUq7VvDc/Zav5wjCsy66HYEO/CviFL14o1VuslvysysQHtUAQUOxfs
 ZU4he2eeCYS8g+6906mvRZeyDbYC9M/rs9H7OJhXtq0Jt0g/olh1tk9AGC/pLL+BOoP0e0YLf4s
 MLZcSu2CLsui+L3NwTpRTd6Zyurva98AwOZLeG4nCT5RD0BtiOujwp7vpLAIIPi++Z4EX3NHtiA
 GquD3taiXqidhgJSncgiKG0jJu4gzkOnwUqcNtE58FA0N/qd2VhwutBQEO7Wi+eAg0A9q8t4eCq
 Qfzlo7Ww1rllJtyL027qkWUfBSROzTAduF60YRZhrf/pgMu+nQ02Fg4orw712WPEV6LGBIztyTo
 4TCb23Ifk/p+3448PvxIQIpDGmbgDI5UgA4p+K/4xXcfK8Gxfr5ac6DgimoXvSLT8zBrpP7LpiA
 l9kxS820EG5annExGcaP2T1coGknn8VKrlUyYjw5WdO1w6NEDEz6S3PnjQehZr5VlQvj/N+VOUX
 ymmtRF5lOciXhs5cfqUjWXkmDgsGfJnhijbWdSkpJFUFE7qGSqe7tIVOKb3cCdAfDgowZfvh1b+
 7QBW2mwx31Wt+qILUO3m7t3g1RLVvvM3R8XY9R9bkySKnjmxuUT6RvvOVwwAyn87w1lTWjJfY8B
 mjMwb5NUCeh2Lhg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Jvr8bc4C c=1 sm=1 tr=0 ts=69c3d378 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=u0WoYhsv3NxjMHURO3IA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 9znQ1d0jadsDi9RHVZ9_V26mGKRqY3FO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4OCBTYWx0ZWRfX4WpbGUBhN+8b
 zMbYX4JJwxiDGDGdtcazuLMS1Xqv6zqIXlEuAeGjxB5Ak9xBuI0Mqwmna+E6NAjupLSVuk3JwBq
 /LZWzkMyNdxUint/Kb3uK1nV0NlMh6QFMHZz9rbg7nP4L4XpZtkXQ36hisHQc9pJmDrAbv4/cjt
 kD3cKo83otOwcYLHQClObEiwaVPxlKiche84wwO8YwBvstv67So6fqqJJ9G15kFhIxTNan6P/oO
 cUQ7YbjTTL0AfL2CHwR+VRLnUsZ1zWBXfaH4/uWGnvLqwA0upxbKDW8MHUEY/yi4OjjxpSCRsh/
 uLc5FfvbAe6ZGNUdOtxg2ZnySpUYm7RLMcoY4TrRJf2eO3P7+jQlqlTHMKMd2LKwH+eV6OZCi+H
 HjZe+d3T+bQKCGBo0gsPksOajLiT+tF0ytuhXdWLQoT7Cy1TGraupJnEXcWB6U0saYGTIRVYzlJ
 xI4jwTtPfX+5m/svDkg==
X-Proofpoint-GUID: 9znQ1d0jadsDi9RHVZ9_V26mGKRqY3FO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250088
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

Device node has children with MMIO addressing, so must have ranges:

  msm/qcom,qcm2290-mdss.example.dtb: display-subsystem@5e00000 (qcom,qcm2290-mdss): 'ranges' is a required property

Fixes: 966a08c293cb ("dt-bindings: display: msm: qcm2290-mdss: Fix iommus property")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Fix for commit taken by Bjorn (Qualcomm SoC).
---
 .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index 2772cdec7e42..bb09ecd1a5b4 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -108,6 +108,7 @@ examples:
                              "cpu-cfg";
 
         iommus = <&apps_smmu 0x420 0x2>;
+        ranges;
 
         display-controller@5e01000 {
             compatible = "qcom,qcm2290-dpu";
-- 
2.51.0

