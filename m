Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDC3C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 295E210EB97;
	Wed, 29 Jul 2026 11:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ELdn2V0I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D52210EB97
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:29:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A943143CB0;
 Wed, 29 Jul 2026 11:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618B61F000E9;
 Wed, 29 Jul 2026 11:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785324580;
 bh=EiUKvhoYlClq7lbdmkrgcZcEt3xFD1qKgsr4T9wMlNg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ELdn2V0ITmoW+1/wISPeI/b0GTxLlmKPsHSQn5DW6jxHr2TLkwMwMRpfFbrbuRgxZ
 6oGHVCdzUgReL5xXJNbV9TZNoF0vJiVv1yB51UTdWV9+Ln+1qQ1nErrkmkpw31J0t1
 a6sEldgtFvkRX59KBa2AYbxd93Yy27w9tKNSnutlQGnFc+JQS92iRzKjuSqTxzgl0o
 bAhb3/2+xx9S8WEoFoMtdC98BaD35StArvLpD2zP7SBbsWFXMdbIt0DAvdrGKLZV2N
 vCgd10AJT3nPUT4+c+M7M/DRLPJ8AI8/UHW0EugjlAo6NnmCZoc+jtKJvhoQ07Qmo0
 rQLkCsdaqH3DA==
From: sashiko-bot@kernel.org
Subject: Re: Patch "drm/amd/display: Handle struct
 drm_plane_state.ignore_damage_clips" has been added to the 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2026072928-caring-papaya-ed97@gregkh>
References: <2026072928-caring-papaya-ed97@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 11:29:39 +0000
Message-Id: <20260729112940.618B61F000E9@smtp.kernel.org>
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
- [High] In the MPO (Multi-Plane Overlay) path, setting `ignore_damage_clip=
s` fails to trigger a full update if the framebuffer and bounding box haven=
't changed, resulting in a dropped display update.
--

--- Patch [1]: Patch "drm/amd/display: Handle struct drm_plane_state.ignore=
_damage_clips" has been added to the 6.18-stable tree ---
commit e9e0d8ca6e7cebee70fe44f3b50f1d51b508e3bf
Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
Subject: drm/amd/display: Handle struct drm_plane_state.ignore_damage_clips

This commit updates the DCN driver code to support the ignore_damage_clips
flag from drm_plane_state. By bypassing damage clip retrieval when this flag
is set, the driver is intended to perform a full display update instead of a
partial one.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7fe40bbba2658..97e14e02bf8c0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

[ ... ]

> @@ -6229,8 +6229,10 @@ static void fill_dc_dirty_rects(struct drm_plane *=
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
> =20

[Severity: High]
When ignore_damage_clips is true, num_clips remains 0. Does this cause an
issue for the MPO (Multi-Plane Overlay) path further down in this function?

Looking at the MPO path later in fill_dc_dirty_rects():

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:fill_dc_dirty_rects() {
    ...
    fb_changed =3D old_plane_state->fb->base.id !=3D
                 new_plane_state->fb->base.id;
    bb_changed =3D (old_plane_state->crtc_x !=3D new_plane_state->crtc_x ||
                  old_plane_state->crtc_y !=3D new_plane_state->crtc_y ||
                  ...);
    ...
    if (num_clips) {
        for (; i < num_clips; clips++)
            ...
    } else if (fb_changed && !bb_changed) {
        fill_dc_dirty_rect(new_plane_state->plane, &dirty_rects[i],
            ...
    }

    flip_addrs->dirty_rect_count =3D i;
    return;
}

If dm_crtc_state->mpo_requested is true, and both fb_changed and bb_changed
are false, the code bypasses the goto ffu (Full Frame Update) logic used by
the non-MPO path.

Since num_clips is 0, the MPO logic will not add any dirty rects, resulting=
 in
flip_addrs->dirty_rect_count being 0.=20

Instead of forcing a full display update when ignore_damage_clips is set,=20
could this silently drop the display update entirely?

>  	if (num_clips && (!amdgpu_damage_clips || (amdgpu_damage_clips < 0 &&
>  						   is_psr_su)))
>  		goto ffu;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026072928-caring-p=
apaya-ed97@gregkh?part=3D1
