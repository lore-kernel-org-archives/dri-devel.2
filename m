Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5069CC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 20:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E71210E4CA;
	Wed, 22 Jul 2026 20:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PQ3g8GGE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46C610E4CA
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 20:58:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B55A43647;
 Wed, 22 Jul 2026 20:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DDA1F000E9;
 Wed, 22 Jul 2026 20:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784753899;
 bh=2efdzSVz+LRfaPt15cAMEOK01WwdRBIG530Mio1PQyY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PQ3g8GGE/PySIaiwIBVVGwR/SBNx9MQra4VJJrK/bLD2UZkbVfXX/PDxD175aN4r9
 wuDkNso+aNewOzxJ+fGyAVLMJEUYKpcufS8J+e2SyW7vwzriE87c+CWE1FU/lSMWAg
 8z95T9ycXe3hxIzxu0uZVPsvaRyYeo0PQMqPN7ViCh1OIscJ5UTSiY+u6RWX7XCESA
 7hgr6CkC1oGBcOG4lLn+P2trPUTs9VQ+Cnc/TKk5Mcuet5jcNv4rb9JDVA4pi/bd2O
 B69VrKScGJLWiR7AZhB6eptGOG2lQDg2bt0NmLlKfR2ixtMEOr1GpMWiJ3V1YkQvAx
 CcqPVlE5xjqtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/11] drm/bridge: it6505: complete poweroff even if
 disabling regulators fails
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <51bec6ff870eb67415408268a798a934dcad6a6c.1784717129.git.daniel@makrotopia.org>
References: <cover.1784717129.git.daniel@makrotopia.org>
 <51bec6ff870eb67415408268a798a934dcad6a6c.1784717129.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 20:58:18 +0000
Message-Id: <20260722205819.04DDA1F000E9@smtp.kernel.org>
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
- [High] Ignoring regulator_disable() failure causes a permanent regulator =
reference leak and hardware state corruption.

Pre-existing issues:
- [High] I2C over AUX reads and writes silently ignore timeout and NACK err=
ors, returning success with garbage data.
- [High] Device power state functions lack synchronization, leading to race=
 conditions between extcon events and system suspend.
- [High] Background works are not cancelled during system suspend, risking =
I/O operations on powered-down hardware.
- [High] Regulators are disabled in the same order they are enabled, violat=
ing power sequencing constraints.
--

--- Patch [4]: [PATCH v5 04/11] drm/bridge: it6505: complete poweroff even =
if disabling regulators fails ---
commit f1926053557b0f8b21512c835ff0e5a067508980
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: complete poweroff even if disabling regulators fails

This patch modifies the driver to continue the power-off sequence and set
the powered state to false even if regulator_disable() fails. This aims
to prevent the bridge from being left deaf to hotplug interrupts by ensuring
the state transition completes.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index ff6471d3ef7ab..0f79ddfd1501e 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2810,13 +2810,15 @@ static int it6505_poweroff(struct it6505 *it6505)
>  	if (pdata->pwr18) {
>  		err =3D regulator_disable(pdata->pwr18);

[Severity: High]
This is a pre-existing issue, but does disabling the regulators in the same
order they were enabled violate power sequencing constraints?

In it6505_poweron(), pwr18 is enabled before ovdd. Here in
it6505_poweroff(), pwr18 is disabled before ovdd.

Could removing core power before I/O power cause back-powering and latch-up
in CMOS logic, potentially damaging the hardware?

>  		if (err)
> -			return err;
> +			dev_err(dev, "cannot disable pwr18 regulator: %d",
> +				err);

[Severity: High]
If regulator_disable() fails (for example, due to an I2C timeout on a PMIC),
does ignoring the error here cause a permanent regulator reference leak?

When the regulator core returns an error during disable, it does not
decrement the consumer's enable_count.

Since this patch ignores the error and forces it6505->powered to false, the
next power-on will increment the enable_count from 1 to 2.

Because the count never reaches 0 again, will the regulator core permanently
leave the hardware powered on?

[ ... ]

While reviewing this driver, I also noticed a few other pre-existing issues:

it6505_aux_i2c_readb() {
    for (retry =3D 0; retry < AUX_I2C_DEFER_RETRY; retry++) {
        // ...
        if (ret >=3D 0)
            break;
    }

    for (i =3D 0; i < size; i++)
        buf[i] =3D it6505_read(it6505, REG_AUX_USER_RXB(0 + i));

    return size;
}

[Severity: High]
This is a pre-existing issue, but does this I2C read silently ignore timeout
and NACK errors?

When an AUX I2C transfer encounters a NACK or timeout, it6505_aux_i2c_wait()
returns a negative error code.

If the retry loop exhausts all retries without breaking, the function
unconditionally executes the register read loop and returns the requested
size as if the transfer succeeded.

Can this result in the DRM core receiving uninitialized memory or garbage
data instead of an error, leading to corrupted EDID parsing?


it6505_extcon_work() {
    // ...
    if (ret < 0)
        it6505_poweron(it6505);
}

[Severity: High]
This is a pre-existing issue, but do the device power state functions lack
synchronization?

During system suspend, pm_runtime_force_suspend() calls
it6505_bridge_suspend(), which invokes it6505_poweroff() without acquiring
extcon_lock.

Concurrently, if an extcon event triggers it6505_extcon_work() on the
non-freezable system_wq, it attempts pm_runtime_get_sync().

If runtime PM is disabled during suspend, this fails and the fallback path
directly calls it6505_poweron().

Could this race condition lead to unbalanced IRQ enable depths or corrupted
regulator states?


it6505_bridge_suspend() {
    // ...
    it6505_remove_edid(it6505);
    return it6505_poweroff(it6505);
}

[Severity: High]
This is a pre-existing issue, but does the suspend handler fail to cancel
background works before powering off the hardware?

it6505_bridge_suspend() calls it6505_poweroff() but does not call
cancel_work_sync() for link_works or extcon_wq.

Because these works are scheduled on the non-freezable system_wq, could
they execute concurrently during the suspend process and attempt I/O
operations on powered-down hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784717129.gi=
t.daniel@makrotopia.org?part=3D4
