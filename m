Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744A0CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 17:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D033610E945;
	Mon, 28 Sep 2026 17:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="C4Lhhx+6";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58EB10E951
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 17:33:43 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so24642895e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1790616822; x=1791221622; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nm+H1sF5plZg2FFwBIfCS3h66ScIgoJSGwKlR3JKRkg=;
 b=C4Lhhx+6vWDH+NAVlRY3si8o3871VjcdArpRlmeA+PAMJ9ZxmYRL6cmD1QGzU3wxZe
 ddPXuvOcQBtuSGBFSLNtKjOdQuNQd1CUMIXqa8RcWa1i1CkyRNqIZib+xEXgjtblVXr0
 mPPGwlt3zYw/tJ/SngcxP7XGMYiiGKjcjwVnuNYKC8EEUlTJwt9/XfUyFvl6aQf3/Hpy
 9uBdWmdgL5tKHvMQRt5Jftfp4+XatQnThczRgn/+9yilTA1Nf6RVWOC4BsfyARk0YOHr
 IbI8I253e1hVqRfSebXC9YeKhn1fbqboDsg5wh1tguD0rBzHypCULSWp/amZjDKoanUC
 b7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790616822; x=1791221622;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nm+H1sF5plZg2FFwBIfCS3h66ScIgoJSGwKlR3JKRkg=;
 b=qFGqmecgIhqqFiJRh6h0qh98njWUi8BINhncDG8MIVEL1EcbM4TpcPfxzihjJrJgIn
 BDn9rrvE+3BZvvKbq3WTxnhajnnB3mOYeHAE6lXUBAokKTsI/IxLLYQNH6o5KunnACNQ
 apXutaleffc2L+C4Gb9FkEZYH3XmTzODb/9SkD690WuTKiOjzUFf28XydkL/28IztZ8c
 7G926JPCb8PDIhDQOLysCyuI3kcDGtkHu4ploem6c1sFypLpO4jN9AEDQUKZGA5Lt39w
 MTJFt96UtCHvejMQT9yKQNlPE4DevogWJ7kDHuyuuMZUiGb2D+NxGF4Id59kVLhzYi8t
 RdCA==
X-Forwarded-Encrypted: i=1;
 AKwUvByWERzgDe4dLkdrpROIUQ4mPjIB1znrHJTXS70HugRDFgh2hTAPJtWRv1No1cFPix/TvyZqtjP4/8A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mQKKELFCj6Xr6tKWYA/+Y6utnWo91CWblq0ZOlcukjZIvs5P/0
 nA2qODRksjZqpdYHcZMHxcTj8t1cAx6c4HY71qH7ClNREoIIGP6qi5AUZS9g+2eC+4A=
X-Gm-Gg: AYBFou2xXiXgky1rcjEuPf3Dedwfdn+Zw2SPFnzZIu/+ZE8gKl5W7tLTHBwNroS1c7r
 8k4P16HlytWRHWWkait+y4ZM8t7/1BqAsFbRruAvC4r31N7G7fl4NsGFkGM2iZ46XZ1ZvH+VHRq
 cSiiTFb1gMaNY/APKq/hemAnWolGWWb0ydWuXid6wYMA77rDH72oW46vgy19IHawHGQwuRTLX3L
 /lWc87+NIXKOm6M8ZPbNcMvyOniNGECMP2ZdkgTHLGHviKAd8F2QOF7DMwE+0jROA0hAu/e6XDK
 W0c/3PzNuVYJB4eVFTBbw6ljxJSj1inOT+p6MOwYrASPnu4XJjJqBo+AbYmwE2wv/J6HIgPruIo
 0Sa5j36WJgA5wCId47ldGH/c683YeVM6mVcXDVkm2/V/ACkpeiQD/wDnu9+5vVp1ib5eWyG+M4L
 LgGPhQTmWeqqHCuX8OffpcYHbOT33URL6urvdF0XU1qiACRNZJLZ9vlHN1nfvrKqtPP8I0Ep1NM
 ykz
X-Received: by 2002:a05:600c:4ed2:b0:49f:e3f2:f5a3 with SMTP id
 5b1f17b1804b1-49fe6685393mr248630105e9.0.1790616821952; 
 Mon, 28 Sep 2026 10:33:41 -0700 (PDT)
Received: from localhost ([2a03:2260:3006:212:74c7:e2df:8ae8:a3f9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfb479asm7566165e9.15.2026.09.28.10.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 10:33:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 19:33:39 +0200
Message-Id: <DLR4OQOPXHKZ.36X3TK68F75K1@fairphone.com>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] arm64: dts: qcom: sm6350-lena: Add flash LED
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Bjorn Andersson" <andersson@kernel.org>, "erebion" <erebion@erebion.eu>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
 <20260926-pdx213-upstream-3-v2-1-b4612e3eb536@erebion.eu>
 <arnF0u2F9ipfnNP-@zenbook>
In-Reply-To: <arnF0u2F9ipfnNP-@zenbook>
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

On Mon Sep 28, 2026 at 3:42 AM CEST, Bjorn Andersson wrote:
> On Sat, Sep 26, 2026 at 04:00:50PM +0200, erebion wrote:
>> Add a node for the camera flash LED found on the Xperia 10 III
>>=20
>> Signed-off-by: erebion <erebion@erebion.eu>
>
> Per
> https://www.kernel.org/doc/html/v4.19/process/submitting-patches.html#dev=
eloper-s-certificate-of-origin-1-1
> please use your real name.

Hi Bjorn,

As per updated versions of the docs
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign=
-your-work-the-developer-s-certificate-of-origin
it says "using a known identity".

I have met erebion multiple times at different events, so I can vouch
for them, in case that's what's needed here. And they have their website
and everything under this identity.

Regards
Luca

>
> Regards,
> Bjorn
>
>> ---
>>  .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts      | 15 ++++++++=
+++++++
>>  1 file changed, 15 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts=
 b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
>> index 6e2bbf4f060ac..79aa2521aed40 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
>> @@ -4,9 +4,11 @@
>>   */
>>  /dts-v1/;
>> =20
>> +#include <dt-bindings/leds/common.h>
>>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>  #include "sm6350.dtsi"
>> +#include "pm6150l.dtsi"
>>  #include "pm6350.dtsi"
>> =20
>>  / {
>> @@ -302,6 +304,19 @@ touchscreen@48 {
>>  	};
>>  };
>> =20
>> +&pm6150l_flash {
>> +	status =3D "okay";
>> +
>> +	led-0 {
>> +		function =3D LED_FUNCTION_FLASH;
>> +		color =3D <LED_COLOR_ID_WHITE>;
>> +		led-sources =3D <1>;
>> +		led-max-microamp =3D <180000>;
>> +		flash-max-microamp =3D <1000000>;
>> +		flash-max-timeout-us =3D <1280000>;
>> +	};
>> +};
>> +
>>  &pm6350_gpios {
>>  	vol_down_n: vol-down-n-state {
>>  		pins =3D "gpio2";
>>=20
>> --=20
>> 2.53.0
>>=20
>>=20


