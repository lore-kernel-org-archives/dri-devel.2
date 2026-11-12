Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AAA606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xrwr6XVN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8840410E4E8;
	Thu, 12 Nov 2026 01:51:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5F310E4E8;
 Thu, 12 Nov 2026 01:50:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DF99542E90;
 Thu, 12 Nov 2026 01:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0F01F00A06;
 Thu, 12 Nov 2026 01:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794448258;
 bh=TT8Le7wY1HqMjC4eg7/4lsHCTUN7+7/R/A+Eh1e3YDk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xrwr6XVN+/BhBJVRBeWPI6nnNJO+fmw+++0douVxSTXVLkkJzUg4ydJA4UKnQndg6
 XUifhERPOwknzD9USEOzaesByIkSxCJzsXMRvgnoJ642IOtGLPTeQ3Vr8U2gCPFsns
 qZOJ07YQHYA3Eoi03OjVxvA2PntRyZxMgRFhQznMSiKDW+QedoOaXdQUxhOlUGZywO
 eXVltU4mmLkYvU5YqvyMHLPeB91/vHETdvQcy9lZQ8nQqVTIZ+Kuz+zdegjBKQmGe6
 Ke/u7hjZmotl3HyLzLfSvDk2EY3OhVBiZtP6VwXanksGDpKbessNmGslFl5R2x3Sbw
 R1+1J2auCdpMg==
Message-ID: <sashiko-outbox-210103@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/19] drm/amd/display/amdgpu_dm: Use DC accessors in
 audio/color/backlight paths
To: "Dave Airlie" <airlied@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-4-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-4-0fae41718ad2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:50:58 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 2 related pre-existing issues it does not
introduce:
- [Critical] drm/amd/display: race and invalid downcast in
  amdgpu_dm_backlight_set_level() [1]
- [Medium] drm/amd/display: swallowed error in
  amdgpu_dm_update_plane_color_mgmt() [2]
--

commit c710d624f30d7a2d26cb80389657ac035d1c1f5e
Author: Dave Airlie <airlied@redhat.com>

drm/amd/display/amdgpu_dm: Use DC accessors in audio/color/backlight paths

This commit replaces direct struct dc member accesses with DC accessor
calls in the audio, backlight, and color management paths.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index cb74b00723fda..3d268703c5514 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -296,7 +296,7 @@ struct dc_stream_state *dm_find_stream_with_link(
>  	struct amdgpu_display_manager *dm,
>  	struct dc_link *link)
>  {
> -	struct dc_state *cur_dc_state =3D dm->dc->current_state;
> +	struct dc_state *cur_dc_state =3D dc_get_current_state(dm->dc);
>  	struct dc_stream_state *stream =3D NULL;
>  	int i;
> =20
> @@ -383,7 +383,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_disp=
lay_manager *dm,
>  	}
> =20
>  	mutex_lock(&dm->dc_lock);
> -	if (dm->dc->caps.ips_support && dm->dc->ctx->dmub_srv->idle_allowed) {
> +	if (dc_get_caps(dm->dc)->ips_support && dc_get_ctx(dm->dc)->dmub_srv->i=
dle_allowed) {
>  		dc_allow_idle_optimizations(dm->dc, false);
>  		reallow_idle =3D true;
>  	}

[Severity: Critical]
This problem wasn't introduced by this patch, but can
amdgpu_dm_backlight_set_level() race with a concurrent atomic commit and
use cur_dc_state or stream after it has been freed [1]?

amdgpu_dm_backlight_set_level() calls dm_find_stream_with_link() before
acquiring dm->dc_lock:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c:amdgpu_dm_backl=
ight_set_level() {
	...
	list_for_each_entry(connector, &dm->ddev->mode_config.connector_list, head=
) {
		struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(connect=
or);
		...
	}
	...
	link =3D (struct dc_link *)dm->backlight_link[bl_idx];
	stream =3D dm_find_stream_with_link(dm, link);
	if (!stream)
		return;
	...
	mutex_lock(&dm->dc_lock);
}

A concurrent commit can replace current_state and release the old state
and its streams while dm_find_stream_with_link() is walking it or before
dm->dc_lock is taken:

CPU0                                  CPU1
amdgpu_dm_backlight_set_level()
  dm_find_stream_with_link()
    cur_dc_state =3D
      dc_get_current_state(dm->dc)
    stream =3D cur_dc_state->streams[i]
                                      amdgpu_dm_commit_streams()
                                        mutex_lock(&dm->dc_lock)
                                        dc_commit_streams()
                                          /* replaces current_state,
                                             releases old state/streams */
                                        mutex_unlock(&dm->dc_lock)
  mutex_lock(&dm->dc_lock)
  mod_power_set_backlight_nits(...,
    stream, ...)                      <-- use-after-free

In addition, the loop at the start of amdgpu_dm_backlight_set_level()
walks mode_config.connector_list with list_for_each_entry() instead of
drm_connector_list_iter_begin()/end(), which can race with DP MST
connector removal, and unconditionally calls to_amdgpu_dm_connector() on
every entry, which causes type confusion on DRM_MODE_CONNECTOR_WRITEBACK
connectors (allocated as struct amdgpu_dm_wb_connector).

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index f9dc9f46a4460..d86b9611568b8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c

[ ... ]

> @@ -2156,7 +2162,7 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crt=
c_state *crtc,
>  	struct amdgpu_device *adev =3D drm_to_adev(crtc->base.state->dev);
>  	struct dm_plane_state *dm_plane_state =3D to_dm_plane_state(plane_state=
);
>  	struct drm_color_ctm_3x4 *ctm =3D NULL;
> -	struct dc_color_caps *color_caps =3D NULL;
> +	const struct dc_color_caps *color_caps =3D NULL;
>  	bool has_crtc_cm_degamma;
>  	int ret;
> =20
> @@ -2167,7 +2173,7 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crt=
c_state *crtc,
>  	}
> =20
>  	if (dc_plane_state->ctx && dc_plane_state->ctx->dc)
> -		color_caps =3D &dc_plane_state->ctx->dc->caps.color;
> +		color_caps =3D &dc_get_caps(dc_plane_state->ctx->dc)->color;
> =20
>  	/* Initially, we can just bypass the DGM block. */
>  	dc_plane_state->in_transfer_func.type =3D TF_TYPE_BYPASS;

[Severity: Medium]
This problem wasn't introduced by this patch, but does
amdgpu_dm_update_plane_color_mgmt() swallow errors from
amdgpu_dm_plane_set_colorop_properties() [2]?

At the end of amdgpu_dm_update_plane_color_mgmt():

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c:amdgpu_dm_update_pl=
ane_color_mgmt() {
	...
	if (!amdgpu_dm_plane_set_colorop_properties(plane_state, dc_plane_state))
		return 0;

	return amdgpu_dm_plane_set_color_properties(plane_state, dc_plane_state);
}

When plane_state->color_pipeline is set and
amdgpu_dm_plane_set_colorop_properties() fails with a negative error code
(such as -EINVAL or -ENOMEM), the ! check evaluates to false and execution
falls through to amdgpu_dm_plane_set_color_properties(). Because no legacy
color properties are set on a colorop commit, the fallback bypasses the
color blocks and returns 0, causing the atomic commit to succeed with
plane color management silently disabled.

[1] https://sashiko.dev/#/bug/linux-d25140b3-5901-4689-81c3-c3890f66e5a2
[2] https://sashiko.dev/#/bug/linux-2356891c-983c-48f7-a656-56667766fead

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-amdgpu-dc-=
cleanup-v1-0-0fae41718ad2@redhat.com?part=3D4
