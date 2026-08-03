Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66102C55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8D910E00E;
	Mon,  3 Aug 2026 11:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qz6hzBAA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D38FF10E00E
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 11:02:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9BDE8439B9;
 Mon,  3 Aug 2026 11:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCD81F000E9;
 Mon,  3 Aug 2026 11:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785754964;
 bh=JyPuvE8WF3jQrj/fG1aJPEnL6oC9T9tcZ3s8/vwfqnI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qz6hzBAAIZELvsPWwKOWIHMI2kjUPCMF+U3IoQbCJQ1Vouw8imLC8ipFbODWoq/6l
 N7QlDCf+UYfcZt6Qcjj/6jCplQU/fuo+TE8oEug8XMG0os8vnCb9KnUvOsFxnF9q0p
 ajiISiu7gDPot8+nZo0qDg4Ld4UqFu9t1ME0bdibAQl56IxAC7dDK+28VYr6yi12k1
 j3DxHOUZ4adMkwEw/nQB6LC6YXUgvNACfjdiP6Bpz68tOoAD0AckEDC8hUpNNjpOY0
 XLzRVhPiH91NHUMHfmlSlXQSjSsTJMQostMQpqDl/QEBn0v63IguqlLKvJLKbatcTN
 DWWN/xXdlG+zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/dsi: Fix command mode line time calculation
To: "Jinman Ma" <justdreemurr@fzu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260803104851.267090-1-justdreemurr@fzu.edu.cn>
References: <20260803104851.267090-1-justdreemurr@fzu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 11:02:43 +0000
Message-Id: <20260803110244.5FCD81F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] DIV_ROUND_UP_ULL is incorrectly used with a 64-bit divisor and a 32=
-bit numerator, which violates the underlying macro contract.

Pre-existing issues:
- [High] The command mode line time calculation fails to account for dual-l=
ink DSI panel bandwidth scaling, resulting in a computed line time that is =
exactly twice the physical line time and halving the requested vertical bla=
nking period.
--

--- Patch [1]: [PATCH] drm/i915/dsi: Fix command mode line time calculation=
 ---
commit edcb713539337dd734175d1e81417b69dd057925
Author: Jinman Ma <justdreemurr@fzu.edu.cn>

drm/i915/dsi: Fix command mode line time calculation

This commit changes the line time calculation for command mode DSI panels
from microseconds to nanoseconds. This prevents divide-by-zero errors during
atomic commits at high link rates.

> diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i91=
5/display/icl_dsi.c
> --- a/drivers/gpu/drm/i915/display/icl_dsi.c
> +++ b/drivers/gpu/drm/i915/display/icl_dsi.c
> @@ -917,16 +917,19 @@ gen11_dsi_set_transcoder_timings(struct intel_encod=
er *encoder,
>  	if (is_vid_mode(intel_dsi)) {
>  		vtotal =3D adjusted_mode->crtc_vtotal;
>  	} else {
> -		int bpp, line_time_us, byte_clk_period_ns;
> +		u64 line_time_ns;
> +		int bpp;
> =20
>  		if (crtc_state->dsc.compression_enable)
>  			bpp =3D fxp_q4_to_int(crtc_state->dsc.compressed_bpp_x16);
>  		else
>  			bpp =3D mipi_dsi_pixel_format_to_bpp(intel_dsi->pixel_format);
> =20
> -		byte_clk_period_ns =3D 1000000 / afe_clk(encoder, crtc_state);
> -		line_time_us =3D (htotal * (bpp / 8) * byte_clk_period_ns) / (1000 * i=
ntel_dsi->lane_count);
> -		vtotal =3D vactive + DIV_ROUND_UP(400, line_time_us);
> +		line_time_ns =3D DIV_ROUND_UP_ULL((u64)htotal * bpp * 1000000,
> +						afe_clk(encoder, crtc_state) *
> +						intel_dsi->lane_count);

[Severity: High]
This is a pre-existing issue, but does this calculation fail to account for
dual-link DSI panel bandwidth scaling?

Because the calculation uses the full htotal against the single-port
bandwidth, and afe_clk is already halved for dual-link setups during VBT
parsing, this results in a computed line_time_ns that is exactly twice the
physical line time.

Further down in gen11_dsi_set_transcoder_timings(), htotal is properly
halved for dual-link configurations:

    if (intel_dsi->dual_link) {
        hactive /=3D 2;
        if (intel_dsi->dual_link =3D=3D DSI_DUAL_LINK_FRONT_BACK)
            hactive +=3D intel_dsi->pixel_overlap;
        htotal /=3D 2;
    }

Since this htotal halving happens after line_time_ns is calculated, could
this be requesting half the necessary blanking lines, providing ~200 us
of vertical blanking time instead of the required 400 us? This might explain
the persistent tearing and jitter mentioned in the commit message.

> +		vtotal =3D vactive +
> +			DIV_ROUND_UP_ULL(400 * 1000, line_time_ns);

[Severity: Low]
Does this usage of DIV_ROUND_UP_ULL() reverse the expected types for the
numerator and denominator?

The DIV_ROUND_UP_ULL() macro is designed for a 64-bit numerator and a 32-bit
denominator. When do_div() is used internally on 32-bit architectures, it
implicitly truncates the denominator to 32 bits.

While line_time_ns easily fits within 32 bits here, so there is no
functional impact, is there a risk of violating the underlying macro
contract by using a 32-bit numerator and a 64-bit divisor?

>  	}
>  	vsync_start =3D adjusted_mode->crtc_vsync_start;
>  	vsync_end =3D adjusted_mode->crtc_vsync_end;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803104851.2670=
90-1-justdreemurr@fzu.edu.cn?part=3D1
