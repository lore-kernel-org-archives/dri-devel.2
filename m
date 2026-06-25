Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972BDCDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D496F10E216;
	Thu, 25 Jun 2026 15:37:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TW/wejn5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E038310E216
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 15:37:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DCDB433D7;
 Thu, 25 Jun 2026 15:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9F31F000E9;
 Thu, 25 Jun 2026 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782401861;
 bh=PJMaTOTEV+3qAiDvmou8y3Qd9f5k/8zmUmGSxE6J34I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TW/wejn5gaFl4QwhRo84CStKHCVWQ/xMwoL9elIFVYdz+MhwrbTpDsMiHbmR8KXXZ
 pQohcmjdCDftVUmNwFMG39Fw/eGg+i6ct3HBkHvyuWcLaWJxwq4iqpNgCq0+jocVYI
 CX7Mym39UHj6DCKQ3WxUXzsKv3aPTahoeItsJZTPYtgJ30hHvwu0AM23Lc/8H1pnqw
 dm4LZwEjH/NQjQg97cLQDPbrlTDHh34ZbFDW6aioUKvH/6Q6hodV0zLRXuBpsAKSqJ
 k1MmrECK+LLMh4H4jOqlpgMWu/GWA9kJ76kUK6gao2ykBWcnbAIVVR2b1FQJRIZect
 rvLeOgcq6zZ7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Fix dangling pointer in plane state
 reset on allocation failure
To: "Evgenii Burenchev" <evg28bur@yandex.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625151717.27757-1-evg28bur@yandex.ru>
References: <20260625151717.27757-1-evg28bur@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 15:37:40 +0000
Message-Id: <20260625153741.4D9F31F000E9@smtp.kernel.org>
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
- [High] Dangling pointers in `amdgpu_dm_crtc_reset_state` and `amdgpu_dm_c=
onnector_funcs_reset` upon memory allocation failure.
--

commit a2f21c8f5312ce74d2f0b34c962db8d83e4d242f
Author: Evgenii Burenchev <evg28bur@yandex.ru>

    drm/amd/display: Fix dangling pointer in plane state reset on allocatio=
n failure

    In amdgpu_dm_plane_drm_plane_reset(), the old plane state is freed
    before allocating a new one. If kzalloc_obj() fails, the function
    returns without updating plane->state, leaving a dangling pointer
    to already freed memory.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index c7f8e08feaf4b..65c0aeeba090c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1490,20 +1490,30 @@ static void amdgpu_dm_plane_drm_plane_reset(struc=
t drm_plane *plane)
>  {
>  	struct dm_plane_state *amdgpu_state =3D NULL;
> =20
> -	if (plane->state)
> -		plane->funcs->atomic_destroy_state(plane, plane->state);
> -
>  	amdgpu_state =3D kzalloc_obj(*amdgpu_state);
> -	WARN_ON(amdgpu_state =3D=3D NULL);

[Severity: High]
This isn't a bug introduced by this patch, but does the same dangling
pointer issue exist in other reset functions within amdgpu_dm?

For example, in drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
within amdgpu_dm_crtc_reset_state():

	if (crtc->state)
		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);

	state =3D kzalloc_obj(*state);
	if (WARN_ON(!state))
		return;

If kzalloc_obj() fails, this returns early without setting crtc->state to=20
NULL, leaving a dangling pointer to the state freed by=20
amdgpu_dm_crtc_destroy_state().

Similarly, in drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
within amdgpu_dm_connector_funcs_reset():

	kfree(state);

	state =3D kzalloc_obj(*state);

	if (state) {
		// ...
		__drm_atomic_helper_connector_reset(connector, &state->base);
	}

If the allocation fails here, connector->state is never cleared and remains=
=20
dangling.

Could these locations also be updated to prevent a potential use-after-free=
=20
under memory pressure?

> =20
>  	if (!amdgpu_state)
> -		return;
> +		goto err_alloc;
> +
> +	/* Old state can now be safely destroyed. The new state is already allo=
cated and will be assigned */

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625151717.2775=
7-1-evg28bur@yandex.ru?part=3D1
