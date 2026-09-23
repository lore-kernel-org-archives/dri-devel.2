Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F17CC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F8810F92E;
	Fri, 25 Sep 2026 07:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PAVT22eD";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2A410F223
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:38:31 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso11320215e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790203110; x=1790807910; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tQXtWNjNigWNQlYLBO5wxwxCg1hTWjPpuHjvfkhkF8E=;
 b=PAVT22eDuNt40sFqC9dKX8UtCdSdzApZGrvUatwcTo1/J/dMsNtcWF4Z+0sHFU1QPi
 WMuzKrN24Fd/xsiORmPPsnIXMyWiYpb1VSfpiKduymrDO0Bhlq2AYXADdmYity3hDcQC
 gRKQ6GokwZKfKC/bIciJRqanZ8Jtg6/LLrPAp3zFdgFG+FDpG89OlOuWdOpIq5ivl4gE
 r0CBMSgNNVk9+3+e0BLc0bEK9IO3fWLCVwlXD2M9Mo9XBB3s2jCTFprSIf8mpL5Jy4B/
 21Mgl5PO8M+5VohQ6C13SqxthnlQh+W/iCh6B+nX56cbfDWSJWQes7ceZeVURfio+NZQ
 G0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790203110; x=1790807910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tQXtWNjNigWNQlYLBO5wxwxCg1hTWjPpuHjvfkhkF8E=;
 b=2yQ/dDduf9Pu2kIHt2z/m8B9wWl2BcKjalwpdFDRxQUlOAnGUuNbOhpyyxHZ2ig0PH
 NjRnNODRDv0OShi22IJsJVlyhLS7SePnWEWDopSj4Nld2Zm/Vz7obGgRDW7mwZScoQaU
 wKhgbSc1g7aC2cilRhU+zgX0nTeyDswbWJszKOxEED+7SzltoCR2Dzc/EvvUJwFWxGMz
 7kWTtep/7KfCRYsUGiOqVehQzpWRrc+wpdCTDPQ8NfdwLh7b2VbM+TjOibMxY9lzWSTS
 KLuxNoeZLPgcKh+Kg3hoIZ4j7Btx4ZTmyZQ3dDf+hzBKcHGTb+FINKhZH6eewQuPhwlK
 HpbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlUqYXKXm/rDWWZQz+qjWLV/XWSlH+Ra/vyArgbiCEO1yj4i2rNelR89UrCNv/MYcxNDC9vvnFj8Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lcqq8CMPZAxY7BMOrBvIFVnAuxGQMobyPEm4YFnmVdAnxXBnKu
 LWxxUiyJVvxsc61jVI/3RNPgZC7akutHJHY3+zGTmcOFaHPpOZ/P3TcW
X-Gm-Gg: AYBFou2nFPlztSr1ifMbsq4BB+KdZCN0N/sEBdtf5dQQLN7Or+L7gxLFtE/jsJCOZYc
 9gwIKHmy+FiRKW8JWW6O8GOzURi5hkNVWpmBq3lAYwdGKxLA04zqtwO0CbkI6bfq0WLKBm23dS0
 7DtLyzGIGPuguCWOkiGehVs8ftdwO5ZFIv9nCVg7hHHOaFkYxJUe3wTDawsjc5yogYE6en3/twh
 YSxeiAYEOeQ6CWClhCYib322OpBXsOj7yBu1LmXdpehG34q6dbK6JIdesfEV72nqZjOJ2y1bjYe
 8Nt1VCNJHfAyjZInO3i7bORw+TQ/ig2Gb7r1w5o49Xir4Dr+ZVtrXLiX3pebwRWB46aDYV9BJyT
 iHXgv1ofBTQJT0/ozi4nGKXsAqPr1af4SybsAA5vfUD7E0K4S5wBwoN3o62Notkvw0sDd8qOY8p
 P/29uV2p+i2wzS/w6I4P5W6Uo1bNpiRJUPYmqfi4t71TI7ulzWj7GoLHRBGjPwpm0A5iraeVhNI
 mb55WvLSaAWzVpxNy32JQnB2raAW0wWcg==
X-Received: by 2002:a05:600c:c492:b0:49d:1f32:c911 with SMTP id
 5b1f17b1804b1-49fe66c867fmr8606205e9.3.1790203110240; 
 Wed, 23 Sep 2026 15:38:30 -0700 (PDT)
Received: from x230 (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5b47da1sm20046625e9.0.2026.09.23.15.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:38:28 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: petr.vorel@gmail.com
Cc: abelvesa@kernel.org, airlied@gmail.com, andersson@kernel.org,
 conor+dt@kernel.org, david@ixit.cz, devicetree@vger.kernel.org,
 devnull+david.ixit.cz@kernel.org, dri-devel@lists.freedesktop.org,
 dsankouski@gmail.com, jesszhan0024@gmail.com, konradybcio@kernel.org,
 krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, neil.armstrong@linaro.org, phone-devel@vger.kernel.org,
 robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 10/11] arm64: dts: qcom: sdm845-google: Move panel pins
Date: Thu, 24 Sep 2026 00:38:23 +0200
Message-ID: <20260923223823.190313-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923222521.188197-1-petr.vorel@gmail.com>
References: <20260923222521.188197-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

> Both devices share the pinctrl configuration.

LGTM.
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr

> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts | 18 ------------------
>  arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi  | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
> index fa89be500fb85..a000c75494f1c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
> @@ -61,29 +61,11 @@ &mdss_dsi0_out {
>  };
>  
>  &mdss_dsi0_phy {
>  	vdds-supply = <&vdda_mipi_dsi0_pll>;
>  
>  	status = "okay";
>  };
>  
> -&tlmm {
> -	panel_default: panel-default-state {
> -		reset-pins {
> -			pins = "gpio6";
> -			function = "gpio";
> -			drive-strength = <8>;
> -			bias-disable;
> -		};
> -
> -		te-pins {
> -			pins = "gpio12";
> -			function = "mdp_vsync";
> -			drive-strength = <2>;
> -			bias-pull-down;
> -		};
> -	};
> -};
> -
>  &wifi {
>  	qcom,calibration-variant = "Google_blueline";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
> index f1379857e2742..d54cb47cdf95b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
> @@ -473,16 +473,32 @@ &qup_uart9_tx {
>  	drive-strength = <2>;
>  	bias-disable;
>  };
>  
>  &tlmm {
>  	gpio-reserved-ranges = < 0 4>, /* SPI (Intel MNH Pixel Visual Core) */
>  			       <81 4>; /* SPI (most likely Fingerprint Cards FPC1075) */
>  
> +	panel_default: panel-default-state {
> +		reset-pins {
> +			pins = "gpio6";
> +			function = "gpio";
> +			drive-strength = <8>;
> +			bias-disable;
> +		};
> +
> +		te-pins {
> +			pins = "gpio12";
> +			function = "mdp_vsync";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +	};
> +
>  	nfc_default: nfc-default-state {
>  		enable-pins {
>  			pins = "gpio25";
>  			function = "gpio";
>  			drive-strength = <2>;
>  			bias-pull-down;
>  		};
>  
> 
