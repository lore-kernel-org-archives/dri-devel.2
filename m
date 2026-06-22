Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B65FCD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 774AB10E661;
	Mon, 22 Jun 2026 12:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hO3CsKnZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6943E10E661
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:04:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B10640DD1;
 Mon, 22 Jun 2026 12:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BEF1F000E9;
 Mon, 22 Jun 2026 12:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782129851;
 bh=IWiWmbOiGZHefIHPtyfhImK7vY7H3IZsWr30S0MTQUE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hO3CsKnZnbw86axdYySI1Uq12lPooCJw721tKvaWdi/4WfnaD6WXBY5+QODsxI9dO
 Oa1qfgTj5YlFkvfNOD5RyfNtlPoHvnErwedceIVfyVMbNjiHf578FS6XzIWfqom6C/
 X130NSjxIN51POXSwWjhVDcNfynuXplvFzJHWa0u/c+0S/382Rtl429Cj2X4eAqEPC
 99c+I+qDCHqaocGZlqBYEDNVZV/vTZ/xDAihERw7x8wWKYkNTbbs6xpYsCaTzCyspn
 a5C9Nfjy6E5lTE6M1hOhcA1WYx9EXxV8Q/kj1awCICfgHdZV59jwoWLdlw4BNsAssB
 8n8CTAfC7OxHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] drm/xe/mcu_i2c: Take over control of the
 controller enabling
To: "Heikki Krogerus" <heikki.krogerus@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 12:04:09 +0000
Message-Id: <20260622120410.D7BEF1F000E9@smtp.kernel.org>
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
- [Critical] Calling a sleeping function `usleep_range()` inside `xe_i2c_di=
sable()` triggers a 'BUG: scheduling while atomic' panic because it execute=
s under a regmap spinlock.
- [High] Keeping the hardware permanently enabled by intercepting IC_ENABLE=
 causes critical configuration registers (clock timings, FIFO thresholds) t=
o be silently dropped by the I2C controller.
- [High] Intercepting IC_ENABLE breaks the DesignWare I2C ABORT command, pr=
eventing error recovery and causing spurious timeouts.
- [High] Unhandled disable timeout drops IC_TAR writes, sending I2C message=
s to the wrong target.

Pre-existing issues:
- [High] Missing `cancel_work_sync()` in the teardown path leads to a poten=
tial Use-After-Free of `struct xe_i2c`.
--

commit 468f953254a43b46d9448f5006c92c7e5fe3466a
Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>

drm/xe/mcu_i2c: Take over control of the controller enabling

This commit intercepts IC_ENABLE register accesses to keep the I2C
controller enabled, as some platforms tie the power state to this register.
It temporarily disables the controller only when updating IC_CON, IC_TAR,
or IC_SAR registers.

> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index 732ad6ee05e9c..45fa9094b6142 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
[ ... ]
> @@ -261,11 +262,49 @@ static void xe_i2c_remove_irq(struct xe_i2c *i2c)
>  	irq_domain_remove(i2c->irqdomain);
>  }
> =20
> +#define IC_CON				0x00
> +#define IC_TAR				0x04
> +#define IC_SAR				0x08
> +#define IC_ENABLE			0x6c
> +#define IC_ENABLE_STATUS		0x9c
> +
> +/* See "Disabling DW_apb_i2c" in the DesignWare DW_abp_i2c databook. */
> +static int xe_i2c_disable(struct xe_i2c *i2c)
> +{
> +	int timeout =3D 100;
> +	u32 status;
> +
> +	do {
> +		/* Disable.*/
> +		xe_mmio_rmw32(i2c->mmio, XE_REG(IC_ENABLE + I2C_MEM_SPACE_OFFSET), 1, =
0);
> +
> +		/* Verify. */
> +		status =3D xe_mmio_read32(i2c->mmio, XE_REG(IC_ENABLE_STATUS + I2C_MEM=
_SPACE_OFFSET));
> +		if (!(status & 1))
> +			return 0;
> +
> +		/* Repeat. */
> +		usleep_range(25, 250);

[Severity: Critical]
Does this sleeping function execute in an atomic context?

The regmap instance for this I2C controller is configured with .fast_io =3D
true in i2c_regmap_config, which means the regmap core protects register
operations with a spinlock (spin_lock_irqsave).

Since xe_i2c_disable() is called from the regmap write callback
xe_i2c_write(), calling usleep_range() while holding this spinlock will
trigger a scheduling while atomic panic.

> +	} while (timeout--);
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static int xe_i2c_read(void *context, unsigned int reg, unsigned int *va=
l)
>  {
>  	struct xe_i2c *i2c =3D context;
> =20
> -	*val =3D xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
> +	switch (reg) {
> +	case IC_ENABLE:
> +		*val =3D i2c->ic_enable;
> +		break;
> +	case IC_ENABLE_STATUS:
> +		*val =3D i2c->ic_enable & 1; /* NOTE: Checking only the enable bit */
> +		break;

[Severity: High]
Will returning a cached value here break the I2C ABORT sequence?

When an I2C transfer stalls, the i2c-designware driver initiates error
recovery by writing the ABORT bit (bit 1) to IC_ENABLE and polling the
register until the hardware auto-clears the bit.

If xe_i2c_read() returns the cached i2c->ic_enable value where the ABORT
bit remains set, the polling loop in i2c_dw_xfer() will unconditionally
time out.

> +	default:
> +		*val =3D xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
> +		break;
> +	}
> =20
>  	return 0;
>  }
> @@ -273,8 +312,30 @@ static int xe_i2c_read(void *context, unsigned int r=
eg, unsigned int *val)
>  static int xe_i2c_write(void *context, unsigned int reg, unsigned int va=
l)
>  {
>  	struct xe_i2c *i2c =3D context;
> +	int ret;
> =20
> -	xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
> +	switch (reg) {
> +	case IC_CON:
> +	case IC_TAR:
> +	case IC_SAR:
> +		/* Disable the controller. */
> +		ret =3D xe_i2c_disable(i2c);
> +		if (ret)
> +			return ret;
> +
> +		/* Write the register. */
> +		xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);

[Severity: High]
If xe_i2c_disable() times out, is it safe to skip the register write?

The i2c-designware master driver ignores the return value of regmap_write()
when programming the target address (DW_IC_TAR). If this write is skipped
due to a timeout, the driver will proceed to transmit the message using the
previously configured target address, which could send data to the wrong
peripheral.

> +
> +		/* Enable the controller. */
> +		xe_mmio_rmw32(i2c->mmio, XE_REG(IC_ENABLE + I2C_MEM_SPACE_OFFSET), 0, =
1);
> +		break;
> +	case IC_ENABLE:
> +		i2c->ic_enable =3D val;
> +		break;

[Severity: High]
Does caching the IC_ENABLE write prevent error recovery?

Because the value is only cached in i2c->ic_enable and not forwarded to the
hardware, the physical controller will never execute the abort sequence
requested by the i2c-designware driver.

> +	default:
> +		xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
> +		break;

[Severity: High]
Will the hardware ignore writes to timing and configuration registers?

The DesignWare APB I2C hardware requires the controller to be disabled
before modifying configuration registers like clock timings (IC_*_SCL_HCNT)
and FIFO thresholds.

Since these registers fall through to this default case, they are sent to
the hardware while it is still actively enabled. The hardware drops these
writes, which could leave the controller operating with incorrect default
settings after system resume.

> +	}
> =20
>  	return 0;
>  }

drivers/gpu/drm/xe/xe_i2c.c:xe_i2c_remove() {
    ...
    for (i =3D 0; i < XE_I2C_MAX_CLIENTS; i++)
        i2c_unregister_device(i2c->client[i]);

    bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
    xe_i2c_unregister_adapter(i2c);
    xe_i2c_remove_irq(i2c);
}

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing
cancel_work_sync() in the teardown path?

The probe function initializes i2c->work, which is scheduled asynchronously.
Since struct xe_i2c is managed by devres, it will be freed immediately
after xe_i2c_remove() returns. If the work is still pending or executing,
it could dereference the freed i2c memory, leading to a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622114759.3464=
047-1-heikki.krogerus@linux.intel.com?part=3D2
