Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62034CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938B710F016;
	Wed, 24 Jun 2026 17:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AmlML/US";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E433410EFE7
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:19:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2069160018;
 Wed, 24 Jun 2026 17:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE711F000E9;
 Wed, 24 Jun 2026 17:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782321545;
 bh=tNh6QzYyEdh/v4s4aUEjNPV0T6PgAjkVRKs7nYQcY4A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AmlML/USQzOWpfDsa0w1zcX6n4BG8SEfpMe40zovln4MPPmgeGspy3ZTXNCPGrRY1
 ydwpZ6nL1tGrF39t8yoIqCEy84lyphDvwUUW02CxPvTIr+tIQTK5hAnSZhz3XnmOR2
 xYS668V4WFGeEl4dZ/UCYPqYjKx/G9GGv/zpEOnFgS3lndCigbQa5gbSNQSYrtXUrH
 XMuo8V1K0n9tgHpsNY5gb9F5gYvS5iFXvkxSY/bTPqlF/31h3F7LpwmQY80A67CHZN
 KnSJayPlNs1FCdVc9xV+CLy9KaIdgMZPECXTyCMe3L8Lel5/ZT2OQZ2DXrSeqqmCoJ
 BrpBg89OAJKrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/10] drm/i915/display: use drm backlight
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624165751.2014759-11-mario.limonciello@amd.com>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
 <20260624165751.2014759-11-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:19:04 +0000
Message-Id: <20260624171905.8DE711F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Calling kobject_uevent_env() (which can sleep) while holding the d=
rm_backlight_lock spinlock in drm_backlight_link().
- [High] Error paths in drm_connector_register() fail to unregister the bac=
klight device, leading to a freed pointer on the global backlight list.
--

commit 91fa46bfbc0b179001176c9331c615c49eadeb08
Author: Mario Limonciello (AMD) <superm1@kernel.org>

drm/i915/display: use drm backlight

Convert Intel display drivers (i915 and xe) to use the new DRM backlight
infrastructure. This allows brightness control via DRM connector
properties.

> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu=
/drm/i915/display/intel_backlight.c
> index b128896cb1c2d..4543c2a8f3568 100644
> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
[ ... ]
> @@ -1004,6 +1005,8 @@ int intel_backlight_device_register(struct intel_co=
nnector *connector)
>  		    "[CONNECTOR:%d:%s] backlight device %s registered\n",
>  		    connector->base.base.id, connector->base.name, name);
> =20
> +	drm_backlight_link(connector->base.backlight, bd);
> +

[Severity: High]
This is a pre-existing issue, but does calling drm_backlight_link() here
introduce a sleep-in-atomic bug?

Looking at drm_backlight_link() in drm_backlight.c, it uses a scope-based
spinlock:

	guard(spinlock)(&drm_backlight_lock);
	send_uevent =3D __drm_backlight_link(b, bd);

	if (send_uevent)
		kobject_uevent_env(&b->connector->kdev->kobj, KOBJ_CHANGE,
				   (char **)ep);

kobject_uevent_env() allocates memory with GFP_KERNEL and can sleep. Since
the spinlock guard is still active when kobject_uevent_env() is called, this
could trigger lockdep warnings or system crashes.

>  out:
>  	kfree(name);
[ ... ]
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 0ce0c09835f6d..cd35cce329a55 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
[ ... ]
> @@ -7421,6 +7422,13 @@ intel_dp_init_connector(struct intel_digital_port =
*dig_port,
>  				    type, &intel_dp->aux.ddc);
>  	drm_connector_helper_add(&connector->base, &intel_dp_connector_helper_f=
uncs);
> =20
> +	if (type =3D=3D DRM_MODE_CONNECTOR_eDP) {
> +		int r =3D drm_backlight_alloc(&connector->base);
> +

[Severity: High]
This is a pre-existing issue, but does allocating the backlight here expose=
 a
list corruption issue during connector registration failures?

If a failure occurs during drm_connector_register() (for example, in
drm_sysfs_connector_add()), the error path does not unregister the
backlight device.

Since it was never fully registered, drm_connector_cleanup() will eventually
skip calling drm_connector_unregister() but will directly call
drm_backlight_free(), which does:

	kfree(b);
	connector->backlight =3D NULL;

Because the backlight was never removed from the global drm_backlight_list,
freeing it here leaves a dangling pointer on the global list, which could
cause a use-after-free panic during later list traversals.

> +		if (r)
> +			drm_err(display->drm, "Failed to allocate backlight: %d\n", r);
> +	}
> +
>  	if (!HAS_GMCH(display) && DISPLAY_VER(display) < 12)
>  		connector->base.interlace_allowed =3D true;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624165751.2014=
759-1-mario.limonciello@amd.com?part=3D10
