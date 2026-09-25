Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF392C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 180DA10FBD2;
	Fri, 25 Sep 2026 18:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="dybEE07j";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="6hkU80fp";
	dkim-atps=neutral
X-Greylist: delayed 463 seconds by postgrey-1.36 at gabe;
 Fri, 25 Sep 2026 18:00:22 UTC
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D8010FBD2;
 Fri, 25 Sep 2026 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1790358748; bh=nNXRZZyO5E6gJXFXSSEbRo7
 RUD3G589ViTisRDLWX74=; b=dybEE07jOsSg2uVQbdrgvnpMJTnRpLxDanSAyANWMHaXeM16IC
 g+Oov4sM3WMnWkgiJGGW8xu4nutrv3Tr/NqSZZvIVJ8s9+uiaRf/Typxm1P5yJhO8ZB88O64D+0
 lpOMx0wfsRL/dNzTfD7yiUy+89mL5zAxuU9//TMhic3wpj8yvnmPjWXaTl3gJAlNnSYnYr9KDbC
 NmJFr4eOi9atCKMb2gbjhSGewJ2gXNBKZseJlACHY1NqlMahuFSMUNWb4DNRVxR3qHaIJmrSwJ3
 dpm8w2QjZAy4+1mrqgOGkOBJAMz65Oo/fgW/8jFyNuEMTzdv2S4kfo7lmIfDipvSa6g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1790358748; bh=nNXRZZyO5E6gJXFXSSEbRo7
 RUD3G589ViTisRDLWX74=; b=6hkU80fpF18eaotihI8czs8zqTmN9aBl918adzBeqol+4g+4I5
 AX114HYqQ5r0FqT8+yWyI6FklC5LOVeiPUBg==;
MIME-Version: 1.0
Date: Fri, 25 Sep 2026 19:52:27 +0200
From: =?UTF-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
 <barnabas.czeman@mainlining.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: kavakliyigitcan@gmail.com, Lee Jones <lee@kernel.org>, Daniel Thompson
 <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Pavel Machek
 <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller
 <deller@gmx.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, Abhinav
 Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 10/10] arm64: dts: qcom: sm6125-xiaomi-ginkgo: enable
 display, backlight and touchscreen
In-Reply-To: <fe437142-eb1e-49d3-ad3f-704066bea53b@oss.qualcomm.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-10-0e68e63a18d4@gmail.com>
 <fe437142-eb1e-49d3-ad3f-704066bea53b@oss.qualcomm.com>
Message-ID: <37bb460f800995ee97b4867e09c04ebb@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
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

On 2026-09-21 13:26, Konrad Dybcio wrote:
> On 9/11/26 10:51 AM, YİĞİTCAN KAVAKLI via B4 Relay wrote:
>> From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
>> 
>> Enable the display subsystem (MDSS/MDP/DSI0), Kinetic KTD3136 
>> backlight,
>> and Novatek NT36672A SPI touchscreen on the Xiaomi Redmi Note 8 
>> (ginkgo).
>> 
>> Hardware nodes added:
>> - Fixed LCDB regulators (lcdb_lab and lcdb_ibb at +/- 5.5V)
>> - MDSS and DSI0 with Tianma 1080x2340 FHD+ video panel
>> - I2C1 backlight node at 0x36 with PMI632 GPIO 6 hardware enable
>> - SPI2 touchscreen node at CS0 with GPIO 88 interrupt and panel 
>> follower
>>   reference
>> - Touchscreen active pinctrl definition on GPIO 88
>> 
>> Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
>> ---
>>  .../boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi | 100 
>> +++++++++++++++++++++
>>  1 file changed, 100 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi 
>> b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
>> index 
>> 59042a5937535c4acda064fa0f865f4f5a52d01b..f4b9e2092a814e56cdc23218025cb4166dec110a 
>> 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
>> @@ -26,11 +26,30 @@ / {
>>  	chassis-type = "handset";
>> 
>>  	qcom,msm-id = <QCOM_ID_SM6125 0x10000>;
>> +	qcom,board-id = <34 0>, <34 1>, <34 2>, <34 3>, <34 4>, <0 0>;
> 
> This should be a separate patch with the reasoning for the change

board-id is not neccesary for this device to be able to boot so it can 
be removed. I have already done that before so it should not be readded.
> 
>> 
>>  	aliases {
>>  		serial0 = &uart4;
>>  	};
>> 
>> +	lcdb_lab: regulator-lcdb-lab {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "lcdb_lab";
>> +		regulator-min-microvolt = <5500000>;
>> +		regulator-max-microvolt = <5500000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
>> +
>> +	lcdb_ibb: regulator-lcdb-ibb {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "lcdb_ibb";
>> +		regulator-min-microvolt = <5500000>;
>> +		regulator-max-microvolt = <5500000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
> 
> LAB/IBB and LCDB are separate hardware blocks, only LCDB is
> present on PMI632. It provides a pair of pos/neg bias
> voltages. Looks like downstream has a driver for controlling
> this block.
> 
> Konrad
