Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2A0CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 17:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 253FD10E557;
	Fri,  1 May 2026 17:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gPqHz4Sn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kovwaAeR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23EBE10E557
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 17:11:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641GLRKf2660929
 for <dri-devel@lists.freedesktop.org>; Fri, 1 May 2026 17:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GjE9JmsvXmVwcbQ2npM2AqZEwboOFJh15p+kF13wl7k=; b=gPqHz4Snz8LTqELg
 EcuXPFYqpGlZm+WxHnI5AL5MphffyUx1upWUxQl5P36ytafFWMmVbjrM5El5m6Cn
 tewgSape3TsQWyCcjIuK3czKN79mcJML9lyf48UMNmrmpoQH7ERqTsgh3yXq0Nhy
 /M8T67TOl3l+QQJnWGCf15GqlHC2Vf66tOLIqdaWWX5FcG5pggdi+2sYgTp+i769
 FVEgbxVnb0i0a3PXc/3ha7/ASrPLpqIcvugRYZKuTD1SPHVf2NYUXpizLnxixIRv
 bBNGxAIZQtzg6cWzkIlT8iUVCNdnHB77GyYB7LI+VzQ49GRHFaPWXk0db6hN0Skf
 6z8T9w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvhbtj9ub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 17:11:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f5f48458eso1169312b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777655482; x=1778260282;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GjE9JmsvXmVwcbQ2npM2AqZEwboOFJh15p+kF13wl7k=;
 b=kovwaAeRePG+4tQMCdkaqL3TWcsHoAnjxwRFZGgl7ps8CgZ4XvoHdhiAZ0tTIrVH+5
 87Y4M7aUyG3yxvBUlJPs0Dqt7HOb1nawAtmjrgJovbYbhooNwZUEhBHFtzcJSItirJAk
 mxha/uH98yJGDoXLbRYzbxlWTs+AAX/3eRMQ6foM3M/K750UDdRTjlqCmHUTbrYDhtz9
 gMVyeB8RyclVvmIbPV92WR/17Kk7nQ0arx8Qr5O9f3+Fyf3+GuTpvNqQHqgTNSjl2PIo
 CFX1xsVQltiCk/TpKZq5ZAEWA8z6VUXvr/OWYxXJkiuU0jDEyrwOXFA80b5QblnM4H4y
 9pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777655482; x=1778260282;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GjE9JmsvXmVwcbQ2npM2AqZEwboOFJh15p+kF13wl7k=;
 b=hEmc+KeYCEYAOheIXwEAFdvuiiPg8ej98yjYJUxkW2DdPeoQ1M9RPWhifyMLupwazq
 vQT+TgUcwhHbCIQcUQDulEZlc0JxgAdrPZSaUHi8SmpyzFLH/CpJGKf2koGWSx5W+ke0
 R6jftia5/meiXoQI8cJslgx1600Dv7j3rRV1tCFellaOmLIYYUM8RtxfpljkTMl98jPp
 3L1V+acd3nwohQmg4EUXV5yUEjwSggUVa9ndWjnHLuORPwAVctOLNiONAWl/w1g+phEa
 YJYZuZwM4OKfs2tdovNaRNaqeiQvHKCkyzr7EnyC88JM5hatIbXovlVK9t6Wo9gvsrNV
 ifxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jpGDFoSDYULvXDOGn5ZCqXSoZvmtjEn0NyWuME1JatKYmGn4o+l8C/bFlFK3L6NYp11O+Zzso7jQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRlDDPgrL6j5vZSTuRMR2BcLEw7eLQGvVkSUgr8D3w5r91uyNu
 RZLcpLN5v1c6Ut2ntmYuGifAJHSnU8e2KA5ybJXadF3fpBJDGnjwmxNubTADlUGVF3Z/j466uO7
 ZFWsSmYXa6Tpx40iVmQKROkGG8YEuk8HngGtHy38gC17eQxezV0evQEteep6baLv1WeLZN2Q=
X-Gm-Gg: AeBDiesFTcX4w2+LT7SU4z3OGJ+cerwaGM+KiSyaXkolKjB58SsGr/kzwS9wd4Nvdrf
 bDMzXZsQ7FKM0UYbMGI4B1vOfgN9PMAmVREhGrJMLIVoOrWqoYuNH/JqN4RavKnqWY/KBcD9+xW
 uzEnKTFnv/egrx5lth4QjvbeCroKzghJU2hnKGGYbQjb+bK/RCicoR5i+Ke0P//6EUe7oqsrpw4
 04vgHKr7SAFB7s9mzgwS6eSnoqPQJ4mBnY5/b5+EIKlaaAc3WNJc4ioEprGuMKXFTl9s09fuy02
 ZcjaIxJ68GFIk5NtO5kK2FtXNb0jeDYAUsSOiX18rGTycLozIfNfaHoBpeLu3pzvjcVF70Dsmss
 AYzYxFsyD2lWO/duV6/NFPXXTj17uo4z5APGrmkWeHRekLUvOxIUz5lXb
X-Received: by 2002:aa7:88c3:0:b0:82f:4d2e:5a9a with SMTP id
 d2e1a72fcca58-8352d2c33dfmr60248b3a.29.1777655481944; 
 Fri, 01 May 2026 10:11:21 -0700 (PDT)
X-Received: by 2002:aa7:88c3:0:b0:82f:4d2e:5a9a with SMTP id
 d2e1a72fcca58-8352d2c33dfmr60197b3a.29.1777655481391; 
 Fri, 01 May 2026 10:11:21 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8351587db67sm3099323b3a.13.2026.05.01.10.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 10:11:21 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 01 May 2026 22:40:40 +0530
Subject: [PATCH v2 4/4] arm64: dts: qcom: Add GPU support for Glymur
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-glymur-gpu-dt-v2-4-2f128b5596bb@oss.qualcomm.com>
References: <20260501-glymur-gpu-dt-v2-0-2f128b5596bb@oss.qualcomm.com>
In-Reply-To: <20260501-glymur-gpu-dt-v2-0-2f128b5596bb@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777655447; l=6253;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=rUowos7EZcvHNQeS9qtSNuRyTQ9Gr+zN4UYlojp27D8=;
 b=E8Miy7n5EizYJr/+9JA+yp8Ft8lR6mw6+PVpmC6c2Dd7A289XVAQBxnvpYHP9u8I/yo9+xsKA
 vl47tOpo+ZbD+buRKzuem4k7/2KA4LmYHcA2GYRIkGObo2ohEp7UjJ6
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=cP7QdFeN c=1 sm=1 tr=0 ts=69f4debb cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=J-CVWWnePqFy-78NKqoA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: WZPINTaJtQVWf-uIdYgpOg7aFYu20oC5
X-Proofpoint-GUID: WZPINTaJtQVWf-uIdYgpOg7aFYu20oC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE2OSBTYWx0ZWRfX/ToRcBpe7bkX
 6cG4Vg1KlBxtWYpkpeRfBW8tKLmCxXo0rRTiFcUsSk1d8L2YWjqcbRwhvI0kgRJe0HbE3ABo8kw
 Y8LBB3bs5AuEJlF99Stk9kGQ0yRbjdOf1oC/GLfYzIJrSSp/xJeJfIA/nk04ghWyXb5zBwyzWtM
 ImEFnbR/bjRDVTSU5LQPGE568dlowXT1FwooX515Czjbfo159G4YoKKFitX9xp0bH8wgRvxaYpr
 F5VGYeAE0B0xqqAueGfoHdyrQKQ1ckjggX/WWutgB/oBaTwuLzOiYYc9N7qZAkizoaZuhZDVIyV
 qSY6R78eO7UWXIeym3HZE8LSr+mR4RuzqDbU8Gt2fkgPYbyvXmhxC5vQNmNpHBg+Go9b6MAdzxw
 aioLwhgR88zy5vsuzeLXt5hSu5bpw1oziT/zO1J2WRz8qPQMnF+rRN0+OsJMLRJIv3HkDhpHGRe
 gVVKhwZqSXcsC6w0k5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010169
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

The Adreno X2 series GPU present in Glymur SoC belongs to the A8x
family. It is a new HW IP with architectural improvements as well
as different set of hw configs like GMEM, num SPs, Caches sizes etc.

Add the GPU and GMU nodes to describe this hardware.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 183 +++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 93afc81698cb64232ac6b61754fc6f4c923e30c8..e36910ed348c8054dcab546c0b3936d781b11e14 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -3701,6 +3701,129 @@ hsc_noc: interconnect@2000000 {
 			#interconnect-cells = <2>;
 		};
 
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-44070001", "qcom,adreno";
+			reg = <0x0 0x03d00000 0x0 0x6c000>,
+			      <0x0 0x03d9e000 0x0 0x2000>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem";
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0 0x0>,
+				 <&adreno_smmu 1 0x0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			qcom,gmu = <&gmu>;
+			#cooling-cells = <2>;
+
+			interconnects = <&hsc_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2-adreno",
+					     "operating-points-v2";
+
+				opp-310000000 {
+					opp-hz = /bits/ 64 <310000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <2136719>;
+					opp-supported-hw = <0xf>;
+					/* ACD is disabled */
+				};
+
+				opp-410000000 {
+					opp-hz = /bits/ 64 <410000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <6074219>;
+					opp-supported-hw = <0xf>;
+					/* ACD is disabled */
+				};
+
+				opp-572000000 {
+					opp-hz = /bits/ 64 <572000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <12449219>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0xe02d5ffd>;
+				};
+
+				opp-760000000 {
+					opp-hz = /bits/ 64 <760000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <12449219>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0xc0285ffd>;
+				};
+
+				opp-820000000 {
+					opp-hz = /bits/ 64 <820000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-peak-kBps = <16500000>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0xa82e5ffd>;
+				};
+
+				opp-915000000 {
+					opp-hz = /bits/ 64 <915000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <16500000>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0x882d5ffd>;
+				};
+
+				opp-1070000000 {
+					opp-hz = /bits/ 64 <1070000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <16500000>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0x882b5ffd>;
+				};
+
+				opp-1185000000 {
+					opp-hz = /bits/ 64 <1185000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					opp-peak-kBps = <16500000>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0x882a5ffd>;
+				};
+
+				opp-1350000000 {
+					opp-hz = /bits/ 64 <1350000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <18597657>;
+					opp-supported-hw = <0xf>;
+					qcom,opp-acd-level = <0x882a5ffd>;
+				};
+
+				opp-1550000000 {
+					opp-hz = /bits/ 64 <1550000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L3>;
+					opp-peak-kBps = <18597657>;
+					opp-supported-hw = <0x7>;
+					qcom,opp-acd-level = <0xa8295ffd>;
+				};
+
+				opp-1700000000 {
+					opp-hz = /bits/ 64 <1700000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L4>;
+					opp-peak-kBps = <18597657>;
+					opp-supported-hw = <0x7>;
+					qcom,opp-acd-level = <0x88295ffd>;
+				};
+
+				opp-1850000000 {
+					opp-hz = /bits/ 64 <1850000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L5>;
+					opp-peak-kBps = <18597657>;
+					opp-supported-hw = <0x3>;
+					qcom,opp-acd-level = <0x88285ffd>;
+				};
+			};
+		};
+
 		gxclkctl: clock-controller@3d64000 {
 			compatible = "qcom,glymur-gxclkctl";
 			reg = <0x0 0x03d64000 0x0 0x6000>;
@@ -3712,6 +3835,66 @@ gxclkctl: clock-controller@3d64000 {
 			#power-domain-cells = <1>;
 		};
 
+		gmu: gmu@3d6c000 {
+			compatible = "qcom,adreno-gmu-x285.1", "qcom,adreno-gmu";
+
+			reg = <0x0 0x03d6c000 0x0 0x32000>;
+			reg-names = "gmu";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi",
+					  "gmu";
+
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_GPU_GEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
+				 <&gpucc GPU_CC_RSCC_HUB_AON_CLK>;
+			clock-names = "ahb",
+				      "gmu",
+				      "cxo",
+				      "memnoc",
+				      "hub",
+				      "rscc";
+
+			power-domains = <&gpucc GPU_CC_CX_GDSC>,
+					<&gxclkctl GX_CLKCTL_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+
+			iommus = <&adreno_smmu 5 0x0>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-575000000 {
+					opp-hz = /bits/ 64 <575000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+
+				opp-700000000 {
+					opp-hz = /bits/ 64 <700000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				opp-725000000 {
+					opp-hz = /bits/ 64 <725000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+				};
+
+				opp-750000000 {
+					opp-hz = /bits/ 64 <750000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,glymur-gpucc";
 			reg = <0x0 0x03d90000 0x0 0x9800>;

-- 
2.51.0

