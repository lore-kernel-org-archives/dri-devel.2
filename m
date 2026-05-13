Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA2ACD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 20:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D05310E342;
	Wed, 13 May 2026 20:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iuj11DuI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P4l52YAl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D15B10E342
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 20:51:14 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DGuIe83995530
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 20:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NMgU7G0PULtWal9zMMhkYiuEJrUUShzsoQegQpN3nxE=; b=Iuj11DuIde3Bi/3W
 bYcwXPOjbSvOfS0g1ee6gEwAzqVu9q0mJYBm0aOqlUt99JHG/F2tCD8VNaJvwNMY
 nWLdT7jh054fEz72rlCIp1NHgLDyh6I3J0Nwdk1tWKlOWQAfExYLuo3mIfCVKPXW
 MiTRlaLRGsPYPywqnXsfj8Ve+Jk4Op5YacHA/9SySKcsqKTSp1fNDkT0Imm5lyy9
 pH6LHYf1HPS67rRcqA5jMViPw1sAuVX7QhrfNfHGGIMErl0+2TZKt8lFhlqoYXug
 miPbhXs2ivFbTyew2QE2Ke/1gOhk1ZF58K6F+yMdf86OqATj1md15ritP0PPQ+wA
 bVzEjQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4w8urx8k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 20:51:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bc860066a6so35988575ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778705472; x=1779310272;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NMgU7G0PULtWal9zMMhkYiuEJrUUShzsoQegQpN3nxE=;
 b=P4l52YAlCBeGK0Ji+wpZeMAKbiuRNgju9WqqNlOPlcgZmfk05zIhTRi9+kVyRZgJGR
 FkRWknQy7wPB7uF0aHDRQlbxp6/Mw1xugUzH7yr2ZE+YefMyXl/M82Bz50An9Dnomj9I
 ou9zjkcOSvR7fd98JtOmO8YqkAGi6rGfH3euuzvIEA8oqCn9xJBHeZaoV7eEE9fu1uJs
 zLpbFSyzu4/3DpUA6qL1T8oXeddMD5n01q5y9WlhLcCMKQz6r61cjOFmqyxL3N+zOMo3
 AEVWnuoH2vBwWkyb8pyu994rGgTJQL4v9xx6I+SNgATjNWJQRmkAMxCUbD0TcQB2EzLR
 ZWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778705472; x=1779310272;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NMgU7G0PULtWal9zMMhkYiuEJrUUShzsoQegQpN3nxE=;
 b=AEZl6TEH+kJB1PX2ttbkd7FBH9iyPrQTuKIB/+jJFs0CZt/tm7o3k41Ouys1Zr/A00
 6Z/K6XIp/1FPsmoxYMZFh2sjd2/oeC5Snv5ZlyEH1A6/C4h7hv8+n1J9xxKCsLADoyJA
 ARBg7Wz21F4p5tmBn5VtySXrrN/iQysXrFIrdmdkVTmCslTBdEg/5RwntRw180q2XF4Q
 PEDJ24o8Z38yczUJFihkuVHpMdGJJ7x03Tgyx7+qAIVsXvICxgtmPBwUdJwncDrFEJba
 b5Ud2KZmLbYJG5V85/hQatZPkngylkWo88mGboam2mo6EV+pK76/6sFXbd4G6ryHOPUX
 EgGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/sAQo8MJpygu0rjiMvtao4sVoAcpUGTUYEzKCa+9lycLVEaUug46JaWy4uaGyPNX2wM/xa0mbO8DA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxACd+I8mzY+i7/jn7/6Vijo1aqh1oeTfDcrFGx/9IizupW7JxS
 VxaW1gVx548IgKWq/vna3eQlb7ckk/wQ1af7UAMOmmX9SVjTJcvO+Z/hM9ZHMnrmY4zPYsi8z58
 dEn0135mcJDA6J3553t+JOAWRJL5eHtrhASH+0G+lpy8aeLhitlqPeynyexuqLDaB+wYfcOM=
X-Gm-Gg: Acq92OFZmS2UWi+di4NROc57DPAwfylykqYTFfttndUaONYmJONenEufKPI14gvTdTQ
 B/ZtVEuhfj8VDn6xCMa+/lICu51chs0WBUuJ9CFsh+5XCDB0+FpON+qFvvyLyZ+NNtyQCvwkZyZ
 9rJm/TYZg8WxGjoJL+pFlxVMQhAKWG9J+MMb4P1MyNr2osK3M1oeQ2c+H80VfLPazJB6W+bj7UP
 3xXVX4S/Aq/oWqKUgvPqbz3NaJmWsOJrvT1bq9FXlhuT2UYX2CboAc+zPYt06EesKDiuFjEndMp
 JSCVdWb7xdSIu1hMFOxtH7dhMpdLmJuvMegxPdyoV0auik5PQYNtfyWCyeRusw2E4r0BKN8+m1k
 wbh7e4fVoIjvdzEYXAeGP2i+BHdNbvAYLqJKoLwd+IXi9
X-Received: by 2002:a17:903:1786:b0:2bd:2de3:519f with SMTP id
 d9443c01a7336-2bd2de35393mr50799655ad.19.1778705472338; 
 Wed, 13 May 2026 13:51:12 -0700 (PDT)
X-Received: by 2002:a17:903:1786:b0:2bd:2de3:519f with SMTP id
 d9443c01a7336-2bd2de35393mr50799335ad.19.1778705471848; 
 Wed, 13 May 2026 13:51:11 -0700 (PDT)
Received: from [192.168.1.6] ([106.222.229.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05f36fsm1595235ad.21.2026.05.13.13.51.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 13:51:11 -0700 (PDT)
Message-ID: <9b3a3cc9-c53b-48d9-a5d1-245b9be894cc@oss.qualcomm.com>
Date: Thu, 14 May 2026 02:21:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 7/7] arm64: dts: qcom: milos: Add Adreno 810 GPU
 and GMU nodes
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
References: <20260502-adreno-810-v5-0-bc9fd2bb788d@pm.me>
 <20260502-adreno-810-v5-7-bc9fd2bb788d@pm.me>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260502-adreno-810-v5-7-bc9fd2bb788d@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WP1PmHsR c=1 sm=1 tr=0 ts=6a04e441 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nm1BsBjGsf7C+PoY3QnOXg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=E6X0ssOTjsGwspkTZlUA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: 1P94HOgyNYv0CBbvVRnazN6JWWv-4ytH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIwNiBTYWx0ZWRfX5OlqeHjL4iEc
 1/Q0d/nF3v7KLXBvWXcaP5pnEIbKrtZqYnu/dks8huujBpFdcjDL9snRm4ZzMTlLlxRcTWiaHaT
 PLyHJnmbAHtkyQKs0U8ctai+fcHvPDOp8RpqYNmcjM2oc5H3b8rQlOct2V7ZClfoqKG29FLQl/i
 BofXmP+a+AJqJTfZwyDekXQFfG1wf3BeGwWgmof/Jbvm889a9qSFD9yYaPYalKJQiiWllfrtS97
 r2g256jEjTxCx01MvUg7gQpVJLsXj4ApMTvJ6mezaivV0aW6T9+rUV4NkyI0N1yjC7JqDeJFKly
 pzmCrOWqDB2QlfSP/lfC3JYa0M2NSPOahLN6Ya4fqGWQ41ClzRbY1AlzzPva952MZcL9aRH5g5U
 5p6/sjFNZEgEpU/6UqMUtO0K2nD6WHkAdXt2FZU+rCu6KnwT0Apx6e65fuz65p9yA7ca7pBMpeZ
 5r3/rwWByxZxHcbJmhQ==
X-Proofpoint-ORIG-GUID: 1P94HOgyNYv0CBbvVRnazN6JWWv-4ytH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130206
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

On 5/2/2026 1:38 PM, Alexander Koskovich wrote:
> Add GPU and GMU devicetree nodes for the Adreno 810 GPU found on
> Qualcomm SM7635 (Milos) based devices.
> 
> The qcom,kaanapali-gxclkctl.h header can be reused here because
> Milos uses the same driver and the GX_CLKCTL_GX_GDSC definition
> is identical.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  arch/arm64/boot/dts/qcom/milos.dtsi | 166 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
> index 0e7cfc12b0d2..4abaef42d7d4 100644
> --- a/arch/arm64/boot/dts/qcom/milos.dtsi
> +++ b/arch/arm64/boot/dts/qcom/milos.dtsi
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
>   */
>  
> +#include <dt-bindings/clock/qcom,kaanapali-gxclkctl.h>
>  #include <dt-bindings/clock/qcom,milos-camcc.h>
>  #include <dt-bindings/clock/qcom,milos-dispcc.h>
>  #include <dt-bindings/clock/qcom,milos-gcc.h>
> @@ -1554,6 +1555,171 @@ lpass_ag_noc: interconnect@3c40000 {
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +		gpu: gpu@3d00000 {
> +			compatible = "qcom,adreno-44010000", "qcom,adreno";
> +			reg = <0x0 0x03d00000 0x0 0x40000>,
> +			      <0x0 0x03d9e000 0x0 0x2000>,
> +			      <0x0 0x03d61000 0x0 0x800>;
> +			reg-names = "kgsl_3d0_reg_memory",
> +				    "cx_mem",
> +				    "cx_dbgc";

I re-jigged the registers ranges for A8x GPU/GMU. Could you please
follow what was done for Glymur here:
https://lore.kernel.org/lkml/20260513-glymur-gpu-dt-v4-5-f83832c3bc9a@oss.qualcomm.com/

And with that, you will need this RSCC update in the driver:
https://lore.kernel.org/lkml/20260513-glymur-gpu-dt-v4-1-f83832c3bc9a@oss.qualcomm.com/

Rest looks fine to me.

-Akhil.

> +
> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH 0>;
> +
> +			iommus = <&adreno_smmu 0 0x0>;
> +
> +			operating-points-v2 = <&gpu_opp_table>;
> +
> +			nvmem-cells = <&gpu_speed_bin>;
> +			nvmem-cell-names = "speed_bin";
> +
> +			qcom,gmu = <&gmu>;
> +			#cooling-cells = <2>;
> +
> +			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> +			interconnect-names = "gfx-mem";
> +
> +			status = "disabled";
> +
> +			gpu_zap_shader: zap-shader {
> +				memory-region = <&gpu_microcode_mem>;
> +			};
> +
> +			gpu_opp_table: opp-table {
> +				compatible = "operating-points-v2-adreno",
> +					     "operating-points-v2";
> +
> +				opp-264000000 {
> +					opp-hz = /bits/ 64 <264000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
> +					opp-peak-kBps = <2136718>;
> +					opp-supported-hw = <0x7>;
> +					qcom,opp-acd-level = <0xc8295ffd>;
> +				};
> +
> +				opp-362000000 {
> +					opp-hz = /bits/ 64 <362000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					opp-peak-kBps = <2136718>;
> +					opp-supported-hw = <0x7>;
> +					qcom,opp-acd-level = <0xc02c5ffd>;
> +				};
> +
> +				opp-510000000 {
> +					opp-hz = /bits/ 64 <510000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					opp-peak-kBps = <3972656>;
> +					opp-supported-hw = <0x7>;
> +					qcom,opp-acd-level = <0x882b5ffd>;
> +				};
> +
> +				opp-644000000 {
> +					opp-hz = /bits/ 64 <644000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					opp-peak-kBps = <5285156>;
> +					opp-supported-hw = <0x7>;
> +					qcom,opp-acd-level = <0x882a5ffd>;
> +				};
> +
> +				opp-688000000 {
> +					opp-hz = /bits/ 64 <688000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
> +					opp-peak-kBps = <6074218>;
> +					opp-supported-hw = <0x7>;
> +					qcom,opp-acd-level = <0x882a5ffd>;
> +				};
> +
> +				opp-763000000 {
> +					opp-hz = /bits/ 64 <763000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					opp-peak-kBps = <6671875>;
> +					opp-supported-hw = <0x7>;
> +					qcom,opp-acd-level = <0xa8295ffd>;
> +				};
> +
> +				opp-895000000 {
> +					opp-hz = /bits/ 64 <895000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					opp-peak-kBps = <8171875>;
> +					opp-supported-hw = <0x7>;
> +					qcom,opp-acd-level = <0x88295ffd>;
> +				};
> +
> +				opp-960000000 {
> +					opp-hz = /bits/ 64 <960000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +					opp-peak-kBps = <8171875>;
> +					opp-supported-hw = <0x7>;
> +					qcom,opp-acd-level = <0xa8285ffd>;
> +				};
> +
> +				opp-1050000000 {
> +					opp-hz = /bits/ 64 <1050000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +					opp-peak-kBps = <18597656>;
> +					opp-supported-hw = <0x7>;
> +					qcom,opp-acd-level = <0x88285ffd>;
> +				};
> +
> +				opp-1150000000 {
> +					opp-hz = /bits/ 64 <1150000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L2>;
> +					opp-peak-kBps = <18597656>;
> +					opp-supported-hw = <0x3>;
> +					qcom,opp-acd-level = <0xa02f5ffd>;
> +				};
> +			};
> +		};
> +
> +		gmu: gmu@3d37000 {
> +			compatible = "qcom,adreno-gmu-810.0", "qcom,adreno-gmu";
> +			reg = <0x0 0x03d37000 0x0 0x68000>;
> +			reg-names = "gmu";
> +
> +			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH 0>,
> +				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH 0>;
> +			interrupt-names = "hfi", "gmu";
> +
> +			clocks = <&gpucc GPU_CC_AHB_CLK>,
> +				 <&gpucc GPU_CC_CX_GMU_CLK>,
> +				 <&gpucc GPU_CC_CXO_CLK>,
> +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gpucc GPU_CC_HUB_CX_INT_CLK>;
> +			clock-names = "ahb",
> +				      "gmu",
> +				      "cxo",
> +				      "axi",
> +				      "memnoc",
> +				      "hub";
> +
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>,
> +					<&gxclkctl GX_CLKCTL_GX_GDSC>;
> +			power-domain-names = "cx",
> +					     "gx";
> +
> +			iommus = <&adreno_smmu 5 0x0>;
> +
> +			qcom,qmp = <&aoss_qmp>;
> +
> +			operating-points-v2 = <&gmu_opp_table>;
> +
> +			gmu_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-350000000 {
> +					opp-hz = /bits/ 64 <350000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +				};
> +
> +				opp-650000000 {
> +					opp-hz = /bits/ 64 <650000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +				};
> +			};
> +		};
> +
>  		gxclkctl: clock-controller@3d64000 {
>  			compatible = "qcom,milos-gxclkctl";
>  			reg = <0x0 0x03d64000 0x0 0x6000>;
> 

