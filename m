Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2B2C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7FE810F8F3;
	Fri, 25 Sep 2026 07:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aFEV7FDB";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C2A010E402
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:25:32 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f62ccdb1so604190f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202331; x=1790807131; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D+jQCVrYZyXr3HsKGilur7CRVT4WUdAll7jn608CdBo=;
 b=aFEV7FDBe36DRl+/0AUAYWPuhv0ru2nilAlEg9t8t+1pT9UsWhXThaiYHudedYbkBq
 uiWoKeNY649U/TNtLESAI5Xb9cjUTE1yYRIuqPRy0leI+OFfecen39O3F0YPLJHB9Dew
 Rov/pKMEJzKtfsSXH0dMgsxwjjyZZnNKyjpM/jiQZ/TgSNXcK+NMlLuiLCuHXjy8lRIY
 gjJ6wGYKfPwdxhM1vp3fS3nufEwZURkWCCPTCJ5M/6XfjU2Fgc4BRf6/jMxwYKOn+Llx
 rjf6EKD26VvUfUi8u8d0lwSBsT9AJM4ueBYpYLouKpdy0lWFwFBJN8Z3BROFxgZ3dD0I
 vm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202331; x=1790807131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D+jQCVrYZyXr3HsKGilur7CRVT4WUdAll7jn608CdBo=;
 b=1StJ9gV4pmV/ojKuYH62kvEe8aCYL+HsAk+Avgqmfc540/9S3cAMky1K9oo5280eyF
 7zAuHftDo/vC6UAGFfyVtWmEMGmLk6STN67J85t76PXmnGudBzpQEYxB+HyyydhNlonW
 ILMSlnP6T9VJ8BeF4h9NM869yKPTBYsSEXmOaYX8yXP9/0QRlyQPy4v17p7fe+9gIdM9
 0tSmEjnxrH7zfrwLz38L/si0oQC6HD3m6ikflsq2bBrUQ4KdSCNPR0NmHyRfgK7Ydzoq
 Ht0QpZ5qr71UotgzP1NuHQnHubLEoyT1zm9gaNYdKqXYOHbn3JqAnUynBI1GmDSIYkAu
 QrBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw80JBXYHjV7C87RmS84r+oymIbibB+xDPTmdwK424ZT+OwgEaiV/OJSiaKRsP/QggXqzUn3wE2CTI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPdGcXgxQNHpNoG4miM71VYa5Md0Q3OrUy/jip+xJZD/Gkg9XC
 hNjnUnSIaoEld9zSt1TgR/Erv427HJlwzrU4uvTVYY7Obigy1+eGc8Nb
X-Gm-Gg: AYBFou3K/xmXqqGFSOpdqlUwsL8Rosel61Y2MluW0IbA/PYLDwMdHGBBWaV368pEeUC
 aiOi0TJ+xCIVuufaRprJySe63b0YnXibP7y7nhhIoT3060ft+je9QLNUUBWCJr+WHMBSC49e04P
 22jrfBuvATlExs3i0P2pYNuy4SsgwS8Kzcw7EYCWlrktyCJDxwAlKL5W787yEJCrVLlfPxnX2MP
 yJfdsaTE7BI7AOZlXMJAppdYrqRPB306ZLNQGV3gDr8TFF6PeW5VAJDmCaIDr3nOJjhPxgQeYvx
 I62fJcSDNrbFQvWexjH8xkCD5wI4RpMN2QAkcGFQBLXLjStIuyN1d7JRSAvI+AOm6xnVXmU1HhR
 thU/LWMsHhBOAVVxViUEOHic/m9Mb5P/F02FfBaEfhZdbCZ6nL+KQM5y/6XbNH3aR0TtFPBNRGe
 YilDskMp2ukXCLTnOIaMb1WVIPVVoCRgATDg+ykWSFi0uUyzTo7DtVmJ1XWwgLlTNVntS0ITyI5
 gbdsn1ceIq7mg1UenIXsJcJG49AbaoRVg==
X-Received: by 2002:a5d:5f8c:0:b0:488:5589:d358 with SMTP id
 ffacd0b85a97d-488716ca7b6mr877328f8f.18.1790202330461; 
 Wed, 23 Sep 2026 15:25:30 -0700 (PDT)
Received: from x230 (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877c379sm9726748f8f.29.2026.09.23.15.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:25:29 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: devnull+david.ixit.cz@kernel.org
Cc: abelvesa@kernel.org, airlied@gmail.com, andersson@kernel.org,
 conor+dt@kernel.org, david@ixit.cz, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dsankouski@gmail.com,
 jesszhan0024@gmail.com, konradybcio@kernel.org, krzk+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, phone-devel@vger.kernel.org, robh@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de, Petr Vorel <petr.vorel@gmail.com>
Subject: Re: [PATCH 09/11] arm64: dts: qcom: sdm845-samsung-starqltechn: Update
Date: Thu, 24 Sep 2026 00:25:20 +0200
Message-ID: <20260923222521.188197-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920-crosshatch-panel-v1-9-de6e9512da96@ixit.cz>
References: <20260920-crosshatch-panel-v1-9-de6e9512da96@ixit.cz>
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

> 
> Original compatible describing only the DDIC used, but omit describing
> the panel used (Samsung AMB577PX01), which we have no way to detect.
> 
> New compatible allows without breaking ABI fixing the inverted reset.
> 
> Assisted-by: LLM
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index bd59f1dcd96dc..c156ed3733b4e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -262,23 +262,23 @@ &mdss {
>  	status = "okay";
>  };
>  
>  &mdss_dsi0 {
>  	vdda-supply = <&vreg_l26a_1p2>;
>  	status = "okay";
>  
>  	panel@0 {
> -		compatible = "samsung,s6e3ha8";
> +		compatible = "samsung,s6e3ha8-amb577px01";

I guess that keeping the original "samsung,s6e3ha8" would cause that ABI break ABI, right?

compatible = "samsung,s6e3ha8-amb577px01", "samsung,s6e3ha8";

Anyway, LGTM.
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr

>  		reg = <0>;
>  		vci-supply = <&s2dos05_ldo4>;
>  		vddr-supply = <&s2dos05_buck>;
>  		vdd3-supply = <&s2dos05_ldo1>;
>  		te-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
> -		reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
>  		pinctrl-0 = <&dsi_default &dsi_te>;
>  		pinctrl-1 = <&dsi_suspend &dsi_te>;
>  		pinctrl-names = "default", "suspend";
>  
>  		port {
>  			panel_in: endpoint {
>  				remote-endpoint = <&mdss_dsi0_out>;
>  			};
> 
