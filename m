Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA77606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdNnNdVw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A7610F3AF;
	Tue,  3 Nov 2026 07:03:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BEA410F3B6
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:03:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 45F8760008;
 Tue,  3 Nov 2026 07:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1771F000C1;
 Tue,  3 Nov 2026 07:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793689411;
 bh=SUjNy9SR7ua9Vo77AP/voSXiWp6NltOgZNiX3xs8C+Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TdNnNdVw/8LQro+nLdeOdi0pqsiAmo3nzo36Udw+M+aRplUPq10oqvA1jm/2FNvlk
 bTNNaZ1MGhOPJ/cWSmpQcdcmESleH4tTDTWpBOX1DA/1iB28fQsAQ7fQWzuqnLs5ZO
 CKesNu4o+udmvThxbe/yPxjXgm7slLFe91499AUOmGK1iRnI53Jt3VOXQjVRQ1LkkD
 j4D88t89Y3HsSs85StiIf4Z/xNN3n1MjOpX/c6RJ/6YFM6q7W4qu0c6KSIRqP0yHtQ
 PsEoZR7CR7bIL3xPVWpM65sWvKzV0FoVdVN3sxZEUnQcTqXcBZmwagDUeRAC1C522M
 GvAboO98ioClg==
Message-ID: <sashiko-outbox-194690@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 16/16] drm/imx: dc: Use prefetch engine
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261103-imx8-dc-prefetch-v9-16-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
 <20261103-imx8-dc-prefetch-v9-16-3b985e7636e2@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:03:30 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/imx: dc: missing use_raw_spinlock in dc_prg_regmap_config
- [Medium] drm/imx: dc: premature source checks in dc_crtc_disable_at_boot()
- [Medium] drm/imx: dc: unbalanced DPRC and PRG runtime PM in dc_crtc_disab=
le_at_boot()
--

commit a0700a3c30143af37a2ae48e1eba7fde342cf2a1
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc: Use prefetch engine

This commit configures and disables prefetch engines (DPR channel and PRGs)
alongside FetchUnits during atomic commits and boot-time cleanup, adapts
FetchUnit burst size and stride fixups for PRG requirements, and enables
use_raw_spinlock in the ExtDst PIXENGCFG regmap configuration.

> diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc=
-crtc.c
> index d03246036d4a7..55c198db9644c 100644
> --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c

[ ... ]

> @@ -381,16 +464,71 @@ int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
>  		goto out1;
>  	}
> =20
> +	crtc_is_enabled =3D dc_drv_crtc_is_enabled(dc_drm, drm_crtc_index(crtc)=
);
> +
> +	ret =3D pm_runtime_resume_and_get(dc_drm->pe->dev);
> +	if (ret) {
> +		dc_crtc_err(crtc, "failed to get DC pixel engine RPM: %d\n",
> +			    ret);
> +		goto out2;
> +	}
> +
>  	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
>  		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
> -		goto out2;
> +		goto out3;
>  	}
> =20
> -	dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
> -	__dc_crtc_disable_fg(crtc);
> +	ret =3D dc_ed_pec_src_sel_get(dc_crtc->ed_cont, &ed_src);
> +	if (ret || ed_src =3D=3D LINK_ID_NONE) {
> +		dc_crtc_err(crtc, "failed to get content ExtDst's source\n");
> +		if (ret =3D=3D 0)
> +			ret =3D -EINVAL;
> +		goto out3;
> +	}
> =20
> -	if (!dc_drv_crtc_is_enabled(dc_drm, drm_crtc_index(crtc)))
> -		goto out2;
> +	if (ed_src =3D=3D LINK_ID_CONSTFRAME0 || ed_src =3D=3D LINK_ID_CONSTFRA=
ME1)
> +		goto disable;
> +
> +	ret =3D dc_lb_pec_dynamic_sec_sel_get(dc_plane->lb, &lb_sec);
> +	if (ret || lb_sec =3D=3D LINK_ID_NONE) {
> +		dc_crtc_err(crtc,
> +			    "failed to get primary plane LayerBlend secondary source\n");
> +		if (ret =3D=3D 0)
> +			ret =3D -EINVAL;
> +		goto out3;
> +	}
> +
> +	/*
> +	 * If CRTC was enabled by bootloader instead of this driver, we don't
> +	 * know if DPRC was enabled or not.  In this case, enforcing DPRC
> +	 * disablement potentially causes imbalanced clock enable count for
> +	 * DPRC and PRG clocks.  So, we presume bootloader doesn't bother to
> +	 * use prefetch engines.
> +	 */
> +	if (crtc_is_enabled)
> +		disable_dprc =3D true;

[Severity: Medium]
As reported by Sashiko on v8 [1], when the display was enabled by the
bootloader rather than a previous instance of this driver
(!crtc_is_enabled), disable_dprc is never set and ed_src and lb_sec are
not used anywhere else in dc_crtc_disable_at_boot().

However, dc_ed_pec_src_sel_get() and dc_lb_pec_dynamic_sec_sel_get() are
called unconditionally before checking crtc_is_enabled. If the bootloader
enabled the display using only the safety stream (leaving ed_cont at its
reset state), using LayerBlend in primary-only mode, or using a different
LayerBlend or FetchUnit not in sec_sels[], dc_crtc_disable_at_boot()
jumps to out3 without disabling FrameGen and returns an error that aborts
driver probe in dc_drm_bind():

drivers/gpu/drm/imx/dc/dc-drv.c:dc_drm_bind()
	drm_for_each_crtc(crtc, drm) {
		ret =3D dc_crtc_disable_at_boot(crtc);
		if (ret) {
			dev_err(dev, "failed to disable CRTC%u at boot: %d\n",
				drm_crtc_index(crtc), ret);
			goto err;
		}
	}

Should dc_crtc_disable_at_boot() check !crtc_is_enabled and jump to
disable before querying ed_src and lb_sec?

> +
> +disable:
> +	enable_irq(dc_crtc->irq_dec_seqcomplete);
> +
> +	if (disable_dprc) {
> +		dc_crtc_dbg(crtc, "disabling FrameGen along with DPRC REPEAT_EN at boo=
t\n");
> +		dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
> +	} else {
> +		dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
> +		dc_fg_disable(dc_crtc->fg);
> +	}
> +
> +	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
> +	disable_irq(dc_crtc->irq_dec_seqcomplete);
> +
> +	if (!crtc_is_enabled)
> +		goto out3;
> +
> +	if (disable_dprc) {
> +		dc_crtc_dbg(crtc, "disabling DPRC at boot\n");
> +		dc_dprc_disable_at_boot(dc_plane->fu->dprc);
> +	}

[Severity: Medium]
When a plane is enabled, dc_dprc_configure() and dc_prg_configure() call
pm_runtime_resume_and_get() on dprc->dev and prg->dev. If the driver is
unbound or unloaded while the plane is active, dc_drm_unbind() calls
drm_dev_unplug() before drm_atomic_helper_shutdown(), so
dc_crtc_atomic_disable() exits early at drm_dev_enter() without calling
dc_dprc_disable().

Unlike de->dev and pe->dev, which are child devices created by
devm_of_platform_populate() in dc_probe() and recreated on rebind,
dprc->dev and prg->dev are top-level platform devices whose struct device
and power.usage_count persist across unbind/rebind and module reload.

When dc_crtc_disable_at_boot() subsequently runs on rebind or module
reload, dc_dprc_disable_at_boot() and dc_prg_disable_at_boot() disable the
clocks directly without balancing runtime PM:

drivers/gpu/drm/imx/dc/dc-dprc.c:
void dc_dprc_disable_at_boot(struct dc_dprc *dprc)
{
	dc_prg_disable_at_boot(dprc->prg);

	clk_bulk_disable_unprepare(dprc->num_clks, dprc->clks);

	dev_dbg(dprc->dev, "disable at boot\n");
}

drivers/gpu/drm/imx/dc/dc-prg.c:
void dc_prg_disable_at_boot(struct dc_prg *prg)
{
	regmap_write(prg->reg, PRG_CTRL, BYPASS);

	clk_bulk_disable_unprepare(prg->num_clks, prg->clks);
}

Won't this leave dprc->dev and prg->dev with an elevated runtime PM
usage_count after module reload (preventing runtime suspend on future
plane disablement), or leave them marked active with their clocks disabled
across a sysfs unbind/rebind of the master device so that the next
dc_dprc_configure() accesses unclocked registers?

> diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/d=
c-plane.c
> index 42c0a46281cb1..ba20d35355155 100644
> --- a/drivers/gpu/drm/imx/dc/dc-plane.c
> +++ b/drivers/gpu/drm/imx/dc/dc-plane.c

[ ... ]

> @@ -193,6 +220,11 @@ dc_plane_atomic_update(struct drm_plane *plane, stru=
ct drm_atomic_commit *state)
> =20
>  	dc_plane_dbg(plane, "uses %s\n", fu_ops->get_name(fu));
> =20
> +	prefetch_start =3D needs_modeset || !old_state->fb ||
> +			 (!old_state->visible && new_state->visible);
> +	dc_dprc_configure(fu->dprc, new_state->crtc->index, src_w, src_h,
> +			  fb->pitches[0], fb->format, baseaddr, prefetch_start);

[Severity: High]
When dc_plane_atomic_update() calls dc_dprc_configure() with
prefetch_start set to true, dc_dprc_enable_ctrl_done_irq() unmasks the
control done interrupt on dprc->wrap_irq.

In dc_dprc_probe(), dprc->wrap_irq is requested with IRQF_NO_THREAD, so
dc_dprc_wrap_irq_handler() runs in hardirq context and calls into PRG
regmap:

dc_dprc_wrap_irq_handler()
  -> dc_dprc_ctrl_done_handle()
    -> dc_prg_shadow_enable()
      -> regmap_write(prg->reg, PRG_CTRL + SET, SHADOW_EN)

However, dc_prg_regmap_config in drivers/gpu/drm/imx/dc/dc-prg.c does not
set use_raw_spinlock:

static const struct regmap_config dc_prg_regmap_config =3D {
	.reg_bits =3D 32,
	.reg_stride =3D 4,
	.val_bits =3D 32,
	.fast_io =3D true,
	.max_register =3D PRG_WIDTH + TOG,
};

Without .use_raw_spinlock =3D true in dc_prg_regmap_config, won't
regmap_write() on prg->reg acquire a sleeping spinlock_t inside hardirq
context on preempt-rt kernels and trigger an invalid wait context warning
under lockdep?

[1] https://lore.kernel.org/r/20261030-imx8-dc-prefetch-v8-15-c4f81afd4533@=
nxp.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-imx8-dc-pr=
efetch-v9-0-3b985e7636e2@nxp.com?part=3D16
