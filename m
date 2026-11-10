Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E96606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0W3ofRf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6720010E209;
	Tue, 10 Nov 2026 09:00:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D90010EEBD
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:00:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 956A7637EF;
 Tue, 10 Nov 2026 09:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203E71F008A1;
 Tue, 10 Nov 2026 09:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794301245;
 bh=Xatw6Qme9eHOIvmoKC15Nop8cYqUu0N4OeiHg2hYVTo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W0W3ofRfoQFiNLDOGN3lpOeZULYJO8X8O4JR18TOy2GF6Vr0qCOIibXj5zEA08raM
 UAv3oZp4CaODIawmVZBtPuaRKRUJ3O4XbJ8jQTeTmJWRzkpR3+P0WumvgUI9nsVjsl
 iw9hUNx26tl4ufEFrNzTjKb8qwFnkyW2jb6jqC1LW8UKkjpM5yyMczAjh22n8BGZh9
 5G//JeXubM7e4nB/1dSKk2qTEYV1InkN+Ozddk/9MuFzrkoE00iBNyHHDmTU7cC+Eh
 74OaobmG6D2/U47RINA4/HHXudzlYJf5opb76fjquhlo1X7+LXiLvigv40cfgIgGul
 WipTw0bTy47ew==
Message-ID: <sashiko-outbox-206691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Only allow idle optimizations when all
 CRTCs are idle
To: "Claudio Forain" <claudioforain@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109230147.16302-1-claudioforain@gmail.com>
References: <20261109230147.16302-1-claudioforain@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:00:44 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/amd/display: idle optimization stall in
  dm_ism_all_crtcs_idle()
- [High] drm/amd/display: unlocked crtc->state access in
  dm_ism_all_crtcs_idle()
- [Medium] drm/amd/display: NULL dereference in dm_ism_all_crtcs_idle()
  in KUnit tests
--

commit 41942a97fda7dd8d4e331b05631c7ae4c3d2cd19
Author: Claudio Forain <claudioforain@gmail.com>

drm/amd/display: Only allow idle optimizations when all CRTCs are idle

This commit adds dm_ism_all_crtcs_idle() so that hardware-wide idle
optimizations are only enabled when every active CRTC's Idle State Manager
is in an optimized idle state.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4906

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> index 127eaba4de60b..79546ad592874 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> @@ -276,6 +276,32 @@ bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,
>  EXPORT_IF_KUNIT(dm_ism_trigger_event);
> =20
> =20
> +/*
> + * Idle optimizations are HW-wide, but each CRTC runs its own ISM. Only =
allow
> + * them once every active CRTC's ISM has reached an optimized idle state=
, so a
> + * static CRTC cannot enable idle optimizations while another CRTC is st=
ill busy
> + * (e.g. receiving cursor updates without a vblank reference). Otherwise=
 every
> + * cursor update on the busy CRTC must exit and re-enter idle through DM=
UB.
> + */
> +static bool dm_ism_all_crtcs_idle(struct amdgpu_display_manager *dm)
> +{
> +	struct drm_crtc *crtc;
> +
> +	drm_for_each_crtc(crtc, adev_to_drm(dm->adev)) {

[Severity: Medium]
Does walking adev_to_drm(dm->adev)->mode_config.crtc_list here cause a NULL
pointer dereference in the amdgpu_dm_ism KUnit test suite?

Unlike amdgpu_dm_ism_disable(), amdgpu_dm_ism_force_full_power() and
amdgpu_dm_ism_enable(), which pass dm->ddev to drm_for_each_crtc(), this
uses adev_to_drm(dm->adev).  In amdgpu_dm_ism_test.c, alloc_test_acrtc() and
setup_commit_test() set adev->dm.ddev =3D &adev->ddev, but leave adev->dm.a=
dev
NULL and do not initialize mode_config.crtc_list or register the test CRTC =
on
it, crashing the six behavioral commit and worker KUnit tests when they rea=
ch
dm_ism_commit_idle_optimization_state().

> +		struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);
> +		struct dm_crtc_state *state =3D to_dm_crtc_state(crtc->state);
> +
> +		if (!state || !state->stream)
> +			continue;

[Severity: High]
Can reading crtc->state and dereferencing state->stream across all CRTCs
under only dm->dc_lock race with an atomic commit on another CRTC and cause=
 a
use-after-free?

dm_ism_all_crtcs_idle() runs from ISM delayed work or
amdgpu_dm_crtc_vblank_control_worker() holding dm->dc_lock, while crtc->sta=
te
is protected by crtc->mutex.  An atomic commit on another CRTC that does not
take dm->dc_lock in amdgpu_dm_atomic_commit_tail() can swap and free the old
CRTC state concurrently:

CPU0 (ISM worker on CRTC 0)           CPU1 (atomic commit on CRTC 1)
dm_ism_delayed_work_func()
  mutex_lock(&dm->dc_lock)
  ...
  dm_ism_all_crtcs_idle(dm)
    state =3D to_dm_crtc_state(
              crtc1->state)
                                      drm_atomic_helper_swap_state()
                                        crtc1->state =3D new_crtc_state
                                      ...
                                      drm_atomic_commit_put()
                                        amdgpu_dm_crtc_destroy_state()
                                          kfree(old_crtc_state)
    if (!state || !state->stream)  <-- use-after-free

> +
> +		if (acrtc->ism.current_state !=3D DM_ISM_STATE_OPTIMIZED_IDLE &&
> +		    acrtc->ism.current_state !=3D DM_ISM_STATE_OPTIMIZED_IDLE_SSO)
> +			return false;

[Severity: High]
Can requiring every active CRTC to be in DM_ISM_STATE_OPTIMIZED_IDLE or
DM_ISM_STATE_OPTIMIZED_IDLE_SSO permanently block hardware-wide idle
optimizations?

Both amdgpu_dm_ism_init() and amdgpu_dm_ism_force_full_power() (called on
suspend and GPU reset) leave each CRTC in DM_ISM_STATE_FULL_POWER_RUNNING.
The only transition toward DM_ISM_STATE_OPTIMIZED_IDLE is
DM_ISM_EVENT_ENTER_IDLE_REQUESTED, which is only sent from
amdgpu_dm_crtc_vblank_control_worker() when vblank is disabled.

When a CRTC is enabled from off via a modeset without a pageflip event, or
restored on resume or GPU reset, manage_dm_interrupts() calls
drm_crtc_vblank_on_config() without enabling vblank.  If that display stays
static and never takes and drops a vblank reference, its ISM remains in
DM_ISM_STATE_FULL_POWER_RUNNING and dm_ism_all_crtcs_idle() returns false
forever.

Similarly, in amdgpu_dm_commit_streams(), a modeset or disable on a CRTC in
DM_ISM_STATE_HYSTERESIS_WAITING calls amdgpu_dm_ism_flush(), which cancels
delayed_work without updating current_state or re-evaluating idle state for
the remaining active CRTCs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109230147.1630=
2-1-claudioforain@gmail.com?part=3D1
