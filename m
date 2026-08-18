Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B37C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C867810EAC6;
	Tue, 18 Aug 2026 10:48:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="exqpR0Ck";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A6sK7a/f";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5369D10EAC6
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:48:25 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IABScp919338
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yAFsf6cYUOKN4O63zPVQPesFKfVCdN+ihDwBZVmkijI=; b=exqpR0CkTbGbCS9r
 QbO1M5RuD50HDIdz7A8/CDsJldXF18r1DLJ28WhtAKNr1gmcCT98Cud6xzrQlR4q
 hsb4qP8h87cc92ADqd4nUknuyeSxyb39oIwxGFyLPOaBXHbWEsOQiiD0X8WA8323
 2IyxV0pFT/UNnTyddD++Rdg1bbxXQoFwrArriQzDs22Uu1guDwIXQ7XcVk+lvJbl
 341V9vAeuKiC8BKQvx6ymVMe3dSdo4bcMnO+aruW6NJKvlpxgOwJaJTP5smA0Fjc
 tziJj3oT9x4kDZBp0dbGaIRSxjdEGf/MHmjMiEWcohfBxqCByM8kloZ41ZBSPLVq
 EF9oNw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb184wy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:48:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93494b1e35cso5262685a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787050104; x=1787654904;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yAFsf6cYUOKN4O63zPVQPesFKfVCdN+ihDwBZVmkijI=;
 b=A6sK7a/fjiGwuOEv+ssytanCh9uCAOVYFS5UA2XEEVoPHWg+OY8mu70417RcsEF6XS
 TJumLg3TW3/mb6D6EYqSY7bb+9HGzJ20EzHBMUusfsFzfsv8fipCNbM56lo2rdajV/qT
 g+xfhM2abKvvvx7T3aC39GvSQPS84k1uySW80t1PS4IxfYjA3/ad++pK7FC4999VNxBE
 iQ7bMsBo4/rOYcZH58tlfU0iPA223lZ8HbfaBkQ0S2yhrFMo8en/XAUCt4Lnst3kzrUg
 71068MCX9zUxbMLKJWm8qxIMpfvA0B4cLhxKMiDOyyxTTnT730u3+UXGOYroFaDLnMLD
 P2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787050104; x=1787654904;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yAFsf6cYUOKN4O63zPVQPesFKfVCdN+ihDwBZVmkijI=;
 b=nqEYgtnanDW79sxy0weuhLMhDRtteDEO9tKNvCSklKS6PFLUtQwEIuywcKTeZrY+eH
 q15lVfu8b4keEsF2clpmNip2PXl5bT03FoulFcFvVqcBtrKwNcaGVLprKv1GxuDENR/3
 F5ezTzjyZylNv61mn0Sp1S6LF4VBXAdEc0m9hkoR2dxhuHA2W+0MYkGJ6HzX6/Pr6Z/b
 13eAACeiQms79eKFqfxED9wvx8H+L5VVZMfX1adEUsW2ZJkrlSt74flccK1BRqNp9+xc
 BfEHxRO5StbRGxTrYy+tZ7u9KNCJL3BmCbwWw++IDmo1jjd5L2/OVLWlrnTCTtSJpNsk
 b7Pg==
X-Gm-Message-State: AOJu0YyuDwgbw5CQKYP7BL8h0Iotu/JTjXrxjxwIEbUlbAbhf/0yNFYh
 uakOnT83I991uolQumnIudSs8lpDPyCVIbRTSAl15/RiRvrR7NDQfoU/nbLJnWiSaSzASE/KFc8
 2vKqTY5cnhmzB089ZimINgDqWKEAqdTv1pqdVYilIckA7gNYJxWap/4VRanAwHICzZd1rgHg=
X-Gm-Gg: AR+sD11ugXbIaEaFNlZOsz5UmRUoI0D1bEZBtwO4C7nF0KlODq5HLTAxQx9wKOska5M
 Qpr4TeeymI5DIOVXZY0Wa0q/vUlhzWulAvrpOFVRKjedzxSccckwkV74YmTv+g5csMrw0p+30RD
 8yH/rpGWCRqxgaAituyZObOMD6n7qLqMX/1m4FMbKzWIMlzWHLKisKdqRpQ6TXlh1hJ5cnt8ZHB
 tfaiIzPjjrMQ7PLr0CwwOBQZv+w2LSKX7aZuispHx0/Go50EF3cyyQBjqdjf6ldCilE0lzSpjo9
 PSjjfaR7oRiXljXpoiTLFf81wslOkhXYutz81cCxPfoZOBLPknkEfmlgteaaZIryc19E4wfpTIY
 LQTqQ1PaLiGNOAFmPcoPyHpOr
X-Received: by 2002:a05:620a:600f:b0:931:23a:83ca with SMTP id
 af79cd13be357-936d23849admr2557382685a.4.1787050103802; 
 Tue, 18 Aug 2026 03:48:23 -0700 (PDT)
X-Received: by 2002:a05:620a:600f:b0:931:23a:83ca with SMTP id
 af79cd13be357-936d23849admr2557377985a.4.1787050103310; 
 Tue, 18 Aug 2026 03:48:23 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c217fe6aa89sm167518466b.2.2026.08.18.03.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 03:48:22 -0700 (PDT)
Message-ID: <1cdfb3e1-8a89-4b52-a5db-0359a9f68878@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 12:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8250: add device tree for the
 Xiaomi Mi Pad 5 Pro 5G
To: me@dawidwrobel.com, Jianhua Lu <lujianhua000@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com>
 <20260730-sm8250-xiaomi-enuma-v1-4-ed6d8fb99668@dawidwrobel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260730-sm8250-xiaomi-enuma-v1-4-ed6d8fb99668@dawidwrobel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3OSBTYWx0ZWRfXzSkV8kJ2ntVf
 qUlj2knd/oU2ftUT1+0ua9br6gTUdW9FqRbm/Rd8dbpAr5/vyUgb1WI+gWzLtlS4DiEe4gYvIYN
 vN7HKKLsScAtjjGUsa9ZulTcN3nsEfhu06b+hIgyBNbuXt9mTWjMONgjRIcEkCiVNcufgjbKZDZ
 MaK+aV4/G+l/4ooHpgQmroRnHlXbqJMBl66tuIQc3v9RYqIYl7NtvkGG0Cp5YphNOQ9sdUkTLZE
 8qJVayA8v/MIJURrqis84hvLjna8ae6dK3MCFeIXvOVUWZMeB/pq/pXRl1N/E3jYwaU+c2jXeG3
 VjgNCC0axiuBsaGN0HIdg6xxaJ846+vMib9K7uYrtRe+4aW9lWDZrvpjp3+WxMV/3zaPU3/6Xbs
 KW2YwFLNqv4YTaOfaNIGq0YZfg1Zr2RXEhhY6z10n2VYZW+ZufaUw4T+NevIJ+fsiQVE0IKUe/D
 UGSE0mW29lxC3cprEqg==
X-Proofpoint-GUID: TGEnGCM0xaj8h0ORBktfwdMiUqIEvxmh
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a843878 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=VoYNWTs0KIJBnnxc:21 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=br21HGidAAAA:8 a=EUspDBNiAAAA:8 a=16WXXSGXZCMmNkSL7LsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=rq5_1Q1BYlbxkLLkNd_B:22
X-Proofpoint-ORIG-GUID: TGEnGCM0xaj8h0ORBktfwdMiUqIEvxmh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3OSBTYWx0ZWRfX4ISUcRzGqBnu
 ti7aYbM86w8Uq5DDLVWI6ekldp8KSFeHpfwM2r+lcrGNhrzKqUAaYWItNuKrr1AVGg6+YIqaVNo
 ZpjXsIBRjnzz1DpeAKjV8UhlN81sUDE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180079
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

On 7/30/26 11:52 PM, Dawid Wróbel via B4 Relay wrote:
> From: Dawid Wróbel <me@dawidwrobel.com>
> 
> The Mi Pad 5 Pro 5G (enuma, 2021) is the modem-equipped variant of the
> Mi Pad 5 Pro. The board is otherwise the elish design, so describe it as
> the common device tree plus its own board ID, panel compatible and WiFi
> board data variant.

[...]

> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-enuma.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025 Dawid Wróbel <me@dawidwrobel.com>

Happy new year!

> + */
> +
> +/dts-v1/;
> +
> +#include "sm8250-xiaomi-elish-common.dtsi"
> +
> +/ {
> +	model = "Xiaomi Mi Pad 5 Pro 5G";
> +	compatible = "xiaomi,enuma", "xiaomi,elish", "qcom,sm8250";
> +
> +	/* Platform type differs from elish; msm-id is inherited unchanged. */
> +	qcom,board-id = <0x2e 0>;
> +};
> +
> +&display_panel {
> +	compatible = "xiaomi,enuma-csot-nt36523", "xiaomi,elish-csot-nt36523",
> +		     "novatek,nt36523";
> +	status = "okay";

ultra nit: \n before status is preferred

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
