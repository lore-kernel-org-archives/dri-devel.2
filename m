Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA2DC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C5410E81F;
	Mon, 20 Jul 2026 08:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="G5EMX6kO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tl8h9lqt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E300D10E81E
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:44:32 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6Rj7O1713671
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VkXDOit3nwajTguZN8vv2bM/CQEmbAdHLSUwzgdY8fU=; b=G5EMX6kOszp6qT4f
 i6TFmF88Dm9O4nVjVX6WKgYrCeJEWu+LGDKHg2Q3ROF7X2lc/jwsBwMEKdQO/4iU
 CaGBecUpcR3qUG8Yspc1CGdZRVITlKKAl9L4wadNoRkUDA7bCPfd4No/PQCTANgS
 1ItBRafETSIQw9Da4DwYOu3f9beZDVP5kF++chY2/4cTOSTUFOzBJwFxYYuVbBhu
 S/wzCWV9QMlgduOEmCM3PfrM4nbczhJ7cOV86+UjMn8fMKjB1EDi8Wbo6w6Ty+Uh
 OahbgMb9v7fM6ku1/kuwqM72Dh9EaQJ1EGwqumbUaH+l+S9Pc9+CiyElrx7AcCK4
 gztYXQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc59ep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:44:31 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ec3314f65fso198876006d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537071; x=1785141871;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VkXDOit3nwajTguZN8vv2bM/CQEmbAdHLSUwzgdY8fU=;
 b=Tl8h9lqtdcJKjGMqZhptQbP278iWXfm0AQffeVfUC/Q11PjNz/H7c82316068y3qZj
 rgT9iUCZPfVRGiZmfdNbN/BsMfDRl8mXjW6t4LWTpM9diJRickzCdfZVnYRhmgrs3Jmb
 etD/9W8UJVo/sRX9QXHZr1KlGT3qztOJRG+KelP5/th5uvfNbd5syYi/AHm0/BvH3okT
 yz0jMNwQm6g5T7WXm0831EOg/eBFKxndJFtisiOnklXI+Itr9vwbqa2OTvMoP3zIHru0
 c4Tv44l7pAHC39PHlV1bspLu3mLYxbYB4PvLFA2+NHGYNBBn76SZW5GqywwUidRH6zrS
 M4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537071; x=1785141871;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VkXDOit3nwajTguZN8vv2bM/CQEmbAdHLSUwzgdY8fU=;
 b=oCUpi9Mn4KpEU5Db31OTHDxz74dF95kMcNwgNlTxhVa6JcvuMMb6kISrgeS17lm9N3
 AzX7jB6brpNgk2rlzEvZ9CwiV32sVzk7Rfo+zikXJvgC8fBcT2YteIBqi0C9bom20KS6
 bQBTEXoEzhFg8ZncsOB2SvtI1pKlZbz0PG9AdMsvnNpN7CUkKCCMpAW5LU025ZzbjpDM
 yz6Qp9KInaBepHoQAGnGPV3PC9E2qcWaMHSZiHu7F9NNoA7LAC0BFK8Zx+LhvUougahC
 8TM/zNSZwk3bejVp6JovRNVO/8oY2L1nc65SRBH0lYMYg0uZDYrThOSzMp65UngSQFb8
 9MXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSd7ZwCwMF97bgKVvN9FHd/zVgeOpWdDnx5do7OO6aInI3baU8EA1U8NXm9abOiSfxyQ2elyl9Qsw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yws8yCv1xESZfelc7E2cwoWGnQWRJX6nCehq3oGqS53dstWFT5t
 /RBkBhvviRtX8mGJeMPnHGc4uCtyN2cqfXZDc78OVhYIS5RorYxygagbMaAIai+pcGW/g7sO5Yq
 EcuIkq3FciVTO7ql1f7JH+Etk/0+OeSlXPKT6wsyQ5+5TJLD2ahtnxsnTaxNnVbYq1XNyY1w=
X-Gm-Gg: AfdE7clOVVggRxYh6g3QuxPyNoY7mqn8JxbQfAm/tiPCNGRL2f36fuOBGg5bKsGboor
 ibjm4EtoH4CKuuZo1jeEiBdYDsHbs06qFXO29RjR/yZJ6d9XM1sU90sLxFSZ/G72jG9DfuSCbed
 cndpmmupcYZagPITElGGYOtp7TAtF6P0PN7rLphbpsj1mc3KwDAl+X1BTuhWVa958sv0oiff3rH
 4wpHMWZMIxOdyoEw331Cc+HF3aVwp9Qcl5J3gldrdmg5TTeBb1lSxNQO+NtAxEqRhnpYiSwT2pb
 qCW8/CzfvNC3xMuIbiUFXYr0xEgxgzPsNEUpnqNulKceLMjBPQdj89i8a8sq71SPTDCFsFXIMKH
 ZXxjZzOR/xPWkwz60Yi7j7wxrB13421PV2dujBdOOJsrx9o/I6OQtaU17O/xJlPc=
X-Received: by 2002:a05:6214:4689:b0:8f1:f379:6b45 with SMTP id
 6a1803df08f44-907785338abmr140180426d6.56.1784537071120; 
 Mon, 20 Jul 2026 01:44:31 -0700 (PDT)
X-Received: by 2002:a05:6214:4689:b0:8f1:f379:6b45 with SMTP id
 6a1803df08f44-907785338abmr140180056d6.56.1784537070722; 
 Mon, 20 Jul 2026 01:44:30 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9077871f650sm87061716d6.45.2026.07.20.01.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:44:30 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:43:55 +0800
Subject: [PATCH 3/3] arm64: dts: qcom: Add INT2_GDSC to MDSS on Kaanapali
 and Glymur
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-msm_gdsc2-v1-3-4687866d6cb0@oss.qualcomm.com>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
In-Reply-To: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
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
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784537040; l=1802;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=CkRJFqt/VW4m5qRKt2q/9AJRY0uceEXzVx2depa2iLY=;
 b=eO1BQJDBvohcpLmoA6yL3Gujad6n9t74NuTPvHvef9LaH2vI8y8J2BlCtKOHVgqLCUIXL+afi
 Q4EaqItvlTbCCPXaBrGHnoOCal7EAG48XFCNy2Z2xbcjdSsLTrvOIuN
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX9v8vOiojK5x+
 0i+z8rffv56gnOzTH46XWudh4w44cFDv54BKZBDeO4pg9gb/xyMnwuXIy7DacICtTC7+hZhfmKb
 PQpK/QEyBF6Ha5NvzKhC1OnLipqa8eM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX74X+X5VMO6CE
 qJipfAHm4v/1esPi/c2UbpV/xlwFfoRs+RH0ifcarvoGMc2i2LRf1BPlWihpt0ZJYGgFeEzMDsA
 xK+LQrEr1BPup/N86s46jPAjgkwV6WcPLWn+J4apxXhTOs4ANZAaaOJmmU5cpkD3mdxhLP8QtMN
 Bq5YuOWo41V2xzfmOIMyQj7StJJk8LPqu7SjBeE7JtTmSYyunHCnhGWclV/RWa8EpJJh7K2WSOZ
 WTipyvjT2HiJTijKc5k34begoghTgeAFN7uZltHIqAJB2TfBeJQg/g9OfE9LBdGztrKXTjloTDv
 tqHr0rv8jdclyhvoxD/IGCBq/V1ZYiMArn+tz+ZwE1xBCPrkTZrk3Sca3nqIO8elh6CJdr14vif
 U8Hs/JlCTUdP22EkMOVR+JryNu6owFndB3F5lqHL8vlTgkNFwDcm+Y4yqVM8/Sel5Nrn3mr8kMW
 +4+q3shH0eD15gy3whA==
X-Proofpoint-ORIG-GUID: tl4l97ZYx4PDHVqCdEbmPza2c8exgFbX
X-Proofpoint-GUID: tl4l97ZYx4PDHVqCdEbmPza2c8exgFbX
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5ddfef cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=BnhMQQodrXrB4p16wh8A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200096
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

Kaanapali (SM8750) and Glymur use two display power domains.
CORE_GDSC powers the main display hardware while INT2_GDSC powers
a subset of SSPP blocks (VIG2/VIG3/DMA5/DMA6).

Add DISP_CC_MDSS_CORE_INT2_GDSC alongside the existing CORE_GDSC
reference in the MDSS node on both platforms and provide matching
power-domain-names entries for the display power domains.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi    | 4 +++-
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index dd80da14ab10..1e447c1d69f7 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -4898,7 +4898,9 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			interconnect-names = "mdp0-mem",
 					     "cpu-cfg";
 
-			power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>;
+			power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>,
+					<&dispcc DISP_CC_MDSS_CORE_INT2_GDSC>;
+			power-domain-names = "core", "int2";
 
 			iommus = <&apps_smmu 0x1de0 0x2>;
 
diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index ace19b8b12d7..ae851adec5a6 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -3581,7 +3581,9 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			interconnect-names = "mdp0-mem",
 					     "cpu-cfg";
 
-			power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>;
+			power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>,
+					<&dispcc DISP_CC_MDSS_CORE_INT2_GDSC>;
+			power-domain-names = "core", "int2";
 
 			iommus = <&apps_smmu 0x800 0x2>;
 

-- 
2.43.0

