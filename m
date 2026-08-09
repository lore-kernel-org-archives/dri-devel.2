Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2904DC5AE49
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 13:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB4610E57C;
	Sun,  9 Aug 2026 13:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e785woHM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E26510E57C
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 13:35:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5372060008;
 Sun,  9 Aug 2026 13:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0581F000E9;
 Sun,  9 Aug 2026 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786282543;
 bh=ugjGOriiU0Y2ChGNDbvl2kZUdWr9sAEtGxiFxyxChyg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e785woHMjnNjaj5kZw3qn4bBB48fUKAC855tvn7aeWigr/z3Gp5VELgEQTE7DJoXH
 qfT12sLiYpgZrZmnE7vDBNAqD82oiJD9OsT8032KcEvEt7Ewut59pfqdhzkQZDr+KP
 YW65vm8cMJmBVP4zy9pPUnqiH3vjuAG2Gus3P/L7KL8YE3Bx8w1tlfplQhcCl+YTDR
 SD9FAeYH0K0D0q4n159U8r1JnzOjm8T2FTJ02Y8jGZwDncKcz7GXRVlJefyF6/8mBV
 m0XSTlhGKxHP5b3+AfziDpQUiK9kB6xhAIsRK2PjacmtbS9p5j2iloQD+qEGf9ZZ9H
 TiW39iG4lgPaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/17] drm/spacemit: add Saturn DPU DRM device driver
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: linux-phy@lists.infradead.org, vkoul@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org, olteanv@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260809-k3-display-v2-11-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-11-327d7910bf71@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 13:35:41 +0000
Message-Id: <20260809133542.3E0581F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The driver calls sleeping delay functions (`usleep_range()`) from =
within CRTC atomic enable and disable callbacks, violating DRM atomic conte=
xt rules.
- [Medium] Setting drm_mode_config.max_width and max_height to a single CRT=
C's maximum resolution breaks multi-monitor support.
- [Medium] Missing error check after `drm_of_component_match_add()` inside =
the OF component loop causes device node reference leaks on subsequent iter=
ations.
--

--- Patch [11]: [PATCH v2 11/17] drm/spacemit: add Saturn DPU DRM device dr=
iver ---
commit cbbaf4042bf32b29313b65d5c670b16c44e0fb03
Author: Cody Kang <codykang.hk@gmail.com>

drm/spacemit: add Saturn DPU DRM device driver

Add the DRM device for the SpacemiT K3 Saturn display processing unit
and hook the driver up to the build. The SoC has two DPU instances;
each drives one CRTC that scans out a single primary plane in linear
RGB at up to 3840x2160@60 and feeds a downstream DP/eDP controller
over an OF-graph endpoint. Buffers use drm_gem_shmem_helper. The
AFBC/compressed decode path is not exposed and writeback is not
implemented.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_drm.c b/drivers/gpu/drm/sp=
acemit/spacemit_drm.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_drm.c

[ ... ]

> +int spacemit_drm_mode_config_init(struct drm_device *drm)
> +{
> +	int ret;
> +
> +	ret =3D drmm_mode_config_init(drm);
> +	if (ret)
> +		return ret;
> +
> +	drm->mode_config.min_width =3D 1;
> +	drm->mode_config.min_height =3D 1;
> +	/* K3 user manual: each DPU scans out at most 3840x2160@60 */
> +	drm->mode_config.max_width =3D 3840;
> +	drm->mode_config.max_height =3D 2160;

[Severity: Medium]
Will setting max_width and max_height to a single CRTC's maximum resolution
break multi-monitor support?

These values dictate the maximum dimensional bounds for the entire DRM
framebuffer, not just a single CRTC's scanout. Windowing systems allocating
a single large framebuffer to span all connected monitors might fail if they
attempt to configure side-by-side dual monitors exceeding 3840x2160.

> +
> +	drm->mode_config.funcs =3D &spacemit_drm_mode_config_funcs;
> +	drm->mode_config.helper_private =3D &spacemit_drm_mode_config_helper;
> +
> +	return 0;
> +}

[ ... ]

> +int spacemit_drm_of_component_probe(struct device *dev)
> +{
> +	struct device_node *ports, *port, *ep;
> +	struct device_node *remote;
> +	struct component_match *match =3D NULL;

[ ... ]

> +	for_each_child_of_node(ports, port) {
> +		if (!of_node_name_eq(port, "port"))
> +			continue;
> +		for_each_child_of_node(port, ep) {
> +			if (!of_node_name_eq(ep, "endpoint"))
> +				continue;
> +			remote =3D of_graph_get_remote_port_parent(ep);
> +			if (!remote)
> +				continue;
> +			if (of_device_is_available(remote))
> +				drm_of_component_match_add(dev, &match,
> +							   compare_of, remote);

[Severity: Medium]
Could this loop leak an OF device node reference on subsequent iterations
if drm_of_component_match_add() fails and returns an error pointer?

If drm_of_component_match_add() encounters a memory allocation failure, it
sets the match pointer to ERR_PTR(-ENOMEM). Because this loop does not
check IS_ERR(match) to break out early, subsequent iterations will pass the
error pointer back into the function.

Internally, drm_of_component_match_add() unconditionally calls of_node_get()
to increment the reference count, but component_match_add_release()
immediately returns without registering a release callback when the match
pointer is already an error.

> +			of_node_put(remote);
> +		}
> +	}

[ ... ]

> diff --git a/drivers/gpu/drm/spacemit/spacemit_crtc.c b/drivers/gpu/drm/s=
pacemit/spacemit_crtc.c
> --- a/drivers/gpu/drm/spacemit/spacemit_crtc.c
> +++ b/drivers/gpu/drm/spacemit/spacemit_crtc.c

[ ... ]

>  static void spacemit_crtc_atomic_enable(struct drm_crtc *crtc,
>  					struct drm_atomic_commit *old_state)
>  {
>  	struct spacemit_crtc *a_crtc =3D to_spacemit_crtc(crtc);
>  	struct spacemit_drm_private *priv =3D crtc->dev->dev_private;
>  	int idx;
>  	int ret;
>=20
>  	if (!drm_dev_enter(crtc->dev, &idx))
>  		return;
>=20
>  	trace_spacemit_crtc_atomic_enable(a_crtc->dev_id);
>=20
>  	/*
>  	 * U-Boot leaves its boot-logo pipeline running. Hard-stop it with the
>  	 * resets alone; the clocks are not ours to gate until we have enabled
>  	 * them.
>  	 */
>  	if (unlikely(a_crtc->first_modeset)) {
>  		ret =3D reset_control_bulk_assert(ARRAY_SIZE(priv->pipe_resets),
>  						priv->pipe_resets);
>  		if (ret)
>  			dev_warn(a_crtc->dev,
>  				 "failed to assert resets: %d\n", ret);
>  		usleep_range(10000, 20000);

[Severity: High]
Does this code call a sleeping function from within atomic context?

CRTC atomic enable callbacks execute in atomic context, where sleeping is
strictly forbidden. Calling usleep_range() here can cause kernel warnings,
system instability, and potential deadlocks.

>  		a_crtc->first_modeset =3D false;
>  	}

[ ... ]

>  static int dpu_pm_suspend(struct device *dev)
>  {
>  	struct spacemit_drm_private *priv =3D dev_get_drvdata(dev);
>  	struct spacemit_crtc *a_crtc =3D priv->a_crtc;
>  	int ret;
>=20
>  	/*
>  	 * Assert before gating: a reset asserted into an already-gated block
>  	 * has no clock edges to propagate on and leaves the register file
>  	 * untouched.
>  	 */
>  	ret =3D reset_control_bulk_assert(ARRAY_SIZE(priv->pipe_resets),
>  					priv->pipe_resets);
>  	if (ret)
>  		dev_warn(dev, "failed to assert resets: %d\n", ret);
>  	usleep_range(10000, 20000);

[Severity: High]
Is this sleeping function also reached from atomic context?

Because dpu_pm_suspend() is called during CRTC atomic disable (via
spacemit_crtc_atomic_disable()), this usleep_range() call also occurs in an
atomic context where sleeping is forbidden.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-k3-display=
-v2-0-327d7910bf71@gmail.com?part=3D11
