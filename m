Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE98CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A735D10ED26;
	Tue, 29 Sep 2026 07:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pdxl5tYh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SU4FSjJ1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B98C10ED25
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:11:36 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T46t3b317797
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DGbSxQ+ordORojocaH0U5BkUwxizVp+6KhwnNAplOmM=; b=Pdxl5tYhEsfAnRXT
 gev0v8DJT0KstEryTCVz3088i/nuuCAK1oRYjZilhwr4Age9XdTRoj8FMAqv1QbN
 mhjZXBZ9DXbDjS6qDfqHdzOSKjYvO++wHZ2odV6sWLLaa3M07Libo7ldgLBeq9U1
 /oIMNwFH5JZahpWHTA+uMzjXJVJ1SslEC719LpjkiHQdJDmec9XCWs0QmLDycbzc
 NReNLfiAt+tkCeIsmJ+9+aEUpRaQ6VD81Pdn0nUkcWzWeCZj2g+NpY3CDdu9ADq2
 R67FXj09Q1aG1SIdpDhH5VmnpXRH2rGpF/WWRmANT709B88sXCu5zkJpxeFLUw9g
 UiP3pg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyw03jq9c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:11:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a01d1d1b6so708656385a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 00:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790665895; x=1791270695;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DGbSxQ+ordORojocaH0U5BkUwxizVp+6KhwnNAplOmM=;
 b=SU4FSjJ1mx6oq5UBtzoyn0yAsoYpPnxjS/EpaVs4QTnpf0QQLUDiOI1eW1HAmGvCmo
 9pVnxUIwViMBpr3YFVg0IaP04wowPwpP/dOD8baHsWwnh2TC9z/0E3djTyYv5V/vOxie
 7rrI0IBNobEkIQ6v4EwJgpHkZCv6psDpZ7gb2NZziBHiVgnpWqVEoxXLkqcRK6kgyNb6
 I1a07tuLie2QpXG1sptJf72JNbVWRn0IB8WcqimuwciHBNB9y3wguM+XJlo3KTujjKsk
 2iR8qlv8T98v/UVjNb7hPJwqCZ7BsLatBwLAceAKde/zjhZl+SUtSkOr3VSioQx1c4+Y
 5a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790665895; x=1791270695;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DGbSxQ+ordORojocaH0U5BkUwxizVp+6KhwnNAplOmM=;
 b=VNc/QRoNhhM+wVVvMCFZyoHnKioBqeSPs4eW/ZtITEl0wDiCaN7Nw9XpCUVClHgctJ
 sTX5OrB2ShvZen5PZGrpa4vDp1dU4qDaPZq0LnrFUOpM437QJsIMJWVJF66764nmx/0s
 hkldzbpq8/W/9gKe09b7u5QdDk6PxKWWViUqRvQNQ3AyzxNhsAsfs78/ICSM9WyyqrV7
 zIqWA4RXfhmdqXq5Zkf8+n8E3FqFesDX5N5dHXZJiW50KdfPZ9dtWm+S9GIrbAUYOR75
 o+C93CR7fzGa4DRDM9UmHMXSfsYtanCo7+v28nDUW+Ik2GXfbLnIcsEBrwKH/2NdcCNo
 DrgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgzZdel3pgxLI8RmEWMAyDNAGf0p44mEE8fZ8oaZcVwyAWzF3cET/VReZEmCcdyaopVGjkyJvTRc8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ngHPKXTqmp2wtVuM+uof921Ih3/HCJ1adZe/+L2HDUEp3r9qpr
 ggT2XQbWjRRqk3QpKR9iHXGN+qAsguFAKZhWptPF7CFDu8soyVX2p4AZkUzyeoswpkTbO3VNpde
 vgO8JvEWX+S1WRp7dE2opc8OAJNEF5swDhiOglUmNYvYVX7p8QBh/7X8hVqWPznH8jCkbRko=
X-Gm-Gg: AYBFou1d1tnDjCO9coSpvdlV1jRHUTwxSAC3ZM3UfhrXozDFMKTcn2Iw0yIUcheUJwQ
 CFUILX9XAqfwTMAsHuLd9OPb7X10zKIkmXOZxXj0J5E/R3ELJkYZfCquzs2xIrg/fE4+BZlbeyh
 Vs8wAGh3xDsbdVAiN0jrwN9UF0R+Rt8VIgiD6ARjnFUYwI9pIHrmysf38sBI70j5WM/MU+VFI71
 D3a0IpFkM0zJ/zxD18Ilj7l9INzV29Euj5vQX924YgdvDkZi8GWnG3YAyBY6Vy7hojTp2ZlBhtm
 DCpv+gjmKqTkF0sB/ZJ4MGRIbE1gYNghonBG8SdvtLmACgFm+4SExUuCcVxn4yBuyk+bVgXj4JA
 0eHLTbcc3GkO71GW5EPMssv4V3KyInU2PAnLXxAq+HIiGOAbjqCyihDo87krkXg==
X-Received: by 2002:a05:620a:c41:b0:939:4b31:4669 with SMTP id
 af79cd13be357-93c43c1ea79mr2442108285a.29.1790665894716; 
 Tue, 29 Sep 2026 00:11:34 -0700 (PDT)
X-Received: by 2002:a05:620a:c41:b0:939:4b31:4669 with SMTP id
 af79cd13be357-93c43c1ea79mr2442101785a.29.1790665894123; 
 Tue, 29 Sep 2026 00:11:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7?
 ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af506fdc1sm1730213f8f.21.2026.09.29.00.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 00:11:33 -0700 (PDT)
Message-ID: <4de27200-3598-47b7-b0af-8f7acd037618@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 09:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/19] thermal: qcom: tsens: Add support for MSM8952
 tsens
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
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-16-b96fd3fe298b@mainlining.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260921-msm8952-initial-support-v3-16-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfXxnsNp5CUAabP
 jv8VWI6MKMVjAMr4KJ6hN7fJE/6L1uG3Ty10/QUFW3ElE/bqL07dx95PdRr4ZCJjOT64aCnjDLe
 3KGrx+myuMBBw+qGrG1VwSVVaJFZLnQ=
X-Authority-Analysis: v=2.4 cv=SIbXx+vH c=1 sm=1 tr=0 ts=6abb64a7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=Oh2cFVv5AAAA:8
 a=OuZLqq7tAAAA:8 a=uWCFXIfD3x_FUo0uTIQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=7KeoIwV6GZqOttXkcoxL:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfX9TeNUe5UG1CD
 4RYXKfmbUQvMKF41LtcxuPuTinOvG5gdl86BGYkltF9Km1mXLSrY4huJD1FthSmly74MkFec6lj
 hd8aA0Ye1bg27YDNEttd60WwynYW8dT6vh5DztgCz+wFaZl/lS5ydQgRr+IRQcRb1FUeDHkO9oT
 nqxFr2IlJyypXhtufdPSFxpYU8HX41avqJ7BtRVvEKGaZ7YsMBoEk65S7y6Cz1MlQPp+x3Mbrkj
 nhQV4RWeVPBDMh/SzAhwWPN3y6LLiLLWJAIwHhJEoimRS7q8QBbIxbZYpR4S0AbV0NK7jSbFXMD
 EDWy/sO0nQw1UpHjhnAPTW0bEgjy5DESvEGyWiQc+2LQCijtyGtH7MZLNbYJBqi0RdaseHCLL2n
 IxkfvIfPef0WUWDkb0G/WI558tE8gy/Sdc0GHhd783+JShPUIhQ4/SJ/Ysd5bPlSTMy+VAzUP8E
 LO1IuCNENPLUPQ4cxcw==
X-Proofpoint-GUID: Oubb8b0WGnm97B-ijpLdARHh0a7MgPop
X-Proofpoint-ORIG-GUID: Oubb8b0WGnm97B-ijpLdARHh0a7MgPop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290028
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

On 9/21/26 20:19, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add MSM8952 support for tsens.
> 
> Downstream does a lot of advanced things with calculations.
> But seems like using tsens-v1 directly works too.

Can you elaborate a bit the changelog please ?

Thanks


> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>   drivers/thermal/qcom/tsens-v1.c | 44 +++++++++++++++++++++++++++++++++++++++++
>   drivers/thermal/qcom/tsens.c    |  3 +++
>   drivers/thermal/qcom/tsens.h    |  2 +-
>   3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index faa5d00788ca..f4201748ea29 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -145,6 +145,37 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>   	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>   };
>   
> +static int __init init_8952(struct tsens_priv *priv)
> +{
> +	for (int i = 0; i < priv->num_sensors; ++i)
> +		priv->sensor[i].slope = 3200;
> +
> +	priv->sensor[0].p1_calib_offset = 2;
> +	priv->sensor[0].p2_calib_offset = -1;
> +	priv->sensor[1].p1_calib_offset = -4;
> +	priv->sensor[1].p2_calib_offset = -4;
> +	priv->sensor[2].p1_calib_offset = 4;
> +	priv->sensor[2].p2_calib_offset = 5;
> +	priv->sensor[3].p1_calib_offset = 1;
> +	priv->sensor[3].p2_calib_offset = 1;
> +	priv->sensor[4].p1_calib_offset = 2;
> +	priv->sensor[4].p2_calib_offset = 3;
> +	priv->sensor[5].p1_calib_offset = -1;
> +	priv->sensor[5].p2_calib_offset = -1;
> +	priv->sensor[6].p1_calib_offset = 0;
> +	priv->sensor[6].p2_calib_offset = -1;
> +	priv->sensor[7].p1_calib_offset = 3;
> +	priv->sensor[7].p2_calib_offset = 4;
> +	priv->sensor[8].p1_calib_offset = 2;
> +	priv->sensor[8].p2_calib_offset = 4;
> +	priv->sensor[9].p1_calib_offset = 0;
> +	priv->sensor[9].p2_calib_offset = 0;
> +	priv->sensor[10].p1_calib_offset = -3;
> +	priv->sensor[10].p2_calib_offset = -2;
> +
> +	return init_common(priv);
> +}
> +
>   static int __init init_8956(struct tsens_priv *priv) {
>   	priv->sensor[0].slope = 3313;
>   	priv->sensor[1].slope = 3275;
> @@ -223,6 +254,19 @@ struct tsens_plat_data data_8937 = {
>   	.fields		= tsens_v1_regfields,
>   };
>   
> +static const struct tsens_ops ops_8952 = {
> +	.init		= init_8952,
> +	.calibrate	= tsens_calibrate_common,
> +	.get_temp	= get_temp_tsens_valid,
> +};
> +
> +struct tsens_plat_data data_8952 = {
> +	.num_sensors	= 11,
> +	.ops		= &ops_8952,
> +	.feat		= &tsens_v1_feat,
> +	.fields		= tsens_v1_regfields,
> +};
> +
>   static const struct tsens_ops ops_8956 = {
>   	.init		= init_8956,
>   	.calibrate	= tsens_calibrate_common,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b5ec70201e2f..4d7013fc79d6 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1191,6 +1191,9 @@ static const struct of_device_id tsens_table[] = {
>   	}, {
>   		.compatible = "qcom,msm8939-tsens",
>   		.data = &data_8939,
> +	}, {
> +		.compatible = "qcom,msm8952-tsens",
> +		.data = &data_8952,
>   	}, {
>   		.compatible = "qcom,msm8956-tsens",
>   		.data = &data_8956,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index e8376accdff3..a35b15312961 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -669,7 +669,7 @@ extern struct tsens_plat_data data_8960;
>   extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8974, data_9607;
>   
>   /* TSENS v1 targets */
> -extern struct tsens_plat_data data_tsens_v1, data_8937, data_8976, data_8956;
> +extern struct tsens_plat_data data_tsens_v1, data_8937, data_8952, data_8976, data_8956;
>   
>   /* TSENS v1 with no RPM targets */
>   extern const struct tsens_plat_data data_ipq5018;
> 

