Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F80D39415
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4689B10E415;
	Thu,  2 Apr 2026 11:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BEu6OxeI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bseQMJUJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF5610F1D8
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 11:45:37 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328d7aU1249341
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 11:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fjEXJr0F4HC6Q4F02RHzTk7Jk/5DjDFjwD5Czl3FSv0=; b=BEu6OxeIhV6UtOVn
 ybxuwhoOGQdPzGM9P5Qcn6Nje1/7rHah7r/F/2cqtLzqs6GpTZwTjWwb9KhykaPj
 mT7BUpON/qObRwsdekQIEqRfaAd4ucsLFz5VyAYt9cg/tbCohQ/+XHoSqzEblwcH
 L4cDVDtFBJ6y+ZWZZmwmMemuBugNS+Oi9ht/+XJLupgKRalhTvymHdffHSc5ql9q
 8t/zmsumqxxHrx3k/yiHFNnYl/Awb4IB7TKNO1Evu4ikkmBQ2snXYWUbb0xqWURA
 f226PzR1BdKFzS7Z/0bwlXZXkpxf4TV6PskXSITW+PtUzCl9eCfsW5iuNH9UWU+f
 rA3Stg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9n4t0r0m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 11:45:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5094741c1c1so22110841cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775130336; x=1775735136;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fjEXJr0F4HC6Q4F02RHzTk7Jk/5DjDFjwD5Czl3FSv0=;
 b=bseQMJUJ36sZ7La8bfOxbvLMH9kchB7YTf58+PBWVm20UtFXMac/bKNGkMwYRHWtru
 m9mI9FyQwuLP/hgEc0x+MRB7qf4eRzyqJQzU1kFRHR8GfyEifGusmx7a3CK1X4KYwy4N
 p6PUn5F1gn9TdAah09b4F3zmqsi+KykfYjfIDoDd3oWxb5zdGT5tNqMbdIx3KB5zgk8Z
 /GCio6vjpWsdYmkBqsrE4gyfoxP8T1dUL6x2Lsa69ANqgAIkdu/wjvNPxflTtVHT1na8
 DtLw7bD1zeV/gH94WMCE+ijLQmeZBf+9ZNGTwPpf0OBctyXoNRv1yxYMIFYLP7GWE0iR
 j8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775130336; x=1775735136;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fjEXJr0F4HC6Q4F02RHzTk7Jk/5DjDFjwD5Czl3FSv0=;
 b=TRmScs9fIy6Mf/ke7yhfbWzrXFhdxYl6QmmpTNh8Zj5D0MUzrK8Pl+tKGJBuJTGlS4
 67HJQtRxZS+B3sYJ2uXMV++GaylNhGJD6QWihcktfIu/qI/rxw/gCaVHaIcRINZtsD4v
 ftren88gsUc0TcF/xogEtlquD4KiYf0Q7vTAOzySFUYhFYrvNU7tO3GLGQWdBdL26nWk
 Lgujgm6+7aVda7te/9CG5Y/7XWAD3MVnFAs8KTL7FmdSLtSa25VBctUxj8aKzTfzpB3N
 bGSj+4Q8iPQvuat9LLuX1ECC/jWQpTiPrMM9w9oozappYVo6dJEos6Hf7Df5IBzdvmsq
 a9NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW55sfwKAvXNJmvuYYXLL+D6Csxkx0wjpLC7cbVta8aEKeiRwqP0J/Br8ayYHSUtuFGUFO2UpYywgU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yys/2MPlNAYKvSQkxNu7x+itkyELjnQARe1hqezvuSErz4D42hq
 Nw0OPEqrgsRL38L0j2O6BSfMoplOClaD5xcYndY8PYWXHPtf0KmgtJPinxLyLIz2FxGTETn5fG8
 Gp78z8OaTJGV3D4g/gU2vHqmgk/Oe8E8rEJc/pqZ5NmtMby8gRL+v+y5GX4bF/lr2dtHY4S8=
X-Gm-Gg: ATEYQzwrQyUIx/AXZQGKA/yW0EgwjWcIImM3IMVJHZu/x7qakY8ZRA5prmIi8o7qDMB
 tcNyOW/juuHb+lMxcm0WSyafR4+HAcbiptUEoY0k7Zm3APBJg2hael0NCYTR5bzoE80QfxCwzBW
 VIcaV2gGDujutB4o1+DasPqU42h1xNVG6/9K/LFJqRGMlIxaGU8+RVEnavaB9bojcgbCByLvoBi
 PlIBAXuJ8GQVfgfhaQJLTHKDdQjp+ka2pxlkFWJmKLEky7bkOWRsJtNzGS77ldqvFD9anPoiWnn
 xb+nWi7hdFp9y1LwcfMgq+e8+fL66ICBhS5Xor3NC0X29J/szWznzcZlKN5qqB2ukfQKgE8NR75
 bAZlADRZ/h8WpRNIAYAy1itDd/RZgTdHmzfPAEsvRoxKG
X-Received: by 2002:a05:622a:4cc9:b0:50b:34b7:fd62 with SMTP id
 d75a77b69052e-50d3bc9b7afmr99636621cf.25.1775130336244; 
 Thu, 02 Apr 2026 04:45:36 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc9:b0:50b:34b7:fd62 with SMTP id
 d75a77b69052e-50d3bc9b7afmr99636061cf.25.1775130335826; 
 Thu, 02 Apr 2026 04:45:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a567bfasm141614635e9.0.2026.04.02.04.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 04:45:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 13:45:16 +0200
Subject: [PATCH 5/7] arm64: dts: qcom: sm8650: Correct and complete DP
 address spaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-dts-qcom-display-regs-v1-5-daa54ab448a3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=OSYiIDzE8fFUwsAtmPND8mFzvbYZFJ4yGb7DajeG4S8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpzlbPCq4EdW4VK0PG9hS7Lfp8GCKRWpwjyGJkz
 DrL8xD1mwiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCac5WzwAKCRDBN2bmhouD
 10rsD/46sDP1SvW14VneXhdhFq2Yx9hTKb6M4RTb0WOKEfN50oAZXorC5sgx+igbQ9NOCmq29fO
 F651NLWxQs9zSMsuO3OTL1rRASw+cJEOb1ZrxczC73QSaXxUSP9IB6flZk6B27CEhu0IcKMzfGw
 1bacLSR/LttUbQTHTG0L8EA4wDzq+mQtkskyttQzIQACVs+GPZhTSPTJ5fwgmnuAAAvCclJU330
 EgsxS7gYH8qlmo0nBR6GtMoqhAKQIBWSGersgaKY/qLpXf9Rq3HkQyVBaA9RE6tvIVnX1tdvCKJ
 Z/j4qoKs2q1XkQUKH5LBPM0mEZcsi4W/Q1kEZTkJeN4bzei5A3P7dd5s5MCvmxbsBY2GD5cJKEX
 ZT6k2JB4N/DoPXYPZ1X1ta1yWMpnsJ2qcXNZ8xI1HMe3FiJ9LcDNQfjDqP7I772ZNEC2OaMUA0+
 NwssXDy/hXc+FQHe8/ycNtRcV3KSXdYWWB9KMNN9tQZCGCiIecZyJhe7kfvP40Jctm1dRsZnO4U
 FpddiagkIX7loOZwoBMjtlGP+UwbXtSsvjqSsfM7wiHCTLJP7uTCdbMLOOTPgtzKu+GkIsQNV/H
 T0UIwE5+klodEsW6oy59+CeSPidfDhOQLSgAcBsXo4yBn9bAewUk9LqyZRdkvyPJNKdoNqCguPp
 ompliKxtQ8A0htg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: _G6YNjWAh6BB1kp3nMG5A8eJUonpLkMy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwNSBTYWx0ZWRfXxg3vg1XLPTHb
 qwkxKmakQewsa8Q4TCsUonku2v3VwkVsAEjm8//PXDybKYua6vCo3rSdeaBUU3sZ6ZLWolTbtUY
 XUbJbfBw/SZl+2b/a9q9MgzjpDfRVxLvp5ynqglQWeajSx3uev82AH396hpPqVDw4xctsoXJLHh
 u6Bh6h19UweHSHJHJ1O6wnBMxnnaN7z4eQm9b2Xc1fXHdup/dT8w8GudMvmDnBOlczkWfZ8ViSG
 Ib1+XFM7dPzUnkUXB/eACtRmAamz6aZStrcvTOHBHDHNe2z9wYXVcHx5diP3b6QYC/4WqWkYDhU
 +7W+P677N4Ngp1YJ53svZcY6Cj1Qfq7XVf8OZ6krrmyUtQ3o8YTvcJLLcUKv5EiG9LFOIw6nkE1
 U35lRRE8SdVWThBMBWDHadpliIZ+ohYZE8M/SQB1yZ/oGnNeZjNoMjnJGd7wKGQDkz6M5AoM8r8
 8nv+rpmRIEpr1tnuP7g==
X-Proofpoint-GUID: _G6YNjWAh6BB1kp3nMG5A8eJUonpLkMy
X-Authority-Analysis: v=2.4 cv=Ap/jHe9P c=1 sm=1 tr=0 ts=69ce56e1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=RMXozov3DQQ1vOc4o_QA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020105
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

DisplayPort block on Qualcomm SM8650 has few too short address space
ranges and misses four more spaces.  Complete the hardware description,
which in the future might be important for full feature support.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

dtbs_check success depends on the binding change (first commit).
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 1604bc8cff37..bc420a44f0b8 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5868,11 +5868,15 @@ mdss_dsi1_phy: phy@ae97000 {
 
 			mdss_dp0: displayport-controller@af54000 {
 				compatible = "qcom,sm8650-dp";
-				reg = <0 0xaf54000 0 0x104>,
-				      <0 0xaf54200 0 0xc0>,
-				      <0 0xaf55000 0 0x770>,
-				      <0 0xaf56000 0 0x9c>,
-				      <0 0xaf57000 0 0x9c>;
+				reg = <0x0 0x0af54000 0x0 0x200>,
+				      <0x0 0x0af54200 0x0 0x200>,
+				      <0x0 0x0af55000 0x0 0xc00>,
+				      <0x0 0x0af56000 0x0 0x400>,
+				      <0x0 0x0af57000 0x0 0x400>,
+				      <0x0 0x0af58000 0x0 0x400>,
+				      <0x0 0x0af59000 0x0 0x400>,
+				      <0x0 0x0af5a000 0x0 0x600>,
+				      <0x0 0x0af5b000 0x0 0x600>;
 
 				interrupts-extended = <&mdss 12>;
 

-- 
2.51.0

