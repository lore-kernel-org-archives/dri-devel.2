Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CEFC44536
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B0810E2A3;
	Thu, 23 Jul 2026 01:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PxEIqJ76";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37A910E2A3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:51:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A321F41E5E;
 Thu, 23 Jul 2026 01:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FCD1F000E9;
 Thu, 23 Jul 2026 01:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771482;
 bh=wvX7KTUU61lDaiLET8Z8RLN245/Y3GBZZKNHMjZYC4g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PxEIqJ76jUT4nKctPJjzHqD8BWm0b5RT9UQXu7W3HOc4pMu1aif5LDCe+CLSeOD4b
 nOMnLzvIcU72mLavBQ7KzCMBAU+qjg+hWqXm3fwc3YFPVX9WFytpH4XeZycN6UVO1T
 aehvv4l008RGLCr1d8hQkoVbEtWRF1Oa17EzNgceiw1gAbGAuImzUl3CdVa7DVCAg7
 vkNRDSprEh17Pa17bKPNoo//8bVHwwriUwHY9WXCbsXI4nyF1k4CHrCl/qZ+X0VwSx
 wEe+2nLyLL/HyTFgzg2VoI55fZ+dD8ONry3fdSDtkv4ypP519j5KOCPyeneOSUhqYN
 BTkRhwv1Hg0Fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 16/61] drm/display: hdmi-state-helper: Pass acquire
 ctx to hotplug helpers
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-16-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-16-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:51:21 +0000
Message-Id: <20260723015122.49FCD1F000E9@smtp.kernel.org>
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
- [High] Self-deadlock due to re-acquiring connection_mutex with a new ww_a=
cquire_ctx in drm_atomic_helper_connector_hdmi_force()
--

--- Patch [16]: [PATCH v9 16/61] drm/display: hdmi-state-helper: Pass acqui=
re ctx to hotplug helpers ---
commit 5cf4eb0e25950e07d4630b5f697abf8096ce1b1d
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: hdmi-state-helper: Pass acquire ctx to hotplug helpers

Extend drm_atomic_helper_connector_hdmi_hotplug() and
drm_atomic_helper_connector_hdmi_update() to take a struct
drm_modeset_acquire_ctx argument to be used when a CRTC reset is required.
Update callers, including drm_atomic_helper_connector_hdmi_force() which
now initializes its own context.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 92be6278ea443..04d5196a2010f 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
[ ... ]
> @@ -1255,6 +1264,19 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hot=
plug);
>   */
>  void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connec=
tor)
>  {
> -	drm_atomic_helper_connector_hdmi_update(connector, connector->status);
> +	struct drm_modeset_acquire_ctx ctx;
> +	int ret;
> +
> +	drm_modeset_acquire_init(&ctx, 0);
> +
> +retry:
> +	ret =3D drm_atomic_helper_connector_hdmi_update(connector, &ctx, connec=
tor->status);

[Severity: High]
Will this cause a self-deadlock when forcing a connector's status?

When a user writes to sysfs to force a connector status, it invokes
drm_helper_probe_single_connector_modes(). This function acquires the
connection_mutex using its own local ww_acquire_ctx before calling the
force() callback:

drm_probe_helper.c:drm_helper_probe_single_connector_modes()
  drm_modeset_acquire_init(&ctx, 0);
  drm_modeset_lock(&dev->mode_config.connection_mutex, &ctx);
  connector->funcs->force(connector);

This new implementation of drm_atomic_helper_connector_hdmi_force() creates
a new local ctx, which is passed down the chain:

drm_atomic_helper_connector_hdmi_force()
  drm_modeset_acquire_init(&new_ctx, 0);
  drm_atomic_helper_connector_hdmi_update(..., &new_ctx, ...)
    drm_connector_hdmi_sync_scdc(..., &new_ctx)
      drm_modeset_lock(&connector->dev->mode_config.connection_mutex, &new_=
ctx)

Because the current thread already holds connection_mutex but is attempting
to acquire it again using this new, conflicting ww_acquire_ctx with
acquired =3D=3D 0, won't __ww_mutex_lock() block the thread waiting for its=
elf
to release the lock instead of returning -EDEADLK?

> +	if (ret =3D=3D -EDEADLK) {
> +		drm_modeset_backoff(&ctx);
> +		goto retry;
> +	}
> +
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D16
