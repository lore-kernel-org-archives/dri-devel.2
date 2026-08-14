Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACB5C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 12:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798C110E54A;
	Fri, 14 Aug 2026 12:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cAiDpaaj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F6110E54A
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:14:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DA2D7601E0;
 Fri, 14 Aug 2026 12:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C701F000E9;
 Fri, 14 Aug 2026 12:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786709671;
 bh=c+eWTaSm/dtlhB5zoThuxINv8PEDE6g4c2v7e/ILfRU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cAiDpaajeS5s//pJ2A2/ZPV+/TQDJPUB5gaudGTn8UettUDfC7FoD5QHZnS9OnGLH
 BY63wcaoAa4ZoX2inru16hslvTAHkHerRLkpl2GixBd824CNxMRtMSjXvsAiXOOsQD
 eAbOOYEjUKZVOuGo/F6VS+VABPOaQfj2EuA/JvryMgo13JjIeNw2lsMhifUDlIS6Nz
 HqGiiebsKSFKcCr43PNA0txcWLB5cKnKKDekMoa5KxRi1P/APb7fuNwWBtN7cm4gNR
 MfnG1wsayeExKf1xoBls6eCo3DXuF86A1K1Ct+M9Lecur5s39Uj3Iz7fwk8bb/Q7kg
 D6SI8dXhRyz1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: retrain DP link directly
 on cable replug
To: "Yashas D" <y-d@ti.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814120304.887993-3-y-d@ti.com>
References: <20260814120304.887993-1-y-d@ti.com>
 <20260814120304.887993-3-y-d@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 12:14:31 +0000
Message-Id: <20260814121431.72C701F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Concurrent execution of DP link training and hardware programming =
between hpd_work and DRM atomic commits corrupts hardware state.
- [High] Bypassing atomic KMS for link retraining on a cable replug forcefu=
lly applies stale display timings to potentially new monitors.
- [High] Use-After-Free of the driver's private data structure due to uncan=
celed delayed work on driver unbind.

Pre-existing issues:
- [High] The DP lane count is permanently crippled when a display with fewe=
r lanes is connected.
--

--- Patch [2]: [PATCH 2/2] drm/bridge: ti-sn65dsi86: retrain DP link direct=
ly on cable replug ---
commit 87e56572108019fd06745308967a4ab03655f77f
Author: Yashas D <y-d@ti.com>

drm/bridge: ti-sn65dsi86: retrain DP link directly on cable replug

When a cable is replugged while the upstream display pipeline is still
active, the bridge can retrain the DP link and re-enable the video stream
directly from the HPD interrupt work handler.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index d9bd4ef8f0e21..f6f930ca1519d 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
[ ... ]
> +static void ti_sn_bridge_hpd_work(struct work_struct *work)
> +{
> +	struct ti_sn65dsi86 *pdata =3D
> +		container_of(work, struct ti_sn65dsi86, hpd_work);
[ ... ]
> +	ret =3D ti_sn_bridge_link_train(pdata, bpp, NULL);
> +	if (ret)
> +		goto notify;
> +
> +	ti_sn_bridge_set_video_timings(pdata, NULL);
> +	mutex_lock(&pdata->hpd_mutex);
> +	if (pdata->bridge_enabled)
> +		regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG,
> +				   VSTREAM_ENABLE, VSTREAM_ENABLE);
> +	mutex_unlock(&pdata->hpd_mutex);

[Severity: High]
Could this lockless invocation of ti_sn_bridge_link_train() race with a DRM
atomic commit?

If userspace reacts to the hotplug event and issues a modeset,
ti_sn_bridge_atomic_disable() clears the enabled flag but doesn't cancel the
running work. Then ti_sn_bridge_atomic_enable() executes link training
concurrently without locking.

This seems like it could cause both threads to race while programming compl=
ex DP
timing and PLL registers simultaneously, leading to hardware state machine
corruption.

[Severity: High]
Does bypassing atomic KMS for link retraining here forcefully apply stale
display timings to a potentially new monitor?

If a user unplugs the current monitor and connects a different one with a
different EDID and capabilities, forcing the old cached_mode into the
hardware could drive out-of-spec timings to the newly plugged display.

Shouldn't we rely on userspace to read the new EDID via hotplug events and
orchestrate a proper modeset?

[ ... ]
> +static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
> +				       struct drm_atomic_commit *state)
> +{
> +	struct ti_sn65dsi86 *pdata =3D bridge_to_ti_sn65dsi86(bridge);
> +	struct drm_connector *connector;
> +	int max_dp_lanes;
> +	unsigned int bpp;
> +	int ret;
> +
> +	connector =3D drm_atomic_get_new_connector_for_encoder(state,
> +							     bridge->encoder);
> +	if (!connector) {
> +		dev_err_ratelimited(pdata->dev, "Could not get the connector\n");
> +		return;
> +	}
> +
> +	max_dp_lanes =3D ti_sn_get_max_lanes(pdata);
> +	mutex_lock(&pdata->hpd_mutex);
> +	pdata->dp_lanes =3D min(pdata->dp_lanes, max_dp_lanes);

[Severity: High]
This is a pre-existing issue, but does this in-place min() reduction
permanently mutate the driver's maximum allowed lane capability based on the
current peripheral sink?

If a 2-lane monitor is connected, pdata->dp_lanes shrinks to 2. Connecting a
4-lane capable monitor afterward would be artificially limited to 2 lanes
since the original physical board maximum is lost.

[ ... ]
> @@ -2050,6 +2192,7 @@ static int ti_sn65dsi86_probe(struct i2c_client *cl=
ient)
> =20
>  	mutex_init(&pdata->hpd_mutex);
>  	mutex_init(&pdata->comms_mutex);
> +	INIT_WORK(&pdata->hpd_work, ti_sn_bridge_hpd_work);
> =20
>  	pdata->regmap =3D devm_regmap_init_i2c(client,
>  					     &ti_sn65dsi86_regmap_config);

[Severity: High]
Is there a chance this work item can outlive the driver's private data
structure during unbind?

Since the work is initialized here but no devm cleanup action is registered
to cancel it on teardown, if a hardware interrupt schedules the work just
before the driver is unbound, devres will free the pdata memory.

The system workqueue could then execute ti_sn_bridge_hpd_work() and
dereference the freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814120304.8879=
93-1-y-d@ti.com?part=3D2
