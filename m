Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC736C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6026210E613;
	Fri,  3 Jul 2026 15:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HbQiz7o1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8240710E613
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:28:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD6986014B;
 Fri,  3 Jul 2026 15:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08271F000E9;
 Fri,  3 Jul 2026 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783092491;
 bh=wzWXTTuZKno9zek/igdpEnQkhCmg7vzNnIokjWDygAM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HbQiz7o1n5EoHAh1aX8T+NjaAJzLOj2eJVaIAN7hpFaRefBYs4CCTkdFn9djYdTl8
 WJzyZ2fqOqYAVi7MuE/Lz96r9Wyj77h6nHFUwYEmULtGbSDAFfm/z3fQgdbtEJk7RW
 YmwHl72dHpR1Io+R9EKK/0ELr66P6xewqcA5DUBCXlb4+FJvFuf02waKWm5M0EcUoc
 87ANzsKzX/M/BvZqN7WLdmOYDlCRHZ/1VU18HP+cZ7jQZdLIJw/dWf+H3IR01dPwGw
 0vnnZA45fIC72TQOpg1tfX1lj31fUA4Q3RDsFbNPo+M++o/b+aJHJdmSs0WASujxMi
 RJBrQXYQQRsFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/vboxvideo: Use damage iterator and plane damage
 clips
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703151841.375364-1-tzimmermann@suse.de>
References: <20260703151841.375364-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 15:28:09 +0000
Message-Id: <20260703152810.B08271F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the plane atomic=
 update callback `vbox_primary_atomic_update` calls `mutex_lock(&vbox->hw_m=
utex)`, which is a sleeping function. Calling a sleeping function in an ato=
mic context violates DRM/KMS design rules.
--

commit 5090cc8b95319e5f88f32549af73d197156ce225
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/vboxvideo: Use damage iterator and plane damage clips

This commit modifies the vboxvideo driver to use the damage iterator
for plane updates. It also enables damage clips for the plane to minimize
the display update area.

> diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vbox=
video/vbox_mode.c
> index 8e4e5fc9d3c5a..cd78071b6cbbf 100644
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
This isn't a bug introduced by this patch, but vbox_primary_atomic_update()
calls mutex_lock(&vbox->hw_mutex).

Can calling this sleeping function in an atomic context cause kernel warnin=
gs
or deadlocks during non-blocking commits? The same mutex is also acquired
earlier in this callback by vbox_crtc_set_base_and_mode().

> =20
> -	for (i =3D 0; i < num_clips; ++i, ++clips) {
> +	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, new_state);
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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703151841.3753=
64-1-tzimmermann@suse.de?part=3D1
