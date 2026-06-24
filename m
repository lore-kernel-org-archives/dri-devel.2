Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B65CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728BD10E0C3;
	Wed, 24 Jun 2026 17:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ik/zbCb6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208C110E0C3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:10:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0985C402CF;
 Wed, 24 Jun 2026 17:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C315B1F000E9;
 Wed, 24 Jun 2026 17:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782321045;
 bh=Ur9nzRHBcbYMIVWJS+TxJPbAQXD9PUn4LW8kUq0k40M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ik/zbCb6OwXsXNSJvmtqcoPgl62h3S0biOlYNBfZ/pX1jmPYMoAACoYYd7ULoBaHg
 6uVU7LvxzAKvs9DH9vih+AKDkjrPoMXE1dKXktIMmRvuPcUDdOh7Y2j5y6OKWn+nqj
 TAavCPPMUfFJhZjwEP2ij5PJzkvjwVNLwTECfUaSIfDjK0Ai0JhOV6gEHnaWWQNfuG
 deAxrQ9QE8efJMLpZJ0DKOuiZCOCjyLDNP8chubDc4Sju+XAdjmB9glrT+yCm1ooXX
 kK+G7ncdgMrcyZqAjdkLIbO0e/aymauFs0OMjBv3aZWmPIX4/iYrUBSV0Lr5zjvDLE
 MBfOtk2s0mQRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/10] drm: link connectors to backlight devices
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624165751.2014759-4-mario.limonciello@amd.com>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
 <20260624165751.2014759-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:10:44 +0000
Message-Id: <20260624171045.C315B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Missing unregistration of `drm_backlight` on connector registr=
ation error paths leads to List Corruption and Use-After-Free.
- [High] `drm_backlight_get_device()` returns an unreferenced pointer, caus=
ing a Use-After-Free vulnerability.
- [High] Calling a sleeping function (`kobject_uevent_env`) while holding a=
 spinlock in `drm_backlight_link()`.
- [High] Out-of-band modification of atomic state in `__drm_backlight_real_=
changed()`.
- [High] Dangling sysfs 'backlight' symlink permanently leaked during conne=
ctor unregistration.
- [High] Global shared property bounds corruption in `__drm_backlight_updat=
e_prop_range()`.
- [Medium] Unconditional lockdep assertion failure and unsafe list access i=
n backlight registration functions.
--

commit 97672c232ba720c2f01bd5c726f55338a93bdc07
Author: Mario Limonciello (AMD) <superm1@kernel.org>

drm: link connectors to backlight devices

This commit introduces DRM backlight helpers to connect hardware backlight
devices to DRM connectors. It adds a generic LUMINANCE property and manages
the links, sysfs symlinks, and legacy sysfs inhibitions.

> --- /dev/null
> +++ b/drivers/gpu/drm/drm_backlight.c
[ ... ]
> +/* caller must hold @drm_backlight_lock */
> +static void __drm_backlight_real_changed(struct drm_backlight *b, uint64=
_t v)
> +{
[ ... ]
> +	/* Update the atomic state directly.
> +	 * For atomic drivers, the luminance value is stored in
> +	 * connector->state->luminance, not in the legacy property array.
> +	 * We update it unconditionally to reflect the hardware state,
> +	 * regardless of DPMS.
> +	 */
> +	if (connector->state)
> +		connector->state->luminance =3D set;

[Severity: High]
Is it safe to mutate the atomic state out-of-band here?

When the hardware brightness changes, this function acts as a notifier
callback and directly assigns connector->state->luminance without
executing an atomic commit or acquiring DRM modeset locks.

Since the state object is expected to be strictly immutable during normal
operation, could this cause data races against concurrent commits modifying
or duplicating the state?

[ ... ]
> +static void __drm_backlight_update_prop_range(struct drm_backlight *b)
> +{
[ ... ]
> +	/* Update property range to match hardware capabilities.
> +	 * Range of 0-0 indicates no backing device.
> +	 * Range of 1-max for normal operation.
> +	 * Range of 0-max means that the display would turn off at 0
> +	 */
> +	if (prop->values[1] !=3D max) {
> +		prop->values[0] =3D max ? (can_disable ? 0 : 1) : 0;
> +		prop->values[1] =3D max;
> +	}
> +}

[Severity: High]
Can this corrupt the permissible brightness range for other connectors?

The LUMINANCE DRM property is created once per device in
drm_mode_create_standard_properties() and shared across all connectors on
that device.

When __drm_backlight_update_prop_range() dynamically overwrites the global
prop->values[0] and prop->values[1] array, it changes the metadata for
the shared property. If a driver exposes multiple display connectors with
backlights that have different maximum brightness ranges, it seems this wou=
ld
overwrite the bounds for all of them.

[ ... ]
> +void drm_backlight_register(struct drm_backlight *b)
> +{
> +	if (!b)
> +		return;
> +
> +	WARN_ON(__drm_backlight_is_registered(b));
> +
> +	guard(spinlock)(&drm_backlight_lock);
> +	list_add(&b->list, &drm_backlight_list);
> +}

[Severity: Medium]
Does this trigger an unconditional lockdep splat?

Looking at drm_backlight_register(), it calls __drm_backlight_is_registered=
(b)
before acquiring the drm_backlight_lock spinlock. However, the helper conta=
ins:

static bool __drm_backlight_is_registered(...)
{
    lockdep_assert_held(&drm_backlight_lock);
    ...
}

Since the lock isn't held yet, this appears to trigger an assertion failure
and creates a data race when accessing the list. Should the lock be acquired
before checking the registration status?

[ ... ]
> +void drm_backlight_link(struct drm_backlight *b, struct backlight_device=
 *bd)
> +{
[ ... ]
> +	guard(spinlock)(&drm_backlight_lock);
> +	send_uevent =3D __drm_backlight_link(b, bd);
> +
> +	if (send_uevent)
> +		kobject_uevent_env(&b->connector->kdev->kobj, KOBJ_CHANGE,
> +				   (char **)ep);
> +}

[Severity: High]
Could this lead to a sleep-in-atomic issue?

The guard(spinlock)(&drm_backlight_lock) acquires the spinlock for the enti=
re
duration of the function scope. Later in the function, it calls
kobject_uevent_env(), which performs memory allocations using GFP_KERNEL and
can sleep.

Is there a way to drop the lock before sending the uevent?

[ ... ]
> +struct backlight_device *drm_backlight_get_device(struct drm_backlight *=
b)
> +{
> +	if (!b)
> +		return NULL;
> +
> +	guard(spinlock)(&drm_backlight_lock);
> +	return b->link;
> +}

[Severity: High]
Could this result in a use-after-free when creating the sysfs link?

In drm_backlight_get_device(), the pointer b->link is returned while briefly
holding a spinlock. However, it doesn't take a reference to the underlying
backlight_device before returning.

When drm_sysfs_connector_add_late() uses this pointer to call
sysfs_create_link(), what prevents the backlight driver from concurrently
unregistering and freeing the device before the kobj is accessed?

> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
[ ... ]
> @@ -845,6 +847,8 @@ int drm_connector_register(struct drm_connector *conn=
ector)
>  	if (connector->registration_state !=3D DRM_CONNECTOR_INITIALIZING)
>  		goto unlock;
> =20
> +	drm_backlight_register(connector->backlight);
> +
>  	ret =3D drm_sysfs_connector_add(connector);
>  	if (ret)
>  		goto unlock;

[Severity: Critical]
Does the error path here leak the backlight registration?

If a subsequent operation like drm_sysfs_connector_add() fails, the function
aborts via goto unlock but doesn't call drm_backlight_unregister().

Later, when drm_connector_cleanup() calls drm_backlight_free(), it performs
kfree(b). Since the object was never unregistered, it remains part of
drm_backlight_list, which would lead to list corruption and a use-after-fre=
e.

Should drm_backlight_unregister() be called on the error paths?

[ ... ]
> @@ -931,6 +935,8 @@ EXPORT_SYMBOL(drm_connector_dynamic_register);
>  void drm_connector_unregister(struct drm_connector *connector)
>  {
>  	mutex_lock(&connector->mutex);
> +	drm_backlight_unregister(connector->backlight);
> +
>  	if (connector->registration_state !=3D DRM_CONNECTOR_REGISTERED) {
>  		mutex_unlock(&connector->mutex);
>  		return;
>  	}
[ ... ]
>  	drm_sysfs_connector_remove_early(connector);

> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
[ ... ]
>  void drm_sysfs_connector_remove_early(struct drm_connector *connector)
>  {
> +	if (connector->backlight && drm_backlight_get_device(connector->backlig=
ht))
> +		sysfs_remove_link(&connector->kdev->kobj, "backlight");
> +
>  	if (connector->ddc)

[Severity: High]
Is the backlight sysfs symlink permanently leaked during unregistration?

In drm_connector_unregister(), drm_backlight_unregister() is called first,
which clears the backlight link.

Shortly after, drm_sysfs_connector_remove_early() is called. It checks if
drm_backlight_get_device(connector->backlight) returns a non-NULL pointer.
Because the backlight was just unregistered, this check fails and the
symlink is never removed from sysfs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624165751.2014=
759-1-mario.limonciello@amd.com?part=3D3
