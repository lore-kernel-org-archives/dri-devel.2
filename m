Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD902606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0KDZQkJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2800310EEC5;
	Mon, 16 Nov 2026 09:29:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BBCD10EED0;
 Mon, 16 Nov 2026 09:28:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CB0161CDB;
 Mon, 16 Nov 2026 09:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D03C1F000C9;
 Mon, 16 Nov 2026 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794821336;
 bh=iV0PlOn0JtIZRD1Y78S1YDWGWl3fhKMaQgHUChC2WPs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G0KDZQkJ4Jzll1GdHmMEbEFMObQmKCn3M+3rdzW9Kl9rFjOGkRRHaJPpiedcynxTZ
 yCrI8DnR/GcWo86DuXiykLlj+j1FE/FMgI8yuwXG43pcIlGHtd/KBJYybyHy/eZdKV
 OG3mhdowPcutbYg/WVFN01Z/CWil4q9bwVTXjeFjzU9x9vUUWscXLrHWE6mMbg3QYV
 rMiXiCeHcL+QBxKwlAIUT3s/hoCyu6C98rlflt6Ay+BJ7UB4J6kVn9B5qrHFj6lmnJ
 00UXAPWHs5bplNC0fIYpGeJFEK+2cZwo3BuzvI03dgtLpOoGfFe9l/HQ7R2bLIDdqT
 eetE7EYx7aabg==
Message-ID: <sashiko-outbox-216616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] drm/i915: Complete no-op "async flips" by hand
To: "Ville Syrjala" <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
In-Reply-To: <20261116091130.13950-11-ville.syrjala@linux.intel.com>
References: <20261116091130.13950-1-ville.syrjala@linux.intel.com>
 <20261116091130.13950-11-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:28:56 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/i915: unreachable noop check in
  intel_crtc_complete_noop_async_flip()
- [Medium] drm/i915: intel_crtc_complete_noop_async_flip() checks
  cleared uapi.event
--

commit 828bac38a449130d5473b2a45f7f646152241cec
Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

drm/i915: Complete no-op "async flips" by hand

This commit adds helpers to manually send the vblank event for atomic
async flip commits when no planes are updated.

> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index f79caeb5a82ec..dd12929284bb8 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -1190,6 +1190,42 @@ static void intel_crtc_disable_flip_done(struct in=
tel_atomic_state *state,
>  	}
>  }
> =20
> +static void intel_crtc_complete_noop_async_flip(struct intel_crtc_state =
*crtc_state)
> +{
> +	struct intel_display *display =3D to_intel_display(crtc_state);
> +	struct intel_crtc *crtc =3D to_intel_crtc(crtc_state->uapi.crtc);
> +
> +	if (!crtc_state->do_async_flip)
> +		return;
> +
> +	/*
> +	 * If there are planes actually performing the async flip then
> +	 * the commit will be completed via the flip done interrupt
> +	 * handler. For a fully no-op "async flip" the commit must
> +	 * be completed by hand as no interrupt will be raised.
> +	 */
> +	if (crtc_state->update_planes)
> +		return;

[Severity: Medium]
Can crtc_state->do_async_flip ever be true when crtc_state->update_planes
is zero?

intel_crtc_duplicate_state() initializes both fields to zero/false, and the
only place that sets new_crtc_state->do_async_flip =3D true is
intel_plane_atomic_check_with_state() -> intel_plane_atomic_calc_changes()
for a visible plane, after intel_plane_atomic_check_with_state() has
already set BIT(plane->id) in new_crtc_state->update_planes:

drivers/gpu/drm/i915/display/intel_plane.c:intel_plane_atomic_check_with_st=
ate() {
	...
	if (new_plane_state->uapi.visible || old_plane_state->uapi.visible)
		new_crtc_state->update_planes |=3D BIT(plane->id);
	...
	return intel_plane_atomic_calc_changes(old_crtc_state, new_crtc_state,
					       old_plane_state, new_plane_state);
}

When no visible planes are in the atomic state, crtc_state->do_async_flip
remains false (unlike crtc_state->uapi.async_flip), so this function always
returns early on the first check and never completes a no-op async flip.

> +
> +	if (crtc_state->uapi.event) {
> +		spin_lock_irq(&display->drm->event_lock);
> +		drm_crtc_send_vblank_event(&crtc->base,
> +					   crtc_state->uapi.event);
> +		spin_unlock_irq(&display->drm->event_lock);
> +
> +		crtc_state->uapi.event =3D NULL;
> +	}
> +}

[Severity: Medium]
Will crtc_state->uapi.event always be NULL by the time
intel_crtc_complete_noop_async_flip() runs?

In intel_atomic_commit_tail(), commit_modeset_enables() runs before
intel_atomic_complete_noop_async_flips().  When new_crtc_state->do_async_fl=
ip
is true, intel_update_crtc() -> intel_pipe_update_start() calls
intel_crtc_prepare_vblank_event(new_crtc_state, &crtc->flip_done_event),
which moves new_crtc_state->uapi.event into crtc->flip_done_event and sets
new_crtc_state->uapi.event =3D NULL.  With update_planes =3D=3D 0, no flip-=
done
interrupt will fire to consume crtc->flip_done_event, leaving the event
unsent and causing drm_atomic_helper_wait_for_flip_done() to time out.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116091130.1395=
0-1-ville.syrjala@linux.intel.com?part=3D10
