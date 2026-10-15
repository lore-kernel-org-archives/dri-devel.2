Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CF0CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EE41112420;
	Thu, 15 Oct 2026 16:32:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0371E1123E0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:32:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 18D7C60A62
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A505C1F000C5;
 Thu, 15 Oct 2026 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792081919;
 bh=Nf37gqU7V2um2nDx7cecpchR5v80lUjDKnvbuAjbfsA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=THam7ijkndz7etciNY19+q7J0iypsPpDYzC7bA79jx87JQ7f3T1/cicbq/2Fw8ihd
 6gkLZnWSYTZieXhDDXJyrD24OAbrwgewNnTP30bytMiXVtzYGPIk/W/5fLmo1SpFH1
 EROsHTb5Q6jioKOEnjWH6pWdL3an2JOFpRgCICxv057NARFGgK1+WPUQQXVnPhA2kN
 AL2o8+/91pYh6UJe8zRASk/Fv6uSBklNcDuu/MAoWYCRR1tfAjKrowVt3SlMnnEVkl
 uOKO9K3ni3eyiPK39sbr0PGAUJwlyANhg6HahS9Zj3bvHjzlgff+yS6haChry5dSOk
 aABot2wCtGJFQ==
Message-ID: <sashiko-outbox-173192@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/28] drm/atomic_helper: Compare actual and readout
 states once the commit is done
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-16-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-16-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:31:59 +0000
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
- [Critical] drm: null pointer dereference in drm_atomic_sro_readout_and_co=
mpare() due to missing SRO support checks
- [High] drm: concurrent hardware state readout races with disjoint atomic =
commits
--

commit 54159ebf5886b308c147c6831cca5d526d0cafd5
Author: Maxime Ripard <mripard@kernel.org>
Subject: drm/atomic_helper: Compare actual and readout states once the comm=
it is done

This commit introduces a new hook for every state, atomic_sro_compare_state,
to read out a new state every time a blocking commit is made, and compare
the readout one with the committed one.

> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> index 9d006f98413a5..fa8a337650138 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
[ ... ]
> @@ -2087,6 +2088,45 @@ static void commit_tail(struct drm_atomic_commit *=
state, bool nonblock)
> =20
>  	drm_atomic_helper_commit_cleanup_done(state);
> =20
> +	/*
> +	 * drm_atomic_sro_readout_and_compare() will compare the @state new
> +	 * states with whatever it will read from the hardware.
[ ... ]
> +	 * Either way, we're past that point here, so we wouldn't delay the
> +	 * fence signalling.
> +	 */
> +	if (!nonblock)
> +		drm_atomic_sro_readout_and_compare(state);

[Severity: Critical]
Will this unconditionally execute for all blocking commits, bypassing any
check for whether the underlying DRM driver actually supports SRO?

Since this is a newly introduced, optional SRO hook, the vast majority of
existing DRM atomic drivers do not implement atomic_sro_build_state, and
some may not even define helper_private.

> +
>  	drm_atomic_commit_put(state);
>  }
> diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomi=
c_sro.c
> index 15ecf88714faa..cd7015f8c333c 100644
> --- a/drivers/gpu/drm/drm_atomic_sro.c
> +++ b/drivers/gpu/drm/drm_atomic_sro.c
[ ... ]
> @@ -725,3 +789,144 @@ void drm_atomic_sro_install_state(struct drm_atomic=
_sro_state *state)
[ ... ]
> +bool drm_atomic_sro_readout_and_compare(struct drm_atomic_commit *commit)
> +{
> +	struct drm_device *dev =3D commit->dev;
> +	const struct drm_mode_config_helper_funcs *funcs =3D
> +		dev->mode_config.helper_private;
> +	struct drm_printer p =3D drm_err_printer(dev, NULL);
> +	struct drm_private_state *new_obj_state;
> +	struct drm_private_obj *obj;
> +	struct drm_plane_state *new_plane_state;
> +	struct drm_plane *plane;
> +	struct drm_crtc_state *new_crtc_state;
> +	struct drm_crtc *crtc;
> +	struct drm_connector_state *new_conn_state;
> +	struct drm_connector *conn;
> +	struct drm_atomic_sro_state *readout_state;
> +	unsigned int i;
> +	bool identical =3D true;
> +
> +	readout_state =3D funcs->atomic_sro_build_state(dev);

[Severity: Critical]
Could this result in a NULL pointer dereference for non-SRO drivers?

The function extracts the helper functions via dev->mode_config.helper_priv=
ate
and immediately dereferences funcs->atomic_sro_build_state(dev) without
verifying if the pointer exists. Should the code explicitly verify
if (funcs && funcs->atomic_sro_build_state) or use
drm_atomic_sro_device_can_readout(dev) before proceeding?

[Severity: High]
Does reading the hardware state of unrelated objects here introduce hardware
data races with concurrent commits?=20

This initiates a device-wide hardware state readout from within
commit_tail() during a partial atomic commit. An atomic commit only holds
drm_modeset_locks for the specific objects being modified in that
transaction.=20

By unconditionally reading the hardware state of all other unrelated,
unlocked objects across the device, this introduces a data race with
concurrent atomic commits that may be actively powering down or reconfiguri=
ng
those disjoint objects. Reading unclocked or powered-down peripheral
registers during a concurrent reprogram sequence can trigger bus hangs,
system lockups, or yield corrupted readout data. Should the readout scope be
restricted solely to the objects locked within the drm_atomic_commit contex=
t?

> +	if (WARN_ON(IS_ERR(readout_state)))
> +		return false;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D16
