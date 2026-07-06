Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050E9C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6146710EAD2;
	Mon,  6 Jul 2026 21:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XemG46oy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="etgAtpX1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADE010EAD2
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:05:47 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE63o1495664
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=; b=XemG46oyty96A3vH
 JA1v1oCMxOQ3cCOvgMFdMKkWjuBqWU2a9oT2A2EVwVQZ9wJxfXR0K2XjmIpasOip
 aRUY8tMCzmEKH4WtgI2CK9hM3JGSrbiQg4TtbA49/fjZ41NLRUtyF+BMdjxIQm0p
 eI8xYNc+LjBep57d3DBufKXmyiOSn4qRGP45N28rk8jRoF49vFkIk//tW5092ztm
 z2mJ2xXjBfNpQoHICIKkPg7VVw0azqteM17fEKQNRHtICQgMzp1cBRg6vNanNgE6
 O7NE2cxwuZEXBYycSnnQ5zw7E2nWFojH79aF2Xybym/1W8NMsBxOe0/2xDkTW+M1
 1sYbzA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8b7h2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:05:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cca5e0a0c9so27862575ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783371946; x=1783976746;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=;
 b=etgAtpX1MXMnwKRDZAw0U4pFBf4kJUOpjIpx6exp42dGi3nTttSOzkT8+8znO9jplT
 IyaQtm7PPYEZ9xwwTXBQwxocV/jl/nc1SHlaROfmdgw83m39X6o93xpTb23qNc4AlTQL
 z1OILt9ex4rdsBQEqaFCP4NYrXsIZI3HKi4+Zvr934Kcq6HkUIuNgjSPJ0aroqsYlyQV
 l3j9oZ7J4aDmWNeX2kScPjK10UwC10RzajpAK12fdySd4dcPuD746VIjZ76E+L7RI+eP
 Fdgm7SborI6es0NiWaS6+9mT1eiCNOQMZTFQQIMGML0eiMOtOnikCCCicuHRMB9Jj2L5
 0YAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783371946; x=1783976746;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YX0xffgjn0Hj0XJqfYesceM2iVvwVlQIavz3fGceyNQ=;
 b=rtE1XPbdX4yWRB5rJNq0579l1aG3BOYnvUMtAUviGK5cZA1g0/qCPBSVI40lB/xWnv
 gvOcRNPp593KVNvDP7YDCu+GFRwPUWALzemId50wxYD5cEx/vI+JKvyIBXGwFFXzyg4R
 5NgtjUmiAxaLbYf3bmqNFUNRnuJWX2is55QimC/jq9e7OptoWWaoU6/WzvHBYDrel1+q
 zYg9Ju2uuHqgvXwS2Gp5ksho6iXCRE+1YIlTWdkY9u5C2jkAyn+x8M7d4SE1XzOR+sO3
 Dxqq1bGn17Mvc84yzFxxY8QJKrjL0u9njX2UnDWjTROa6aibqGy+0NadDqZtWNqvsRvI
 Q95w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1gs1omEc+5EM1hJZRoFdsXuYjK+T4xfng4Pi5DjeQSb8+a6FbIELwgp+R0aChdokrpYRytvPmYhA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnmnXytb7iNIYgRBddtbZAhptBjyGTTpdQxY0XHMvlAsRX1UiF
 puseWp+/PIs3hzjzl2KChWgfXEl9APi9CZbIrpZCAW5bNB53I8dbb3GMMx2V4YxsbGtbj/2/NUX
 PeDm85ZYl5tNXs1eH9cLCaYrMLlxvb74tBUdjuk34FoRcsQBA4Lx9YYwJsQ4w2uwvhM9QXwc=
X-Gm-Gg: AfdE7ckGfDXfXdaa3CjehVF1gWqECT217cUwJb2y8sS7Lsm91rXqtJYRQ5ePT7rD3k9
 TkjlxwFp30reEHMwnibPXnyg0p8BNi5bkzQB8nU8UMJ6sLnX582xDgrOP9BTwyyZJb8KcxN0U7K
 rNdmRmNZoSGZYNU5s5DD7hYV7bLHqXq2ISalN8dPFmnJstZ2mIQolvvCGUYFiGNq5UoORBb2o4w
 q/ZeudtNfDewxOdHzWFzjXmlYYNodt9VO+7b3DhDTCvyumLfsh5EjmGCISmc6WNRI8+5cDKzv9M
 nfEA0yfk5xDC4yur+fqItDc6PeICACPsZZEG7PAIGibxzAa6SXKqIYq3wtO+KQ1H/ZLeJ3E59Ez
 njmoT/1RNgNrxREapEa6JKKM8z8Jc1S0RZc4=
X-Received: by 2002:a17:903:19ec:b0:2cc:8ad3:423d with SMTP id
 d9443c01a7336-2ccbf041c8cmr26647095ad.29.1783371946262; 
 Mon, 06 Jul 2026 14:05:46 -0700 (PDT)
X-Received: by 2002:a17:903:19ec:b0:2cc:8ad3:423d with SMTP id
 d9443c01a7336-2ccbf041c8cmr26645595ad.29.1783371944672; 
 Mon, 06 Jul 2026 14:05:44 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:05:44 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:37 +0530
Subject: [PATCH v5 5/7] arm64: dts: qcom: shikra: Add A704 GPU support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-shikra-gpu-v5-5-d2f373912d3f@oss.qualcomm.com>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
In-Reply-To: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=3495;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=AFPL1mLXpKffrlVn7dhyAuVw3rCpzngGAE8+zg6xtsE=;
 b=Hg2Kf+dWXJ+whlWJjf8ja7E8O66IAXgviTZ41pNM+vxeAaoMmTklSyb87ZwbbzCvOrJtjZe4o
 VVlCMvVeNWWAZQO4FGDVlUVdpIrYZG85JDUmqOliICPcLii0AxUVNsV
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX4bYLasEm2SzL
 9Wy8vE6QeQB/3C4PQlPd90vlmH2CpUqCEtpRyRe/ZfASh08j/L8u1oqNormWHA1D7jOANqYVFMJ
 234741dNCv3T5E0j+2DKSfoNSuU+Vzk=
X-Proofpoint-GUID: rYeWRNxF8rVeXa5qqnVU9d0Q8GgcPLlB
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4c18aa cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=jWRUczSHPS-Ra7sZ8p8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: rYeWRNxF8rVeXa5qqnVU9d0Q8GgcPLlB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfXxEpDpuGXcuAe
 gqif7lmai1Frf058wumpQiioej4qxGLwILwFRthSdyPFnP0a2KbZyoG0n2e+pJsPbLx2/zTWULt
 pOWqXmPzEPl6z0PXvY3PiKz64u6vUu52qWT7oV07Xcz+eUvtm9gIoAuPEQVkoyxxqZNKpn5nIcP
 KWVFFF28Pu+SSBXdkl8GQ2LGOKd54fmChMvkU4Wte4VBOyThDvIgEsqRYYagJLFn8vA8FDcD15m
 gzzFxcZ/v11bl9htcMGhxWt+6khQWt6cRm5pyeR31C+FaysyVErRDcAUALRszdulxBYFcDomlsj
 0NKgn3oP4hVW7eSEVnon7V6WjCB0+2G0NA7Cvn3/pz/VxxmwoenJjqE8yDw+TRvq3QYHniexGeP
 krSaDUECMT9uqe1+h0+YRwtOTOOiKfIyd9BdG5Q91/BLoOKoDuj/M5OE/j/cYJYFURGCAQcnd8w
 vg4IDXIgIPiV23YtlaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060213
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

