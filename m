Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E9ECC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C5510E5CA;
	Thu, 15 Oct 2026 15:52:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4DC810E5CA
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:52:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81102436B2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508741F000C4;
 Thu, 15 Oct 2026 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792079523;
 bh=gT+vywrKMAHWvYIFDFV98FrKjX5A1zJYLbF3vWVxhvc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fIcLS3B4yNk/wLliRAqTwfH0VhbZauGd4880m5rDdNIilYcTVTUQjecM/Kt3k3nWb
 JoKs6z0YHRQ+DCXoP/sSRAAPwjb0pGtEXfVFGvgqBSSa9+erSedQJ4V5gfSPcZ9kSo
 M43JfpgbkflJ0fFITSd0+lfApdbwu3RL4Q+6f+RfASaCYi45X4GUM1FJIUVhfzwglt
 pqK3tbHtcyVoAs3/8ajvlEHvgTYbX74tvRWQ2CtC5euGqnWRoTYHrRQ796UkovvZaS
 hemhtAheuCS4hg+hxBS2TiW543SNRWUZ53haihTz0SnBfQWUk/M2cT3gw9QgSuJ/nU
 Af2DaTlSxO8zg==
Message-ID: <sashiko-outbox-173109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/28] drm/atomic_sro: Add atomic state readout
 infrastructure
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-8-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-8-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:52:02 +0000
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
- [Critical] drm: NULL pointer dereference in SRO readout and compare hooks
- [High] drm: Buffer overflow in atomic SRO state due to dynamic connector =
counts
--

commit 419b43474568c97f2e2b083e992fc05ff840db52
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Add atomic state readout infrastructure

This patch introduces the atomic state readout (SRO) infrastructure by
adding readout hooks to KMS object vtables and providing top-level entry
points for hardware state readout at initialization.

> diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomi=
c_sro.c
> index 1551f6de6c89a..6921af73eb697 100644
> --- a/drivers/gpu/drm/drm_atomic_sro.c
> +++ b/drivers/gpu/drm/drm_atomic_sro.c
[ ... ]
> @@ -25,6 +26,59 @@ module_param_unsafe(atomic_readout, uint, 0400);
>  MODULE_PARM_DESC(atomic_readout,
>  		 "Enable Hardware State Readout (0 =3D disabled, 1 =3D enabled, 2 =3D =
ignore missing compares, 3 =3D ignore missing readouts and compares, defaul=
t =3D 1)");
> =20
> +static bool drm_atomic_sro_can_readout(struct drm_device *dev)
> +{
> +	struct drm_crtc *crtc;
> +	struct drm_plane *plane;
> +	struct drm_connector *connector;
> +	struct drm_private_obj *privobj;
> +	struct drm_connector_list_iter conn_iter;
> +
> +	if (atomic_readout =3D=3D DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT)
> +		return true;

[Severity: Critical]
If atomic_readout is set to DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT (3), th=
is
bypasses driver capability checks and returns true. Can this cause a NULL
pointer dereference?

Looking at drm_atomic_sro_readout_and_compare() and
drm_atomic_helper_sro_readout_state(), they unconditionally dereference
dev->mode_config.helper_private (as funcs) and call
funcs->atomic_sro_build_state(dev):

    const struct drm_mode_config_helper_funcs *funcs =3D
        dev->mode_config.helper_private;
    ...
    readout_state =3D funcs->atomic_sro_build_state(dev);

Since most existing atomic drivers do not implement SRO and leave
atomic_sro_build_state NULL (or lack helper_private entirely), wouldn't
bypassing this capability check cause an immediate NULL pointer dereference=
 on
any modeset or blocking commit for those drivers?

Also, doesn't drm_atomic_helper_commit_hw_done() unconditionally call
drm_atomic_sro_readout_and_compare() for all blocking commits across all
atomic drivers, triggering this crash even without the module parameter?

    if (!nonblock)
        drm_atomic_sro_readout_and_compare(state);

Looking at the state allocation in drm_atomic_sro_state_init():

    state->connectors =3D kzalloc_objs(*state->connectors,
                                     dev->mode_config.num_connector);

[Severity: High]
Can this array overflow when DP MST connectors are dynamically added?

Since MST connectors can be added or removed dynamically, a connector's
IDA-allocated index (conn->index) can exceed the originally allocated
dev->mode_config.num_connector count.

Later in drm_atomic_sro_set_connector_state(), the code writes to this array
without a bounds check or dynamic reallocation:

    unsigned int index =3D drm_connector_index(conn);
    drm_connector_get(conn);
    state->connectors[index].ptr =3D conn;
    state->connectors[index].state =3D conn_state;

Does this lead to an out-of-bounds write?

Additionally, drm_atomic_sro_state_free() iterates using the live
dev->mode_config.num_connector value instead of the allocated capacity:

    for (i =3D 0; i < state->dev->mode_config.num_connector; i++) {
        struct drm_connector *conn =3D state->connectors[i].ptr;

If the number of connectors increased or decreased since allocation, could =
this
lead to an out-of-bounds read or a memory leak respectively?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D8
