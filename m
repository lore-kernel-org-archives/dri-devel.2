Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6561E10D14A0
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD8310E60B;
	Mon, 30 Mar 2026 11:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eN+/nEud";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="df68qtHE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC90F10E666
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:22:51 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U7fklh350298
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 plDxEJIEjCNBQg3n0O4+/HclwzWxwaqEltwNdOaJVbs=; b=eN+/nEudwXb+wVXd
 Hlj7gMrI1Nxnan1OU5Gb7o6sIQo4OdbCDAH4gPtAgRNax21N9Xr9M0jB1l5xU1O/
 NYdr8qQcwIQf370OTMeLJ5WZvl8PbCgsP4DoLpSzEN++Lqws3njCQZdYgzbVJ96b
 r+n8VPsSbKkztsg30WPBqSzztDGn0NODb7bTqrOUH/2v38d6Gnlvz9I6OLiEnvgm
 oGNOhtNNcnz/z+3IRGjPaRqziSaSLqA5n8WciNbzISDKkkWpBsVbzQyuiPvJGPFx
 d9mckR9y5Nbg9ODrq91rWBoXs6Ibz4kEg+0o+0VPy1Gu57k4ZwH6uKFHpG2qdaoZ
 y7dKxg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6wqeks81-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:22:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89cd0f68ed4so17596256d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 04:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774869770; x=1775474570;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=plDxEJIEjCNBQg3n0O4+/HclwzWxwaqEltwNdOaJVbs=;
 b=df68qtHELbNDJKi4sHGE2th8z7qjOpOx9Drc2eHJ0QpsFt89Z7JDm2KWr+U+nubpZg
 LqaVHmAiH4d4oysA6CRfwleRe6DFw4a8KLLooJ0aVkXOU36m8MpxrEN2Zl9/+UFv+iN2
 LXjOuLGkjRjjSfQK/87KyIG47uu9qFaF+rgvGqS0ubrW5hR8jE2VO5S3GbdGgtSD4NVi
 3A02cpkZK4dxI4tmklbQaKnUYt2g77JaFVWAH2uhDB4ndGXsykknwpzzSVsJm26iu3i4
 BrUwg+dxGiAdoXFt9eHQWtXyDAH2CjLbGy98lUjAu2//3jQJcnS2rhePdF+gq5vXO9bL
 IoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774869770; x=1775474570;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=plDxEJIEjCNBQg3n0O4+/HclwzWxwaqEltwNdOaJVbs=;
 b=JVsijQ0oRUPO5V1rtVXAzMWjc9ypA2PO9knm+fhS8uKJwmGQtuqzKyC2WMoT4/F0Ci
 U8iOdgw6O9ksV0P/un9pkzobA1x6fxpYUsESKLusGucySxMLd9/fxaY/aX7ArQ6x5An0
 0l4fhK2wC7SL+4m1YcVJzDr8Q2ezVzfKSOhhY+5BjHistv/n2to+PIqeVZEyXLp6Vz/r
 2v70kXoFIw1qm718Kzp9whPp4RnB37ZMTlFzSVH3prkAI653+4KGHZmu2zozvYgq/hCF
 hZcbyBwWtPBgjPms43tGfgFYhlaIORkKbO0r4qLs82HjUmiZi8WPQu1qHIpQg3lPvGg7
 jsbQ==
X-Gm-Message-State: AOJu0Yzb4xLi6dTxh8DNChdH2JGd2lygvFb6h4SoB2tNrSBJJWyk8e1v
 XTmZhozxVkpa20Ns27WwhxVwjMDaozJfjsdtVdgpqZUNyUMKDkAYSgANKVF+jupntj6by63xDrU
 gpZ2AX4H8rU5AArcSJFDPgshJqu0gXiFPDGGfi0bKmK+EQGTZ4xuxb1fsjhwxZJwDSZ8DYVY=
X-Gm-Gg: ATEYQzzTfAqNG8a5K49AJzGcVx2/5Z2jdB9p7gU6r/pemxdA8Z6nhEuYzdCHXYu5yDW
 HuCJOl2j0SGuFo2oEivk/cczKQ1eGsMXTCq7bWndDOyWRXd83IXx53uhMLUwiQi8CMhrcLJ62WU
 Pn8ZCWIvqkbLNhFch92rC8suA8qY6RQ2L058Iz94lNFKlLgmiPHdxaUmTMFkyxYzSzhsd6m5yeP
 jojLU91OTzzMBdwf8MKExv6skAVTIYy52pZ5L/kt83jq2SRhhACTkeO3rV+axHUKvX5I0iI+obh
 R0YDs4lmINwoSBM1heGnQI26zQov+cDS4SbEizstKfxHqzKgvIKdP9ZsOy9AEZDRnrbw6MNeiVb
 JO4FedZgsdbx3HP8FyCIuYHkmLePGF8Vz0+814CWSDV0K5G0aL5nwY6POr7EOjD2G1ur1pDuEr8
 SKOwI=
X-Received: by 2002:a05:6214:528a:b0:89c:5473:bf47 with SMTP id
 6a1803df08f44-89ce8df70cbmr125942696d6.4.1774869770144; 
 Mon, 30 Mar 2026 04:22:50 -0700 (PDT)
X-Received: by 2002:a05:6214:528a:b0:89c:5473:bf47 with SMTP id
 6a1803df08f44-89ce8df70cbmr125942386d6.4.1774869769508; 
 Mon, 30 Mar 2026 04:22:49 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7ae24d6bsm276245966b.6.2026.03.30.04.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 04:22:48 -0700 (PDT)
Message-ID: <ecfae618-b2fd-426d-ab2c-c13ba5d764f1@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 13:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 display and GPU
To: cristian_ci@protonmail.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20260327-rimob-new-features-v4-0-06edff9c4509@protonmail.com>
 <20260327-rimob-new-features-v4-3-06edff9c4509@protonmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-rimob-new-features-v4-3-06edff9c4509@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Jo78bc4C c=1 sm=1 tr=0 ts=69ca5d0b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=sfOm8-O8AAAA:8 a=EUspDBNiAAAA:8 a=ER6jexHYGgKHINCZH0oA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: GYjAkb471xur6Z6B29GIrE4SRGNmqtYW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX//qJS1PZlsgO
 8a315PpVAtHcsWMj4JgBl9gR96Ou/RAil8+4jNO5SxfRuAb+XDj/HHvN7pAFzu65bsqW5z52K3+
 HHZhLDGfV35a/4Rqqmh8CKS3r5WIXgJ6Y1hJUNC4FQ97944lJFnMccIKeTD9rWAxixqr15cnjkB
 CBUgJMQA1A/59uSPFMioeC8wG0Cl9m8Xei7moiywpi+FQyrm+BaOBnymfXcF+kFxl6Uyk4uKIQA
 JMpHAraKbSZ0QHTIMbWRKiGBFdepSaRJrCqRH6bYtVrs16td5kiGzTtqhuHteYpnDRPPztyLXYM
 Bcy85OsAZ+gyQM5BBTRsV0AlU+Arjd+CBlPJHaQobNqUeixbBr8T0iT0xQMXB3eJbxEH2QNoqzE
 M0qQmRJMBgt/mqY3GxCZ6tsscfGljvkiqtFr3BI5PEd9vJFXdwqagfFc+UgQvMtoOr20th3rRC6
 lnVyUCH4XVmT2ZsEWzg==
X-Proofpoint-ORIG-GUID: GYjAkb471xur6Z6B29GIrE4SRGNmqtYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089
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

On 3/27/26 3:30 PM, Cristian Cozzolino via B4 Relay wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> Add the description for the display panel found on this phone.
> And with this done we can also enable the GPU and set the zap shader
> firmware path.
> 
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---

[...]

>  &rpm_requests {
>  	regulators {
>  		compatible = "qcom,rpm-pm8953-regulators";
> @@ -244,6 +310,13 @@ gpio_key_default: gpio-key-default-state {
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> +
> +	panel_default: panel-default-state {
> +		pins = "gpio61";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};

Nit: ideally the pin entries would be ordered by the GPIO index,
via:

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-nodes


Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
