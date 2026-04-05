Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1A0E9D802
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232A210E1D1;
	Sun,  5 Apr 2026 14:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KdjYm0L7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FQ+IE0Hs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A1810E1A1
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 14:34:23 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6353o2Gl2412282
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Apr 2026 14:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iWhtw5e8ZkAVkw6AxfuaycLcF65AIqs8mxtqI1auKNY=; b=KdjYm0L7o+p9mvMG
 FBBo3horl/8L6+VyWogGhCmc5Y/NQ2IFJzN8PYIAWbxzBsJOC5deVrIqZHvjtv/4
 ONJNifPKfZOf2mGBpcJ1D4tEcMDFZwSR0zd5gijyRNhLBOIAPhBT2K6IyiM6Q9ZO
 JndkryOeBtjgj8kl+aOz+6nDYVn3ci1sq9Xoco+R4qLyxNxtLkhnAhv4DnXD6LE3
 tvD3ZDCA7Q1Ei6e15qSsdfqJ8b3BW25Z2OBGse++nB9C2s/iEj+C4NeUOfHT84fT
 3RNhLiOAiJmrl3wr7qF+gA0krChEg3XtyQDQqCtWzQ2A6McRmQ/9TLV1thO9As/L
 sTXpFQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4datqsjjmk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 14:34:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so6386301cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775399662; x=1776004462;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iWhtw5e8ZkAVkw6AxfuaycLcF65AIqs8mxtqI1auKNY=;
 b=FQ+IE0Hs4tGwEekgTpXZW4MY1VptXnVN69NeK3Onj6S7NX4ZnFBzab3WG21qM5WNCx
 gaZmdb47F59304ojqFyhiWuL83lAtA61LndU8LOAcykF0rZnpudiCQyspbVjWQWA5av5
 uqaih//CbpJbtjQMB70AGzPnuGQ+WvqXK6GUuiyEQ31U9gq+Krlv8cn4RByEOc18s2u3
 as+g42DOMpPvr9MwqE69fkFf1G6LzzpGze5EQg7XbgvWr7GcqEmshu73zTfWmf8BUJsQ
 dLCKfimQo0UoCtv1SuoV5ZxG64ff2K96UbMmYWiPoWVQdVKNEahDXG6K+AOE+uhmpHPy
 yh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775399662; x=1776004462;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iWhtw5e8ZkAVkw6AxfuaycLcF65AIqs8mxtqI1auKNY=;
 b=OniG2D9Mb1pTZtHjWLKdzJ3UU7/b6ruXSw6S7WPg5rA98qP6mkTahU+/AS4bvrv3Ih
 EYSCpmMXk69Itra4lNjjQR1lfd20XjVsdNwt+W2zkMS+G8hserAGelSvZ7dxEr8Y54up
 2NpBeT/y6YNv/oP2RWm1/HLPp0fLYEm+x3GiQegHcQ4+zXCiijti/dMXXrVYvMkTYUqk
 5Nj4IeirlDr7NHB5wj9Gspwqo4Y6D1/5IGsn13nszy2Q3rSFBMHwbPJrHlj2e6GMM/+2
 LdLIcJGuht1KdoMXY95OPoabGDQ3qyMOhOAItWyigxhA6gtDDyENabiStyxmWud6dmK0
 4G+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgKhw4cfsV8cvWhMFzM3PXSC8LtVwt4qMmXqjXWjJ0teVPZnGCabSfuGu9xnaiUtByzF95wT3jL4g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySbfdKcRIQx0hGxdnK97hkoChYrku04eGugbTTNHiPciMr+dRT
 sHD0BDA2hQ1ndfKwDVGo1lp/Wi9XvxmKgTcM73BFKKGaynz8UOx6XCMdR4GCZz+m4w8pLKBW3cE
 RHot3tagx+cqM8lRScM+VFwL5jPyhroiuHxifALx50mrR5MowWdwIb01woigGl3EWoyJGEVA=
X-Gm-Gg: AeBDietmTyR6XcNlGo/FcEEYQ34qANqquexpqXq+4iEwkNW0jGLSumQeD3TvDLBYlS7
 ys8zkG4tTYywVPZzqY7mEpJmaqryL1rrO50bAdhgOEAUcezb0brpaz1UIdTww+fsiPTl2hc+JWC
 RsWC1Qy99iVJXOI8kEum9/xb28yEeoU05Qvkg/0XvQU2R2bQcXxvUkup+dtCvMaXIbxHKjRJOZQ
 rd+d9zjMG8yhi3y1iRN3xFltZC9hfE4oYR+d4LcO+WM3AEigLRpaqCxD5U/nj3r+25V9kO35c0S
 szvfWnlE5OTvNwu+LOlwlNP81kmRvOCGK1OLzzjzTPjGEG8Mejm+VWVh3b6h0spNDQdww4C5t+D
 sySR0+P6gfkOvhwg+XlA4QwI6l1Li8/ua25IApr4uYC5m
X-Received: by 2002:a05:622a:2b03:b0:509:34b8:a373 with SMTP id
 d75a77b69052e-50d62cbfb5fmr148458451cf.32.1775399662526; 
 Sun, 05 Apr 2026 07:34:22 -0700 (PDT)
X-Received: by 2002:a05:622a:2b03:b0:509:34b8:a373 with SMTP id
 d75a77b69052e-50d62cbfb5fmr148458021cf.32.1775399662103; 
 Sun, 05 Apr 2026 07:34:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm713934755e9.2.2026.04.05.07.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:34:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 05 Apr 2026 16:34:02 +0200
Subject: [PATCH v2 6/8] arm64: dts: qcom: sm8650: Correct and complete DP
 address spaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-dts-qcom-display-regs-v2-6-34f4024c65dc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wTyBsbVFmvsQqpCgq/J1A/2bDtZjhyAk8KLBFxuWu/A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp0nLcRbkorQilz1WXRwKlfKpQkLKwFWGuCUWKw
 pPFmo7H3hGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadJy3AAKCRDBN2bmhouD
 18yIEACRaZMlJCkZSZY4is0XxsJoPu0EwoDPSNa4DSA+on9+goqgNFKDZcbVWPzPJL8Q22NEEyy
 3FwmkYot2UwQLh/6okJF67xUnf/Rdp504cKtU3irRlcrDTdtPOopXuD4g2EgiIx0jmMj1ssDyg/
 SBkFLRi3b3KlXTKP4JzKBNTpLQM6he0X7dKLnla6U/3zSmW48sc64Pmqpg+31DhlMgU14Rfx9Jk
 sHQ+RA6Cyi5yEDHl1KM9MvnE90om29GmA6aR++RLD+0CQTOsIS2YTAcmcDE9oCS/VOd8m0GB5kX
 CsplJJdBOXqg9fkRYES0/BmLu9HJc1b+l5pmaT2ZvGVcuWPZKDQz3+H9RkmrqnMXEpu4vRaXg41
 imxg8/gH8Flv9LOsscI/iMqTH9XVCJ/3IGjqh1I0RXRiQ1iE/vCtdn6JumothjL55baErPAmNrg
 qWNfQeqLmrK4hK2P4eoF46G/TH0adku/6jo+1h/PT4szsWZj5huI6l+9Ghu8jFVpiDHsQ9VJufy
 oZQN6OyUcrHshBgUtdoiTHwBkTKk4r0Ca4iQ4B6l2qoNa9w6mQZCE0jyEPK2U/eUyD6y0yw44h/
 fQ8gVtuphIfLxCGwTTGQTrxPJhgtBjSF3LNpvoNiNRq8I9bbSzimavh+/gxjTr/UibON5+htGSu
 OO/QeL2IYjgJKZw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=ari/yCZV c=1 sm=1 tr=0 ts=69d272ef cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9LIhnIfllzZggS0j5EYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: DEr5z2Zq6Dxg19TQuwPW5zZ7EgL_WdZj
X-Proofpoint-GUID: DEr5z2Zq6Dxg19TQuwPW5zZ7EgL_WdZj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE1MSBTYWx0ZWRfX/PkNdnKtIwls
 iOWvakPMnGN5OBOoE4gLsgRjpkly4MJqVVXMjaM7JLSK5RdCVaujmAgvhE8SOzB3Ezt9Qm6yqZG
 rwHV+oWXGCd7Q81d8ewFr7rqLv21Rmb81LKE1N7O7fe66loQJx7yA4QBg3GrQ3+tAaCrzTFo6Ki
 dtfiSMTXjs0HnAwUnLXMumMvJGJ2v9HoeMC+ojT1INTlXHFWCTsp5zuU24KP6A7gEWU9j0Dd+7+
 outWe9f5gmX+tCcgDdSZq2rOwKDNXxmd0rG7TSnqotRdG5JmrjCFo1T1SKRroi/GdF53bFmKSun
 QRovdvhjaPwjWwK4oYmO7rgzE1a7RfUQPSGLmo9FtYkfU4hpN3r8yZc3jsI+6NY29o4CSEe2/eZ
 zwlfghW1J92nx3czmA5tGPo0xcsRfVVkJnJFjEhy2IhVFm3ygkNk1hH0sM9Pax9AgKpxS4OIxDr
 0LKYmxDPrSMzSVuDHsg==
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

DisplayPort block on Qualcomm SM8650 has few too short address space
ranges and misses four more spaces.  Complete the hardware description,
which in the future might be important for full feature support.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

