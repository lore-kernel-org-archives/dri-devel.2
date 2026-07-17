Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FE1C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9635410F5D8;
	Fri, 17 Jul 2026 20:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l+KULMYp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dKmpdMFS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5534A10E4F1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:53 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtWaL2906324
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p5EABLMYgrPqX+e6g9POPOLdFY8Rck09SBi7ZSFcSKQ=; b=l+KULMYpfhx31Xm2
 SEo+MCsYLBw0rqvsugbSuJE3U8AVVu9n7JQbKyTOwTopsx0Baxebl2TPoyQjTWgP
 ndTlv6auJpOfA9jfxYIpbn8Wh/D2dNzjTyRQMEUzi7uprVcvljwUkw8NvlFnZVaO
 2jb+MQggIjV7J/yERkZ1dw7e59EITu+O2P2P5uMNzvJ9rAFf+0UNL828GGRz+7VT
 Krbn6NkPe3Gs7OjPVJnBpB3duWq19K0vDf5Wh1HsE5+BoAUeKUbKomCmqeRdy+UO
 RHCBCGd6QD5xP94aykQe9weASI0/1dW4vQ+1+In5Hfv3UjgsZb9+k8USEkzfoFl7
 aBl42A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrsq8qmv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dad28e86eso12194056a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784320971; x=1784925771;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p5EABLMYgrPqX+e6g9POPOLdFY8Rck09SBi7ZSFcSKQ=;
 b=dKmpdMFSZOREoq+AcZB6Qpsw36iziCPU71SMyH6vNcYtfjcsIF+yMe2sksDO9tKs0L
 6he8JmpXUTaXXj0EUW2HyhFL249qM8AutezncukJ0qOhx88vKJ6/gdLOMEb7QrOHHckg
 +d4J4L0LPDx5kjK0MYrkFZjDRCyt6gl9GZFd5Rl5KOUCfVGRWan6PfmoehUzcj2nL4Ae
 pO+r3noZ1s8RSJO0l5AeV6QzwDdewb5SXiAkS85NubGNqrC4XfOihPPNwR1As3nyO+qc
 m1YT7RrLs38CXWVxxjWCCZauLHuZUqBjUGgIRKkAzr1VtMIzJzWCZoi1TBM9yIJNnZ2N
 BCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784320971; x=1784925771;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p5EABLMYgrPqX+e6g9POPOLdFY8Rck09SBi7ZSFcSKQ=;
 b=ECfEov2dRYtoWgFVK2i9nZoQngsMj8TQxHrUK8bANwt9/ibrMgFGN+E8sJWTlZOO78
 Ovjoh5CvWHQzQb2mQ4jKMrRI6GGLz7XuEVWgK9nK4UHdITejeGzKW45bAOpToBVB2T2X
 xNWDLC7rLb4chtH5svMMmJ8IiS+tfpvAf4evfda3TnTD9fawGMsGzhG9pqy10b/Vx+pO
 V9JfxrhrBm+Ps5gN44elf7gKbbD/dUii/iqqWrClxWQ54gtQ9UjHT/2tcqD1me1ZSX4s
 9R/T4y2zUrMzZaQ5dDPxDE7NZnJeD8ha4icNE02QA6fZoopPyZVk6a9q+FpBefqL0ZlP
 wxNw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpM3zfPqORxS6xO4zRgc0pc8CwK1AB3Up5Xbg8xPqF8Y4XLIrGjY47fVYBm7zFl/fHp1G1tZFalbQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7W0nANRuANimJaCbvJAj9BJNfqHRzxVEsCQ+BK46LiV50GNFI
 51OMTi4rEOsskQL7rDrCU1rui3W1UaCVuDySE5+mmGvfAuA7h6aVikA4yxLM/ZBrsNf0yqshjHi
 sZx+xvQt/Ua4JLSR9iV3szlGKvc1Mof367V5OEfSu0mdpWGQgbr/YloPm/YtivzKXV6grpdU=
X-Gm-Gg: AfdE7cnI4NJxVCeEIjqzHPx6hPN3zH8tPGdhYdMdbszj9PIesWHJ/sfNNqc1qsjxpYT
 1tsWSVYH0In3IKHwL0RYi16odbu6sVAS/fGwhOfuVHXjPsWVJ+qGkzM6D37t3HYSIeINhYOJTfO
 FgQtfA6+ViNBy+/24gR3bxqBNM5GXD+mjyLUQ3WaUSHb+rcgIuQH4edLCdSY117ojC6t5Gc0jdj
 9GvmHP8nnKTiwSgYDa7+lnf1y6Be9MJXdDQzW8DES/qFEg1LnCWzOuy7x5pb2605PlNkPWYOsBv
 ry9Xttioe22IOOGy7tgNWkF2GG3j6jRRssbg2I8LsWj0yD1lqFg2sXJ2Zb6ek4cvW4UphT/nI/q
 atWQCAZHxMhx+Jj0DN1xClmfU
X-Received: by 2002:a17:90b:4d09:b0:38e:2fa0:491b with SMTP id
 98e67ed59e1d1-38e4b594eb3mr4384607a91.31.1784320971032; 
 Fri, 17 Jul 2026 13:42:51 -0700 (PDT)
X-Received: by 2002:a17:90b:4d09:b0:38e:2fa0:491b with SMTP id
 98e67ed59e1d1-38e4b594eb3mr4384579a91.31.1784320970601; 
 Fri, 17 Jul 2026 13:42:50 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:42:49 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:32 +0530
Subject: [PATCH v2 7/9] arm64: dts: qcom: eliza: Add GPU nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-7-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=5441;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Tc760x2HSzCAh01NrUqagWazPo/xG5E3TZ5FY+sYPYo=;
 b=HA2PZqykYBrV4RxYXVrVfdMUsWyeU8C73KsGv99Xxxv8wFWMitPeXYsK/BRKzqOJIoyWF4R1r
 moUX080nk0OB48kkfTJC4ii2Cs8Joi8F03FvySccGIMkTAqODwsuEWv
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX/NuDTb2f6FSJ
 z1XA8w3Dvhd32L8tsHXPSvGgViJkckl9GuCS5d8O5ZDuV6tAaTwES9bGC2LivG6+TKH6ew2Swt/
 i6xfRFEKOJeyC5zALb+8hfc5uj+R8HU=
X-Proofpoint-ORIG-GUID: 0pgDLSL1UjcpBZBdAjWbeBKutCOF4iG1
X-Proofpoint-GUID: 0pgDLSL1UjcpBZBdAjWbeBKutCOF4iG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX3An/V+livdS4
 NR654AaQkU4PgppI2Cstou2SETBsjnmqbTtIBXQ28lbOzvGKrt8eAEvZovJfEtZTstA/3FMKc++
 QrKziMiqJlidWCmyNPG/eHPGyt3rXHZJUikyvApUjt0gjyZ01eNmH/CLK4wisBENfAlOwCBfzT3
 QaItRQiGKz3kHUvNxPRTXPUSgtfKjqwq3HyR/JNbiVZ0kyXwx1FQfmHBUaS/w8YRhlIn6lcNnkq
 aYhTf3GZNzVc0F1d+1i14YAi05WxsrhMawgengRGHCpSMw47KpI2LaEyQH/CeqJsmZ74UrPfzFz
 BlIQV7RImyZY/mnhuyoj1+y9F4Y5yq9n9xTgT0RGuy4t1vzTp22tYhd4vo3GKibcLUgB6MIISuk
 t4IKqclKaMsEGG1GQkpCIN5Z2aL5nB/JvkTy/M+4db+yTXpGTO24RjFimQmzPkXLklXU4mSGuxF
 1SYjJNLNoyFPRMoGWEw==
X-Authority-Analysis: v=2.4 cv=OJIXGyaB c=1 sm=1 tr=0 ts=6a5a93cc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=p8LQYYvwJZuHz2WWpfMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170212
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

