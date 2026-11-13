Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97023606A333
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BdbsOvip
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0150910ECA4;
	Fri, 13 Nov 2026 21:07:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34A7610E0F4;
 Fri, 13 Nov 2026 21:07:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 303E3623A5;
 Fri, 13 Nov 2026 21:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFF41F000C5;
 Fri, 13 Nov 2026 21:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794604050;
 bh=kYw3fgn9+viVP9mrF/w0Dm0lCK2fQ0CCpVxoizjLxzA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BdbsOvipPouQ8p9NiyiD5lYF47TwfIS0B1toLPC6SeD3SnvU2bi6YOvE5QXuUSkST
 IYWlf0rkZi5Td5/7EMMBT2pi2IExqwuIuWQv28ht6EUP8MpIx7L217QNVZqdsNIJw7
 JAQN2G0j2Ro/FaXpfFPr7qfugOUHdxedhOVWwV+dJcxxUtHMX4e7rOPxvPSz+11On6
 FST+RgVN8/IvGloX5cCFpIPObUaTaGMWP/BEP4o1ufMW3pGJrDirnEpAJkBd7l/E5c
 9OpSjynh4+/ZjKT4gfbatlqEDOaZPz0VG5PknC612TSPtTvYjT88W4fQBcM3VVe7D8
 /lrsI+Y2fANfQ==
Message-ID: <sashiko-outbox-213691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] drm/amd/display: Don't force a modeset when the
 ABM level changes
To: "Hugo Sales" <hugo@hsal.es>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261113-abm-sysfs-commit-v2-2-5808d17a7e89@hsal.es>
References: <20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es>
 <20261113-abm-sysfs-commit-v2-2-5808d17a7e89@hsal.es>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:07:30 +0000
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
- [Medium] drm/amd/display: missing companion planes on VRR CRTC in
  amdgpu_dm_atomic_check()
--

commit 827e5ec3b519e3ae27f4dddc2ca14ba587d16858
Author: Hugo Sales <hugo@hsal.es>

drm/amd/display: Don't force a modeset when the ABM level changes

This commit stops setting connectors_changed on the CRTC state in
amdgpu_dm_atomic_check() when a connector's abm_level changes, allowing
ABM level updates to proceed without a modeset.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3077744b2d2d5..f5a45686df454 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6371,8 +6371,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct =
drm_device *dev,
>  			goto fail;
>  		}
> =20
> -		if (dm_old_con_state->abm_level !=3D dm_new_con_state->abm_level ||
> -		    dm_old_con_state->scaling !=3D dm_new_con_state->scaling)
> +		if (dm_old_con_state->scaling !=3D dm_new_con_state->scaling)
>  			new_crtc_state->connectors_changed =3D true;
>  	}

[Severity: Medium]
Can a connector-only abm_level commit on a VRR-active CRTC drop active
overlay planes from DC?

Without connectors_changed, drm_atomic_crtc_needs_modeset() is false, so
amdgpu_dm_atomic_check() skips drm_atomic_add_affected_planes().  With no
planes in the atomic state yet, the companion-plane loop in
amdgpu_dm_atomic_check() sees modified =3D=3D false and adds nothing, and b=
oth
dm_update_plane_state() passes run on zero planes.

Later in amdgpu_dm_atomic_check(), drm_atomic_helper_check_planes() calls
amdgpu_dm_crtc_helper_atomic_check(), which pulls only crtc->primary into
the state when VRR is active:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c:amdgpu_dm_crtc_helpe=
r_atomic_check() {
    ...
	if (!state->legacy_cursor_update && amdgpu_dm_crtc_vrr_active(dm_crtc_stat=
e)) {
		struct drm_plane_state *primary_state;

		/* Pull in primary plane for correct VRR handling */
		primary_state =3D drm_atomic_get_plane_state(state, crtc->primary);
		if (IS_ERR(primary_state))
			return PTR_ERR(primary_state);
	}
    ...
}

Because that happens after the companion-plane expansion and
dm_update_plane_state(), amdgpu_dm_commit_planes() submits only
crtc->primary (surface_count =3D=3D 1) to dc_update_planes_and_stream().  If
an overlay plane is active on the stream, DC sees
stream_status->plane_count !=3D surface_count, elevates to UPDATE_TYPE_FULL,
and replaces all planes on the stream with only crtc->primary, leaving the
overlay plane disabled in DC while DRM still considers it enabled and
causing later plane resets or disables on that CRTC to fail with -EINVAL
in dc_state_remove_plane().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-abm-sysfs-=
commit-v2-0-5808d17a7e89@hsal.es?part=3D2
