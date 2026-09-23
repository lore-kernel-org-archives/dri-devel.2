Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3342DC98328
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39B110F8E9;
	Fri, 25 Sep 2026 07:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PYT5nqgE";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8E3410E3E3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:44:55 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6356256so493609f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790203494; x=1790808294; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tQXtWNjNigWNQlYLBO5wxwxCg1hTWjPpuHjvfkhkF8E=;
 b=PYT5nqgEzPb7L/Rg4DJ0lAjBIzi/V9vxXIPWZh5RzbjpMfhnKrF8Gh2nlITEtKZ9y7
 4MgQ/ll8ads8wGD7e23XfGkJfWQD6oD9fHxQFnFzNwnxdrjsIGFkZMfogagUQvZZQ0qA
 oafwjU/vNLilhlGt8CcEvaLLQWOybTyjfOSfhvA33rBxLRFPAoBJetEK/hu2N2W7lOD5
 9m8QOZvJeTkRX+DD8foWTHeiiT34MNQpXhzkeVrZLTtRiFR4ltq46w/adLQ74vpTo2PR
 IQKTtcAuON9ChiTzbNMoZIoGnuj+8l9HfRg+pJ0VwqQ7O13enNaILNBZtfEaLoG6bxAr
 QT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790203494; x=1790808294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tQXtWNjNigWNQlYLBO5wxwxCg1hTWjPpuHjvfkhkF8E=;
 b=EhQl+wO5JgsHt2JaqDyn+rHFw6kwkPPJQTLQpjv8Dxxz70/MY0qzCWPu7pe5A2YyIr
 ECkR0WcDXiCcvM1aFbT6DGnooxatpkBuMa6ib2MWRi9r9+k0Q44diWdU4sYL27l1+uoQ
 xIz8i2tjluusEKc65pNPc5Ys8aOoSnGipQNWZbjxUt2tHbjT/rW6NdAKOWWPcu+9p4wq
 Bf6qw9wus/qius9cuFBRKx0fqVgjxI8rB52Nz3qNFcBrjKGmYLP9SE8CYrndNtinC6s6
 AO4m+G3ovhYTWB95pyEECGPWywGGTVlxigO561lq9lkaXHi7ilwCJRO9wJEz53Jeo0KX
 P7mQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAAsN4cehxCGDZi7L1KdjdNed8zaxeprHhsMrJy/b/eOwxVR7o0M0d/7DN9FuUy045268yITq8QJA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lC8GMaPknkYKOmRCbaYXZwrpWxF/3KULoglDtpX3IGUIlgsI0o
 T1VVJcDB6D6eWc4fdV63YlaMUNDzYEFBVte3EH0Z1EKDLtjp+Vz67tbJ
X-Gm-Gg: AYBFou3eEDlbS/hxH9JE/tbKzAUHDPleg5MqHnW81YkR5QSQea55VNiEE834HaPbEiF
 O79IMHDru/YnofD/cSljmS0zfW3O2XNvZh0S6r/HqM0PMFoIq8Pq9t6XkqhMGNbSwN3dw4D4v9h
 jIQpAsklvH0jv0Su6+D+mS3nqu92NejOfil3Vzr56LBr2FmRhDBoE7TikUgjQ5mk+PCtdN6DFVb
 HjQXtl7hwoCU6kGfvwtcKQA+kt3msd/UGu6kKkTmvuSXUvD5vLl8Zwx+ljMY9l+riwgBuFYvojM
 +6/73jGqP+BKf4zJBffwQlgN3jCoevq1vP6PvQviLC0+8OPAi3KWW9Yedd2DrTGGrSrTLxTRlMY
 2lvz84qzL7hr1DcfzRiWrU0WDVwUvP9YFhvfgppZRBgYSD4Ge+cWmq1A2UrJIflJoUyK8Wi/2bp
 njDoFcEP9Hwzg5oZhQYydLBsHtzJjqIUQVlaPeL/UXyN8Ck8WS6ZkPSbwznOllg2pp5u039xqSW
 Ot5q4alDuiqruLrXDfNVwwx/c50SJu28g==
X-Received: by 2002:a05:600c:6986:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-49fe66d05d7mr10255655e9.8.1790203494222; 
 Wed, 23 Sep 2026 15:44:54 -0700 (PDT)
Received: from x230 (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5b9c16dsm31420695e9.3.2026.09.23.15.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:44:53 -0700 (PDT)
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
Date: Thu, 24 Sep 2026 00:44:32 +0200
Message-ID: <20260923224432.190902-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920-crosshatch-panel-v1-10-de6e9512da96@ixit.cz>
References: <20260920-crosshatch-panel-v1-10-de6e9512da96@ixit.cz>
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
