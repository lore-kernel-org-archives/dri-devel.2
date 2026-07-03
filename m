Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68866C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BAC110F900;
	Fri,  3 Jul 2026 20:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kwWcc/aQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HpJMNzn3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4519710F8FA
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:36:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KPg151020707
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 20:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=; b=kwWcc/aQsvDhuNvU
 sR7hpyO1eDnpBJVtmAbr9xTdsoTDV/umabqbahre0b6e4XNHuWEDLADYcmDPoIP5
 RVRpYv46JJcuv42nh/uIRPKVavgKEomucpLkYOCSstuaFiDolNL3MwQkgUCjNV1M
 Qe90JQBTQwnxVYPLP8yzo4Bw1UGjwwsWfb8jFqFKnLLGzoVAVbyTHxlAuBsbD7aA
 u/6rEvqbMjy+myKEK2uvwWQQ3FJC46T3e86XyArv/GU96C5rwAGjgJP2wF+sgEgE
 zc/24HIlzL3Oj92i18QWYdBgSptNqMIFYbW+1NEYBR0ZksdatmJ15lBv7JiFgbrB
 ol6OSQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkhd92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 20:36:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3810e5c5871so1434586a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 13:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783110962; x=1783715762;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=;
 b=HpJMNzn3FyW6c6CvaDL0xoWiJTxlzEWRgQ3gh5dOpXuMIUHAi97r/zWK2JiZP8bzGh
 if3by4uqJjGRNGNmZVRtjhp1pY+fWyY7MdzciwabU3YWp4mPsVEwRvONTa9faDb7riG0
 sWYIIX7vO2D8IciYfv4BnvlpkVJh1GxKPVZl8FcfuhwauJaJfNCz+ky9vEqe17aMqPus
 pWl1EqN/ON9vOjMU5obpikFmdKPjv4cZy4ls4j6k/icEPmwFoThlJ/DQ6ze84tOepn/R
 JSyo5JUFAnwqh0/sXp1GBcdPIg2ObRrImB9ffCrs966TnmGG6Inakw+3n7h4FLNd+D8q
 Wpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110962; x=1783715762;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=;
 b=cd/AWWIEs295lOmKGOARQwTOC0IV8dXWLp75RRSjnt1tdc+HUDntJPfHNWoRnyy6xo
 1QsClHoVdT7L+BKKWiOvoADROx0Qfll25TU9IhDYZx/Jreq3ZeRZcAEqgnVo2yE9TGm+
 x3XKv7c2Kejkl5fy6b3LiHv7lY7GiUUoSpelnDuK/lVXuprN/U4I0PAYgFSjm+eGD+n1
 X6VAuUWLuWH7sG3iXqOGAh8yjfq10ncieubZ4nbxNMXWcCazHVbD/u1mw41v8+yuxATQ
 5BXbz72Xr3+GRvkSvV0JhofKspA9HCyOyJ0nRbyQ0EcWuhAtkB/PvFUs3+YzKTvQY152
 Ou3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLH1EJioKVyTNF5tYWkEPWBV8JcunLfcqbEl8jSxtozNTl/4inzcVdrAqjfmyCXmHHn6kNdYHD980=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzrn0bRKWUBc1TR3ZVP+cjGa+8s6e/kWNHULXUsFkWBAOqzr9BQ
 h2SyhSVTjDctHkfJU1bTV9emGVSafVIkea0uIPwRC+6DthHKViqnGmI0EVfl+Y5fIC04nXwEq56
 VaSbk5SF8FHp4bD5x0g+HH5zgok85+pyCfXPXkjQvu8tc6g1YLwJ+v+qBnIdQd5Y6wBhCzu8=
X-Gm-Gg: AfdE7ckIP9NNgYNDFfPnSAp9x/E0xJ/PjODO7825QlpSdplnbCXjdtl1oEOlKro4TjV
 TNfUz1263jwaJoJDGYwZhL6LzyNbTBMWNiBMSwOuo956SkjySNP0/WxhOh457E+A9z+aMEK2BkH
 ifG4s+OETSEO0vIMnlmlmcWqtukkho9mG02Kn//3Gsm/KAadZqn0QWkFcDFRVBwCip5lC6QXhW6
 xZxudli//Svz/cbqwHEA7rddxSKxaJqfp9jEsEy3qvGEcaeyk2F6UqAGDZnLmFDR5KWj9oMagRx
 +3/mFAkNPTM3hOlm+g+Go8OFmRlKZS6nxoSUAxXC/frH1pIUc7XQFgo+ZIoJU6+2ZM8awoh9PZz
 tFxBQItk3ri/AQesm34kXvK4IwFyP541PtMs=
X-Received: by 2002:a17:90b:57c8:b0:382:1cf1:a0a6 with SMTP id
 98e67ed59e1d1-3829f5eadf7mr875865a91.24.1783110962218; 
 Fri, 03 Jul 2026 13:36:02 -0700 (PDT)
X-Received: by 2002:a17:90b:57c8:b0:382:1cf1:a0a6 with SMTP id
 98e67ed59e1d1-3829f5eadf7mr875826a91.24.1783110961759; 
 Fri, 03 Jul 2026 13:36:01 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:36:01 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:31 +0530
Subject: [PATCH v4 5/9] arm64: dts: qcom: shikra: Add A704 GPU support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-5-90cf1a52e539@oss.qualcomm.com>
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=3495;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=AFPL1mLXpKffrlVn7dhyAuVw3rCpzngGAE8+zg6xtsE=;
 b=ZlRr5sWqKb8250Ap/ksWBqpMq0V4lok4Fs/7+kMo7z64J193DYFwpD+3fTzxPU/vnV3Pvpcyi
 v/N3wBxCT//DPMPx7VhN1Xd25wRLqcduWT3dZQeV4ed2hEg3ZXl8MJg
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX73bwWmbtizkg
 WyLGYNIk4RPebAblXDemx7ONuxpvED3ZJuVU6A59YVEiRMQibBZwzsKBOUjuxtJXH8eVn057RnM
 FrQ5nlAQtHiRLa+qXm+bHBGfjH1u1i5PEbjaGTjWgfqkJrwWfkTqz19ZVt68roby37Bk1jNWxrw
 f+5xDd27oNhKaZ2il3hs8NteSXwxXiIhvv88GGppHE6MS4CPSnHh1CENO72iuMk0nFK810BisTb
 tb49Xjd7or4fi8+YZjvU9fJJYBrazW5oq+X9iarRQEfCujRl1d1+w3D6ZthjOxUEThy5n/Shcyx
 qK+IgCGk5XSYiFsffLjare1VkXiWaTYamIQH8TStYCqMdamxmjLKSG26MHcV3vpO1rdTEM70BQ1
 uQjrywl+yBYtlCrP2egRFxTQmeoZz4GrWxj7RZGOSvDAcTTx091gZ4PVjG30pS2jZvJXTDgifEt
 zllRr6dhITrEbOeJf8A==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a481d33 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=jWRUczSHPS-Ra7sZ8p8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: QUXd0PFxOUwnFHdgNPMFYKdrh7N-5VLM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX8S1P86sd98jZ
 huYV3k/OOukVNKE3q+3S5NKsdLChzBZJBixFa7QHnm6arRGuXI/BYMz1fv455/Kt3MmMkuKUjYB
 i0m24uOujNVZ3oUAj3L5DWEgHMIpMbw=
X-Proofpoint-GUID: QUXd0PFxOUwnFHdgNPMFYKdrh7N-5VLM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
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

Add the A704 GPU and GMU wrapper nodes with register maps, clocks,
interconnects, IOMMU, OPP table and the zap-shader region.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 98 ++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index bb11e832d9a6..34261221664b 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1992,6 +1992,104 @@ glink-edge {
 			};
 		};
 
+		gpu: gpu@5900000 {
+			compatible = "qcom,adreno-07000400", "qcom,adreno";
+			reg = <0x0 0x05900000 0x0 0x40000>,
+			      <0x0 0x0599e000 0x0 0x1000>,
+			      <0x0 0x05961000 0x0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem",
+				    "cx_dbgc";
+
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&gpucc GPU_CC_GX_GFX3D_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>;
+			clock-names = "core",
+				      "iface",
+				      "mem_iface",
+				      "alt_mem_iface",
+				      "gmu",
+				      "xo";
+
+			interconnects = <&mem_noc MASTER_GRAPHICS_3D RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+			interconnect-names = "gfx-mem";
+
+			iommus = <&adreno_smmu 0 1>;
+			operating-points-v2 = <&gpu_opp_table>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
+			qcom,gmu = <&gmu_wrapper>;
+
+			#cooling-cells = <2>;
+
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_micro_code_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-1142400000 {
+					opp-hz = /bits/ 64 <1142400000>;
+					required-opps = <&rpmpd_opp_turbo_plus>;
+					opp-peak-kBps = <8171875>;
+				};
+
+				opp-1017600000 {
+					opp-hz = /bits/ 64 <1017600000>;
+					required-opps = <&rpmpd_opp_turbo>;
+					opp-peak-kBps = <8171875>;
+				};
+
+				opp-921600000 {
+					opp-hz = /bits/ 64 <921600000>;
+					required-opps = <&rpmpd_opp_nom_plus>;
+					opp-peak-kBps = <7046875>;
+				};
+
+				opp-844800000 {
+					opp-hz = /bits/ 64 <844800000>;
+					required-opps = <&rpmpd_opp_nom>;
+					opp-peak-kBps = <6074218>;
+				};
+
+				opp-672000000 {
+					opp-hz = /bits/ 64 <672000000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+					opp-peak-kBps = <5285156>;
+				};
+
+				opp-537600000 {
+					opp-hz = /bits/ 64 <537600000>;
+					required-opps = <&rpmpd_opp_svs>;
+					opp-peak-kBps = <3972656>;
+				};
+
+				opp-355200000 {
+					opp-hz = /bits/ 64 <355200000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <2136718>;
+				};
+			};
+		};
+
+		gmu_wrapper: gmu@596a000 {
+			compatible = "qcom,adreno-gmu-wrapper";
+			reg = <0x0 0x0596a000 0x0 0x30000>;
+			reg-names = "gmu";
+			power-domains = <&gpucc GPU_CX_GDSC>,
+					<&gpucc GPU_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+		};
+
 		gpucc: clock-controller@5990000 {
 			compatible = "qcom,shikra-gpucc";
 			reg = <0x0 0x05990000 0x0 0x9000>;

-- 
2.54.0

