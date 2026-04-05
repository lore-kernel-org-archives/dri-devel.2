Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991D9E9D801
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98E610E244;
	Sun,  5 Apr 2026 14:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C46ZUBnV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P34QV06g";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4225310E243
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 14:34:26 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635AU4Yd3205000
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Apr 2026 14:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vAMWoWte2Tjn4Jl81QLiLfqRU3eA8YP3AzsfgymsFwM=; b=C46ZUBnV+WbMPMdH
 E3EdMBCY0rKBrdbYYQayBKHjVkXouOZHJcvOY6C6TI3bZzgJR7OdhFDtRO/h1t2c
 zyDMZlNKOf+0eRGY1iIxYxxwX5G5YI6FErDDIX71ygzIrBYlEyAU2mJi14wPBM15
 kMDwfo09Vpq8T5/i2Z+LBT/Sedt3pZ3mRglsioSWm4V8A5dOZ0Gqvf7A7PQ0oeWM
 ykyc10mWXf+SSHa2DtWmgmYXyETE0QoQk/mx+I6EoHAojU46GfA561NJBqxRAiYV
 zIaSCeuHJ/rZm/431rMd6XJBt541VfKJuRYxLS4DM77HtO81S0ZMyQ/SWnw66Yzu
 q688Nw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4datqsjjmw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 14:34:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d8c192b3fso11437791cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775399664; x=1776004464;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vAMWoWte2Tjn4Jl81QLiLfqRU3eA8YP3AzsfgymsFwM=;
 b=P34QV06gs4AgOitbbVedmHTit2Nrnen6869VYZPZiOQ5oLWn7iqcpOxWSQPvCTJ0xM
 Ws//1cU8wEVNzQJE2wDdVVodvwUsGlbaM8zXz01BcTDqdUWTUnQVYvrLtMCZnNur2aCx
 1EjHBrNh8rIMpZHfWpdDgLePTCrbesRwwDmI7yBSRnbSwx9rpeL09OWLBH3XQj/aXbBL
 748DebTNScasarmi7YJlzaAOLBMooArzl4iA7LKRRyBvj8PysgrPg5iUyRVyF1dwRInb
 hiRRyfxESZOzs6pPU6WYZE4EnRoG+xguPUjf9C9NYt/2AWqvhsVdc0ol1QG49+rADy/U
 N2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775399664; x=1776004464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vAMWoWte2Tjn4Jl81QLiLfqRU3eA8YP3AzsfgymsFwM=;
 b=ornkYU0IvGAATrVRyUxWFEiUrEzvUGB9AZq1d/xclaGaSoJ97Vu/ULouQX5bV7aHqd
 Z5csbG+HQK2Kxg7mhFqnRPvV5J/twzMhK7P+DL0HlX6HmH7ZlrU4q+h/eAp2JnQePRtm
 paAfTDhxtTRFGJF2nyWayjFz/GJg4GSuts1sTbAVYYU4y1mFHdiCF12g5oYXkDlFddqQ
 hY5d/hwnvjiaGlrhaIFANOTxtUP9AzQ4qFJ0mYK2AqRPU5EG5Kgtnydf08+rantsv//h
 1FflYpcDgWj6X5wGlo0Z/m3/sewC+SjNsHoaGob15ZCfcSnBV4+3JyajjRMLbw+KjTGB
 WN9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhvB4+q+S6vsXPa/GmyU59UQ4yGEm3+t7VGTzgnXSmavm1DvwGgR9wjRfnc3iRalPiuIUq1yrN2II=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3vX4zqwpE3uLuK5RO1mPI15k1yhIqHYWVTCAtL2UXc/ik6+Sa
 MGNHXFKpGA6VIoMH8sllleGINFcHS2ChHl6MWXYPmBPL1JbYkv0PTslzpu1EXtCrxfGoLJXpKkJ
 dRlC93oZxZ61uJJzBbfJsf3b1+tu1v4e/Xa+h5fkf8eHKOowyGglgGkcJv0cB/AZyBR+D6RPOph
 7Zw0I=
X-Gm-Gg: AeBDiev9K7ZSHuvd0d4jp/SKUTZ761RgKiUgCQcsYXU17evffaig1A/dQsA0IG33+y+
 vN7zpCXSfM2d1hJRJh8YXDzykZIdqLFDX/z4Tii2MCRGM28SIL8rapWNAz7Khk/oo4gyFTDKKBZ
 POmQvRVd8/DiN39UA18OhBSTGlwmPJRDVm9ZVLrWEWqBaYvCz9OKwdTS92HAsXMf6PcI9LgVWlF
 2lfP3RTL0VobDe1MUdBZH0PRsM4l4TpntkwUFGZDG0kc12qrU9895HUrAe9iq+a5JM5hBXDEyVA
 LIDZKpIM1os24ozZfKx7lPM495RiOHa2r9nkBprQz8ipjKAG7m0acPCgMvin8/eeHuEeluh8Nnw
 i5ATNax5+b22Lq4xyQysbxQjtiiE9dFaq5AFfNH0DRKRz
X-Received: by 2002:a05:622a:44d:b0:50b:6b21:2bf7 with SMTP id
 d75a77b69052e-50d6209d94emr162546971cf.0.1775399664557; 
 Sun, 05 Apr 2026 07:34:24 -0700 (PDT)
X-Received: by 2002:a05:622a:44d:b0:50b:6b21:2bf7 with SMTP id
 d75a77b69052e-50d6209d94emr162546621cf.0.1775399664148; 
 Sun, 05 Apr 2026 07:34:24 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm713934755e9.2.2026.04.05.07.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:34:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 05 Apr 2026 16:34:03 +0200
Subject: [PATCH v2 7/8] arm64: dts: qcom: sm8750: Correct and complete DP
 address spaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-dts-qcom-display-regs-v2-7-34f4024c65dc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=D++Wl73hTbYfSyRKuH5nKLaK34f/XYn1VQrydlWt6hM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp0nLd9mCeRR/2R5Hwx+8lfcB+uXg4NX1Li12LS
 GBvIY5NX5KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadJy3QAKCRDBN2bmhouD
 19LmD/9C/CNpAsJJ6szXCf/YpgJ5fuVnArSTkVVf+5ue8ZCbZHAHBnmF+r2No7DQxXXgQxiiKeA
 FdAto7dL70qr6eubHNtcPR8f+i2tqzAWdbiaEhdXGHSMg0xJCgSseQ5B0lVKSlEFlosYAVdJ9p1
 VHgA6DAAwvu1dwGVXdNWrvUcBzwmATDM3gbnOF0sULgyV7BklXrXlm7ARdzCaa8dZ5ljpuwC6jq
 6nBOijC54/NzscmQ7ezxME8F1L+fwdwgiYYnaM6R2goKQUQQVGHXmLFZgKZKclB2RCYsJhJPXGn
 D0vm3n//0Equ/8UivYmC5PpIReRPEnBifRl0T00Tg0NmnosmGYOTfSXDTRWTps/eVPNQPAMDER2
 ZSUKJodX65nWsgj1Lum1ZTLP3appBWHQtiUs4UcHsUIU3hcljDJnw7Bb8j/l7aog0uyH+94oJUc
 GmLmNxYq1VmHSK0tkExiE7t7sFo7n6IQ1t5wufqUT1EO7iYWv+liII8WUV85a/sSs7jNmQfEJqO
 2xqb2zUzQkkqfuXiioK30Gy1Du0lgtlExdTRrelOgrTW5K07PZPB5CC5dt9tJwak+a3O3QCxCs5
 QfQQiJFco1JUBcM+eG+OMQTZdocamKTh/+hJf/f59UDJdoluJPbRjkVxNpJ41Ilzz3wsawHdMl8
 h+b0hOHzEfDHizA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=ari/yCZV c=1 sm=1 tr=0 ts=69d272f1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9LIhnIfllzZggS0j5EYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: c1BtI2N6oQkijGFN68T_993WjIShJGGs
X-Proofpoint-GUID: c1BtI2N6oQkijGFN68T_993WjIShJGGs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE1MSBTYWx0ZWRfX6Q2meL92xx1z
 igMrkJ6FRSlA1BgEddS26JwhswFOX4BmpjOkiSJ6VMzcObD2Qx6sknT3t2Dcl4fjAWblfy0G2wO
 ICfZaAH3qLO5mkWv4XUy+H9fbotW4YOMb29IvB6marKPMdBAcL5+4j4VG+tCBjCGx0G1Q4+ztDu
 ro/3oYpipNGyVdi8necGJPMY76hWEI0V/zbBKashUarjm2fbEbtasPYxyg2KXIf0Bwm8teUiAoW
 Xv++Y3h39x/K9VDq9uTs8rJiANOlcOu+y4+Bis9QFB52h561BcO02WHcfE7+fc7y8geUxLpAblq
 t01vl4Tt1v9aRRORcxIa4xvL486ZuDqc5qiIh53AgRP0m3Ow9o+V9QRaxCgwSL2UB8vLBJKhZRI
 O/jl8jh7PLFG4NCUQRR9gjOXF1zVyAueevqbFRy1UCE3DuhuhL/4vFgxngpIKwy20wvvzaMQliL
 9I3suks88uDX6zkhE4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
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

DisplayPort block on Qualcomm SM8750 has few too short address space
ranges and misses four more spaces.  Complete the hardware description,
which in the future might be important for full feature support.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
dtbs_check success depends on the binding change (first commit).
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 18fb52c14acd..aefe517e0669 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -3325,11 +3325,15 @@ mdss_dsi1_phy: phy@ae97000 {
 
 			mdss_dp0: displayport-controller@af54000 {
 				compatible = "qcom,sm8750-dp", "qcom,sm8650-dp";
-				reg = <0x0 0xaf54000 0x0 0x104>,
-				      <0x0 0xaf54200 0x0 0xc0>,
-				      <0x0 0xaf55000 0x0 0x770>,
-				      <0x0 0xaf56000 0x0 0x9c>,
-				      <0x0 0xaf57000 0x0 0x9c>;
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

