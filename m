Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B19BCA6017
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB2410FD06;
	Thu,  8 Oct 2026 21:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WEw9wtfV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gxoGz7Ls";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF9510FD6D
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 21:07:30 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0N6s3387063
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 21:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yKtOOvFc5D27LCXFHoXF9QLWg5IasKf5P3xB+DwmaeQ=; b=WEw9wtfVjtcWxcyY
 4VQo18+yoysdzuba7UA/qyi62cBJFbW4e8fSOPZEi/xpuazH6KX4iB5mtUiY5ZSi
 A/wmcBU/exDz6z1FY9ujCUD2cWXtTpfStyCZbOq3GSIx6XJ5lLVBIqsoEm6LxGdb
 tcvolzSUi5qkW+QoDyEyuRpJoJGoT+FAVehR+ffrgL4vHEDzDV4ncxW7+kJqUzs9
 zHHtlsUqRADpOPWCoVWduf1UsIyh12RZx/zq7qwm/lwehCMXU179XKSUY9Qa2xNE
 Nra4w2om78oojEJCzmb7EgUN6W82SIzp7SPH4jRTFVZulDCDikklXCaepUyKBSCX
 9dIjAA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrrp23-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 21:07:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-351788121cfso4952931eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493650; x=1792098450;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yKtOOvFc5D27LCXFHoXF9QLWg5IasKf5P3xB+DwmaeQ=;
 b=gxoGz7Lsm8msDsi6AT4edOVs5WrT+zyi85ksCVrT1QwzET1gsVOlIJQ5wAzdhNsPL0
 r903+an9pNkG8jNO2150kHVRyNUVWS/7xr1htfRo8T4gIcxMYbDrykt4qM/vJqbNdeJz
 4AtCFfvhxfiVia4qbdt4Z1x7XP2yRxCvUwj7X8Au8GUFZQXItuTjSZpJWP5auh8cey32
 3XXOpu17UdzY6Lu2c2LfXmZEGm0fqHAOqatu46ZOGlHKwpFsDzEW65q/1jLWnBBKO2zf
 QAe5JQgkCyyfQ+qf3pWCyEYMFNAUysLIERqM1F2udGoXAZtkrUj2MvAzIC1bRDkTZme4
 NLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493650; x=1792098450;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yKtOOvFc5D27LCXFHoXF9QLWg5IasKf5P3xB+DwmaeQ=;
 b=qn4w8U3K+3LnpWz/eTXUWtvfgONTjmxGRaH5l1l+7CB5jdaQE8IvgKXqwzk0JN60kK
 0AzbpTXXZzPR3J62gfnOu4T0yglv3be/ZStTb4azmo9bU7a1Et6JyvYy0oE1tvEOBey4
 Bih1CYuvXjt//bumoOyDKYX8Oiz5U3v48GZEMvYAVw2rq7vk89EWPP2lNOSOVP6EhhZv
 Xp3INbj8luPtec2m2piJG6F1hh0aLr46/FL9t2WiTWxFX17IDAGWT46xd4jPvtE3kxdU
 79xeOJLmK6U8l6MNdlZ84OEE1ASwvydjzDrvZh6mLLh4CyAfKipx7/V2ZnfxYDCHAfpb
 KRlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4ePGn/+dNLXj6ooSWx3jBLoL+bPwR42p6q0t9c+UHg4G0/u83ZxE/hKsKhMJCYXXCYN9Uf9DZGjI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ47M5r1uOoYEInRsKKLBRJt3CFYfkAHFSl8bPQUfBS3RRn1gXp
 gRk8wL42kqMdoGCbSKe2k+gNUZxL1X/lpchp4f+MW2Gd9NRwCITkiH5XjWUzorxLpve+KRSmu8D
 sQ0x8sPJ6gzWbfNUKtW78bBCKNkWaxEvdTZyC8P9PhXTjBBfAYfBEyEMdi/tbEd2ZUB8ro/I=
X-Gm-Gg: AYBFou17pjSgjvRA6jINg22boi2jsihLqiLLG6z43eDg/cDKD+qBlqgB96k/bL8IK/H
 lKVAx/3kgCgpK0KyL0Y6fk1gfsvAX8HL9Q7wEPE4Ag8vnf9ArxnVhjNhBBssTHtobrkQhYJr3lK
 3zz2IWUNLkdmKaFQvgEehFtIxVSbayEGjq/soQUv6wa7FZKcF8wIHgzFTVlUdHMOtqwZFghq0wu
 CwOy8d1krmMMQXo4q0OuZtSjqPpKjp44c5pUn8q9NYqnlkc9qlnFcKOJhqIJoobLbhs/ujEdwjt
 0pdLdbM4qXk/yUeAVCh7ZGCjp9qkTKZL1W6Tx/kQ3wtitQhDusMN4LIVY8JPKtvJgAr/hYs3i9U
 YQVTHsWk28XydLa4Si8H8QKY=
X-Received: by 2002:a05:693c:895a:10b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-3537e0270fbmr104194eec.26.1791493649287; 
 Thu, 08 Oct 2026 14:07:29 -0700 (PDT)
X-Received: by 2002:a05:693c:895a:10b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-3537e0270fbmr104146eec.26.1791493648753; 
 Thu, 08 Oct 2026 14:07:28 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm634773eec.17.2026.10.08.14.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:07:28 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 02:36:37 +0530
Subject: [PATCH 3/5] arm64: dts: qcom: nord: Add Adreno 753 GPU and GMU nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-nord-gpu1-v1-3-a06a6c57bde7@oss.qualcomm.com>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
In-Reply-To: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Shivam Rawat <shivrawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791493618; l=4289;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=6h4f7qVB4BKj8LihzL9H5wv7/el2Fm3tcb/8YO2NRo0=;
 b=g6Wbz6L+lGaMZuM2qLDwfWf242JVw9KWYgrDBLIggTh+WUYgs9DycTv52UscuMiOTt2a90FYP
 4LEXEoArMpcCUOT6gk5uKG+7/ST2BxO4c0g3mq2are7+oqCK7P/a5tb
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac80612 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iMbq6FfIWUb5wk3_mucA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: lY9kRr8kWydmnVAj8jB3hpgQrK5c_adD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfXxf6OEV/DAXJy
 MJAJhMuvS7JcvX0KH31+KQBbiq72o1NOpbj5CnRlvqlN/N0hjYmzrnStMBS1y1tU2AASLtcNq3B
 3mk72o6hZ7xvjqpSNijN03mn9ySa44MrnS7Wq8B0RKVCumIVK6nB0b4MDcuFVC0F+Lrd2S0c2S6
 uk3oB4vmSFqQy/sQpFHWYneH8iGyYEJSReLeRqB6Sb9jrTnHLi50xZEL3TkX1kIA3fYZvmmBeNO
 KreJyUrCEBdIWAN/x/GAVoGnv3yiFkW/WgC1ZvLY/5JCO+pHHohSrfRdSzp4Jnn61oMh6F8LHWb
 R3zpiOcsI8bmMFGhoy49N0LqtBVuH7MhmoA7N+CehuJmWmx/8nKy0vyYOo7/RKgwZcLxJlX+j3J
 LFhSIcCC29Y4JsznKfbfp6ndCXeEqLplIw31DzF2Hytix/7JABkpZXWWGNM55Ew/KPsJ5djWnef
 jeq89E2X/PJcCwXihTw==
X-Proofpoint-ORIG-GUID: lY9kRr8kWydmnVAj8jB3hpgQrK5c_adD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfXywbSu9dp2QxS
 Smo3tI63XZqINdTguyXZqn+I87TkvuZP4NsFTPU+afAKxKZUwe/bhZ2oibUh6A2D4jYzlmHKBQ0
 zPqrhGqzZ3T3Het7t16B0QykXujcA7Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

From: Shivam Rawat <shivrawa@qti.qualcomm.com>

Nord SoC integrates an Adreno 753 GPU as its primary GPU, belonging to
the A7xx Gen3 family, along with its Graphics Management Unit (GMU).

Add the GPU and GMU nodes together with their OPP tables. The GPU sits
behind adreno_smmu_0 and uses the gen71300 zap shader, while the GMU is
clocked and powered from GPUCC.

Unlike previous Adreno SoCs, where the GMU AXI clock comes from the
single global clock controller, Nord splits its GCC into four blocks
(GCC, SE_GCC, NE_GCC and NW_GCC). The GPU's AXI clock,
NW_GCC_HSCNOC_GPU_AXI_CLK, is provided by NW_GCC, so the GMU node
references nwgcc directly.

Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/nord-embedded.dtsi | 116 ++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
index 1ab7d9bc3cfe..4379092b7bf8 100644
--- a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
+++ b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
@@ -776,6 +776,122 @@ hscnoc: interconnect@2000000 {
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
+	gpu_0: gpu@3d00000 {
+		compatible = "qcom,adreno-43051701", "qcom,adreno";
+		reg = <0x0 0x03d00000 0x0 0x40000>,
+		      <0x0 0x03d9e000 0x0 0x2000>,
+		      <0x0 0x03d61000 0x0 0x800>;
+		reg-names = "kgsl_3d0_reg_memory",
+			    "cx_mem",
+			    "cx_dbgc";
+
+		interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+		iommus = <&adreno_smmu_0 0 0x0>,
+			 <&adreno_smmu_0 1 0x0>;
+
+		operating-points-v2 = <&gpu_opp_table_0>;
+
+		qcom,gmu = <&gmu_0>;
+		#cooling-cells = <2>;
+
+		interconnects = <&hscnoc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+				 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+		interconnect-names = "gfx-mem";
+
+		status = "disabled";
+
+		gpu_0_zap_shader: zap-shader {
+			memory-region = <&gpu_microcode_mem>;
+		};
+
+		gpu_opp_table_0: opp-table {
+			compatible = "operating-points-v2-adreno",
+				     "operating-points-v2";
+
+			opp-468000000 {
+				opp-hz = /bits/ 64 <468000000>;
+				opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				opp-peak-kBps = <781250>;
+			};
+
+			opp-625000000 {
+				opp-hz = /bits/ 64 <625000000>;
+				opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+				opp-peak-kBps = <6075000>;
+			};
+
+			opp-735000000 {
+				opp-hz = /bits/ 64 <735000000>;
+				opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+				opp-peak-kBps = <8175000>;
+			};
+
+			opp-854000000 {
+				opp-hz = /bits/ 64 <854000000>;
+				opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+				opp-peak-kBps = <10687500>;
+			};
+
+			opp-1000000000 {
+				opp-hz = /bits/ 64 <1000000000>;
+				opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+				opp-peak-kBps = <12450000>;
+			};
+		};
+	};
+
+	gmu_0: gmu@3d6a000 {
+		compatible = "qcom,adreno-gmu-753.1", "qcom,adreno-gmu";
+		reg = <0x0 0x03d6a000 0x0 0x35000>,
+		      <0x0 0x03d50000 0x0 0x10000>,
+		      <0x0 0x0b2a0000 0x0 0x10000>;
+		reg-names = "gmu",
+			    "rscc",
+			    "gmu_pdc";
+
+		interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "hfi",
+				  "gmu";
+
+		clocks = <&gpucc GPU_CC_AHB_CLK>,
+			 <&gpucc GPU_CC_CX_GMU_CLK>,
+			 <&gpucc GPU_CC_CXO_CLK>,
+			 <&nwgcc NW_GCC_HSCNOC_GPU_AXI_CLK>,
+			 <&gpucc GPU_CC_MEMNOC_GFX_CLK>,
+			 <&gpucc GPU_CC_HUB_CX_INT_CLK>;
+		clock-names = "ahb",
+			      "gmu",
+			      "cxo",
+			      "axi",
+			      "memnoc",
+			      "hub";
+
+		power-domains = <&gpucc GPU_CC_CX_GDSC>,
+				<&gpucc GPU_CC_GX_GDSC>;
+		power-domain-names = "cx",
+				     "gx";
+
+		iommus = <&adreno_smmu_0 5 0x0>;
+
+		operating-points-v2 = <&gmu_opp_table_0>;
+
+		gmu_opp_table_0: opp-table {
+			compatible = "operating-points-v2";
+
+			opp-416666000 {
+				opp-hz = /bits/ 64 <416666000>;
+				opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+			};
+
+			opp-625000000 {
+				opp-hz = /bits/ 64 <625000000>;
+				opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+			};
+		};
+	};
+
 	gpucc: clock-controller@3d90000 {
 		compatible = "qcom,nord-gpucc";
 		reg = <0x0 0x03d90000 0x0 0x9800>;

-- 
2.55.0

