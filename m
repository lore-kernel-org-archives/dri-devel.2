Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EED606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EY5GvC2z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BAFF10E107;
	Fri,  6 Nov 2026 13:44:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C538E112DA9
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB8D641EEF
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676F21F008A6;
 Fri,  6 Nov 2026 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793972662;
 bh=3JGNwXg0XUM0B1COfbc5dQgAith6E4jpEsqUxJIvCzQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EY5GvC2zh5scNIRJ2jn8NgQ/7Wy1H2Y2Vc25mIp+P0hDjHVZoYITV4Z7CQ9BePDEb
 wDj/jN/mxy0Rj+FyXAtXosD08Yv3Rzz57bixqJc0U/eIUEKa54cUukpOHqpL6x4h1r
 Nq+wj6JSTDngnRdP04YObhmUMipKLrZwQPZE56gQVlrwAmVeFj/b96nr/KJYdJ4nCc
 S9yc7NYOrHpWBKb1I8ob6Ozb8buX+0+QIy6o6FhIigr5ri8yCc//DZhE9NFoumdxwd
 WaCn9IoZuz0odgWubj+ZSt5tEJV4TPPf8mJZH7TuKTKBWt3TVgaeORBMAwy7IhM5js
 qk8t7Gb2oPABg==
Message-ID: <sashiko-outbox-201491@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 20/39] drm/atomic_sro: Provide helpers to implement
 hardware state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-20-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-20-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:44:22 +0000
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
- [High] drm/atomic_sro: missing drm_crtc_vblank_reset() in CRTC state
  readout
--

commit 3ceb67bab8b0a4cc05a31256122d1df0b3736c93
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Provide helpers to implement hardware state readout

This commit adds helper functions to read out KMS object states from
hardware and install them as the initial atomic state.

> diff --git a/drivers/gpu/drm/drm_atomic_state_readout_helper.c b/drivers/=
gpu/drm/drm_atomic_state_readout_helper.c
> new file mode 100644
> index 0000000000000..1b6cf304702c2
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
[ ... ]
> +int drm_atomic_helper_sro_readout_state(struct drm_device *dev)
> +{
> +	const struct drm_mode_config_helper_funcs *funcs =3D
> +		dev->mode_config.helper_private;
> +	struct drm_atomic_sro_state *state;
> +	struct drm_colorop *colorop;
> +
> +	if (!drm_atomic_sro_device_can_readout(dev)) {
> +		drm_info(dev, "Device doesn't support hardware state readout.");
> +		return -ENOTSUPP;
> +	}
> +
> +	state =3D funcs->atomic_sro_build_state(dev, NULL);
> +	if (IS_ERR(state)) {
> +		drm_warn(dev, "Couldn't read out the hardware state: %pe\n",
> +			 state);
> +		return PTR_ERR(state);
> +	}
> +
> +	/* TODO: Add colorop state readout support */
> +	drm_for_each_colorop(colorop, dev) {
> +		struct drm_colorop_state *colorop_state;
> +
> +		/*
> +		 * The colorop states are already initialized when the
> +		 * colorops are created. Only create a pristine state for
> +		 * the ones that don't have one, like
> +		 * drm_mode_config_create_state() does.
> +		 */
> +		if (colorop->state)
> +			continue;
> +
> +		colorop_state =3D drm_atomic_helper_colorop_create_state(colorop);
> +		if (IS_ERR(colorop_state)) {
> +			drm_atomic_sro_state_free(state);
> +			return PTR_ERR(colorop_state);
> +		}
> +
> +		colorop->state =3D colorop_state;
> +	}
> +
> +	drm_atomic_sro_install_state(state);
> +	drm_atomic_sro_state_free(state);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_sro_readout_state);

[Severity: High]
Does bypassing drm_mode_config_create_state() when readout succeeds leave
disabled CRTCs without a drm_crtc_vblank_reset() call?

On the non-readout path, drm_mode_config_crtc_create_state() resets each
CRTC's vblank state when drm_dev_has_vblank(crtc->dev) is true:

drivers/gpu/drm/drm_mode_config.c:drm_mode_config_crtc_create_state() {
    ...
	if (drm_dev_has_vblank(crtc->dev))
		drm_crtc_vblank_reset(crtc);
}

Because crtc_funcs->atomic_create_state() is side-effect-free and readout
skips drm_mode_config_create_state(), any CRTC that is read out as
inactive (or that falls back to a pristine state when drm.atomic_readout
skips missing readout hooks) is left with vblank->inmodeset =3D=3D 0 and
vblank->refcount =3D=3D 0 after drm_vblank_init().  If userspace issues
DRM_IOCTL_WAIT_VBLANK on that disabled CRTC before a modeset,
drm_vblank_get() transitions refcount from 0 to 1 and invokes
crtc->funcs->enable_vblank() on disabled hardware instead of returning
-EINVAL, and any call to drm_crtc_set_max_vblank_count() before
drm_crtc_vblank_on() will hit drm_WARN_ON(dev, !READ_ONCE(vblank->inmodeset=
)).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D20
