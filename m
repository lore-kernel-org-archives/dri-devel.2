Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A9DC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68707890EA;
	Fri, 31 Jul 2026 17:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dW5AHyLe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3869F10F365
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 17:33:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB02643A93;
 Fri, 31 Jul 2026 17:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723F41F00ACA;
 Fri, 31 Jul 2026 17:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785519187;
 bh=MQaj+hByQhc6p3JvmgMN8Ui0NxGayLfAfTG6thDyfNI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dW5AHyLeD37Wgb/rJbGsWH8oOL2SBNFSxjeNMvjZt/znYKp0xkdc9Q2ZwDQxKviU1
 OjBJjsFmRO43PZJCiKx+eiHbCVvu9aHPDqLzb3K4XVRSbY4JP3Anr4W0toxYLoembc
 8uxcTk+XZjTNLhJZPH5ft+6WFZllVCAoZhXnsdf7QFSP//n7MCt1jQXEJYbJN8hrV2
 DNszLZ+lqnJGEQlkv8n5y0cpKSBJNCL/zIfUfFdYcEDpvTQskcmO9YrdGpqIj1gwIB
 qoqFoadFh1B52A0Oz+224YeIJpJ7Hz5grLVmdkpi+uV/voxvAIkX6DqDgEmtT7uUKy
 Y9ngc1ClZKiJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/69] drm/display: hdmi: Add HDMI 2.0 scrambling
 management helpers
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-10-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-10-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:33:07 +0000
Message-Id: <20260731173307.723F41F00ACA@smtp.kernel.org>
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
- [High] The SCDC scrambling monitor work item fails to reschedule itself, =
terminating the periodic polling after a single successful check or transie=
nt error.
- [High] Missing NULL check for connector->ddc in drm_connector_hdmi_disabl=
e_scrambling() causes a crash when scrambling is disabled for a connector w=
ithout a DDC bus.
- [High] TOCTOU race condition in drm_connector_hdmi_scdc_work leading to a=
 potential Use-After-Free of the I2C adapter.
- [High] Dead code in drm_connector_hdmi_sync_scdc fails to synchronize wit=
h hardware programming due to an impossible condition.
--

--- Patch [10]: [PATCH v10 10/69] drm/display: hdmi: Add HDMI 2.0 scramblin=
g management helpers ---
commit 3991d28f3f40213e274370d230b6145165dadbee
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: hdmi: Add HDMI 2.0 scrambling management helpers

This commit adds helpers to manage the full lifecycle of HDMI 2.0 SCDC
scrambling on both source and sink sides. It introduces checking if a mode
needs scrambling, enabling/disabling with monitoring, and restoring the
SCDC state on reconnection.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/=
display/drm_hdmi_helper.c
> index 5cb0b033b1713..cfecfef639ad0 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c

[ ... ]

> @@ -426,3 +434,291 @@ drm_hdmi_acr_get_n_cts(unsigned long long tmds_char=
_rate,
>  	*out_cts =3D cts;
>  }
>  EXPORT_SYMBOL(drm_hdmi_acr_get_n_cts);

[ ... ]

> +static int drm_connector_hdmi_try_scrambling_setup(struct drm_connector =
*connector)
> +{
> +	bool done;
> +
> +	done =3D drm_scdc_set_high_tmds_clock_ratio(connector, true);
> +	if (!done)
> +		return -EIO;

[Severity: High]
Does this prevent the SCDC worker from retrying on transient errors?

If drm_scdc_set_high_tmds_clock_ratio() fails, the function returns -EIO
early and skips the schedule_delayed_work() call, preventing any further
monitoring of the scrambling state.

[ ... ]

> +static void drm_connector_hdmi_scdc_work(struct work_struct *work)
> +{
> +	struct drm_connector *connector;
> +	struct drm_connector_hdmi *hdmi;
> +
> +	hdmi =3D container_of(to_delayed_work(work), struct drm_connector_hdmi,
> +			    scdc_work);
> +	connector =3D container_of(hdmi, struct drm_connector, hdmi);
> +
> +	/*
> +	 * The connector, and hence this work item, may outlive the source
> +	 * driver, e.g. when userspace keeps a DRM file descriptor open past
> +	 * unbind. Never poke the DDC bus after the connector got unregistered,
> +	 * as the underlying I2C adapter may already be gone.
> +	 */
> +	if (drm_connector_is_unregistered(connector))
> +		return;

[Severity: High]
Could this lockless check lead to a Use-After-Free of the I2C adapter?

If the worker thread is preempted immediately after this check returns fals=
e,
the driver unbind process could complete and free the I2C adapter. When the
worker resumes, it calls drm_scdc_get_scrambling_status() which accesses the
now-freed connector->ddc.

> +
> +	if (READ_ONCE(connector->hdmi.scrambler_enabled) &&
> +	    !drm_scdc_get_scrambling_status(connector))
> +		drm_connector_hdmi_try_scrambling_setup(connector);

[Severity: High]
Will this work item fail to reschedule itself if the SCDC status is correct?

If drm_scdc_get_scrambling_status() returns true (meaning scrambling is
working), this function simply returns without rescheduling the worker. The
rescheduling only happens inside drm_connector_hdmi_try_scrambling_setup()
on a successful setup, so the periodic monitoring stops after the first
successful check.

> +}

[ ... ]

> +int drm_connector_hdmi_disable_scrambling(struct drm_connector *connecto=
r)
> +{
> +	struct drm_connector_hdmi *hdmi =3D &connector->hdmi;
> +	struct drm_device *dev =3D connector->dev;
> +
> +	if (!READ_ONCE(hdmi->scrambler_enabled))
> +		return 0;
> +
> +	drm_dbg_kms(dev, "Disabling scrambling\n");
> +
> +	WRITE_ONCE(hdmi->scrambler_enabled, false);
> +
> +	/*
> +	 * A driver may force scrambler_enabled at init to trigger a disable
> +	 * at boot (e.g. vc4), bypassing the enable path that sets up the work
> +	 * item. Only cancel it once it has actually been initialized.
> +	 */
> +	if (hdmi->scdc_work_initialized)
> +		cancel_delayed_work_sync(&hdmi->scdc_work);
> +
> +	if (connector->status =3D=3D connector_status_connected &&
> +	    drm_scdc_sink_supports_scrambling(connector)) {
> +		drm_scdc_set_scrambling(connector, false);
> +		drm_scdc_set_high_tmds_clock_ratio(connector, false);

[Severity: High]
Can this cause a NULL pointer dereference if connector->ddc is missing?

If a driver forces hdmi->scrambler_enabled to true at init to trigger a
disable at boot, and the connector has no DDC bus (connector->ddc is NULL),
drm_scdc_set_scrambling() will unconditionally dereference the NULL DDC
adapter. The enable path correctly checks for connector->ddc, but the disab=
le
path does not.

> +	}
> +
> +	return hdmi->funcs->scrambler_disable(connector);
> +}

[ ... ]

> +int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool p=
lugged,
> +				 struct drm_modeset_acquire_ctx *ctx)
> +{
> +	struct drm_connector_hdmi *hdmi =3D &connector->hdmi;
> +	struct drm_device *dev =3D connector->dev;
> +	struct drm_connector_state *conn_state;
> +	struct drm_crtc *crtc;
> +	u8 config;
> +	int ret;
> +
> +	if (!connector || !plugged || !ctx)
> +		return 0;

[ ... ]

> +	crtc =3D conn_state->crtc;
> +	if (!crtc)
> +		return 0;
> +
> +	ret =3D drm_modeset_lock(&crtc->mutex, ctx);
> +	if (ret)
> +		return ret;
> +
> +	if (!crtc->state || !crtc->state->active)
> +		return 0;
> +
> +	if (!connector->ddc || !drm_scdc_sink_supports_scrambling(connector))
> +		return 0;
> +
> +	if (conn_state->commit &&
> +	    !try_wait_for_completion(&conn_state->commit->hw_done))

[Severity: High]
Is this wait condition dead code?

Earlier in the function, it verifies that crtc is not NULL (if (!crtc)
return 0;). According to the struct drm_connector_state documentation, the
commit field is only set when crtc is NULL. Since crtc is guaranteed to be
non-NULL here, conn_state->commit will always be NULL, making this check
impossible to hit. Consequently, the function proceeds to perform SCDC I2C
reads concurrently with active hardware programming.

> +		return 0;
> +
> +	ret =3D drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D10
