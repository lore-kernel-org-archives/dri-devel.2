Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8213C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D663810E1B8;
	Wed, 19 Aug 2026 06:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UxNDsXWG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE6610E1B8
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 06:00:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D46B360204;
 Wed, 19 Aug 2026 06:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C84E1F000E9;
 Wed, 19 Aug 2026 06:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787119210;
 bh=7+kzv7jTPjHyrLx/jjZtJDjNOiyGkpM1+1eFZp2HfqI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UxNDsXWGQqV2/fVRafzKwbFIGaNs2BtxUFyXV0V5u4a4Ph1avCBYPfb8iIjCzdRsw
 bR32TFZBWHi81x+ltOP4IsKI4jiSkhHoXb+oomQ8RGfpygTGleW11a2X93Unu49j8N
 6JLortGenuHUnBLnyvNSnQYUOFilcX69MOI2drV2J4VyYb7SO52u/36q6YSors5ka/
 XjdwWJ4C2jXg5fiQ1WzlDQ8eAZP4vY9hQlloPjhGiREjg6gFSidwtqoNir6/WPoOxG
 GjLWS0iQ5z86VKrnR+FxkdYPHb/4SW66AVlsO9ro348JPeUv3Q4KKGr6e9Y/OvnghR
 9ekVL2/I2/4eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: fix dc_lock leak on GPU reset error paths
To: "Linkai Gong" <gonglinkai@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819054742.3143856-1-gonglinkai@kylinos.cn>
References: <20260819054742.3143856-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:00:10 +0000
Message-Id: <20260819060010.6C84E1F000E9@smtp.kernel.org>
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
- [High] Missing error handling for `dc_state_create_copy()` allocation fai=
lure leads to a NULL pointer dereference in `dm_resume()`.
--

--- Patch [1]: [PATCH] drm/amd/display: fix dc_lock leak on GPU reset error=
 paths ---
commit 052121f5a12c1a8a145a6c7fd55be37159a21de9
Author: Linkai Gong <gonglinkai@kylinos.cn>

drm/amd/display: fix dc_lock leak on GPU reset error paths

On GPU reset, dm_suspend() takes dc_lock and leaves it for dm_resume()
to drop. This commit releases the cached DC state and unlocks the lock
before returning an error if amdgpu_dm_commit_zero_streams() or
dm_dmub_hw_init() fails.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 567bf04979ee5..2fe934036e363 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1589,6 +1589,9 @@ static int dm_suspend(struct amdgpu_ip_block *ip_bl=
ock)
>  		dm->cached_dc_state =3D dc_state_create_copy(dm->dc->current_state);
> =20
>  		if (dm->cached_dc_state)
>  			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
> =20
>  		res =3D amdgpu_dm_commit_zero_streams(dm->dc);
>  		if (res !=3D DC_OK) {
>  			drm_err(adev_to_drm(adev), "Failed to commit zero streams: %d\n", res=
);
> +			dc_state_release(dm->cached_dc_state);
> +			dm->cached_dc_state =3D NULL;
> +			mutex_unlock(&dm->dc_lock);
>  			return -EINVAL;
>  		}

[Severity: High]
This is a pre-existing issue, but I wanted to ask about the error handling
when dc_state_create_copy() fails here in dm_suspend().

If memory allocation fails, dm->cached_dc_state becomes NULL. The code
correctly skips dm_gpureset_toggle_interrupts() but continues execution
and ultimately returns success (0) without aborting the suspend operation.

Since dm_suspend() returns success, dm_resume() will be called later on
the same GPU reset path.

[ ... ]

> @@ -1884,6 +1887,9 @@ static int dm_resume(struct amdgpu_ip_block *ip_blo=
ck)
>  	if (amdgpu_in_reset(adev)) {
>  		dc_state =3D dm->cached_dc_state;
[ ... ]
>  		link_enc_cfg_copy(adev->dm.dc->current_state, dc_state);
> =20
>  		r =3D dm_dmub_hw_init(adev);
>  		if (r) {
>  			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: stat=
us=3D%d\n", r);
> +			dc_state_release(dm->cached_dc_state);
> +			dm->cached_dc_state =3D NULL;
> +			mutex_unlock(&dm->dc_lock);
>  			return r;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but does this lead to a NULL
pointer dereference when calling link_enc_cfg_copy()?

In dm_resume(), dc_state is initialized to dm->cached_dc_state, which would
be NULL if the earlier allocation failed. It is then unconditionally passed
to link_enc_cfg_copy(), which appears to dereference it without checking.

Should dm_suspend() return an error when dc_state_create_copy() fails,
preventing the system from continuing the GPU reset process with a missing
DC state and crashing here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819054742.3143=
856-1-gonglinkai@kylinos.cn?part=3D1
