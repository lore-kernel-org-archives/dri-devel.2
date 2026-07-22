Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78568C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D6710E480;
	Wed, 22 Jul 2026 13:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pismn3qJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YDH6/KvL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E93410E480
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:44:21 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MDWZ8K974008
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=GIYdoPwmlp7SGGM3Zke7zv5s
 UTlikc1HJ43uNZXOXg0=; b=Pismn3qJPSfTO0BiitkZhgBvnpO3ySI2znI+O3ZV
 Ov3IyKoKlZumsAOUsdIKT4xFm0Eg15T5GjXaI6xf+22/7z4HgV+ojKmiHTvWqsrP
 zrwxvHY/3stUpZ/uVvgsMPufeuYKJTesqIfcpLZ7B/3eJiS4Xoqn/YKK93R7MeHc
 33coLoq+RliTOVxCrdMi3Y4MKZAHBvAH1xAh+FbniqUBWqpLD7XJl0RfNeKi9QdD
 E/RkPm3qgoWpVZtwgKzmCPiD3M+vIo/ziiG2fe+gv7x6A+BupKHFdEppwEsBgqQ1
 uzB3nlbwfO9VoixGtzXCDoRnB4r3TLMyvtKtqy7KO6C1rg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjuu78rxq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:44:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso158467531cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784727859; x=1785332659;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GIYdoPwmlp7SGGM3Zke7zv5sUTlikc1HJ43uNZXOXg0=;
 b=YDH6/KvLikBuhG1ZVh4kmJ9AG+P/SYd3/MGSwrvF5bcB6PwFXFjv6Kra0Bj+gPVk1+
 5yFE1VLHYDrn9WeYMQiuAsAnyXHvBTmDBbMFhwNv0IMegW1Nc80CX0ZTA96YgJ9VdCAW
 T7M5fj4EXS0Z84ZKvIv9TNqWE9Ho7KGFb4RpxqyjkI+Ct/vtmTdW8VE189cCpjxt0oEg
 qc4o/VzvrO5TSMVxzwXec+2VeEPLwGCxw3Jn3OrIObfdiGae0YN9vty8dFOuy7L9vPqt
 o/5YZUADKn6PM9ek2+RUCsamN84VHgAWyo0ktqTcrTEeYLi9S/51S4jY7zJYuFdrO2A0
 DUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784727859; x=1785332659;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GIYdoPwmlp7SGGM3Zke7zv5sUTlikc1HJ43uNZXOXg0=;
 b=RGcKfSdiABPkqs0+JRL3k7awI/qmgvaUfGnAcH9wGt4sC+7CcAnr8i4KIZI3bDfIsf
 8riaRRsQhcpAMaczDkR9OMUgiM43Xth71ld7EZ2QI0lo9vXnWy805p3/X5+EE8E4VC0L
 EJaavsEC7AP0SjI6qNgY9pnw3WQp6hO4CdnNkLLVLWlSvKGZbyZx6UT7NQjwYpFwgbgp
 kzDA+dDVeWwJ8P4P7cvHpt8pdcxQRZYec1MA88h0bVWr6Mf0N2j1bdYmyunT+XS07AvQ
 Ja++//6k4prbzP8QiMLhMczWTkeed2BOt+5MCh5fVIgQi4nQLZL5BgJ7rd1oCCx9Xz4M
 /IEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrujMPIzRdjHSxT4ZlntClJ18ZXBQbIlsYsGpFuZ2CMlRgjsrqPAUyyF2DXBFXTNNlVseoIcmE1AOs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7vrC7w8eK3s0h9z5eN00GAqKUB1N2Mxq3wevUTsKPeViC+Ja+
 C2IyO46WMxtfgYQo8bksOVP4flKkNK9AnJb9dsp46GE4Pz5Y9RaeqAQQ8ouAnL8nEYDLB3uHya7
 ggXVkC28DatbpC/3pDIudwSNCXhIeKnutnp0weygYqWHjvDi4ErSn/L2LIjKjo5ZjeXYCeXc=
X-Gm-Gg: AR+sD11ZXfVS79kT3LSHWO1l9KWF2OSUSRH9We3lAKlUu+uCvLuWDXXtBFeUiOLLOmB
 S8acd92yUWfcTlBJQ45jfdwHKXcLMlP8q/s4ITUIY7xsXyQ7qpj38KwWwRe17058Kzd128f+kso
 Hh3HE7pHEKwS5QSEWJTFXmvwXa2cRVrnYPJF8P40eTk7MlmMwUFkGMzrD4Vuur2FJRR3jiHP8G2
 sQ7SNBuLjbJ8aO5iGbe1/xxdXkAImWLSlw2s+1mY9RuWSDdHxKu16v/ZkDAzdHeRFCitvkU+o7Y
 Bk5uZIXiYwpoJfOg0F1XM3FFQdnrH0iAm1OsQoMWAzA6MDWf5C+RsBQ5a2okjZohrLeLWckrNw5
 Lk8/JUd9EE6uebkmjWh4nTTJWihVuFeCwgq+3OrNSJYjXVF56eXCE5p816GtVue8jOVCg6OdJ1K
 OFpF3MPdi6XT7RNQ==
X-Received: by 2002:ac8:7d0c:0:b0:51c:94f:8ce with SMTP id
 d75a77b69052e-5213c201a70mr211249441cf.34.1784727858367; 
 Wed, 22 Jul 2026 06:44:18 -0700 (PDT)
X-Received: by 2002:ac8:7d0c:0:b0:51c:94f:8ce with SMTP id
 d75a77b69052e-5213c201a70mr211249091cf.34.1784727857758; 
 Wed, 22 Jul 2026 06:44:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9f4a728sm482968e87.75.2026.07.22.06.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:44:16 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:44:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: lemans-evk: Add LVDS display overlay
Message-ID: <b2pbwtqd5mf5d3sbbadx3e5o3ohys4mmjv5dxc3grycuuqjvgg@rh5veftljlrt>
References: <20260719-lvds-support-v1-0-1f1aca3213ba@oss.qualcomm.com>
 <20260719-lvds-support-v1-1-1f1aca3213ba@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719-lvds-support-v1-1-1f1aca3213ba@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: JoZKn6CIeS648RYCL5DkqywJ46ayWeqL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzNCBTYWx0ZWRfX+vXhy1mgPEBg
 95A7dhJ/S3Ubu+LBuEPg/f9ZYmVSj8Cyh/JOXBIdMg87ECVhHiiI9WapySAquRLqB/7y7Y0385D
 OlT/FrQRzR5IWASgYqIx3z7Yr4oDDE8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzNCBTYWx0ZWRfX2o1RztePSlnB
 2MmsADvPfw2EE/5nn7YKxduGZuyfhRl/11fVzOl/g52kHzRslOLfRwn3Ok4n9QpVss21GJkjbnu
 m4HVk8t3VcILB80P15JkzzgvhRyin0KhlIe+L1TUPUQmObv1zhqPQuef5hNl/XzGDYK5XNKaqhn
 RPjB4QNk+NfLiddZs09fZ9bfHC8CYklW0PuO+wgQE35+yzX+N1zOLG+wVcYufCE6HcwAkh0yC1d
 0teAcjy27T90ukuLynO3iGx+ZNDSVU0UUFufmM6tKF9373e92IUDWsj/i4MBf7T6RnR2DXNIGpH
 PyDwc+2kpvrFCEqWwmNjNmi/icMOIRbEWkU3DHBTat2KL/uRiqFkeUqsZYXjHDtKT4oK+1PTY4Z
 wb9rQ+9DPSGn1xVCjt/8KrQMKTTno2Euetg9E5M8wGT/zA1y6E9svJdARuB2bMbQSHkEdKyOB97
 kJ6oRnvu8D3IvjK7wUw==
X-Proofpoint-GUID: JoZKn6CIeS648RYCL5DkqywJ46ayWeqL
X-Authority-Analysis: v=2.4 cv=JuTBas4C c=1 sm=1 tr=0 ts=6a60c933 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=hb4hLJ562k5UIXpG1yUA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220134
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

On Sun, Jul 19, 2026 at 11:35:06PM +0530, Vishnu Saini wrote:
> The Lemans EVK IFP mezzanine supports LVDS display output using the
> Lontium LT9211C DSI-to-LVDS bridge. The bridge is connected to the
> DSI0 output and drives a dual-channel 1920x1080 LVDS panel in
> VESA-24 mapping.
> 
> Add a DTBO overlay, lemans-evk-lvds-boe,dv215fhm-r01.dtso, that wires
> up the LT9211C bridge on I2C1 (address 0x2d) with reset on GPIO37,
> a panel-lvds node describing the 476x268mm 1080p panel timing, and
> an LCD display bias regulator supplied through the GPIO expander.
> DSI power is provided by vreg_s4a.
> 
> The overlay is built as a composite DTB combining the base
> lemans-evk.dtb, the IFP mezzanine overlay, and this LVDS overlay.
> 
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |   4 +
>  .../dts/qcom/lemans-evk-lvds-boe,dv215fhm-r01.dtso | 127 +++++++++++++++++++++
>  2 files changed, 131 insertions(+)
> 
> +	model = "Qualcomm Technologies, Inc. Lemans-evk Mezzanine Lvds";

EVK, LVDS.

> +
> +	panel_lvds: panel-lvds {
> +		compatible = "boe,dv215fhm-r01", "panel-lvds";

Thinking about it, does your panel have EDID? Is it readable from the
device via the I2C bus?

My major concern is that if the user changes the LVDS panel, they'd need
a new DTBO.

Would it make sense to implement EDID-based handling (like it's done in
panel-edp)?

> +		data-mapping = "vesa-24";
> +		width-mm = <476>;
> +		height-mm = <268>;
> +		power-supply = <&lcd_disp_bias>;
> +		status = "okay";
> +
> +		panel-timing {
> +			clock-frequency = <148500000>;
> +			hactive = <1920>;
> +			vactive = <1080>;
> +			hfront-porch = <88>;
> +			hback-porch = <148>;
> +			hsync-len = <44>;
> +			vfront-porch = <4>;
> +			vback-porch = <36>;
> +			vsync-len = <5>;
> +			de-active = <1>;
> +		};

[..]

> +
> +&i2c1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup_i2c1_default>;
> +	status = "okay";

Empty lines before the status property (here and later).

> +

-- 
With best wishes
Dmitry
