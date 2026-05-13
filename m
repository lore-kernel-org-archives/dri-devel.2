Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5ECCD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 16:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD4910E32B;
	Wed, 13 May 2026 16:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OKhBglmb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PONBrUb5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85AD10E32B
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:51:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DF8glB2888316
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kvW9MFUmG8rvh5PNkmsY1wyy
 sIDeA/uWWz+EQKpqk6g=; b=OKhBglmbyQEX6oq9vBhZaGVssws+8Oa4lvLJQKfB
 4FEJkO4YRuPf1HRAdUShy1fygbwX1pfjz83GjEUwa93LLuDPghfBuLMvFuTG2SLD
 +65p0KgExqbkudiKV2L3KmrxwRmWK6rQVhZrlmOeYqa2bWAX+GcJA5dtB8wV3MiC
 GnZ3NhJtQRhAf+nKH6KnRWLrfB406qwwwvtg0i/brx3tQ7mz47ZA+FOIjO7TZx4I
 4kb1qi66BpS1Ytc8S25d0HiTqTyte/pKRc0O9kDA6FXxAa/VYyTTRoUVFDq585jX
 2c4sPuGmX84QWsN5ESl9w2jikrBUf0wOO+0tNGV5gplOaQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p4ghx3u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:51:43 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-634ce585b41so2068730137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778691102; x=1779295902;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kvW9MFUmG8rvh5PNkmsY1wyysIDeA/uWWz+EQKpqk6g=;
 b=PONBrUb50h8l+3mAN/FIEc5Xa/PEkz34LG3Yxc+YYCiMTdNDqhGC1sMymiYD/yqFWN
 amVhTyJP9Mrz9SxA413ryBmtE/jP6TdIpPEtzzF04OaOfltkgGF4Y6aezpdHRKm/ObxY
 bJ/ULpTDjcRWxxWop15ujWAz90GnoaN46oHtxd//74Yfa3QpsTu9yMWOTTHGCKfKIEBD
 ItG8MMLuZTUm/lW4J+06siAyZcHCCJdBGCZDgA8JQegqoSIIO1EesWFHxh5N6m586BDW
 tl23/OygYwOH+vZYN70G/oxfSEG1SAYH2ul1qt/Akok4nkxYdPvvqsmxMVSLKCT0+HF5
 tUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778691102; x=1779295902;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvW9MFUmG8rvh5PNkmsY1wyysIDeA/uWWz+EQKpqk6g=;
 b=rMlOhTFkhCVq85MBfesvVSG+gT5WysYdmG3FtN9pDP8S1J4EEu30Pi5TaYTrwc2Vxw
 h7WUAL70yVz7jLOAFy0oIuMiFXYlGIOSYlpTSYyd+UT33HRsCLJzwTL72ld1tdCwgSz5
 OpcrAtlMKhpi7ZN3XCPFF3IN1e2YuQQuWwiZTqmMRCX3kp4nvbGa3VlUlXVTNktrwaya
 GkzH3A1ZWfrKkqEHjaAlgYIbozGU3TC1F/1Lc78OD6vIN8pW3+khVNy1iDuI8N0/h4f1
 ZD2/UvuzFx0KKvFXXe0MnQB/oby4beg0rfjMgGxP0y8MZPLWO0iUHXiY+6vDaWJW+4aL
 Zp3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vXmPZUVHyrccZj2IYTb5ZZI+NaXNkAR0WigR0hGCFmOw3DfIxRTRKICcabeuzxMZmPDToamNlS64=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWfs8MsdG89JqUs4ypFjqL01oCdsGXsGKkKWz8xpyIOHQpH6Z/
 bpx3OLvzLaPGbbtEY7JL5tD2ViGPP+B/CEX4s1EGnOq82b+70tztu0UkY+QvDR4O9dtvk6ftl7+
 s9xW0gOAr2/s6Slhz7m75iwEF/jed4JIlDPGwKqjUFRERR1sShyTMagk/WVbDBffSK4vs/Ok=
X-Gm-Gg: Acq92OGGyHgOK+wg7qHZQOBKTmIXLD35PM0Dw7xv8mLUC8BJNQ57v0BITgfpAV0wMsV
 Bodje/wneqXAoBzPGbcijDd5b7s75XHGqFKFcw7BBocO3NZKUhN//D5JRtIzZZ4++gyImOAMYqx
 espPWhe5ZAEqaeGAx+4gjTvopGUFpBJnd9q8b86+688KVfbiNZ9zHtHjqYsZAbEFAPat3+IyDnS
 R8W0hWa6MKRIX9r8sixfDk8evj/3xDEvxRbevJeXH54KiUouZeyCMmOt+Pzj08N5unlkHqSljVF
 3Z2y7eJ4EjsnLLZwnm9Tj7es746qTVA53ctWh8OP1Hmq9SHplHrqLlylrKBTJ9BFuMkD213UbBz
 fbI/N6pFLnFr44pu9RJGtpriVhanMO3TUOw9kFu1gL9Vd0LE3U9c1CTbUYowNVD9ztUFznEbvHE
 c1G8de9p37zE1wABUj3p1LHoahWuWI1jPlKbg=
X-Received: by 2002:a05:6102:358e:b0:631:7781:fe89 with SMTP id
 ada2fe7eead31-637728ca842mr2437812137.7.1778691102142; 
 Wed, 13 May 2026 09:51:42 -0700 (PDT)
X-Received: by 2002:a05:6102:358e:b0:631:7781:fe89 with SMTP id
 ada2fe7eead31-637728ca842mr2437801137.7.1778691101711; 
 Wed, 13 May 2026 09:51:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a955dfbfsm4156067e87.46.2026.05.13.09.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:51:40 -0700 (PDT)
Date: Wed, 13 May 2026 19:51:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Qingqing Zhou <quic_qqzhou@quicinc.com>
Subject: Re: [PATCH 3/8] arm64: dts: qcom: kaanapali: add the GPU SMMU node
Message-ID: <ergnufuk7qx7b3xsccdifdhlwfoxka5k4y6s72zpqvcfmv4uxm@brakkpiqkqhy>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-3-13e1c07c2050@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-kaana-gpu-dt-v1-3-13e1c07c2050@oss.qualcomm.com>
X-Proofpoint-GUID: 3hZsQyb-ruA9CCoXi0ZcW2Hk7VaInYIq
X-Authority-Analysis: v=2.4 cv=DOS/JSNb c=1 sm=1 tr=0 ts=6a04ac1f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=54KNg95dvv-uSQ5X8vIA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3hZsQyb-ruA9CCoXi0ZcW2Hk7VaInYIq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3MCBTYWx0ZWRfX+sld2PQmZSsI
 VcXtWgG0JF1NXjoRbfm6Oz8Yx01746WpYqgBqUFPnXcp2ZDgNYUDD6C5zFp87OZ026h+Zzt+87X
 5om8pimB5u48LXZdVdu6J8P/G9GH5YlWr6261fvh7jnWCriG73iqDQxmVm0UdkrIvm9iRlTeGcX
 wlO8Xc6yqyC0CHYeW4t81FsjvVmz74XmLBsFyh1TNM7u4eBtlt+2ACW4VK4thFbMaG7dKNpJFa0
 9a1AbktvgVolSco1x1A3YejDKaCqoY73lttzp5l4n2u2PqYDazH2rHnQBaDZhmcLL2ivS6OUcHH
 SW4fN/hFEtaQ5UEMijQFMscsNzylhCith8m5PcfGh9xgxDqauTSlhqJfj0BXqDimeThES8eISws
 RhuTVc4NtaF7BVRBwb61/i46fakbdl8l+4RBbfiMhUHQ+EGbSky3Yoz3aCayVLOdQArfWk2smh8
 98lJEmnTt0QC6S4dY7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130170
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

On Tue, May 12, 2026 at 03:53:17AM +0530, Akhil P Oommen wrote:
> From: Qingqing Zhou <quic_qqzhou@quicinc.com>
> 
> Add the Adreno GPU SMMU node for kaanapali platform.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 41 +++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> index bab654bbd6d0..26a4de9c8d45 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> @@ -2597,6 +2597,47 @@ gpucc: clock-controller@3d90000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		adreno_smmu: iommu@3da0000 {
> +			compatible = "qcom,kaanapali-smmu-500", "qcom,adreno-smmu",
> +					"qcom,smmu-500", "arm,mmu-500";
> +			reg = <0x0 0x3da0000 0x0 0x40000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;
> +			dma-coherent;
> +
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> +
> +			clocks = <&gpucc GPU_CC_GPU_SMMU_VOTE_CLK>;
> +			clock-names = "hlos";
> +
> +			interrupts = <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,

Please align on '<' symbol

> +				<GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,

-- 
With best wishes
Dmitry
