Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F75606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=5PyRSKeF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD8A10F68E;
	Tue, 17 Nov 2026 12:10:24 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6851B10F68E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:10:18 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c4cb6834eaaso296372666b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1794917417; x=1795522217; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dfaypAa6ppfXfClsoWfeiFIIEjS/QTWnqdCEZYeNYh8=;
 b=5PyRSKeFuDHyiz0ESs698TwDViNsb0W3EqwCXPLkGdXxjqV7r1+MYfcwCZd1deWbDQ
 WazjLvmczJg2g29dxFyijOkPi5lsA7+q2b7vLBGbMH0N2aSxNvtrbEeEmZD1JhIBT+Wl
 nHH1ZBlvw7fD+jBWE4djYFYscrjnbC/iti2PIq/gHwSNRxW+eF5k/5+NcYZ5Rr4OL/2W
 wfYFcLyzyrrZwWw+WxsTLN6ijCbCCyASUVuNoQkA6DSZFHHnwAlePvH8rn4R9+zCnAlY
 FprwgERbqVmKhIKI1vt9c+d2m6yzUi7SsApxOH98OasddFDEcLFgbXRDxKc+z8yhw27y
 3+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794917417; x=1795522217;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dfaypAa6ppfXfClsoWfeiFIIEjS/QTWnqdCEZYeNYh8=;
 b=gCoyQVoyVViqVMzeVMoBpu8/dVl6XXzln529xyNwdyjko/9ZlZru3X0clIWRRX6A/d
 sVZMMBH3UzzLVomDBLDCdc47hk2uaP7hK9o0ntI1XH7i6HxoUQxwBS7jbZgGy8nQuFZi
 J0stG7ogNiqW+WmmXEC/U2HjjzELMtXgdwm4CTyewOJ/D+ggPM7wA4/lP80WqP5AXtuC
 3b6z7Sv7B0QlNlZ6XFN0kw5RYCOGfCxhdsSpVVylyQy3JoWDSY/zIAZBpPVm+LGYp3XV
 IXFTvJN/Jfq3OPYAsf4VbBEGKqIemWd1Hb4ebtQ97xzZ9KLpRDIuGW5d7Tb5Mw2YEcrp
 9GHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEronPkXw6SyvX3CJhG1CTLSdOkNoQDLczeY3/Nr2OOLIAZSsea/nrIkKJv+dc/G/DGxMQjR45s6a8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/qwgwLHfe170E0fm2gQ23oPkxJy+tBZTZG0cPrv6ECWf48vPNo
 wU9iwbp/CIFEkPXPQOnGXVlIKohvJXwrBVcDt47TzKMBQJB2RuKwx3NQTqhTVDvqzkk=
X-Gm-Gg: AYBFou3Xssif1dAcEYTrjsOoPCWtf0Qr+Jtq5YY7IJ8M3Lgcqz4NSfDb1+yjLbBZDj6
 9C/V0dv/Q8QQrmZIK7UirBsU0nQM3RH5jXXporCPIHqU7z93+AAbkp3fx5OK0GUj0DvGsWEw5Z1
 FwmZNX0iaxF9EfIK2nqMXyUtqxXZJdlTkaWUCjPmVh/HRpSTyLisPgXo789xgHECszjTuE45xr/
 L4aCsyKUBE+nzD9saeL9R+OC726KOCpRh8ZFazJDNyghrxsWKbtfoWV33/D3hBGbMAdsTWHSfj8
 zrnCqGMR546ATuyQm2NsAoAvZi9Uox/EM9zp/d89rm09nTN09BlUQEHT73ESlDQDzdWQT+aECiw
 micWw0a/pcxtUiIGSfMbmUwmWxCkqJ6d8EKiUGiD9lgVtN9Pg0Su+eN1XaA+joB7fn+0mUliC/0
 i/Pv2sjZo0d4Lhwm5LCLk9oY+oY1aSM6uBEjUObFBnYwpDH1KTRze5cjev0s6yG6b0yi0AraGSX
 +LoyF3SVvxgP+5v5guQ9a79WttxGvlnP32Mqc4BSZIfK8ot6VWJP2Egcp5k2pfcGwEwiniobZkB
 gqC94biL0b2524gXHkgWKwffjO9P0RRNboQIG79cQS09zSk52J99kDTFL7r7hTjNuNs35XW28A=
 =
X-Received: by 2002:a17:907:94c2:b0:c41:26b8:c49d with SMTP id
 a640c23a62f3a-c50963cccbdmr1064546666b.38.1794917416774; 
 Tue, 17 Nov 2026 04:10:16 -0800 (PST)
Received: from localhost (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b685b0sm531579666b.60.2026.11.17.04.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 04:10:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 13:10:15 +0100
Message-Id: <DMXH4DEA8NRH.2HZPS0S9ASHN9@fairphone.com>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <phone-devel@vger.kernel.org>
Subject: Re: [PATCH v5 11/12] arm64: dts: qcom: sm6350-lena: Add PM6150L
 thermals
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "erebion" <erebion@erebion.eu>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-11-7318a19806eb@erebion.eu>
In-Reply-To: <20261116-pdx213-upstream-3-v5-11-7318a19806eb@erebion.eu>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 16, 2026 at 11:50 PM CET, erebion wrote:
> Configure the thermals for the PA_THERM1, MSM_THERM, PA_THERM0,
> CAM_FLASH_THERM and QUIET_THERM thermistors connected to
> PM6150L.
>
> Due to hardware constraints we can only register 4 zones with
> pm6150l_adc_tm, the other 2 we can register via generic-adc-thermal.
>
> RFC_CAM_THERM is intentionally omitted for now and will have to be
> added once it is clear how it should be added.
>
> The trip points can really only be considered as placeholders, more
> configuration with cooling etc. can be added later.

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> Signed-off-by: erebion <erebion@erebion.eu>
> ---
>  .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 160 +++++++++++++++=
++++++
>  1 file changed, 160 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index b86fe11fd5296..b19e76b3c1a75 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -81,6 +81,13 @@ memory@fe901000 {
>  		};
>  	};
> =20
> +	msm_therm_sensor: thermal-sensor-msm {
> +		compatible =3D "generic-adc-thermal";
> +		#thermal-sensor-cells =3D <0>;
> +		io-channels =3D <&pm6150l_adc ADC5_AMUX_THM2_100K_PU>;
> +		io-channel-names =3D "sensor-channel";
> +	};
> +
>  	thermal-zones {
>  		chg-skin-thermal {
>  			thermal-sensors =3D <&pm7250b_adc_tm 0>;
> @@ -106,6 +113,74 @@ active-config0 {
>  			};
>  		};
> =20
> +		pa0-thermal {
> +			thermal-sensors =3D <&pm6150l_adc_tm 1>;
> +
> +			trips {
> +				active-config0 {
> +					temperature =3D <125000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +			};
> +		};
> +
> +		pa1-thermal {
> +			thermal-sensors =3D <&pm6150l_adc_tm 0>;
> +
> +			trips {
> +				active-config0 {
> +					temperature =3D <125000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +			};
> +		};
> +
> +		quiet-thermal {
> +			thermal-sensors =3D <&pm6150l_adc_tm 3>;
> +
> +			trips {
> +				active-config0 {
> +					temperature =3D <125000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +			};
> +		};
> +
> +		rfc-flash-thermal {
> +			thermal-sensors =3D <&pm6150l_adc_tm 2>;
> +
> +			trips {
> +				active-config0 {
> +					temperature =3D <125000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +			};
> +		};
> +
> +		sdm-skin-thermal {
> +			polling-delay-passive =3D <1000>;
> +			polling-delay =3D <5000>;
> +			thermal-sensors =3D <&msm_therm_sensor>;
> +
> +			trips {
> +				trip0 {
> +					temperature =3D <45000>;
> +					hysteresis =3D <0>;
> +					type =3D "passive";
> +				};
> +
> +				trip1 {
> +					temperature =3D <55000>;
> +					hysteresis =3D <0>;
> +					type =3D "critical";
> +				};
> +			};
> +		};
> +
>  		xo-thermal {
>  			thermal-sensors =3D <&pmk8350_adc_tm 0>;
> =20
> @@ -392,6 +467,83 @@ &mpss {
>  	status =3D "okay";
>  };
> =20
> +&pm6150l_adc {
> +	pinctrl-0 =3D <&pm6150l_adc_default>;
> +	pinctrl-names =3D "default";
> +
> +	channel@4d {
> +		reg =3D <ADC5_AMUX_THM1_100K_PU>;
> +		label =3D "pa_therm1";
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		qcom,ratiometric;
> +	};
> +
> +	channel@4e {
> +		reg =3D <ADC5_AMUX_THM2_100K_PU>;
> +		label =3D "msm_therm";
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		qcom,ratiometric;
> +	};
> +
> +	channel@4f {
> +		reg =3D <ADC5_AMUX_THM3_100K_PU>;
> +		label =3D "pa_therm0";
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		qcom,ratiometric;
> +	};
> +
> +	channel@54 {
> +		reg =3D <ADC5_GPIO3_100K_PU>;
> +		label =3D "rear_cam_flash_therm";
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		qcom,ratiometric;
> +	};
> +
> +	channel@55 {
> +		reg =3D <ADC5_GPIO4_100K_PU>;
> +		label =3D "quiet_therm";
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		qcom,ratiometric;
> +	};
> +};
> +
> +&pm6150l_adc_tm {
> +	status =3D "okay";
> +
> +	pa-therm1@0 {
> +		reg =3D <0>;
> +		io-channels =3D <&pm6150l_adc ADC5_AMUX_THM1_100K_PU>;
> +		qcom,hw-settle-time-us =3D <200>;
> +		qcom,ratiometric;
> +	};
> +
> +	pa-therm0@1 {
> +		reg =3D <1>;
> +		io-channels =3D <&pm6150l_adc ADC5_AMUX_THM3_100K_PU>;
> +		qcom,hw-settle-time-us =3D <200>;
> +		qcom,ratiometric;
> +	};
> +
> +	rear-cam-flash-therm@2 {
> +		reg =3D <2>;
> +		io-channels =3D <&pm6150l_adc ADC5_GPIO3_100K_PU>;
> +		qcom,hw-settle-time-us =3D <200>;
> +		qcom,ratiometric;
> +	};
> +
> +	quiet-therm@3 {
> +		reg =3D <3>;
> +		io-channels =3D <&pm6150l_adc ADC5_GPIO4_100K_PU>;
> +		qcom,hw-settle-time-us =3D <200>;
> +		qcom,ratiometric;
> +	};
> +};
> +
>  &pm6150l_flash {
>  	status =3D "okay";
> =20
> @@ -405,6 +557,14 @@ led-0 {
>  	};
>  };
> =20
> +&pm6150l_gpios {
> +	pm6150l_adc_default: adc-default-state {
> +		pins =3D "gpio7", "gpio10";
> +		function =3D PMIC_GPIO_FUNC_NORMAL;
> +		bias-high-impedance;
> +	};
> +};
> +
>  &pm6350_gpios {
>  	vol_down_n: vol-down-n-state {
>  		pins =3D "gpio2";


