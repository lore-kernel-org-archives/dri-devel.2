Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9635FCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3ABF10E663;
	Mon, 22 Jun 2026 12:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CEAHMF3M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229F510E663
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:04:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0BE64444BE;
 Mon, 22 Jun 2026 12:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1091F000E9;
 Mon, 22 Jun 2026 12:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782129856;
 bh=KiaGk6uk256Lfme45C0Y1acUpayH97gS/UDZQJLB4gs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CEAHMF3MAVcedbHV+IiGLhmMsC8/MXffRb2AP7pi3j+a9tJzW9LgHiC9HuVUWBlpD
 pL9/eewecefVYlbNRqjKnWweqXTNPC8Ha11wVufL4YHMwkiUK1qR1GjkwbdWcf1uz4
 LqrqHGhfZMBd/ZqjlzPkXu0KUBWnIvTWpZavXcMLCUr4G1eekL1WASg9cDpZIgRWpc
 zyRQIoW/JxEiDELKjrnAwBTZkkiFehHtvK+tlq1eHtmzuhgnq0l2UwwSku84pW9Zvy
 vZdNSGPmafMz+rkzLw7jxlnvHvmFhJYSNNWKFuoryEIPFSDLnibgmqxX/j3dRffhgb
 R2Lre/bV66goQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] drm/xe/i2c: Handler for SMBus Alerts
To: "Heikki Krogerus" <heikki.krogerus@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622114759.3464047-2-heikki.krogerus@linux.intel.com>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-2-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 12:04:16 +0000
Message-Id: <20260622120416.BB1091F000E9@smtp.kernel.org>
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
- [High] Calling `i2c_new_smbus_alert_device()` with an uninitialized `i2c-=
>adapter` causes a kernel crash during probe.
- [High] `xe_i2c_remove()` unregisters the SMBus alert device twice, leadin=
g to a use-after-free and kernel crash.
- [High] The driver will fail to link (`undefined reference`) when `CONFIG_=
DRM_XE=3Dy` and `CONFIG_I2C_SMBUS=3Dm`.
- [High] Using `regmap_write()` to clear the SMBus alert interrupt register=
 fails to clear it, resulting in an interrupt storm.
- [High] The SMBus alert client device is unregistered and freed during dri=
ver removal while the I2C hardirq handler remains active, causing a use-aft=
er-free.
- [High] Calling regmap APIs in the hardirq handler without raw spinlocks c=
auses a "sleeping in atomic context" BUG on PREEMPT_RT kernels.
- [Medium] Disabling `CONFIG_I2C_SMBUS` causes the entire Xe driver probe t=
o fail on Crescent Island.
--

commit 4babbf281e90eb4de9750bdaf56676cc4600f883
Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>

drm/xe/i2c: Handler for SMBus Alerts

Some devices that are attached to the I2C controller use the
SMBus Alert signal for example to inform the host about
thermal events, so registering the default SMBus Alert
device device for them. The alert device makes sure that
the alert is processed and passed to the correct I2C client
driver.

> diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
> index 8e7b146880f46..9c8af00cf37fd 100644
> --- a/drivers/gpu/drm/xe/Makefile
> +++ b/drivers/gpu/drm/xe/Makefile
> @@ -153,6 +153,7 @@ xe-y +=3D xe_bb.o \
>  	xe_wopcm.o
> =20
>  xe-$(CONFIG_I2C)	+=3D xe_i2c.o
> +xe-$(CONFIG_I2C_SMBUS)	+=3D xe_i2c_smbus.o

[Severity: High]
Will this cause a build failure when CONFIG_DRM_XE=3Dy and CONFIG_I2C_SMBUS=
=3Dm?

If CONFIG_I2C_SMBUS is built as a module, xe_i2c_smbus.o is added to the xe=
-m
target. However, IS_ENABLED(CONFIG_I2C_SMBUS) in xe_i2c.h will still evalua=
te
to true, causing the built-in driver to expect the functions and resulting =
in
an undefined reference at link time.

> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index 706783863d07d..732ad6ee05e9c 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
[ ... ]
> @@ -182,7 +183,10 @@ void xe_i2c_irq_handler(struct xe_device *xe, u32 ma=
ster_ctl)
>  		return;
> =20
>  	/* Forward interrupt to I2C adapter */
> -	generic_handle_irq_safe(xe->i2c->adapter_irq);
> +	if (xe->i2c->smbus_alert)
> +		xe_i2c_handle_smbus_alert(xe->i2c);

[Severity: High]
Is there a race condition here during driver teardown that could cause a
use-after-free?

During teardown, the smbus_alert device is unregistered and freed, but the
i2c->smbus_alert pointer is not set to NULL. If a hardware interrupt fires
concurrently before the IRQ is completely disabled, this handler will
evaluate xe->i2c->smbus_alert as true and dereference the freed pointer.

> +	else
> +		generic_handle_irq_safe(xe->i2c->adapter_irq);
> =20
>  	/* Deassert after I2C adapter clears the interrupt */
[ ... ]
> @@ -232,6 +236,9 @@ static int xe_i2c_create_irq(struct xe_device *xe)
>  	    xe_survivability_mode_is_boot_enabled(xe))
>  		return 0;
> =20
> +	if (xe->info.platform =3D=3D XE_CRESCENTISLAND)
> +		return xe_i2c_register_smbus_alert(i2c);

[Severity: High]
Does this pass an uninitialized adapter to the SMBus registration?

This call happens during xe_i2c_probe() before the adapter is fully
initialized and registered. The i2c->adapter pointer is still NULL at
this point, which will cause i2c_new_smbus_alert_device() to crash when
it dereferences the adapter.

[Severity: Medium]
Should the driver fail to probe entirely if SMBus is disabled?

If the kernel is built without CONFIG_I2C_SMBUS, the stub for
xe_i2c_register_smbus_alert() returns -EOPNOTSUPP. Returning that error
here propagates up and causes the entire GPU driver probe to fail on this
platform.

> +
>  	domain =3D irq_domain_create_linear(dev_fwnode(i2c->drm_dev), 1, &xe_i2=
c_irq_ops, NULL);
>  	if (!domain)
>  		return -ENOMEM;
> @@ -244,6 +251,9 @@ static int xe_i2c_create_irq(struct xe_device *xe)
> =20
>  static void xe_i2c_remove_irq(struct xe_i2c *i2c)
>  {
> +	if (i2c->smbus_alert)
> +		i2c_unregister_device(i2c->smbus_alert);
> +

[Severity: High]
Does this trigger a double-free of the alert device?

During device removal, xe_i2c_remove() unregisters the adapter before
calling xe_i2c_remove_irq(). Unregistering the adapter synchronously removes
and frees all child clients, including the SMBus alert device. Calling
i2c_unregister_device() on it again here will access freed memory.

[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_i2c_smbus.c b/drivers/gpu/drm/xe/xe_i2=
c_smbus.c
> new file mode 100644
> index 0000000000000..185a6d2f0a508
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_i2c_smbus.c
[ ... ]
> +void xe_i2c_handle_smbus_alert(struct xe_i2c *i2c)
> +{
> +	u32 stat;
> +
> +	if (!i2c->smbus_alert)
> +		return;
> +
> +	regmap_read(i2c->regmap, DW_IC_SMBUS_INTR_STAT, &stat);

[Severity: High]
Can this sleep in atomic context?

This function is called from xe_i2c_irq_handler() which runs in hardirq
context. The regmap initialized for the I2C controller does not set
use_raw_spinlock to true.

On PREEMPT_RT kernels, the standard spinlock used by regmap becomes a
sleepable mutex, which will trigger a bug when acquired from hardirq contex=
t.

> +	if (!stat)
> +		return;
> +
> +	regmap_write(i2c->regmap, DW_IC_CLR_SMBUS_INTR, stat);

[Severity: High]
Does writing to this register properly clear the interrupt?

In Synopsys DesignWare I2C controllers, interrupt clear registers are
typically read-to-clear. A write operation is usually ignored by the
hardware. If the interrupt is not cleared, it will remain asserted and
cause an interrupt storm when the handler returns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622114759.3464=
047-1-heikki.krogerus@linux.intel.com?part=3D1
