Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA410CA600A
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DDA210FCE3;
	Thu,  8 Oct 2026 07:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LrdRbu1K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309AE10FCE3
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 07:43:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBB5B43FE7;
 Thu,  8 Oct 2026 07:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEAA1F000FF;
 Thu,  8 Oct 2026 07:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791445394;
 bh=tRhbGSvqhYdLdCYhV+8YNyzWUfJxo4KUQXL2e22w8ZY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LrdRbu1KBFiM4jkFEpsUKLQTSuLkfgrBASlo2glzSeP7hHBIXJPAacsj3YCgDJ1sL
 a5nYNLiiTQBLafhBWD1TtpghAoFy6GADFpqt33HfOAHHr6zde2m7THL4LUlkUGUW86
 oVhw8zz9jroGDWkwoh23r3L1TBZ3rIu7gXpU9Hc7frwT6OL0MLQuHPLyTceiT+tE85
 OjkpkvxPVN2dDlkiLdnxNBmPJl2mP0rx+JSkZdSQEqEE1lMlyhnnYOoRDWOB21LheY
 L27inE0Gi6FpHKs8tUG/6fiSBKfN/cv+DFpCfzjiqtJ4itOjRWku/MkHgWgSQRyjXL
 DdPAMzdM/AUOw==
Message-ID: <sashiko-outbox-163778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Snapshot dm_crtc_state->stream before use
To: 2564278112@qq.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <tencent_3F4F1469A115C5112FD7CA3CC4A9CF6F6C07@qq.com>
References: <tencent_3F4F1469A115C5112FD7CA3CC4A9CF6F6C07@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 07:43:14 +0000
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
- [High] drm/amd: Missing NULL check on snapshotted stream in amdgpu_dm_com=
mit_planes
- [High] drm/amd: TOCTOU race on stream pointers in amdgpu_dm_atomic_commit=
_tail
--

commit b5d41316e3dbf4b387efaeed72f5a145535e3564
Author: Wang Jiang <jiangwang@kylinos.cn>
Subject: drm/amd/display: Snapshot dm_crtc_state->stream before use

This commit introduces local snapshots for the display manager's stream=20
pointers to prevent NULL pointer dereferences caused by concurrent clearanc=
es=20
during system suspend and resume. However, there are a few places where the=
=20
snapshots are bypassed or remain unvalidated before use.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1b42c4606002e..b31ac9434da1d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -3926,12 +3946,12 @@ static void amdgpu_dm_commit_planes(struct drm_at=
omic_commit *state,
>  		bundle->surface_updates[planes_count].plane_info =3D
>  			&bundle->plane_infos[planes_count];
> =20
> -		if (acrtc_state->stream->link->psr_settings.psr_feature_enabled ||
> -		    acrtc_state->stream->link->replay_settings.replay_feature_enabled)=
 {
> +		if (stream->link->psr_settings.psr_feature_enabled ||
> +		    stream->link->replay_settings.replay_feature_enabled) {

[Severity: High]
Does amdgpu_dm_commit_planes() need to verify if the captured snapshot is=20
valid before proceeding?

If the stream was concurrently cleared and the snapshot is NULL, evaluating=
=20
this condition will result in a kernel panic since the stream pointer is=20
dereferenced unconditionally here.

>  			fill_dc_dirty_rects(plane, old_plane_state,
>  					    new_plane_state, new_crtc_state,
>  					    &bundle->flip_addrs[planes_count],
> -					    acrtc_state->stream->link->psr_settings.psr_version =3D=3D
> +					    stream->link->psr_settings.psr_version =3D=3D
>  					    DC_PSR_VERSION_SU_1,
>  					    &dirty_rects_changed);
[ ... ]
> @@ -4113,7 +4133,7 @@ static void amdgpu_dm_commit_planes(struct drm_atom=
ic_commit *state,
>  		if (amdgpu_dm_is_dc_timing_adjust_needed(dm_old_crtc_state, acrtc_stat=
e)) {

[Severity: High]
Does passing the acrtc_state object here bypass the snapshot entirely?

The helper function amdgpu_dm_is_dc_timing_adjust_needed() directly reads
the stream from the state object:

amdgpu_dm_freesync.c:amdgpu_dm_is_dc_timing_adjust_needed() {
    if (new_state->stream->adjust.timing_adjust_pending)
        return true;
    ...

If the stream was concurrently cleared, this directly dereferences the NULL
pointer from the state object, causing a crash.

>  			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>  			dc_stream_adjust_vmin_vmax(
> -				dm->dc, acrtc_state->stream,
> +				dm->dc, stream,
>  				&acrtc_attach->dm_irq_params.vrr_params.adjust);
>  			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>  		}
[ ... ]
> @@ -5072,6 +5093,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm=
_atomic_commit *state)
>  							     dm_old_con_state);
> =20
>  		if ((new_con_state->hdmi.broadcast_rgb !=3D old_con_state->hdmi.broadc=
ast_rgb) &&
> +			dm_old_crtc_state->stream && dm_new_crtc_state->stream &&
>  			(dm_old_crtc_state->stream->output_color_space !=3D
>  				amdgpu_dm_get_output_color_space(&dm_new_crtc_state->stream->timing,=
 new_con_state)))
>  			output_color_space_changed =3D true;

[Severity: High]
Does checking the stream pointer here and immediately rereading it from the
state structure create a time-of-check to time-of-use race in=20
amdgpu_dm_atomic_commit_tail()?

If dm_new_crtc_state->stream is concurrently set to NULL immediately after
evaluating to true in the check, taking the address of its timing field:
&dm_new_crtc_state->stream->timing
will compute an invalid offset pointer (NULL + offset).

This invalid pointer is then passed into amdgpu_dm_get_output_color_space(),
which attempts to access its fields:

amdgpu_dm_connector.c:amdgpu_dm_get_output_color_space() {
    ...
    case DRM_MODE_COLORIMETRY_BT601_YCC:
        if (dc_crtc_timing->flags.Y_ONLY)
    ...

Dereferencing this invalid offset pointer will cause a page fault. To close
this window, the state pointers should likely be captured into local=20
snapshots before being evaluated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_3F4F1469A11=
5C5112FD7CA3CC4A9CF6F6C07@qq.com?part=3D1
