Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D7ACD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B955E10EACE;
	Tue, 23 Jun 2026 11:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="exUMlBsl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HT+Hy5tz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E4110EACE
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 11:46:10 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBXsNn3668900
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 11:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m5U5jjEW9F6IsBKiOyKcfNkewQXQpsrvSh1PrEY+JBU=; b=exUMlBslb0malfKz
 wCVTsgbL6sHO2bs58FC2dSO2vcOdObXhisMaudGZqA+tvxqLVcxYMqo53yM5ZR3k
 XgaFyf1xh5KgV/PPy3y70NVXa1uNxhmxw94+fRE5kzc861jjNTEkp8qJDvUWoR6K
 rDO5jMbVYXVvf1I3jovyjDvZPXW+MH4biNZK3cbEceK9vZN4EZC304yp8g+n68sx
 TbW5Sgatnbk8GjPZq4FkVYvsrOiIeJJyG9AyJpWJkmjeU+4evg7ol9N4Qb8sRU6Y
 oR5lhUn7boKNCCKY7S/c+dL5/L+QKMpvL32nAU1kri1Ox2Sulta97j8lScjbM9h8
 9+z2Gg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppygtb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 11:46:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915c364ae3bso1105830485a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 04:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782215164; x=1782819964;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m5U5jjEW9F6IsBKiOyKcfNkewQXQpsrvSh1PrEY+JBU=;
 b=HT+Hy5tzx1XI7R5gijG40vbIr14fNopBg+4hTWId7c21zIFoHhtT6550RYhz+1k/fz
 8pNVFU3usNV+t4m9vipONkP3U5XOXO1yl54Dqg6WS9Js4TrJD+wP3C7uocdwN5dIDRpK
 NqQhLrL/lT1qgGTEIPNu5tYH7MaGCLlsoqNtmQ/KEpafge82xZvT8fuBti/erBNvBVhs
 atJE2sucQTtT0bhOA3VSqWKfdjasfe84rnqPmq5SxlT6WGCVtzSV8hqImWzPLy6nf2of
 CTuI70/2ODL7fe94heS+HIGjAb1j+9Lyr6J6D7L+gOmDEsy+VSuT+Cs2/iuCP3vwzUKg
 SKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782215164; x=1782819964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m5U5jjEW9F6IsBKiOyKcfNkewQXQpsrvSh1PrEY+JBU=;
 b=Q0MVoqytL0o3nkOig2k4Sko1rBoLVDcGgIJAjNLek7mFva0YOmkLdSVwecEeDBPQQp
 bhuYoSmLZj0QGoBHUCdV3HMQsoiyG/rJE+iCYJJqLtfD6ZXUCemsPEMlrbjD+GPt6jcO
 Ya8uHa08/8/ncBMmFb3I+gmwWKYHgJhPycgxwaH5WwCGRQqce5+XPs6hhtcLogIudjWs
 8ora0mQVrRbpQjcH0JyS9dCjPhXSbMRDa5gkRNaAo9fqZqkx7MTY+haautPXrsrO9XSM
 LmYJmCQzQjVwi1WptgNTcpyg+EmzO0pgJA2TD0vTWZ4gKqPyf/t4QLLsTpMioJNOV5X8
 Khdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FdUNTQ0yf6w0fGx7aRp2tCrhoZMMzuy6VopQIf2R0a5DcGNzx9n75p6ma6fjmqMVNXVBJgZVrnBM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyG3zVCETQYX3JKqe46lQzlDW5qhY/EOyZOKW4DUUHcgVd/G1lH
 4IfMlq9bCQ5d+krlDij6xY0F+wmeikYqIhR3MrcjnuQ/2p/37ZAgB5jK0BDNWoHlgWN5A1wrMgN
 mfc26sDy0Cz2x7TS4hSCNPj6ElzRS48Uu3MlnYnvER02pYYr1rjImn3qSReDM2ZKsrJsp1PM=
X-Gm-Gg: AfdE7cm/XO602jyM8uT//yYONWqKDeJuwXvc/Y5WZ/Vc28hBq42nLf82Ss6miW/tV3s
 91/gT3sGqE4lQYCx1lPz09doV7WDODv6Q5irbOt7zf6ZQI6oCync5WUxjv1JecOOBmFEIdgxojQ
 LL5USe9pkkFnZIdkvOugigVYipbfXxRnhQbmUSqIE2umcy/GS/1QkjBD+izxmuSrJC1l2xzZc5c
 90mRRO3sUUMgD0XU8jh9EG3QOsiaTDvi1vMsTcp6cbkqBK6jSjEqDGtjU+uWNQcSEDsbfgOacZW
 lEdzbcwb4GRrAt6jcajJxFgbddLwm4YWOD5IgnkkjRsQukr+1j/+YbyvHqWn7n6tWbPNsXdDKPx
 q3I4N7iu5EePovUTzo/+OzmrMhXONR+t+MAS0f3+an3we029dXWuwK6u+6l0TJLtVebCW9IllBw
 ==
X-Received: by 2002:a05:620a:4625:b0:915:d322:c47b with SMTP id
 af79cd13be357-92645aa5b4dmr405207085a.13.1782215163865; 
 Tue, 23 Jun 2026 04:46:03 -0700 (PDT)
X-Received: by 2002:a05:620a:4625:b0:915:d322:c47b with SMTP id
 af79cd13be357-92645aa5b4dmr405194985a.13.1782215163149; 
 Tue, 23 Jun 2026 04:46:03 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:21db:9254:19d9:645e?
 ([2a05:6e02:1041:c10:21db:9254:19d9:645e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fe7ba08sm370702135e9.11.2026.06.23.04.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 04:46:02 -0700 (PDT)
Message-ID: <b35abbd7-f06e-4794-91a1-bdaccd63af50@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 13:45:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: Drop incorrect usage of double '::'
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Andi Shyti
 <andi.shyti@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, Peter Rosin <peda@lysator.liu.se>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Linus Walleij <linusw@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 Javier Martinez Canillas <javier@dowhile0.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Jonathan Marek <jonathan@marek.ca>, Taniya Das <quic_tdas@quicinc.com>,
 Robert Marko <robimarko@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>,
 Adam Skladowski <a_skl39@protonmail.com>,
 Sireesh Kodali <sireeshkodali@protonmail.com>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Anusha Rao <quic_anusha@quicinc.com>, Luo Jie <quic_luoj@quicinc.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanho Park
 <chanho61.park@samsung.com>, Sunyeal Hong <sunyeal.hong@samsung.com>,
 Shin Son <shin.son@samsung.com>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Alina Yu
 <alina_yu@richtek.com>, Andy Gross <agross@kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Wesley Cheng <quic_wcheng@quicinc.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20260622101606.485961-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5NiBTYWx0ZWRfXxfZMDZZgeuIQ
 /9+UbGvjLPfT/kQYWoaG519iMU3z/MK/D1kVMPXYvTEaDSTSOaoKj6y1dZEFoNz+RcByP+qZ+qI
 FGjsRtJ+TafmnJIFeTokElfLN87iRxtDWbl3AVi1doZBJ1BHr9DDqSD5ctAkRkAymWlkdUq/NJR
 ieR8uZTLqW9ajw535fbhJ0evQfRmEs2tWQx7iY2qkiarHk9Zqu9p5VUBgv7hn3nhgIAkJEiM+Y2
 Uv1BekjEm+McPNAF4RHXU6s/pewuFoF1/jiHBzVaYAIvepiqWz5xb6D/Z4CzwojfQDzC1Zo3f3H
 JH/lI1c2mVWrMUtjJQqTg6yhDXeobsYgOulMjCNwo6wKYWY/Q/vr0KkbiYTajLB0YEOk7/v3C3q
 Dl7LH5exJdMnR5wkVN+TIlGj7v9iHA==
X-Proofpoint-GUID: kvO3KYbTIdZqYSxdRIrSPDcXolkDzHEu
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3a71fd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=fqWYVyBuAAAA:8
 a=EUspDBNiAAAA:8 a=p1VIHm5NO6eVjb5xVX8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=3EkFFxAVN7Xjp7FSp-fE:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5NiBTYWx0ZWRfXweWHurwRLsNd
 ks8j3Yj11hvKykeF1zohPyWR7Y/J73Tj9IV9pFG9LAxJ0nI8lpQcQlJkqn8wm3DD0tnTsmW8Lwo
 HDdt0N23dufi9DiUdoFZkRMrwor6V1g=
X-Proofpoint-ORIG-GUID: kvO3KYbTIdZqYSxdRIrSPDcXolkDzHEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230096
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

On 6/22/26 12:16, Krzysztof Kozlowski wrote:
> There is no use of double colon '::' in YAML. OTOH, the literal style
> block, e.g. using '|' treats all characters as content [1] therefore
> single use of ':' in descriptions is perfectly fine, whenever '|' is
> used.
> 
> Cleanup existing code, so the confusing style won't be re-used in new
> contributions.
> 
> Link: https://yaml.org/spec/1.2.2/#literal-style [1]
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Intention for this patch is to go via Rob's tree.
> ---
>   .../devicetree/bindings/arm/qcom-soc.yaml     |  4 ++--
>   .../devicetree/bindings/arm/qcom.yaml         |  4 ++--
>   .../bindings/arm/samsung/samsung-soc.yaml     |  4 ++--
>   .../display/msm/dsi-controller-main.yaml      | 20 +++++++++----------
>   .../display/samsung/samsung,fimd.yaml         |  4 ++--
>   .../bindings/i2c/samsung,s3c2410-i2c.yaml     |  2 +-
>   .../interconnect/qcom,msm8998-bwmon.yaml      |  2 +-
>   .../interconnect/samsung,exynos-bus.yaml      | 14 ++++++-------
>   .../bindings/leds/qcom,pm8058-led.yaml        |  4 ++--
>   .../bindings/leds/skyworks,aat1290.yaml       |  6 +++---
>   .../bindings/media/cec/cec-gpio.yaml          |  2 +-
>   .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |  2 +-
>   .../devicetree/bindings/mux/mux-consumer.yaml |  4 ++--
>   .../bindings/phy/samsung,mipi-video-phy.yaml  |  4 ++--
>   .../bindings/phy/samsung,usb2-phy.yaml        |  2 +-
>   .../bindings/phy/samsung,usb3-drd-phy.yaml    |  2 +-
>   .../bindings/pinctrl/samsung,pinctrl.yaml     |  2 +-
>   .../bindings/power/renesas,rcar-sysc.yaml     |  2 +-
>   .../bindings/power/reset/restart-handler.yaml |  8 ++++----
>   .../bindings/regulator/maxim,max77802.yaml    |  4 ++--
>   .../bindings/regulator/richtek,rtq2208.yaml   |  2 +-
>   .../bindings/serial/qcom,msm-uartdm.yaml      |  2 +-
>   .../devicetree/bindings/slimbus/slimbus.yaml  |  4 ++--
>   .../bindings/soc/qcom/qcom,apr-services.yaml  |  2 +-
>   .../bindings/soc/qcom/qcom,rpmh-rsc.yaml      |  8 ++++----
>   .../bindings/soc/qcom/qcom,wcnss.yaml         |  2 +-
>   .../bindings/soc/renesas/renesas-soc.yaml     |  4 ++--
>   .../bindings/sound/qcom,q6asm-dais.yaml       |  2 +-
>   .../thermal/samsung,exynos-thermal.yaml       |  4 ++--

Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com> # thermal

