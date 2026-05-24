Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E02CD5BAB
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 16:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF7A210E379;
	Sun, 24 May 2026 16:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SIrnan5g";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S0fQvMEj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A22CC10E379
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 16:38:27 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64O37PKZ2667606
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 16:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=VXsbIGfE/YGMhTf/DNGAiwi0
 TECdbjhbag3+7cTDv9k=; b=SIrnan5gB1jAJWsSJPjwGzlEU0sRG+SUfFPAS+dM
 PO4mUtGh7aP2yIIRTd/2B983/QN26DJ4MFUOzvmlHzPKXfr7TWI3r04JceRo7MuK
 asr+XPAbJwqsR9JoXb1sNnqoH7v/O6boHetmm+IB8tE0H5bYqFXCLIqp1GyS9Yk+
 ZdN1MBLNDIhfMxLqWNEgpiHk/L5ZL93RRpqrxFTdfNnlnj4bgjoWh2bJ0WlP/45f
 VXPARvsqhPyRPf3bB4FtRVKtXw0+9veBnNddzIpLGu0f0vKN3XR2lQF+VAkvCd0i
 3DN9IQoMugg9yW7WmUKj53uzvsfoz9uk6TOri7PIF/tP6A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3bjrh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 16:38:27 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-63cbb164b37so17950258137.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779640706; x=1780245506;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VXsbIGfE/YGMhTf/DNGAiwi0TECdbjhbag3+7cTDv9k=;
 b=S0fQvMEjXc/IXLh1o6yfUXsBjJjx2XkAeR/QYXujU4/fpnQUON2Ae3wrzqXCAZkJQF
 1B1Hevo3XFgqTD4n1WxA8fBbG75GRLLUMLK+5YOBXN9Zggb8jI7kg2dqdqKw6wGgUtNm
 TAx3cmncJF79l4V5P3nmKeKY8cBOs9EbFCkwH6PTyfx2pc2AEQl5f6pjh+7pQ3EaDoTg
 +roec631pO/oXNHqcEpHwxfXDA7uyCWN3WLpGA5ug30ajI+37johl8l8bwFhAWPThxaj
 gRl/bIgN7hd8awk9MmjxsE++l8QQw5jRjAo3z/mVaKl4I4fJ2Nqr0xrdABZxzKoPqdyg
 ts/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779640706; x=1780245506;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXsbIGfE/YGMhTf/DNGAiwi0TECdbjhbag3+7cTDv9k=;
 b=XV7jZc9DJxXMqGxBnwB8F5bGC3GJM3XZDGNRTyx/pFeZn+D2/Jz5PGvz576FTFTjvI
 maCJP6XNT4QncNWFSCP/IKjhIgkqeXreB/RFIpx8sRuzDS8gS3ZIV8Hl0ED+TNWO2LQe
 ZStzO+m1QO3ur49KSqX/hS7o9w1EgDTuZe94BGo+CBH65npyLjXZ1n2g7ajF8dHVEU7a
 Ry897c2Ekn1uOYSsit2cbgdB0j/B6F4cAp8gA48qx04MKgGi2dBVkNUsN4+PApNz/Ccv
 f/Yi4Z0UdjCJ6QQp4+Zk4/e8usiOmTbfhnHkXPL3V4Asdh9E7x9xZQckpAJNE9g1akPP
 s/5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8H1SKfQugFAKVw8h4+WOoDYlWs9KGwA5I1IzsOSoDacqkIHizkMTj6Wn1NB6zQG4BARrGcKRVoDpY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWWZlJiHezD0KveHFOeAifedEraFQp8umGYhOpw+KCQKDvWo9W
 rMnFpdY5ztGwWQ1yGJxG/phlAfH2Bjk4FtfKJAx9PNao3j4UuZv2bbbFgmzrExUksccU3o39FpK
 wdS+WH5B03kCSuJjybNE6mro0TutmPe756AoDiUsr9/Yf9g59VmtsE6XkXkvszWXOkTVQhlU=
X-Gm-Gg: Acq92OHBY9f3ZHDta+G1hEFjTnF0fxjfwnO+lush5DmbUVfnyEsAulcONr6cMpwT9Hq
 zMczjgj1qkZ3qYl1FGFpV4csF0LdZAjCBC/kIdoDBWt4MdGSLB3r6GNRYAeSxwGpCOWzoa1YzCT
 MqPRScfJQCdkGK6nx2UY7mp1X+ZWs2pCQAbiDOlB03thNbt6eBnXxqBIf/CeMte2kKTa/+Pbm2G
 AsGntO47X2IXtIcpfpAdvD7HE0ph8uSEwo9k8PepEY5/TE7zA/16BSs6CyC+qezX7fIzI++skaR
 Nu3Fip2M0qRIGuU1FYMmfbHVnT6H2+8mDUnKxl56MMXwalbxoW3qtopzCOhiYCqmsOoAmgWOqIf
 d7XlD6r6hvPW4PM6x+gMRDXisj16pVfa4E3WWS1FT/fzOQr+XvE7X/9MkGFcKhgiyLOrPgG50T5
 V9nHnMQ8ymzDhCAKG3PIUtsr5LyMZ8Zljdu/U=
X-Received: by 2002:a05:6102:8641:10b0:631:9366:da89 with SMTP id
 ada2fe7eead31-673c31671d9mr4237846137.8.1779640705983; 
 Sun, 24 May 2026 09:38:25 -0700 (PDT)
X-Received: by 2002:a05:6102:8641:10b0:631:9366:da89 with SMTP id
 ada2fe7eead31-673c31671d9mr4237842137.8.1779640705537; 
 Sun, 24 May 2026 09:38:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cc08c0sm2020669e87.36.2026.05.24.09.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 09:38:24 -0700 (PDT)
Date: Sun, 24 May 2026 19:38:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Graham O'Connor <graham.oconnor@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] arm64: dts: qcom: qcs6490-radxa-dragon-q6a: Add
 regulator supplies and disable EUD
Message-ID: <hwlkksr2nbarur6n7i7gt56ghhuxxscaey2idff75cx2sthsqz@cd52yzmhyybp>
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
 <20260522060645.4399-5-graham.oconnor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522060645.4399-5-graham.oconnor@gmail.com>
X-Proofpoint-ORIG-GUID: oH5du9VWNsc3Mev9y1da6-P3iys4rBDb
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a132983 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=xsPyQ2l8_84pY8PHn1gA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE2NyBTYWx0ZWRfX6cr16HApya0B
 lmRcnsKT6QQir40pIhWuZ+67VHA3FNpPPfmrmr9o/HlRnaMT9o81WVDFwwo3St8o69zjuQ0I1H6
 QcGnWeg/cl6gvNhvVPVmRMNPyvdSWrLZzFZNPkTfab19kv8UGcjyvd805JBBevJq6txRI6NKZYt
 6OJpzYshKWQ7+IzrvNQC2P1X0htK7DPAdVNWEC1DojivZll4bfxa8/BwGTGCFDFhsk+Kne/5Gmo
 NFd9w4mDExNn4RkmFxxsVJKf+lgKbjSvRtEzXejLPkmgdF8gIVh0HCpnktMhi8QzbkvhcD8zOl4
 8fUvuxqNCfK5KBbNIOcyJTd67sJWHq6xEFhWClOWTHTnFOy0xI7YcvC3VM17mK10Ud0INKsexxr
 Y86oBZNrgx5rMGHecC97uhIOc4XNyiQY6h2aRs2osN+eJ0z4gkq/l8hiHDsUeAw5aEvXwiNGzAk
 LvJw5gWNcNKw0H+72Yw==
X-Proofpoint-GUID: oH5du9VWNsc3Mev9y1da6-P3iys4rBDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240167
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

On Fri, May 22, 2026 at 06:06:43PM +1200, Graham O'Connor wrote:
> Add missing regulator supplies for qfprom and the PCIe controllers.
> The qfprom node requires vcc-supply for correct eFuse reading. The
> PCIe controllers require vdda and vddpe-3v3 supplies for the PHY and
> connector power rails.

vddpe-3v3 is a legacy property for specifying power rails for connected
devices rather than the controller.

> 
> Disable the Embedded USB Debugger (EUD) as it conflicts with normal
> USB operation on this board.

Separate commot please, with the description of the conflict.

> 
> Tested on Radxa Dragon Q6A (QCS6490)
> 
> Signed-off-by: Graham O'Connor <graham.oconnor@gmail.com>
> ---
>  .../dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> index bb5a42b03..4003837ad 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> @@ -1093,3 +1093,23 @@ &sdc2_data {
>  	bias-pull-up;
>  	drive-strength = <10>;
>  };
> +
> +/* Provide required regulator supplies for qfprom and PCIe controllers */
> +&qfprom {
> +	vcc-supply = <&vreg_l1c_1p8>;
> +};

Please keep the nodes sorted.

> +
> +&pcie0 {
> +	vdda-supply = <&vreg_l1c_1p8>;
> +	vddpe-3v3-supply = <&vreg_bob_3p296>;
> +};
> +
> +&pcie1 {
> +	vdda-supply = <&vreg_l1c_1p8>;
> +	vddpe-3v3-supply = <&vreg_bob_3p296>;
> +};
> +
> +/* Disable EUD as it conflicts with USB operation */
> +&eud {
> +	status = "disabled";
> +};
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
