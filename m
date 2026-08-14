Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A40FC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8675610E55B;
	Fri, 14 Aug 2026 14:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cJovJqxt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0581110E55B
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:20:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 272B8600C3;
 Fri, 14 Aug 2026 14:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0041F000E9;
 Fri, 14 Aug 2026 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786717218;
 bh=jb0UE+Cov9+NgkyNZ7wadCYkEY6xJ28KmedsY5vIK+M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cJovJqxt6DrM+4JEsjEZxxOlfEQgKuLUtN+tbCjC2S8tzk1xz/KaMlWbTeEg6FRlz
 org+JGLBImxo8uY5yF75tCyOZNu6G7k6Gz6rGM2r6L5O5dLZ6Bs3q7QW59DmQd5MZo
 m0tZvzPgoG2z+H/0EC1+lcuyGz5z2SrP6XryRiuBdCTz1WRA0Q6gMQHVpAH1JfB/SN
 hMuBttFa2PeKFe+YqA+a1zur3lZPBViIysnV68ZYq1BO03RLAsELvjZUG1WlGqUYD8
 vBStBlErgZ5BlcTf1dvEXHoRl7TUsHbHh5/4EnfUTSEIe7tSlqnEMo+1swDeAWLcmD
 BysLuvclLNwog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] drm: of: drm_of_find_panel_or_bridge: prioritize
 the bridge, not the panel
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-bridge-every-panel-v1-3-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-3-19cd5277cc8d@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:20:18 +0000
Message-Id: <20260814142018.AA0041F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Changing the lookup priority from panel to bridge breaks drivers t=
hat use `panel !=3D NULL` checks to apply panel-specific hardware constrain=
ts or initialization logic.
--

--- Patch [3]: [PATCH 03/11] drm: of: drm_of_find_panel_or_bridge: prioriti=
ze the bridge, not the panel ---
commit e0a1351b53c705f02789905fd967720e44e8a076
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm: of: drm_of_find_panel_or_bridge: prioritize the bridge, not the panel

This commit changes drm_of_find_panel_or_bridge() to prioritize returning
a drm_bridge instead of a drm_panel when both are present. This avoids
re-creating a panel_bridge if a panel already automatically creates one.

> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index 8ec352f3df93e..f92f02f9b202a 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -308,14 +308,7 @@ int drm_of_find_panel_or_bridge(const struct device_=
node *np,
>  	if (!remote)
>  		return -ENODEV;
> =20
> -	*panel =3D of_drm_find_panel(remote);
> -	if (!IS_ERR(*panel))
> -		return 0;
> -
> -	*panel =3D NULL;
> -
>  	if (bridge) {
> -		/* No panel found yet, check for a bridge next. */
>  		*bridge =3D of_drm_find_bridge(remote);
>  		if (*bridge)
>  			return 0;

[Severity: High]
Will changing the lookup priority to return a bridge before a panel break
drivers that rely on the panel pointer being non-NULL to apply
hardware-specific logic?

For example, in sun4i_rgb_mode_valid(), if a panel wraps itself in a bridge,
the panel pointer will be NULL, causing valid modes to be rejected:

drivers/gpu/drm/sun4i/sun4i_rgb.c:sun4i_rgb_mode_valid() {
	if (rgb->panel) {
		DRM_DEBUG_DRIVER("RGB panel used, skipping clock rate checks");
		goto out;
	}
	...
}

Similarly in fsl_dcu_create_outputs(), it relies on panel to enforce
hdisplay alignment and custom connector initialization:

drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c:fsl_dcu_create_outputs() {
	if (panel) {
		ret =3D devm_add_action_or_reset(fsl_dev->dev,
					       fsl_dcu_panel_put_action, panel);
		if (ret)
			return ret;

		fsl_dev->connector.panel =3D panel;
		return fsl_dcu_attach_panel(fsl_dev, panel);
	}
	...
}

And tegra_sor_dp_enable() uses the panel pointer to identify eDPs and
misconfigures internal eDP panels as standard DP displays if panel is NULL:

drivers/gpu/drm/tegra/sor.c:tegra_sor_dp_enable() {
	if (output->panel)
		value |=3D SOR_CLK_CNTRL_DP_CLK_SEL_SINGLE_DPCLK;
	else
		value |=3D SOR_CLK_CNTRL_DP_CLK_SEL_DIFF_DPCLK;

	tegra_sor_writel(sor, value, SOR_CLK_CNTRL);
	...
}

Could this cause display initialization to fail on these platforms?

> =20
>  		*bridge =3D NULL;
>  	}
> =20
> +	/* No bridge found yet, check for a panel next. */
> +	*panel =3D of_drm_find_panel(remote);
> +	if (!IS_ERR(*panel))
> +		return 0;
> +
> +	*panel =3D NULL;
> +
>  	return -EPROBE_DEFER;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-bridge=
-every-panel-v1-0-19cd5277cc8d@bootlin.com?part=3D3
