Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7312C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FD010EA15;
	Tue,  8 Sep 2026 04:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kkTLthO5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB0C10EA13;
 Tue,  8 Sep 2026 04:55:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A4F840259;
 Tue,  8 Sep 2026 04:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAEB1F00A3A;
 Tue,  8 Sep 2026 04:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788843331;
 bh=a/AgNhJVmXnAp0HHx3gB5cCRW5p/wGn/JlW5G8OFqw4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kkTLthO5eNe2FyXYW8RiYunzMRwcEDgi8Dp/mxRIItBZz0khNEFn5rt5c68F701cu
 YV0/vpDnV8tVX/6f4GI9VIruI8WD4rwWkPevJeN6p4ZH0O8+JK0/ejBd5XxVUPVyi2
 RheT1HUIR52qSQELMxHHYoJqzw0mS6e7g0AVjV2yvEPfKPt3IUROXkFKtoqWwVjdjR
 du8XeQZaHrJe69kj704ZkpFvks5ftzb2JJ6f1sNhwTOOgdlwyg7q/Yiw+W6OVBeK+n
 Dp4QAXhABTWtc4F3q8FnFg0eK7tAIEeqPKjS9zfy6oKL4zeqBGYvYArKtJDzUbO5gB
 PcNZp37yUf+FA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/14] drm: add DRM_CLIENT_CAP_LUMINANCE
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260908044035.62093-6-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-6-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 04:55:30 +0000
Message-Id: <20260908045530.BCAEB1F00A3A@smtp.kernel.org>
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
- [High] TOCTOU race between `drm_backlight_link()` and device-wide backlig=
ht inhibit/uninhibit iterations causes permanent count corruption.
- [High] The LUMINANCE property is unconditionally exposed to all atomic cl=
ients, violating the DRM_CLIENT_CAP_LUMINANCE capability contract.
- [Low] Clients cannot cleanly unset DRM_CLIENT_CAP_LUMINANCE if they have =
previously unset DRM_CLIENT_CAP_ATOMIC.
--

commit 3e9d95a8d4fc1bbb26ab6124a33c012ee7b1f848
Author: Mario Limonciello <mario.limonciello@amd.com>

drm: add DRM_CLIENT_CAP_LUMINANCE

This patch adds a DRIVER_CONNECTOR_LUMINANCE driver feature and a
DRM_CLIENT_CAP_LUMINANCE client capability. When a client sets this
capability, every DRM-connected backlight is marked as taken over, and
legacy sysfs writes return -EBUSY.

> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 9039a39c43243..de2c9d9ab5285 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c

[ ... ]

> @@ -392,6 +394,28 @@ drm_setclientcap(struct drm_device *dev, void *data,=
 struct drm_file *file_priv)
>  		file_priv->plane_color_pipeline =3D req->value;
>  		break;
>  	}
> +	case DRM_CLIENT_CAP_LUMINANCE:
> +		if (!drm_core_check_feature(dev, DRIVER_CONNECTOR_LUMINANCE))
> +			return -EOPNOTSUPP;
> +		if (!file_priv->atomic)
> +			return -EINVAL;

[Severity: Low]
Can this prevent clients from cleanly unsetting DRM_CLIENT_CAP_LUMINANCE if
they have previously unset DRM_CLIENT_CAP_ATOMIC?

If a client sets ATOMIC=3D1, LUMINANCE=3D1, ATOMIC=3D0, and then tries to u=
nset
LUMINANCE=3D0, this unconditional atomic check will cause the last call to
return -EINVAL.

> +		if (req->value > 1)
> +			return -EINVAL;
> +
> +		/*
> +		 * Serialize the compare-and-act so concurrent ioctls on a shared
> +		 * fd cannot unbalance the device-wide inhibit count.
> +		 */
> +		mutex_lock(&dev->mode_config.mutex);
> +		if (req->value !=3D file_priv->supports_luminance_control) {
> +			if (req->value)
> +				drm_backlight_inhibit_legacy_all(dev);

[Severity: High]
Does this call introduce a TOCTOU race between drm_backlight_link() and the
device-wide backlight inhibit iteration?

Looking at drm_backlight_inhibit_legacy_all() in
drivers/gpu/drm/drm_backlight.c, it drops drm_backlight_lock before
iterating connectors:

	scoped_guard(spinlock, &drm_backlight_lock)
		dev->mode_config.luminance_clients++;

	drm_connector_list_iter_begin(dev, &iter);

If a concurrent hotplug/probe thread calls drm_backlight_link(), it reads
the already-incremented dev->mode_config.luminance_clients and assigns it to
the new connector's b->luminance_clients.

Then the ioctl thread resumes, iterates the connector list, reaches this
newly linked connector, and calls drm_backlight_inhibit_legacy(), which
increments b->luminance_clients again. This causes the connector's count to
get permanently stuck at a non-zero value, locking out legacy sysfs backlig=
ht
control for the rest of the system uptime.

> +			else
> +				drm_backlight_uninhibit_legacy_all(dev);
> +			file_priv->supports_luminance_control =3D req->value;

[Severity: High]
Is the LUMINANCE property being unconditionally exposed to all atomic clien=
ts,
violating the DRM_CLIENT_CAP_LUMINANCE capability contract?

The UAPI behavior documented in include/uapi/drm/drm.h states: "The LUMINAN=
CE
property becomes visible on supported connectors".

However, the capability tracked here (file_priv->supports_luminance_control)
is never utilized by the DRM core (e.g., in drm_mode_object_get_properties)
to filter property visibility. drm_mode_object_get_properties() only checks
if the client is atomic, but fails to check if the property is luminance and
if the client supports it:

	if ((prop->flags & DRM_MODE_PROP_ATOMIC) && !atomic)
		continue;

As a result, any generic atomic client (like a compositor restoring state)
will see and restore the LUMINANCE property without setting
DRM_CLIENT_CAP_LUMINANCE, bypassing the sysfs inhibition.

> +		}
> +		mutex_unlock(&dev->mode_config.mutex);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908044035.6209=
3-1-mario.limonciello@amd.com?part=3D5
