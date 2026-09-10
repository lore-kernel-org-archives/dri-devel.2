Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158C3C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A68710E5F9;
	Thu, 10 Sep 2026 13:21:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ggi8TlUw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2114810E5F9
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 13:21:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71C71600E2;
 Thu, 10 Sep 2026 13:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D6B1F000FF;
 Thu, 10 Sep 2026 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789046516;
 bh=kk/nlQmNnPFwq5Dw0ZPFNELIOAKWZxwI65NOlsDRGaA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ggi8TlUwkg//6isk0WhReiLp7xdqIE0sDgSATXQihonnzqJZA2imQQFOK2d8sAQ30
 /SXda9tfr/Robf6TcRdR/Vij8L+Mebl98MeT3Jwgac2cM3T/Hle1drBZtgmxxlAq29
 PJaqW0A3tKq7mXkoxkul9TLgDiWYBFnP2UdWodyD+MirpDd4vTMQoR5PincML1q2/i
 1bwBQYWKDmAZNnFWsFLXbvQGe91hknmegIi/bQWmB8FYAmJsflsl3nsmXxKQITPcVb
 Bt+Y7tQioYm5Sj3Rk4J2KJx1z1Hh5jF8T+Hg7AtzN4pt03bdIXR5vSOBf2DwR31qp/
 OuCghHJ8iIGIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/rockchip: vop2: Scale the AXI clock to the
 bandwidth the mode needs
To: "Igor Paunovic" <royalnet026@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910130824.6587-1-royalnet026@gmail.com>
References: <20260910130824.6587-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:21:55 +0000
Message-Id: <20260910132156.07D6B1F000FF@smtp.kernel.org>
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
- [High] Sleeping functions called from atomic commit tail path.

Pre-existing issues:
- [High] Preexisting sleeping functions called from CRTC atomic disable cal=
lback.
--

commit ba765a9b53922b23dd96c53d16b5f0f7d8aa8c99
Author: Igor Paunovic <royalnet026@gmail.com>

drm/rockchip: vop2: Scale the AXI clock to the bandwidth the mode needs

This patch dynamically scales the VOP2 AXI clock on RK3588 based on the
bandwidth requirements of the video mode. It tracks the clock requirement v=
ia
a global atomic state object and updates the clock in the atomic commit tail
path.

Link: https://lore.kernel.org/all/20260808104240.13776-1-royalnet026@gmail.=
com/
Link: https://lore.kernel.org/all/20767137.geO5KgaWL5@diego/ [1]

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index b2f3a579bbe52..cf574e48f9561 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
[ ... ]
> +static void vop2_commit_tail_begin(struct rockchip_drm_commit_hooks *hoo=
ks,
> +				   struct drm_atomic_commit *state)
> +{
> +	struct vop2 *vop2 =3D vop2_from_commit_hooks(hooks);
> +	struct drm_private_state *old_priv_state, *new_priv_state;
> +	struct vop2_aclk_state *old_aclk_state;
> +	unsigned int i;
> +
> +	old_priv_state =3D drm_atomic_get_old_private_obj_state(state, &vop2->a=
clk_obj);
> +	new_priv_state =3D drm_atomic_get_new_private_obj_state(state, &vop2->a=
clk_obj);
> +	if (!old_priv_state || !new_priv_state)
> +		return;
> +
> +	old_aclk_state =3D to_vop2_aclk_state(old_priv_state);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(old_aclk_state->pending_commit); i++) {
> +		struct drm_crtc_commit *commit =3D old_aclk_state->pending_commit[i];
> +
> +		if (!commit)
> +			continue;
> +
> +		if (drm_crtc_commit_wait(commit))
> +			drm_err(vop2->drm, "timed out waiting for the commit on vp%u\n", i);

[Severity: High]
Does calling drm_crtc_commit_wait() here cause a kernel warning or potentia=
l=20
deadlock?=20

According to the DRM Subsystem Details, drm_atomic_helper_commit_tail()=20
and its variants execute in atomic context where sleeping is forbidden.=20
Since drm_crtc_commit_wait() uses wait_for_completion_timeout() internally,=
=20
it can sleep and may lead to issues when called from the atomic commit tail
path.

> +
> +		drm_crtc_commit_put(commit);
> +		old_aclk_state->pending_commit[i] =3D NULL;
> +	}
> +
> +	vop2_set_aclk_rate(vop2,
> +			   max(vop2_aclk_rate(vop2, old_aclk_state),
> +			       vop2_aclk_rate(vop2, to_vop2_aclk_state(new_priv_state))));
> +}
> +
> +/*
> + * Every port has moved over: settle at the rate the new configuration n=
eeds.
> + * Runs before drm_atomic_helper_commit_hw_done(), so the next commit, w=
hich
> + * waits for hw_done, never sees this write land after its own.
> + */
> +static void vop2_commit_tail_end(struct rockchip_drm_commit_hooks *hooks,
> +				 struct drm_atomic_commit *state)
> +{
> +	struct vop2 *vop2 =3D vop2_from_commit_hooks(hooks);
> +	struct drm_private_state *priv_state;
> +
> +	priv_state =3D drm_atomic_get_new_private_obj_state(state, &vop2->aclk_=
obj);
> +	if (!priv_state)
> +		return;
> +
> +	vop2_set_aclk_rate(vop2, vop2_aclk_rate(vop2, to_vop2_aclk_state(priv_s=
tate)));

[Severity: High]
Can this call to vop2_set_aclk_rate() sleep while in an atomic context?

This path eventually calls clk_set_rate() which takes a mutex and is a=20
sleeping function. Just like with drm_crtc_commit_wait() above, invoking=20
this from the atomic commit tail could lead to warnings or deadlocks.

> +}
> +
>  static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
>  				     struct drm_atomic_commit *state)
>  {

[Severity: High]
This is a pre-existing issue, but it appears that the implementation of
vop2_crtc_atomic_disable() calls sleeping functions from an atomic context.

Specifically, it calls vop2_lock() which acquires a mutex, and=20
wait_for_completion_timeout() for vp->dsp_hold_completion. The subsystem=20
guidelines state that CRTC atomic disable callbacks run in atomic context=20
where sleeping is forbidden. This might also be contributing to kernel
warnings or system instability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910130824.6587=
-1-royalnet026@gmail.com?part=3D1
