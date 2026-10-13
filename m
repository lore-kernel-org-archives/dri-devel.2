Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E77CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB0D410F6C5;
	Tue, 13 Oct 2026 10:10:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE6ED10F6E3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:10:28 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8RZjI3907366
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JaWEQZWW26qUB0UpQWigzCRt6cE6lA4BoKS/zHeTD8o=; b=f2tYKyr8upCq+Mcc
 2UPh3aLmC+nVXmBww/2aIzDlz5igVDv7ahV1ouVe2dOJfzr0iDMTih/N/apdPHOw
 T/Klz6WE8c9gOERHjh1Dx0qqdquyyR4AhHvhsY/q+hOvKW9P4kgcepMbKI6uo6x/
 YpnXLiwOoaZmg/MGuVNNJUhJQ/Fv9DM/ZJzshTvEP5IMyF32V+kyWgLS8V853jJ2
 Eup1HI/4yBaH5DbmSTDRvFHlBEWc2ioRLc9qiFHmMoHuwXS0oNyN5zHDn6SpReOB
 AeLxDS4WC2aLnxGhGHLqo3qHoMh1xzOrYTLxpQ9yfd5u886XQ7q7dTtPHLfXPtS5
 m/e64Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h95xqtybe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:10:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-917a54501a8so8240916d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791886227; x=1792491027;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JaWEQZWW26qUB0UpQWigzCRt6cE6lA4BoKS/zHeTD8o=;
 b=e/iquPyUNbZn1wf+OfayiKeWK6XfYG2K5nFKc0tcude00iV+sfFPhgF+97DdC2oKNi
 eKzVz2oBX2gelifzcSHTJ2zWZRx+nKQZsFcv1Y5f1g2oJtRds2/H1mGPKJZhXhqCijCC
 BoHcj8+Mjp25SCxSvu2MrEnMG2fuVK5vNNc6t5lc17pNG7rNfCqSzwCti4K72gtuy8wv
 qlyEWGdpcYM8Fq95bON9m3+myBmonEmrWJa0EHl1WqfuSSk7vbjTjYuGB98E8sPV3IYk
 YHRUMpREZv4Etb/GDYTWIcpEn8sTQ4TXsk43LTOV5oX31rcF5Jyfwt+y2KU/wXuQ4KwQ
 AiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791886227; x=1792491027;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JaWEQZWW26qUB0UpQWigzCRt6cE6lA4BoKS/zHeTD8o=;
 b=BJEgAXEkl4DWQutl36/8OC2BTzIQZtI65XK5RQm7KIdO4HfxkUKLHxvr7DdlUMySVj
 REzfr33mbuNUghhX2SvRqV1cHVwATWTGpCXbedWA2xQtW+801cRPGivQu0H9gTeX6Y/P
 xXgS+cYaeww+JAza58OBSbIvP7Q9cZLOfw2STfuUkmAcokxOcsRZt81tAvFq3Kk6/tRc
 nrkau7feR/UV6EOd41QfHahW/+RnnDMGowrReQ2tHGruV/1NvOTON+LLAX8++9lt4wDf
 D0taYFQ456uTrBmmb//JLir8N4owa67P00Rr1XGTQ0s5oYevkgpNUbDLQYZ5VQdgGqqD
 SlOw==
X-Forwarded-Encrypted: i=1;
 AKwUvByXSvoPZyIMCz6DsR/2fCl8adbrOAn0v9O9VBE3TrdjH9mv4OW+xGBKKHA+pkTuGGA+7e88vWGi5r0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI7TaO8PfHX7U0sZx5+bZUvEWLKkggxMQf4DBpusPTLriDTkjUW
 dkuuwF73B5lc/0V9mpb2xRTT/5P128WKc7v3gzrYERDb/1lBBtNVhopFTqSTOk7RWiJRP0RKf+m
 wGW23WF6xph1B4MkGfRO1iG695DgzwWsgUfMOdAY/2sMeGnLtJwAVYG/ImNo6gqqHxj3FmOY=
X-Gm-Gg: AYBFou3xO3Cbv0jx9HfkakVBuL/hdqig0s8MrAfQ29py5Hpsads6y/UvSjjmR9/Fp21
 HC55MtcttxPadHH+9YyVxYdTiioYf06GKEfr5Fsp5Ti2uNNJH1KNB0XRTE0z50nW93qx1DDf6Oo
 yThZRzuvIof9kCPxfqGlIKHvFuMlIS8NsKLF5puhsTxjMHg0APWxQJ4vdQjpa39nQk6HQ/19eSx
 9esDgZH6byLIGSrznk/pZcDf8nJcZTiiZActTHWgIDpnBbN4NZ7ucSJkfeIwqKYwJFyZUo61aKg
 45MXM6JgGMaFt1g1LLYSwkV8EleqIur5fWUO9OEd44pis7bfyWdqt8G3Al4nftA0BRkms+Yhrse
 bUwSU+8ERUw8lGMT8brvSHg==
X-Received: by 2002:a05:620a:19a2:b0:93e:54d2:2283 with SMTP id
 af79cd13be357-93ebd2955edmr2138498685a.6.1791886227082; 
 Tue, 13 Oct 2026 03:10:27 -0700 (PDT)
X-Received: by 2002:a05:620a:19a2:b0:93e:54d2:2283 with SMTP id
 af79cd13be357-93ebd2955edmr2138494285a.6.1791886226526; 
 Tue, 13 Oct 2026 03:10:26 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3350fcf309sm353463166b.39.2026.10.13.03.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 03:10:25 -0700 (PDT)
Message-ID: <fb634f17-de56-4f43-b139-3d040a35f019@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add Samsung Galaxy Book2 Go
To: Luca Weiss <luca.weiss@fairphone.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Jasper Korten <jja2000@gmail.com>,
 Federico Amedeo Izzo <federico@izzo.pro>, Luca Weiss <luca@lucaweiss.eu>
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
 <20261012-book2go-v1-3-7188e7ea7a15@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261012-book2go-v1-3-7188e7ea7a15@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfX77qtR/ZVlvCg
 hCOJ3QjvPOmN1VCKp8To6jWeIfB8QOvK2zDiho1mpcpkdSWlEuFO1c+JG1YttEutTz2dHWWKpex
 jdGzH4dykvHlzn7p2DgbRtWwnESN+k+AuLV0BKW9X7aMyOexK75CpLOV/JRsHhsPW3ejZ6er+Bd
 uv5ZohQgr5lTsl3vOcUQaEkkQkIpLvO/7N47B2jxODoXY4R5eeJl+K19yoeKWVdw3iMPfgYQmGR
 43rAycKhSGEn3Wdt84Sz1EGYUughD5/0ZmxRo1m+xwSCxdL+qHHRn1Z7kUh2BsGhk7WG/UXhH0Z
 8RmvVk7q0Qt3RvV1yrlWAh9yChQUkYUgAtNnHw7czICRueq9O6jpT9nUKxhrx+t+ijrTSxF7ROu
 ujC6ZJ3LjGq5iDlWk4Yv4+jarToV7PI3nHKJIWnSASBE4J69dhaISPee9BB0Sd6AYYP+13WqrKu
 6jZEqpV6ECrHMmx7Rlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfXz+O31Bv2WGKP
 oUBAe1MJvPJtt8ImHKTaDuPWSh2xfzya68cNtuNJSe2huGq0kIvoVzRERSyTGHcEliuBBLJitDv
 nx6LSgBAHViH38Bs6HYmNyedZrKVxSk=
X-Proofpoint-ORIG-GUID: ENjEs6Co9ktF6hA02wCb9GqoHc03SI2E
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6ace0393 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=dlmhaOwlAAAA:8 a=6H0WHjuAAAAA:8 a=RY9Homj74iP04qnvyqkA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=y4cfut4LVr_MrANMpYTh:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: ENjEs6Co9ktF6hA02wCb9GqoHc03SI2E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130040
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

On 10/12/26 8:11 PM, Luca Weiss wrote:
> From: Jasper Korten <jja2000@gmail.com>

[...]

> Signed-off-by: Jasper Korten <jja2000@gmail.com>
> Co-developed-by: Federico Amedeo Izzo <federico@izzo.pro>
> Signed-off-by: Federico Amedeo Izzo <federico@izzo.pro>
> Co-developed-by: Luca Weiss <luca@lucaweiss.eu>
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Good to see the Lucas are in agreement ;)

[...]

> +&pm8350c_gpios {
> +	pmic_lcd_bl_en: pmic-lcd-bl-en-state {
> +		pins = "gpio7";
> +		function = "normal";
> +		bias-disable;
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +		output-low;
> +		power-source = <0>;
> +	};
> +
> +	pmic_lcd_bl_pwm: pmic-lcd-bl-pwm-state {
> +		pins = "gpio8";
> +		function = "func1";
> +		bias-disable;
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +		output-low;
> +		power-source = <0>;
> +	};

Drop the output-low, the consumers already take care of the state

[...]

> +&uart7 {
> +	/delete-property/interrupts;

Let's add a space after the '/'

> +	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
> +
> +	pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>, <&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;

And let's wrap this line

[...]

> +&usb_1 {
> +	dr_mode = "host";

Does OTG not "just work"?

I'm assuming there's no pmic-glink on this device?

Konrad
