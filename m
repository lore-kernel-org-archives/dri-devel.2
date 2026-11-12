Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84BF606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkEOQexL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E09210E592;
	Thu, 12 Nov 2026 09:01:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E3410E592
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:01:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A597360DEA;
 Thu, 12 Nov 2026 09:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4E41F00A0E;
 Thu, 12 Nov 2026 09:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794474068;
 bh=ccNNZeCgsD/T3P3XZjToEhS82dcX1+5omntB+GjmWZw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WkEOQexL97lIiw2qe/I37oGUqY9hJT8W4FVWaEb9GdUj59+CoeHPRgyMpJK0KbJw9
 YdXQUVAvsSngGCW9LPZrrlyBV6GINnCaBKbVYOKQ8hrUbFrVPG/M7uI8T5qrDMjjjg
 C3Ux+7afgICIALWtfne1OiYalcAOqqhs9iKl2SaXFdYqXqizGwXOm8zzma/cxNxAGA
 cnPz581OevWi5Z8KngstIP4kDoa1ewpz526vZK/dkQUGXEafrm5z89RfwqYzDHcBYq
 S4W0UaQVbPy0wpfU7D0qpsfcB3JJacpQPtXK/0eaebiHu/1INejiopiZwB4tzISW5m
 vNtDKbqmbQWDQ==
Message-ID: <sashiko-outbox-210814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] drm/rockchip: vop2: Balance window fetches
 across both AXI ports on RK3588
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-vop2-fixes-v2-5-8218c1cf8ac8@gmail.com>
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
 <20261112-vop2-fixes-v2-5-8218c1cf8ac8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 09:01:07 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/rockchip: vop2: wrong AXI clash checks in
  vop2_win_may_fetch()
--

commit 73d9c526a345979a18aa8e0e398a482c59cd3a4f
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/rockchip: vop2: Balance window fetches across both AXI ports on RK3588

This commit dynamically assigns AXI read ports to VOP2 windows on RK3588
during atomic check to balance memory bandwidth across both ports while
avoiding AXI read ID collisions.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 7c157f5c17346..684fa46924e7f 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
[ ... ]
> +/*
> + * Whether a window that doesn't fetch in the new state may still fetch =
while
> + * a window starts on @crtc. The window registers are latched at the fra=
me
> + * start of their video port: a window switched off in this commit stops
> + * together with the new one only on the same video port, and one switch=
ed
> + * off in an earlier commit once that commit is done.
> + */
> +static int vop2_win_may_fetch(struct drm_atomic_commit *state,
> +			      struct vop2_win *win, const struct drm_crtc *crtc,
> +			      bool *fetching)
> +{
> +	const struct drm_plane_state *old =3D drm_atomic_get_old_plane_state(st=
ate, &win->base);
> +	struct drm_crtc_commit *commit;
> +	int ret;
> +
> +	if (old) {
> +		*fetching =3D old->crtc && old->crtc !=3D crtc;
> +		return 0;
> +	}
> +
> +	ret =3D drm_modeset_lock(&win->base.mutex, state->acquire_ctx);
> +	if (ret)
> +		return ret;
> +
> +	commit =3D win->base.state->commit;
> +	*fetching =3D commit && !try_wait_for_completion(&commit->flip_done);
> +
> +	return 0;
> +}
[ ... ]
> +			if (!fetching) {
> +				ret =3D vop2_win_may_fetch(state, w, pstate->crtc, &fetching);
> +				if (ret)
> +					return ret;
> +			}
> +
> +			if (fetching)
> +				clash[new->win[j].bus] =3D true;

[Severity: Medium]
Does vop2_win_may_fetch() misidentify whether a clashing window w is still
fetching by branching on whether w is in @state (old !=3D NULL) instead of
whether w was active in the old AXI state (old->win[j].active)?

When old !=3D NULL, *fetching is set to old->crtc && old->crtc !=3D crtc wi=
thout
checking old->win[j].active. If w is attached to another CRTC that is in
DPMS off, or w is clipped off-screen (!old->visible), w is already disabled
in hardware, yet pulling w into @state (for instance via
drm_atomic_normalize_zpos()) marks its AXI port as clashing and forces the
new window onto the other, potentially saturated port. Conversely, if w was
disabled in an earlier non-blocking commit that has not completed flip_done
and w is included in @state with old->crtc =3D=3D NULL, the old !=3D NULL b=
ranch
returns *fetching =3D false without checking old->commit->flip_done.

When old =3D=3D NULL, the fallback checks win->base.state->commit->flip_done
without checking commit->crtc !=3D crtc, so an earlier non-blocking disable=
 on
the same video port is treated as clashing even though its registers latch =
at
the same frame start. In addition, drm_atomic_helper_setup_commit() sets
plane_state->commit on every plane in a commit's state, so an in-flight
commit on another CRTC that included an already-inactive plane w causes
vop2_win_may_fetch() to report w as fetching.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-vop2-fixes=
-v2-0-8218c1cf8ac8@gmail.com?part=3D5
