Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4554C79FB6
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABF310E22B;
	Thu, 10 Sep 2026 01:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AW/mIdkz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6025810E22B
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 01:58:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 354A7601F0;
 Thu, 10 Sep 2026 01:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75141F000FF;
 Thu, 10 Sep 2026 01:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789005510;
 bh=TShg/hZrbc+R+/YMehvoFkrUYLxHiIUOv5PkCyVsFno=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AW/mIdkzXHUIrpiJLXmw9BgWzdKGuS0qiIHuednn2nPJEp6ntn9J6KBIqCTu2/vof
 IoUZoJoOOw+OPZZyFeX9xkNbmYqPAz9j8WVG0474x2r+xAAtqPBjGdbyPEnfTQxBay
 UiQOLNCcXxx3rq+Cj7XlXIqXi5B6woQDy8jQlAY7/M3uLKe3C+F60p20BjZDfAy9+h
 ZV1oKPyLLwoP9rlq47rgFAZmoAJGgySKn1Dz2oEJm5xE7bRK9lB6zq+h9Rx5oy/Y0+
 ZXwWiFKEvN5IYZNWGzt8dgra/P7o5wjtaBu6t3YsY/GgcVHdxbPHSeiPUJsBqUpbTo
 Uy/eYq8lBY6FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/gud: Ignore damage clips in full update mode
To: "Sophie D" <patches@scd31.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910014910.8564-1-patches@scd31.com>
References: <20260907230849.31032-1-patches@scd31.com>
 <20260910014910.8564-1-patches@scd31.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 01:58:30 +0000
Message-Id: <20260910015830.B75141F000FF@smtp.kernel.org>
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
- [High] The iterator variable `connector_state` leaks out of `for_each_new=
_connector_in_state`, bypassing the fallback search.
--

commit 4deed33a0bafa9e2ff82e53d1da0f3130451d673
Author: Sophie D <patches@scd31.com>

drm/gud: Ignore damage clips in full update mode

When running in full update mode, previously small updates (such as
moving the mouse across the screen) would cause many full frames to be
generated. This would bog down the bus and lower the effective framerate
significantly - I was seeing a drop from 60 FPS to 2 FPS.

> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pip=
e.c
> index 5ef887d8485a3..3388fdc8ea7b5 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -482,6 +482,9 @@ int gud_plane_atomic_check(struct drm_plane *plane,
>  	if (!new_plane_state->visible)
>  		return 0;
> =20
> +	if (gdrm->flags & GUD_DISPLAY_FLAG_FULL_UPDATE)
> +		new_plane_state->ignore_damage_clips =3D true;
> +
>  	if (old_plane_state->rotation !=3D new_plane_state->rotation)
>  		crtc_state->mode_changed =3D true;
> =20

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing
gud_plane_atomic_check(), I noticed an issue with the fallback search for
the connector.

Does connector_state bypass the fallback search here?

	for_each_new_connector_in_state(state, connector, connector_state, i) {
		if (connector_state->crtc)
			break;
	}

	/*
	 * DRM_IOCTL_MODE_OBJ_SETPROPERTY on the rotation property will not have
	 * the connector included in the state.
	 */
	if (!connector_state) {
		struct drm_connector_list_iter conn_iter;

If the loop finishes without finding a matching CRTC, connector_state retai=
ns
the pointer to the last evaluated connector rather than evaluating to NULL.
This happens because short-circuit evaluation prevents the macro's assignme=
nt
block from running on the final iteration.

Could this cause the driver to extract properties and the connector index f=
rom
an unrelated or disconnected connector and send them to the hardware device
during the atomic check phase, leading to hardware misconfiguration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910014910.8564=
-1-patches@scd31.com?part=3D1
