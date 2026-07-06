Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB5AC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98FD310E30B;
	Mon,  6 Jul 2026 08:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PNJc616W";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MM6sJqHX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4461F10E30B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:01:29 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641Wcn3615514
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 08:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LEvwY9lVsl4c0KkWFbM31zunGMAv/eiBIVSW86anSwM=; b=PNJc616WMWAi/P5h
 KzviJ2QOcmxmWXrNJrOBf186e8ISZSGtk198bVxyTL1x8Ul2sznEyosF6vSU+S4o
 1Iidcvx0nJoQ0rt1im8IZc8p2GU6PoaLmX0Cu6oBI1wjZIHDlvbj9GeTL4QEWcSo
 UdL8TInLCrszGVqnQRAA7vKM0/0QKz0fAIrUjxHcJ5Vk5gRH8FU38XhDAEwh8pUb
 efJLf0/aAi3C8d3e2nd/6vvEk3QoG02CApQOj/ngfc8Oqpwg31zqE+SnHkk2kpCj
 /A7aZ80v+JQV3/90uYV2iFw9EGC9LN2hFw6xV1ivi5vuW5RVfoYOs9owJxpaojO6
 lDdtAA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3d5em-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 08:01:28 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-73966c839bfso93884137.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783324887; x=1783929687;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LEvwY9lVsl4c0KkWFbM31zunGMAv/eiBIVSW86anSwM=;
 b=MM6sJqHXtc7OFT74mYhhQKUOZRut0yV19z1ez54+IyJ/Uw2Zb9uoAbG0p1FVUs234y
 +g/5ahOB4ldGhpfXIUjm0MiGHAZwTyslWBsTuJX6PuJuQL3uVDYjo2G8vzfLsx2AeCK4
 nHRS3DoWHacL4quTm73C3SVcJoQuyB3CEzzivOQkjrTsBF6ZZhnXpNdUMBX+PSOtOqtw
 BrwsqourqL6XLyms9xTn5ugCaJtZ2ApaXg9vVo5Ph7kTDgPWw2EyhdfQZCXDsOHYVc3y
 YtAQeij1OtiJ1zLjUBG5PyFAmH1fY1sCcr2RUjn9yyM8c/ZMAVoI4wDZV+P9vjNYk/Co
 bhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783324887; x=1783929687;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LEvwY9lVsl4c0KkWFbM31zunGMAv/eiBIVSW86anSwM=;
 b=k5ATrogwHfTJ7qvn1v1S/SRSYkWn323XwkguB8JEReYp8u0+oJwBnOGKW6iR9BjlNN
 CSnlTPIQehzoduLjuSviUy0t/8c3bvyMq5rFDC2njlY9mZS5l9mP5E5PGOvyoaEsK46y
 afWelmv6Eh7FO9pnm/BnrgYNGAq1/FtbCkEM+rqtjQEeJtebfBHihnfivcYGH4CnW1SL
 2L57nDd7vElBX2/pb042Hr8C/DwFpo28GTZHV+texjKZZxBbi2kTHsEDhEvFZcorXdGN
 aU3IdOQnwToBg00ynI50+06wXmEARVBmNH+Zk9YakzZbFzbrqGGfjIZpETdll2xaOBZe
 P87g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxA4H/pPo2wrx2Ic+y5nHqPW503ifuAhD0wGFDzLZvZ/uRhBXJJjauYD/WjBO8oU0+08V3Unmws5Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxohaxD4QF5xRzAViOhPYQAA4dOVmoLyZjgSAlD9e/bKy6yEKW+
 hexwa7CKOlzbAZAKdjFWFB5gAV+gfileKZ3MFZkYCZFtTKv7t1qBRo14uZTps1uqZ+WLRw/m4Yz
 NWXId6HbEi4cwfOoqVsBdlzqliHhXkaKYIcAi+38LiJmy1IV+jGCcaSF7G6Ac2/S1FjGGDuo=
X-Gm-Gg: AfdE7cmLULC/2ANfGkAn5llU+bBqPdcPUDt/2af/1a+E+hNCzFYBkhZ2anEle2ezfEn
 veo52eoNXoTpQK5FaiVbp2MRLh3oyyMg3bLkHVQuPyflDSRd4OkNpuQuzgJsUwZ3p8+y0Nhxlgw
 hrckiJOW7D8JT1IbpQjSmkWKkvRMw8a/h6C/uYxRHYwJ3AzzXq0JQCT4SDvAFpyYua49iwicKdE
 DykDhu/Q9obxUe3cCNsd9Aqzqwo3tni+GPuKXuqu/Jcy19HXqmhLFHo09r2QlH9caZuz7ASH3Se
 fhQMV/TwQFjOMNGo6nQwHQQ4dF7uh7BAg17s/NkRqZJvIPyp06WzTEYyKxGipuoBjk0FHYF2h2Y
 WmBLQ3Kl6xD2GSWIm/t0I6CSA/HOPr0RfgHM=
X-Received: by 2002:a05:6102:5f02:b0:633:3bf6:977c with SMTP id
 ada2fe7eead31-741f6b12922mr1165580137.1.1783324887386; 
 Mon, 06 Jul 2026 01:01:27 -0700 (PDT)
X-Received: by 2002:a05:6102:5f02:b0:633:3bf6:977c with SMTP id
 ada2fe7eead31-741f6b12922mr1165550137.1.1783324886847; 
 Mon, 06 Jul 2026 01:01:26 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d786e7sm3638842a12.16.2026.07.06.01.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:01:25 -0700 (PDT)
Message-ID: <f55c20ab-681e-423f-8d51-9c1def0f13ea@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:01:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] arm64: dts: qcom: shikra-cqm-evk: Enable A704 GPU
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
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
 <20260704-shikra-gpu-v4-7-90cf1a52e539@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-7-90cf1a52e539@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3OSBTYWx0ZWRfX1yCjDNLYi9Sp
 LavxKHVrHlGZ7x2V0Tu9xdQhO3FQTY9lLGtAYI0tBbLCVjNU5wUBDHvzQ5NTLFK+C60j5Oq5iCZ
 i8qlc1c7qdkq3cOTlHQ/kbrJkyE3n/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3OSBTYWx0ZWRfXyeorGLo4MVi1
 W4U3vNW5i+MoLIsXn+kWR7qcM9oJhb1NhbX5D/e9cigkZxIXmvaaTNNUEJl95vDJ4VvSkw+Ywrp
 sVbpxkQshdiGKogpE4F3GU4Zp04E5uRvM1mzN5O6QR28sTa892LBgLPA2JH7PhGCOtu/k7IR4GX
 594czK/XhW8xq6SoCF/9PQsmI5z8RNoGHJVcdAa98LnxcuLBXLCqFPnRimm9zmFd19CUOxg3m6Z
 AIdHToQbZJIt4i2QxeppdKfH+guyHkIGBzgoR6MeHoSbR0JcEGsn0gtuDMqZXc6zmSEJpOjRdR2
 Y2bS4Vkea8h8HqLOkVwjXq/+02ARuy54TPYxGiMHYc1obKxiOUHtVrw7vX9oKw+cykat/UOUarl
 acSNDBGSNXYDNTOaQN980xUeEvwX9BrFUtYtYa4xu81GquD3XcDYU4cYdESUSTPMPYA4rNzWK87
 T9CtPEA+u4NqvLAToYw==
X-Proofpoint-GUID: Uto0Fs-b4DlNjyOmnlZmu3IPFoS8WXr_
X-Proofpoint-ORIG-GUID: Uto0Fs-b4DlNjyOmnlZmu3IPFoS8WXr_
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4b60d8 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=dZuxl-eQfz5dsBr31XEA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060079
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

On 7/3/26 10:34 PM, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Enable the A704 GPU and configure its zap-shader firmware on the
> Shikra CQM EVK board.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> index 269e11bd44f6..8206dddcfc75 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> @@ -50,6 +50,14 @@ &remoteproc_mpss {
>  	status = "okay";
>  };
>  
> +&gpu {
> +	status = "okay";
> +};
> +
> +&gpu_zap_shader {
> +	firmware-name = "qcom/shikra/a704_zap.mbn";
> +};

Move this to evk.dtsi

Konrad
