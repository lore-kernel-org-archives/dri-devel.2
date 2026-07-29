Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F44C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA26510EB9C;
	Wed, 29 Jul 2026 11:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C4n+n9b9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8021F10EB9C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:29:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A059406BE;
 Wed, 29 Jul 2026 11:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F091F000E9;
 Wed, 29 Jul 2026 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785324596;
 bh=19krETzUfeOkUDseDraJl67KRPz8BucNMBYqYquuR0g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C4n+n9b9/MUhr8IfaEUZLDGCmsS7xfj7b/sqqshjJVBq4v+bCrX86Hh2VcZBBYlXO
 fwFoN8ME6Xw+pVtScsAh77LWNZnh1BlErsLuChVaeBGY+FKj8Z77fQxDNHGCN1Ct3g
 OI/TOpmLXtyXojqXpm3Mz1ob3GAKx0lO4B8UcpAhQanCdasuHsLbwaOgEKV3/od36z
 c8OKascUrPk8AKqlm/k1c+tooWsw3Pbo9umXDf29CbGrRV3HeF0+3wyhD1iuU03u2f
 rAgylMTvVXIZTy4NnuLs7hSGQR+O9h2XfW7PY948HGuAw/9eugiWRN5V6YsGRFi6Q7
 Mvw0SDiij09Ww==
From: sashiko-bot@kernel.org
Subject: Re: Patch "drm/amd/display: Handle struct
 drm_plane_state.ignore_damage_clips" has been added to the 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2026072919-worshiper-candied-889c@gregkh>
References: <2026072919-worshiper-candied-889c@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 11:29:55 +0000
Message-Id: <20260729112956.21F091F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Setting `ignore_damage_clips` silently drops damage updates inst=
ead of forcing a full update when MPO is requested.
--

--- Patch [1]: Patch "drm/amd/display: Handle struct drm_plane_state.ignore=
_damage_clips" has been added to the 6.12-stable tree ---
commit f3d595b0a2d71acfd337d504cdb933e78875455e
Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>

drm/amd/display: Handle struct drm_plane_state.ignore_damage_clips

The mode-setting pipeline can disable damage clippings for a commit by
setting ignore_damage_clips in struct drm_plane_state. This commit
updates the DCN code to do a full update if this flag is set.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8d97f17ffe662..2f00287d2c2ae 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -5718,8 +5718,10 @@ static void fill_dc_dirty_rects(struct drm_plane *=
plane,
>  	if (new_plane_state->rotation !=3D DRM_MODE_ROTATE_0)
>  		goto ffu;
> =20
> -	num_clips =3D drm_plane_get_damage_clips_count(new_plane_state);
> -	clips =3D drm_plane_get_damage_clips(new_plane_state);
> +	if (!new_plane_state->ignore_damage_clips) {
> +		num_clips =3D drm_plane_get_damage_clips_count(new_plane_state);
> +		clips =3D drm_plane_get_damage_clips(new_plane_state);
> +	}

[Severity: Medium]
When ignore_damage_clips is true, num_clips remains 0. Does this silently
drop damage updates instead of forcing a full update when MPO is requested?

Further down in fill_dc_dirty_rects(), if dm_crtc_state->mpo_requested is
true and both the framebuffer ID and bounding box are unchanged (e.g.,
frontbuffer rendering or property-only updates):

	if (num_clips) {
		for (; i < num_clips; clips++)
			fill_dc_dirty_rect(new_plane_state->plane,
					   &dirty_rects[i], clips->x1,
					   clips->y1, clips->x2 - clips->x1,
					   clips->y2 - clips->y1, &i, false);
	} else if (fb_changed && !bb_changed) {
		fill_dc_dirty_rect(new_plane_state->plane, &dirty_rects[i],
				   new_plane_state->crtc_x,
				   new_plane_state->crtc_y,
				   new_plane_state->crtc_w,
				   new_plane_state->crtc_h, &i, false);
	}

	flip_addrs->dirty_rect_count =3D i;
	return;

If fb_changed and bb_changed are false, i remains 0. With num_clips also 0,
flip_addrs->dirty_rect_count becomes 0. The update appears to be dropped
entirely rather than falling back to a full update via the ffu path.

> =20
>  	if (num_clips && (!amdgpu_damage_clips || (amdgpu_damage_clips < 0 &&
>  						   is_psr_su)))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026072919-worshipe=
r-candied-889c@gregkh?part=3D1
