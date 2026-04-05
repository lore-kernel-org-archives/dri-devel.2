Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755EBE9D803
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03DC10E24C;
	Sun,  5 Apr 2026 14:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RVEIFMpM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Os0ZCnQ/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6546F10E243
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 14:34:28 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635BfgFN3346442
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Apr 2026 14:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 52oscFDjem1+c6zc6REhqJiMklNGT0dva2yqjZoyFxs=; b=RVEIFMpMKMSXfIoa
 ZPo3e86ZUVDI61Vmy8nadkvLlBqE/qMSGUYQhrHpp7qJWOroh03+1/6Tsbea1+XN
 F3ECjGHZ8d9+qDR5zxdzDKkaUCCXy7s++7o2h/yCnTTOwHQIY4etS7mLxLl9ehCw
 jyA5tUZTXQU+3HPXe62U71R3uDMC/+hCOB41mbD8igOHZzzHXwGOwQi8ChHGqd8s
 en36wRemjuXTsPKON/bRKa23o2jZKJYcAIpmJ4La9jNFAk3WI3bDj+5FGytIHj3F
 6dUg5t7j0I7lgzyTpH1KTPApDp3kIrvGC4y5kFXQvW7rSs2rX5awBSlwmdqykSrc
 0fkNEw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4datqsjjn5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 14:34:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8d3bea3aa34so596215385a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775399667; x=1776004467;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=52oscFDjem1+c6zc6REhqJiMklNGT0dva2yqjZoyFxs=;
 b=Os0ZCnQ/5o10h5+cYlgKN7fHxd9KEKQqKSvpToEa4Bsl700wPX16sf1wBPdyH7YM47
 VWovqBNUN5AVrzr90JVvmEjhzDOdPbit0VCbPNz7NP/FPmOzoaQsG90tWATDf7/AFQjB
 Yxu/9ITWAR6OY7/DO7sg8lJ7JIREZ06eLghYfvQG6cw7P1mJ9gP7KNgIGqt2utwxGb+0
 H4pXyTHY31fxQIvdwan5vAAr1GevyGBS9VmugOXHy+w7rgFLSBSI0TgvV/uTaBAueXP7
 caz/JcD/o51gpxB6Id9YDYlqwAlwzoupv2wFucS2CBUoFTO674rZbWn85KCsh1CGMpFN
 S3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775399667; x=1776004467;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=52oscFDjem1+c6zc6REhqJiMklNGT0dva2yqjZoyFxs=;
 b=FRjn38fd532acsN1WNZUAW47/PwzN7kO2PntSPsy9R1gg3j/0+gbvNr+snUI/5uM2W
 sc/eJgZVmsliWJcAnf3RTJsv1xixc5dI2UNh8zNlM/HwDHPthHUxfP24v0va/nmIrcuq
 ComfVQ+OQlbzNZPzq65mCjd+Xbis0+nxKk8DC7mp6ZIBC964EGpzBigGrmNQuaU8pPci
 BBd/YA6tC7MsTAYa2lUK32nyh4pxX4KLUIBlbsUX2r9S5ZheGAf6jWIsD2QA6gfljUPA
 gA1HbOJL/PIpL692b2cLKQ3VRK1qEUt/v1FmyCa/dO8aUDsjWj39Cg3x7U0Nz4NaHnYk
 XDdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTNFCborCwPoSmWzSQzURZjCyYt1HsDYbw5InGpLQ3DjdS8yrT3NGfChrSbjNXZanG3U9n5J6rKnk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1jgUy45uLpXMFDMjqSMKnKIqO4TsF+byPpnnBpdgtzpjLrWaU
 qvWpMslrbmixG4UQ5H5RrZdUvu2tvE++zTUAaOwMgbEkYcPyMCGGMS6lI8cjYthBU14htVVBlEZ
 XURsk2t9NMubFDJASPHJWOo+YMIYhvUR+BZhZXmNFMQgD5EykfFr5sH2wcgmeDy2q54Yq4mAdrk
 lL7Ks=
X-Gm-Gg: AeBDietqhwUM88JwrkLRFlVo4SSdJhlsbX/Zd+69JE3RKsWsp1WOmagBGYbJo8gx331
 mZshVT7b2XHosYHqHzdqjA10X/km87OW5uDhvFpuv1iey5dO7+OH8b+XTWNO/k8t8TxMc6+5bTE
 WvVSJNRPLmo2Bt+8L9oQyHpL7qb1GbuwlaH0Nb/yg83gCTrYtovkxkr61jthRysDw5BmsVkymt4
 Hj+PRrbiH/7qjKYBPP9pWjmRcL83999A1dTJWxgSBYmoUk6F4nr77dBcLf/rM92E+LhYU/lI6XX
 g2GZH3anJAZJTBZ5DqUtAQZkxz7YXQeaL7N1jPcESjPyR/06JotoozmLkj8RRjyCP5wFTr5NMa7
 IzewNfqBHjszexS0UixC23cMEOaHBwEpVwaijdB3jmRQ6
X-Received: by 2002:ac8:7f48:0:b0:50d:855a:8909 with SMTP id
 d75a77b69052e-50d855a8cb9mr46714811cf.32.1775399666626; 
 Sun, 05 Apr 2026 07:34:26 -0700 (PDT)
X-Received: by 2002:ac8:7f48:0:b0:50d:855a:8909 with SMTP id
 d75a77b69052e-50d855a8cb9mr46714401cf.32.1775399666125; 
 Sun, 05 Apr 2026 07:34:26 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm713934755e9.2.2026.04.05.07.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:34:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 05 Apr 2026 16:34:04 +0200
Subject: [PATCH v2 8/8] arm64: dts: qcom: sm8750: Correct DPU VBIF address
 space size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-dts-qcom-display-regs-v2-8-34f4024c65dc@oss.qualcomm.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=845;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Hl0zlaD4IFKg1NjUgP4F3RZL1deVCm5fZzxtJLP6NuI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp0nLeYiVcsI8vu787g1/XyQ9q0dbh9TdjeqRqI
 rrMFSpeRL2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadJy3gAKCRDBN2bmhouD
 157JD/9is11lENJgRuFgQ9Yth9GAtompFKYbTWij+WSzhIj0ch7c2fycWLChVDDGZSL2BJw3dT5
 jhYIU3JROcDUMvbOjNgcw7W68rqWjBk0Hltm0QFnGUiwUXGlkmULuSKPjA2kRlSmdqJI32ewiOF
 UKF44+/5BSY01Hc15/Nj1oxNSRjh9kbPzyg90iHXJ59QwPcp0oaccz1as04khsYKv4OuI8Ye1J0
 x2cLK1PnCsb5B95adaaAtFB/l0fMo6V6V0Tm/+9rJezcvURfDRBcHgQUz0mSMMfSlyqoyPRERBc
 mrlSzfBme4speAWuCSFh1thHbFbc0h8mDgVQ7l/DkTg4PK/5coVBHjqvRDwh/NFlwhQhFpLZBwy
 iqY3+BX4mEwmfFDmFUwDjpLbEaXf71rrvqfTy/9gE6fONgz+YUHPqLCuSLSi4qmdrvh3WKw4+M6
 Z5FzP19pktGnQ+VOdM9UUEMlpFYM3tAAneZQSCRK5UV8sB46AdMj5N/Hjao588jNqsDoGk7Eq0c
 +JjXpE8nE8ulKxN3JVmr4ObKKJRciTTpgmZ+t+MVTQMxvxGicOoDp/dWXewlY8ylsraI+MohEGy
 WdJBAF1hwYPZf2incCt+2S3C9qazhWKpPgAeLmVRGghQmPlYD5z9sB6+4/iA3oktncZ1GPun5yw
 DXIseaB5aVuK9wg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=ari/yCZV c=1 sm=1 tr=0 ts=69d272f3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=WYllmNudUJmrw8VR-PoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: ZI4f-sDjhJw_rBvP_OqfAT8xGAv4qPp0
X-Proofpoint-GUID: ZI4f-sDjhJw_rBvP_OqfAT8xGAv4qPp0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE1MSBTYWx0ZWRfX5KbBBtNsBlKA
 qVBOFR7rgz2NMJPndh1S5seKPQSLReaKni0Li2den1IphxxWLDwtQ2Bg0P40VL+a+5kiei/vpg3
 3OHGIIxfEjwrAVW7tyGSNQOGcXaPV7ysr8vdMpFePUDNpJA4J5TmGJwewi3+7YFu+8OgUMW9Ejc
 b3yXZ0rwIE9eWMgrkEpFdDO8UkM6ahf5746DSrwXfvszupeM3Ga06EUCZraFE82eET4W5RjgvMR
 8iM/jaiNsXqo4N8WfNLdmMlcHG1MEpKm+6z41MRBlfYPDAE6Wtyj1/+V/+UsYKwCuIvs7c8oa+I
 Aw2jjisOh3yS6gzBqowpCjW8Bxynav5P9VLw3xgqyBqvsEMRSgmXgasWbvfvLcXwqL9yw3fcbZ9
 45pE2LMK3fXjgA8/1fbJZpMVTELUKy/uxmldFRrMeMLrLnd+cuqD8lAE0nhG8SZX5nq7j4Ri9/U
 Fx76l50/XI4mKGFSucA==
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

VBIF register range is 0x3000 long, so correct the code even though
missing part seems without practical impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index aefe517e0669..f4b8703ef856 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -3041,7 +3041,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			mdss_mdp: display-controller@ae01000 {
 				compatible = "qcom,sm8750-dpu";
 				reg = <0x0 0x0ae01000 0x0 0x93000>,
-				      <0x0 0x0aeb0000 0x0 0x2008>;
+				      <0x0 0x0aeb0000 0x0 0x3000>;
 				reg-names = "mdp",
 					    "vbif";
 

-- 
2.51.0

