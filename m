Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC38C4452B
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6447E10E354;
	Wed, 22 Jul 2026 01:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L372j+3Y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1835610E354
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:21:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 684E0601EC;
 Wed, 22 Jul 2026 01:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4C51F000E9;
 Wed, 22 Jul 2026 01:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784683285;
 bh=SzMamv30BUIltegsVQ+49B5qSmaEno+SUPwhWw+bfJ4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L372j+3Y0SGNHy1uJP8iNGtj7sVh7B2jPLz1sPzQhfPebSqNaklkPaMa9+MlcNZjo
 lbYkYrrfergpCiXQmE5bAQQpTun6UrQpO5rW9dI4d2bexBYz5lJbJfDjLhNes0AW63
 QvXxGTSWr7cBxmeTfLgd5ejx41sx+EiAILOvPPjHhxnbqV2KbSk5U+XIAljF1lZWMj
 6jtgEZC3b/9gpd/fKZDL9k7OXIV+32llTLSdSD4z0HXG9CTUBFM3YR2z0E2ecQ7KMS
 ekb7/fAX4TkgLBDY/P+FxPaoqhzTCFx6ybLYRfKCrZ2JX+42SBihaHURYIlaIn1S06
 tv9dqtvt5N1Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] drm/bridge: it6505: disable runtime PM on remove
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <59d6066b37a33878c8673bf1659e16fd2624cae4.1784681487.git.daniel@makrotopia.org>
References: <cover.1784681487.git.daniel@makrotopia.org>
 <59d6066b37a33878c8673bf1659e16fd2624cae4.1784681487.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 01:21:24 +0000
Message-Id: <20260722012125.0A4C51F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The driver leaks the runtime PM usage counter if unbound while the=
 DisplayPort cable is connected, breaking subsequent driver binds.
- [High] Resource registration asymmetry for the DRM DP AUX adapter causes =
registration failures on re-attach.
- [Medium] Missing error check on I2C reads in the IRQ handler causes negat=
ive error codes to be misinterpreted as phantom interrupts.
- [Low] The PM callback structure is assigned unconditionally, violating co=
nditional compilation guidelines and creating dead code.
--

--- Patch [2]: [PATCH v4 2/5] drm/bridge: it6505: disable runtime PM on rem=
ove ---
commit 6b8ae3352685a773af0a6bbc5a90e489dc50ff6b
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: disable runtime PM on remove

This commit disables runtime PM in the remove callback for the it6505 bridge
driver. It cancels work items before disabling runtime PM and powering off =
the
chip, which prevents the device from having an unbalanced disable depth aft=
er
unbind.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 7873ae6df3aff..2a8298ee6c03c 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -3655,6 +3655,7 @@ static void it6505_i2c_remove(struct i2c_client *cl=
ient)
>  	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
>  	cancel_delayed_work_sync(&it6505->hdcp_work);
>  	cancel_work_sync(&it6505->extcon_wq);
> +	pm_runtime_disable(&client->dev);

[Severity: High]
This is a pre-existing issue, but does the driver leak the runtime PM usage
counter if unbound while the DisplayPort cable is connected?

If the driver is unbound while a display is connected, it6505_extcon_work()=
 has
previously called pm_runtime_get_sync() and elevated the PM usage counter.

The remove callback disables runtime PM via pm_runtime_disable() but fails =
to
drop the usage counter.

Because the usage count belongs to the struct device and persists across
bind/unbind cycles, a subsequent bind will start with an elevated usage cou=
nt.
When extcon_work runs on the new bind, pm_runtime_get_sync() will return 1,
bypassing the it6505_poweron() sequence.

Can this cause the hardware to remain unpowered and all subsequent I2C
operations to fail?

>  	it6505_poweroff(it6505);
>  	it6505_remove_edid(it6505);
>  }

[Severity: High]
This is a pre-existing issue, but does the resource registration asymmetry =
for
the DRM DP AUX adapter cause registration failures on re-attach?

The driver registers the AUX channel via drm_dp_aux_register() in the
it6505_bridge_attach() callback, but unregisters it via
drm_dp_aux_unregister() in the I2C driver's it6505_i2c_remove() callback.

If the parent DRM device is unbound, the bridge is detached but the I2C dri=
ver
remains bound. When the DRM device is rebound, the bridge is attached again,
and drm_dp_aux_register() is called a second time on the same instance with=
out
it having been unregistered.

Can this cause kernel warnings and registration failures in the I2C core?


[Severity: Medium]
This is a pre-existing issue, but can the missing error check on I2C reads =
in
the IRQ handler cause negative error codes to be misinterpreted as phantom
interrupts?

In it6505_int_threaded_handler(), the driver reads interrupt status registe=
rs
via it6505_read(). If the I2C read fails, it returns a negative error code:

    int_status[0] =3D it6505_read(it6505, INT_STATUS_01);
    int_status[1] =3D it6505_read(it6505, INT_STATUS_02);
    int_status[2] =3D it6505_read(it6505, INT_STATUS_03);

This negative integer is stored in the int_status array and passed to
it6505_test_bit(), which accesses it as an unsigned int.

Since a negative value has most of its bits set to 1, it6505_test_bit()
evaluates to true for multiple interrupt sources.

Does this cause spurious execution of interrupt sub-handlers and unpredicta=
ble
state changes?


[Severity: Low]
This is a pre-existing issue, but is the PM callback structure assigned
unconditionally?

In the it6505_i2c_driver structure, the .pm field is assigned directly to
&it6505_bridge_pm_ops.

According to the Power Management subsystem guidelines, this assignment sho=
uld
be wrapped with the pm_ptr() macro to ensure the pointer becomes NULL when
CONFIG_PM is disabled.

Does this unconditional assignment create dead code and compiler warnings w=
hen
power management is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784681487.gi=
t.daniel@makrotopia.org?part=3D2
