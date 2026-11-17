Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3282606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=1tZjsmie
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B53AE10F282;
	Tue, 17 Nov 2026 11:31:28 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1E710F282
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 11:31:23 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6b167ffd132so7628442a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 03:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1794915081; x=1795519881; darn=lists.freedesktop.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=37F/rQXOY5cbeWkahN1eco01zCL7u1ct5LuaDA+efic=;
 b=1tZjsmie1xH2ONn6jIW8RglZ1P4vv5Yp2v/P3ezuPEtEyX+2dM3E7MpulJhl1HUmAe
 OjNRED95oouXGOktWCyMKy8ZwD6OIz/n8qjTNdUGNdlRP42xfoeuxScR/G03rdYKXHIq
 E9R0ZPMewBRZz8Q+EloHMaVglPPkw1K/wnTvn0lDodyUulQ2gviBYqc4VEkqgxsGV/7N
 +gFK9nr2LmOFvdY4JCea8ZAjpdkva7VqoLKwoUkbk+1anqot41y2EG2280BvG7P0juv2
 yKjZeeDiO0lgnVkV/FNLevdmUfIsqK8ZKFh/nwfT5aVGbC0/+BA0SYWroB762QViH6h4
 vsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794915081; x=1795519881;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=37F/rQXOY5cbeWkahN1eco01zCL7u1ct5LuaDA+efic=;
 b=LDsIg7J/R8ZQSplefU7tz+C/y4cAm505Z/fy2rP7wLsd1BRrt7B0TdW0NaTQs3KBG4
 wiX4VRRr4Mdb04FQviuy0gHg5FLfVXeE79PB7rlRrC+LKXJNk/YBDU7q6FUvbKndEHPV
 po9lgMu98hE8TvYEcFlxBeo+A+mtMpGyV3vSkYPjKvEKuaOuHh/N0qYM+SF1CAgA5//d
 qCfdqt811X55FqkTsNPQsn7XsViT7mpguMpsqOllM/3IB028qzrUNySJhYimNpvFtJBI
 /0NY7PVc1jzg0FH1DIhVGQv7ySePjFBpn/RafnwkD6KX1jIxAdtt6AOa6z5TO+7PsJ42
 uAxw==
X-Forwarded-Encrypted: i=1;
 AL+hErEkvVmgPbv3zGHXlzo7Op62C3X0GuoaSlI6ufEBjrhAI+0NYXbi9AahqqxhSNorjmXmkRll+HklGJE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+0lcU4AB94Dp1oGYOviCamz5y+fZ0M28DOMaKVPIRgqawwqHhS
 VhvxToVJlkXc2q3Xly7q5ThaEq/x7ZgcHuy9rwMzhyTEtb9U4QGW6w9px0ihGAk+ZDc=
X-Gm-Gg: AYBFou2mD/N0KY+0Twy8QwueaiLf7QCKB05Yz+lP/bMsD0wTQx4SDa333Wd5rf1D7dS
 CjdY/35yjG7EDI02Y+RadZsW2oZLKuWzEOxFT0ZBQTM5LAy7Tstg6lL2AkiQpXtbF8CFBDPWL9O
 0ftZq/JkXv21VHqzU4/NQ9RuXg6GwvQrzJaCvlHCez1DQwpFGiYwATA4VBdgmFb3YVj2RAeL2sZ
 rg/ExqWQX4L1JhJCkgngTxp1GV1Q43y9Zm5R2/KJIr+pEsxwuO3FbzK8OHy3We1KduDboTeKReO
 z/UEO1O+t2Nk5qG1BS2yamZJqTUDSbveza9KrCYdkAPFnmxi/L1Pgr/F6bjnYha44kpEJQu1CCr
 N5dhrT8yglE8wr6pgFLIaNc6Zo2d9RBi5z0IJBb0Qyv9WpUmaj4Lg7RZ8MtQwUIRMv9OB40sxNz
 35AizDtIYDrnXZZWGdM5UHc5b2h+yJv5MeaxJna717fjzhK2VThOITnLBcBFvqGDnqterLZ1X18
 2ERnXJDsWGFM/iYARkucHrhQ6dHftHxt8euRePZBj1dKFn8waO7znu0SRkhM9tB0laGrgK7oacq
 3pt3kkUn7t2by30qyX0ETt25CyWJJwgEdhZ4qZ5kXY+Ck/QTW19kKwAdbzNIuK34PMdrfVmQcQ=
 =
X-Received: by 2002:a17:906:dc89:b0:c26:1648:a06b with SMTP id
 a640c23a62f3a-c509642fa78mr1153445566b.38.1794915081033; 
 Tue, 17 Nov 2026 03:31:21 -0800 (PST)
Received: from localhost (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b79146sm519632666b.68.2026.11.17.03.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 03:31:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 12:31:19 +0100
Message-Id: <DMXGAKCZ1Y9L.3IO6O895BMH6@fairphone.com>
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
Subject: Re: [PATCH v5 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP,
 CDSP, IPA & MPSS
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-4-7318a19806eb@erebion.eu>
In-Reply-To: <20261116-pdx213-upstream-3-v5-4-7318a19806eb@erebion.eu>
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
> Enable the ADSP, CDSP, IPA and MPSS (Modem) nodes for the Xperia 10 III.
>

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> Signed-off-by: erebion <erebion@erebion.eu>
> ---
>  .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 24 ++++++++++++++++=
++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index a393b7533ccbf..e8808865bf6fa 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -68,6 +68,12 @@ memory@fe901000 {
>  	};
>  };
> =20
> +&adsp {
> +	firmware-name =3D "qcom/sm6350/Sony/lena/adsp.mbn";
> +
> +	status =3D "okay";
> +};
> +
>  &apps_rsc {
>  	regulators-0 {
>  		compatible =3D "qcom,pm6350-rpmh-regulators";
> @@ -291,6 +297,12 @@ pm6150l_bob: bob {
>  	};
>  };
> =20
> +&cdsp {
> +	firmware-name =3D "qcom/sm6350/Sony/lena/cdsp.mbn";
> +
> +	status =3D "okay";
> +};
> +
>  &gpi_dma0 {
>  	status =3D "okay";
>  };
> @@ -316,6 +328,18 @@ touchscreen@48 {
>  	};
>  };
> =20
> +&ipa {
> +	firmware-name =3D "qcom/sm6350/Sony/lena/ipa_fws.mbn";
> +
> +	status =3D "okay";
> +};
> +
> +&mpss {
> +	firmware-name =3D "qcom/sm6350/Sony/lena/modem.mbn";
> +
> +	status =3D "okay";
> +};
> +
>  &pm6150l_flash {
>  	status =3D "okay";
> =20


