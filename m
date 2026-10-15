Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DB6CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2082C1122B6;
	Thu, 15 Oct 2026 10:46:52 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F181122BA
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:46:40 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jTrI2809328
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O18SBrU7L9QrFSh6HrVkIKkdn/UBtVI5QfKtA2OKja4=; b=AVJh1QPEE1xL6NOU
 5JA6WjsNz3q6/xIgMbFw/5D2DZPNozgYtissPFIO7qxyrQ7h49jiNzo3c6vVYzGb
 JpNhxsXQys3NRPOrODWN1I8k9FbuKdKi9mMZdk5Re1gkY0PERpFDd8MlSbrRZqnH
 qHjYkFnZ1hN0DbHD/xmp83kuJZkJGVzCET+nYRY1GuSzVyOyitOsSVw6p1/rgy9m
 ZZ4p456kwgfO3Cfe7PO2a7Kk5xN/BqEeXo3A2MsPDXFpahnz+twYMsHv2IF0K3Uj
 EdTgi5lpTYkNSdQp/GVbD4xygxxISzvRpCHU6cadfLyfHYTBy1XpKc1CmXGPfpv/
 jYSeSA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4han54t58d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:46:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ea8a9cfe6so89660985a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792061199; x=1792665999;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O18SBrU7L9QrFSh6HrVkIKkdn/UBtVI5QfKtA2OKja4=;
 b=al3VudFi6K6WEEQcGdHkaeS+c2mPPdtnLAWvTEUk1XaumVzldIYtMfX+QoFkpsEzl3
 EZMhoweWDOoHpmZ5mFvzCU6bOhasYcJyatI9ADx8+uMl50z8bcANGxcrYkbrTwhg9CQ+
 +KaLb37IqgNbVZ9b6w43JcRpdH/PcJn82vywBV2YtorF8z9lGThl44c2xPu6ClU61Y41
 jhMtYkdsVHqJqxUWIvuBFuv1NAGKckNBD5wHWSKw1QJKXrf331R+JQ1xPtCA9Ua1oA/n
 SsmmdyvOc93uOXuEXnEU0uPXZQWTcZPK0CLjr9SiFw27e+tH+Rc0yd9Kji3wyUoOGBD9
 gkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061199; x=1792665999;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O18SBrU7L9QrFSh6HrVkIKkdn/UBtVI5QfKtA2OKja4=;
 b=J/jeTV2efyuEMMnGyJMVErOS9Id+iT3SRD22sj+fJ1MrrUVSpvl7TL3BcYZ8MPVMlg
 TwAc3N3D2yd5eYRSlxoLg0gUd1C/OSYVWOfM1FcM01CEzER60Bn43tP/ey/5XvFChcjO
 T5IO2yFnHmWq7sXPjpA3+vVxN56lX1K8UflK50Il1gdDNz7sPZpFDFTQgT6bYWDagbMu
 c2PV9i98lh0HMVnW/nBmjoqVoBneYbPrd98+uIq30oMGIum77wj8zraSxW6KbxtLGFAg
 QOL4CGkmR1sfKfIAwdTAUPRsO18LVoWdScxBUih7xJV8+wVyscHlh+/rlD5GZA4StzQA
 AjBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz08Ynh6eWHKTBkuOSt52J+MlRSEiGyS9XeyCm3zQuD5zYJvzTWyCVgOMOjoD7bIUk2Fk6EMQJL+3g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ4tl74+SEtx1YcUoLn0th/uDi/qPZFOlsFxA+U5nhg538gY+r1
 z7DBLPV/i1day/3A6x19Ys7lv/69NFz78V0sAWlzSHups8F+OFylnupOHeeKf3b0Yk/PCIagZQe
 yllbmOQCdUsMLpxakglHPoVh4+ttKVzxHXvfVHycVUXZ0lgkU6rfgSQYMR3C8UspZLaZnKeM=
X-Gm-Gg: AYBFou0h/Do9AkROiYogbBYhIuthLxs/TSKA/0wlOvSsZsZsOIt6uLMe8n4pJ9OPEZm
 5bV83pbxIC8LaxWeabp3f3OSL3WYU9MYX+t/KbcHq4/EMDJX5flACUfN8DmfLt3mhHWIZeMFSVO
 7jfo09sf0kH37z1AwdOcpI3DidyCZQ6dteK3tA0SYbfvLfrZ5zTklQ535JyP+/SW7Zx3t5ocx/p
 1F9RiRNuPqTgZimv7qKGLQGYkKloTIhqMgCsTcXHaxRg9GTSJeO3MBVDeW0EFRlNrAqKVVPeceI
 OuQxe4WAkuNUDk8+LjtmcCR/kjI1AQSqxpEiL35/7RW0WeI9Rae2lXcwn4aoRCsSEF9+L8XDYbh
 m/RkIdT1DdxG3XnTXTYTkcg==
X-Received: by 2002:a05:620a:6506:b0:93e:508b:7800 with SMTP id
 af79cd13be357-93ebcd29970mr3116765785a.0.1792061199035; 
 Thu, 15 Oct 2026 03:46:39 -0700 (PDT)
X-Received: by 2002:a05:620a:6506:b0:93e:508b:7800 with SMTP id
 af79cd13be357-93ebcd29970mr3116762485a.0.1792061198512; 
 Thu, 15 Oct 2026 03:46:38 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3eda62d2ebsm107780266b.74.2026.10.15.03.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 03:46:37 -0700 (PDT)
Message-ID: <0f3f754b-c612-406e-9d35-6966e64a876a@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] arm64: dts: qcom: sm6350-lena: Add flash LED
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
 <20260926-pdx213-upstream-3-v2-1-b4612e3eb536@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-pdx213-upstream-3-v2-1-b4612e3eb536@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RYQFmFtv c=1 sm=1 tr=0 ts=6ad0af0f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=JgZe5hknAAAA:8 a=INp5xvtxXxILuIktMPQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX4gyPocID0OKL
 YpT1bPqwMLyOGrMjj/l5tsjPJKva+nphu8MnBftfUQcwrLSTAViVHQ0DrwR9rVQp0iIaWxrT79r
 vzcylOQ9hTDv7qj5qeZ1gxRCalOAFg/IlCQ+858zWjSoUfa87+VqnaDGOIadsUZz3Z+u7wFsSzd
 C15F9kag+rlpPV3bhWWY7N33espWF4ah+pdr9n78B4YWb/qh4oPHWoonuxCyqVf0iEMBHS0mOiH
 GxvKvdv+m7ToGkvWIfZiPb3srxWZfGoc14be7tct3e/UoFT+quJmrQroYKblHTxtM60T61oY/XQ
 wPPABTuPUNv4LUW7mKIxLtG704opQkCSAGwzlcDqIgbAgRczeNSIjn8qzt7lyI/WCa7eVoBlRZ6
 tPTRe64UoQ6c/VULoun9h7t+7S1YMkfw1i5XgjnYCSvUgMUXMEdLDZ0mhVWIh8xrx4dK52TWu3V
 B1Ju1lAjJBLgTFqG+vg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX/Sk/Dia51k3A
 I9xKBtEHAYUq3/Z4wSDziR5BeKGVPAXBA9/pRYKLQ20NhhgEAN8dpB5aZuA4ZCuPJw7Gh8IvVWP
 ceY5ji9OCijVaEsf0KsmzYe+6EDjYkw=
X-Proofpoint-GUID: cTFUkXiUnZAqFdHYOsW-gAAOY3w3OBrg
X-Proofpoint-ORIG-GUID: cTFUkXiUnZAqFdHYOsW-gAAOY3w3OBrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150042
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
> Add a node for the camera flash LED found on the Xperia 10 III
> 
> Signed-off-by: erebion <erebion@erebion.eu>
> ---
>  .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 6e2bbf4f060ac..79aa2521aed40 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -4,9 +4,11 @@
>   */
>  /dts-v1/;
>  
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sm6350.dtsi"
> +#include "pm6150l.dtsi"
>  #include "pm6350.dtsi"
>  
>  / {
> @@ -302,6 +304,19 @@ touchscreen@48 {
>  	};
>  };
>  
> +&pm6150l_flash {
> +	status = "okay";
> +
> +	led-0 {
> +		function = LED_FUNCTION_FLASH;
> +		color = <LED_COLOR_ID_WHITE>;
> +		led-sources = <1>;
> +		led-max-microamp = <180000>;

GPT suggests 500mA here

> +		flash-max-microamp = <1000000>;

and 1500 here

but the downstream DT is noisy.. please verify once again

Konrad
