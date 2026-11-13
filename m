Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A8606A334
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcEktn9W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84FE610E6E1;
	Fri, 13 Nov 2026 21:28:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE4710E6E1;
 Fri, 13 Nov 2026 21:28:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F3D9360120;
 Fri, 13 Nov 2026 21:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799F01F000C4;
 Fri, 13 Nov 2026 21:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794605328;
 bh=qr8F0iRte2sKnHwdoKEootlH8v0MVrjBHVzuaOUS/K4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IcEktn9WNVP1HphCtVRLpbLeAugwOiNPouEOCzUA/rdUp9jJopaJVasDFt1sEb++/
 7Qx6Z83+jWaKcndo31FPtXb6/O71rWfmygus00aJ7SaF8GNn4R4rqkpe46dKWjee0+
 SNsqFdGUHqCZVk4ZmC27SxneUZQVjEFZQXaEE8+8kjDhECjLmKW1hPZErn+X8ItbJE
 R1p7gTw9DDKsllyepXghtQxS9ZrY+hqHkVPlPEDYsEcvnsOVoMVpNxTZD1Xk76+yAO
 cCFQHVE7Ngzm80GrPScAg71i/W3LH4LFheyH+3V400CMMIxNzzPYXO6Hosj/O8MwJx
 IIbk1L14kHd8A==
Message-ID: <sashiko-outbox-213714@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] drm/amd/display: Commit panel_power_savings
 writes from the kernel
To: "Hugo Sales" <hugo@hsal.es>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261113-abm-sysfs-commit-v2-4-5808d17a7e89@hsal.es>
References: <20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es>
 <20261113-abm-sysfs-commit-v2-4-5808d17a7e89@hsal.es>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:28:47 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/amd/display: overlay plane loss in
  panel_power_savings_apply() with VRR
--

commit f07b9f0f5284e550d50d58da3cfcd7dcb7eae3b4
Author: Hugo Sales <hugo@hsal.es>

drm/amd/display: Commit panel_power_savings writes from the kernel

This commit updates panel_power_savings_store() to apply ABM level changes
through a non-modeset atomic commit instead of sending a hotplug uevent.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 27546febf90d3..8487ac0661396 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c

[ ... ]

> @@ -712,13 +727,100 @@ ssize_t panel_power_savings_show(struct device *de=
vice,
>  }
>  EXPORT_IF_KUNIT(panel_power_savings_show);
> =20
> +static int panel_power_savings_apply(struct drm_connector *connector,
> +				     unsigned int level)
> +{
> +	struct drm_connector_state *conn_state;
> +	struct dm_connector_state *dm_state;
> +	struct drm_device *dev =3D connector->dev;
> +	struct drm_modeset_acquire_ctx ctx;
> +	struct drm_atomic_commit *state;
> +	bool forbidden, unchanged;
> +	int ret, idx;

[ ... ]

> +retry:
> +	conn_state =3D drm_atomic_get_connector_state(state, connector);
> +	if (IS_ERR(conn_state)) {
> +		ret =3D PTR_ERR(conn_state);
> +		goto out;
> +	}
> +
> +	dm_state =3D to_dm_connector_state(conn_state);
> +	if (dm_state->abm_sysfs_forbidden) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> +
> +	if (dm_state->abm_level =3D=3D level) {
> +		ret =3D 0;
> +		goto out;
> +	}
> +
> +	dm_state->abm_level =3D level;
> +
> +	ret =3D drm_atomic_commit(state);

[Severity: High]
Can this commit drop active overlay planes from DC when VRR is enabled on
the CRTC?

panel_power_savings_apply() builds a non-modeset commit containing only
the connector and its CRTC, with no planes.  In amdgpu_dm_atomic_check(),
the loop that pulls in all primary and overlay planes on a CRTC runs
before drm_atomic_helper_check_planes(), while state still has no planes,
so it skips the CRTC.  Later, drm_atomic_helper_check_planes() calls
amdgpu_dm_crtc_helper_atomic_check():

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

That adds only crtc->primary to state after the plane-gathering loop has
already run.  In amdgpu_dm_commit_planes(), planes_count is then 1, and
update_planes_and_stream_state() sees stream_status->plane_count !=3D
surface_count, elevates the update to UPDATE_TYPE_FULL, and calls
dc_state_rem_all_planes_for_stream() followed by
dc_state_add_all_planes_for_stream() with only the primary plane,
detaching any enabled overlay plane in DC while DRM state still tracks it
as active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-abm-sysfs-=
commit-v2-0-5808d17a7e89@hsal.es?part=3D4
