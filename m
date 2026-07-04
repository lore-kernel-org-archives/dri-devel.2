Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46ECC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B3410E0D3;
	Sat,  4 Jul 2026 18:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ca5Ta4xq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D62810E0D3
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:53:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CBCC60052;
 Sat,  4 Jul 2026 18:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627B61F000E9;
 Sat,  4 Jul 2026 18:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783191227;
 bh=CfT4SqdzxNT8gdaM3y8lRRCXLvW6Ir7qsFGSwxUsO/c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ca5Ta4xqoZSdaXckHp8ogNuLdWJ7ajjwv4PECaoyQYcr7n+d6T+/X1hqLEFxzBv5E
 AkTacW/IpbvnH6dR80jnOCvNsjcE0tBPVg5ZLShvoI0gvOKfwvf60iecLb32Bt/FGF
 xMm18ZRNY7HCQNYARwEhwlnD1H50AeZzKJgxcvoLoBElrqxzfpK7Ld7CVMT+22iQuw
 Bm5wrcO/dSNxBN5y+1WNfiBlQ5cvlb6E0/WESWVqaPUiA3ONNCW0wmM8SrIIo5pD5E
 zLs9eF8DFSR3lxCFy0RWqU2zLgsuR0WFptBPqwOzJQdqbkexhXQWEsF06LOSukEsFt
 v4Rt0l0EdUQyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] drm/xen: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20260705-drm-simple-kms-removal-v1-9-b4e1ca053623@oss.qualcomm.com>
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-9-b4e1ca053623@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:53:45 +0000
Message-Id: <20260704185346.627B61F000E9@smtp.kernel.org>
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
- [High] Hardcoded `possible_crtcs` mask restricts all primary planes to CR=
TC 0, breaking multi-display support.
- [High] Direct access of global `plane->state` and `crtc->state` in atomic=
 commit hooks leads to race conditions and stalled events.
--

commit 8a32b307abb3d8e006d032d01a1802aa1e4ae6f0
Author: Ze Huang <ze.huang@oss.qualcomm.com>

drm/xen: replace struct drm_simple_display_pipe with regular atomic helpers

Replace Xen frontend simple display pipe with explicit plane, CRTC and
encoder objects for each pipeline. Keep generic plane-state validation
before Xen-specific checks, and install GEM framebuffer prepare helper
explicitly.

> diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xe=
n/xen_drm_front_kms.c
> index 48772b5fe71cf..57e1bef452f83 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c

[ ... ]

> @@ -105,17 +105,15 @@ static void send_pending_event(struct xen_drm_front=
_drm_pipeline *pipeline)
>  	spin_unlock_irqrestore(&dev->event_lock, flags);
>  }
> =20
> -static void display_enable(struct drm_simple_display_pipe *pipe,
> -			   struct drm_crtc_state *crtc_state,
> -			   struct drm_plane_state *plane_state)
> +static void xen_drm_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					      struct drm_atomic_commit *state)
>  {
> -	struct xen_drm_front_drm_pipeline *pipeline =3D
> -			to_xen_drm_pipeline(pipe);
> -	struct drm_crtc *crtc =3D &pipe->crtc;
> +	struct xen_drm_front_drm_pipeline *pipeline =3D to_xen_drm_pipeline(crt=
c);
> +	struct drm_plane_state *plane_state =3D pipeline->plane.state;

[Severity: High]
Is it safe to access the global pipeline->plane.state directly here? If
non-blocking commits overlap, this pointer might point to a newer,
uncommitted state. Should this code use drm_atomic_get_new_plane_state()
to extract the state from the drm_atomic_commit object instead?

>  	struct drm_framebuffer *fb =3D plane_state->fb;
>  	int ret, idx;

[ ... ]

> @@ -242,15 +259,19 @@ static int display_check(struct drm_simple_display_=
pipe *pipe,
>  	return 0;
>  }
> =20
> -static void display_update(struct drm_simple_display_pipe *pipe,
> -			   struct drm_plane_state *old_plane_state)
> +static void xen_drm_plane_helper_atomic_update(struct drm_plane *plane,
> +					       struct drm_atomic_commit *state)
>  {
> -	struct xen_drm_front_drm_pipeline *pipeline =3D
> -			to_xen_drm_pipeline(pipe);
> -	struct drm_crtc *crtc =3D &pipe->crtc;
> +	struct drm_plane_state *old_plane_state =3D drm_atomic_get_old_plane_st=
ate(state, plane);
> +	struct drm_crtc *crtc =3D plane->state->crtc ?: old_plane_state->crtc;

[Severity: High]
Can accessing the global plane->state pointer here cause race conditions?
It might be safer to use drm_atomic_get_new_plane_state(state, plane)->crtc
to ensure the correct state is referenced during the atomic commit.

> +	struct xen_drm_front_drm_pipeline *pipeline;
>  	struct drm_pending_vblank_event *event;
>  	int idx;
> =20
> +	if (!crtc)
> +		return;
> +
> +	pipeline =3D to_xen_drm_pipeline(crtc);
>  	event =3D crtc->state->event;

[Severity: High]
Similarly, does reading and modifying the global crtc->state directly risk
fetching state from a concurrent commit instead of the current one?

>  	if (event) {
>  		struct drm_device *dev =3D crtc->dev;

[ ... ]

> @@ -331,10 +395,37 @@ static int display_pipe_init(struct xen_drm_front_d=
rm_info *drm_info,
> =20
>  	formats =3D xen_drm_front_conn_get_formats(&format_count);
> =20
> -	return drm_simple_display_pipe_init(dev, &pipeline->pipe,
> -					    &display_funcs, formats,
> -					    format_count, NULL,
> -					    &pipeline->conn);
> +	ret =3D drm_universal_plane_init(dev, &pipeline->plane, 1,
> +				       &display_plane_funcs,
> +				       formats, format_count,
> +				       NULL,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);

[Severity: High]
Does hardcoding the possible_crtcs mask to 1 restrict all primary planes to
CRTC 0? For pipelines with an index greater than 0, the CRTC might fail to
find a compatible primary plane during atomic validation. Would using
1 << pipeline->index allow multi-display configurations to work correctly?

> +	if (ret)
> +		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-drm-simple=
-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com?part=3D9
