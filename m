Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A825C624DE
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 21:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8043510F78C;
	Thu,  3 Sep 2026 21:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R0QiP5P2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04BE410F78C
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 21:27:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89EF94345D;
 Thu,  3 Sep 2026 21:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEBF1F000E9;
 Thu,  3 Sep 2026 21:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788470832;
 bh=bYnzOG/g12BIF5+Y/o1132fplEkVrRmDzBXyb+kAoSA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R0QiP5P2/u55rTy1oe7Ievzx93kmBn1kP3d097Ivwp8R7/SHt4pEeUAJamwRivbzx
 10IgM3JN7hfqb1ZxntxoheldbkYnQbXLuGiVl+ogJJeXwyHKLqhg5MWNvr3WN9eZ1v
 npFlfiS1pgIWXVkBsrQuJ3KE4nFjLT8aqM9wYlLaGC2QkTnwMG598ncIQskLetFE06
 y1J4RQoSTNJJrYXKqIQ9P5q+43v3mhervb3BSyBrIVuyfuTpmx6tsDkLgmSfaqNTjB
 Yu3H7/Ruxvb9G6p2JpX4mb7DnFpYkoLu8MWVBXSLyisEzp4TmSqUTON4ikbN+gdkap
 6tyAaeTYVQMMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/virtio: Recalculate ignore_damage_clips on
 every update
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903211914.1109100-3-lyude@redhat.com>
References: <20260903211914.1109100-1-lyude@redhat.com>
 <20260903211914.1109100-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 21:27:11 +0000
Message-Id: <20260903212712.4BEBF1F000E9@smtp.kernel.org>
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
- [High] Preexisting bug in vmwgfx: Plane state duplication permanently pre=
serves ignore_damage_clips, disabling partial updates.
--

commit 18671312bd2be6fe18c7092369d0bbfb67a39103
Author: Christian Hergert <christian@sourceandstack.com>

drm/virtio: Recalculate ignore_damage_clips on every update

Plane state duplication preserves ignore_damage_clips. Once fbdev sets
it for a dumb buffer, later updates using rendered resources continue to
ignore damage because the flag is never cleared.

Assign ignore_damage_clips on every atomic check so rendered resources
can use supplied damage after an earlier dumb-buffer update.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/vir=
tio/virtgpu_plane.c
> index d9579a4b4714c..95ec688690d3a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -119,8 +119,8 @@ static int virtio_gpu_plane_atomic_check(struct drm_p=
lane *plane,
>  	 * so preserve userspace's accumulated per-buffer damage for those.
>  	 */
>  	bo =3D gem_to_virtio_gpu_obj(new_plane_state->fb->obj[0]);
> -	if (old_plane_state->fb !=3D new_plane_state->fb && bo->dumb)
> -		new_plane_state->ignore_damage_clips =3D true;
> +	new_plane_state->ignore_damage_clips =3D
> +		old_plane_state->fb !=3D new_plane_state->fb && bo->dumb;

[Severity: High]
This is a pre-existing issue, but does the same problem exist in vmwgfx?

Looking at vmw_du_primary_plane_atomic_check() in
drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:

	if (old_fb !=3D new_fb)
		new_state->ignore_damage_clips =3D true;

When old_fb =3D=3D new_fb, it fails to clear the flag.

Once the flag is set to true during a page flip, won't it remain permanently
true across future state duplications?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903211914.1109=
100-1-lyude@redhat.com?part=3D2
