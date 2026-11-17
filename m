Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C115C606A329
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=Vk8NU9UY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B34D10F682;
	Tue, 17 Nov 2026 12:05:13 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF45110F682
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:05:06 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c4d21051042so273437666b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1794917105; x=1795521905; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Hw0ZL/BcMhgQSpsBsS2RQ/TIEgnIP66HggNOJxC2S1Q=;
 b=Vk8NU9UYfZ5NIPyqoWSgMj65KJKzd+XR8npHsOziI0rHIJn7FJ2k5LY22et/huFZVM
 LCtokeG9uVXLN5euXiYE6E7/h3IS1Ghz79BvvBzRHzKIAmEO0vho4aSqB/bP+uJuXaVh
 OfRZ0ArE82PIGHphJDB3W0K2Ayh5JQH1VZ1IYF/Hi/5sO7GgqAR4mMWNHBNQM2G6U8us
 of2EC3BhFQ77Swwk8nz8OdH12z61gGro9Aa+dZiixA/REvnazwJCW0XHLNt6+63xUyZ+
 6QSjE4rog6Ei5E/xbHrc6guxQt09upZoPGthBjJvo889tsZt+xOV9K4GDUVTFQEB4meG
 wv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794917105; x=1795521905;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hw0ZL/BcMhgQSpsBsS2RQ/TIEgnIP66HggNOJxC2S1Q=;
 b=SV5/asqDH6SffOxApfKFoxhrpNMLx8WJTcsxC1/PR2OQf2Wx1NtIE0Grxx4Xbqm2Fu
 qSA5VnTnsOrQD9eDNKnx/nx6eziGZ8cIJm/v3n394FQxNqVzabS3E4o3mnNb7Gxp8obn
 QWOoZrTjPhctzcHNO/cf6fr2ra9ZJmziGIOqFHJey2PsgXx+1oWdtSGnQHetDGzerZ4z
 P0eTJ5dNd+nNnGy9ioCtjLC1bFQyxTBTs0AoOiotubzR7m6MSnrLkgcaSzHkXZhh4NNU
 ZTNkPj+h2MfIu7oX6rZg3SoTITCCTnzlsNghtSY2J+XLNNyxgC4DlAenaGFp0RRFil1q
 HnBw==
X-Forwarded-Encrypted: i=1;
 AL+hErEV/F2fBg35iAGJJxdu8iP+5w1lUEOhJO9Qq7TTDL0n8Qd9F6YmkT8MT8oirBfw9F79GXKT9dyUjNU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+rdt9d1vo3OHp2W4I4biJ4HZxxi0uEyYbyQSbvPDamK5hKMILk
 nH2Cj4e0NqZ8gtx+lqi9Ofw0GUYaqM2BTINDiNrWdO0OSLfdRQn9KJjopKSAh8l2PRs=
X-Gm-Gg: AYBFou3UD6yJHVqoztxJgebUPcDiXzObzHuCg4WK+1RwOHcTbN62Q+RuyAS8z40OrTu
 Pz89SodLN1VCTRULhDP2+Ws+hCgG9r16Upk7pLOh3Mnk/gp6kYy5whAJODLChxVRDLZ8jNVzw6i
 ABlmY8hcBwrZ1PbW3hQvzpM8wUaBAAYLTIFAeuU6E4q4fMzpD7xv+B4gEbc4/2zAPg2Huwdv4G7
 eMVMIGd//SwA+g9coSBEyWXlV1hnviGqRMvcUJyExeu3HdCxOQFhcRePGIpUfC92WRiZFp4JhX/
 0CBEl98uNeuh0Pn+DJBAx5bm5TOWW3OJSu8sGbDO9ZMk3/uFva7FLGS5y1OC7j0Lcym66bD6/qb
 DT0nQsohnGMvVivdd9RrRzuy2Rl4EhobEDylJD48fOIj9xHQRQkhp9NnGrMwsqUHKtWr2YLN/Bl
 rtJ86aS22WrXxNN3/spmqUDoS9YRBtx7FakNhtF6SAww132w2Yw6GgwnLnJoAHZyYskNhGK5RhG
 Vqput1xCEVwOocNb1jJhrQBrLSbFs5EuleEONQUp5ebMObxH3EIslh+WnjxMymnW6rwmAmp3DcK
 EXNjfaWR46si3k8K8/WZTgKZTHTlTdOE24p7GUPwcHqUizMr+JMorMVEIQOo+dBfYfHiN02sqQH
 xk915RguiI/1T/FunwA8=
X-Received: by 2002:a17:907:84b:b0:c35:3880:773b with SMTP id
 a640c23a62f3a-c50963f11f7mr1200537766b.45.1794917105150; 
 Tue, 17 Nov 2026 04:05:05 -0800 (PST)
Received: from localhost (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c50a6c826bcsm473472666b.11.2026.11.17.04.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 04:05:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 13:05:03 +0100
Message-Id: <DMXH0E5U7WSG.W427836YQJIS@fairphone.com>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <phone-devel@vger.kernel.org>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 07/12] arm64: dts: qcom: sm6350-lena: Enable PM7250B
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
 <20261116-pdx213-upstream-3-v5-7-7318a19806eb@erebion.eu>
In-Reply-To: <20261116-pdx213-upstream-3-v5-7-7318a19806eb@erebion.eu>
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
> Enable PM7250B and some components on it for the Xperia 10 III.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> Signed-off-by: erebion <erebion@erebion.eu>
> ---
>  .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 48 ++++++++++++++++=
++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 9d880f6baa531..697e1cfae72e0 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -4,6 +4,10 @@
>   */
>  /dts-v1/;
> =20
> +/* PM7250B is configured to use SID2/3 */
> +#define PM7250B_SID 2
> +#define PM7250B_SID1 3
> +
>  #include <dt-bindings/firmware/qcom,scm.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> @@ -11,6 +15,7 @@
>  #include "sm6350.dtsi"
>  #include "pm6150l.dtsi"
>  #include "pm6350.dtsi"
> +#include "pm7250b.dtsi"
> =20
>  / {
>  	model =3D "Sony Xperia 10 III";
> @@ -372,6 +377,49 @@ &pm6350_resin {
>  	status =3D "okay";
>  };
> =20
> +&pm7250b_adc {
> +	channel@4d {
> +		reg =3D <ADC5_AMUX_THM1_100K_PU>;
> +		label =3D "charger_skin_therm";
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		qcom,ratiometric;
> +	};
> +
> +	channel@4f {
> +		reg =3D <ADC5_AMUX_THM3_100K_PU>;
> +		label =3D "conn_therm";
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		qcom,ratiometric;
> +	};
> +};
> +
> +&pm7250b_adc_tm {
> +	status =3D "okay";
> +
> +	charger-skin-therm@0 {
> +		reg =3D <0>;
> +		io-channels =3D <&pm7250b_adc ADC5_AMUX_THM1_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us =3D <200>;
> +	};
> +
> +	conn-therm@1 {
> +		reg =3D <1>;
> +		io-channels =3D <&pm7250b_adc ADC5_AMUX_THM3_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us =3D <200>;
> +	};
> +};
> +
> +&pm7250b_vbus {
> +	regulator-min-microamp =3D <500000>;
> +	regulator-max-microamp =3D <1000000>;
> +
> +	status =3D "okay";
> +};
> +
>  &qupv3_id_0 {
>  	status =3D "okay";
>  };


