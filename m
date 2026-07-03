Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C08EC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98BFF10F8FD;
	Fri,  3 Jul 2026 20:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dveUoURl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GNAcIGeJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4304810F905
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:36:30 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KPSAf1019174
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 20:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I3Mr60y0+dO9JKpcFRd8+KSXVcXHZQThl+NbZHMGx/E=; b=dveUoURlYPAM5nVI
 5PErai44qS1UMMuNlvsWX+1GcwixZE5ClKW2MidRZEDujcUNX5k1DLccb/+8ixjm
 4Knjeh7HodckZpt8JkQIn+WOG97zt171QbUAn3uQjZ0fTK1QZ6wE26QuxLFBRoTx
 ZHL0QxBC1J7naXn7Xq7c6EuQpm1tmTI4BzNVDIUAhPpKDm146kTkisdrRoA2rGFs
 W/ziGpTcnX/Tovv8XR800cxXvTp38Kp7ZV8ZxcPOdht8VlvHqEWKAmpD4mr94jyJ
 v5fAUBikl/SyskA6uCGhGVo/qUsn8GeKN9XMFPP4zcMmUHMQbHFMhrA1F1F15fZH
 gHRppg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj1ngn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 20:36:29 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so287847a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783110988; x=1783715788;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I3Mr60y0+dO9JKpcFRd8+KSXVcXHZQThl+NbZHMGx/E=;
 b=GNAcIGeJCq1tsPRmHwZZNNsnQv0x4kNbmjAJwRDFsAT7ygpl9hVIOrXfZS9NQ8DYQb
 kgxidIZoQ4oaEaYbS1lp6DaLgaJ97K9s4kHGl1qdfzkCDxZZwgKx+8dDuSOTRPDUWufS
 hhXwwv1MLpB7yHUIgV17cnpD2eV/1c08C3uOqvk0hua4bzxXUIQJk6wriK6lchy1yVy3
 fhmJEVO2pMDBNfHtDdhqpbyaABBKNIjQ0WEfrYXajj6Sit7eiGYtOKU7jKXOHvlhMp1C
 FeyVkQT2LDeTOX44/WtyF+7HCUhl2JMpNQurv3pUAzy5qUk3a2j0yXtNhlrjQKmXP4XZ
 iImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110988; x=1783715788;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I3Mr60y0+dO9JKpcFRd8+KSXVcXHZQThl+NbZHMGx/E=;
 b=I9r2v5WDnT7bWiirNqQK+CggP15U8U84Tn1LvGq8SOWgO9u6QnprbBqOuD7tbuWGaN
 HQM1/D73jdx1bYiUgblY2he05WBWu8mRxStN/fgpUQPWHIgVWrkpTWOdAVPm18r3Nh1I
 92gcvqDQki8eRCZdXe7hyPSDzrJKlDB8hkv8jySc52eF+23CJdpBJT8kn0xJQiy+MH40
 MhNJKynotTlsHxl0GFGtJWwOQ2ZOjOLbFpXSPGuquDP83U8b5lH9pBYuNYi5z7IcNPwa
 BpQ9seLibJp7IfjD1A7OKK80Tao8qBcExv8Fct2yxqWHWS55n5OOMjxg1AKDPaeP5swG
 A4/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrclXiDZGBqVstsZN28fx64g5tr/4j13nwGh4gWWa781Q2+DmhUXYpM3XXl6IP0DF0yLS7vLdkGBPc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6Oz/IrVQai9yTbekuHw6KYowNeQWN6DIdsmkF1ceglsDaxgvO
 vilLWa0VgOiwbpZWMvxYpSEct1xLEnmCebqGMpTlH5lCbTPY1UEkfC3q274v4f4FjsQPAtCyW7Y
 UjJkjEL4hAdTu1ZNI7Pl/yDWkUWv5zhaOC4SBWnL4Z+QrBMryIsDQ6LoY432TIjhxeaBo4Vk=
X-Gm-Gg: AfdE7ckqIrBgw+gMFfFsVCT3kgaGO+/Efv2JGGFHpjDmNiZGAU54SOdK+NGFj3jfeqp
 cELzghktY1hnsdaXC/7VQQy1Vo5czfyM6SRKfUFvBxBCiSlCCPeNi4aYH/doRARXbQLen93r8vs
 4yoSTUEWrFg0N/3ziVEsOw0Gyp3GC8EbdbCee5GCZkkUu4jZQsCnw4gd/6JMoPr553g67hVztYl
 9Z/pYhceJTP1SQsL0HdKi/+EU0PtSr4VAteUSfWgJRvj+gtt2+UIFyjgemRVF26QjT3gny1DgLI
 j0iQYOIj7sQ+veNIngDIE4CnAWVmh9RcAgbHKaHVtRbmQBdeV8Hx+pw4fnkxZIPJ9psuHKd+Qhz
 JyHIgMEFwnBZ6KWDLOqHt+Ok1LfTW1dfzzwY=
X-Received: by 2002:a17:90b:51:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-382808b43cemr879968a91.8.1783110988390; 
 Fri, 03 Jul 2026 13:36:28 -0700 (PDT)
X-Received: by 2002:a17:90b:51:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-382808b43cemr879934a91.8.1783110987939; 
 Fri, 03 Jul 2026 13:36:27 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:36:27 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:34 +0530
Subject: [PATCH v4 8/9] arm64: dts: qcom: shikra-cqs-evk: Enable A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-8-90cf1a52e539@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=894;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=gfyhHgOTYf7Emr9cLrvSN0kypJSlIEIIltSML9/b06g=;
 b=K/LDEKPGoZfUeH0tbE74ajfDKOByD2ZHrcPWd7L5t+EUoogX2zIW7VdSETU2ARUATIH0akAMR
 AAKcD2XotdRCPLTyDSnzTY7LWtZbQ9VE2nior29pU513KlghswTzcfr
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX8q6tJEsuB6/S
 wm0PVWxj5RRcnaYtLVXfgwsA7OS+1UgxFT3fbXPyEXNXSsvOTOm+5Srj5pWalKeUWRhiZ3yPDft
 OuOqaeY0HTl+x357YdxZqKvOfVL3rgs=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a481d4d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JW4bpjJLMT2bmMDKeKQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: nE2cBpD5m77bCk_XY_LitwGxa6Y0pG_f
X-Proofpoint-GUID: nE2cBpD5m77bCk_XY_LitwGxa6Y0pG_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfXxd1MvPjsgcs1
 07a8FppyLQEKj6Vtpw+BHJC6jpimNLDQRLowJz0E/4wIkazlQGpFb7yMyrgj5JjAprny5al6x/r
 JCc8o5RszPfnqUeFPRMDozpdvHK7/sUMS+/x42UnZWKY7EPluYOdDUzcRCfk3eNMiCfcnu8WrJp
 jWHdExubYMrVpkzZMAHkfnQLN6yRiNgjqZzUjZiDM4eHjPpFkdHix/E+Fdf8G2OtJXDuJa/1Lgi
 pz8nkL+qIftKwkZP9rqgWZrZRoJx7hy7sFpO/xnGJIDIiJUNQupcDEzdM4XOX8R9bYhx5ZpmzDu
 75DJlQ2TcUxzYQQWtw9k50DKFUalfwqqHFQgDAniwccCoKj22qPuhqahf2Dtg81adwimCgY9hKq
 ZZeWG+oROLYjxSGb/wvb0MY0fVypo6x560l24t/b7JVmNj3QssVHiga9Zdgmbx0fkIAIBWZvmHu
 r3n7sHxZ4hrstWu9fyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
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
Shikra CQS EVK board.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index ccf8f856e994..a95daed1581f 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -50,6 +50,14 @@ &remoteproc_mpss {
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
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;

-- 
2.54.0

