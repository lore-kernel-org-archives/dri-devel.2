Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA9606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWLTWEfl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E1E112077;
	Thu, 29 Oct 2026 08:09:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DE2112096
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:09:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 40008600D1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56911F01825;
 Thu, 29 Oct 2026 08:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793261342;
 bh=6BQxsmbL45forNKyNAjFwt1c/Xf9Vz0WZTP14/Fq1oM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oWLTWEfl6kTZcIXSgmioMCEmqjV+7OAjDwqKPdpP4Ynscl9PgWhaPeP9L7TY4nndf
 iIJjwcOzPloJOhJAfTNettkJ5tbLGLerrzy/N5NmZcLLLmhtJSby2u03gLlw0S+Egb
 xyz2fYljC9DXpkzS/mjyjE5ktNBad12oPuZZqLnrXN8UXYsqHLFH5YvpuLO+akL33s
 1JrHtctdGuGv8wuez73frRvmjZthEdGp98R5BGY1BZ4PKZr4o94Ljmu6QVRDtghYrz
 nooZw4Okogi2zvsSvoq22a3U83QQGRcghyJtvfsmCG1z3QVhjVz8rZJv8qPo0OYXXJ
 3oAUqABWqCLOQ==
Message-ID: <sashiko-outbox-188950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 31/34] drm/tidss: Implement hw_reset
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-31-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-31-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:09:01 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/tidss: moving dispc_reset_hw() to tidss_hw_reset() breaks hard=
ware reset
- [High] drm/tidss: dispc_reset_hw() never called on probe and fails when P=
M enabled
--

commit b4ac51170032bf695c274ab86a54a2de58078be4
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: Implement hw_reset

This commit renames dispc_init_hw() to dispc_reset_hw(), removes its
unconditional call from dispc_init(), and wires it up to
drm_mode_config_funcs.hw_reset via tidss_hw_reset().

> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index 5943a5f254321..fd33edd809770 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2909,7 +2909,7 @@ static int dispc_softreset(struct dispc_device *dis=
pc)
>  	return 0;
>  }
> =20
> -static int dispc_init_hw(struct dispc_device *dispc)
> +int dispc_reset_hw(struct dispc_device *dispc)
>  {
>  	struct device *dev =3D dispc->dev;
>  	int ret;
> @@ -3059,10 +3059,6 @@ int dispc_init(struct tidss_device *tidss)
>  	of_property_read_u32(dispc->dev->of_node, "max-memory-bandwidth",
>  			     &dispc->memory_bandwidth_limit);
> =20
> -	r =3D dispc_init_hw(dispc);
> -	if (r)
> -		return r;
> -
>  	tidss->dispc =3D dispc;
> =20
>  	return 0;

[Severity: High]
Does removing dispc_init_hw() from dispc_init() leave the DISPC hardware
unreset during probe and before tidss_irq_install() registers the interrupt
handler?

In drivers/gpu/drm/tidss/tidss_drv.c, tidss_probe() calls
drm_mode_config_reset(ddev) rather than
drm_mode_config_create_initial_state(ddev):

drivers/gpu/drm/tidss/tidss_drv.c:tidss_probe() {
	...
	ret =3D tidss_irq_install(ddev, irq);
	if (ret) {
		dev_err(dev, "tidss_irq_install failed: %d\n", ret);
		goto err_runtime_suspend;
	}

	drm_kms_helper_poll_init(ddev);

	drm_mode_config_reset(ddev);
	...
}

Because drm_mode_config_reset() in drivers/gpu/drm/drm_mode_config.c only
invokes per-CRTC helper_funcs->hw_reset and does not call
dev->mode_config.funcs->hw_reset(dev) (which is only called by
drm_mode_config_create_initial_state()), tidss_hw_reset() and
dispc_reset_hw() are never called during probe. This also leaves any active
bootloader display or interrupt state unmasked when tidss_irq_install()
requests the IRQ line.

[ ... ]

> diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/ti=
dss_kms.c
> index 70c14c3be10d5..3b97c08c4f714 100644
> --- a/drivers/gpu/drm/tidss/tidss_kms.c
> +++ b/drivers/gpu/drm/tidss/tidss_kms.c
> @@ -116,10 +117,23 @@ static int tidss_atomic_check(struct drm_device *dd=
ev,
>  	return 0;
>  }
> =20
> +static void tidss_hw_reset(struct drm_device *dev)
> +{
> +	struct tidss_device *tidss =3D to_tidss(dev);
> +	int ret;
> +
> +	ret =3D dispc_reset_hw(tidss->dispc);
> +	if (ret)
> +		drm_warn(dev, "Couldn't reset dispc");
> +
> +	drm_mode_config_helper_hw_reset(dev);
> +}
> +
>  static const struct drm_mode_config_funcs mode_config_funcs =3D {
>  	.fb_create =3D drm_gem_fb_create,
>  	.atomic_check =3D tidss_atomic_check,
>  	.atomic_commit =3D drm_atomic_helper_commit,
> +	.hw_reset =3D tidss_hw_reset,
>  };

[Severity: High]
When tidss_hw_reset() is called during mode_config initialization (such as =
via
drm_mode_config_create_initial_state()), won't dispc_reset_hw() fail with
-EAGAIN when CONFIG_PM is enabled, or wipe out programmed register state wh=
en
CONFIG_PM is disabled?

In drivers/gpu/drm/tidss/tidss_drv.c, tidss_probe() enables runtime PM (or
manually calls dispc_runtime_resume() when !CONFIG_PM) before modeset
initialization and reset:

drivers/gpu/drm/tidss/tidss_drv.c:tidss_probe() {
	...
	pm_runtime_enable(dev);

	pm_runtime_set_autosuspend_delay(dev, 1000);
	pm_runtime_use_autosuspend(dev);

#ifndef CONFIG_PM
	/* If we don't have PM, we need to call resume manually */
	dispc_runtime_resume(tidss->dispc);
#endif

	ret =3D tidss_modeset_init(tidss);
	...
}

However, dispc_reset_hw() uses pm_runtime_set_active() and
pm_runtime_set_suspended(), which only work while runtime PM is disabled:

drivers/gpu/drm/tidss/tidss_dispc.c:dispc_reset_hw() {
	struct device *dev =3D dispc->dev;
	int ret;

	ret =3D pm_runtime_set_active(dev);
	if (ret) {
		dev_err(dev, "Failed to set DSS PM to active\n");
		return ret;
	}
	...
}

Once pm_runtime_enable(dev) has been called (so dev->power.disable_depth =
=3D=3D 0
and dev->power.runtime_error =3D=3D 0), __pm_runtime_set_status() in
drivers/base/power/runtime.c rejects pm_runtime_set_active(dev) with -EAGAI=
N:

drivers/base/power/runtime.c:__pm_runtime_set_status() {
	...
	if (dev->power.runtime_error || dev->power.disable_depth)
		dev->power.disable_depth++;
	else
		error =3D -EAGAIN;
	...
}

As a result, under CONFIG_PM=3Dy, dispc_reset_hw() aborts immediately before
enabling dispc->fclk or calling dispc_softreset(). Conversely, under
CONFIG_PM=3Dn, dispc_runtime_resume() and tidss_irq_install() have already
configured the initial registers and interrupt masks before tidss_hw_reset()
runs, so executing dispc_softreset() at that point resets DSS_SYSCONFIG and
wipes out the programmed register and IRQ state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D31
