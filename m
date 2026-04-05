Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1B5E9D802
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F68010E255;
	Sun,  5 Apr 2026 14:34:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FjS2rqiM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NKDaB5Cu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D635810E255
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 14:34:19 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6353mfFn3015549
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Apr 2026 14:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pq0b4D6oDOEBLPSMi+uQ9Ri2dEKyibd7slMRg39VPNI=; b=FjS2rqiMBWsCUGJF
 +Ra/QhRB/mqTnHoiXaIT3c/G0RuITFisnBQOqGKgMSo0PNedMtZP8HJRXlMNlgo+
 v2B/XxrjECUgPjQZWy1Mfn+4wBV+GxsSxcjgngmyfmFNOORzocaMu1qkhI81yjNB
 ynmT75TqyPIScE1e5iW4DdCJOwoTb/XrGCS8ID78BnSe4mQdQUuezHXEHdHmvEqz
 b+cfk/wJHOx9Wfwso4ErZ/cpGK38689lFHkfmZoQrjCKp72YFjhuRm+GzoYbSHcv
 VqJ2hnnxQtNgT9GOMLmRymsU2/mvF0PlvwnTZQg35ymGF6ikw6/Lf9wxmG+HX1lS
 MskhQA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dasn5tr0q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 14:34:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d5aa81907so76986031cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775399658; x=1776004458;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pq0b4D6oDOEBLPSMi+uQ9Ri2dEKyibd7slMRg39VPNI=;
 b=NKDaB5CuGg4l/WkHK8beF5YNU3RTbEbZcTqDIACTK3dPRVaz6dmFRMm/Yiq+ciDyIG
 G7kx1N4IZIOiW0yOy+GiwNOsvUmWGJXiO+yEIwKCqBo/+LaSH0v1xzMpIqA7Nfae3G3S
 zPKHzgSJD7Ps489bTJZuv6wP8iBXOXfrGkZZPCgmHwep/Vm12b5wot3qxzYsnLroJBt/
 hhvVINeL2HmOoZW3lK9c3EynZcrAyedjFj8wMEUeU9pxu20VNCWbch384WHD4eOVixpn
 uVzHfPwGGmxWGTaD6OSwEYI1z4xHkaTZweUBC9jNNWKOGxqh0kGZSkvBC+m4tqA8XjKq
 3mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775399658; x=1776004458;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Pq0b4D6oDOEBLPSMi+uQ9Ri2dEKyibd7slMRg39VPNI=;
 b=AFqcHx7DcdRHxZKigE7f5rVhaxlVqu3GiRSv2hPVDLtGSwoT6XPJxlkscVS0BmDnR1
 Q4bnZ3rV+nQ6syOXSlz3bta0HRNQ4Ve/E7QiHwoBj7gtPl3ORnIZEwcFukBY++bNnP1y
 z+7EO7cPb8jIUsSyVWSJkdRsjKj+dAj9yzN6AL7UdzDco9ZxNS/lOTYB65I9Nb/JY4ME
 SWT5yppNv5CGRGBW2VdN9JKvQIS9WJQWRTvdG0I5K+e2P/787aGQlRFoERRNp0XM+iHW
 ghc3pVURqMKGaPzkjM1iH2hqnKVo6tczkqb6eAOoIEo7j2GUQwxG9vh6XYPv+W1o2Vpp
 x/+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpY6y7PYn5W5CQujrQk/r6B8k6dti2PrRGms7ZxeuPiLAxiBBVEuookapgHKZVaxQaoKcjhmX4r/U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycRKlDRyoVYRoFoegVlwq6AJFewUQz2C3rgkei5SMCRf9XWEKH
 u+01OCV3sxhyp/PQQ/bcgydqAieb1Vxj2fqQuwBY+klZvGvjuj8CZcODhJ04g7OCONljatYIaNK
 phjWhzvCg7xY8B67Pt0qylprktzIoFImKRwQJj1wEWJX0VJdTrl+T1qqNmV+xypV1V9me768=
X-Gm-Gg: AeBDietmV1u5oK5ldZeO2vd9TQ7zAN0DCJsn7lMcF3lwVdUlmGLYEP8eaeqqK+7Bqfp
 xoSDAt6WMO1h6aHknmKwuluQ+p9QD21TGqHGD740nECyz2ZkXyXLcqRoK3kVH4+q9FJS0P0ZdiZ
 PyCGqn8gnKp0ESqGGxxSinr8xINscPL73UBZu8eLw0zfBB6CJLaPIVYOVsP+yUjQtgz+rsvXT3X
 dw3X3mPHS5YyW/Sd+gbgvL5eTP/418qzSSbWxnM9z1GDzCjPoxubRS5Z9c2yZGAXvjlbYDDqMXj
 voggh/4PeLs9XcVsLIhsbpVUV5gVvK+3v96VqrvVmAxTkSAl8dSuAu2P20QZurkQwikTwl3mYd2
 RKTYwmIP6dvtmvebzsvJig97Mt+uqygoESje6dpum37cG
X-Received: by 2002:a05:622a:1249:b0:50d:8d63:3899 with SMTP id
 d75a77b69052e-50d8d633997mr23573891cf.14.1775399658299; 
 Sun, 05 Apr 2026 07:34:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1249:b0:50d:8d63:3899 with SMTP id
 d75a77b69052e-50d8d633997mr23573511cf.14.1775399657779; 
 Sun, 05 Apr 2026 07:34:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm713934755e9.2.2026.04.05.07.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:34:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 05 Apr 2026 16:34:00 +0200
Subject: [PATCH v2 4/8] dt-bindings: display/msm: sm8750-mdss: Correct DPU
 and DP ranges in example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-dts-qcom-display-regs-v2-4-34f4024c65dc@oss.qualcomm.com>
References: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
In-Reply-To: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=v/As2lgvj4nEccaPMNbc8+T6AhYK6KjF+ymCj5u1t5c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp0nLaE59TNemyZueMtXcpDVJZPk4CYrSmvb0D0
 vSqzVK9qMGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadJy2gAKCRDBN2bmhouD
 147GEACP+6i1YTGenGOtQGzfwjBkXETv/BUdW0/x/4jVBv1zNF37wBK7y3UxrXSF3P3B+oOxZ8t
 WpTyJEmTs9hOZ+GR8SRT3qChNN/UxFqX2qwmGetqvOXLker51fWoqecCCKkLxi7kkuBIhtFN+ch
 pIsiQDt5MwFOopTbZ3aUSTe4QnDoNyJcYvTx8RlytLwLeLK95m0FjxfUCZMJdBBrgq7+kebpNYG
 TF9zc4xikzuZ7lrIz680IsE032iEoQC8/F42jmO/bGlzYEFBaBn4Q5WicwyrtlztfHIxi37aNW5
 SFDUQWCXGvrg/mL337Cvazv6sLAlO0NIOEuE5ZzsSHPCWtINPlmUsNYHkReBzaVjX//T7OLTx2X
 j7eDIzCjuh0XATCuMMkM57sN+jEvYF8aKrrh0iO57Vk3nD7Uy/vnxSXhAn7TGnE6G+pGU6+9ZQK
 MlPJ8Dy+N7pKfcAQE9dhv8CISQ8dWvQM9JXn7ahW8GCyq7I55SB/lnw3v+ah4yeb2zWbqz2Hdlm
 h1+hjjKks0gs0BaZ3YWYQ6O+8PSx/vWQgKuzLi7v4svuRCV12f23AiIc2X3xTy4jZW5LKxIXolw
 ro0oa7eb67Zs5y8UZbKZUTELtZVQS+BC9TDQPlbrNzk01k7QOk3uadm8Ml2TE5AD02EscPoIZMi
 LYizeouJKzV7Yxw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE1MSBTYWx0ZWRfXyPrz/N3oetNN
 PJwGM/CZYiuU/qahdMjDk3NlF54q2n0TlEJxVVgwmcT4Pxda+3/+6r00G39Y+i/F/kIBkDEX8G1
 ARzrSYOuKFnEMdKYLOj16pKaK2kLKuSW/vR2ltdL67lBMybny+13x/mqA+zkzDutkFippoMpiuG
 I31NnAbI2h7fWESboL5w5QWBsjyyWC9sdQDIrW7ztmITO+ILm4zQSMDLv75Pts7Ua1TVPv3QJW8
 YKKYAjHIJI/yhbBXrVrTCmcbcdpDhW+JG/la/I3lrv6Qbg/B62Ujb+Fg4h3idRteqY76PuYbkX/
 YQV97C+5Ck5uPc1+I6LT5gi5JCjreE0JW1mS71pRwGlOhITtbAYwUWgpjkIf3TneeTlU/s/zrjF
 9jla588m6mBb4K1LbE2XknxhCjkOHQUlx6fzH/nzCajYCAeHtzqAP/qSSky6F/kaenrpBdwzTUP
 VbzfjVlpBr/3Bj5gFmQ==
X-Proofpoint-ORIG-GUID: q7n0sdQ61Is-EN2gazKJ-SkGCbWzK3mu
X-Authority-Analysis: v=2.4 cv=K9wv3iWI c=1 sm=1 tr=0 ts=69d272ea cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=RlbI4P1zFy3kOpNnRyEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: q7n0sdQ61Is-EN2gazKJ-SkGCbWzK3mu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050151
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

VBIF register range is 0x3000 long. DisplayPort block has few too short
ranges and misses four more address spaces.

No practical impact, except when existing code is being re-used in new
contributions.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/display/msm/qcom,sm8750-mdss.yaml           | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
index a38c2261ef1a..46dc0d28da29 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
@@ -117,7 +117,7 @@ examples:
             display-controller@ae01000 {
                 compatible = "qcom,sm8750-dpu";
                 reg = <0x0ae01000 0x93000>,
-                      <0x0aeb0000 0x2008>;
+                      <0x0aeb0000 0x3000>;
                 reg-names = "mdp",
                             "vbif";
 
@@ -389,11 +389,15 @@ examples:
 
             displayport-controller@af54000 {
                 compatible = "qcom,sm8750-dp", "qcom,sm8650-dp";
-                reg = <0xaf54000 0x104>,
-                      <0xaf54200 0xc0>,
-                      <0xaf55000 0x770>,
-                      <0xaf56000 0x9c>,
-                      <0xaf57000 0x9c>;
+                reg = <0x0af54000 0x200>,
+                      <0x0af54200 0x200>,
+                      <0x0af55000 0xc00>,
+                      <0x0af56000 0x400>,
+                      <0x0af57000 0x400>,
+                      <0x0af58000 0x400>,
+                      <0x0af59000 0x400>,
+                      <0x0af5a000 0x600>,
+                      <0x0af5b000 0x600>;
 
                 interrupts-extended = <&mdss 12>;
 

-- 
2.51.0

