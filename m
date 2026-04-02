Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66E1D39415
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49EAF10F1D0;
	Thu,  2 Apr 2026 11:45:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZFM4J8OS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hik/SuE1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9876210F1CC
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 11:45:35 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6327Ht5T4009493
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 11:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9QQr2yUYx0BXFI7syW/yH5UPEP1YMmo+Pqs0/TkwKi4=; b=ZFM4J8OSQ3e7uy9o
 eQkgGDHQ6aikJCyPH7lrkqLdYS1CzGpcpSyq4kdL43BMbMwOBSHJG0j0gnQpbCkL
 fxOBr2FQWh/KANoFqjtETOI1F1VnsXfXgTPG5G/3Fjm3syn1nnH85owd8L2oSnPy
 NGZpVKcBkCZZ+8iThY+cp8A3LXXHidXMJuoVx+HGKPkH+WtWYPkmmUzMS1hR48Rt
 w3mUf36HzbBsdT3PfVRBwZFjQtoORSiYx/d6DLZD6ChGBTsjvXVj52YhEnEvkBEV
 pymumDYgNsNOGIMxQDAVNa+ZAdIYxQrihyNjKuSVMkCqp11tWsutE+D82q6APw88
 f/jI5w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d97e03u2f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 11:45:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5090cc6a7d2so22428371cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775130334; x=1775735134;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9QQr2yUYx0BXFI7syW/yH5UPEP1YMmo+Pqs0/TkwKi4=;
 b=hik/SuE1/wGwALgpaRbW5I+quCSQ1Wj2HIAd6vrBCPbSFLNBe8wp0cs1sz7yCk1t7r
 i+7B/RSLSE6vXQj2cHPR2d5NheORWtxG5zEq5WB+1GeXYTkvrl9OGnV30zPoq2whuW+S
 5lqyYnuiCZ93SstbxhUdo+ZPpIrfvGF84zTLG4JqNJTaA5Ltt7h5gvy1oMCq/6NjWevk
 VM0R1SlOGdMzRLPOadUuzYEw2nRCNlirt9Tk308Ysw1NUfPkBycClIPZHUC7llc8zlCv
 sZ1xD6wWrEX5moh4UlkYglPBkj3fPpYm5HtWfIHKsQQeP5ehIjjhRrZp1tcJWGyN4i7R
 IqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775130334; x=1775735134;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9QQr2yUYx0BXFI7syW/yH5UPEP1YMmo+Pqs0/TkwKi4=;
 b=BXsWvrtvtyRExdx0XNnKI3Gow679DQBMJy8aSRnrFeAilp05CI01Qak4edsqXMKzgT
 0tX1oxnb/5FV1VXKwvXrGjtnnC3ynedGZy0Q6+GL90gr7ZKmU3FlamUgsizSkobgkLjs
 nUwh0Q9TjoTJPG+F6eUoixjikApc3BOmx/Bd6h+nKB0elQW1lXl92MYXLKvQ1sijpnsI
 N1ceiNnkADKTrMQGGJ/jaAkRGobOaHjV2IqGofhUrqLympmxj6kgRFPAlYt4X2NYhZkP
 f4yd0buslhlkxPywGt0hridV77W0t8fLUjGtShHVrS6vaBAe14n3yTZ4MKuNLnUiP4Jw
 ffkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj4As0MYCQCmRsrehA0dno1bZOMmJ3XTcoAHSoyLvVuBtiWPYPwNRJtbZIHMDgTu991a6uoHAtbHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8DaCOCU8zhi00RO9vMLJEQQhcxneeP8y/NKinHdPLke8A8vi4
 MeFrUSTnbr5gl/yYQK7z0eoETtMRSVNweMN13VFypPiFcLRQCcouvUQ+MG1RW3uGQaGsfFU+3wQ
 jNVgIMHaGx9VbW60T0nJ9fFPlFVgFktLmfPPL1tgV3LNgfayblXPTPzorynMu3fNe/I8I+iY=
X-Gm-Gg: ATEYQzyEQQgmqHGB+IvD7yq5qIww5Q06RHah4norAKHlbUBGoFhyjGXMygSVSlL3o6f
 oT/tofi6RLijSdSVDyFMg70tqotAL663bOafxnH23ZNW4zoBsmHcX+Ujz5vSGcEImEd9jUcamfC
 2CzH/xIjq5MQM5sZObR4Dpi2K85qfes8NXvDnVRM1k2NEzDbCN/qhItueBhFsH/bQg4wPsWXKTy
 cZhWP0s22aC0AzYrZalBKLpmTotzbElZzt5RAeMnzbwphkhjgep1ELGoEpBsrj3xdMMKQ95B2pk
 1cD6OJOvSJP718VkfldwCWtEdNdyKN6lGNT9/YSskJzZLT8CDJbjMW2BhTftoizbvcZ0xqfOjTN
 r1RrkurXE9pE2ckBT9AgTwN0k11cl61tC2ctTH27gLB1f
X-Received: by 2002:ac8:5d0e:0:b0:50b:3d9f:3846 with SMTP id
 d75a77b69052e-50d3bcf47e8mr96663141cf.50.1775130334197; 
 Thu, 02 Apr 2026 04:45:34 -0700 (PDT)
X-Received: by 2002:ac8:5d0e:0:b0:50b:3d9f:3846 with SMTP id
 d75a77b69052e-50d3bcf47e8mr96662731cf.50.1775130333789; 
 Thu, 02 Apr 2026 04:45:33 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a567bfasm141614635e9.0.2026.04.02.04.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 04:45:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 13:45:15 +0200
Subject: [PATCH 4/7] dt-bindings: display/msm: qcom,sm8750-mdss: Correct
 DPU and DP ranges in example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-dts-qcom-display-regs-v1-4-daa54ab448a3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=oolybNFYF2YC+JBXqETSseIPPbtOhOXk64H3MqKsvSY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpzlbOTL/W7oo6HfZihZ9nbBrijftS24ToZIGuw
 qi4TNrUU1iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCac5WzgAKCRDBN2bmhouD
 1w9BD/9wQTfAUcub0x9gCyELjdPbRWGEm2D6pknvFvy3j5g7GkW0MpxI6sTNINhwTUwec71uFeY
 ZUmGc2A52Lj1aCzyjDPlXEzeR6gbEp9t2qJOfmMALxKsMMByLf+z85SeIZEMyGqajnunh1Sl5rC
 ek0b7TLYq9u2rfguL6MwUw95BpsLPO1J8ZBH+Yq1Py6hVmN4Rh7mEot+8aVARyq+m2SBIVWvXLc
 WCxFtNPYBv9wSiV/I9TVP8srHxcE83zYssL4teMFCSj6y4gvb7qWUMnNopk8neUDUM1+89gHXK8
 AtBs2MdxuH+0xLwkzSaRhN0eH/ZGcB1dD1uf08P9lOv86oFHgGPbbcEHRVrYBa5TZsYwA6lCgnj
 X64uJHZItU9FsGRdpO3Qby4rCvaK4Ue+eAsWDKWk7nmLI8krXAULTnEIPxp5eo2W8Qf9cyWqJlW
 nM+WK5/yXKUJNOG0C0CqhjwmJ010NXgVd+Ql3UDWuGtcV4/kZ+yCyI3CrcAB5zms/KlQ5sPAMQA
 IXsw7zKMeur0O/0y50SJ6qkIFQ2ONRQsgDFQ3bO125wJTZSjtKkrGUcS6HSwHqLFt6edBCVHtJQ
 Y8iGbSX+4SLpHN4AWUCXgEfhL2LO8L4PV3qslO1/l5+u5KhDwGgGER/i0Y2DSbKfa8m2wahFGKk
 b0xk/3cV8W5bLFg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=fdGgCkQF c=1 sm=1 tr=0 ts=69ce56df cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=RlbI4P1zFy3kOpNnRyEA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 3fneHxxV_PPD5Vkn98KdH_LFb-uM3Ugs
X-Proofpoint-GUID: 3fneHxxV_PPD5Vkn98KdH_LFb-uM3Ugs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwNSBTYWx0ZWRfXz+m4CgRHIaHR
 7pL+s/kRLnGfjD7B7Yo24goKF2TX/1LY1ZYgJxaE5lvIIzYFyBKsVr3kP3a3TSPfw/Z1nemkP8C
 bfj5G5lOA33IpdbbTcx2yjJlwkLN1ogr2QUC+u322mhWVwVTcg1GZ7sfarPWYu8cyAiU8H1Fktn
 udOtuFVAd1MUTsiksgLcM/5f1V/LlGeFnhCulFfFRf3If6xpsUHL3YKtKUSggcbf+9EObvY1WXJ
 sq+NYegmylgzORwTv2BmLgEI/+6oVDAI/HNLwpX72u1D6xBVx5wNRDT8A/IlQ7pXpkH/EDxbYc0
 XkQMthxgbGin70hmme0gXAlnVSHKxJHwgqUBA/Ycp/5k4VO50x3IbP/9ySYQsJefi30rJn5q1Ff
 gPG+AwYhQG+dEsgzdplQZOp83Z7BkdQ1vcVpx3L4uX/9WRIvtvWTcwiAVzau8flL30Pqx/36i2z
 f9j0mSkB5b3nDAw/X0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

VBIF register range is 0x3000 long. DisplayPort block has few too short
ranges and misses four more address spaces.

No practical impact, except when existing code is being re-used in new
contributions.

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

