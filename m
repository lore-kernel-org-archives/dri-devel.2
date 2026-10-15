Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848E0CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA2D11122D0;
	Thu, 15 Oct 2026 11:06:31 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13A5112298
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:06:20 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jkDl3510586
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AsYNJSBh0Wrd9np61Ns04WJE5AtICL59Ip7Jq4tsBek=; b=SIHXasmoRyUIV08p
 WIsNmvIbkDCmlJTcWWDH/vBGuX25ARY9bmlRdiZpN4xJl40j08Go3G7TJu7ip0J7
 tlHqKn8pG4c41IlHWlCqI/7FBdwTHJhJBiVgN3cafUAzrov41ilKQ9k/srbjiylG
 2MdcnJdS7WqQhDArjyYcD6J592cJnym6OzODFBVglydQfP6QjtbyQpr1efHj69D0
 ct43yDV0rF8fkJt7PSjfK99fXDzG+Dav8KfvkBng5K6QIo1JYmcQdmxu6lnNQN5C
 EfZTzh9fVMlzGogPw1UQXrAYStQXBc8zUbSnPYeU57Tb6oUytX3JVpYeigGZd1+e
 6dJVqg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds9pg7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:06:19 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5d44237e2faso265947e0c.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792062379; x=1792667179;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AsYNJSBh0Wrd9np61Ns04WJE5AtICL59Ip7Jq4tsBek=;
 b=ZTPB4/l9ebsJGZAX3lVgmzj4RpAiQXaIy92XBo0tLjKT4rnMyvSIAVQ5Lngc7MAn8P
 TPfFqD+kGauT7qQpzmlSPBzHQTPJODdTx9MoFqRfKA64+PUmnFqo0erIWzGQ3UoBSd12
 ulZg/THfA7vTh1f08cUYVarABRxVIwXJ7CMj4WSaYW5zUpZBnOdoBLxNPN4LEjHI6Tae
 DGkPwrCW3fWvowM+P0ZeBUiImxXwVC1hfYLLrIsIr/Packuvz6YrAzTHVKzRNuXkDQyS
 /gIKpf4dJyiwcl4LFZnLKTM90MvXZhTSAWRZ8syQ9xGtB2Z+BpQLQVd7HtZCgOawqojc
 XD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792062379; x=1792667179;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AsYNJSBh0Wrd9np61Ns04WJE5AtICL59Ip7Jq4tsBek=;
 b=enGWSKBkyas+qcDEHLQd+HtaK/uXioUWbur44Sq1eKpNnGZzWEx90fnvAhJq/J/0bn
 6+bfJTEiOVEvTb/FZOXzzeYC+hjY3kLvLz83y8E5TgTOb5ceNP+w1gWw+Qh+WR0/DbFR
 Xd2n/ABPeUs0OrSVQN8HmTgaluSEj65hfAV+iHla34UMIemu5r2OQ9iYG/29/BuBXWew
 GRaXVWVw99ODTxLvZsi4reIuOXZ4WAFmy87urRUoYacIoakTHVjl8zmZuLsUTTtcMTY4
 a1u2/TZqe1z0arn4dDLxRWxz5UnvfMUIv/THOeTLtLsV7uDciQbGCM9/DTzqRSWT6ovm
 xG5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF2ffV1SkC7fpbBlsfR2OfeirgvePjR/y/pVRGl/3kVsWzE/W4tleQ7hfd8eQ+/0agNSeaQvdlotg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJhmMoDGWYUur2ciTJdftSmg0AeT0G95raPUwQ73Mfane3MbFKX
 OqHWTv/eLGOCxmErSrkP1/uedW0V4ySQV20Ma4m/J/yEv55ayjqOLk/PAucD9IwIYuTwSNVmwur
 DHB/yoO9pJEhrgtD725Op5b6vQLA8nG9kUNHocNLtSZEFgNFvym4O2YjJVcJHb35kjCFYlvo=
X-Gm-Gg: AYBFou2JB9xMH/bY/Ao1NMWWKFz+ui+2AAo2goC5JpsE71GrqQUFg5ZG6pB0QdNFo78
 z6gW+5vrsEk5Dz2H9w2eX3wGoNoiZLSVCEhxOCaL7FMK06TeFHJ7zW8qtdZE1so+oDpZH1EjzIE
 33vj+AzqlvKAQIgKfNG4SPF0a4b3dYIBp46IG06ZI/OP7Sw62k1P46+FqCRtv1FSwytqFHs/I6Q
 2KIvAxspZMErcpcz+QfNu5J3d4YqsS4MyMOI0KT/MoenIIpgFxzgAaABb7z2c6VRVGjRD61cWoe
 OdvQwIoPjCUvCtanDYN2YAjpvdLMH5sSMvQD97NlGeCyYa75yCI2BPepggOvNTR+M5xGV6qBFp4
 yZ0D8PZ7sXN53A6VfIdNULg==
X-Received: by 2002:a05:6122:8111:b0:5d2:d60c:6c48 with SMTP id
 71dfb90a1353d-5e91efb84camr3996585e0c.0.1792062379111; 
 Thu, 15 Oct 2026 04:06:19 -0700 (PDT)
X-Received: by 2002:a05:6122:8111:b0:5d2:d60c:6c48 with SMTP id
 71dfb90a1353d-5e91efb84camr3996576e0c.0.1792062378544; 
 Thu, 15 Oct 2026 04:06:18 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3ed963e42csm111355866b.26.2026.10.15.04.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 04:06:16 -0700 (PDT)
Message-ID: <ddd2d324-4202-48bf-8984-45edae0c3278@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: sm6350-lena: Enable Bluetooth
To: erebion <erebion@erebion.eu>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
 <20260926-pdx213-upstream-3-v2-5-b4612e3eb536@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-pdx213-upstream-3-v2-5-b4612e3eb536@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Kt_-x3snDgcyW2qKwn6Zx7PfdD0CteX2
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad0b3ab cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=JgZe5hknAAAA:8 a=LKHdihu55Qpm22szt-kA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=tNoRWFLymzeba-QzToBc:22 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0NCBTYWx0ZWRfX4Q0LHSxq7AKg
 Dz5gPZSiAL/9uaBsGGAoCEi3RAnRoUcic2KgOe4M+0pQqEEM+amf9mlJWBMJoI6ZymIhLvAvO+y
 /LdxBDfLV0B9h612GdBPyLjQfbnQnizP3gieZgFp7Kor3rb4B6NAx5mvtQaYp374nZXNlgBJxU6
 tN+2UnoG3AWEA2A3sJqSptvq6m2sQTnbWDg6thuMK7bdkBgX0jlr2ubSsmoUHUWRWYgxRWhj7gm
 4s+WaV+STAPtIrwPSKA8EIyEmibYFZvH6g5bRtnH5Rxpi79lc3opPN90uTlXgo5Ywru/E/jZesV
 aUnB7xIU0ZWdIezgZEERypTcDFe7DVNfbPkrUWz0PSn/37ZLSyWOeqZyKGMfZybGhWKO1Ce27Wj
 l31/fLJJNNALGKPHxN+H18yQcXKMZRFyBs/nW4cok6Z0wxD7iqNbK3T2uUoJJamHhH8jfYcQbJM
 vdm4BXOoCkaXI7nV8VQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0NCBTYWx0ZWRfX8TS6CSrEDklL
 L+l1ZdaTNRJKlUCxuwfsYLteQcSjvqdeMIjLFJzM2mmIbQEn6K0KAPiJ9SiJ5u8NM0O6otHqogD
 hDUKaAfaWtr7ExRsHtKSByfevg9s9rA=
X-Proofpoint-GUID: Kt_-x3snDgcyW2qKwn6Zx7PfdD0CteX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150044
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

On 9/26/26 4:00 PM, erebion wrote:
> Configure the required regulators for Bluetooth and enable it on the
> Xperia 10 III.
> 
> Signed-off-by: erebion <erebion@erebion.eu>
> ---

[...]

> +&qup_uart1_cts {
> +	/*
> +	 * Configure a bias-bus-hold on CTS to lower power
> +	 * usage when Bluetooth is turned off. Bus hold will
> +	 * maintain a low power state regardless of whether
> +	 * the Bluetooth module drives the pin in either
> +	 * direction or leaves the pin fully unpowered.
> +	 */
> +	/delete-property/ bias-disable;
> +	bias-bus-hold;
> +};

I don't like how these comments are spreading across the tree as
everyone copy-pastes them. On newer platforms, we settled on
setting bias-disable everywhere and there don't seem to be any
issues. Are these edits beneficial in any way?

FWIW I think this claim of lower power here is just preventing
leakage current from a floating pin.. 

Konrad
