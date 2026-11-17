Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE29606A883
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=jhrtrfuu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7933E10E445;
	Tue, 17 Nov 2026 12:02:26 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 194B110F684
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:02:20 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c45551fa84eso850720366b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1794916938; x=1795521738; darn=lists.freedesktop.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SqFEWe0x1tzwyClz1tTRFPazaqExHTu4JKiosZvtC2E=;
 b=jhrtrfuucJ1RbwpjJa7FvF893yE/ywZnkxc3Qj/SKPM4dkreINsb5+jC3XgRkowrUi
 l1PaBiIA/tm7rQcqyZU6LjbgyOHg9u1boTR/rLU0ty+5qONizBFx7MNrwTYENioIGwPB
 +KdryAtoJBQBWQxGFoR8FMU0ddTzFpVOqrp24jvaoHZA9P+0OwK8WREp9Y46JhQmubwV
 nOR/P+26wim2TKL0G8ey/2Q4KK1vREaia3NtDaUk4yViEIOXa5gmBJAVFtUQ3+/A9+Vu
 FG2K3P17/9e10pMIV06dVVQ9gyFBLflZdxN8z0PZq/LEXw+n5fRIV0CNos3n4SI8x1oe
 5SLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794916938; x=1795521738;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SqFEWe0x1tzwyClz1tTRFPazaqExHTu4JKiosZvtC2E=;
 b=l8py4VlSi2fFV7ed0yFYBYwVtQ0kpYflDi4O2Sakdo92iY9OUcDw0VrWckB+Uuor2o
 n64VKPKqPQLiNVAa8P3Jnb+kCyEFTeg/qtSpMQAjDqx20sEC4fARIK6rpXoE5Fjc/C6/
 4AeIflxvaNW8aaER9I/ppZmV0N/CGxcUFy7aHUbdWxxDRbwAYCmWeWkMQBnm0hc1rG05
 8wTIt1EkW04PraAqzW7KpOLLhxPAgcGRyLhPM3vGVQjgMq9gN2jRb6J58uUGms4OnvK8
 vKCmNd3eX30L4YeffCenOl0YqvSs6BWcY4SDuBC5gEDPvKt+cGlMfsCf+7vMNkkMt7l9
 M9wQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGQZ917LOPVT0W9Xq3MXem38Jmz6YC4kY4qhTjq+poBAdZbyW818igeEYISuWcWHb9MnOtzl82S7JI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/JtSo9H+2FFMhBmQh/1UzmG/thdWZpo5/rs03An6dasucaSoAU
 5zNiPgi/AFlBtVqRLnN1TK7t4XceXMMSvBNFVEIVQQgHTMVnhRq8yxWvH8q5pn8Mgtw=
X-Gm-Gg: AYBFou1rkvV/1ozkL8IrnZpK0wrQqCTi4xIFhJIFhFCH9dkyIG4gBBCgFKunfczeDGJ
 v6/hxdpHoRrxiBKPHR93hdZJFVvCbjkQXOPOpgWXwAh92oaKzdg/0Sy5APk9Yi3DQ4e442op8Qf
 VS13y4DzA+NcT9/zGAo9ezSUHyTAjC1079C/zWUe+7UyDHoCb4cJr51FcGT4W7B0Js10g3uQdoo
 MsLxSgED0OOTmQl+pVlO3gj88DU+FlLIqUHY/+e1WrBmIHdp71mvnv9vTtZcPJMUl1P741Qd7Iw
 pxAq4yiy/2axb7Actz6TFNcXShWrcF2YcblfHRbOTiF+fxJhPMjrWGyNvnpWhq7N8p5HjEnTGPo
 6Jtl4755wO3HUantceODeTqI23jqdfRpMkBkZCbQ0/hNk18qskckJ+HbUQ20/zasPLaa/Yet1/u
 sPl8DQaXh6mNg/Qs+0NPDe40Sx2KXY1Nhoft7Z3LZKQomVAwSpvx5JvOQisLdK2Cu04ol0rhSQE
 FKbchZOzmTrghuckHfYaENt/WhpKTiNfPimBhXEh9nLvCj1CUE7WMIH69BwNkdlC/u91uAZCxlk
 j3WAsC7MMJenZHDEB+xUC3W08nFR3J4lNb1V1QZ/8KGZ1gtxDOWu1P7KrBUwDg8R7UVgnyy60g=
 =
X-Received: by 2002:a17:907:c06:b0:c50:8d2b:4392 with SMTP id
 a640c23a62f3a-c509674081amr1060134066b.49.1794916937935; 
 Tue, 17 Nov 2026 04:02:17 -0800 (PST)
Received: from localhost (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c50efdb3471sm115816066b.87.2026.11.17.04.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 04:02:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 13:02:16 +0100
Message-Id: <DMXGY98BB06A.KWBSBPSFMXJ9@fairphone.com>
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
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <phone-devel@vger.kernel.org>
Subject: Re: [PATCH v5 08/12] arm64: dts: qcom: sm6350-lena: Enable PMK8350
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-8-7318a19806eb@erebion.eu>
In-Reply-To: <20261116-pdx213-upstream-3-v5-8-7318a19806eb@erebion.eu>
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
> Configure and enable nodes for PMK8350 on the Xperia 10 III.
>
> The phone has two PMICs which have a PON block, disable the PMK8350
>  PON and keep the PM6350 PON, as only one should be enabled.
>

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> Signed-off-by: erebion <erebion@erebion.eu>
> ---
>  .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 34 ++++++++++++++++=
++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 697e1cfae72e0..50a235d6fb6df 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -8,7 +8,11 @@
>  #define PM7250B_SID 2
>  #define PM7250B_SID1 3
> =20
> +/* PMK8350 (in reality a PMK8003) is configured to use SID6 instead of 0=
 */
> +#define PMK8350_SID 6
> +
>  #include <dt-bindings/firmware/qcom,scm.h>
> +#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> @@ -16,6 +20,7 @@
>  #include "pm6150l.dtsi"
>  #include "pm6350.dtsi"
>  #include "pm7250b.dtsi"
> +#include "pmk8350.dtsi"
> =20
>  / {
>  	model =3D "Sony Xperia 10 III";
> @@ -420,6 +425,35 @@ &pm7250b_vbus {
>  	status =3D "okay";
>  };
> =20
> +&pmk8350_adc_tm {
> +	status =3D "okay";
> +
> +	xo-therm@0 {
> +		reg =3D <0>;
> +		io-channels =3D <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +		qcom,hw-settle-time-us =3D <200>;
> +		qcom,ratiometric;
> +	};
> +};
> +
> +&pmk8350_pon {
> +	status =3D "disabled";
> +};
> +
> +&pmk8350_rtc {
> +	status =3D "okay";
> +};
> +
> +&pmk8350_vadc {
> +	channel@644 {
> +		reg =3D <PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +		label =3D "xo_therm";
> +		qcom,ratiometric;
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +	};
> +};
> +
>  &qupv3_id_0 {
>  	status =3D "okay";
>  };


