Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5BF606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mG4YXcQ/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA6110F4F4;
	Tue, 24 Nov 2026 11:26:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC6A10F4C6;
 Tue, 24 Nov 2026 11:26:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3EFB620D0;
 Tue, 24 Nov 2026 11:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD651F000C0;
 Tue, 24 Nov 2026 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795519583;
 bh=YahFZDH9xEpTs3/gaJUL+VNcZgcs0F/7mo0trfEzk7c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mG4YXcQ/kuj2yFb2CAlekMJHWDr80yqKFqRK/a0CawgPcMRz+TSBNd3qo7NClRSaW
 J6XqB62JN/WJsOjM1Ze8I6kNfgt21uzjC0irYE7wfiDzyO3ACHabXF3JBuQVF2h0JJ
 +71WXrjqNv0Pu6dcn3EN/am/ZOMQbX/UgfuuLnCZ1W87RV5GpVSDVfeuPX9haPUKdy
 qHEbBXF4KB3bfXwKdX4sB1h6ZLnfkgxURkRDXMBIiq4amI5IWt1w/InrWjRVGDXt7x
 1okQdLw09no+lsKBEEt91ZGJxATuUUeAfpvQ7RpUH7p8H6ft0Y8jqPsrOqlmOGQtxy
 37D3tFA3/H3mA==
Message-ID: <sashiko-outbox-231047@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] drm/i915: Implement CRTC atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261124-drm-i915-conversion-state-readout-v1-3-b7132f72644d@kernel.org>
References: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
 <20261124-drm-i915-conversion-state-readout-v1-3-b7132f72644d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 11:26:22 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/i915: intel_crtc_create_state() causes UAF in
  drm_mode_config_reset()
--

commit c5121c9ae2a50c81961f73b900dacfb69a94085f
Author: Maxime Ripard <mripard@kernel.org>

drm/i915: Implement CRTC atomic_create_state

This commit adds an atomic_create_state callback for i915 CRTCs by
wrapping intel_crtc_state_alloc() and wiring it into INTEL_CRTC_FUNCS.

> diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/=
i915/display/intel_crtc.c
> index 10ed9bdfee763..7bb3caf913106 100644
> --- a/drivers/gpu/drm/i915/display/intel_crtc.c
> +++ b/drivers/gpu/drm/i915/display/intel_crtc.c
> @@ -177,6 +177,17 @@ struct intel_crtc_state *intel_crtc_state_alloc(stru=
ct intel_crtc *crtc)
>  	return crtc_state;
>  }
> =20
> +static struct drm_crtc_state *intel_crtc_create_state(struct drm_crtc *c=
rtc)
> +{
> +	struct intel_crtc_state *crtc_state;
> +
> +	crtc_state =3D intel_crtc_state_alloc(to_intel_crtc(crtc));
> +	if (!crtc_state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return &crtc_state->uapi;
> +}
> +
>  void intel_crtc_state_reset(struct intel_crtc_state *crtc_state,
>  			    struct intel_crtc *crtc)
>  {
> @@ -243,6 +254,7 @@ static int intel_crtc_late_register(struct drm_crtc *=
crtc)
>  	.set_config =3D drm_atomic_helper_set_config, \
>  	.destroy =3D intel_crtc_destroy, \
>  	.page_flip =3D drm_atomic_helper_page_flip, \
> +	.atomic_create_state =3D intel_crtc_create_state, \

[Severity: High]
Does wiring up .atomic_create_state cause a use-after-free of
struct intel_crtc_state when drm_mode_config_reset() runs on resume or
Xe D3cold exit?

When crtc->funcs->atomic_create_state is populated,
drm_mode_config_reset() calls
drm_mode_config_crtc_reset_with_create_state(), which destroys
crtc->state via atomic_destroy_state() and replaces it with a new state
from atomic_create_state().  Both i915 and Xe call
drm_mode_config_reset() in i915_drm_resume(), xe_display_pm_resume(),
and xe_display_disable_d3cold(), where INTEL_CRTC_FUNCS previously had
neither .reset nor .atomic_create_state.

First, replacing crtc->base.state without updating intel_crtc->config
leaves crtc->config as a dangling pointer to the freed state.  During
intel_modeset_setup_hw_state() on system resume,
intel_modeset_readout_hw_state() resets crtc->base.state in place and
paths such as bxt_dsi_get_config() or
intel_crtc_disable_noatomic_complete() -> intel_update_watermarks() ->
intel_crtc_active() dereference the freed crtc->config before
intel_atomic_commit_tail() updates it.

Second, on Xe D3cold exit, an atomic commit records
state->crtcs[i].old_state =3D crtc->state before intel_atomic_commit()
calls intel_display_rpm_get(), which wakes the device and runs
xe_display_disable_d3cold() -> drm_mode_config_reset().  That frees
old_crtc_state mid-commit, so intel_atomic_setup_commit() and
drm_atomic_helper_swap_state() read and write freed memory, hit
WARN_ON(crtc->state !=3D old_crtc_state), leak the newly allocated state,
and double free old_crtc_state when the commit is put.  Even outside an
atomic commit, xe_display_disable_d3cold() runs unlocked without state
restoration and wipes active CRTC state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-drm-i915-c=
onversion-state-readout-v1-0-b7132f72644d@kernel.org?part=3D3
