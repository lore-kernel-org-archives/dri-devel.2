Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF92C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E020910EECA;
	Tue,  1 Sep 2026 19:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LJURerp/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A4B10EECA
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:29:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E519C60207;
 Tue,  1 Sep 2026 19:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E6C1F000E9;
 Tue,  1 Sep 2026 19:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788290981;
 bh=PZohcBCxe5DooY2goIB49tsDYtl4GLQaIx5i+fD1Pps=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LJURerp/GEsAUV0kL+zOFduUseNDPvaLPilJWD+SFF1wX3BCT7BKdBXTnRC20vRp2
 a3Jk2U+pXegkFX7N/yT4pmVqF27R4eu+l1jJErqDwri9AzOyg2yCJ10S3RFZfe9FlA
 KgxKSEDO6h7If8iluDiCi9/pFTtb5h6JP5lMk6c/eT9ucrY7Eqcrnq2wxRVyj/04fS
 q/f5XXWehkhWq7mxykwnIltuu9ht7jL2lH4sfYhExpvApi1ROBhcK/IdgPOdIIigVe
 WzQis5KZWNhqVyCr6Y887TYNnEh4Sv3kEKRm3RooW8TTpwAOD2YgqQRy18K1y04khW
 kSPfqLbnij0mA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] drm/amd/display: Use passive_vrr properties in
 amdgpu
To: "Fangzhi Zuo" <jerry.zuo@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901191251.2653684-3-jerry.zuo@amd.com>
References: <20260901191251.2653684-1-jerry.zuo@amd.com>
 <20260901191251.2653684-3-jerry.zuo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 19:29:40 +0000
Message-Id: <20260901192941.78E6C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing `passive_vrr_disabled` check in atomic check prevents hard=
ware update.
- [High] In-place mutation of shared `dc_stream_state` during atomic check.
- [Medium] Missing `passive_vrr_capable` property on MST endpoints, but the=
 feature is silently enabled.
--

commit b13d5b0a2a71643131cf661b1a6d126b390f1d96
Author: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>

drm/amd/display: Use passive_vrr properties in amdgpu

This commit wires the passive_vrr DRM properties into amdgpu for HDMI, DP,
and eDP sinks. It attaches the passive_vrr_capable property alongside
vrr_capable for non-MST connectors, records the freesync_on_desktop
capability, and sets the stream freesync_on_desktop state based on the
passive_vrr_disabled property.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 0e71ba498e8aa..8b2eec1a683d4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
[ ... ]
> @@ -3241,8 +3242,10 @@ void amdgpu_dm_connector_init_helper(struct amdgpu=
_display_manager *dm,
>  	    connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
>  		drm_connector_attach_hdr_output_metadata_property(&aconnector->base);
> =20
> -		if (!aconnector->mst_root)
> +		if (!aconnector->mst_root) {
>  			drm_connector_attach_vrr_capable_property(&aconnector->base);
> +			drm_connector_attach_passive_vrr_capable_property(&aconnector->base);
> +		}

[Severity: Medium]
Will this result in passive VRR being silently enabled for MST endpoints
without exposing the capability property to userspace?

The passive_vrr_capable property is explicitly restricted to non-MST
endpoints here. However, the logic in amdgpu_dm_update_freesync_caps() and
amdgpu_dm_get_freesync_config_for_crtc() appears to unconditionally activate
freesync_on_desktop if the display is FreeSync capable.

Because the capability property isn't cloned to dynamic MST endpoints, those
endpoints will have the feature activated by default (since the
passive_vrr_disabled property defaults to false) without userspace being
able to discover the capability.

[ ... ]
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> index 281c6cec9f4bc..903d5ab387d4b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> @@ -138,6 +138,12 @@ void amdgpu_dm_get_freesync_config_for_crtc(
>  		config.vsif_supported =3D true;
>  		config.btr =3D true;
> =20
> +		if (new_con_state->freesync_on_desktop_capable)
> +			new_crtc_state->stream->freesync_on_desktop =3D
> +				!new_crtc_state->base.passive_vrr_disabled;
> +		else
> +			new_crtc_state->stream->freesync_on_desktop =3D false;
> +

[Severity: High]
If userspace only toggles the passive_vrr_disabled property without
triggering a modeset, will the hardware actually get updated?

It appears that amdgpu_dm_atomic_check() in amdgpu_dm.c skips adding
affected planes if only passive_vrr_disabled changes. Its fast-return path
checks for color_mgmt_changed, vrr_enabled, and dsc_force_changed, but
misses a check for passive_vrr_disabled.

If planes aren't added to the atomic state, the subsequent commit will skip
updating the stream and VRR state entirely, leaving hardware and software
out of sync.

[Severity: High]
Does this assignment mutate the active stream state during a TEST_ONLY
atomic commit?

In amdgpu_dm_get_freesync_config_for_crtc(), new_crtc_state->stream points
to a shared, refcounted dc_stream_state object that represents the current
hardware state. It is not deep-copied during state duplication.

If userspace performs a DRM_MODE_ATOMIC_TEST_ONLY commit, writing directly
to stream->freesync_on_desktop permanently alters the running state and
breaks atomic test-only invariants.

>  		if (fs_vid_mode) {
>  			config.state =3D VRR_STATE_ACTIVE_FIXED;
>  			config.fixed_refresh_in_uhz =3D new_crtc_state->freesync_config.fixed=
_refresh_in_uhz;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901191251.2653=
684-1-jerry.zuo@amd.com?part=3D2
