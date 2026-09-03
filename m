Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653C6C624DE
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93A4310F42D;
	Thu,  3 Sep 2026 07:41:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CmtynO5x";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02E310F42D
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 07:41:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C9F143B69;
 Thu,  3 Sep 2026 07:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456231F00A3D;
 Thu,  3 Sep 2026 07:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788421312;
 bh=R1xvoqtEOpgQAW7kVD0auUkwE7Uxh4KKEAvoSnYoRoc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CmtynO5x+nBEYBkmyiBBoSZlIpGjHU7YRVoDBw0NV9VvelB8ws4bfcmsM7q/0xWiH
 ZMXldjNMtqJbplISSuTqeyaR+X4zBBSKMJtguRgUUrea/aBqu1UcW78msrvXN9rfTI
 dvJ6R8ziKGOyLh9IBfn8X3MGmMC/pucHVhsbwAeErUM7znOqNQ5AoXT4xFPp5BA5x3
 e99VlEmeuMiMT/mui4rKBJ+5f8JFP1aYb2a8e9/FAB2/00H8lo4IN+hxiuMUn0J2CA
 bcUxnvDKtj8JAMiSuPTUeg3i/3+RlV1xh0YansWLsyeTxzCzbBuBjtCXdRlKCJ9CQW
 DgTTDGC1tKKmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: fix MALL hysteresis timer underflow at
 high refresh rates
To: "Francis Marlou Pacaro" <pacaro.francis.marlou.n@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903055952.62906-1-pacaro.francis.marlou.n@gmail.com>
References: <20260903055952.62906-1-pacaro.francis.marlou.n@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:41:51 +0000
Message-Id: <20260903074152.456231F00A3D@smtp.kernel.org>
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

Pre-existing issues:
- [High] Potential kernel panic due to division by zero if `refresh_hz` or =
`denom` evaluates to 0.
--

commit 66e20e6af2a54e1f051a2802b102f884a27f0948
Author: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>

drm/amd/display: fix MALL hysteresis timer underflow at high refresh rates

This commit fixes an issue where high refresh rates cause the MALL frame
cache hysteresis timer calculation to wrap instead of going negative. It
addresses this by explicitly calculating the timer ticks and clamping the
result to 0 to prevent the underflow.

> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> index 8b0a667dc59b7..76aa7a82e24e7 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> @@ -1065,10 +1065,12 @@ bool dcn30_apply_idle_power_optimizations(struct =
dc *dc, bool enable)
>  				 */
>  				unsigned int denom =3D refresh_hz * 6528;
>  				unsigned int stutter_period =3D dc->current_state->perf_params.stutt=
er_period_us;
> +				u64 num =3D (1000000LL + 2 * stutter_period * refresh_hz) *
> +					(100LL + dc->debug.mall_additional_timer_percent);
> +				u64 tmr_ticks;
> =20
> -				tmr_delay =3D (uint32_t)(div_u64(((1000000LL + 2 * stutter_period * =
refresh_hz) *
> -						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
> -						denom) - 64LL);
> +				tmr_ticks =3D div_u64(num + denom - 1, denom);

[Severity: High]
This is a pre-existing issue, but could this calculation trigger a division
by zero kernel panic if denom is 0?

Looking at how refresh_hz is calculated earlier in
dcn30_apply_idle_power_optimizations():

    refresh_hz =3D (unsigned int)div_u64(
            (unsigned long long)stream->timing.pix_clk_100hz * 100LL,
            (v_total * stream->timing.h_total));

If a compositor provides a malformed display mode with very low clocks and
high totals such that pix_clk_100hz * 100 < v_total * h_total, refresh_hz
will evaluate to 0. This makes denom =3D 0, leading to a division by zero in
the div_u64() call above.

Additionally, this same condition natively panics a few lines down in the
unpatched context where we check the stutter period:

    if (stutter_period > 100000/refresh_hz)
        return false;

Would it make sense to add an early return to check if refresh_hz evaluates
to 0 before proceeding with these calculations?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903055952.6290=
6-1-pacaro.francis.marlou.n@gmail.com?part=3D1
