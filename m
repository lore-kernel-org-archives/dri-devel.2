Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325DFC44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BD1610E9C7;
	Thu,  9 Jul 2026 18:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XrFaRUVX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fe4aoSA1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FFE610F667
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 18:43:29 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXLKT2517485
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 18:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L1sQOlc7W2R+Nl5G9nVFB2M5cH4AGDkF0NzQkvcFvZA=; b=XrFaRUVXvcGaBNhE
 ipDn5AT4mzKJkmmrNwgSczG9YfhH1HLN3LqbVGfzkoZ4d+ZwQCBxGoqoiFq/8qHt
 LQeFAijKeUWmlUvtdQY844OtLzkeR113+HWzn6J/DkvbdkjV4Wzt9AljQ6uoLrvS
 /z7SYXRzAGTLe71+O2jVCHnKtHXma/1qaJij/1uOa3wOtCKGkq883YeFVm0x+Whu
 HnN80yEmEA1TBY5RL1xnMvuHcoNPyKyfIeFpPwUOUH+/xEE1H74Tl6x6a2Wzv6gl
 JXLe2o9ZvPhGwnGxQ9/dwKR3udYAL7jP/LSWLSWx4hD1y565HjsEsXkKCNuql0IK
 Z6rgdg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesrx2c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 18:43:28 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c889d1eebafso265196a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783622608; x=1784227408;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L1sQOlc7W2R+Nl5G9nVFB2M5cH4AGDkF0NzQkvcFvZA=;
 b=fe4aoSA1sOQCSpnBEZ61+Tax+whoILt/GKsglGip7ulCMpm/Nw3togquwHogrO33vp
 CC9T1AlwHr9Ed022vsLbmbf1XBvecSOJjnTSmWcXlactp1GdO9nMo5VfyX5souQHwbos
 w6c7n0v0eC5E7IyeZItuFXZN97PCDUPWa8bH2etDsBeVWs5txKnstVtWn+9rnVcvG3pk
 Fwj7PryNJXIqw15OShk3VqkXs0nGWxOlBoO4E9vjoH0F6xqu8qQBHOo95UhSO/FeLb4u
 VoVlryEIFCU4k5+ioCltcANM2+PwFnSvce9sfAsTSXOOyrSl++AGkSH3bt46gXkgel4c
 ZjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622608; x=1784227408;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L1sQOlc7W2R+Nl5G9nVFB2M5cH4AGDkF0NzQkvcFvZA=;
 b=kMunl+wMgSNypYK+8QoLhrFWYFTMkwaRjvI+tIm/NtFbDEChQImJ4R0pKJn3ry6OzC
 cZK5HZ7CrhUqkY4s7FEuNbh7qWoe50FGaSmgIocqgwzg/7tHrtgG41qMKNeU0AHLY4ki
 WadaUOKlpaMQz/Op2/XAisYyxn33BRvBfyYatO6RPzOaHUruGMQxwec8CZ6Dgtmop3/J
 wkbcgEqd7Z5uiqfefJlQokYbeaie6r6gu28eE/jX0tSSX3TRG3dYWohTNyk1fDqO+9pT
 8Tr2jaEuIkfL7FmGrKVxqU3Bvqlh9ZeMToQuI37ggBUhU5k2S48P0Pq3Q3KPBk+JQmNv
 UugQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKLZSWrUNeKYOpcy20uvbNbOXHmKxKMuBT4sAqq/1fVsaebFf23Q5bo5zb2qTB3cjLPOEtTy1m5rQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCDejUdsOmOUfI/glCrPi0BbqXLo3uUndYD/cStEDPJruy4Ign
 IhXRTcvW1vhQnGxzKonbazrwRqpfaZBSkehTmFbgS5WxHz+qUxQ0JmnoSnPSId5ykwCqmKeieEV
 JD+H39BJLI/0aX7EMnK6K+DmgjAjPDRiYRYKZP2TMSTGLJprQXkRAyBacw9GN0vyP2vqs1fY=
X-Gm-Gg: AfdE7cnwiW6+aBLPGTGiHOPJt7yGWF8ABivpMCvLxJiRu+LxUDnBYcf3RXx6bY3zGQF
 Gd0pFd8OX3/R/EO6guKz909vmStU/lqrXTAD6UXBUJjSyc5JxI1vuLMghjIONw5stnOWcUvxP80
 7RSvhbKy3qStjVYYEdM5S40hUL0DQ2EVyhWT40q6O/xcm/ZdUQKyXlM6v8ZjD61+j3TT99VjQE4
 0i2oQz/2wMAAG2xXI7O7TsCqP7SHrfl5x8P3PejwyGw0jH24mhr3l+DNXnu+ReBGc8wM+QqvMsc
 PQ3pvgY4r33FVRP4JPyGizGJzWaBZNFAJS+l2ebNUKA5x1qOIi4x/Fivz+W7r66HjpcrMlM+HEP
 xnyWeYFYaHAaGutZ3eDcrJFe93kNrl/C6leY=
X-Received: by 2002:a05:6a21:4902:b0:3c0:b766:750e with SMTP id
 adf61e73a8af0-3c0bcfea632mr10283284637.25.1783622607972; 
 Thu, 09 Jul 2026 11:43:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:4902:b0:3c0:b766:750e with SMTP id
 adf61e73a8af0-3c0bcfea632mr10283252637.25.1783622607576; 
 Thu, 09 Jul 2026 11:43:27 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 11:43:27 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:06 +0530
Subject: [PATCH v6 7/7] arm64: dts: qcom: shikra-evk: Enable A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-shikra-gpu-v6-7-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=849;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=TpvtLBwihWHNEKd1VwQvgAfHhzoeB2GGOqDfiPe0Xho=;
 b=ZIve4DWCl87XBF7AfPHf5g2BJeKum6itVChbN+14NX0yb+c2lSO4GLV80PWdApQDHp0lHww6y
 MmdHRS+rBCEDgn1bSRRYLQshjQmUl8u8iyr/Z7ckKek/8UGqepWFhl2
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: o0Y5LpCz7D-vMp_dz6bxaXVICW_S6KoP
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a4febd0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX6M4U4lHlp1Kr
 bcfU9vgNChhgEUXfUs3IkmcT6ot2WJWEzgGU8vcWu++OZtrMWgS9E2u/qxOOqRI6wO7wj3A68OS
 vfOdtu3OXLVG4rMLatiSLrLZ55NFMAU=
X-Proofpoint-ORIG-GUID: o0Y5LpCz7D-vMp_dz6bxaXVICW_S6KoP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfXya/wcPZpGPUS
 UcJdhZdhDY1B2kWulfgN9o/EbnTD93uFT/z9D1MHzeXyAkXBeTuIvwq8c4QG04m5FR9L17eJ7yZ
 i8KfMDGjCbT2c5YYaZPDafezSmzOhyjqvtjdu5gyvjiLT2x5Wi8z79doZIfuN7ZvBAT/xecHGOa
 SlZK+wvt5PC7QVwa3b4NLwdfyOaD7nAXmebNDWfY5KvI1Y3ox2FaWwTFzZs0Jba++lwljtc8tVu
 /UgbRizmywuhj6KchYfWl6Brb0zjwPUqUxRF8NILdpiKKZpmaMdV7w+wNiC8lHiBHX0z0D2B2j5
 umXbU/5U8CeH3hSqiGhyZeOfBPgOnbyXiwYfi0ILph3AvZO0vpUVmAZu1q/IyPyKJhyC+gMVW5j
 e0peqeJ+h5i/MzVKyZKO0UDmC45OdRnSForhLQum1nOO18fvrwN+nnheYAzNUF+dqWgTjvvMa27
 yREcPm3YV6SF71gKIGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090185
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

