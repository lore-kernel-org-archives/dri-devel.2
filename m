Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856E5C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7D9310F503;
	Thu,  3 Sep 2026 10:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZLBXTujM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFEE610F503
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 10:52:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 888584126A;
 Thu,  3 Sep 2026 10:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C2A1F000E9;
 Thu,  3 Sep 2026 10:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788432761;
 bh=szRJn7a9pWP8knS4NmhDTIkQwj9e+k1UsT7iRfhv2WU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZLBXTujM/rJihOdp+AYcO8W1sdbccSw/91vzKcnCGtXLxB6zJVr2W59hcngtfd3NN
 Ip4NAAFW4po9aaI6ecq5cXfIKVsbUUP6IN5Rs6tnYiJl8NTtHs5Bp1tdeWLRFVX9Zh
 7xafTlgqTCWk3ZION4e+RQyPCk47Fx7qW49vg0Oxl6K9s8MRwMpmx/YTxwRHsrQQXU
 oApCjSttullIVZZIPXJPdAvLDbTamQZ8PD5/wdgv41Vh0hCLTXK8ertBr3i9KbCOzT
 aJ229uV0aWWFv6+UPMsGOgoH4P2kld3QeCUJW6Zzo75X5lE2s/S5UpFr+4WDHrrlnO
 6EAhma78NclWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dsi: Fix setting completely bogus rate for byte
 clock
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903104732.145353-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260903104732.145353-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:52:40 +0000
Message-Id: <20260903105241.41C2A1F000E9@smtp.kernel.org>
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
- [High] Reverting commit 6cd33b6f4155 directly reintroduces a panel scanou=
t glitch on MSM8916 and similar older platforms during runtime DCS commands.
--

commit bc484ede914d3152ef2331cbb6fea324d910f6be
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

drm/msm/dsi: Fix setting completely bogus rate for byte clock

This commit reverts 6cd33b6f4155 ("drm/msm/dsi: round 6G byte clock rate to
the PLL-achievable value") because the rounding of the byte clock rate broke
DSI display initialization on newer devices like Eliza. It removes the
clk_round_rate() call that modified msm_host->byte_clk_rate.

> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi=
/dsi_host.c
> index 7e4e3718b536c..78e6436a92b21 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -669,24 +669,12 @@ static void dsi_calc_pclk(struct msm_dsi_host *msm_=
host, bool is_bonded_dsi)
> =20
>  int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_d=
si)
>  {
[ ... ]
>  	dsi_calc_pclk(msm_host, is_bonded_dsi);
> -
> -	rounded_byte_clk_rate =3D clk_round_rate(msm_host->byte_clk,
> -					       msm_host->byte_clk_rate);
> -	if (rounded_byte_clk_rate < 0) {
> -		pr_err("%s: failed to round byte clock rate, %ld\n",
> -		       __func__, rounded_byte_clk_rate);
> -		return rounded_byte_clk_rate;
> -	}
> -
> -	msm_host->byte_clk_rate =3D rounded_byte_clk_rate;
>  	msm_host->esc_clk_rate =3D clk_get_rate(msm_host->esc_clk);

[Severity: High]
Does removing clk_round_rate() reintroduce panel scanout glitches on older
platforms like MSM8916 during runtime DCS commands?

Without rounding the byte clock rate up front, the ideal rate computed by
dsi_calc_pclk() is retained in msm_host->byte_clk_rate.=20

When link_clk_set_rate() is called later with this ideal rate, it appears t=
he
clock framework detects a discrepancy with the actual PLL rate, which then
forces the PHY PLL to unnecessarily re-lock. This re-lock visually corrupts
the display scanout and causes the panel to lose pixel lock whenever runtime
commands (like backlight writes) are sent.

While this revert fixes the initialization on newer platforms where the
clock is not yet properly parented at this stage, it seems to reintroduce
the regression on older platforms that the original commit specifically
addressed. Is there a way to apply this workaround only for newer hardware,
or ensure the clock is parented properly before calling clk_round_rate()?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903104732.1453=
53-2-krzysztof.kozlowski@oss.qualcomm.com?part=3D1
