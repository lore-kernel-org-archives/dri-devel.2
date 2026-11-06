Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF9606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrJKodZP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B4610EA40;
	Fri,  6 Nov 2026 13:50:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF8A10EA40
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:50:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEE3D602D4
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2DD1F008A1;
 Fri,  6 Nov 2026 13:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793973034;
 bh=JkYfSlKKafwrZe4qm6jQvfOoPKdmeZ9pgr1is3yH220=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JrJKodZPJMuPwb6SLZzeILrZRjW16xhmKqZSWg99jpWUXe0FO9rzKppq8Fi9LFJxp
 Tusbq0jDMoozn8qPfmfuE/wphWR3APVblvZ1/BDGuvYdS7YssbU+AqFh78+tQSeQwI
 VfvZvuJ3hum1C928scLpsA/e2iQRtn/n9GMbsLk9q3SWPZmU3Canxl6GNIZ+CmID2G
 sLaQkpNG1C8FvTw32AY9lGTBo5fbLrM3jsXySTD8Ao1HYW5EjDbnQN7BrINZwFdfBz
 uJAcf7+Ere5rZBUEI4fKaBk7QHObMlr4c42E7koAm3GmfZ+j2sSbWxscPaeDVFlOnz
 mMMkGK20KRH6w==
Message-ID: <sashiko-outbox-201506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 34/39] drm/tidss: Implement hw_reset
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-34-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-34-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:50:33 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/tidss: dispc_reset_hw() wipes initial config and skips
  irq_mask setup
- [Medium] drm/tidss: unchecked tidss_runtime_get() in dispc_reset_hw()
--

commit a129179ba80db5a92955433675f3f60bbebdd1c5
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: Implement hw_reset

This commit moves the DISPC hardware soft reset out of dispc_init() into a
drm_mode_config_funcs.hw_reset callback and reorders tidss_probe() so that
drm_mode_config_create_initial_state() runs before tidss_irq_install().

> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index b5fb296fddccc..8720403af9ed3 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2931,45 +2931,23 @@ static int dispc_softreset(struct dispc_device *d=
ispc)
>  	return 0;
>  }
> =20
> -static int dispc_init_hw(struct dispc_device *dispc)
> +int dispc_reset_hw(struct dispc_device *dispc)
>  {
> -	struct device *dev =3D dispc->dev;
> +	struct tidss_device *tidss =3D dispc->tidss;
>  	int ret;
> =20
> -	ret =3D pm_runtime_set_active(dev);
> -	if (ret) {
> -		dev_err(dev, "Failed to set DSS PM to active\n");
> -		return ret;
> -	}
> -
> -	ret =3D clk_prepare_enable(dispc->fclk);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable DSS fclk\n");
> -		goto err_runtime_suspend;
> -	}
> +	/*
> +	 * The reset runs from drm_mode_config_create_initial_state(), so
> +	 * after the driver has enabled runtime PM. As
> +	 * pm_runtime_set_active() is only allowed while runtime PM is
> +	 * disabled, rely on the regular runtime PM references to power
> +	 * the device up for the reset instead.
> +	 */
> +	tidss_runtime_get(tidss);
> =20
>  	ret =3D dispc_softreset(dispc);
> -	if (ret)
> -		goto err_clk_disable;
> =20
> -	clk_disable_unprepare(dispc->fclk);
> -	ret =3D pm_runtime_set_suspended(dev);
> -	if (ret) {
> -		dev_err(dev, "Failed to set DSS PM to suspended\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -
> -err_clk_disable:
> -	clk_disable_unprepare(dispc->fclk);
> -
> -err_runtime_suspend:
> -	ret =3D pm_runtime_set_suspended(dev);
> -	if (ret) {
> -		dev_err(dev, "Failed to set DSS PM to suspended\n");
> -		return ret;
> -	}
> +	tidss_runtime_put(tidss);
> =20
>  	return ret;
>  }

[Severity: Medium]
What happens if tidss_runtime_get() fails here?

tidss_runtime_get() wraps pm_runtime_resume_and_get(), which drops its usage
reference on error and leaves the power domain and dispc->fclk disabled.
Continuing on failure accesses unclocked DISPC registers in
dispc_softreset() and then underflows the runtime PM usage count in
tidss_runtime_put().

[ ... ]

> diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/ti=
dss_drv.c
> index e258f656cf03d..409d599bb2ffd 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.c
> +++ b/drivers/gpu/drm/tidss/tidss_drv.c
> @@ -151,6 +151,20 @@ static int tidss_probe(struct platform_device *pdev)
>  		goto err_runtime_suspend;
>  	}
> =20
> +	drm_kms_helper_poll_init(ddev);
> +
> +	/*
> +	 * drm_mode_config_create_initial_state() resets the DISPC when
> +	 * the state readout isn't possible, which also clears the
> +	 * interrupt enable registers. Install the interrupts only once
> +	 * that's been done, so that the reset can't wipe them.
> +	 */
> +	ret =3D drm_mode_config_create_initial_state(ddev);
> +	if (ret) {
> +		dev_err(dev, "failed to create initial state: %d\n", ret);
> +		goto err_runtime_suspend;
> +	}
> +
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		ret =3D irq;
> @@ -164,14 +178,6 @@ static int tidss_probe(struct platform_device *pdev)
>  		goto err_runtime_suspend;
>  	}
> =20
> -	drm_kms_helper_poll_init(ddev);
> -
> -	ret =3D drm_mode_config_create_initial_state(ddev);
> -	if (ret) {
> -		dev_err(dev, "failed to create initial state: %d\n", ret);
> -		goto err_irq_uninstall;
> -	}
> -
>  	ret =3D drm_dev_register(ddev, 0);

[Severity: High]
Does running dispc_reset_hw() via runtime PM and before tidss_irq_install()
wipe the initial DISPC configuration and leave tidss->irq_mask unprogrammed
in hardware?

drivers/gpu/drm/tidss/tidss_dispc.c:dispc_runtime_resume() {
    ...
	dispc_initial_config(dispc);

	dispc->is_enabled =3D true;

	tidss_irq_resume(dispc->tidss);
    ...
}

Previously, dispc_init_hw() ran before pm_runtime_enable() using
pm_runtime_set_active() and clk_prepare_enable() so that the soft reset
completed before dispc_runtime_resume() ever ran (as noted in
bc288a927815 ("drm/tidss: Fix dss reset")).  Now, tidss_runtime_get() in
dispc_reset_hw() triggers dispc_runtime_resume() first, and
dispc_softreset() immediately resets all DISPC registers back to their
defaults, wiping the plane thresholds, preload values, gamma shadow bits,
and J721E DISPC_CONNECTIONS programmed by dispc_initial_config().

In addition, tidss_irq_install() only populates tidss->irq_mask in memory
and relies on tidss_irq_resume() during dispc_runtime_resume() to program
the hardware IRQ enable registers.  Because dispc_runtime_resume() now runs
during drm_mode_config_create_initial_state() while tidss->irq_mask is still
0, and tidss_runtime_put() uses a 1000 ms autosuspend delay (or never
suspends when CONFIG_PM is disabled), the device stays runtime-active across
tidss_irq_install() and the initial modeset in drm_client_setup(), leaving
the hardware unconfigured and frame-done/underflow interrupts disabled in
hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D34
