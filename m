Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7973FC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C998A10EAE4;
	Mon,  6 Jul 2026 21:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aF8cCuQe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eiLJMpIc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD7410EAE1
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:41:34 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDtfS1650532
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C4mB77oGh7s9Y0Uqowh6UFsEunZgz5Qm0N6N+M/Go50=; b=aF8cCuQeNE/JRcAd
 bbZKBA9JgksxORNz0jvl+9V+WsgIqyei4LiWaABWQbKFSuc1ctnhTLNCBrqcGPiI
 NC455v2KZ5WRCVBTfiPwE031EFCZJrnYaIT61BxeEwlHjPkO3Qc1KqhC06XZPxef
 7Y0GASRkuIX2l2Ldcn8qEhv3eAmQZLSncEVUNNjE0I0JumatV4ZTY0i6fxOHt9Ib
 r9vCqAZclW4aTLVN2xklqwyKU0/9AA/PHLcAEszxSnR1uqaANj27lU20ZfyHSutA
 fBkS5gbEgxhclmFPZ1A/ic3Y7hAfaM+pCSFZWvFPUqNESZUxAhkl06ErXsETGFWT
 O19ZOA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgu5v7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:41:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c6a20348ceso49262945ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783374094; x=1783978894;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C4mB77oGh7s9Y0Uqowh6UFsEunZgz5Qm0N6N+M/Go50=;
 b=eiLJMpIcu5bxfqe7BgeQTWRQbKA6AOUpyo2ewhMaAj6RuqxPVueYaHNRZtxEWNaks0
 eywBvdwnoAMAuiy+PHguOLmN6wF3I/L5lEWythvucaK+NUyW+nVVeOX4jJSsO/Q05rlG
 kA6VacU6661Rcz6ZhNT+wbHtJusQil/vCWx2LwyyAFVrTpwg7Cw/1fVL1Djs/Gpa1HT6
 fEeS2xaWm42b5c8HUnAHCguPxzK7rvUWPrzi2zbKQ+w+T2wW+sNSze16at7z3Y8rGVo9
 6cNF6gEZgOm7aC4Jqvb292YpVnRMGONWsBGSYvIZ59lheGQ9IWIb6TCQy959mf0+CVg/
 LReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374094; x=1783978894;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C4mB77oGh7s9Y0Uqowh6UFsEunZgz5Qm0N6N+M/Go50=;
 b=iAInW4ATVf4cN6SUncr91OGhX+bT44hJVUoUawbuJkZI8Bn0qLPfICetp6lW6nyFbu
 5Cq7jckbNkqAonPYPRobK5hnxegCV03XVlJq6pv0c7nbL0Xma7c4pke4+xJTKY1VAssH
 0xpFfzWY0hwEETyP50SFOFOEnqhs5QO91lmUlJEh09AHts70mRDP6ob3/1SGovGN/hMu
 mQoWuPswZgbxp7wGY1co2nLX7vzuckqjKKsJRGBGoS6M3VSRSH1q4geiEG1Vxs/Qo5Nm
 mNKbpaWjrSmahQnLFx89GpZkyHC3O8FP4Xw/u4OmDptk2Cv3M6rdwpGh7ow5kfe7DCI8
 4LDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxY9xyACvqkSFcjpLp/7CplHBgUP+dAiVokkNFqom2+Mqs3DenN5DCeDKGjDPGxJuUqcj4Saq0i9U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrI5mW9mOY9MgECPDQuHcS10UTBokzg4+2z+rJjv56r0CVLFSK
 fAuw8fr7TuHvXZmIs86nLVFlX+CnBeJahsOrI/YIfXo2v4+t+KdXQODmFPW8nQPsvZ6mJ0pOlNw
 j6SYoW5rrm69iDwx3AajI8BEdI6SLqClRXoJS9YYjk1nWjnoR1Ro8v7itfITfskXbLG3JBaw=
X-Gm-Gg: AfdE7clxHwbf97Wm6j/6433HGxsQHvnTgbKSNqotrx+Zk4BbYyzTON1ZRRiG1c8Ill0
 vgWPQPoc+NRsF3qzp20ZotIxXqJO1qfa7+U2+hKCRGCFe5CBT+vtRno/DH0s2TcYtV3i8DNCkWK
 +A3jA7qVi2mMFjta0U5gY8oFm2tVP0hVlE42KN5BBHdAafewb3RQVZCbN5uiPUm4yu1Lgv59Uup
 fOJyNfQ1VWmekoD0VDs/HGdxJEneZtMvQDABM3HtcSx9wOYquKZILT6EhMZajZKQOIh1WyEcVZW
 brIuWhQWdJIndDrSj1tS4bHZOLMFU9KVypEFYyn9aSf0WjcEbkZ0CS9Zr0LrgSa62R+gwzpl91b
 sVUniur1pwP0RX1aTeSSWZMwRBA2SPqtCyOE=
X-Received: by 2002:a17:902:d508:b0:2c9:97a7:f548 with SMTP id
 d9443c01a7336-2ccbf07a0bfmr24977895ad.46.1783374093654; 
 Mon, 06 Jul 2026 14:41:33 -0700 (PDT)
X-Received: by 2002:a17:902:d508:b0:2c9:97a7:f548 with SMTP id
 d9443c01a7336-2ccbf07a0bfmr24977335ad.46.1783374093148; 
 Mon, 06 Jul 2026 14:41:33 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:41:32 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 03:10:24 +0530
Subject: [PATCH v3 6/7] arm64: dts: qcom: kaanapali-mtp: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-kaana-gpu-dt-v3-6-8dac9a60dd5c@oss.qualcomm.com>
References: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
In-Reply-To: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=911;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vUUf0SFe8a51kmB8FPrJBDQ5H++K+t9n0PvwI74fWXs=;
 b=aWOgXzjDLGOk6ap9wWT6nV8R25bUMhTcQZ8FX1FCMAyQ6W+IvA5VqINg1OxgXuse8gpeFkUWT
 zQiCbM3Ci4mBiSxjBmgJuTY4/9WT4cqs0AYsxWw6lJS2YMP3ONPEr6w
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 67A9vQQuiI60_4pxQglsX0QL5QinlvIo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX5pfRTSmufbvL
 PqnJw2icZ6mp2ieapGfMSEsKI7t5/7xxbbrgCoIoNwMddqAutq3czpebhxtRxQbPL3FFRoxBSQ1
 IrTOtbbX4Y1daD1u9qLWRuHdAJDRvPa6kvHBpRgkaDOH742CzcqQe/fwkuLqFEAikAxg1v6R8Zw
 qvqDAzXJhGX7n4/k1dtwD1xq97O3cyrJCVXZmw33Gl3XlWxQ8pgvCH72g7gMuZY51TB8Grq9mIk
 cklsWmvKBBsE/GAIQ/q+aveY+zU0tby88r7NnoMwddKwYxcFbOZPIr9BMG2GpkR+/TXfm0/Izhm
 UUTCLffZfJyhlk773IDqCdurumzImAqaOwXdWZjmNbbLqsgATve/EGWsJ6RUrvDjtC6zcBVRhzs
 DDoq5MU9aKBIcViwMfLlay3l/f7GWO7tUgs2eGFK97IkAIi2/oyjxyi4zJM+WjWbrsBm/zxrzzt
 UMZq5DaIsDm3jIy909w==
X-Proofpoint-ORIG-GUID: 67A9vQQuiI60_4pxQglsX0QL5QinlvIo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX0hsiNH0o1rTn
 k4Bp5+jJldXHcllEScU9WcsiPPMULcD9GnsIHvbyhj5qKIXg7wDDffcGXevLigxRv6+o+KstY2n
 YdkOvL5bP7nMZkyzRpBxpPROjKnGR+8=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4c210e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VHn1p_zO8-rooJRYzQAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060218
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

Add the secure firmware name property and enable GPU support on
Kaanapali MTP device.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index f9b5b5718b90..ba256039dd3c 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -865,6 +865,14 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";

-- 
2.54.0

