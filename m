Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC121088E67
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D1310E846;
	Thu, 19 Mar 2026 02:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hx0ie2pf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iqhw36Rk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11EB210E846
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:54:12 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62INlp2m551102
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zr55jwjPMr4CipN/1sygJnvq
 rz4xwfpiIiHPxxrHDZg=; b=hx0ie2pfmgdGEhRAVhR9FDl2jhZcnRl6Ppzx868m
 iofY9UgiaU54YSIuaJvbiKsFaTwSydwa1ORGyJcmynTGr3ADtW5orx9ved2cO4DU
 o1pYfo9s1zlqYSRCWjK/CUzaLmRP2yGq7BgsPZn13RT2qBHvZpE27Q8Fr7o0E1Tw
 /FIegp58HHQUURYCmlxoqy3IWo+ebDpiua3AEE/M3zU6NFxdHyzfgGXIFfvz/kM1
 p0bwMRlkRT4Cx4PDdQI0c26QNE5VQriky3aURkMRBXPZ+T1B/a3UWyvhUa8ntjxx
 8mumGVis6JS9VVZlMN8des93uVw4lCa5DPSl4QNEvK1/YA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyj4g55t1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:54:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5090bc4823cso14286261cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 19:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773888850; x=1774493650;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zr55jwjPMr4CipN/1sygJnvqrz4xwfpiIiHPxxrHDZg=;
 b=iqhw36Rk1GN3g5jRJede796/OGqxGIEz6rB9GzP2zKJ0sSP2Hl1mtZWLqYL5IPwKD5
 m3q2U5ljFxgni3wIoe1QMxabAbcqm6ASaUexXXbS6zWfsR/OJlRFc8KTonJh8qqw63Mv
 wpnN073JPxA5XWydsSvnPVMR+oLsatG0/lmmSWqg4onyaih+4CayXULbmRqbH//g+nMX
 hKhjf7MMrASGwqDBktsC6j7I1QhwNbMTtkntu9cVDSmom8vgfUp5E2Akmf3y2aHwqSUL
 MdLaBepgkBY/xuIBsFGBDzV7MRPx+TbzitzYnkdUSiVgRC8Xxed8h+Y1w99yvfqS2b1J
 6mfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773888850; x=1774493650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zr55jwjPMr4CipN/1sygJnvqrz4xwfpiIiHPxxrHDZg=;
 b=lBzKrHnt0ZHMs8YqpjVMXpIBz/MqczIgOViomQ+5tJTJkEIhR5fsoY340n3FIB+6YH
 tbSIm5TvkuofJtc3MjBglI/R6Zj2zo0sZ0bNiNINXhKGaJpMd7Uw71FFJgcXvEiVpgJ2
 riTfXQTli4OqeJvAyQaTCNuAJgMGN7EvrdMJlf/2DGnmzZ77G1wHzRPqCx2vnEqDT/kn
 zuubFyjIRmYF5dtDoJjo3GQX8qZyP2PwqXXggynQhBFDtE2JBKSqoZWewwkvI57NT8lD
 +W5jLRzNlAy7+LGqhjf4+51JwbV8xwOWT3g6CNZsqKBsaHgyetlMaUruUQvQhNrMBxGO
 MQUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIr60QtmOnr0t6V2HoO3f6fmA0FfkDJih1xsahGLhAKjvqNBl0G4Y1ngovM164cKLfq/GYbojVXrM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTcO9KXm8lWFu0wJ0kQlZ0jyYgt4woKwxMKTmngaljYfamPG/c
 Yoc6Tg/ZqP1lfQNomtmqYNyDoU65qWeT7YWbh5l0vOx432shhpR3nqaZGSmkrme8hOL/fp4lWC6
 jzKf0mYlKZ6WsQ8//rVBQlqfcrfAX+PuWG7PYOpfSc6EoZRscjmZ4t9bFnjJHDoG0fw5D2mU=
X-Gm-Gg: ATEYQzywJfP92OpdlQ07pJw7+DBNMT4lrjqBhAnPF5eUv/VsK4j8GlMnxJERbZJlr5V
 kjWVfDig8kzwrk45cJQ8W1Vimo1x9iWHaBw7ouQyRDMyovgvPhrVnZVIUNBNPjPacRIOlgufZod
 6QesseDrULdNoRFJNzRvd7YasWiZ5xY2Xk/ttLsGjSgaM9Q7u6sqMXqVXebwyWihu4NGnjdp7xL
 L2b1Bx7G9qCwWAzMOewRTV3QDcB+dt5n2neZ9tHSLMEDXa8I3AFYFNJQIyv4MEfYSoynGscJ1f0
 D09aKBFl24uf+v6Eu0aZKDxL3KVjtX8IIDChgZz28/FQtnp/ZyvfimeIATFipco92dbLyfvVeSA
 CFDrAhKdTNjZ8riTvM0D3ttfA/MUrx7LjIYMBntfdxhokNSsDc6yc3ugvH+klQhErs1XK0zXG9F
 IzJsfK7HlbLHDUrxOnUbj4kHYe7JKSHxlm3ZQ=
X-Received: by 2002:ac8:59cb:0:b0:508:ff31:47f1 with SMTP id
 d75a77b69052e-50b14889319mr77055241cf.50.1773888850378; 
 Wed, 18 Mar 2026 19:54:10 -0700 (PDT)
X-Received: by 2002:ac8:59cb:0:b0:508:ff31:47f1 with SMTP id
 d75a77b69052e-50b14889319mr77054921cf.50.1773888849825; 
 Wed, 18 Mar 2026 19:54:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bd5157108sm9573101fa.1.2026.03.18.19.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 19:54:07 -0700 (PDT)
Date: Thu, 19 Mar 2026 04:54:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: cristian_ci@protonmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 display and GPU
Message-ID: <jin2ecagomu2npjnqr6ejpair6d4uam3djznuaodjijqi6hilk@64ddbqaezuah>
References: <20260318-rimob-new-features-v2-0-c1bf8917449e@protonmail.com>
 <20260318-rimob-new-features-v2-3-c1bf8917449e@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-rimob-new-features-v2-3-c1bf8917449e@protonmail.com>
X-Authority-Analysis: v=2.4 cv=TPhIilla c=1 sm=1 tr=0 ts=69bb6553 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8
 a=sfOm8-O8AAAA:8 a=QiVCaVSgwpAuPVqWOeAA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-ORIG-GUID: IanlS8L93OMc3t_W2QQjrL2cyNchr7i7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAyMCBTYWx0ZWRfX/C1GdOc78LIm
 GheLC5PGgdu9v813tFiaCoCsrF46xL6z4lxtjIHOqNR02d+AcmkQHhTBQn3Wxs/JMjMWUUnNvL2
 VnBLwEBVu8uVA8o8l1KCQqO1oOd3pUMXNI9erz7e3u9ag1brdzrbGBSBpsab/7g+IDbe+y/LUS0
 I9pH9i9FoTqR5GC+ItO7DhI2YJhia9YxRE/P133biQ8Z4JfY8cPnq+7ljlySSSZIQupV8d1k1q4
 Y81qtZ8SdFt3TL+4VUyEi5hjKs0Wm0WOS0te3GaC5jLsWaeQNA+bDtTfmeATN2HN1WWxCiwm06J
 8QkeY7YOqQacqY6Ka0MVABPmAESPY1eQCP/WAyvYKuH3KSf7BewKYqErPalD/6uEHEXwG3q1CY6
 h4ahCRlcFmbpwd26EVQO+kK0b4in43SqYO7N/CpUts5fzDEiPWlj57IJOyL/lpHXGfFVPb3EjBL
 a50xlGkPIYnB1GAxCoA==
X-Proofpoint-GUID: IanlS8L93OMc3t_W2QQjrL2cyNchr7i7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190020
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

On Wed, Mar 18, 2026 at 11:28:11PM +0100, Cristian Cozzolino via B4 Relay wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> Add the description for the display panel found on this phone.
> And with this done we can also enable the GPU and set the zap shader
> firmware path.
> 
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---
>  .../arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 74 ++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts b/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
> index ef4faf763132..de287c8e9686 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
> @@ -78,6 +78,13 @@ vph_pwr: vph-pwr-regulator {
>  	};
>  };
>  
> +&gpu {
> +	status = "okay";
> +};
> +
> +&gpu_zap_shader {
> +	firmware-name = "qcom/msm8953/flipkart/rimob/a506_zap.mdt";

.mbn, please. You can use https://github.com/linux-msm/pil-squasher to
squash .mdt+.bNN into .mbn.

> +};
>  
>  &hsusb_phy {
>  	vdd-supply = <&pm8953_l3>;

-- 
With best wishes
Dmitry
