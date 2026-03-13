Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A2B105F79F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDD210EBC6;
	Fri, 13 Mar 2026 12:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="adZxjFEa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TF4/3CNu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8DC10EBC9
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:09:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D7iL6E2262551
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bP04qDOHi3y
 ZSiapxHxzYhZg7ajf2prSRAxjflLSrgM=; b=adZxjFEaFGPXbBuc6bt0VXyFXag
 S2m5lb1E6f0ajhnfynpq83YxD3HD9bf09BKI4teFVr7Ca5fPSzvidCbS9uKYR0h5
 h0e4eXK+nZPAx8eRewuzTIH/aSSA3ZkBBulDr0nHoaSGw9n7jSd2MWGQUhe71rZz
 Zx5vVjkF3+plgtZammLSSgE4NcJnk6aFQzY7ntxCDOtr5Xf4EinX4hQz5Vq70jkM
 jFwfTw5knn/B8/lDp61qUtfJUQNp/ZPcEKOCaUI4owrF2adVLP1SOt2rObcBRjZx
 dcqTJ9F94pPwxtNRYPv6QcW596dMPQ4TEQr1YrqhOIZ8ePDnvOho+n+1aVQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvef4rv9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:09:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35a019abd6aso2173293a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 05:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773403744; x=1774008544;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bP04qDOHi3yZSiapxHxzYhZg7ajf2prSRAxjflLSrgM=;
 b=TF4/3CNujqxKN34t1k9p3m33qoonnphVUfFJUr1Jbh4XGvBsHz+XNbwgDmdJiC0JX+
 GL9Q5s6iEoj2hMAdKTjX20eFfAi65lSmm1IH65Um5pK0GjOHcuPgWEQ+bCheQNPMS3cw
 cTLALqtYRgm9atvVvT/ClWo127OsaxN0Sm4tjirpJk4G5vbL3bozLj52kJsuY4oFMIs0
 OHltwn/X4fSFDnY+wl93Il1E1sjgoqHiuN86k7vcUof0fKNt8iZ/ELcpWqsxtDpIEPCP
 8T0PAM/RRFMO8mcqgrhQqBdj6XdxlxXlNkCKHZnrA3S3JjYFEkVhsBX50IZIdv+Y5fyJ
 an1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773403744; x=1774008544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bP04qDOHi3yZSiapxHxzYhZg7ajf2prSRAxjflLSrgM=;
 b=tJj/Sz9yMmivGXIzvK1rVNgP1R2DEzcw9J33GrLcTCGlnqr0m/AjGLIBrwPzIrKKZw
 3Pz9wCzgPO+SjwCkCYx7nbBSCwWXoF5yO/2mLv7jhaHqRX+vwRh6L5Sg1R+d1bkZoInT
 kKiLv7aXz5ui26bD2SPORRuqPKd0Pt8jMSlagzCOQcHYT7JZMq4Baib0hM4/RLSIpxty
 78CAp3o50H5B25ZQ5qgmSE80tkDeIycCQQbZnJK9j0E4w+CCbZs/S6lM1AFLxGuqCxbp
 FWfT+agQ6knq8LjyIDDLghdsA0PdnFgwC2E8PprgpyCka5m2bomGO3T7lUlqG2uSTuKD
 vJ8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoerwfjD0vCe/MlDjx1Cnz7g8dw3tEZMUDH06w2fHXgD5QrpXFVq1W7ekAKbKMnJf7U4kZrFSNCkE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyb9f9QOAfYGWlxnqKUiUvtiPZDE2UQBHhGtz/3NP+dbMS7jsD0
 BHqjJSq6ON+o6TAlcZIWNPMX/HNxs0/rgr5l+/CTmb82ENp8EVlJj3jkiVbc480vMNe68kFId6g
 Ol2Ngz4JTDG5f0W6FZU579V2H841EsBvVoV/CG+NYzbCbrk1VmI9de+hE2RhPvEGwgXklNWU=
X-Gm-Gg: ATEYQzw/Q0UfLUW7qLaUCAJm9FD1f6d6OMpJeRBZb67n7ODg/iy/7AyP03tHVs8VkjT
 OY1NZ4+LB0lVB12FE+dMxZMtdnXqLuA6LHZOccsMDAGlb4sERyfQIXGST09wffrLSxXAzimRs8B
 /KVssd1/HIF4t4rgE9DWt2+I+5SsCym2gCS5uHQoUMERA3t01bPCVXV9By/YNDG1/aWpYlUeaMw
 M8yU4QjlzvuTim/bb7JaVHgyn/tF9sJMuspAbAAnPxqqwVW6yg3HEwzc8JtvfIeCb6rqBbstVU2
 spoFvzWLhfJGB06Loru5TLs/30UCtKMd+09b9W1cvjCw4vvia28KJmhHcMbBZ2PiCMpfW3bVOnT
 +GO8fx9oXa+DIAAbYTg1O0SN5+LTQ8FWNhk64tHNUjxJlJPo4BEyVCFqmaI48zkDr05LCTsuLH5
 NprIMQKG/YJacgWXGRWMxR+zNe1+qjT3kyc/GY
X-Received: by 2002:a17:90b:3f85:b0:359:8a78:5696 with SMTP id
 98e67ed59e1d1-35a21e39beemr2475415a91.1.1773403744271; 
 Fri, 13 Mar 2026 05:09:04 -0700 (PDT)
X-Received: by 2002:a17:90b:3f85:b0:359:8a78:5696 with SMTP id
 98e67ed59e1d1-35a21e39beemr2475386a91.1.1773403743835; 
 Fri, 13 Mar 2026 05:09:03 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e18f0asm8421945a91.1.2026.03.13.05.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 05:09:03 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 mani@kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V5 5/5] arm64: dts: qcom: glymur-crd: Enable ADSP and CDSP
Date: Fri, 13 Mar 2026 17:38:14 +0530
Message-Id: <20260313120814.1312410-6-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
References: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xYunbefIovbfg9F6Y448BN00qv1czme_
X-Proofpoint-GUID: xYunbefIovbfg9F6Y448BN00qv1czme_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NiBTYWx0ZWRfXx95OmTQHumnG
 AJ5W8N4ilOkVM+Ejeb/UAuubzdXAwMAaLSIKxLQKLj6dqz4SC4t0rH2kuGrtfNU9xlPL+KC4i84
 CMQ+vst2xW7kW/nu/2l7CEnymAPdfQXT0TR9LIRHzQoUupyflEpeE+mAx/Mmxh+AocKQ2K0rRWt
 mhyL2DYYMwzBELS/ZbkveSgqzMNIi2jBKOLd6Xgu3hgaYtDjknME7cnjLhFv7V1eBk4Hqd4ZrJu
 YM61zNF7/ZU7wff5x9WGlar93/64EyaRg2/dvk6nketSVMGUv54TOanuJXI9K6wwNsi3aumTeRG
 p5suMVJ8/Kt/eVWLTwt8QdfBpLWAMyl5dnkxS61rRGS8i8qRcdkdgDkxq3J3Q+zc+QpkD/uXCid
 r75jec7sZNl8Pp3+5LOddVkOcvXN4tiug38MJ3bYd1rUUPOeIBoJbKo7lBfS8Uqo/qNPukqdUlw
 +2ogNo6pFteZn5YdJSQ==
X-Authority-Analysis: v=2.4 cv=S9nUAYsP c=1 sm=1 tr=0 ts=69b3fe60 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ePUXPMwdJMzpUIYWY5YA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130096
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

Enable ADSP and CDSP on Glymur CRD board.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index 877945319012..6b7f91a3a968 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -485,6 +485,20 @@ &pon_resin {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/glymur/adsp.mbn",
+			"qcom/glymur/adsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/glymur/cdsp.mbn",
+			"qcom/glymur/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <4 4>, /* EC TZ Secure I3C */
 			       <10 2>, /* OOB UART */
-- 
2.34.1

