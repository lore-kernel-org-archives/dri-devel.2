Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A458C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D0F10E521;
	Fri,  3 Jul 2026 14:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L5SoG2Q4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE2810E521
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 14:59:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60C85600C8;
 Fri,  3 Jul 2026 14:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46881F00A3A;
 Fri,  3 Jul 2026 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783090794;
 bh=09IjCEDpVTXtJmV+7CQDSBZp19Z4Uu7tWxBs4JUd4e8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L5SoG2Q4yWsYkJGqVfVFEfvniMIgOKhWZzKR/gBqmFyQod/DdramyB0GGvzxaSYkV
 KLZqZ7EUvBcOwMBaQIjhiiB2BF/PCcHQ2iBYAjRIDMoNEOhw0HKevKVdEnWeGTvHK2
 S5BNckWR11LayFQqtFTxJKB5NeFnQ2V5H3/z9zlQoy3gnj7qyfgp/sta5zjgQHBwhu
 0q96W64QwPaWBxZiIaWycTpZygMXEd8VN8MjdzmASZt8JZOo5x9E+dQ/jQkaxD/HHt
 6oafpwmsevCBojQwAtZF8rFYtFHcLL4MOhV16rHCuF0XY6OVOUQtGj2uKSNqEpdEZX
 BS4yYRAXw3sOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vboxvideo: Use damage iterator and plane damage clips
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703145229.369404-1-tzimmermann@suse.de>
References: <20260703145229.369404-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:59:53 +0000
Message-Id: <20260703145953.C46881F00A3A@smtp.kernel.org>
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

New issues:
- [High] The `drm_atomic_helper_damage_iter_init()` function is called with=
 its `old_state` and `new_state` arguments swapped.

Pre-existing issues:
- [High] Acquiring a blocking mutex (`vbox->hw_mutex`) inside a plane atomi=
c update callback violates atomic context rules.
--

commit d10e9cef3fd78d35bcfae0e63eb85f53c33aa092
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/vboxvideo: Use damage iterator and plane damage clips

This commit updates the vboxvideo driver to use the damage iterator for
handling updates without damage clips correctly, ensuring the entire display
area is updated when no clips are given. It also enables plane damage clips
to minimize the area of each display update.

> diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vbox=
video/vbox_mode.c
> index 8e4e5fc9d3c5a..237115c2e1f19 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
[ ... ]
> @@ -282,9 +283,10 @@ static void vbox_primary_atomic_update(struct drm_pl=
ane *plane,
>  									   plane);
>  	struct drm_crtc *crtc =3D new_state->crtc;
>  	struct drm_framebuffer *fb =3D new_state->fb;
> +	struct drm_plane_state *old_plane_state =3D drm_atomic_get_old_plane_st=
ate(state, plane);
>  	struct vbox_private *vbox =3D to_vbox_dev(fb->dev);
> -	struct drm_mode_rect *clips;
> -	uint32_t num_clips, i;
> +	struct drm_rect damage;
> +	struct drm_atomic_helper_damage_iter iter;
> =20
>  	vbox_crtc_set_base_and_mode(crtc, fb,
>  				    new_state->src_x >> 16,
> @@ -292,22 +294,17 @@ static void vbox_primary_atomic_update(struct drm_p=
lane *plane,
> =20
>  	/* Send information about dirty rectangles to VBVA. */
> =20
> -	clips =3D drm_plane_get_damage_clips(new_state);
> -	num_clips =3D drm_plane_get_damage_clips_count(new_state);
> -
> -	if (!num_clips)
> -		return;
> -
>  	mutex_lock(&vbox->hw_mutex);

[Severity: High]
This is a pre-existing issue, but does this mutex_lock() violate atomic
context rules?

The DRM subsystem guidelines specify that plane atomic update callbacks=20
execute in atomic context during non-blocking commits, where sleeping
functions like mutex_lock() are forbidden. Calling this here, and in
vbox_crtc_set_base_and_mode() which is called just above, could lead to
"scheduling while atomic" warnings or deadlocks.

> =20
> -	for (i =3D 0; i < num_clips; ++i, ++clips) {
> +	drm_atomic_helper_damage_iter_init(&iter, new_state, old_plane_state);

[Severity: High]
Are the old and new state arguments swapped here?

Looking at the signature for drm_atomic_helper_damage_iter_init(), it
expects the old state as the second argument and the new state as the third
argument.

Passing old_plane_state as the third argument means the iterator evaluates
old_plane_state->visible to determine if it should yield updates. If the
plane is transitioning from disabled to enabled, this evaluates to false,
causing the iterator to skip all updates and leaving the screen blank. It
will also read damage clips and source dimensions from the old state instead
of the new state.

> +	drm_atomic_for_each_plane_damage(&iter, &damage) {
>  		struct vbva_cmd_hdr cmd_hdr;
>  		unsigned int crtc_id =3D to_vbox_crtc(crtc)->crtc_id;
> =20
> -		cmd_hdr.x =3D (s16)clips->x1;
> -		cmd_hdr.y =3D (s16)clips->y1;
> -		cmd_hdr.w =3D (u16)clips->x2 - clips->x1;
> -		cmd_hdr.h =3D (u16)clips->y2 - clips->y1;
> +		cmd_hdr.x =3D (s16)damage.x1;
> +		cmd_hdr.y =3D (s16)damage.y1;
> +		cmd_hdr.w =3D (u16)drm_rect_width(&damage);
> +		cmd_hdr.h =3D (u16)drm_rect_height(&damage);
> =20
>  		if (!vbva_buffer_begin_update(&vbox->vbva_info[crtc_id],
>  					      vbox->guest_pool))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703145229.3694=
04-1-tzimmermann@suse.de?part=3D1
