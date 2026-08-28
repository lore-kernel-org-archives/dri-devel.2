Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945D3C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F4610F3DE;
	Fri, 28 Aug 2026 14:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dDVw5G31";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8275910F3DE
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:22:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21BED4165D;
 Fri, 28 Aug 2026 14:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB61C1F000E9;
 Fri, 28 Aug 2026 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787926941;
 bh=F9R/jw6fYGhp1qHHGXXhrB4PiqZq9JvnVHSFVZEmj60=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dDVw5G315pwn0fGWL6AsIMRtMdil0F89XAJbS0Dz03fjldMTlf09yMSsbjG1yk3B0
 5FKHszYwjjo87qz2ZraeG1AuJJjHJCuNNlWEoYEPciEpn8j3D4jwhoHVHrUEmLPdkF
 Usm2FkJ/ZSbstnkYDdaO8q6Z7zRx+iAiqF11DpMOeyAw3+p6kReQTsU7iT6BBZuRfz
 A7uf8sGVbmBNJSfq5w1KRAWHu8mGxhBmtKZoJDXylPCwexWVnWYPvNfTkJ/OnRURSg
 9xvywwUBPEYsuTodARQR87C5ZWGlNUkSEvTJT/GgNvr/Z6dGWdqTO0rb9t4vthmU2j
 hCKEvxnT6ml+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC/DO NOT MERGE 09/12] drm/msm/hdmi: Add HDMI for Eliza
 SoC
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: vkoul@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, neil.armstrong@linaro.org,
 linux-phy@lists.infradead.org, olteanv@gmail.com, robh@kernel.org,
 conor+dt@kernel.org
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-9-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-9-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:22:20 +0000
Message-Id: <20260828142220.AB61C1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The TMDS rate validation for platforms with OPP tables accepts ine=
xact pixel clocks by skipping clock synthesizability checks.
--

commit e2e2d112c3fa04206001b8a9cc56acdda995a731
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

drm/msm/hdmi: Add HDMI for Eliza SoC
   =20
This commit adds HDMI support for the Qualcomm Eliza SoC (DPU v12.4). It
introduces configuration for INTF_11 with new interrupt registers and handl=
es
Eliza's distinct clock and power requirements.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm=
/hdmi/hdmi_bridge.c
> index 17e81628525a9..b5353a1688ddf 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c

[ ... ]

> @@ -459,21 +490,47 @@ static enum drm_mode_status msm_hdmi_bridge_tmds_ch=
ar_rate_valid(const struct dr
>  	 * mdp4/dtv stuff where pixel clk is assigned to mdp/encoder
>  	 * instead):
>  	 */
> -	if (kms->funcs->round_pixclk)
> +	if (kms->funcs->round_pixclk) {
>  		actual =3D kms->funcs->round_pixclk(kms,
>  						  tmds_rate,
>  						  hdmi_bridge->hdmi->encoder);
> -	else if (hdmi->extp_clk)
> -		actual =3D clk_round_rate(hdmi->extp_clk, tmds_rate);
> -	else
> -		actual =3D tmds_rate;
> -
> -	DBG("requested=3D%lld, actual=3D%ld", tmds_rate, actual);
> -
> -	if (actual !=3D tmds_rate)
> -		return MODE_CLOCK_RANGE;
> -
> -	return 0;
> +		DBG("requested=3D%lld, actual=3D%ld", tmds_rate, actual);
> +
> +		if (actual !=3D tmds_rate)
> +			return MODE_CLOCK_RANGE;
> +		return MODE_OK;
> +	} else if (!dev_pm_opp_get_opp_count(&hdmi->pdev->dev)) {
> +		if (hdmi->extp_clk)
> +			actual =3D clk_round_rate(hdmi->extp_clk, tmds_rate);
> +		else
> +			actual =3D tmds_rate;
> +
> +		if (actual !=3D tmds_rate)
> +			return MODE_CLOCK_RANGE;
> +		return MODE_OK;
> +	} else {
> +		struct dev_pm_opp *opp;
> +		unsigned long pclk_rate =3D tmds_rate;
> +
> +		if (mode->clock > 600000)
> +			return MODE_CLOCK_HIGH;
> +
> +		opp =3D dev_pm_opp_find_freq_ceil(&hdmi->pdev->dev, &pclk_rate);
> +		if (!IS_ERR(opp)) {
> +			dev_pm_opp_put(opp);
> +		} else if (PTR_ERR(opp) =3D=3D -ERANGE) {
> +			/*
> +			 * An empty table is created by devm_pm_opp_set_clkname() even
> +			 * if there is none. Thus find_freq_ceil will still return
> +			 * -ERANGE in such case.
> +			 */
> +			return MODE_CLOCK_RANGE;
> +		} else {
> +			return MODE_ERROR;
> +		}
> +
> +		return MODE_OK;

[Severity: High]
Does this bypass clock synthesizability checks for platforms with OPP table=
s?

The TMDS rate validation here accepts inexact pixel clocks because it skips
the exact match check that is enforced in the non-OPP path:

	if (hdmi->extp_clk)
		actual =3D clk_round_rate(hdmi->extp_clk, tmds_rate);
	...
	if (actual !=3D tmds_rate)
		return MODE_CLOCK_RANGE;

When msm_hdmi_bridge_tmds_char_rate_valid() searches for an OPP entry, it
uses dev_pm_opp_find_freq_ceil() which finds a ceiling rather than an exact
match. Because it returns MODE_OK unconditionally upon finding a ceiling,
it can accept display modes that the hardware clock generator cannot
exactly synthesize.

Could this result in configuring an inaccurate pixel clock for the display,
leading to Out of Range errors or visual corruption?

> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-drm-msm-hd=
mi-eliza-v1-0-67843277de17@oss.qualcomm.com?part=3D9
