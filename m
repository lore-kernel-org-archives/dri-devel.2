Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69718C624CE
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CFB210E348;
	Mon, 31 Aug 2026 22:37:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PuYa19At";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E508510E32B;
 Mon, 31 Aug 2026 22:37:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4C464034F;
 Mon, 31 Aug 2026 22:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67D11F000E9;
 Mon, 31 Aug 2026 22:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788215832;
 bh=x4hbSekisOOofZcqpcuNGlFq1xlmf9njDQ3dRiRKnag=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PuYa19At8qjbk74q7Y4cWBuOzw7w6loxpQzG7soreYdongWvuipUbBbLbaKcy4g9r
 Rc7lEDMHytSghPqbJAilbZ4RyjDiXFTdG7tqTava/Oix6W6D6FPWlPbwyYSDp1N4Pq
 I0J38v5Xrv79oYMpqG+atCspEyDYCQooNHcAuDYK6DyIbRo6b01SZSG8wnFBo5YQgU
 nEwrAyEoZP4YVSZj+yBEWWTgSgKRi9Q5d/JlupOccQSZCcWRSGwqpvXdcWo/x3r6Ov
 ySmhjZGS61x9TGt6fo7rGSxcvVGcUMb9JlyD66eThPNyHgARFvHXt8/p1NWqv5+EWb
 qYF9RPczyYQhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/12] drm: add DRM_CLIENT_CAP_LUMINANCE
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260831210531.2334221-6-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
 <20260831210531.2334221-6-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:37:11 +0000
Message-Id: <20260831223711.A67D11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Connector hotplugging or unplugging while DRM_CLIENT_CAP_LUMINANCE=
 is active causes state desynchronization and triggers kernel warnings.
- [High] Concurrent calls to DRM_IOCTL_SET_CLIENT_CAP can leak `luminance_c=
lients` reference counts, permanently inhibiting legacy sysfs backlight con=
trol (DoS).
--

commit d72da18676683e0c9579165708469f0cf974aa5b
Author: Mario Limonciello <mario.limonciello@amd.com>

drm: add DRM_CLIENT_CAP_LUMINANCE

This commit adds a DRIVER_CONNECTOR_LUMINANCE feature and a
DRM_CLIENT_CAP_LUMINANCE client capability. When a client enables this
capability, the kernel inhibits legacy sysfs backlight control by taking
over the backlight devices.

> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c

[ ... ]

> @@ -252,6 +253,10 @@ void drm_file_free(struct drm_file *file)
>  	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
>  		drm_fb_release(file);
>  		drm_property_destroy_user_blobs(dev, file);
> +		if (file->supports_luminance_control) {
> +			drm_backlight_uninhibit_legacy_all(dev);
> +			file->supports_luminance_control =3D false;
> +		}
>  	}

[Severity: High]
Will this correctly handle connectors that are hotplugged or unplugged
after the compositor sets DRM_CLIENT_CAP_LUMINANCE?

drm_backlight_uninhibit_legacy_all() iterates over the list of currently
present connectors. If a compositor enables DRM_CLIENT_CAP_LUMINANCE and a
monitor is later hotplugged via DP MST, the new connector will not have
its legacy sysfs backlight control inhibited.

When the compositor exits and drm_file_free() runs:

For newly hotplugged connectors, it will try to uninhibit them even though
they were never inhibited, triggering WARN_ON(b->luminance_clients =3D=3D 0)
in drm_backlight_uninhibit_legacy().

Conversely, for connectors unplugged before the compositor exits,
drm_backlight_connector_cleanup() will fire WARN_ON(b->luminance_clients)
because the connector is destroyed while its luminance_clients count is
still 1.

> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c

[ ... ]

> @@ -392,6 +394,21 @@ drm_setclientcap(struct drm_device *dev, void *data,=
 struct drm_file *file_priv)
>  		file_priv->plane_color_pipeline =3D req->value;
>  		break;
>  	}
> +	case DRM_CLIENT_CAP_LUMINANCE:
> +		if (!drm_core_check_feature(dev, DRIVER_CONNECTOR_LUMINANCE))
> +			return -EOPNOTSUPP;
> +		if (!file_priv->atomic)
> +			return -EINVAL;
> +		if (req->value > 1)
> +			return -EINVAL;
> +		if (req->value =3D=3D file_priv->supports_luminance_control)
> +			break;
> +		if (req->value)
> +			drm_backlight_inhibit_legacy_all(dev);
> +		else
> +			drm_backlight_uninhibit_legacy_all(dev);
> +		file_priv->supports_luminance_control =3D req->value;
> +		break;

[Severity: High]
Does this check-then-act sequence lack synchronization?

If two threads share a single DRM file descriptor and concurrently invoke
DRM_IOCTL_SET_CLIENT_CAP with DRM_CLIENT_CAP_LUMINANCE=3D1, both threads
could evaluate the supports_luminance_control condition as false before
either updates it.

Both threads would then call drm_backlight_inhibit_legacy_all(dev), causing
a double-increment of the luminance_clients reference count. When the file
descriptor is closed, drm_file_free() will only call
drm_backlight_uninhibit_legacy_all() once, permanently leaving the legacy
sysfs backlight interface inhibited and returning -EBUSY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831210531.2334=
221-1-mario.limonciello@amd.com?part=3D5
