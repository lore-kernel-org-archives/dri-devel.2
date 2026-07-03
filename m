Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE22AC44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 142CB10F905;
	Fri,  3 Jul 2026 20:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GzQAeyrU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d83wqcoO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD1E10F905
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:36:38 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KPWqP837470
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 20:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4Ewl6TyrZ/SLK7WpaVFEgmD0kq1oJXIxrfIN/wFdQXs=; b=GzQAeyrUtLWL/Att
 0BQGtN1jrzTo3PMxpYmNXjkP0hrCClkfQewZAXWIWWxjar8OD51Bd38B9gAe8W1z
 D9WqjaVyv3dEC1uk71Izsejfrma03HUbRJO8L3bUJwdJeJibdKzRV/Ra5BDO9IWs
 uXQKF8q1SKTXb/qI+Hz3JKMCpccz2ytTkp1c4SfdiLAJ+jaV5EMaBNg+Jxc4LtyA
 mbQiF85aF0mcSqVdK780tKeDjeK45dd8yvIN3QTb1wsm22g+OHDC73Kfy7ZCoRmF
 +dOU+6OBoHeh0ETKIAcxURhiNX2mqDqloLlkSr+myMny3zHBLPzPBegUcC3xzVAp
 /dImjA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68jytr27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 20:36:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88d7a75507so1489853a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783110997; x=1783715797;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Ewl6TyrZ/SLK7WpaVFEgmD0kq1oJXIxrfIN/wFdQXs=;
 b=d83wqcoO4MU9xOiHhvpzkzXwn9+9PbLY5YN1KmoNkTe3c45IsNNTPFwSUOI6Z1x8u4
 QHMBqrLI9mxUNNxXRJRUAXxTiaGGBJHsTW+db1W5cP1E6zDsfZtIKt7fORo7FcqT5myM
 gR7QatZapvq0xHr4FKt/hMLfGueYccCFDDVM21nEWSSeUZkN9L7sYWybvzI25np9NOXZ
 7Cslq2Km/6Y28/FH2fxO94TkMei+/AzGhsa5716+zOsZ/hKtL+ApEJRLG3e4y6GTO+xL
 D47yIgilEX1cBS5iztDSILuz6txWMSZm0Z0LlWAfC0sI7B0cPnlsC2hTwqElby4iqm0x
 DbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110997; x=1783715797;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4Ewl6TyrZ/SLK7WpaVFEgmD0kq1oJXIxrfIN/wFdQXs=;
 b=FIHYtVsUgiojhDHuYGMgj2bQGzRaUvUPbnrRbq4YsS5v+Ql1oVGgN4xfobB670Ky/5
 KmKBBhSeHYtm6Cc2QHon3+531iK/QPx0ly6lxB7K8HYYQPojCr02V66qe/6HgsiMPV3z
 dMcI+EJk2DGW+7tglfl5S2yY7rjhzR7T9CmbckqriizGTt7fsHwX/Yn/djCe9iljC7IU
 4mQqjPVTNndW2RUkTjRXHeeNDSzgdKnuzSJ+wwL71IbbdQ6n99/xX3ssDpNmFLaTBnyB
 AsBDXBr0h9ct8aj7TGfqWcHv5Y/y2d2JIvCOn81PKqknwlQ4cVOJFH7bwMXt/bBk8v6Y
 NjUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XsTtDNufwc6yfPOtt9+xZmO71OdsTzUvPcgGPGSHih1kXZqaDxs9IrXP2V5QE5fVJwIqWPSSUKt4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWCRzUcLFEZVXwMeS2eapBiaJj/lxFtkvxV8JgCFxzp2teDsDl
 Uoa5H5eVqiYM2U9SUzDrX7Ov2Yxe06sk/A/O0pnJT/2xGqQsKZnDy9hH5/DZdEzkdO5ivCq3clr
 lc2TfyiMosncCavsGnHD/Y9XmN6BEfcByLNREZcj5pRuzm8Z83iUDWh21SbiZ41Zrp1g3PYc=
X-Gm-Gg: AfdE7clZPEXgfjF31JK7tZlrLZzgWChGClRgC47y/m0izSFlNAH5vfF3Zg0NJm7z1Rp
 RrqNqugSrbUhiZP8GQYw+HFzp9mpkq5uRoOxZUPS3y4fbPx1bDi/NdEBF91oikNaVGrVawQqnpW
 j3LpA73WbDp6NIUJJnL8aNpAfEcjZfSkjF62kE8lnGvsb+Wo8zgC5p6IuAe7r8yPuMfsWqwwtJ6
 2BXSSS2z174ZrNEFEITfcPzQwCaLkYVMTt8NTsvZ1Qz2dVF0gUY6UDhZhEzTYXjiZ5Ls0UFPL/W
 RduYGQWeDWivXorExnFzTuydP4EAj1uivC4J76tJAI8g0MpcZKNmHs0nsCoVTGXPo6hcFBBOwhE
 tyOegfewF++0COldyUQIh7uHUmVigkw/AYDA=
X-Received: by 2002:a05:6a21:4cc7:b0:3b4:68e3:f16b with SMTP id
 adf61e73a8af0-3c03e3065c8mr805396637.25.1783110997150; 
 Fri, 03 Jul 2026 13:36:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc7:b0:3b4:68e3:f16b with SMTP id
 adf61e73a8af0-3c03e3065c8mr805345637.25.1783110996652; 
 Fri, 03 Jul 2026 13:36:36 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:36:36 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:35 +0530
Subject: [PATCH v4 9/9] arm64: dts: qcom: shikra-iqs-evk: Enable A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-9-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=893;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=MQlXtxhLQFtUqLHdZjGZifsTsVTh3ESNrqyekz7rOG0=;
 b=MzhVMhZap4fsAniWO3w2MNYPOUIaWxceqpeu98aHYIopN/QURKoMDWtY2N1HuWpigtKSVKySi
 wFaarKM7dXKBYN942TJzB1YH/LjyAJhqYOZLEi4us5GnzMYF3HTZD2L
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfXxxNdz64ld6Fj
 /RCFCF7abjCoF8/q+f3gaDSYLtR1MeDs9O1qSj0ztMeOnxMPYFdoIbtoYMJWPQedtmjIIUthpF8
 oZY/4cq6kULYPCo5QJLNRkOXfOTNfgty0/0zYRuV5tCqmhJREeh10phF5h/lOzpO+wNv4UC/QL0
 6pl2Op7DL8YOkpmj0bdaSwi1n3m/i0nbRxctrlXifGqkSF/9jE232frwk5/qvCegZGqTkxA1DfE
 MAiLGcEITNGQq32dJefH4Y+FFWW+/2QEFd9HLHw/FwzvoWHWi5R9bd1Ia12FoeBoo4r8NYqGDi+
 GcdxIDVKbSKDLKwR/KQ4a+k28616AlMVqjPpnlqyFOjPWRzXsntJQARBf0fX7CzXWTkJJwGGJHj
 lQLTyD6khIE5DsMglZlaHPsBAaZ5UQ1SrBjW4YzCdTBgQ1oH2mZwwekH34IT29IQsR4r6m+5Nj1
 FNGsP8F5RfkoJRDs9jg==
X-Proofpoint-GUID: yE6inrvDf1ejTEzcNbuxHYnXTncfIx9E
X-Authority-Analysis: v=2.4 cv=QbFWeMbv c=1 sm=1 tr=0 ts=6a481d55 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=C5heC5qkSJu3Z_QeR_8A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: yE6inrvDf1ejTEzcNbuxHYnXTncfIx9E
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX3zMhUDhXSyPE
 Ysv/iJDeRJ82VYG5gCtlYLECdypXu8crQ/cycUf0f0revD1fevigAH7JbeU7tiqo3Dq3+Z6HCJS
 KSf+EaHOuzOJH3mvCg//1jWgctwY59o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030208
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
Shikra IQS EVK board.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 743979b5ed5e..b51aee19ee20 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -58,6 +58,14 @@ &remoteproc_mpss {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/shikra/a704_zap.mbn";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm8150_l17>;
 	vqmmc-supply = <&pm8150_s4>;

-- 
2.54.0

