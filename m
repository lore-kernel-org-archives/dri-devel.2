Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56DBC61DE4
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43E410E55D;
	Sun, 30 Aug 2026 16:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JLVL8459";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A839910E0EB;
 Sun, 30 Aug 2026 16:33:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A6FC600AE;
 Sun, 30 Aug 2026 16:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0307B1F000E9;
 Sun, 30 Aug 2026 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788107585;
 bh=+0Y7nWWh4etciCtwsIekUWGxfb/32vQ0fTVPeTJID20=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JLVL8459zTJ9oq/7g1Q+8Jj3rrZYXB0c9LINqQcmwloaX0pcsO+Fyiai6KEpFjpge
 fnPdoHVSXdTOOmMn16k1ZG/vKKdg/Akm/+WkeIFuOKNjyJe82lGGTuCU6Ri7C84Iap
 4NWNjx0ot0WwGiQkNkGl1/yvX//rFvQrjlRIbRrRV9BYGCJv3coADAUwaqZVD80BPH
 FSbsn7EjCrcsaCYOYg7ks6DE5vanXtTK8sOiA+fDXoGiCGdawFEkJwM1GBDFeDCOa+
 dNbWZeQj8ov98Rb4hvr7HwE7ziy7ZjC9BB2cKIuD9s3QudvxfeocUT/7L3ftyf5nw5
 RLeZ1qUAK3Z0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/cdclk: Don't trust boot readout for per-pipe
 cdclk/voltage tracking
To: "Eduardo Diaz" <iamedu@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260830161703.11570-1-iamedu@gmail.com>
References: <20260830161703.11570-1-iamedu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 16:33:04 +0000
Message-Id: <20260830163305.0307B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Zeroing `min_cdclk` and `min_voltage_level` during boot readout co=
rrupts the global state tracking for inherited pipes, leading to FIFO under=
runs on partial commits.
- [High] The boot-time invalidation of cdclk/voltage tracking is fragile an=
d gets silently undone during hardware sanitization, breaking the fix for t=
he remaining active pipes.
- [Medium] Moving the early return in the CDCLK update paths forces unneces=
sary global state duplication and memory allocation on every page flip.
- [Low] The `old_min_cdclk` and `old_min_voltage_level` parameters are now =
ignored and immediately overwritten.
--

commit edef4e8a0b14b779ca2831158248f1bc907d372c
Author: Eduardo Diaz <iamedu@gmail.com>

drm/i915/cdclk: Don't trust boot readout for per-pipe cdclk/voltage tracking

This commit addresses a bug where cold boot corrupts the internal eDP panel
due to cdclk/voltage tracking assuming firmware-programmed state as its own.
It invalidates the tracking state during readout and forces the cdclk and
voltage update functions to skip early returns.

> diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm=
/i915/display/intel_cdclk.c
> index a53d887271778..209a2373d17aa 100644
> --- a/drivers/gpu/drm/i915/display/intel_cdclk.c
> +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
> @@ -2981,11 +2981,14 @@ static int intel_cdclk_update_crtc_min_cdclk(stru=
ct intel_atomic_state *state,
>  	bool allow_cdclk_decrease =3D intel_any_crtc_needs_modeset(state);
>  	int ret;
> =20
> -	if (new_min_cdclk =3D=3D old_min_cdclk)
> -		return 0;
> -
> -	if (!allow_cdclk_decrease && new_min_cdclk < old_min_cdclk)
> -		return 0;
> +	/*
> +	 * old_min_cdclk comes from the previous crtc_state, which after
> +	 * boot-time readout reflects whatever firmware/GOP left running,
> +	 * not what this driver has programmed. For an inherited pipe it
> +	 * equals new_min_cdclk by construction (same mode, same formula),
> +	 * so an early return here would skip the recalculation that
> +	 * matters. Always continue on to the cdclk_state check below.
> +	 */
> =20
>  	cdclk_state =3D intel_atomic_get_cdclk_state(state);
>  	if (IS_ERR(cdclk_state))

[Severity: Medium]
Moving this early return causes the state duplication and memory allocations
in intel_atomic_get_cdclk_state() to occur unconditionally on every commit,
including every page flip. Does this introduce a performance regression or
latency spike in this hot path?

[Severity: Low]
Additionally, since the old_min_cdclk value passed into the function is now
overwritten right after intel_atomic_get_cdclk_state() returns:

    old_min_cdclk =3D cdclk_state->min_cdclk[crtc->pipe];

Does this make the old_min_cdclk parameter passed by the caller dead code
that is never actually read?

[ ... ]

> @@ -3026,12 +3029,10 @@ static int intel_cdclk_update_crtc_min_voltage_le=
vel(struct intel_atomic_state *
>  	bool allow_voltage_level_decrease =3D intel_any_crtc_needs_modeset(stat=
e);
>  	int ret;
> =20
> -	if (new_min_voltage_level =3D=3D old_min_voltage_level)
> -		return 0;
> -
> -	if (!allow_voltage_level_decrease &&
> -	    new_min_voltage_level < old_min_voltage_level)
> -		return 0;
> +	/*
> +	 * old_min_voltage_level is unreliable for the same reason; see
> +	 * intel_cdclk_update_crtc_min_cdclk().
> +	 */
> =20
>  	cdclk_state =3D intel_atomic_get_cdclk_state(state);
>  	if (IS_ERR(cdclk_state))

[Severity: Low]
Similarly to old_min_cdclk, is the old_min_voltage_level parameter now igno=
red
and overwritten before it is ever used?

[ ... ]

> @@ -3705,6 +3706,28 @@ void intel_cdclk_update_hw_state(struct intel_disp=
lay *display)
>  	cdclk_state->dbuf_bw_min_cdclk =3D intel_dbuf_bw_min_cdclk(display, dbu=
f_bw_state);
>  }
> =20
> +/*
> + * intel_cdclk_update_hw_state() seeds min_cdclk[]/min_voltage_level[]
> + * from readout's crtc_state, i.e. from whatever firmware/GOP left
> + * running, not from anything this driver has programmed. A pipe's
> + * first real modeset usually targets the same native mode, so the
> + * freshly computed value matches this seeded baseline and
> + * intel_cdclk_update_crtc_min_cdclk()/_min_voltage_level() conclude
> + * nothing changed, skipping the recalculation that matters. Call
> + * this after readout so the first real commit sees a difference.
> + */
> +void intel_cdclk_invalidate_min_tracking(struct intel_display *display)
> +{
> +	struct intel_cdclk_state *cdclk_state =3D
> +		to_intel_cdclk_state(display->cdclk.obj.state);
> +	enum pipe pipe;
> +
> +	for_each_pipe(display, pipe) {
> +		cdclk_state->min_cdclk[pipe] =3D 0;
> +		cdclk_state->min_voltage_level[pipe] =3D 0;
> +	}
> +}

[Severity: High]
Does zeroing min_cdclk for all pipes corrupt the state for inherited pipes
that are not included in the first atomic commit?

If the OS performs a partial commit (e.g., a cursor update on a single pipe)
on a multi-display setup, intel_cdclk_update_crtc_min_cdclk() will only
update the tracking for the pipe in the commit.

Because intel_compute_min_cdclk() takes the maximum of all pipes' requireme=
nts,
will the untouched active pipes with 0 tracked requirement be starved of th=
eir
necessary clock speed, leading to a FIFO underrun?

[Severity: High]
Can this boot-time invalidation be silently undone during hardware sanitiza=
tion?

If a CRTC requires sanitization during boot, intel_crtc_disable_noatomic()
calls intel_cdclk_crtc_disable_noatomic(), which in turn calls
intel_cdclk_update_hw_state().

intel_cdclk_update_hw_state() loops over all pipes and does:

    cdclk_state->min_cdclk[pipe] =3D crtc_state->min_cdclk;

Since crtc_state->min_cdclk still contains the readout value, does this
re-seed the tracking values for the remaining active pipes, circumventing
the fix entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830161703.1157=
0-1-iamedu@gmail.com?part=3D1
