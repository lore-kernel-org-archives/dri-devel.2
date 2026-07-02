Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643B6C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52E410F43F;
	Thu,  2 Jul 2026 15:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QjVqHHqy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F096210F43F
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:13:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E331601C6;
 Thu,  2 Jul 2026 15:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E286F1F000E9;
 Thu,  2 Jul 2026 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783005185;
 bh=QWtEhBNlVU1TTnwCgwDWQ9MeEzmT6op8hGgRZtwULtw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QjVqHHqyGb8ZNrfXn6VeTcDMWtz3thdWXSmaLB6kPneotg3RPno7/R+O6MkXWxtXd
 0hJfbLaHCj2jS5fIjimJWM99Rlf4F+Xc+ukLHFNXyfpcwCDgphBVi6HwGxpzCSZAa3
 OYgO46hQ486sc6JdLcQCVNenU2gXXwzvK/NI0DhXclUsTLdm9HxodP4/NF+YziVoRt
 KdEKVnubZ13vqliEA/INHbAdXngu/iKYbvSo/vxxTxuAiRfvodJUYfDcARhGj+Brj7
 VgkM+MGLuQ1Api93S0tGywtOOuK1yppdiZDhX9M91U2Qir6hiVIE6NjG58D/5118UR
 2/Zb+MLB38uEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/39] drm/display: hdmi: Add HDMI 2.0 scrambling
 management helpers
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-7-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-7-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:13:04 +0000
Message-Id: <20260702151304.E286F1F000E9@smtp.kernel.org>
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
- [High] The `scdc_work` delayed work item is initialized but never explici=
tly canceled during connector cleanup, risking a Use-After-Free.
- [High] The SCDC configuration helpers attempt to execute I2C transfers wi=
thout verifying that `connector->ddc` is not NULL, leading to a NULL pointe=
r dereference.
- [High] The newly added HDMI scrambling helpers invoke sleeping functions =
in atomic context.
- [Medium] The SCDC scrambling monitor delayed work fails to reschedule its=
elf under normal conditions or upon recovery failure, breaking the intended=
 periodic polling.
--

commit 8b2652a7b68d13a84c5a135061f33fe6fdd00be1
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: hdmi: Add HDMI 2.0 scrambling management helpers

Add helpers to manage the full lifecycle of HDMI 2.0 SCDC scrambling on
both source and sink sides:

- drm_hdmi_mode_needs_scrambling(): checks whether a mode, bits per
  component and output format combination requires scrambling, which is
  needed when the resulting TMDS character rate exceeds the HDMI 1.3
  maximum of 340 MHz

- drm_connector_hdmi_enable_scrambling(): configures SCDC scrambling and
  high TMDS clock ratio and starts a periodic work item that monitors
  the sink's SCDC scrambling status, retrying setup when the sink loses
  state

- drm_connector_hdmi_disable_scrambling(): tears down scrambling on both
  sides and cancels the monitoring work

- drm_connector_hdmi_sync_scdc(): triggers a CRTC reset on reconnection
  to restore SCDC state lost during sink disconnects within an active
  display pipeline

> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/=
display/drm_hdmi_helper.c
> index 5cb0b033b1713..7c96cccf683d4 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
[ ... ]
> +static int drm_scdc_try_scrambling_setup(struct drm_connector *connector)
> +{
> +	bool done;
> +
> +	done =3D drm_scdc_set_high_tmds_clock_ratio(connector, true);
> +	if (!done)
> +		return -EIO;
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
> +static void drm_scdc_monitor_scrambler(struct drm_connector *connector)
> +{
> +	if (READ_ONCE(connector->hdmi.scrambler_enabled) &&
> +	    !drm_scdc_get_scrambling_status(connector))
> +		drm_scdc_try_scrambling_setup(connector);
> +}

[Severity: Medium]
Does this periodic monitoring loop stop unintentionally?

If drm_scdc_get_scrambling_status() returns true to indicate normal status,
or if drm_scdc_try_scrambling_setup() fails and returns early without
rescheduling, the delayed work is never scheduled again.

This appears to break the intended periodic polling loop in both the
success and persistent-failure paths.

[Severity: High]
Is the scdc_work delayed work item explicitly cancelled when the connector
is destroyed?

If a connector is destroyed abruptly while the work is pending, it seems
drm_connector_cleanup() will clear the connector structure using memset
without first calling cancel_delayed_work_sync(&connector->hdmi.scdc_work).

Could this leave a corrupted entry in the timer list, leading to a panic
when the timer fires?

[ ... ]
> +int drm_connector_hdmi_enable_scrambling(struct drm_connector *connector,
> +					 const struct drm_connector_state *conn_state)
> +{
> +	struct drm_connector_hdmi *hdmi =3D &connector->hdmi;
> +	struct drm_device *dev =3D connector->dev;
> +	int ret;
> +
> +	if (!conn_state)
> +		return -EINVAL;
> +
> +	if (!conn_state->hdmi.scrambler_needed)
> +		return 0;
> +
> +	if (!hdmi->scrambler_supported) {
> +		drm_dbg_kms(dev, "Source doesn't support scrambling.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!drm_scdc_sink_supports_scrambling(connector)) {
> +		drm_dbg_kms(dev, "Sink doesn't support scrambling.\n");
> +		return -EINVAL;
> +	}

[Severity: High]
Is it possible for connector->ddc to be NULL here?

If an EDID advertising SCDC is forced on a connector that physically lacks
an I2C DDC bus, drm_scdc_sink_supports_scrambling() might pass because it
only checks the EDID capabilities.

This would lead to a NULL pointer dereference when I2C transfers are
attempted later in the function.

> +
> +	drm_dbg_kms(dev, "Enabling scrambling\n");
> +
> +	hdmi->scdc_cb =3D drm_scdc_monitor_scrambler;
> +	WRITE_ONCE(hdmi->scrambler_enabled, true);
> +
> +	ret =3D drm_scdc_try_scrambling_setup(connector);
> +	if (!ret)
> +		ret =3D hdmi->funcs->scrambler_enable(connector);
> +
> +	if (ret) {
> +		WRITE_ONCE(hdmi->scrambler_enabled, false);
> +		cancel_delayed_work_sync(&hdmi->scdc_work);

[Severity: High]
Are sleeping functions being called from an atomic context here?

These scrambling helpers appear to be invoked from encoder and bridge
atomic enable/disable paths where sleeping is strictly forbidden.

However, drm_scdc_try_scrambling_setup() indirectly uses usleep_range(),
and cancel_delayed_work_sync() can also sleep.

Could this cause deadlocks or system instability during modesets?

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
> +	cancel_delayed_work_sync(&hdmi->scdc_work);

[Severity: High]
Could this cancel_delayed_work_sync() call sleep in an atomic disable path?

Like the enable path, this disable helper uses a synchronization function
that can sleep. This violates the requirement that atomic disable callbacks
must not sleep.

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
[ ... ]
> +	if (!drm_scdc_sink_supports_scrambling(connector))
> +		return 0;
> +
> +	if (conn_state->commit &&
> +	    !try_wait_for_completion(&conn_state->commit->hw_done))
> +		return 0;
> +
> +	ret =3D drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);

[Severity: High]
Does this code need to verify connector->ddc before using it?

Similar to the enable path, if the connector lacks a physical I2C bus but
SCDC is supported by the EDID, reading from connector->ddc here without
a NULL check will result in a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D7
