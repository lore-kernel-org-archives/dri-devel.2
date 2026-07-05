Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5932EC43602
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF08810E165;
	Sun,  5 Jul 2026 08:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IqjMzpkl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GT+XyLXU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC3F910E165
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:15:36 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6655t3vN756130
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4k9UzutMXiZdlWIeEIUwNCwlg80QNOnzM/93OOz7hjw=; b=IqjMzpklbdTVi2Sl
 eJU+QuXMihuCVjTL8+eQIS+B8Sng6SlLTXsHqA/PgfjaZwyo5X6kv9TGVKxPgD5e
 p5bra/LAAZAiQ8zip11R16R2Gdfjln6QhSJEEcdas5k1lPq0OKHOIW1UlXAiPeb9
 U9RnZC+tk0FMue+ypLLWgDKEAZv77mXZu4S1m6PImdnd5E4oQKGCniCNulUEX65p
 /gfgAZuSnuZIgmKTCBYRBwDvdci9K6wCIb1nUDUB9F91CCXT91DvgfGiZNNqd+uE
 WTUhOgcvs9c4CFEtkn2OKChWA0f9f4eZzzPdzENs5kt+4aoB7P86/UzN7pRWazSo
 35rQ7w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf826j7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:15:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c6bbd0afffso41288535ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783239336; x=1783844136;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4k9UzutMXiZdlWIeEIUwNCwlg80QNOnzM/93OOz7hjw=;
 b=GT+XyLXU+zq4pZXRLLtcgccMVq7gLRy7T48nETZoEniYo4gp4MW2JTeWalFw4Zyx4k
 yW6f1Bgr6jvbtZvixtnbMd8tZzog9thjFg07weIDWzMCr5DB0pXG2VHE0N+aln0gXSmj
 Yhgx/lh1CIkjJ41kUwy18s64WbTWfqoWRM1vuXSuUeoJFGbzv5P+ENW/dPJwujptuuYd
 TPoVLPyQoJ9U8E0a+zuCBCoqEHX+gZimI7gUzo7XVrJf6JgSuNhIx/oAnFKQEMgiV/hC
 8OrSgAvAwFbS6tGWuzxRFLC/D3u+CGEhO4s7NpGlh0TUK7MixnXkk1K7+m5hrkZPd9Qq
 HKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783239336; x=1783844136;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4k9UzutMXiZdlWIeEIUwNCwlg80QNOnzM/93OOz7hjw=;
 b=ePt93XMymqrNtGU80Idp6xdZuoIA1+EBpkwrJrgysecJJ5hkaLXqFONISekmUrKnO/
 a93UMViIcM8/dI8w1OXXB4KG8CGptqRGyA3xZGqniEeQeRgeJvXgGqf3araj/gKewTle
 Ku0jwxAQYhfMpwMUpJiQKDOXhEvEZ+P7MpFSYOvgltlUZ2y5SZKb+kGVcT/P89FCH1NZ
 mPZFIjSM5gJrUxFXNIShaIFMS37kIMeLrAU5iTvULnGWdKdHuRWXy6a3BWX2uotdOQG9
 hwFlwV5rz/jlUHsvfLIsn2EOgSO4C3zb8/jXC0Oz3QHj3qxDn6zJWLXtsTtMUi2n/P9c
 GxdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQZLKBcEtSCL1+7E7phCwKpzdslH1Y7Y3/8FsL5bZm4MDuamlI3UTfrHEmTnOq8/1vTGz39pHG6t8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIlQ9OhwsG9uTSpLEx8dPkNgkJSk/AvFHfxXOo9rXBOHLV9UjN
 X4ipaOtqVnzbxB7tv1x82BQXIWiKsJujxTSHVx51E6NAmsaIdO2KrQQkGAK7y+i2cLvqWizWAx1
 1yPexGxY2C1XjiuqPkQAOaRSGPC7rfyUdL0iduydC0idVnqy7En8NoZp7Db8HvBW0PFDTBso=
X-Gm-Gg: AfdE7ckuzYCMpdd3F18fQ6rpaqhi7vGfCdheFFH+lQ9xDOD3rJOes2TD+xUkPvwSSCJ
 NMxXIDiKE45sLV/7bAw1mOI9UGy8XXGTG/OQqFy+fKwh2BJNb4VSFvNV9rmL9vdMqYPbK/1ESqJ
 dwqhde3vKvb0t3PNi6Cq4a6j+dpGkcoinCy5koCA06NgT7IO2js9xoj8cRibqxPNk9IUyKAtVdP
 H3HSLMi3eBnY0/LeQD7qMMamajKaOW3NXswapgAaDiv9PLh33VJ5QnDlApEAvkAP/+WFews6jkZ
 /ymfK/QiZZm98bzHbrY9amT245LptyC5zDw9RqRT+62zHQNyiLmk0igrOCNT72F7zEhNT536KUp
 J/NSsTAQPpdL7OovmRBvvveSXo/nmyj8muRs=
X-Received: by 2002:a17:903:3c70:b0:2ca:c01e:8836 with SMTP id
 d9443c01a7336-2cbb201b5c1mr54322695ad.13.1783239335218; 
 Sun, 05 Jul 2026 01:15:35 -0700 (PDT)
X-Received: by 2002:a17:903:3c70:b0:2ca:c01e:8836 with SMTP id
 d9443c01a7336-2cbb201b5c1mr54322345ad.13.1783239334746; 
 Sun, 05 Jul 2026 01:15:34 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:15:34 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:22 +0530
Subject: [PATCH 7/8] arm64: dts: qcom: eliza: Add GPU nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-7-c9f1354dbd29@oss.qualcomm.com>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=5380;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=hj4XTXJRwVTJobJx71cynzfN1k4QxqJRtGjaWZFWW2E=;
 b=35fe4KBw3FTsKp/hdtdHgczUQWi7qZh48PQEJWcKngdSxoOThZmRYCaTgT42VxCbWOhn0KKp0
 UEUQorWapK4BW8DnOpoaHEFoo0f1BSJ+my4rJ9t3PMLzdO39S3p3+89
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: vSsYIk82CtEFFOdpD-MeQlFRFhobtp7e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX/sxWDLrtupLO
 MSdXc3XPSm2aHuwKjyAxdJ4yARoTfneUJsAinE9QOdpcIxW8LUVkZPXLHXt4j2ribQDjDQUA4mw
 pl1N0WuOIcrtYAeFtTf1iuiwB8AqdRY=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4a12a8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=p8LQYYvwJZuHz2WWpfMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: vSsYIk82CtEFFOdpD-MeQlFRFhobtp7e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfXyE9li0au6EA8
 uXN4zXLb1HmGeMZLV04S9t5evUzORaFw3bM1rJKUxB/ETJ0CrZaN/E0ty3nZM1WMY0ab6E35suc
 lT7W3wuEX3TOrzOpL3a+NqAbigBMaBrN11eBc0ywKYl6AD9XMp37C9dESe6JsgPzztJjJVks5tD
 /auiBW5ZLfwPtyweOt3vVAJ82KCoCqrjULdi5S9r44DXNz/Gww6sdJq7iiOMyWYcAddAqgqhzuh
 qrFi74sLC9yHOGX6gEx80dl4HEEWB5Qxl0/DejUo6WOEl1M2sNV3YY13xnVBFvQzL23QppptOen
 rh7rQRh2qj4gCwwsRoFT8f0YO/Kgg0HRmek14TG54rTy4YY8q6rnSgp8sinlVMjHo0z5caeqZRm
 zBbe3NqSx/LQY47q9tZnFz48ZREeDIn/CL/1LB7R8s050dSCvn5ErFiqnFIRgtyr0h+ekXd4/AX
 JL0ZuTk1y3kEO3W8j7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050082
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

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Adreno 722 found in Eliza chipset belongs to the A7x GEN1 family. It is
derived from A730 and shares the same IP-level configurations: HWCG
registers, protected registers, GBIF CX registers and gmu_cgc_mode.
Major differences include lower cache/core counts, 1MB GMEM, no
Concurrent Binning & LPAC support. Some of the peripheral blocks like
RSCC are from A740 that resulted in updates to RSC layout.

Add the necessary devicetree nodes to describe this GPU.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza.dtsi | 152 ++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index e5b8377e6c3a..c24c5e9695d5 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -3742,6 +3742,158 @@ nsp_noc: interconnect@320c0000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 			#interconnect-cells = <2>;
 		};
+
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-43020100", "qcom,adreno";
+			reg = <0x0 0x03d00000 0x0 0x40000>,
+			      <0x0 0x03d9e000 0x0 0x1000>,
+			      <0x0 0x03d61000 0x0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem",
+				    "cx_dbgc";
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0x0 0x0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+			qcom,gmu = <&gmu>;
+			#cooling-cells = <2>;
+			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_micro_code_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2-adreno",
+					     "operating-points-v2";
+
+				opp-259000000 {
+					opp-hz = /bits/ 64 <259000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <781250>;
+					qcom,opp-acd-level = <0xc82f5ffd>;
+				};
+
+				opp-345000000 {
+					opp-hz = /bits/ 64 <345000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <2136718>;
+					qcom,opp-acd-level = <0xc82f5ffd>;
+				};
+
+				opp-515000000 {
+					opp-hz = /bits/ 64 <515000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <5285156>;
+					qcom,opp-acd-level = <0xc02d5ffd>;
+				};
+
+				opp-645000000 {
+					opp-hz = /bits/ 64 <645000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <6074218>;
+					qcom,opp-acd-level = <0x882f5ffd>;
+				};
+
+				opp-724000000 {
+					opp-hz = /bits/ 64 <724000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-peak-kBps = <6671875>;
+					qcom,opp-acd-level = <0xa82d5ffd>;
+				};
+
+				opp-796000000 {
+					opp-hz = /bits/ 64 <796000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <10687500>;
+					qcom,opp-acd-level = <0x882d5ffd>;
+				};
+
+				opp-900000000 {
+					opp-hz = /bits/ 64 <900000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <10687500>;
+					qcom,opp-acd-level = <0x882d5ffd>;
+				};
+
+				opp-975000000 {
+					opp-hz = /bits/ 64 <975000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					opp-peak-kBps = <12449218>;
+					qcom,opp-acd-level = <0x882c5ffd>;
+				};
+
+				opp-1075000000 {
+					opp-hz = /bits/ 64 <1075000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0xa82a5ffd>;
+				};
+
+				opp-1150000000 {
+					opp-hz = /bits/ 64 <1150000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L2>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0xa8295ffd>;
+				};
+			};
+		};
+
+		gmu: gmu@3d6a000 {
+			compatible = "qcom,adreno-gmu-722.0", "qcom,adreno-gmu";
+			reg = <0x0 0x03d6a000 0x0 0x35000>,
+			      <0x0 0x03d50000 0x0 0x10000>,
+			      <0x0 0x0b290000 0x0 0x10000>;
+			reg-names = "gmu", "rscc", "gmu_pdc";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_GEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
+				 <&gpucc GPU_CC_DEMET_CLK>;
+			clock-names = "ahb",
+				      "gmu",
+				      "cxo",
+				      "axi",
+				      "memnoc",
+				      "hub",
+				      "demet";
+
+			power-domains = <&gpucc GPU_CC_CX_GDSC>,
+					<&gpucc GPU_CC_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+
+			iommus = <&adreno_smmu 0x5 0x0>;
+			qcom,qmp = <&aoss_qmp>;
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-220000000 {
+					opp-hz = /bits/ 64 <220000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+
+				opp-550000000 {
+					opp-hz = /bits/ 64 <550000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+			};
+		};
 	};
 
 	thermal-zones {

-- 
2.54.0

