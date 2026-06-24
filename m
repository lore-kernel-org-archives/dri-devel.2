Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25750CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F0C10E0BF;
	Wed, 24 Jun 2026 17:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XM21iIdU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B961410E0BF
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:10:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7573043F1A;
 Wed, 24 Jun 2026 17:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320EC1F00A3A;
 Wed, 24 Jun 2026 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782321006;
 bh=BlovTqSBgB3I+WqsBzL2eUdU+bu1F64gfQigcQZS95c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XM21iIdUmQfu4aRLHouw8OYeZkaf17sqelkukNHUVbmowwhCAMpF/GbZuHC2R7rEp
 /fpwzz943UD6MuWqT4+r8IbLNSDEK+YWz/2hdST9I5H/XWsS+g40iEHMCXKQ7xMBMq
 KqpDjrPkKb7+LIzvXZX1OuRxsHkOZX8W62117u7VOd0gFI5LnjZEetC1w05iOUNKeH
 sjo0QbvnAN6XkDpefzqmM377pArXWcDACRq2qDfRJ1LbR0XSec/KX+zBDqbyESs8LT
 v9aHHwtT0yUbfsZPxj4C99rb1Rw9smfYCBLt1NtuCMdKzSiogmR1t+DyNuTB1j51Vr
 QKFJPjDoUG8Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/10] Revert "backlight: Remove notifier"
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624165751.2014759-2-mario.limonciello@amd.com>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
 <20260624165751.2014759-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:10:05 +0000
Message-Id: <20260624171006.320EC1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Low] Multiple copy-paste errors and typos in the newly added kerneldoc c=
omments for the backlight notifier API.
- [Low] Missing include or forward declaration for `struct notifier_block` =
in `<linux/backlight.h>`.

Pre-existing issues:
- [High] Concurrent `backlight_update_status()` and `backlight_device_unreg=
ister()` can cause a Use-After-Free of `bd->ops` or execution of unmapped m=
emory.
- [High] `backlight_device_get_by_type` returns a pointer to a `backlight_d=
evice` without incrementing its reference count, leading to a Use-After-Fre=
e.
- [High] `backlight_enable()` and `backlight_disable()` modify `bd->props.s=
tate` locklessly, causing data races and state corruption.
--

commit 692a77b3d3423be93e071e88f6a741af5c0ebe7d
Author: Mario Limonciello (AMD) <superm1@kernel.org>
Subject: Revert "backlight: Remove notifier"

This reverts a previous commit to restore backlight notifier support.
The backlight notifier support is needed in order to add backlight
control support into DRM connectors.

> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backligh=
t/backlight.c
> index a22d0bbb6e639..ff2c2084c73a4 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
[ ... ]
> @@ -484,6 +488,9 @@ void backlight_device_unregister(struct backlight_dev=
ice *bd)
>  	mutex_unlock(&pmac_backlight_mutex);
>  #endif
> =20
> +	blocking_notifier_call_chain(&backlight_notifier,
> +				     BACKLIGHT_UNREGISTERED, bd);
> +
>  	mutex_lock(&bd->ops_lock);
>  	bd->ops =3D NULL;
>  	mutex_unlock(&bd->ops_lock);

[Severity: High]
This is a pre-existing issue, but can the lockless check in
backlight_update_status() race with this teardown?

If a panel driver concurrently calls backlight_update_status(), which checks
bd->ops under the update_lock but without the ops_lock, and this function
sets bd->ops to NULL under the ops_lock:

include/linux/backlight.h:backlight_update_status() {
    ...
    mutex_lock(&bd->update_lock);
    if (bd->ops && bd->ops->update_status)
        ret =3D bd->ops->update_status(bd);
    ...
}

Could it lead to a use-after-free or executing unmapped module memory if the
driver is unbound right after the check passes?

[ ... ]
> +/**
> + * backlight_unregister_notifier - unregister a backlight notifier
> + * @nb: notifier block to unregister
> + *
> + * Register a notifier to get notified when backlight devices get regist=
ered
> + * or unregistered.

[Severity: Low]
This kerneldoc description appears to be copied directly from
backlight_register_notifier().

Should this be updated to describe unregistering a notifier instead?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
use-after-free in backlight_device_get_by_type() in the same file.

drivers/video/backlight/backlight.c:backlight_device_get_by_type() {
    ...
    mutex_unlock(&backlight_dev_list_mutex);
    return found ? bd : NULL;
}

This function returns a matched backlight_device pointer without taking a
reference count via get_device(). If the backlight device is concurrently
unregistered, the device could be freed, leaving the caller with a dangling
pointer.

Should this function increment the reference count before returning?

> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index f29a9ef1052e7..d905173c7f73c 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
[ ... ]
> +enum backlight_notification {
> +	/**
> +	 * @BACKLIGHT_REGISTERED: The backlight device is registered.
> +	 */
> +	BACKLIGHT_REGISTERED,
> +
> +	/**
> +	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
> +	 */

[Severity: Low]
Is the word revice a typo for device here?

> +	BACKLIGHT_UNREGISTERED,
> +};
[ ... ]
>  void backlight_force_update(struct backlight_device *bd,
>  			    enum backlight_update_reason reason);
> +int backlight_register_notifier(struct notifier_block *nb);
> +int backlight_unregister_notifier(struct notifier_block *nb);
>  struct backlight_device *backlight_device_get_by_name(const char *name);

[Severity: Low]
Does this header need a forward declaration of struct notifier_block, or an
include of linux/notifier.h?

Relying on implicit includes could cause build failures in downstream modul=
es
that include this header.

[Severity: High]
This is a pre-existing issue, but there appears to be a potential data race
regarding state in backlight_enable() and backlight_disable().

include/linux/backlight.h:backlight_enable() {
    ...
    bd->props.power =3D BACKLIGHT_POWER_ON;
    bd->props.state &=3D ~BL_CORE_FBBLANK;
    ...
}

These functions modify the state locklessly. Since other backlight
functions like backlight_suspend() modify the same state while holding
the ops_lock, could a concurrent call to backlight_enable() silently
overwrite and lose bits like BL_CORE_SUSPENDED?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624165751.2014=
759-1-mario.limonciello@amd.com?part=3D1
