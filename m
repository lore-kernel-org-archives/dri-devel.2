Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64DBCD6E57
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E01113EA5;
	Thu,  4 Jun 2026 09:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PMKjYmYg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kQB60YFs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1855D113EA5
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 09:59:22 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654784QB1476732
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 09:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PUsiL+sMTqw2BA6pSSQlXtUhqDxTlOvEKEB4d/D5wsM=; b=PMKjYmYg7tDzkNfL
 54nihwYnoojM1vkFUagTBALspgONiH0Uj0w2NCfuesxrLISx7+5P+ZmTeAYJjvQm
 sv9ec08U3WQCidSf7LwqpEsVvSDY9Sf48mVB2wvpTLiFKDCCAv73IY917lfNqgvb
 z62yun4Z8V0WLx1asbVW7kmMFTlrsZVRynKerUZCjWH9NQ9GPLMaqmu33SK7x5lX
 Fi+wUiDyIQzuugEWJUCEATiRlcxu6J/wa2ZjnmKuJm1i8RLMwkNHrpxk+ctXQnn+
 16HFpKgbb67ACLrx+KrcjiEK2jLPIfWF4Sx5/cb1IUPShQN3hxhze6XZ3N7I7LKV
 v3mxOA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejp6nv5ah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 09:59:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0c32f4b1bso6131035ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780567161; x=1781171961;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PUsiL+sMTqw2BA6pSSQlXtUhqDxTlOvEKEB4d/D5wsM=;
 b=kQB60YFsnZ25xnkRGFw3GI+wihdH5tdrZqrkQXNxfgYZA8do6Ub00Hb56DXIXz/ojh
 bZ/4WXGGwpjAOH1fxirbYonc+eLcsXFNzoDWmJei1z04AOdzj/o+2U23Xw4XfNP1BJU5
 jVcy43Wnbihgwvvq37pf/TVN8g8O7Nc9WS4w2GzCYRgL9tYACH7IvMdabPyA43NJ+J0W
 0FkqMHC+jpnRyI2Ng+Pl1LPyAkwOr7MiY6CLaKSnLrvNHP22N+fuX9Ao06PL2tTfMqNd
 8gGUwBRpbpJ/u1ra2Da90FB/eCJamIqwpr7stRqX+wH8ohjQe1FS6on03Vj1q01J2PIw
 Sf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780567161; x=1781171961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PUsiL+sMTqw2BA6pSSQlXtUhqDxTlOvEKEB4d/D5wsM=;
 b=kmNk4RAjcn3KrFgo070KhPrRQLbJj7OLzTStJu+mTDzLCUDnmW5sgi3iuSV/H8AQs0
 f6RU86I8DmB+Z9ptf04neRwQowSGZjmpKQxCfypTXhtNF0D7ApgJCs8pJ6NftBmSWoXS
 mF9dTRNsHzG0q8rr120hdVO0rKFTkq384CKnaRmxTnXcJWJf0iMAUBXCMv6KFk4GAPTA
 wG1TEmEWIJbQBNpVbeBIXNZrRbbTelGziEoaPfDb3HxtmFAfZFSNxC/VLT7byj86nW8Z
 QymhPXrv/6s/TQy2FNAVgfOCdx/bhCcZcjDFOLkPhU/B7Pn0i5+rkMI/DQZMd0nORrqK
 Ryvw==
X-Gm-Message-State: AOJu0YxHmbosRLgN8dMHvaOMRAOYTSTnDNNkoK/EamJL0NYAjgpuFfVW
 lqKfpYJ10LNsKSNpdQ9o8FbzSIH67P2DeI28Mj7lK55PmNnO4njpCvPKSOOWvKcCX9awWzr4HuT
 Nccd7NKeR4SX7hGTRsTSqwls7uvFvMwr7oST+47udlQR482FzbM0CDK1s0ps8MLT65WrTskE=
X-Gm-Gg: Acq92OE9583xD/2QEexuigfwzRSaqpzmbWFa7NjxGl+2+W4Sl5EyCI2Z/aQ/3a6c3Sp
 ifd5aGJuyQGPsQ9sRXvnozKPRFeIgU8wQzdRASx4jgqTc7KGU7/+2xyD1nU6NRhLY7G994rwrLW
 l9BOAZ98B6XDVduRC03S1o4PFzBIFsf2Faah9Rwu6Az4xxuWavTSS/fDrTaHXdSAa6LI5OlgdYu
 +om4KTODqGqWJbXA8bpOMl29DmhmWvefYhmWmTe0wX6mHKGBqn9bVeJjuGNZ0Zl5reMZEZUSbj3
 tFgyIaxfVnUPMLiat2L44Boq8HR5qMrL5CDBp8fxhqp+ce8IuEbo8biAW5z0s9YnEaBcD8qQO6E
 LuUmkfxAl/AOF+kqt9yCBVqTC+KuAGQo47iMqqAjMRZp00nzwK1XoB/zACxT+2rRF6IiGNO43kc
 i85UZshwbvK+v7HRJNVZokZA9RPPEbBCN2em4zaslV0z3VnUvlzL7u/B3fPA==
X-Received: by 2002:a17:903:22ce:b0:2c0:b5c1:8e3e with SMTP id
 d9443c01a7336-2c1639ec7f3mr78133395ad.8.1780567160631; 
 Thu, 04 Jun 2026 02:59:20 -0700 (PDT)
X-Received: by 2002:a17:903:22ce:b0:2c0:b5c1:8e3e with SMTP id
 d9443c01a7336-2c1639ec7f3mr78132985ad.8.1780567160065; 
 Thu, 04 Jun 2026 02:59:20 -0700 (PDT)
Received: from [10.79.138.73]
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6d59csm50731415ad.4.2026.06.04.02.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 02:59:19 -0700 (PDT)
Message-ID: <6d2ca392-148a-4539-92b8-05bdab1d07e3@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 15:29:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add Glymur-based Lenovo Yoga Slim
 7x Gen11
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-3-57c70c23d0d6@oss.qualcomm.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <20260604-topic-yoga_submission-v1-3-57c70c23d0d6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 018F5Kyxa8PV2mAJhWjD-oPuaawtCWoA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5NSBTYWx0ZWRfX7Cf0h83akEm5
 cSA9FEnQBmX0gCHjnXXkMadIDNGq+044wv/lUXWrtlE6FPk99MUAYohThgp9z8hk15BWl8dmAxj
 GmahXc6ysyOmRXXbFFc8CQeyUGnMGFnFFHmZZldt0NsKoXkydWBZ+T+dVquyDO2Y/HzeUJ7+OWf
 938tTPzuxYd+pUtDiJdp4YafCxn5ppbIMkZadVB7+aEVR+aFhiGoecIMTM1+pf2TppddExl8eZA
 nYWIteA3SXTSdNpOGsZLkDks3n9FTeKn2+ulRUfpMAkgm/nxLMVxd5Xrl9wPrLDXK0H7tUOTKYS
 4d56/jfadUPmsvO0JJJakvKEyaVQZppU+qv3yiRlsROBQ8k3AHDlV0utROspjmVIniutyHWTSyl
 nW6x31ROB1DHsJR3M7x8MrmSYMJmbgwfmrL+qLMWG1uPcibXcj3Q8/gs4Ad6uRY2ocN8Ojbnc3X
 nHHC2KVibNNH/lZZpSg==
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a214c79 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fkFsjA6a2Lb9G7MwmvcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 018F5Kyxa8PV2mAJhWjD-oPuaawtCWoA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040095
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



On 6/4/2026 1:36 PM, Konrad Dybcio wrote:
> Introduce a device tree for the Glymur-based Lenovo Yoga Slim 7x Gen11
> laptop. It's fairly similar to the reference design, although there are
> a couple of major differences, including a different EC.
> 
> Currently working:
> - Audio playback and capture
> - GPU, Display
> - Keyboard, touchpad, touchscreen, lid switch
> - Privacy LED
> - Charging, Type-C
> - Wi-Fi, Bluetooth
> - Modem should work on the SKUs that have it, but it remains untested
>    due to lack of access to such a device
> 
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Co-developed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile                  |    1 +
>   .../boot/dts/qcom/glymur-lenovo-yoga-slim7x.dts    | 1237 ++++++++++++++++++++
>   2 files changed, 1238 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 6f33c4e2f09c3990e90e1b25a6f7d618891948c5..4d2864b371e29925a3b3bf4de50efe709b971851 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -16,6 +16,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8096sg-db820c.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= eliza-mtp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= glymur-crd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= glymur-lenovo-yoga-slim7x.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= hamoa-iot-evk.dtb
>   
>   hamoa-iot-evk-el2-dtbs	:= hamoa-iot-evk.dtb x1-el2.dtbo
> diff --git a/arch/arm64/boot/dts/qcom/glymur-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/glymur-lenovo-yoga-slim7x.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..e7eb20ea81fa4e9b735b7daf4c27bb0feeeb6060
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/glymur-lenovo-yoga-slim7x.dts
> @@ -0,0 +1,1237 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +/dts-v1/;
> +
> +#include "glymur.dtsi"
> +
> +#include "pmcx0102.dtsi"        /* SPMI0: SID-2/3 SPMI1: SID-2/3 */
> +#include "pmh0101.dtsi"         /* SPMI0: SID-1                  */
> +#include "pmh0110-glymur.dtsi"  /* SPMI0: SID-5/7 SPMI1: SID-5   */
> +#include "pmh0104-glymur.dtsi"  /* SPMI0: SID-8/9 SPMI1: SID-11  */
> +#include "pmk8850.dtsi"         /* SPMI0: SID-0                  */
> +#include "smb2370.dtsi"         /* SPMI2: SID-9/10/11            */
> +
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +
> +/ {
> +	model = "Lenovo Yoga Slim 7x Gen 11";
> +	compatible = "lenovo,yoga-slim7x-gen11", "qcom,glymur";
> +
> +	aliases {
> +		serial0 = &uart21;
> +		serial1 = &uart14;
> +		i2c0 = &i2c0;
> +		i2c5 = &i2c5;
> +		i2c8 = &i2c8;
> +		i2c9 = &i2c9;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			clock-frequency = <38400000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-0 = <&key_vol_up_default>, <&hall_int_n_default>;
> +		pinctrl-names = "default";
> +
> +		switch-lid {
> +			label = "lid";
> +			gpios = <&tlmm 92 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			wakeup-source;
> +			wakeup-event-action = <EV_ACT_DEASSERTED>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		pinctrl-0 = <&cam_indicator_en>;
> +		pinctrl-names = "default";
> +
> +		privacy_led: privacy-led {
> +			function = LED_FUNCTION_INDICATOR;
> +			color = <LED_COLOR_ID_WHITE>;
> +			gpios = <&tlmm 111 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +			panic-indicator;
> +		};
> +	};
> +
> +	pmic-glink {
> +		compatible = "qcom,glymur-pmic-glink",
> +			     "qcom,pmic-glink";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* Left side display-adjacent port */
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_hs_in: endpoint {
> +						remote-endpoint = <&usb_0_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss_in: endpoint {
> +						remote-endpoint = <&usb_0_qmpphy_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* Left side user-adjacent port */
> +		connector@1 {
> +			compatible = "usb-c-connector";
> +			reg = <1>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_hs_in1: endpoint {
> +						remote-endpoint = <&usb_1_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss_in1: endpoint {
> +						remote-endpoint = <&usb_1_qmpphy_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* Right side port */
> +		connector@2 {
> +			compatible = "usb-c-connector";
> +			reg = <2>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_hs_in2: endpoint {
> +						remote-endpoint = <&usb_2_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss_in2: endpoint {
> +						remote-endpoint = <&usb_2_qmpphy_out>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	vreg_edp_3p3: regulator-edp-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_EDP_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 70 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&edp_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_misc_3p3: regulator-misc-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_MISC_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmh0110_f_e0_gpios 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&misc_3p3_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_nvme: regulator-nvme {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_NVME_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmh0101_gpios 14 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&nvme_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_wcn_0p95: regulator-wcn-0p95 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WCN_0P95";
> +		regulator-min-microvolt = <950000>;
> +		regulator-max-microvolt = <950000>;
> +
> +		vin-supply = <&vreg_wcn_3p3>;
> +	};
> +
> +	vreg_wcn_3p3: regulator-wcn-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WCN_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 94 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&wcn_sw_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_wwan: regulator-wwan {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WWAN_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 246 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&wwan_reg_en>;
> +		pinctrl-names = "default";
> +	};
> +
> +	sound {
> +		compatible = "qcom,glymur-sndcard";
> +		model = "GLYMUR-LENOVO-Yoga-Slim7x";
> +		audio-routing = "WooferLeft IN", "WSA WSA_SPK1 OUT",
> +				"TweeterLeft IN", "WSA WSA_SPK2 OUT",
> +				"WooferRight IN", "WSA2 WSA_SPK1 OUT",
> +				"TweeterRight IN", "WSA2 WSA_SPK2 OUT",
> +				"VA DMIC0", "vdd-micb",
> +				"VA DMIC1", "vdd-micb",
> +				"VA DMIC2", "vdd-micb",
> +				"VA DMIC3", "vdd-micb";
> +
> +		va-dai-link {
> +			link-name = "VA Capture";
> +
> +			codec {
> +				sound-dai = <&lpass_vamacro 0>;
> +			};
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +
> +		wsa-dai-link {
> +			link-name = "WSA Playback";
> +
> +			codec {
> +				sound-dai = <&left_woofer>, <&left_tweeter>,
> +					    <&swr0 0>, <&lpass_wsamacro 0>,
> +					    <&right_woofer>, <&right_tweeter>,
> +					    <&swr3 0>, <&lpass_wsa2macro 0>;
> +			};
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +	};
> +
> +	wcn7850-pmu {
> +		compatible = "qcom,wcn7850-pmu";
> +
> +		vdd-supply = <&vreg_wcn_0p95>;
> +		vddio-supply = <&vreg_l15b_e0>;
> +		vddaon-supply = <&vreg_l15b_e0>;
> +		vdddig-supply = <&vreg_l15b_e0>;
> +		vddrfa1p2-supply = <&vreg_l15b_e0>;
> +		vddrfa1p8-supply = <&vreg_l15b_e0>;
> +
> +		wlan-enable-gpios = <&tlmm 117 GPIO_ACTIVE_HIGH>;
> +		bt-enable-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-0 = <&wcn_wlan_bt_en>;
> +		pinctrl-names = "default";
> +
> +		regulators {
> +			vreg_pmu_rfa_cmn: ldo0 {
> +				regulator-name = "vreg_pmu_rfa_cmn";
> +			};
> +
> +			vreg_pmu_aon_0p59: ldo1 {
> +				regulator-name = "vreg_pmu_aon_0p59";
> +			};
> +
> +			vreg_pmu_wlcx_0p8: ldo2 {
> +				regulator-name = "vreg_pmu_wlcx_0p8";
> +			};
> +
> +			vreg_pmu_wlmx_0p85: ldo3 {
> +				regulator-name = "vreg_pmu_wlmx_0p85";
> +			};
> +
> +			vreg_pmu_btcmx_0p85: ldo4 {
> +				regulator-name = "vreg_pmu_btcmx_0p85";
> +			};
> +
> +			vreg_pmu_rfa_0p8: ldo5 {
> +				regulator-name = "vreg_pmu_rfa_0p8";
> +			};
> +
> +			vreg_pmu_rfa_1p2: ldo6 {
> +				regulator-name = "vreg_pmu_rfa_1p2";
> +			};
> +
> +			vreg_pmu_rfa_1p8: ldo7 {
> +				regulator-name = "vreg_pmu_rfa_1p8";
> +			};
> +
> +			vreg_pmu_pcie_0p9: ldo8 {
> +				regulator-name = "vreg_pmu_pcie_0p9";
> +			};
> +
> +			vreg_pmu_pcie_1p8: ldo9 {
> +				regulator-name = "vreg_pmu_pcie_1p8";
> +			};
> +		};
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pmh0101-rpmh-regulators";
> +		qcom,pmic-id = "B_E0";
> +
> +		vreg_l1b_e0: ldo1 {
> +			regulator-name = "vreg_l1b_e0";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7b_e0: ldo7 {
> +			regulator-name = "vreg_l7b_e0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8b_e0: ldo8 {
> +			regulator-name = "vreg_l8b_e0";
> +			regulator-min-microvolt = <3304000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9b_e0: ldo9 {
> +			regulator-name = "vreg_l9b_e0";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10b_e0: ldo10 {
> +			regulator-name = "vreg_l10b_e0";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11b_e0: ldo11 {
> +			regulator-name = "vreg_l11b_e0";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12b_e0: ldo12 {
> +			regulator-name = "vreg_l12b_e0";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l15b_e0: ldo15 {
> +			regulator-name = "vreg_l15b_e0";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l17b_e0: ldo17 {
> +			regulator-name = "vreg_l17b_e0";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l18b_e0: ldo18 {
> +			regulator-name = "vreg_l18b_e0";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-1 {
> +		compatible = "qcom,pmcx0102-rpmh-regulators";
> +		qcom,pmic-id = "C_E1";
> +
> +		vreg_l1c_e1: ldo1 {
> +			regulator-name = "vreg_l1c_e1";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2c_e1: ldo2 {
> +			regulator-name = "vreg_l2c_e1";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3c_e1: ldo3 {
> +			regulator-name = "vreg_l3c_e1";
> +			regulator-min-microvolt = <936000>;
> +			regulator-max-microvolt = <936000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4c_e1: ldo4 {
> +			regulator-name = "vreg_l4c_e1";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-2 {
> +		compatible = "qcom,pmh0110-rpmh-regulators";
> +		qcom,pmic-id = "F_E0";
> +
> +		vreg_s7f_e0: smps7 {
> +			regulator-name = "vreg_s7f_e0";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s8f_e0: smps8 {
> +			regulator-name = "vreg_s8f_e0";
> +			regulator-min-microvolt = <952000>;
> +			regulator-max-microvolt = <952000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2f_e0: ldo2 {
> +			regulator-name = "vreg_l2f_e0";
> +			regulator-min-microvolt = <936000>;
> +			regulator-max-microvolt = <936000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3f_e0: ldo3 {
> +			regulator-name = "vreg_l3f_e0";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-3 {
> +		compatible = "qcom,pmh0110-rpmh-regulators";
> +		qcom,pmic-id = "F_E1";
> +
> +		vreg_l1f_e1: ldo1 {
> +			regulator-name = "vreg_l1f_e1";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <904000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2f_e1: ldo2 {
> +			regulator-name = "vreg_l2f_e1";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4f_e1: ldo4 {
> +			regulator-name = "vreg_l4f_e1";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-4 {
> +		compatible = "qcom,pmh0110-rpmh-regulators";
> +		qcom,pmic-id = "H_E0";
> +
> +		vreg_l1h_e0: ldo1 {
> +			regulator-name = "vreg_l1h_e0";
> +			regulator-min-microvolt = <936000>;
> +			regulator-max-microvolt = <936000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2h_e0: ldo2 {
> +			regulator-name = "vreg_l2h_e0";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3h_e0: ldo3 {
> +			regulator-name = "vreg_l3h_e0";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4h_e0: ldo4 {
> +			regulator-name = "vreg_l4h_e0";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&gpu {
> +	status = "okay";
> +};
> +
> +&gmu {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";
> +
> +	touchpad@2c {
> +		compatible = "hid-over-i2c";
> +		reg = <0x2c>;
> +
> +		hid-descr-addr = <0x20>;
> +		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
> +
> +		vdd-supply = <&vreg_misc_3p3>;
> +		vddl-supply = <&vreg_l15b_e0>;
> +
> +		pinctrl-0 = <&tpad_default>;
> +		pinctrl-names = "default";
> +
> +		wakeup-source;
> +	};
> +
> +	keyboard@3a {
> +		compatible = "hid-over-i2c";
> +		reg = <0x3a>;
> +
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 67 IRQ_TYPE_LEVEL_LOW>;
> +
> +		vdd-supply = <&vreg_misc_3p3>;
> +		vddl-supply = <&vreg_l15b_e0>;
> +
> +		pinctrl-0 = <&kybd_default>;
> +		pinctrl-names = "default";
> +
> +		wakeup-source;
> +	};
> +
> +	/* Something @ 0x5b */
> +};
> +
> +&i2c5 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";
> +};
> +
> +&i2c8 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";
> +
> +	touchscreen@14 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x14>;
> +
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 51 IRQ_TYPE_LEVEL_LOW>;
> +
> +		post-power-on-delay-ms = <200>;
> +
> +		vdd-supply = <&vreg_misc_3p3>;
> +		vddl-supply = <&vreg_l15b_e0>;
> +
> +		pinctrl-0 = <&ts0_default>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&i2c9 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";
> +
> +	/* EC @ 0x70, irq = TLMM 66 */
> +};
> +
> +&lpass_vamacro {
> +	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
> +	pinctrl-names = "default";
> +	qcom,dmic-sample-rate = <4800000>;
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dp0 {
> +	status = "okay";
> +};
> +
> +&mdss_dp0_out {
> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +};
> +
> +&mdss_dp1 {
> +	status = "okay";
> +};
> +
> +&mdss_dp1_out {
> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +};
> +
> +&mdss_dp2 {
> +	status = "okay";
> +};
> +
> +&mdss_dp2_out {
> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +};
> +
> +&mdss_dp3 {
> +	/delete-property/ #sound-dai-cells;
> +
> +	status = "okay";
> +
> +	aux-bus {
> +		panel {
> +			compatible = "samsung,atna40hq08", "samsung,atna33xc20";
> +			enable-gpios = <&tlmm 18 GPIO_ACTIVE_HIGH>;
> +			power-supply = <&vreg_edp_3p3>;
> +
> +			pinctrl-0 = <&edp_bl_en>;
> +			pinctrl-names = "default";
> +
> +			port {
> +				edp_panel_in: endpoint {
> +					remote-endpoint = <&mdss_dp3_out>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&mdss_dp3_out {
> +	data-lanes = <0 1 2 3>;
> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +
> +	remote-endpoint = <&edp_panel_in>;
> +};
> +
> +&mdss_dp3_phy {
> +	vdda-phy-supply = <&vreg_l2f_e1>;
> +	vdda-pll-supply = <&vreg_l4f_e1>;
> +
> +	status = "okay";
> +};
> +
> +&pcie4 {
> +	pinctrl-0 = <&pcie4_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie4_phy {
> +	vdda-phy-supply = <&vreg_l1c_e1>;
> +	vdda-pll-supply = <&vreg_l4f_e1>;
> +
> +	status = "okay";
> +};
> +
> +&pcie4_port0 {
> +	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
> +
> +	wifi@0 {
> +		compatible = "pci17cb,1107";
> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> +
> +		vddaon-supply = <&vreg_pmu_aon_0p59>;
> +		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> +		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> +		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> +		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> +		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> +		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
> +		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
> +		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
> +	};
> +};
> +
> +&pcie5 {
> +	vddpe-3v3-supply = <&vreg_nvme>;
> +
> +	pinctrl-0 = <&pcie5_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie5_phy {
> +	vdda-phy-supply = <&vreg_l2f_e0>;
> +	vdda-pll-supply = <&vreg_l4h_e0>;
> +
> +	status = "okay";
> +};
> +
> +&pcie5_port0 {
> +	reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
> +};
> +
> +&pcie6 {
> +	vddpe-3v3-supply = <&vreg_wwan>;
> +
> +	pinctrl-0 = <&pcie6_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie6_phy {
> +	vdda-phy-supply = <&vreg_l1c_e1>;
> +	vdda-pll-supply = <&vreg_l4f_e1>;
> +
> +	status = "okay";
> +};
> +
> +&pcie6_port0 {
> +	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> +};
> +

Hi Konrad,

> +&pmh0101_gpios {
> +	nvme_reg_en: nvme-reg-en-state {
> +		pins = "gpio14";
> +		function = "normal";
> +		bias-disable;
> +	};
> +};

[...]

> +&pmh0101_gpios {
> +	key_vol_up_default: key-vol-up-default-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		output-disable;
> +		bias-pull-up;
> +	};
> +};
The &pmh0101_gpios node is extended twice here. Please merge both
pinctrl states into a single block, similar to the fix already sent
for glymur-crd.dtsi [1].

While at it, could you also take a look at [1]? It addresses the
same issue in glymur-crd.dtsi and has been awaiting review.

[1] 
https://lore.kernel.org/all/20260602-merge-duplicate-pmh0101-gpios-node-v2-1-251107b3d9fe@oss.qualcomm.com/

Thanks,
Gopikrishna Garmidi.
