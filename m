Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706A1C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2EEE10F577;
	Thu,  9 Jul 2026 12:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jGC4IruU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D43910F572
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:00:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 360F2400D8
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26791F00A3A;
 Thu,  9 Jul 2026 12:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783598434;
 bh=asV61tk7nVmL3qfpUliw9qRaqdQwomg7AculEsHM7Xo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jGC4IruUTBnAZ6jn2YzRMJfy3Z5ATNiFCiimEGm1i8nOifQZPDaC7Tf+q2bvTsdv8
 IwaS8oHAATfOmxqlpHv/sR5kpgkdz16UnTGKuDfZvqWXJw39II66GmhXtcafqqxIG9
 So+sSvfQ0RCSja05oIBteBtzu28+DCM6BHJI3113dK38fWgLCKns/VJ1mTbGzXxBtj
 wPXIdZcWdUWOLJmEhpl/i1rIW3K960WGk2+ceS3lsf6xfoSRaS/S3wd92RGGyfGAe9
 eqJvnNU7A56NROsxPNGdWSbiYuVS1uT11n2/+qC6VJUb2+o4MefqpJFcz5szpVEIpP
 94QAH0wU+mNQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/60] drm/simple-kms: Add create_plane_state hook
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-1-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-1-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:00:33 +0000
Message-Id: <20260709120033.E26791F00A3A@smtp.kernel.org>
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
- [High] Unconditional call to the optional `destroy_plane_state` callback =
causes a NULL pointer dereference if the driver does not implement it.
- [Medium] The fallback priority between `create_plane_state` and `reset_pl=
ane` contradicts the intended design, prioritizing the legacy hook.
--

--- Patch [1]: [PATCH 01/60] drm/simple-kms: Add create_plane_state hook ---
commit 2eb693cbd25d991d0fc7bf28e45683c97579b97a
Author: Maxime Ripard <mripard@kernel.org>

drm/simple-kms: Add create_plane_state hook

This commit introduces a create_plane_state hook to the simple-kms helper to
allow drivers to allocate and initialize pristine state without side effect=
s.
It updates drm_simple_kms_plane_reset() to use this new hook while falling
back to the legacy reset_plane hook if it is not provided.

> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/dr=
m_simple_kms_helper.c
> index 8e1d07b9f1e30..efb643ab64487 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
[ ... ]
> @@ -286,10 +286,29 @@ static void drm_simple_kms_plane_reset(struct drm_p=
lane *plane)
>  	struct drm_simple_display_pipe *pipe;
> =20
>  	pipe =3D container_of(plane, struct drm_simple_display_pipe, plane);
> -	if (!pipe->funcs || !pipe->funcs->reset_plane)
> +	if (!pipe->funcs)
>  		return drm_atomic_helper_plane_reset(plane);
> =20
> -	return pipe->funcs->reset_plane(pipe);
> +	if (pipe->funcs->reset_plane)
> +		return pipe->funcs->reset_plane(pipe);
> +
> +	if (pipe->funcs->create_plane_state) {

[Severity: Medium]
Does this evaluation order match the intended design? The commit message=20
states the code will use create_plane_state to allocate a fresh state,=20
falling back to reset_plane. But here, if a driver provides both during a=20
migration, it returns early and create_plane_state will not be executed.
Should create_plane_state be prioritized before checking reset_plane?

> +		struct drm_plane_state *state;
> +
> +		if (plane->state) {
> +			pipe->funcs->destroy_plane_state(pipe, plane->state);

[Severity: High]
Can this cause a NULL pointer dereference? If a driver implements=20
create_plane_state but relies on the default destruction logic (meaning=20
pipe->funcs->destroy_plane_state is NULL), this unconditional call will=20
panic when plane->state is already set, such as during suspend/resume or=20
consecutive resets. Other functions in this file check for NULL and safely=
=20
fall back to drm_atomic_helper_plane_destroy_state().

> +			plane->state =3D NULL;
> +		}
> +
> +		state =3D pipe->funcs->create_plane_state(pipe);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D1
