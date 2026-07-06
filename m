Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B218AC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F327B10E363;
	Mon,  6 Jul 2026 11:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="psP9WYXz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BEtC44X5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3037210E363
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:07:22 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxLdC369098
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 11:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pBztFgeivDEDVCYAqSb+ojmxplpWHAAOO/i8mhVfjVs=; b=psP9WYXzjA6tVY4c
 e7rvWCUSBKLLxlaKYYldlfSj8q4wfEcWRj8z0GEpzslEP5lCPfkuOd0puPbQnESx
 dpHExnPs3jZUFkF3Qtj6ig3uQDhfh0W5LGqf+KBRZb95RDDco0i3w67KSO+AaKVA
 n1cgehAjkLnlQ//KiQS7HScVSQnbA76/tV75eE5Z7o0INDuV2vgr7DyOqtXFS7qn
 E5O7ExMLndq6u/rPHHfCpi8YSgNdg//4RILbabVAENfoj/nOPHSpNCc/o26wbx24
 s5P8arb22Ut9h7Xjcaw9TwZ3SEgi/xD2yyezhU4wYLHhkhdyHFS+rvennSmICyqv
 8A/g4Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h98qsb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 11:07:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bf9df2eabso1872651cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783336040; x=1783940840;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pBztFgeivDEDVCYAqSb+ojmxplpWHAAOO/i8mhVfjVs=;
 b=BEtC44X5g58kkyjz0HDuI2I0DBkZ1KIJgOwN73IrBx6vpy6U7G3sHC0i/G+V7DHyu9
 eKM9WC7GXvMGZ2BFOsdwGxePtp0FZTMpH0rOBIGZEY50pe59E7McT6+3GgM4UVLwQmoE
 ssrgnJ5RshNK5rwm+5FHZWVV25ThMCXzxBycYQQkGbJ2/SEmFYGWNSnz4aWUSOPO2ADH
 jN171CRbaX6qPe3soeF3bU1z6Ph++IZ4JCUpVdJiJCEh0vI4MxexU5hQrb3rpbapeM0C
 huXA4L1THVNhIpmhW7WSReZmLCI+f1ZYOWX+CDJVvZ7M8rvSOOKUgISeIlrQWX5B/SzP
 45jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783336040; x=1783940840;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pBztFgeivDEDVCYAqSb+ojmxplpWHAAOO/i8mhVfjVs=;
 b=EXwuqLLG2STfgRY4fiRdn9kSEUpChRzXFlMqBHwTaGYNqPBuKvXUKs7fXpaz2GPuws
 h+TpU4ymgls7pkPJLrIYlVOi4AboawH9tRX62P0q9oWbdP8wpMcJR6A4JuGCE2/2cUNX
 a7OYF4VZnJVghtdcqHjwYPT9I8q85Y0EqiEZ2d1yKMG5YnIkSAsXlNFuG0A3QoB41UTS
 co09eT4j/ReWPkL0X48GtbHMqQ7O0UzAWq/okzZQoHpCcQNK4jpufVl2kty3gweMVpcA
 L6aA464V87HvEQt+1GF0mL1Vs1tZCw2TYmQ8gZOKFshBfLOd5tNmnzOhqmTPFxLR70uH
 FXjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSwPa83hDPInR6ba7Ca+xWUG/4cGmI7Y+76JoRg24x+ddarZ31LrdIG8M8jvuhKkFD1cwhredZlk8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPkcKUrPlsBMpSBt93VNc/wcCmvLNlwaBFXvagwxkIfz3KQeMB
 hi4sTHBbO3plR4hO0Ayg7ihADw2qbhVHIyFUmgk2CJqOAEXFa1mEfsdSz7r+KN+uSAtl2FFJVdG
 CqEevnwXYKQ3X1lpkla4LTFldjFfalCi7tunCUkQu2PHgBy9P6kSQFBMW5GYiZzE22JH5FJo=
X-Gm-Gg: AfdE7cl+oGws47EwXUo/fIwVVti2jvs2A7kkwVcZ7xcTEIop0K3cU8WFYjkI+JGKxzY
 1+Mk3Vd3r1zIPDCm3pxvSNNH83dlxHguHAT1xw5af1QZ7kUdTRc5nelqXDFDIjvzQZSL8lZrzmz
 Dkil+Vq6YlyM4LUynWm7bLGiP3CUViBgdfdnRAAqqp11pmFJxMvyJInl/TBXHmUk7M6wvhJd2NH
 h1poouocsg6xsbvk0JZXsgoT0xSQGMAmlitjJjiPqjvmRfyhoOmk6YASOr/suqi+Ze47O0RuJrS
 +/t9xlYdslZRIXcN4t75lneq83Fj0dt4jKn+GLs17RN+0wkGuNkQ1On9emR2Yyj4EdIXpZgHy5v
 x//qOI3RXHnNRKP4Dn2d07VVhvbw4ZRH+KXs=
X-Received: by 2002:a05:622a:347:b0:51c:2101:f0 with SMTP id
 d75a77b69052e-51c4bda6c05mr97022721cf.2.1783336040158; 
 Mon, 06 Jul 2026 04:07:20 -0700 (PDT)
X-Received: by 2002:a05:622a:347:b0:51c:2101:f0 with SMTP id
 d75a77b69052e-51c4bda6c05mr97022121cf.2.1783336039446; 
 Mon, 06 Jul 2026 04:07:19 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b6055039sm720881966b.4.2026.07.06.04.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 04:07:18 -0700 (PDT)
Message-ID: <10b0ad51-8766-449c-a51c-979364e6c781@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: eliza: Add GPU SMMU node
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-6-c9f1354dbd29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-6-c9f1354dbd29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hE6ZTm9gPP-FsL9k67yi4NDsiM2EYjMB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMiBTYWx0ZWRfX8W0RnGKGyROV
 GprPCTeE+UhVKB2vvnPNEuhIMt+Wjx7S8PnqQLTdcsmOsQ4Wotl7CnqaC3ubix6HzNNzJ0UIokG
 s5gcFXCFxBIrokYGTOETWPI0ypzoHyU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMiBTYWx0ZWRfX5MbpAv/ZDX2U
 3IUnFxrxRtRQsgRNycy3c+EVJT/ISQS04be/K7v26SKS6BQUgteK3nwG57MnkdgXo0u9dYTmE3E
 9ee5IK7vNwgfb0e+iPLE2PrpuXaxRhXHjvIpmfazu9/q/t9Mpn6go+5haPZL0pMiqC3ozKt/sLR
 U49kSVUoGIeqkFKEeFd4M3RpvWUVcQoXQFCQgPegV4oT/iBgVGrPvk/9ALVm+Bydy5n0a2+WZ3p
 PkPMN6uH+0R2sEVdBdMUF9kDC/n/vBpeDO7WmpBjmQhnhN8jeys70n6u+Blv8RzZDA8qCpxh4or
 uYOOulqqaylWrSe4jncT0/8GN2bJhL2wyWMjZWbul+chzQwLz2TkIZdo/eAfV9fmCcLJKUHigL9
 lvlblL+LtJS+GXeM4H9ovwG5Z11HLD2Mw1ohBJulTNzaFfFWGnn6eJxtntPlDSKigflXnqAnGrs
 sfUJ12DCL9+vWwBmkRQ==
X-Proofpoint-GUID: hE6ZTm9gPP-FsL9k67yi4NDsiM2EYjMB
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4b8c69 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=UMfccTTTTeY9HYHi3ccA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060112
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

On 7/5/26 10:14 AM, Akhil P Oommen wrote:
> From: Abel Vesa <abel.vesa@oss.qualcomm.com>
> 
> Add the nodes to describe the GPU SMMU.
> 
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/eliza.dtsi | 38 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
> index c5635f22e2a7..e5b8377e6c3a 100644
> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
> @@ -2674,6 +2674,44 @@ mdss_dp0_out: endpoint {
>  			};
>  		};
>  
> +		adreno_smmu: iommu@3da0000 {
> +			compatible = "qcom,eliza-smmu-500", "qcom,adreno-smmu",
> +				     "qcom,smmu-500", "arm,mmu-500";
> +			reg = <0x0 0x03da0000 0x0 0x40000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;
> +			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,

674 is the correct globla > +				     <GIC_SPI 677 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 659 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 661 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 664 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 699 IRQ_TYPE_LEVEL_HIGH>;

This list is not quite correct. It must be sorted by the context index,
to which a given interrupt corresponds to - the driver relies on that
to give you information about where a context fault happens

Moreover, I see that the interrupt sheet has the bug where some
interrupts are offset by 32 from the base vector, and others are offset
by 31 (i.e. the SPI number doesn't equal irq vector - 32) - please find
out which mapping is correct with the right folks

Konrad
