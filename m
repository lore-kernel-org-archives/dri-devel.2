Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EE0C44536
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E513F10EF54;
	Thu, 23 Jul 2026 01:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RBuG6G1S";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A9A10EF53
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:51:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0FAF443F69;
 Thu, 23 Jul 2026 01:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD331F000E9;
 Thu, 23 Jul 2026 01:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771465;
 bh=VI7Pe0gCcr4/+6aJCf5jYtL+K7K8fcvjJNtiitTaYUM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RBuG6G1Sja6I1BS07tZuqPIP1DFzc3udjcC3bSAowPG2Ql2UXPz5R40+4V8Gd0aGq
 3acQlmpJqB5Ua919FW8M/aa7cgMXqPmd/iV/X8fXYBJhDsiKwoaWgGZ/VjU0Ha72B1
 aSYu/pqhyAs11LrlF15Hi+K5Ip04QrW3Nh/BkCEU4ixSLqa4Ucsy2G3FJKCmPFu9OB
 RO+PH+NNM/JKbo/LmgTN1kEIxKwKUQFmgxjtFkDAlBYphtKq+PollnRznfYHDT7EiJ
 /Dg9Rk8IVDdJgTosXe1EchUS22pP7w7qCCf1KU11UGRLQfLSYVGZ7Qak04jWNNzWsG
 n4J8/bN/qTIOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/61] drm/display: hdmi: Add HDMI 2.0 scrambling
 management helpers
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-8-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-8-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:51:05 +0000
Message-Id: <20260723015105.AFD331F000E9@smtp.kernel.org>
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
- [High] SCDC scrambling monitor work item stops polling permanently after =
first success or I2C failure.
- [High] Incorrect pending commit check in drm_connector_hdmi_sync_scdc() b=
ypasses synchronization and allows concurrent hardware programming.
- [High] Sleeping functions called from atomic context in SCDC scrambling l=
ifecycle helpers.
- [Medium] The drm_connector_hdmi_sync_scdc() function is dead code and bre=
aks the automatic SCDC sync feature.
--

--- Patch [8]: [PATCH v9 08/61] drm/display: hdmi: Add HDMI 2.0 scrambling =
management helpers ---
commit ef23d36fe9814f6ecd453af5cfc123e83ec840f5
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: hdmi: Add HDMI 2.0 scrambling management helpers

Add helpers to manage the full lifecycle of HDMI 2.0 SCDC scrambling on
both source and sink sides.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/=
display/drm_hdmi_helper.c
> index 5cb0b033b1713..b9be0a2e833ad 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
[ ... ]
> +static int drm_connector_hdmi_try_scrambling_setup(struct drm_connector =
*connector)
> +{
> +	bool done;
> +
> +	done =3D drm_scdc_set_high_tmds_clock_ratio(connector, true);

[Severity: High]
Does this code sleep in atomic context? drm_scdc_set_high_tmds_clock_ratio()
internally calls usleep_range(1000, 2000). If this is called from atomic
modesetting callbacks (like encoder enable), it will violate the atomic
context constraint.

> +	if (!done)
> +		return -EIO;

[Severity: High]
If an I2C error occurs here, the function returns early without rescheduling
the work. Will this cause the polling to stop permanently upon a transient
failure?

> +
> +	done =3D drm_scdc_set_scrambling(connector, true);
> +	if (!done)
> +		return -EIO;
> +
> +	if (READ_ONCE(connector->hdmi.scrambler_enabled))
> +		schedule_delayed_work(&connector->hdmi.scdc_work,
> +				      msecs_to_jiffies(DRM_HDMI_SCDC_POLL_DELAY_MS));
> +
> +	return 0;
> +}
> +
> +static void drm_connector_hdmi_scdc_work(struct work_struct *work)
> +{
> +	struct drm_connector *connector;
> +	struct drm_connector_hdmi *hdmi;
> +
> +	hdmi =3D container_of(to_delayed_work(work), struct drm_connector_hdmi,
> +			    scdc_work);
> +	connector =3D container_of(hdmi, struct drm_connector, hdmi);
> +
> +	if (READ_ONCE(connector->hdmi.scrambler_enabled) &&
> +	    !drm_scdc_get_scrambling_status(connector))
> +		drm_connector_hdmi_try_scrambling_setup(connector);

[Severity: High]
If the SCDC status is correct (!drm_scdc_get_scrambling_status() is false),
the delayed work item is not rescheduled. Does this mean the periodic monit=
or
will only run once and then stop tracking the SCDC status permanently?

> +}
[ ... ]
> +int drm_connector_hdmi_disable_scrambling(struct drm_connector *connecto=
r)
> +{
[ ... ]
> +	/*
> +	 * A driver may force scrambler_enabled at init to trigger a disable
> +	 * at boot (e.g. vc4), bypassing the enable path that sets up the work
> +	 * item. Only cancel it once it has actually been initialized.
> +	 */
> +	if (hdmi->scdc_work_initialized)
> +		cancel_delayed_work_sync(&hdmi->scdc_work);

[Severity: High]
Could this cause a sleep in atomic context? cancel_delayed_work_sync() is a
blocking function. If this disable path is executed during an atomic commit,
it will violate atomic context constraints.

[ ... ]
> + * The typical solution for this is to trigger an empty modeset in
> + * drm_connector_helper_funcs.detect_ctx(), which is what this helper do=
es
> + * by triggering a CRTC reset on reconnection.
> + *
> + * When making use of the HDMI connector framework, this is automatically
> + * triggered via drm_atomic_helper_connector_hdmi_hotplug().
> + *
> + * Returns:
> + * Zero on success, an error code otherwise, including -EDEADLK.
> + */
> +int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool p=
lugged,
> +				 struct drm_modeset_acquire_ctx *ctx)
> +{

[Severity: Medium]
Is this function actually hooked up? It appears to be dead code that is nev=
er
called from drm_atomic_helper_connector_hdmi_hotplug() as claimed in the
commit message and comments, which would mean the automatic SCDC sync featu=
re
is not functional.

> +	struct drm_connector_hdmi *hdmi =3D &connector->hdmi;
[ ... ]
> +	conn_state =3D connector->state;
> +	if (!conn_state)
> +		return 0;
> +
> +	crtc =3D connector->state->crtc;
> +	if (!crtc)
> +		return 0;
[ ... ]
> +	if (conn_state->commit &&
> +	    !try_wait_for_completion(&conn_state->commit->hw_done))
> +		return 0;

[Severity: High]
Does this check the wrong commit pointer? According to the DRM core
documentation, conn_state->commit is only set when crtc is NULL. However,
earlier in this function, it explicitly returns if crtc is NULL.

This means conn_state->commit is guaranteed to be NULL here, which bypasses
synchronization and could allow concurrent hardware programming while a
non-blocking commit is active. Should this be checking crtc->state->commit
instead?

> +
> +	ret =3D drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D8
