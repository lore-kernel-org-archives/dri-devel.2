Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F77CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 03:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1EF10E06F;
	Sun, 11 Oct 2026 03:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MesY5mZI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IUt8C5I0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F65610E06F
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 03:25:26 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B1rn222212494
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 03:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ki8pPIk/6jBLuAEjzjkKNzgj
 IL2/HgZYij415q9mlfY=; b=MesY5mZIIzXmco6uzhlKDC4Z0qGdWV1oTgbr8Xh2
 8JmwVJRlMPut8ybRRXJ+mcaF3y7KvzMu9Ws8I/Sk+dvZZqvy9MwAaFgSWMzbPI9w
 rSJ2qF9YBEx97dGqe7VsWDYlQTuowq0JLmWg8AEznSwnCE5L4Y69eEwb6WzGd9ot
 1Qe2c3DkWgAi2I4GQUn8yI1/68ksZ5uhEjlOIXII3lrfuh1i+hG9RnTl4mqGfiW2
 Q6NH2OLO2iXH7cQaavPLyiitcj6K86OtVI6QPVh7tXw1eske/qH5Ev4obLo39JGX
 3nLdHXsO6AlK7mABTIAx+39V52lYY8t6j2iKIQBQ9OpUUg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7deuj95t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 03:25:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-358856e5105so4614899eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 20:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791689124; x=1792293924;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ki8pPIk/6jBLuAEjzjkKNzgjIL2/HgZYij415q9mlfY=;
 b=IUt8C5I0tgqQvdRhMf6fkNPkWy37wQqsVFO33NDBS+BooGunJotFg1ITveMnP3jlvd
 g36fMCpcj6QSO8ZhmyP6XooZq6NHzcHTDYDIQkUu6lRKchrYCyHhBTGQsPjfWaFBUl5e
 Ms01+KGS99Dcu7nVnl4VEL5wQflpBRsgkmbUCEHUK+J44phOkCJf5GfHG5YCrEBRGCWG
 G8YEnwIHDt+7hJCuQjg4W4t3KE844OvUBZjxh4BdaNRDX0NwfRrUU+smJLAxlxB7QiWU
 4pnGZbe8j2BUztElNNFTNEmMfzx1mSkuqT5oFAfs+8k1zyn/SLC3Q77lMdH1z5OggOBl
 yIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791689124; x=1792293924;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ki8pPIk/6jBLuAEjzjkKNzgjIL2/HgZYij415q9mlfY=;
 b=SHkBZJqFyuOwz5AwkcIh9KkILDbORVFrHxXKbVWqDrFkjJM6FhCMH7XSbQyDK9IKQr
 NVYrBhapJPEPZUYZfT3khz+u8qHWbiZ30Nr9TVvU2eMMaZP/HM17NBaPETzTdqriz3FA
 fwY1GyjeBmECAXRbQkKzq61jagzr+wIhpCSsgxiJxEL2JDRBYGh2vQcnrJIElYaGoHHV
 TaoX/lwnoHLq1/PsglV4rvHrR8kpbgRhQQBURW+pqwnbo28ZmBk+3yyfyDt3WSuBBiUi
 yb6YAoidHdeVErAeCumWmBa16fimIoyM8TxKZtfPduVTZcn4tDWG1LOY95tdv/yM5vtz
 xjMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlg45+hm4xqrvVPW1FWNRqCaSKUiwdWnyBq/oqUHHrLt4/8psOO+ea/L068U7F26ldxjMb/7Vrr5k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIAI1GxoG8rFA8NiBVsiadFPndp0/LRSxa9hhM5uFQSSjIc9S2U
 z181z+uGbL1LSrJhDqKchHlVBw3Zv6ljgDFJERaq+h8fYUnL4+ozh9xSrus0TkObb7KAmYPoyuQ
 mB+Wf5l3itYyzXTK4Q1n8iwxRQPVFnxuzreWi0ishmrTi/Q/nh8AvKCHtJfQrEIdwj4h7NTQ=
X-Gm-Gg: AYBFou3Y7MwXat+WXVXbj3StmnRLS6RGdpESVXHPWcxSeeqKeVWMhtGaDnV625H5TPv
 EjJQfbl+usRlJdzNLa8iRSYKqfM8NXPPm3PJT0gA9xMbAvhKUJ4g73HQ1IepGfaGI5+Ik1+ctga
 /sRSuizaXurAd2Y4zXghvN9STJJQIHYuv8yo7L7IUa6x6r7JMKEAEkI5DmSp5TMle3vszBf1UCC
 2Ye4FZnT7hQjiVlwTHzuNHfr9uoG4IsZhKSG+Z8mIiXYDPl+WXX0U4g707d/qU/GhwfLMNKER3W
 FP+Rhyh6QutOwToicl8I/r9mZYbZaTGJVM5zFuilktrmy8Y+85Z+K9dhrClCK4W0/v7DRSd5Vy5
 x/Jyk0NdSymbDm/AXhChvYh33zU/pmDpEtHr7YZvc5g==
X-Received: by 2002:a05:7301:140b:b0:352:4f11:8118 with SMTP id
 5a478bee46e88-3537e08c6camr8328651eec.40.1791689124004; 
 Sat, 10 Oct 2026 20:25:24 -0700 (PDT)
X-Received: by 2002:a05:7301:140b:b0:352:4f11:8118 with SMTP id
 5a478bee46e88-3537e08c6camr8328612eec.40.1791689123305; 
 Sat, 10 Oct 2026 20:25:23 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm17840817eec.29.2026.10.10.20.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 20:25:23 -0700 (PDT)
Date: Sun, 11 Oct 2026 11:25:15 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Shivam Rawat <shivrawa@qti.qualcomm.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: nord: Add Adreno 753 GPU and GMU
 nodes
Message-ID: <assBm36Joq5pdULw@QCOM-aGQu4IUr3Y>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
 <20261009-nord-gpu1-v1-3-a06a6c57bde7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-nord-gpu1-v1-3-a06a6c57bde7@oss.qualcomm.com>
X-Proofpoint-GUID: tEBieBKAEY_bpItTiY_aITFuGhWrixpV
X-Authority-Analysis: v=2.4 cv=Aud7T+9P c=1 sm=1 tr=0 ts=6acb01a5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=BJWcozxxeopv1PEHIoIA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDAxMyBTYWx0ZWRfX+NEGfDSlyQjW
 tKqI03qOxWRlkVB4bbZ5jvuh4WK2FUuk2qbcxyEU790X/aeKSkcZ4Cuu9sfqCPLyMgCUWQyRTzr
 DTRTEG9WuPI/MfvfZtLeJWMovcg9Z4k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDAxMyBTYWx0ZWRfX2qiyQkcYig6s
 X8immCWmC1xxCrxCdqZUxlDI8FtH4J8VUsc3UeAUgqE4s0NK+OqQpvjLb/SPLetbapk3ndTm3KE
 Kvde1j8eKVVL18ALAt3f2jLYlJUWLGjaGRUIuJC9Uc/So+Drex7YReQhctX1hRpbfOsY1v8wtWp
 1Qf8UVw24qAJeSd1uCgFG9o5KPwRyj51yDnuIVWDPOjTkIohHRN2DwO6nNPAQZN08Eo8Ta9mNQ3
 R5w0SJKOjtHEtVG37OycBN5CoKbJniyFTdRlP9rpnNl7Xk3nb6ipAVhHCfbHYNVmPmYC0OEVbiY
 vExPyAaXslgl9D78I2cR0+05b1wxYP8CjIV21vzcA253CWkQBP2o42Cnf11gov4T2zYhvW7iAa/
 xwRoMCUthQritDiVwdXz/9MS7JYmgH//BiJb+K7ZCUlAJksxfAjm6vwhwRate7BGnshGtex3zlh
 8zhIFblDwiCxAJ1RmAw==
X-Proofpoint-ORIG-GUID: tEBieBKAEY_bpItTiY_aITFuGhWrixpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110013
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

On Fri, Oct 09, 2026 at 02:36:37AM +0530, Akhil P Oommen wrote:
> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
> 
> Nord SoC integrates an Adreno 753 GPU as its primary GPU, belonging to
> the A7xx Gen3 family, along with its Graphics Management Unit (GMU).
> 
> Add the GPU and GMU nodes together with their OPP tables. The GPU sits
> behind adreno_smmu_0 and uses the gen71300 zap shader, while the GMU is
> clocked and powered from GPUCC.
> 
> Unlike previous Adreno SoCs, where the GMU AXI clock comes from the
> single global clock controller, Nord splits its GCC into four blocks
> (GCC, SE_GCC, NE_GCC and NW_GCC). The GPU's AXI clock,
> NW_GCC_HSCNOC_GPU_AXI_CLK, is provided by NW_GCC, so the GMU node
> references nwgcc directly.
> 
> Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/nord-embedded.dtsi | 116 ++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> index 1ab7d9bc3cfe..4379092b7bf8 100644
> --- a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> +++ b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> @@ -776,6 +776,122 @@ hscnoc: interconnect@2000000 {
>  		qcom,bcm-voters = <&apps_bcm_voter>;
>  	};
>  
> +	gpu_0: gpu@3d00000 {
> +		compatible = "qcom,adreno-43051701", "qcom,adreno";
> +		reg = <0x0 0x03d00000 0x0 0x40000>,
> +		      <0x0 0x03d9e000 0x0 0x2000>,
> +		      <0x0 0x03d61000 0x0 0x800>;
> +		reg-names = "kgsl_3d0_reg_memory",
> +			    "cx_mem",
> +			    "cx_dbgc";

nord-embedded.dtsi is created to accommodate Nord Embedded (Non-GearVM)
variant specific resources like clocks, resets, power dmains,
interconects, PHYs, etc. The common resources like reg, interrupts,
iommus, etc, should go to nord.dts. Please follow the existing device
examples to do the split.

Shawn

> +
> +		interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		iommus = <&adreno_smmu_0 0 0x0>,
> +			 <&adreno_smmu_0 1 0x0>;
> +
> +		operating-points-v2 = <&gpu_opp_table_0>;
> +
> +		qcom,gmu = <&gmu_0>;
> +		#cooling-cells = <2>;
> +
> +		interconnects = <&hscnoc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
> +				 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> +		interconnect-names = "gfx-mem";
> +
> +		status = "disabled";
> +
> +		gpu_0_zap_shader: zap-shader {
> +			memory-region = <&gpu_microcode_mem>;
> +		};
> +
> +		gpu_opp_table_0: opp-table {
> +			compatible = "operating-points-v2-adreno",
> +				     "operating-points-v2";
> +
> +			opp-468000000 {
> +				opp-hz = /bits/ 64 <468000000>;
> +				opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +				opp-peak-kBps = <781250>;
> +			};
> +
> +			opp-625000000 {
> +				opp-hz = /bits/ 64 <625000000>;
> +				opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +				opp-peak-kBps = <6075000>;
> +			};
> +
> +			opp-735000000 {
> +				opp-hz = /bits/ 64 <735000000>;
> +				opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +				opp-peak-kBps = <8175000>;
> +			};
> +
> +			opp-854000000 {
> +				opp-hz = /bits/ 64 <854000000>;
> +				opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +				opp-peak-kBps = <10687500>;
> +			};
> +
> +			opp-1000000000 {
> +				opp-hz = /bits/ 64 <1000000000>;
> +				opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +				opp-peak-kBps = <12450000>;
> +			};
> +		};
> +	};
> +
> +	gmu_0: gmu@3d6a000 {
> +		compatible = "qcom,adreno-gmu-753.1", "qcom,adreno-gmu";
> +		reg = <0x0 0x03d6a000 0x0 0x35000>,
> +		      <0x0 0x03d50000 0x0 0x10000>,
> +		      <0x0 0x0b2a0000 0x0 0x10000>;
> +		reg-names = "gmu",
> +			    "rscc",
> +			    "gmu_pdc";
> +
> +		interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "hfi",
> +				  "gmu";
> +
> +		clocks = <&gpucc GPU_CC_AHB_CLK>,
> +			 <&gpucc GPU_CC_CX_GMU_CLK>,
> +			 <&gpucc GPU_CC_CXO_CLK>,
> +			 <&nwgcc NW_GCC_HSCNOC_GPU_AXI_CLK>,
> +			 <&gpucc GPU_CC_MEMNOC_GFX_CLK>,
> +			 <&gpucc GPU_CC_HUB_CX_INT_CLK>;
> +		clock-names = "ahb",
> +			      "gmu",
> +			      "cxo",
> +			      "axi",
> +			      "memnoc",
> +			      "hub";
> +
> +		power-domains = <&gpucc GPU_CC_CX_GDSC>,
> +				<&gpucc GPU_CC_GX_GDSC>;
> +		power-domain-names = "cx",
> +				     "gx";
> +
> +		iommus = <&adreno_smmu_0 5 0x0>;
> +
> +		operating-points-v2 = <&gmu_opp_table_0>;
> +
> +		gmu_opp_table_0: opp-table {
> +			compatible = "operating-points-v2";
> +
> +			opp-416666000 {
> +				opp-hz = /bits/ 64 <416666000>;
> +				opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +			};
> +
> +			opp-625000000 {
> +				opp-hz = /bits/ 64 <625000000>;
> +				opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +			};
> +		};
> +	};
> +
>  	gpucc: clock-controller@3d90000 {
>  		compatible = "qcom,nord-gpucc";
>  		reg = <0x0 0x03d90000 0x0 0x9800>;
> 
> -- 
> 2.55.0
> 
> 
