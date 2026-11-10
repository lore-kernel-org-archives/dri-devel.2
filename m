Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA5606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2HXtD6g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B26F510EDD1;
	Tue, 10 Nov 2026 05:37:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D668710EDD1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:37:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6304641E75;
 Tue, 10 Nov 2026 05:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7BF1F0089F;
 Tue, 10 Nov 2026 05:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794289053;
 bh=psuK9NamxFNq3Xsb0dCsQBcReofkN53WMSh9x4grPfo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l2HXtD6g0+zs471ZZfatOzApdZ4vy1y9jHVy8J6l/dBXxHZSe9pdcFKcLMul2n4cO
 UfiaQa4iBXQk6vKvlEFOCCZcqkjNVD2x5i3F5gTEFTWClALcJbELdeGcK0gImWEkDO
 1L4kWdozxxuah/ljT3B8kv4xZwh2vqHH0JnsU5WsrVb1tjgRhG8XX0X1xH9jkBqUy4
 qFQGeuoZSfHWUxqh0unf93g1vQqNatXHAAYAeFXw9jLsg3psrV5nFZkvzfi6eYBEpC
 3ty5Onk+fAwO23VBuk4rFjL3iObPRKTDci0rMaa2uB5LCjbdFy+UEXqlo55okrNj5q
 iRcTeJ0aFvciA==
Message-ID: <sashiko-outbox-206314@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 19/29] drm/bridge_connector: suppress hotplug for
 IRQ_HPD without status changes
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-19-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-19-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:37:32 +0000
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
- [High] drm/bridge_connector: unconditional detect() after hpd_notify()
  breaks msm_dp
- [Medium] drm/bridge_connector: suppressed IRQ_HPD uevent on downstream
  EDID change
--

commit f0f1fcb0e2054ca27f091a1526051359ce518167
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/bridge_connector: suppress hotplug for IRQ_HPD without status changes

This commit updates drm_bridge_connector_handle_hpd() to notify the bridge
chain first, invoke the detect bridge callback to update connector->status,
and send a hotplug event on IRQ_HPD only when the connector status changes.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 4ade63306653f..1d4502126bff3 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -160,15 +160,25 @@ static void drm_bridge_connector_handle_hpd(struct =
drm_bridge_connector *drm_bri
>  					    enum drm_connector_dp_event event)
>  {
>  	struct drm_connector *connector =3D &drm_bridge_connector->base;
> +	struct drm_bridge *detect =3D drm_bridge_connector->bridge_detect;
>  	struct drm_device *dev =3D connector->dev;
> +	enum drm_connector_status old_status, new_status;
> +	bool level_hpd;
> +	bool changed;
> =20
> -	mutex_lock(&dev->mode_config.mutex);
> -	connector->status =3D status;
> -	mutex_unlock(&dev->mode_config.mutex);
> +	level_hpd =3D event =3D=3D DRM_CONNECTOR_NO_EXTRA_STATUS;
> =20
>  	drm_bridge_connector_hpd_notify(connector, status, event);
> =20
> -	drm_kms_helper_connector_hotplug_event(connector);
> +	mutex_lock(&dev->mode_config.mutex);
> +	old_status =3D connector->status;
> +	new_status =3D detect ? detect->funcs->detect(detect, connector) : stat=
us;

[Severity: High]
Does calling detect->funcs->detect() unconditionally after
drm_bridge_connector_hpd_notify() leak runtime PM references and leave AUX
transfers enabled after unplug in msm_dp?

On HPD plug and IRQ_HPD events, msm_dp_bridge_hpd_notify() ->
msm_dp_hpd_plug_handle() calls pm_runtime_resume_and_get() and sets
dp->plugged =3D true.  Calling msm_dp_bridge_detect() right after acquires
another runtime PM reference unconditionally and skips
pm_runtime_put_sync() when priv->plugged is true:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_detect() {
	guard(mutex)(&priv->plugged_lock);
	ret =3D pm_runtime_resume_and_get(&dp->pdev->dev);
	...
	status =3D connector_status_connected;
	priv->plugged =3D true;
	...
end:
	if (!priv->plugged) {
		if (phy_deinit) {
			msm_dp_aux_enable_xfers(priv->aux, false);
			msm_dp_display_host_phy_exit(priv);
		}

		pm_runtime_put_sync(&dp->pdev->dev);
	}
}

Because msm_dp_hpd_unplug_handle() only drops one reference when clearing
dp->plugged, every HPD plug and IRQ_HPD event leaks a runtime PM reference
on dp->pdev->dev, preventing the controller from runtime suspending.  If a
DPCD read fails in msm_dp_bridge_detect() while plugged, it clears
priv->plugged and drops only its own reference, causing a subsequent
msm_dp_hpd_unplug_handle() to return early without tearing down the session
or dropping the plug reference.

On unplug (status =3D=3D connector_status_disconnected), calling
detect->funcs->detect() after msm_dp_hpd_unplug_handle() re-enables AUX
transfers (leaving them enabled when dp->link->sink_count > 0 kept the PHY
initialized so phy_deinit is false) or re-initializes the PHY when
sink_count =3D=3D 0.  In addition, for bridges whose detect callback does n=
ot
sense HPD directly (such as lt9611uxc_bridge_detect() when hpd_supported is
false, which returns connector_status_connected), calling detect() on an
unplug notification overwrites connector_status_disconnected with
connector_status_connected.

> +	connector->status =3D new_status;
> +	changed =3D new_status !=3D old_status;
> +	mutex_unlock(&dev->mode_config.mutex);
> +
> +	if (changed || level_hpd)
> +		drm_kms_helper_connector_hotplug_event(connector);
>  }

[Severity: Medium]
Can this suppress needed hotplug events when a downstream sink or EDID
changes on a DP branch device during IRQ_HPD while connector->status stays
connector_status_connected?

When a branch device signals DS_PORT_STATUS_CHANGED via IRQ_HPD without
transitioning through disconnected, msm_dp_irq_hpd_handle() ->
msm_dp_display_process_hpd_high() reads the new EDID and calls
drm_edid_connector_update(), which increments connector->epoch_counter.
Because level_hpd is false and old_status and new_status are both
connector_status_connected, changed is false and userspace is not notified
to reprobe the updated modes.  Checking whether connector->epoch_counter
changed across drm_bridge_connector_hpd_notify() and detect() would
preserve the hotplug event when the EDID changes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D19
