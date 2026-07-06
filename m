Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E61CC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C08110EAD5;
	Mon,  6 Jul 2026 21:06:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AbccwYny";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FeAf7Vm4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B01A10EAD4
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:06:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDxha1478039
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L1sQOlc7W2R+Nl5G9nVFB2M5cH4AGDkF0NzQkvcFvZA=; b=AbccwYnywChyPTgF
 RBrC4+h2W36mvrkx3GLid2XD8jzQPcYsCBVJGtpVUJgTXhdJutcHjTzD+D4t3OmW
 lAYD/YbakPxt2eAcAAgatuogf9tjrG0N3iZnhxmtMXA+tqUfaMGgFLTSup/4a7uv
 Ai9+L9f6UpPHNpTh5q4IE4Pf/vvUYu1QZathG5DaDd80P7UTdzhStjUgkoSyK+lQ
 WulOaq6W7+4URzgUeBfR5sepN6WbPw4AVMZYzUHzxtrLvY43BLm6GhQXeLDN7FFH
 SFsdkd+9rhUtY/gn6R1ofBxxyGg3sYXhf8F+1gFjx9+PAI1fjgUsEukv3e4jEKij
 JNNF/Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsbbfb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:06:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so5011042a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783371962; x=1783976762;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L1sQOlc7W2R+Nl5G9nVFB2M5cH4AGDkF0NzQkvcFvZA=;
 b=FeAf7Vm4TSxEDkU6T0PKDI1hW98zGNAGEp4JGoLedOHV8V4YKbZuJhDtmMucXmRCt3
 dAU5za2qQmhwa+AuIjqufX2FqpONxoI24lhIl8VzdmRQaFc9GL9a+u0ZtWNqgys2ZopJ
 DoIvo2Pkkc2W4whv92zC+e3JgShVauOgXheVLZ5DzBszGVSMQjd9gAjA+5G3aSSRlawu
 7BqY4ixktqbxgl2IHYWBlgOF/DPsypYfW+E0AlaamRFsvat8aiyQUmHMqYtGQ8ulr/xe
 yLoQ6DbB4wnm1EGhDFAQp6NkK6VohXIQQOTFPdh/CA/M7kfsfSymk10XvuPpTTWPmXiH
 Pbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783371962; x=1783976762;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L1sQOlc7W2R+Nl5G9nVFB2M5cH4AGDkF0NzQkvcFvZA=;
 b=ohVGv9ss57yTIwdbxWu43jItP5McYHt7//J++AFHEBO8HwBVrTjhRYozoJn97KGWkf
 nlKinD7PgyiuQnPh+S10pHoN9AbtbKAuBRstbtGBpIePeKweWTEUM++6dwZ4d0KokQJx
 SlLjH3ienAeOEXPcZZOhCchRN4JlOrCLg/oSZM9/Xf1UelfPVHPriUShrBpRYvxPe4Lg
 ivjoPJvmPL5WCVOiz+VcNjw7QbxdeHuqlCxYakgIvY9MS1Iz+ZPjMSihRZmsleCAfDwi
 y7cKZ1xHJ7/vIuR7j5zXI7H5C9gAkovRTMWAmcdaGZND036+JL4Z3vrPCLKjlle9rCJe
 yT9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrsQs/Pe3bCV2Rw+WVGt528ZI7xKlYLVKNEXDDGQl2dXit3ry6u8NidRps2FeKPZhG0YAA/rqPGjFg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOgJNCBUgxqCxEwN9C3y8jEQT5GJfMOQLaVEuRiVzJkBYDIVii
 xVueZ/WCq3Kb3xab3GPKZ9pWau7Ja/93e0G/YGtFqTb2sYE9q6xeGFfcatMMRWX7vFvQMv7yAx2
 n5pDCRsBYPI7GBSoCRGAWGGR/RQlbb9RNA8gndPq+CtYgOPzR+XwfYjoq7CFMbP7gRO0YRA8=
X-Gm-Gg: AfdE7cnNMaaMZY5Tvqh48yl1gFI5MVjdVn6zsQlMFoUniHPIaBujXiyBUraZ+ZcaiTD
 iFKaHkCNM1KBINCx0KSEZTpVbdX33jWuX+6eWnMrunkEUJqRJBG+C+GUF29Guy+AE3b2jxADhsL
 j3dC63kIEC91y8uN3a7FZQ/bEDTR2QRvdxXezOAlq8FGwSkVldTIuGaPR5Ggnf4OJdkohTUwkit
 /RoVbij6n0+ZzFSCIkkxsYvTPPMV5xqw/AqkKx2qH+IgrEhaJkS7xzqJ7m9D07R40jNb5tM9/vR
 rf1dTqTlBalZ8AVou9xh93+3JG0PKjY3vpogKWazfBnD9FAF/AYz36Vv49vZ//ekWaSoFbgPDjX
 RZcYx8rWYmK3nkf29VnJ/4VnCm8qMpDtItu4=
X-Received: by 2002:a05:6a20:be8f:b0:3bf:9615:12da with SMTP id
 adf61e73a8af0-3c08ede1ea1mr2865625637.23.1783371962476; 
 Mon, 06 Jul 2026 14:06:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:be8f:b0:3bf:9615:12da with SMTP id
 adf61e73a8af0-3c08ede1ea1mr2865583637.23.1783371961997; 
 Mon, 06 Jul 2026 14:06:01 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:06:01 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:39 +0530
Subject: [PATCH v5 7/7] arm64: dts: qcom: shikra-evk: Enable A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-shikra-gpu-v5-7-d2f373912d3f@oss.qualcomm.com>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
In-Reply-To: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=849;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=TpvtLBwihWHNEKd1VwQvgAfHhzoeB2GGOqDfiPe0Xho=;
 b=dfyRRLzk6X22LRvVuarzLJYhr4uXZga/lIRc5OYOiiD8py29ZoBlA877+GkX+z7ssquDayLoS
 i736/Elf9UxAHI+/pIfeTDFCmYSKvza3YQP347A19hJlyWFrrg1G205
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: whVArxhFBojbqt3TueIridMrnlreXIba
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX34rvt3jjWgjC
 EM1cnp6s/lkksp5owBGuczPWGrXoaiGdeFXSXxvCZyYENzSd3lxmqL8dHh7TubbbgkkYnlCEzcS
 XZfYN1GTmJAyFrKI2Lrs7CvEYD5n5S+D8Pxu0zwa23W/yC8d4eMQHIWiBsQJ3dgKp4lYRHmS664
 jJknZNyIrnOoh6Olcl/bMW89kV0Ub1t2afVG8unqdViOubJrDafVJvqfj8r3atKD/24Lb1nTESH
 ZjObUOeAPyc0LzU2IrI3o4b8+cDqZlr8LI3FFTh0Qj0UiHMSxSGYeLtkO7GFTTN/mBd99IH87+O
 O8CCI97JuqATwDLH5QbiE4zVKjAlng3AZfjbHURnGCUG+aAQBZaFMhhSn7tSR+OzN9df+vL4ofT
 13hTkKLvYsQFbXScwrTn30DhiW8BzxyRrCkxwylkKpDyWMhs0aN7VT/+HwgVeXASEDZvMxj2q5K
 V0x4SINPv5KZpJnjREw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX1+SOd0f2YXp8
 jIVQKsE1n6GYyrE/qfKd3Gataa0i6J/28sAFay2agTefwbD8G0ATLrToEcitO1+xmjpNoUCGmAn
 FGYBLWrwCWKE+rHN0J/t/XRCYOFbDh0=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c18bb cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: whVArxhFBojbqt3TueIridMrnlreXIba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060213
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Enable the A704 GPU and configure its zap-shader firmware on the
Shikra EVK boards.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
index 4b7be09eb5a5..9febbf200f10 100644
--- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
@@ -36,6 +36,14 @@ vreg_pmu_ch1: ldo4 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/shikra/a704_zap.mbn";
+};
+
 &qupv3_0 {
 	firmware-name = "qcom/shikra/qupv3fw.elf";
 

-- 
2.54.0

