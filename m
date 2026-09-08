Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C83C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E1C10E9DF;
	Tue,  8 Sep 2026 04:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bxKdt7Zq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14A5310E9DF;
 Tue,  8 Sep 2026 04:52:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F2001439EF;
 Tue,  8 Sep 2026 04:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F77B1F00A3A;
 Tue,  8 Sep 2026 04:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788843152;
 bh=WMPyVlZjr3kxWWCGzItajqB/EgpG/WRpEPeyFezNdbg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bxKdt7Zqdj+Nb6BQ8sS2TWOPbP8LbBIwgecjbpm/iNQKNWVZXsnfk+1UQ0KD86L7K
 mZ0cThEV+HkSevBUyGs89UtePazssRA2ZJz5jH/imYevz5q07gIlyr4IMqlZOjX9OX
 fpPBQswUXpkInXGAxCfYJc7hAFusOF7X6y//twP2b5PFi+XJam88DxhO3DZpx+g/9o
 BKn2N3IBwqSakDFB+leIf1h2BSYeB5qGH/1Uhx2vSV3LvH+eolbtG9fdI6EXgtLIfF
 o7w24wRFPa1jbosQ8CWg+/vS1J/ssVgj+RNKz1MFl+/N3RBpQa8d47/DzAWwr1L1U+
 m2QHaZg/dAIOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260908044035.62093-3-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 04:52:32 +0000
Message-Id: <20260908045232.9F77B1F00A3A@smtp.kernel.org>
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
- [High] backlight_notify_brightness() is called inside backlight_update_st=
atus() while bd->ops_lock is held, creating an AB-BA deadlock risk with DRM=
 listeners.
- [Medium] Hardware/hotkey-driven brightness changes reported via backlight=
_force_update() bypass backlight_notify_brightness(), causing in-kernel lis=
teners to lose sync with the actual state.
--

commit 56d45c464432e9b84ad73dff6ec5f6ddda9af544
Author: Mario Limonciello <mario.limonciello@amd.com>

backlight: add kernel-internal backlight API

This commit adds internal backlight helpers allowing DRM drivers to provide
an interface for user-space to control the backlight via DRM connector
properties. It introduces a brightness-changed notification and a per-device
takeover count to inhibit legacy sysfs writes while a luminance-aware DRM
client is in control.

> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backligh=
t/backlight.c
> index 4401f6294ccc8..1c700c1e77c3f 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
[ ... ]
> @@ -548,6 +600,20 @@ int backlight_unregister_notifier(struct notifier_bl=
ock *nb)
>  }
>  EXPORT_SYMBOL(backlight_unregister_notifier);
> =20
> +/**
> + * backlight_notify_brightness - notify brightness change to listeners
> + * @bd: backlight device that changed
> + *
> + * Notify registered listeners that the backlight brightness has changed.
> + * This is called automatically after successful brightness updates.
> + */
> +void backlight_notify_brightness(struct backlight_device *bd)
> +{
> +	blocking_notifier_call_chain(&backlight_notifier,
> +				     BACKLIGHT_BRIGHTNESS_CHANGED, bd);
> +}
> +EXPORT_SYMBOL(backlight_notify_brightness);

[Severity: Medium]
Will in-kernel listeners lose sync with the actual hardware backlight state
when brightness is changed via a hardware hotkey or ACPI event?

When physical hotkey presses trigger platform drivers to invoke
backlight_force_update():

drivers/video/backlight/backlight.c:backlight_force_update() {
	...
	mutex_unlock(&bd->ops_lock);
	backlight_generate_event(bd, reason);
}

It emits a user-space uevent via backlight_generate_event(), but it doesn't
call the newly added backlight_notify_brightness() helper. Should it also
notify in-kernel DRM connector luminance properties here?

> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 015183d129f96..fac1acbc698a1 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
[ ... ]
> @@ -325,6 +351,10 @@ static inline int backlight_update_status(struct bac=
klight_device *bd)
>  		ret =3D bd->ops->update_status(bd);
>  	mutex_unlock(&bd->update_lock);
> =20
> +	/* Notify DRM and other listeners that brightness changed */
> +	if (ret =3D=3D 0)
> +		backlight_notify_brightness(bd);

[Severity: High]
Does calling backlight_notify_brightness() here create an AB-BA deadlock ri=
sk
with DRM listeners?

The caller of backlight_update_status() often holds bd->ops_lock (for examp=
le,
in backlight_set_brightness() or legacy sysfs writes). This means the block=
ing
notifier chain is fired synchronously under ops_lock.

If a DRM listener acquires a DRM lock during the notification callback, it
establishes an ops_lock -> drm_lock dependency.=20

Conversely, if a DRM driver calls backlight_set_brightness() while holding
DRM locks, it will attempt to acquire ops_lock, resulting in a drm_lock ->
ops_lock dependency.

Should the notification be deferred until after ops_lock is released, just
as backlight_generate_event() is handled?

> +
>  	return ret;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908044035.6209=
3-1-mario.limonciello@amd.com?part=3D2
