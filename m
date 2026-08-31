Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43F2C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7680E10E2A6;
	Mon, 31 Aug 2026 22:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gSCnD4qu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1407E10E121;
 Mon, 31 Aug 2026 22:11:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C6C6400A7;
 Mon, 31 Aug 2026 22:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C61D1F00A3D;
 Mon, 31 Aug 2026 22:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788214306;
 bh=3QufebDidnA9U50oPH1NtaCbyYrcC46sFufrAikcyf8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gSCnD4quGrkLIQ0iWa84t2Q7xcG6Uty7tXI32Ed6MXm5vr4jXAQXWAA5ayFypynLz
 NO0XVCJStFnS1wiNj2aKBolvU3X3JPQmlpfkYizx7h3HGkeD9O9SgmNo4mS4n07ptc
 uekqSUi0DEJzrWVUEOvvnWoYvj+3xJw5MQz/Ox9pss9oT9wEJIKSPueyV2Mfx2qujr
 r2uFJ8Ho/ClA4G3y4D4qvojT0fHaWYVPEZZ47a6UFgZuidnud+J6Iwr7qZapQbFA2P
 oThPqX+E4/IrKdQh1e7APPLX/NW3D2y+UqyQCeMK8Wg1LEgFY6iZNz3MUyKL+18MZo
 90+tsJb9uFTdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/12] backlight: add kernel-internal backlight API
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260831210531.2334221-3-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
 <20260831210531.2334221-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:11:45 +0000
Message-Id: <20260831221146.1C61D1F00A3D@smtp.kernel.org>
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
- [High] DRM takeover protection is missing from bl_power_store(), allowing=
 userspace to bypass DRM exclusivity and toggle the backlight power state.
- [Medium] backlight_set_brightness() incorrectly returns success (0) and g=
enerates a spurious event when the backlight device is unregistered or unbo=
und (bd->ops is NULL).
- [Medium] guard(mutex)(&bd->ops_lock) unintentionally extends the lock sco=
pe over backlight_generate_event(), violating intended lock lifetime and ri=
sking lock contention.
- [Medium] backlight_notify_brightness() is called from inconsistent lockin=
g contexts, exposing registered notifier chains to AB-BA deadlocks or lockd=
ep splats.
--

commit bb82de7554b837e30f99cb722d8f1a608b68529b
Author: Mario Limonciello <mario.limonciello@amd.com>
Subject: backlight: add kernel-internal backlight API

This commit adds kernel-internal backlight helpers to allow modifying
backlights from within DRM. It introduces a brightness-changed notification
and a per-device takeover count to inhibit legacy sysfs writes while a DRM
client is in control.

> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backligh=
t/backlight.c
> index 51d8c3501768b..eec2aeadcc4b9 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
[ ... ]
> @@ -214,6 +217,13 @@ static ssize_t brightness_store(struct device *dev,
>  	struct backlight_device *bd =3D to_backlight_device(dev);
>  	unsigned long brightness;
> =20
> +	/* A luminance-aware DRM client has taken over this backlight; the
> +	 * legacy sysfs interface is disabled until the last such client
> +	 * goes away.
> +	 */
> +	if (atomic_read(&bd->drm_takeover) > 0)
> +		return -EBUSY;
> +

[Severity: High]
Since drm_takeover prevents legacy sysfs writes here, does bl_power_store()
also need this check?

Without it, could userspace write to the legacy bl_power sysfs attribute to
toggle the backlight power state, completely bypassing the DRM exclusivity
constraint?

[ ... ]
> @@ -514,6 +524,39 @@ static int devm_backlight_device_match(struct device=
 *dev, void *res,
>  	return *r =3D=3D data;
>  }
> =20
> +/**
> + * backlight_set_brightness - set brightness on a backlight device
> + * @bd: backlight device to operate on
> + * @value: brightness value to set on the device
> + * @reason: backlight-change reason to use for notifications
> + *
> + * This is the in-kernel API equivalent of writing into the 'brightness'=
 sysfs
> + * file. It calls into the underlying backlight driver to change the bri=
ghtness
> + * value.
> + * A uevent notification is sent with the reason set to @reason.
> + * Return: 0 if successfully notified, -EINVAL for invalid values
> + */
> +int backlight_set_brightness(struct backlight_device *bd, unsigned int v=
alue,
> +			      enum backlight_update_reason reason)
> +{
> +	int rc =3D 0;
> +
> +	guard(mutex)(&bd->ops_lock);
> +	if (bd->ops) {

[Severity: Medium]
If the backlight device is unregistered or unbound and bd->ops is NULL, this
skips the if block, but rc remains 0.

Could this falsely signal success to the caller and generate a spurious
uevent even though no brightness change actually occurred?

> +		if (value > bd->props.max_brightness)
> +			return -EINVAL;
> +
> +		dev_dbg(&bd->dev, "set brightness to %u\n", value);
> +		bd->props.brightness =3D value;
> +		rc =3D backlight_update_status(bd);
> +	}
> +	if (rc =3D=3D 0)
> +		backlight_generate_event(bd, reason);

[Severity: Medium]
The function-scoped guard causes ops_lock to remain held during the call to
backlight_generate_event(), which in turn calls sysfs_notify() and
kobject_uevent_env().

Does this unintentionally extend the lock scope over the event generation,
departing from the convention of releasing the lock before emitting events
and potentially increasing lock contention?

> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(backlight_set_brightness);
[ ... ]
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 015183d129f96..18d9145198b5f 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
[ ... ]
> @@ -325,6 +347,10 @@ static inline int backlight_update_status(struct bac=
klight_device *bd)
>  		ret =3D bd->ops->update_status(bd);
>  	mutex_unlock(&bd->update_lock);
> =20
> +	/* Notify DRM and other listeners that brightness changed */
> +	if (ret =3D=3D 0)
> +		backlight_notify_brightness(bd);

[Severity: Medium]
This emits the notifier call without guaranteeing a consistent state of
ops_lock across all call paths.

When backlight_update_status() is called from the sysfs path via
backlight_device_set_brightness(), bd->ops_lock is held. However, when
triggered by driver hotkeys, ops_lock might not be held. Does this expose
registered notifier chains to inconsistent locking contexts, risking lockdep
splats or AB-BA deadlocks if listeners acquire locks that nest with ops_loc=
k?

> +
>  	return ret;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831210531.2334=
221-1-mario.limonciello@amd.com?part=3D2
