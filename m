Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3789CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC04610E0C8;
	Wed, 24 Jun 2026 17:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nGoWBWk7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DAEF10E0C8
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:19:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 972B4600FC;
 Wed, 24 Jun 2026 17:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6EB1F000E9;
 Wed, 24 Jun 2026 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782321573;
 bh=1vXjUrQRPqpVe1hxlGddCMgGBdhtW5qkpL5h7LNMzK8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nGoWBWk7BVMx5PbRPYurU3TN6OgStORLjIebo0JU6Gr4Rez+Nsh3x47Sq2Gt/JDZ8
 WvvND9herIZBNnGjD+4/3QhG2Ke1a7ivdvfwcEEELxhC54ibzKZYn31d+nbDPYvhTd
 CwU6YvwRuD51EN1csz11yxFmLS9W+TE9WRIzz8KuItQKGZUuVUuF+2BUVlvdzD0T+K
 /gAwuex7LKSIsBSbrlRaDHc/0TnIj7BAKqUuf3NheDuZ7H0K5M4KySs2SbclIzDdDs
 HWLtF8kOsT6+pO0ps4IfBFl7o3vSP66XkRvQfbJzdqBt/ZIQoeT5W6bbApzkdsUTHo
 3as+U8LUNrMeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/10] drm/amd/display: use drm backlight
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624165751.2014759-8-mario.limonciello@amd.com>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
 <20260624165751.2014759-8-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:19:32 +0000
Message-Id: <20260624171933.3B6EB1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Redundant call to drm_connector_unregister() in the connector dest=
roy hook triggers a kernel WARN_ON during driver unload.
- [Medium] LVDS connectors are missing the DRM backlight property allocatio=
n, leaving them without the new DRM-level brightness control capabilities.

Pre-existing issues:
- [High] Pre-existing error path Use-After-Free, Double Free, and memory le=
ak when device initialization fails.
--

commit 1adb86b656e02ccab8cb2193136ef89ff549cddf
Author: Mario Limonciello (AMD) <superm1@kernel.org>
Subject: drm/amd/display: use drm backlight

This commit converts the AMD display driver to use the new DRM backlight
infrastructure to allow brightness control via DRM connector properties.
It also includes fixes for backlight resource lifecycle management.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

[ ... ]

> @@ -8152,6 +8163,10 @@ static void amdgpu_dm_connector_destroy(struct drm=
_connector *connector)
>  	aconnector->dc_sink =3D NULL;
> =20
>  	drm_dp_cec_unregister_connector(&aconnector->dm_dp_aux.aux);
> +	/* DRM core will handle drm_backlight cleanup via:
> +	 * drm_connector_unregister() -> drm_backlight_unregister()
> +	 * drm_connector_cleanup() -> drm_backlight_free()
> +	 */
>  	drm_connector_unregister(connector);
>  	drm_connector_cleanup(connector);

[Severity: High]
Does this redundant unregister trigger a WARN_ON during driver unload?

When the driver is removed, drm_dev_unregister() automatically calls
drm_connector_unregister_all(), which unregisters the connector and its
newly added backlight object via drm_backlight_unregister().

Later, when the DRM device is cleaned up and the connector reference drops
to zero, amdgpu_dm_connector_destroy() is called. Because
drm_connector_unregister() calls drm_backlight_unregister() before checking
if the connector is already unregistered, it will attempt to unregister the
backlight a second time. This asserts a warning because the backlight was
already removed from the list.

[ ... ]

> @@ -9402,6 +9417,12 @@ void amdgpu_dm_connector_init_helper(struct amdgpu=
_display_manager *dm,
>  	aconnector->base.state->max_bpc =3D 16;
>  	aconnector->base.state->max_requested_bpc =3D aconnector->base.state->m=
ax_bpc;
> =20
> +	if (connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
> +		int r =3D drm_backlight_alloc(&aconnector->base);
> +
> +		if (r)
> +			drm_err(dm->ddev, "Failed to allocate backlight: %d\n", r);
> +	}

[Severity: Medium]
Are LVDS connectors meant to be excluded from the new backlight allocation?

The AMD display driver also supports backlight control for legacy LVDS
panels, but drm_backlight_alloc() is explicitly restricted to eDP here.
Since it is skipped for LVDS, the connector's backlight pointer remains
NULL, and LVDS panels will not expose the new DRM luminance properties.

[ ... ]

While reviewing these changes, I also noticed an issue in the error handling
path of amdgpu_dm_initialize_drm_device() in the same file:

> fail:
> 	kfree(aencoder);
> 	kfree(aconnector);
>
> 	return -EINVAL;

[Severity: High]
This is a pre-existing issue, but can this error path lead to a
use-after-free and double-free?

If a late initialization step fails after a connector is successfully
created and registered into the global drm_device connector list, the
code jumps to the fail label and frees aconnector.

This leaves a dangling pointer in the global DRM connector list. During
the subsequent error rollback via drm_mode_config_cleanup(), the DRM core
will iterate over the connector list and invoke
amdgpu_dm_connector_destroy(), which accesses the freed memory and
attempts to free it again. Additionally, the newly added backlight
allocation would be leaked here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624165751.2014=
759-1-mario.limonciello@amd.com?part=3D7
