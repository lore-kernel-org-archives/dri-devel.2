Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6EA606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fXyqGrFO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8501121BD;
	Thu, 19 Nov 2026 09:01:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C211121CB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:01:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 94FB861F59;
 Thu, 19 Nov 2026 09:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC751F000C4;
 Thu, 19 Nov 2026 09:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795078865;
 bh=R6+l/q8k+fi9fAfQcYQDK9FAdhinYY3KR8fHbBdnQQ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fXyqGrFOUeD3QUDFrag1O01R0gPJ+bRqt8oH1Y/rkIlbuZT6nHBoZV084p27Y98rc
 3SbjQKCH2mIT0yOZthbPpbuSwY86QdS/KG7jIx88HREbFoyBSgAyRQkKzCjUJS2LV7
 L8j8aOtkNXbvKUvVdfsWZ3baiM1tdv5hlD/+BXSEPmA/3hoNkzHLAi8LTmVGgAOtLk
 ttc/Gacmhq9mYduAQ77iDYL8IuqLBCCsTNBhtZIm7daQalspKJ0ttqnB3r/zARP7ZU
 79i8eRMvteNfDtm62mpiy5LoVmUOBdbruijwW6+K2zJHF1uakPLaJetjJYWmCmwpwz
 4Lw7o/WyhaD5g==
Message-ID: <sashiko-outbox-222771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 19/29] drm/bridge_connector: suppress hotplug for
 IRQ_HPD without status changes
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-19-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-19-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:01:04 +0000
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

commit 639a7eb6e945d13bc1ca0a8e003c6cf0a496e228
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/bridge_connector: suppress hotplug for IRQ_HPD without status changes

This commit calls the bridge .detect() callback after HPD notification to
update connector->status and skips sending a hotplug event on IRQ_HPD when
the connector status has not changed.

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
drm_bridge_connector_hpd_notify() leak a runtime PM reference on
dp->pdev->dev in msm_dp on every connect and IRQ_HPD event?

On plug and IRQ_HPD notifications, msm_dp_bridge_hpd_notify() ->
msm_dp_hpd_plug_handle() acquires a runtime PM reference and sets
dp->plugged =3D true.  Calling msm_dp_bridge_detect() right after acquires a
second reference and skips releasing it at exit because priv->plugged is
true:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_detect() {
	...
	ret =3D pm_runtime_resume_and_get(&dp->pdev->dev);
	...
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

msm_dp_hpd_unplug_handle() only drops one reference when clearing
dp->plugged, so the extra reference is never released and the DP controller
cannot runtime suspend.  If a DPCD read in msm_dp_bridge_detect() fails
instead, it clears priv->plugged =3D false while releasing only its own
reference, causing a later msm_dp_hpd_unplug_handle() to return early and
skip unplug cleanup and the initial reference release.

On disconnect notifications, running msm_dp_bridge_detect() after
msm_dp_hpd_unplug_handle() also re-enables AUX transfers or re-initializes
the PHY after unplug, and bridges whose .detect() callback does not sense
HPD (such as lt9611uxc_bridge_detect() when hpd_supported is false) will
overwrite connector_status_disconnected with connector_status_connected.

> +	connector->status =3D new_status;
> +	changed =3D new_status !=3D old_status;
> +	mutex_unlock(&dev->mode_config.mutex);
> +
> +	if (changed || level_hpd)
> +		drm_kms_helper_connector_hotplug_event(connector);
>  }

[Severity: Medium]
Can checking only new_status !=3D old_status suppress hotplug events when a
downstream DP branch device changes EDID over IRQ_HPD while remaining
connected?

When a branch device signals DP_DOWNSTREAM_PORT_STATUS_CHANGED while
connector->status is already connector_status_connected,
msm_dp_irq_hpd_handle() -> msm_dp_display_process_hpd_high() reads the new
EDID and calls drm_edid_connector_update(), which increments
connector->epoch_counter.  Because new_status and old_status are both
connector_status_connected and level_hpd is false, changed is false and
userspace never receives the hotplug notification.

When new_status !=3D old_status, updating connector->status directly here
without incrementing connector->epoch_counter also causes subsequent
drm_helper_probe_detect() calls to see no status change and skip bumping
connector->epoch_counter.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D19
