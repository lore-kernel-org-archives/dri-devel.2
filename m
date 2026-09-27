Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49040C98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 21:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33BED10E6A9;
	Sun, 27 Sep 2026 21:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="lsv/0B3L";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7024D10E6A9
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 21:00:11 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48882c1f261so750527f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 14:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1790542809; x=1791147609; darn=lists.freedesktop.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HdQLpvgoc2kmRQGNUAWswTV8bwgORG4pWTKI2Gc4aS0=;
 b=lsv/0B3LYj0AU9YbrRyq2DiFP46psMqFe2uo9rRJmLwarC/W1BlP9CUw1QqYjwB1H1
 FuSUuUCoaBVrS5ua5CUXvNUDBu9HiYg+Beps9484/kWXnyE4MgStcFYA66byytT/o8bm
 PEP+SMJ+5nlZlRttaFJBQ5SRU05QzrS3KuoROOzEaNrP2is+2LD7dOQDv08AWYtgprw8
 XShsADUQE8tA8UK3fBkNWUEXXw6Tivtmiaxmn/BVbQ8PD10e7qjMv/xIS2BY1gJsEm+r
 SQK32tDKQzpTAp9viM/HKLuxBSAjwtQ96TrU5J/SV8xxfgH05dIFGN506HHW56W+GsCa
 lMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790542809; x=1791147609;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HdQLpvgoc2kmRQGNUAWswTV8bwgORG4pWTKI2Gc4aS0=;
 b=u2GeIBuPFuaHHVUYdmtj58mYa6VNIupiOi0xIILXFo+Y2CAx2qj+ZGd3xuZD681vVD
 6NH8znr6wAQU+jRtVQj8+8fLmNGjsT1gTomdK4JTfvByUP964fLFcFcnFGOF6WkdRtdS
 L2EgSdabsKCf/YVZSJnfATcmuKVHxNNeWLIiuBVhXWAxNG70vnXm81zVi4z5oAK1h0bb
 w4PjXUYy7xM98gjpOhQD3autBP1zSV9OLEzTTHxCPLwLx+GX2QV+LisJMLo8PQ5Ovnh5
 hz97QEeXgoD6uMAgrOTXZ5LUYhpLM/nwN7l8kwTYl9iBBEg8wvsorIlv8pucGckKD9wh
 ebow==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+LmdpTIen78hLh1/G0x0Uui6RqGRNChllRLguNAANVnbWbPlEB98MC3HT7UGBF+wYdz5ZZdcIznk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nOdUP6eEMQqIwCHVxukof9SbrZI+Smh1k0xJVD9jPKZhLBg972
 P2iSeBW7pogyjDYy4qKdNSRDsTIq/xenuA1jzma3OKZtD10YeVfevayZXNOanOqin9Q=
X-Gm-Gg: AYBFou3itEKzvpykkAwClv1auQy8smKPvoYtiexu80Dx1QB3G1zD1maEyo4QUlod3yl
 7/4vBZzTtf8ooFfrVT2GyChnhzZdfWYN7nHAYz3UsRI57IH6TnBkYtI1utyoSby9pKF/Hb8dHxM
 kUWbJkjR9VWsd1mehMzVRNkViX/sGtGWKif5BSl/YbmzCFPcy4agTCVvItJqXzj85KlCwlpI9bR
 Dr6rSCPvKoGJC1KzD9/HdgLeK5ou64xs0TZK5mIZB+5e4y0nCRy1sXE2VoF35UdaS3cuzEoB1If
 57zf5lZtMIQ3DKWZ46pBlbvJzViBSSOB5rCagWiuV0tTjIjRSFDOnuZfrhb1+6LOVowUwRA5Ocw
 RYh9qEZ20hAsCWidX09wVNJq4OyWUF0XIh1acHXLORRIavP6gtWXHZDW2Hxm5GDvHbuhxV7wjXp
 Vuw6GUiPAEUpdlnhCMZ/8Vuk6Ouc2YhiNoPIeIudOiHhD5Th9t8PZCtoq6xq5nJJbLxjhKFSI=
X-Received: by 2002:a05:600c:4e53:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49fe66c8288mr201327785e9.4.1790542809339; 
 Sun, 27 Sep 2026 14:00:09 -0700 (PDT)
Received: from localhost ([62.217.52.92]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fee6ced69sm146468965e9.0.2026.09.27.14.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 14:00:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 23:00:07 +0200
Message-Id: <DLQEGA48W7X8.21N6R6EPU8C@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "erebion" <erebion@erebion.eu>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] arm64: dts: qcom: sm6350-lena: Add flash LED
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
 <20260926-pdx213-upstream-3-v2-1-b4612e3eb536@erebion.eu>
In-Reply-To: <20260926-pdx213-upstream-3-v2-1-b4612e3eb536@erebion.eu>
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

Hi erebion,

On Sat Sep 26, 2026 at 4:00 PM CEST, erebion wrote:
> Add a node for the camera flash LED found on the Xperia 10 III
>

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> Signed-off-by: erebion <erebion@erebion.eu>
> ---
>  .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts      | 15 +++++++++=
++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 6e2bbf4f060ac..79aa2521aed40 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -4,9 +4,11 @@
>   */
>  /dts-v1/;
> =20
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sm6350.dtsi"
> +#include "pm6150l.dtsi"
>  #include "pm6350.dtsi"
> =20
>  / {
> @@ -302,6 +304,19 @@ touchscreen@48 {
>  	};
>  };
> =20
> +&pm6150l_flash {
> +	status =3D "okay";
> +
> +	led-0 {
> +		function =3D LED_FUNCTION_FLASH;
> +		color =3D <LED_COLOR_ID_WHITE>;
> +		led-sources =3D <1>;
> +		led-max-microamp =3D <180000>;
> +		flash-max-microamp =3D <1000000>;
> +		flash-max-timeout-us =3D <1280000>;
> +	};
> +};
> +
>  &pm6350_gpios {
>  	vol_down_n: vol-down-n-state {
>  		pins =3D "gpio2";


