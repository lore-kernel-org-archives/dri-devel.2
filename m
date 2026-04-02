Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E782D39410
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A2010F1DE;
	Thu,  2 Apr 2026 11:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="G8zS5SRZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hL9bM1NJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2444410F1D8
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 11:45:40 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328RqqF351891
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 11:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u69S/TJ5H48qNg5eh+ouhg7rNEWoiU7d61/6yt/Y27M=; b=G8zS5SRZ9Tvx0G1L
 WH8hnKh7uRioSSaNknIfw3WLRme4CcDCbK2vr3v+dMnq5lhT42AfgjBeGqDdVHlM
 WrJUpn3C4NJecWOqBt3HCfLmgqDbUUUKzicg6tYymyMbK3BEiZmPieKWqtsOiuOA
 0BovxY7q4gp/gIzaYq1KfIYJItmr8bLhOyH1Kxov13XWX6RaL1lYY74oqkSRC9BS
 hiWRd8z99mH3lr/Q/c4LOioD3XLaxmDqRHnQ3VzGLYa9TqCWvdQUPhr5mZ7s0F2Y
 3WBjRWzjkQxUgA8feDPW+JE1Ozdf7wgGPwaCo0V+7lRygJ0SkIJAR+Ql2c28jC9o
 2QVTBg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9myh8s4q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 11:45:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5094ba09affso20659541cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 04:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775130339; x=1775735139;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u69S/TJ5H48qNg5eh+ouhg7rNEWoiU7d61/6yt/Y27M=;
 b=hL9bM1NJxnlUB+KPTyN/tR0ePKQJI//vNk9DhxJ4etfzZ4UoJ/lJ95xQ+aEtpMewsB
 dVsFeGftJbYYjHw92SxTrZC73nWqGAVz06by3sqL/6+uRdEArv1Xjx73rcMlj7EWW8NO
 wJcskq/p2vZMCBVUO7g5n8Tq647RzwFVOTDVQOFJ2m95j38/4LtZM75ofi1aT0FRrQSb
 uhaiytPyKXRlh5sJt4JE+L4qCmuwbracacKJxFvSVoP1iWia6g2750RCCFftyJ8M/a/4
 iy4Kof2+yn+DPOwA+EHhGoEOwYToBYMAGpFs616aZcXfti2YgQC/aTCwEgGUhDgo64Sn
 KMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775130339; x=1775735139;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u69S/TJ5H48qNg5eh+ouhg7rNEWoiU7d61/6yt/Y27M=;
 b=f5otiJs4mqHL8S/rwK9rC9LUhSMFxw2t1dq5xvnAmBU/5hev0UCUB26NwNmOFJYq05
 IlV4HMs0omqr48RTfaBjOHurYvRz2oCForPnoM5o5p0GngMXHSg51zTfuQCY9RwJnqSR
 zA/WPN7KtTdmfpPLAl74zAbOCLKdxVOT3bxbNTm+vitW8TxZtgOMn12M7Ucr9aJlm6TC
 TLErlifin+Kny3B3FIweAFCeKXzaqPXd9s+eL+IfiQi5HnENwrR37N6Jlm3qFOYxyWF9
 bwFfvcGslUkU059vRLY+URxY77KbbVWLitr7tp29mIaYspmr2qyi89nrgK2WIbiYJEI0
 xBUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZblEe2kDfxmYs3svANwAWv1gQ6XFLGgEp63hUMY5Mct4j7dfTWkx9hnhCdeEFPvdnWj3Css94YxQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4QL3Crv/fp6EE8qcwu8OjyE3fAMSKj4n8PpjDIvMWZrceI1zi
 ivVuFMAhGEqPJPDqiOpAMYRgFMf7u/VNLZI7wvmYdiEwElr80S55+fkB8tFNPyhyyd2hRrrwfe1
 2kAHvGsRkTQmzHMBsJzOT+/zmDtr9zj9wwrt+XzT2kGSS+Uo4ETsBYQK2SMZamcmTIO+bjOw=
X-Gm-Gg: ATEYQzzntrS5WHbPjJkeJZuimS9wx1ZkWZfGHJ39mxF7pdlQSck8u9uSlz93Tx5XmKM
 dcS0wE5gyMtthykk7TyvWeTDdOzIImq1f9Ls9zwQlz8LY9OIEw108yuNZc03f3klF/xtgm6yo2n
 GgjMeOg4ZJnExLJLMjkuIUPQ63uZw1FVSV1HIF+7rLEUAeeD39IVbmFMnMJrxNowkpG90pBpgdU
 IhpsAJRRqjtCScB7D5MqrBOiJnJwLknChLnxYfqjMiPNvOrhVCT0T4Uzup2bBvvNIejBObi3Suv
 jDuO+RDMIDNhnsvYl8mQ3Xf8bDoD+yUm/DXrfgrZjbWTbjEvUF4QFPKIUlWs5/Q371LS1pxsecQ
 H0qzPex7nn3/Y2KaH0He7rUgcCrJfSRodWKeL/6W0o1SB
X-Received: by 2002:a05:622a:207:b0:50b:3f6a:1d88 with SMTP id
 d75a77b69052e-50d3bc92420mr102554151cf.19.1775130338623; 
 Thu, 02 Apr 2026 04:45:38 -0700 (PDT)
X-Received: by 2002:a05:622a:207:b0:50b:3f6a:1d88 with SMTP id
 d75a77b69052e-50d3bc92420mr102553691cf.19.1775130338208; 
 Thu, 02 Apr 2026 04:45:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a567bfasm141614635e9.0.2026.04.02.04.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 04:45:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 13:45:17 +0200
Subject: [PATCH 6/7] arm64: dts: qcom: sm8750: Correct and complete DP
 address spaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-dts-qcom-display-regs-v1-6-daa54ab448a3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=cikxYZCMBRNg0V1GMjULfidchhUEEc6a9UCGqPBYh+s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpzlbQYRDq4k5OCWp8S+4aGjhOn4G3hqwTIPvQt
 D9loWcksCaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCac5W0AAKCRDBN2bmhouD
 1z2kD/9wXv1XidF60fqEM+OmuRpOggS9P8g1IoM7kFAaJFLNYZdowO7Zd70Bj2Cxhk1YxkCSyuF
 GrooOVgHKJTeUnTLFO5lRZvHfD5ozA+/jp+BWgGY3xPbnezWVsuwWT/XaeHZmBfUAnG/v314o4d
 uQkmqrgSuP+ISa1T7Ba3La694uiC5S6eI75Z/5pK5LVGrw+CiWfoJuOqtxNV22h9L1+6TFRseV8
 47nKDieXEmkXAjrSJbu7U7aXnFRHw+tJAaSPXZisp119M0a7WZiDr7y6ED0MN9C+Asg/A2niQvn
 Cdq5HR3PVxB2NrAF1I1bhYC8HObMM48ePpdN175LlHzNdihyYQ9l76y28dGuPX/nfH8m85F5S0z
 ttQrvMu6Wu0ytgJogsIA7CRpmDDiz8nEDX2E9sacd/FMgw/T/kpZd812RzwQ9umbBjb7vbqacuE
 iKlmPXrusfNjWfVmF9IHjCPtzl10JMXWuDhso8pIT9Sk8nQC1oCIDJS4GT/2JQP24nc1spt2n+L
 Xvk+8FFzEQWYa8CtWBFYwENzKTz3nbz84XiCH+8WhgtdSM6LYiNvoGbTM+JKApdn98QJgmNgR/s
 DI55y6bid3qdrFA9ziIObUwKA1VFpf3NsNd/F9RXuvEAHnxjwUBeAKFJYF42M9yKW2YXtxTSiXI
 rqUfb1eszYZwmNw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: RryN_U-jztYfKRwViRAO9d1LWik8_6SA
X-Proofpoint-ORIG-GUID: RryN_U-jztYfKRwViRAO9d1LWik8_6SA
X-Authority-Analysis: v=2.4 cv=JII2csKb c=1 sm=1 tr=0 ts=69ce56e3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=RMXozov3DQQ1vOc4o_QA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwNSBTYWx0ZWRfXwJjcmWxNvpJi
 y4eMCXQfsgPo/C+9XVRD3WLfnjj4avGp9sp2b1kpSsCRuCHIirXGcv312OhYQU5C9x+5QgfSpZZ
 XoYPHG0Sr7/Kj1QmICbg1ozfY9/GX2d3qKgb3jmRzORLw/Oa3LRMfhlUrW/vAW1/PopIRqFJBWi
 yV2SrlHO87MpFfFanG2dzW7muzYoLTg2wk5cD4y+Ybk/4d9b2D1Ra76AZsHP5qpaUCcFwMCoKED
 vSwEv/qnBOd9NXIhjxOJQODb8sCKo18hwKFD0gvyzQ0cC6I7b2NzCsKKOXBji3dwwwPh3nwCePl
 3qv36AWma2KZYIHWeVCVDFtI/Y9YPE1gvgiYYL0eu/vEvtmR06evKh5GdZJ3pk7+6pxeirmtVwK
 OEFRON8BD5Vdt7gZ0RRIxWYUB+NFIup2vhHIiAqzxn30fsKsd70ffqWj4z7V+gUL+8ZyBCMatdo
 W8A0Pmhcd+KNxPYvZYA==
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

DisplayPort block on Qualcomm SM8750 has few too short address space
ranges and misses four more spaces.  Complete the hardware description,
which in the future might be important for full feature support.

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

