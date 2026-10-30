Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEECF606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjQoFnjL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 634FE112A43;
	Fri, 30 Oct 2026 22:19:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E01110E0E8
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 22:19:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C09C9601F8;
 Fri, 30 Oct 2026 22:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524A81F000C1;
 Fri, 30 Oct 2026 22:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793398757;
 bh=QFHwgVHXu00VsCI9Abkas5YHNs9L7aZ0WTBWH6kOduo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RjQoFnjLmoOC1Ops8ivvABw760jy0OEN0yLICCjIznNVmUzzS8s07VdMggL6FCEoN
 r9MXLel53lMcYIyIVNQJE6CuFqLxSAhMl5X3UErA3Mhpd+9ryGYpx3dYfkYBWhK/pU
 xXuobX9TLbsxvSsfWkExYHBU9zrxMZmUBJEsVCAhxGpfPkoPVXOChFEqanzEPjsG24
 G80MAxVb1YCV4vYVlM/iHoDEde2kmb4JaKNlwJ5sxqPmkGz3sBB3glGeSX3R2e8KyC
 B/fHt/HYyLeEc6nhQOaH94NMgTeZx/pH1nxFKquIu56Rw+dbjVC/GdRk5kQwLFV+C2
 WrmO7dAcFHe1g==
Message-ID: <sashiko-outbox-191573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: use atomic commit for panel power savings
To: "Shivam Kalra" <shivamkalra98@zohomail.in>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261031-abm-sysfs-atomic-v1-1-a99068f3b49c@zohomail.in>
References: <20261031-abm-sysfs-atomic-v1-1-a99068f3b49c@zohomail.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:19:16 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] drm/amd/display: commit message claims non-modeset stream update pa=
th
- [Low] drm/amd/display: duplicate connector state helpers in backlight KUn=
it test
--

commit 60bc0c08268c70e96bfcf62cb19e21a33e151366
Author: Shivam Kalra <shivamkalra98@zohomail.in>

drm/amd/display: use atomic commit for panel power savings

This commit updates panel_power_savings_store() to apply ABM level changes
through an atomic commit instead of mutating connector->state directly and
emitting a hotplug uevent, and extends the backlight KUnit test suite.

>     drm/amd/display: use atomic commit for panel power savings
>    =20
>     panel_power_savings_store() mutates connector->state directly and sen=
ds a
>     hotplug event. This bypasses atomic commit handling, so the new ABM l=
evel
>     is only applied when userspace happens to perform another modeset, an=
d it
>     races with concurrent commits.
>    =20
>     Build an atomic state, set the level on the connector state and commi=
t it.
>     If the connector is not attached to a CRTC, keep the level in the cur=
rent
>     state so the next modeset picks it up, as before.
>    =20
>     A previous attempt to avoid the modeset by calling into DMUB directly=
 was
>     reverted because it broke the abm_gradual IGT test (8d20a066fa9b,
>     95aaa207e9ef). This version instead uses the normal atomic stream upd=
ate
>     path.
>    =20
>     Expose the atomic state update helper for KUnit and extend the tests =
to
>     cover the atomic update and the inactive sysfs path.
>    =20
>     Fixes: 63d0b87213a0 ("drm/amd/display: add panel_power_savings sysfs =
entry to eDP connectors")
>     Signed-off-by: Shivam Kalra <shivamkalra98@zohomail.in>

[Severity: Low]
This isn't a bug, but is the commit message accurate when it says that this
version avoids a modeset by using the normal atomic stream update path?

When panel_power_savings_store() calls drm_atomic_commit(state) in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c,
amdgpu_dm_atomic_check() in drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm=
.c
marks connectors_changed when abm_level changes:

	if (dm_old_con_state->abm_level !=3D dm_new_con_state->abm_level ||
	    dm_old_con_state->scaling !=3D dm_new_con_state->scaling)
		new_crtc_state->connectors_changed =3D true;

Because connectors_changed is set, drm_atomic_crtc_needs_modeset() returns
true, causing amdgpu_dm_atomic_commit_tail() to perform a full modeset and
skip the non-modeset connector stream update loop:

	/* Skip any modesets/resets */
	if (!acrtc || drm_atomic_crtc_needs_modeset(new_crtc_state))
		continue;

The note below the "---" separator mentions that standalone operation still
performs a modeset and depends on an unmerged companion series to use the
non-modeset stream update path, but that note is stripped when the patch is
applied. Should the commit message itself describe the standalone modeset
behavior?

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backli=
ght_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backligh=
t_test.c
> index c6d15fb8ad989..a482261e85d25 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_tes=
t.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_tes=
t.c
> @@ -514,6 +514,37 @@ static void dm_test_register_backlight_device_succes=
s(struct kunit *test)
>  			adev->dm.backlight_dev[0]), 0);
>  }
> =20
> +static struct drm_connector_state *
> +dm_test_panel_power_savings_duplicate_state(struct drm_connector *connec=
tor)
> +{
> +	struct dm_connector_state *state;
> +
> +	state =3D kmemdup(to_dm_connector_state(connector->state),
> +			sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return NULL;
> +
> +	__drm_atomic_helper_connector_duplicate_state(connector, &state->base);
> +
> +	return &state->base;
> +}
> +
> +static void
> +dm_test_panel_power_savings_destroy_state(struct drm_connector *connecto=
r,
> +					  struct drm_connector_state *state)
> +{
> +	__drm_atomic_helper_connector_destroy_state(state);
> +	kfree(to_dm_connector_state(state));
> +}
> +
> +static const struct drm_connector_funcs dm_test_panel_power_savings_conn=
ector_funcs =3D {
> +	.atomic_duplicate_state =3D dm_test_panel_power_savings_duplicate_state,
> +	.atomic_destroy_state =3D dm_test_panel_power_savings_destroy_state,
> +};

[Severity: Low]
This isn't a bug, but could dm_test_panel_power_savings_connector_funcs in
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c reuse
amdgpu_dm_connector_atomic_duplicate_state() and
drm_atomic_helper_connector_destroy_state() instead of defining
dm_test_panel_power_savings_duplicate_state() and
dm_test_panel_power_savings_destroy_state()?

In drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c,
amdgpu_dm_connector_atomic_duplicate_state() is already exported with
EXPORT_IF_KUNIT and performs the same kmemdup() and
__drm_atomic_helper_connector_duplicate_state() sequence, and
dm_test_connector_funcs in
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c uses
both helpers directly:

static const struct drm_connector_funcs dm_test_connector_funcs =3D {
	.reset =3D amdgpu_dm_connector_funcs_reset,
	.atomic_duplicate_state =3D amdgpu_dm_connector_atomic_duplicate_state,
	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-abm-sysfs-=
atomic-v1-1-a99068f3b49c@zohomail.in?part=3D1
