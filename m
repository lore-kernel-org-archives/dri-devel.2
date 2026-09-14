Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C3FC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A859F10EB9F;
	Mon, 14 Sep 2026 07:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tlpx0cy4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kj9ll0q/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8916510EB9F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:33:18 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5iwgD543112
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PPVHmgYi7mIm8HbRO3S2SjE7
 s1NeTOAcrc3esYObcpQ=; b=Tlpx0cy4xC/PJbyXS/+6IME4cTRft8805PiR1jjE
 871i3Ntx9bL1FEDluPZPNCYzjCkRCpgVn/iUknQBnQ7TfVg7qel4lX+p0Z2ST8aS
 LVDjP4d3MZKmyZ//KhRX6EnEKeVWPgJgE3EZ9biavcGFACtn/cclAeCops025BF7
 DRkP1yT7CS4+YhI5GjQUzBk0QjsrsLRCbMiuQFE7gqkqK8kV9ypRT+ZEa4cFQvk3
 EiWT2d9C4hqYtSjpnSj2/8Ix3b36ATzkC0ehYKENwIVYY7Fc6qVilGyQVqFwoaEq
 Hxvt1thilrpMjDb67zokaMQZ7qaAd8cDuEsbeiIINo5Q6w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k09c8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:33:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a01d1d1b6so307926685a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789371197; x=1789975997;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PPVHmgYi7mIm8HbRO3S2SjE7s1NeTOAcrc3esYObcpQ=;
 b=Kj9ll0q/N82f2LgIBBZpHPQBasXcKYEDk+X4kUNRBss08mMsA5/tIISdirVQ8fasUP
 m+XL4WkZZXIPQ8l1St24PDKRObSwrDvPYV1AF/0n4gx+kKVaemZDLeRQ581ej+IF1s1v
 03XbVbpisjkpCakN+SbSbrjLsVYrbvTOJ0ynev6yU9Uq0A2Oh+nBBTDmZOExKkmKLf6k
 QrjHtULyuVRr0IXeOxFBLdyUuT/adjYAWwFh3YWGBZZkLRT7FerMkNFI5go0snIVWAnA
 fscNphKc67XzT+2ADxB3Kx5nPtl1dE0dZ/Z334t9ac6vNrpylh+zb6zDSzu4OBmjGPQ/
 mGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371197; x=1789975997;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PPVHmgYi7mIm8HbRO3S2SjE7s1NeTOAcrc3esYObcpQ=;
 b=pSF76dyVZfuKpiQoaYjgN6odvuuG0O6llYTZZeK1GitqghRXk8spMX5/N40Rjqivb4
 UnDa2mG4B4iiEJ+8TdmiFTVy109qhzPJUZhhiLx8bU4uGobWmP62UtDzYYRNUO1h+LJ+
 Y7AKkeoWDosCbLnsXuAJuYebBcTtb0ShWGm5O+xHayCYVzptkPNY6y6ljJ5Okugl5/Dd
 vAnO8bC1B4xrx9yYp9LNR1LXPS1aqTbx//Bo/07o6wsvKb3f5J+ST011h30v7xsCtxf9
 gw6eBKx5tatgjSzshc923vm7ZLk+hXOwz6WkVTtyeQg0/50UUNS1unMFZVFIMcvsVFPJ
 moPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhxgiH7XDZsP7EU5IhLeJap8S778EojTyDjmMt3zORtIdOTzq0hRkj3D1MBaEDZE/ytPS1XYc4wqo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lUYrmyBI2SYpr7dJQX2Cox5PU4VZoqFnXmrjA9V4G1t1PZUwam
 lM4E+9Rql+Fm26K6quLCkbnsd2BFvLukA9IF8ODWse+Xc/uiFa3hzbb5MZUodh3ZUQIncqZ2izp
 UHq3EQIk5kRxgqhMzcToNFUK+Ng86pp0b7us+Do43wPWha7NRnAecEmNI7u9KcnAHZZoilbg=
X-Gm-Gg: AYBFou3SBh+f4S70BIMOFoEN/6VYkuRv0xnoVUHsAp2OBHRreA/oIG44wjyn7m4ClzS
 SxedJroNzwREKx8iVBmmzd+7Q1dpDwx17+RKtBCVNoKj9DRBXVpi36O1PvsXjFvxHoYRoXw8y9b
 EIfIhWq8ut+hkPpnNJ6KyYA4t4FBknByH3etJBnY37TvA1nwJO/W5sj9VWBjWyO2K4pyHM5pnrD
 VDZO3V8hYJptfLmcGp6GrAlwzu1DN6B17ULhHVbAyjsrCMISPzEvl8h5PNUJQbEl4JtpbKdIrY0
 ydCABScZQFPjrB9Yg8C7WNWaX9E3FNHmXNvIoWPzzLl/NeQ0KRG5rS+R5lcZz9WVxOxS0K7/c9J
 1/SuiUp4mvBEP9cU=
X-Received: by 2002:a05:620a:684a:b0:939:36f3:fea8 with SMTP id
 af79cd13be357-93a299fbf40mr181203085a.25.1789371196775; 
 Mon, 14 Sep 2026 00:33:16 -0700 (PDT)
X-Received: by 2002:a05:620a:684a:b0:939:36f3:fea8 with SMTP id
 af79cd13be357-93a299fbf40mr181199385a.25.1789371196308; 
 Mon, 14 Sep 2026 00:33:16 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6cc11607sm194517025e9.12.2026.09.14.00.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:33:15 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:33:12 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mpearson-lenovo@squebb.ca, sibi.sankar@oss.qualcomm.com
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add Lenovo ThinkPad T14s Gen 7
Message-ID: <654pl65hnq5hrdebqsj7iyse6uea2ltrnahac2fsszj77lodun@56yozp6x44bn>
References: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260913201835.250085-4-srinivas.kandagatla@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913201835.250085-4-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEwNSBTYWx0ZWRfX2UV08jIWaXSD
 exDN8QK5w8DcOpBPT8V0dwQ2Bbku0IqiwmhkBHlLC3wec6rsgC83gjQ4Vfmy0qVIX7LqiKyKeIc
 F+iVu3fwT5ZaBgvJNLeC0PmjYoLwvF4=
X-Proofpoint-GUID: ea5BGUNZ_tf0OxRzO2yi68YsCkS9bssc
X-Proofpoint-ORIG-GUID: ea5BGUNZ_tf0OxRzO2yi68YsCkS9bssc
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa7a33d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=akxgaDyAjk3E6sMMxtYA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEwNSBTYWx0ZWRfXw5EvC7z9NjG9
 7bHc9LqHuz5KFOU5wZbXEv/mx0bfC6xvWXzDlkmCraqaaHrDQcntRIHgS6YU2kZleiAx9MPyjv+
 IhVCVddEpe1Jygg0+0UrRAiNN/qQ+pKR8kpdYy/csnwLKaU31Dv1HefwbU0/pAQLYwGu8cqfDGR
 Oav6Eg6mdRTNutk0Bu4T94EeMiwugoiGYxLj6DUap395T/UwejfIVtS/oVHb1adyPfYrXyjEDMr
 mjIZtXmfEDTObEYvxpAeXmcJB+ovM2T/MkCMTUg4+orO1YwNJdWya6FRaQvLgjFDXgpc9i7TPh0
 CMChVSWpGHFCR119Ap+ouMF3QaibhjkBftB+OgoTtxD0vlqARtTIVvV9WFzf6Jb1R3D0lkEY+8Y
 Hk/svFgdp0OOf1iicZ0VxZGbGzwZauNH4qYup5XqdXoiW4AHANnfwLYCoRe5WKpaERqQF35b9bf
 bgXxvLmKTmYeZ+goRXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140105
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

On 26-09-13 21:18:34, Srinivas Kandagatla wrote:
> Introduce a device tree for the Mahua-based Lenovo ThinkPad T14s Gen 7,
> a Snapdragon X2 Elite laptop.  It follows the Qualcomm Glymur reference
> design used by mahua-crd.
> 
> Currently working:
> - Display (internal eDP panel)
> - Audio playback and capture (2x WSA8845 speakers on swr0, DMICs via
>   the VA macro)
> - USB-C (host + charging on both ports)
> - Wi-Fi (WCN7850 on PCIe4), Bluetooth (over uart14)
> - NVMe on PCIe5
> - HID-over-I2C touchpad, keyboard and TrackPoint on i2c0
> - Lid switch
> - WWAN wiring is included but remains untested due to lack of access
>   to such a SKU.
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

One minor nit below. Anyway, LGTM so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

> ---
>  arch/arm64/boot/dts/qcom/Makefile             |    1 +
>  .../qcom/mahua-lenovo-thinkpad-t14s-gen7.dts  | 1184 +++++++++++++++++
>  2 files changed, 1185 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/mahua-lenovo-thinkpad-t14s-gen7.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 6c2ac11133ca..c71d536fc3e7 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -59,6 +59,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-el2.dtb
>  lemans-evk-ifp-mezzanine-dtbs	:= lemans-evk.dtb lemans-evk-ifp-mezzanine.dtbo
>  dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-ifp-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= mahua-crd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= mahua-lenovo-thinkpad-t14s-gen7.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= milos-fairphone-fp6.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= milos-nothing-asteroids.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= monaco-arduino-monza.dtb
> diff --git a/arch/arm64/boot/dts/qcom/mahua-lenovo-thinkpad-t14s-gen7.dts b/arch/arm64/boot/dts/qcom/mahua-lenovo-thinkpad-t14s-gen7.dts
> new file mode 100644
> index 000000000000..be5f12bfe56a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/mahua-lenovo-thinkpad-t14s-gen7.dts
> @@ -0,0 +1,1184 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +/dts-v1/;
> +
> +#include "mahua.dtsi"
> +

[...]

> +
> +	reserved-memory {
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x0 0x10000000>;
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
> +
> +

Nit: Drop this extra line.

> +	sound {
> +		compatible = "qcom,glymur-sndcard";
> +		model = "Lenovo-ThinkPad-T14s-Gen-7";
> +		audio-routing = "SpkrLeft IN", "WSA WSA_SPK1 OUT",
> +				"SpkrRight IN", "WSA WSA_SPK2 OUT",
> +				"VA DMIC0", "vdd-micb",
> +				"VA DMIC1", "vdd-micb";
> +
> +		wsa-dai-link {
> +			link-name = "WSA Playback";
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
> +			};
> +
> +			codec {
> +				sound-dai = <&left_spk>, <&right_spk>,
> +					    <&swr0 0>, <&lpass_wsamacro 0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +
> +		va-dai-link {
> +			link-name = "VA Capture";
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
> +			};
> +
> +			codec {
> +				sound-dai = <&lpass_vamacro 0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +	};
> +

