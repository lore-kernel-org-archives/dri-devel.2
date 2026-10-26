Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D4606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6EsnK1Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5123210F0D2;
	Mon, 26 Oct 2026 19:32:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 336D510F0D2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 19:31:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7303D601EF;
 Mon, 26 Oct 2026 19:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFF91F01825;
 Mon, 26 Oct 2026 19:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793043116;
 bh=BcdWlR4z+NXL6A3SiKGiIEgvbY6TAJXJCP+qu5LXmlQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W6EsnK1QXyhkqZ1H3eN1x3x0gSrzBFE6SjyVqbbM4XQPjJe2lW4NNJTcC2ml5eMA0
 3uaNxc3qodUWLA4Xf8NJ7U/F1pb7nnuP9onOOvx/8EgxdT36UzwCJ7PniYM+X7hK7T
 Tkf//ID6JawDZG1H88I0hUX4/4GYItwBzByWr9/rWQzX26Quu+RecGhWzvbWnyLEbw
 q1ry4A2gCTB2KfvuF6B29FwUJndikno3oBWETIbCvSPmIPiFCJrGmifCRHiDdFD5SC
 lD2xSi5GZ2O7nsw2dIZADCSRdjhFrQ7MpUz2SnaCBgaw5KB4GAi6m0KS0pDXPHfc2M
 Fi3nH3/n8dKXQ==
Message-ID: <sashiko-outbox-185678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] drm/msm/dpu: workaround res re-assignment issues by
 pairing enc/crtc
To: "Xi Zhang" <xz.ca.cn@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026-msm-dpu-res-clean-v1-6-f46130a8a717@gmail.com>
References: <20261026-msm-dpu-res-clean-v1-0-f46130a8a717@gmail.com>
 <20261026-msm-dpu-res-clean-v1-6-f46130a8a717@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 19:31:55 +0000
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/msm/dpu: disjoint possible_crtcs in _dpu_kms_drm_obj_init() br=
eaks CWB
- [Medium] drm/msm/dpu: pairing encoder i to crtc i deprives encoders of cu=
rsor planes
- [Medium] drm/msm/dpu: broken possible_crtcs pairing in _dpu_kms_drm_obj_i=
nit()
--

commit 92f85d682d2387cdaeb71bf5aeb4e7434bd2e013
Author: Xi Zhang <xz.ca.cn@gmail.com>

drm/msm/dpu: workaround res re-assignment issues by pairing enc/crtc

This commit pairs each encoder with a dedicated CRTC in
_dpu_kms_drm_obj_init() when dev->mode_config.num_crtc >=3D num_encoders so
that modesets keep the same CRTC and release old DPU resources before
allocating new ones during atomic_check.

>     drm/msm/dpu: workaround res re-assignment issues by pairing enc/crtc
>    =20
>     Consider the scenario with 4 crtcs, 3 encoders/displays are
>     connected. DPU resources is nearly maxed-out, and mode set is
>     performed on a display which has acquired many dpu resources.
>     A new crtc is selected by kernel drm for the mode set,
>     and during atomic_check, the previous crtc won't have a chance
>     to release its old resources from global_state before the new
>     crtc tries to allocate new ones. Leading to atomic_check failure.
>    =20
>     By having the same crtc for encoder when possible, during
>     atomic_check each individual crtc will always be able to release
>     old resources before allocating new ones.
>    =20
>     Signed-off-by: Xi Zhang <xz.ca.cn@gmail.com>

[Severity: Medium]
Can the scenario with 4 CRTCs and 3 encoders described in the commit message
occur, and does pairing encoders to CRTCs resolve cross-CRTC resource
reassignment in dpu_crtc_atomic_check()?

In drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:_dpu_kms_drm_obj_init(), the
number of created CRTCs is capped at num_encoders:

    max_crtc_count =3D min(catalog->mixer_count, num_encoders);
    ...
    max_crtc_count =3D min(max_crtc_count, primary_planes_idx);

    /* Create one CRTC per encoder */
    for (i =3D 0; i < max_crtc_count; i++) {
        crtc =3D dpu_crtc_init(dev, primary_planes[i], cursor_planes[i]);

so dev->mode_config.num_crtc is never greater than num_encoders.

In addition, drm_atomic_helper_check_planes() iterates over CRTCs in
ascending CRTC index order and calls dpu_crtc_atomic_check(). Inside
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c, both dpu_crtc_assign_resources()
and dpu_crtc_reassign_planes() release and immediately reserve resources per
CRTC:

    dpu_rm_release(global_state, crtc);

    if (!crtc_state->enable)
        return 0;

    topology =3D dpu_crtc_get_topology(crtc, dpu_kms, crtc_state);
    ret =3D dpu_rm_reserve(&dpu_kms->rm, global_state,
                 crtc_state->crtc, &topology);

and:

    dpu_rm_release_all_sspp(global_state, crtc);

    return dpu_crtc_assign_planes(crtc, crtc_state);

Even with 1:1 encoder-to-CRTC pairing, if a multi-display atomic commit
disables or reduces resources on a higher-indexed CRTC while enabling or
increasing resources on a lower-indexed CRTC, won't the lower-indexed CRTC
still attempt to reserve from global_state before the higher-indexed CRTC h=
as
released its old resources?

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/ms=
m/disp/dpu1/dpu_kms.c
> index da3556eb6ecc2..13099d6e3ac95 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -879,9 +879,18 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu=
_kms)
>  		}
>  	}
> =20
> -	/* All CRTCs are compatible with all encoders */
> -	drm_for_each_encoder(encoder, dev)
> -		encoder->possible_crtcs =3D (1 << dev->mode_config.num_crtc) - 1;
> +	/* All CRTCs are compatible with all encoders.
> +	 * Nevertheless, if enough CRTCs are available, pair up crtc/encoder
> +	 * for better resource re-assignments during atomic_check
> +	 * from userspace mode set.
> +	 */
> +	i =3D 0;
> +	drm_for_each_encoder(encoder, dev) {
> +		if (dev->mode_config.num_crtc >=3D num_encoders)
> +			encoder->possible_crtcs =3D 1 << i++;

[Severity: High]
Does assigning encoder->possible_crtcs =3D 1 << i++ break Concurrent Writeb=
ack
(CWB) clone mode on platforms where catalog->cwb_count > 0?

Earlier in _dpu_kms_drm_obj_init(), DSI and Writeback encoders are marked as
clones via dpu_encoder_get_clones():

    drm_for_each_encoder(encoder, dev) {
        num_encoders++;
        if (catalog->cwb_count > 0)
            encoder->possible_clones =3D dpu_encoder_get_clones(encoder);
    }

where drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:dpu_encoder_get_clones()
pairs DRM_MODE_ENCODER_DSI and DRM_MODE_ENCODER_VIRTUAL encoders so both can
attach to the same drm_crtc.

When dev->mode_config.num_crtc >=3D num_encoders, this loop gives every enc=
oder
a mutually exclusive single-bit possible_crtcs mask. When userspace submits
an atomic commit attaching both a DSI encoder and a Writeback encoder to the
same CRTC for CWB, drm_atomic_helper_check_modeset() ->
update_connector_routing() checks drm_encoder_crtc_ok():

    if (!drm_encoder_crtc_ok(new_encoder, new_connector_state->crtc)) {
        drm_dbg_atomic(connector->dev,
                   "[ENCODER:%d:%s] incompatible with [CRTC:%d:%s]\n",
                   new_encoder->base.id,
                   new_encoder->name,
                   new_connector_state->crtc->base.id,
                   new_connector_state->crtc->name);
        return -EINVAL;
    }

Because the DSI and Writeback encoders no longer share any common CRTC bit =
in
possible_crtcs, won't all CWB clone commits be rejected with -EINVAL?

[Severity: Medium]
Also in _dpu_kms_drm_obj_init(), won't locking encoder i to CRTC i prevent
displays on higher-indexed encoders from using hardware cursor planes?

Earlier in _dpu_kms_drm_obj_init(), DRM_PLANE_TYPE_CURSOR planes are only
created for SSPPs with BIT(DPU_SSPP_CURSOR) (at most 1 or 2 across DPU
catalogs):

    if ((catalog->sspp[i].features & BIT(DPU_SSPP_CURSOR))
        && cursor_planes_idx < max_crtc_count)
        type =3D DRM_PLANE_TYPE_CURSOR;

and passed to dpu_crtc_init():

    for (i =3D 0; i < max_crtc_count; i++) {
        crtc =3D dpu_crtc_init(dev, primary_planes[i], cursor_planes[i]);

Therefore, CRTCs at index i >=3D cursor_planes_idx are initialized with
cursor_planes[i] =3D=3D NULL (so crtc->cursor =3D=3D NULL).

Because _dpu_kms_setup_displays() registers encoders in fixed controller
order (DSI, DP controllers, HDMI, Writeback), an active display on an encod=
er
at index i >=3D cursor_planes_idx (such as an eDP panel on dp[3] on multi-DP
laptops) is now forced onto CRTC i where crtc->cursor is NULL, even when
CRTC 0 and CRTC 1 are unused.

When userspace calls DRM_IOCTL_MODE_CURSOR or DRM_IOCTL_MODE_CURSOR2 on that
CRTC, drivers/gpu/drm/drm_plane.c:drm_mode_cursor_common() sees
crtc->cursor =3D=3D NULL:

    if (crtc->cursor) {
        ...
        ret =3D drm_mode_cursor_universal(crtc, req, file_priv, &ctx);
        goto out;
    }

    if (req->flags & DRM_MODE_CURSOR_BO) {
        if (!crtc->funcs->cursor_set && !crtc->funcs->cursor_set2) {
            ret =3D -ENXIO;
            goto out;
        }

and fails with -ENXIO (or -EFAULT for DRM_MODE_CURSOR_MOVE) because
dpu_crtc_funcs does not implement legacy cursor callbacks, while also
preventing drm_atomic_helper_update_plane() from setting
state->legacy_cursor_update for async cursor updates in can_do_async().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-msm-dpu-re=
s-clean-v1-0-f46130a8a717@gmail.com?part=3D6
