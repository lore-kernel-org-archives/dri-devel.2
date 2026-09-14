Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131BCC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D5F110ED2A;
	Mon, 14 Sep 2026 11:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V6eXEJqa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UTdX5Pzz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E237910E492
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:22:59 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EAm1TE727675
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 htoucfNJ1NBOznj2ucEtPoE5fys137bATrwbrwYNEEg=; b=V6eXEJqaW52sruVW
 KmAWqHedQKN92ge5YENWkiPjd+G4FUiYoi+rXuXHOXCHct/s2ruBO47fL403iyAH
 2SylfxfndayU9tuNs74mBf0Xj12d3kC5/2MhrMELYG8moOkZhHp5DR7YyqO0kNHs
 0Lw7qkc35AhQS+AgFCbu3IoOaFGpMQF7HP0nvezpOH9EjkcQG7/eI1EGSaOHqhHE
 tAFRbnOZo/0zdY6LMW69aKrcmdFxfdNVAuR98oQs9x/NZr3V+VuTPtOnn+xGBeb6
 5M5JFDIf2VvoFSBwfEjJixhhuEPdxOYVn7knVSt6iSa8pTvUSJQzCq5yrtQwVTO8
 3nO8Vw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdb5rnqb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:22:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-912213ef433so4391206d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 04:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789384978; x=1789989778;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=htoucfNJ1NBOznj2ucEtPoE5fys137bATrwbrwYNEEg=;
 b=UTdX5PzzRu4xSPOs+7AHu6AL1ogPtOz06TSwNvtxt3ZBJkvsI3QtPfaLRMObLj8XRG
 tjCQsDpWhN52oPnk02y//os9zs73bQP3TRvgRdAhNyxKLxqVHyUP5Le0TSJ0z1t6O1LH
 ti01bvUfsrlBK2KttI6tgx+k6CJwvAhbQEoWU+TK4hh9FRPRwAupOhO2ae8x3xjWkDBW
 O2LP7Lsu+t0h13HQSkZQOYR1OGtRuTUDlVq+H+EY70M4NPpmPUA0LLVtpu7E9Ya60W2E
 fFh8ZfD1zxXq+9RQv/T1RRRu1Ra24rUrmurKjEtZSsk2waxvCTg7LYVYY92dYp36jHWd
 8Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789384978; x=1789989778;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=htoucfNJ1NBOznj2ucEtPoE5fys137bATrwbrwYNEEg=;
 b=FcWDWxQ1DKnmQvTJkwD2359ahg/LiGsxTLbSkntT9xm2DyK71+i05H1CxdJNxiN2Zg
 lzdcoNb24WAI+pe+RdRY4AlNwjmykedZZtZrJAXrodYDdGtjV2oSywiHTzv0x45WYQu8
 JZj1Lasl41LYcey4vRpx4C/dg6j996IrG1lds9YYKPH/wQJJ+yBDFfwcyD5tL3LIFM+w
 nXNTz1fWkwDl8d/Gvlt/tjsA7hMhnhdmmJsnPfvfnWCYsbojs+x5wglQBkqUxo3F+jA/
 /1KeZdVCGIVcSh7eC8MhFcYjRCZW/qeqVqQED4TObxtWAGxznTL5q9w3oN5OgxXF9RHs
 OA9g==
X-Forwarded-Encrypted: i=1;
 AKwUvByc1K7ZoacWqqgtQT8kXuPmaK4YGsgADOPs64PbhYjpleQLctyj85QKuruJ2GwL0EE+hrdd5L3Rrnk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kMCjB191tWbFeajQcpp9SnCbrjDM/ZnMcp0MvFLGfN4yuaGS0K
 d60FeZX39iowp1NABpn3pS2O/B0a/oEL+ZFlOMyXXRtV8IJYSYwZTlRbMPqrZvWCJxKUYvjf4P6
 wqEkBsWF57A44VKGos6BY/kshL6HThoj6lAHecUptA4N0LnNpyyit+cH+gC6kH0Do/17RVNo=
X-Gm-Gg: AYBFou2s/dQ5FMVqeVTJ7k8y4DNoxsYsXAUsh4MCH3sxkmphThTC4D081pfXn6485Tt
 +Z7v+y+x45dHqz08QAWSNEDJfbcaneATZ5yWSyqHk9nDLA8xWUA88IFqEMacyTQpE3+zxiRgoq2
 sAhNXHzlF/DWY122tP53EPaPKIOupbIXObrJmaeJfdZnpH2R+CTJjjt9a1wLTx08yFw3ObYuj+L
 vSy7nneb0c0OQN8fI2Yn7cWjlzzo1ZeGBONRquIBx/kiRMhvUtqwvi3/p1oLazbmXiCXbU9FYvk
 qQyeZqXOeLLcnHOPfZ5zVfs1SlzSz531/c8qgLPXG6f6g62UzxPar0fqSPQYQbF9u+Rpaz0fsjX
 Sn+xrVhdhIsjg5F+nucQnDw==
X-Received: by 2002:a05:6214:4883:b0:912:1f0f:b204 with SMTP id
 6a1803df08f44-9122e4ccd58mr27340486d6.1.1789384978170; 
 Mon, 14 Sep 2026 04:22:58 -0700 (PDT)
X-Received: by 2002:a05:6214:4883:b0:912:1f0f:b204 with SMTP id
 6a1803df08f44-9122e4ccd58mr27339976d6.1.1789384977653; 
 Mon, 14 Sep 2026 04:22:57 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9b594f0fasm4216719a12.25.2026.09.14.04.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 04:22:56 -0700 (PDT)
Message-ID: <d0d7e3d0-15bf-4850-99ec-44d429c6bae1@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 20/20] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: muzafferkadir@mainlining.org, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>,
 Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-20-0e742578b524@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260912-msm8952-initial-support-v1-20-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX625NodyJiFkD
 jzZmsd3IaAkoOjrQqHlLFS8YSR5Fzyivda48i4QZAxhRhur4GxAyGEICkHa82YTyDywWSscHDOV
 Ni7kwVjPfCmTl9r1TfWsnVaWiIu/Eks=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX9v9vy0wX3eRz
 Pmbu+NNrgS3gWh6lcH9RCtasFRYmcl9Z/DKT13sHfFM9HosGn5s+AaXxqdGuknW2Tj7St/n3w4P
 I4GteOz+5/HYo4qRFImJny3rNGczw2C6AY4f3MoCRYcZ8PgORTKoHv9+PYrGxbum32rN1SQfBkT
 2gRhN1DKm1x/EhAhbQ/bHu4FkUsYozHVJ6UJkqZozx6fkftHM84HVeYNLLOpQeX+/Qxp+XZYKew
 COEMjvl9WElc6zCqqKKgZYYHsLqbv9eknyhkQgg1Kt6PEKQo9JHmLZKvdlfciV4yN3Hhu7HURtZ
 Y6JDmA+ms2itpu/pr8Ynkfv7+JVTuXKxFR9yittF5XX82mO0j+J3REQAsHQcs3e2g8uqbmkxbky
 VUK20Haq6FM7ZOaQIRxm/a3AuLDNhoQxUYPD9EtgmMrjm+NVwoGyjeQ6cK+SXi8dMKeWj2ygpuv
 zp6DymXryR6Z+E9YNmg==
X-Proofpoint-GUID: 8aIreF3Q0q1wfLV52KE3GT_KD3ga8T0R
X-Authority-Analysis: v=2.4 cv=Ie4Symqa c=1 sm=1 tr=0 ts=6aa7d912 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=OuZLqq7tAAAA:8 a=orgwjQpZXFS75ENpSOkA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: 8aIreF3Q0q1wfLV52KE3GT_KD3ga8T0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140161
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

On 9/12/26 10:39 AM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add General Mobile Shamrock (GM 5 Plus).
> Shamrock is designed similar to L9300.
> Downstream reference is [1].

Please feel free to
wrap your messages at 72
characters, otherwise they are
a bit hard to read! :D

[...]


> +/ {
> +	model = "General Mobile GM 5 Plus (shamrock)";

It's not any "policy", but other DTs tend to only put the "pretty
name" here, without the codename


[...]

> +		framebuffer {
> +			compatible = "simple-framebuffer";
> +			memory-region = <&cont_splash_mem>;
> +
> +			width = <1080>;
> +			height = <1920>;
> +			stride = <(1080 * 3)>;
> +			format = "r8g8b8";
> +
> +			power-domains = <&gcc MDSS_GDSC>;
> +
> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_MDSS_AXI_CLK>,
> +					 <&gcc GCC_MDSS_VSYNC_CLK>,
> +					 <&gcc GCC_MDSS_MDP_CLK>,
> +					 <&gcc GCC_MDSS_BYTE0_CLK>,
> +					 <&gcc GCC_MDSS_PCLK0_CLK>,
> +					 <&gcc GCC_MDSS_ESC0_CLK>;

Please align the '<'s, make sure your tab width is set to 8

[...]

> +	multi-led {
> +		compatible = "leds-group-multicolor";
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_INDICATOR;
> +		leds = <&red_status>, <&green_status>, <&blue_status>;
> +	};
> +
> +};

Stray \n above

[...]

> +&ramoops_mem {
> +	status = "okay";
> +};
> +
> +&adsp {
> +	status = "okay";
> +};
> +
> +&lpass_mem {
> +	status = "okay";
> +};

Please sort the label references alphabetically

> +
> +&pm8950_spmi_regulators {
> +	// PM8950 S5 + S6 = VDD_APC supply

Let's use /* C-style comments */

[...]

> +&tlmm {
> +	gpio-reserved-ranges = <20 4>; // Downstream doesn't use 21,22,23. 24 is mdss_te

Let's keep a \n between the last property and the following subnode

[...]

> +	tpa6130a2_default: tpa6130a2-default-state {
> +		pins = "gpio61";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +		output-low;

Drop this property, the driver will take care of it 

Konrad
