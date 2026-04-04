Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F02E63FFB
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 21:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5889510E0CF;
	Sat,  4 Apr 2026 21:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aBXpU1OF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DFqjFbHq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 231AF10E0CF
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 21:04:06 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6349MpWV3291003
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 21:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xZYOVY8Bj2xAAp+/yXmI9Yv3a3R9C9Cg1LE3mTzMmTk=; b=aBXpU1OF/QzBWq8/
 8rgwgjGhA890/YP7rWUin/bLtWa0O26RFJ6BHkHS6RO30sJ8ttbxrmwhq4TOQ334
 y8GuRhpGK8jl8NwO1GZ865yHFjfddjLixlPpjzC1elHUAwxCFSNDPMytwLbKiKxz
 UUxHSqKDnJh0LhLpEoB/2BTaj0UMojXPJolMhRfmt9+HKy020bxxso0NMbuVdWyR
 YX+PJeW/dkSQOsxyQAz792ZNcBxgxOTFspgQuC5PI8Z/TEJKDVK97riUE7lUzAbo
 ZC+ihhraC5l/GFXP13SfBJoCM4EmnsydeEoW4P/GwM7eu/hW7uhKkDN8I8oZQPop
 embdGw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daskrhm3f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 21:04:05 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35da99b90f6so3189239a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 14:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775336645; x=1775941445;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xZYOVY8Bj2xAAp+/yXmI9Yv3a3R9C9Cg1LE3mTzMmTk=;
 b=DFqjFbHqdySZssMGAowoZTWK4SYnJca4+luhCE9PIf1Z0xkyDl6m0YtJsVm1eHCqf8
 pOajPMNHOO3jpZX+CcWe3+uut5OPSfgVfy9TFelLQNaWMZGJemLWG4RgNuHKckKqmZ1B
 ucNWu+6i1vkAgH0Fs18xacLISeT2Lk5HGgNvZ55uVNEp0YpPd59HUpZFq94qULm2zfPH
 tr9W/HaYn6wFD608NNNo4NVmpw1sGk0VjLA8xSmj6vGci60dk7y2AI8hivXItcfCrV3N
 GiArkLOwcD1ENHW6XZOVEqqiGYz9BuYWAeZJ7NcMspgCToBn90S4yWV7vP3YAU+2DjUp
 m7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775336645; x=1775941445;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xZYOVY8Bj2xAAp+/yXmI9Yv3a3R9C9Cg1LE3mTzMmTk=;
 b=OUAv5bmqUrzdT4AvMiA0UPOP8t/qJsamh6XaMtnuSeDkvHZau6fGklkGgv3BJVWs/g
 brcHjBrV3JtGLLwgH4pYqBk0R0mouPSXPUGcsGic/TIGoKxoDzA2wGL+TVxlkaszOBJ8
 bt64ylP/Jb9on9JflHjtHgC9hH3kMSoFEZsHIYTd4/RuVb/B/XPiod9/cObbKAO8+sw9
 m82GVi4vdDFVgNDh39EQUL50LEwL+Sbf/2p+cxjkL9uq5O1eqFr4TXKlWWI/tfF/RBRW
 ai4npXJELU8W2phKpiMf0HnIs9ELgurHT7yEuVsmPd0tEbrpRq1rVA8+kevFFcJYk2XV
 12GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu4H9hNOi/F3zTlv8Ly6YZX9W1n0yBqzhTaePdKuimXWXWixzScfUrFDr1JxKAe1rn3B6DTd2UukM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy18HpndDJaA8j9A598TjtJq7TgPXYuj+6G9jqEiEK4K9Zr93VC
 46BUQveK/Gnt/xc2WA+magcZMpAvYerT4XdJh4HuC1Lvlk8tNqAjR/lI5ygWMFJJiYrPXQ65qnu
 4L1XsfZwDl7pneRlcg6iNc+sFoQeD7P8nE5oYOduBoRv3hkm1t3D/CLiT93zbyWaWw8zeVBY=
X-Gm-Gg: AeBDieuN5ktwIgizc2UfLKU4pTMnsXHI3+fUG7B15SiAVV+pubQMwgb81QNNXEWKVY/
 KZTwwG7Jzkgb+h3NLrCd+1sHKAI6NpwAIEQg8JcKBKgs08fHCEqj5ogNBQZv0T5E/pF20FCdlat
 ZldrzBsjd4tJ+lld9eXAD8jGILE2O6/SZQdLDpRSKtvL/JYVLFP8IwrLgUeSpGM6W9Jvxd/q+ug
 d1Yyfu7ikxdCyACw+sy5/K+yhSZVM5MYk/5fk47uoshJjv4hKr0u5Y7PhhNhky1SJhW3DtxJ4vR
 NB8KQhUwB50wcMDXgDp72S8USEb8bbqiTugoNR7/QhIP2HRmi0nGK+OLcqULI3z+GTG5ZQyjmrz
 +M9M8KHGqj6CYEHjy14ftRtR8xL3/xz+uUJFo1z+DmEiBRA==
X-Received: by 2002:a17:90b:1dc6:b0:35d:a843:6b1f with SMTP id
 98e67ed59e1d1-35de6899ce5mr7001519a91.11.1775336644811; 
 Sat, 04 Apr 2026 14:04:04 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc6:b0:35d:a843:6b1f with SMTP id
 98e67ed59e1d1-35de6899ce5mr7001496a91.11.1775336644271; 
 Sat, 04 Apr 2026 14:04:04 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de677e2dbsm2675545a91.4.2026.04.04.14.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 14:04:03 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Apr 2026 02:33:16 +0530
Subject: [PATCH RFC 3/4] arm64: dts: qcom: Add GPU support for Glymur
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-glymur-gpu-dt-v1-3-2135eb11c562@oss.qualcomm.com>
References: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
In-Reply-To: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775336618; l=6149;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=RBr1XjsDT5Kr6QGcEhhynZK4g4iPCpIcVew7cJKrqCg=;
 b=vwd51qZFvIb7MednXSSvkr+UUDduQutfBfAo/sQ7TfeZ34CdFZg1cWFzKWn4D1+CkPATty4PY
 Pi68RNF6rnpDkq/GLcPC/lUcNAnGS4RWDQvZ6pW+btZ0u55wZsMof55
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=Xpv3+FF9 c=1 sm=1 tr=0 ts=69d17cc5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=hGZpaGHu81SVUIw3OUwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: G879XBvXAx4K6YcXfAd5VqqITX0DH_Yk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIwMCBTYWx0ZWRfXw0rG7E4PtBg1
 eK0UkvyvLHCT6Dc89PhkrruknexbWJjXtTZ5ZnIxfA4S+I+Z01rEdgefPDAaao2Ge1sl7CEBu43
 qt80IwPJmeGRydNJLnwInCrs5BBlU2+UmzWaHud+SPz9oHbCd6zcGy3H2SK98LLh7UKD6qJ21li
 oA2Q+qDtnaOdQjtIe+diFUlwX1tx2xLO4YU8Kb0kC9cF1VSMwul2KyX5CoJZRbh50f8wi2PuUgN
 gTdOtli9waU1fzD/dz2VyC7rEIGNJGW/Tkk4v+Tu4HkbZQWcLrqJdw2zx/e883a/51d13rIqbAe
 07O1w3l1qhh8DC1yOEKu0aNKpqACQVBXtfKRcmkgc3TJnhp5QDjn6ennenSAMu5fD27hbn9GnEB
 yULS9UAdz+epktkxJ2+Zo0gcA5/+NYhhLBgWhFa9dfDuG2hrsu0yMsPl8smY5VemsmpLn//0Ofa
 tN0gcNlKnzlzkDr0hOg==
X-Proofpoint-GUID: G879XBvXAx4K6YcXfAd5VqqITX0DH_Yk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040200
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

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 194 +++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index a3fe2b12aee0..0174917fe942 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -3712,6 +3712,200 @@ gxclkctl: clock-controller@3d64000 {
 			#power-domain-cells = <1>;
 		};
 
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-44070001", "qcom,adreno";
+			reg = <0x0 0x03d00000 0x0 0x40000>,
+			      <0x0 0x03d9e000 0x0 0x2000>,
+			      <0x0 0x03d61000 0x0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem",
+				    "cx_dbgc";
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
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				status = "disabled";
+				memory-region = <&gpu_microcode_mem>;
+			};
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
+		gmu: gmu@3d6a000 {
+			compatible = "qcom,adreno-gmu-x285.1", "qcom,adreno-gmu";
+
+			reg = <0x0 0x03d37000 0x0 0x68000>;
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
+			status = "disabled";
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

