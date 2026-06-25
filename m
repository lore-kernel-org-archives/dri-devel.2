Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9AACDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CAEB10E1F3;
	Thu, 25 Jun 2026 13:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kd0zrf9I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417B110E1F3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:16:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 256B540B4B;
 Thu, 25 Jun 2026 13:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD041F000E9;
 Thu, 25 Jun 2026 13:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782393381;
 bh=82xJDBL6Dd4He8g9tOS4cAzpKQqoGdkGYL2iJOYValo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kd0zrf9I6b9GKbHrOi4AB8SnzUatBxhSngP4LMWlax2n62z6NX36CDlq/pQJ1RM9V
 5ofgOCd9W+i5NjWcC5VdodeXoAM/H6NZC/ttf0kAcrYPfU15VVFg8j+/bBn34jGm3t
 Zoj4cUt5uhMVPXu3jq2UU+R0doPAlCU4Cv8MzpqSKJUORxQ+uLb/TzK/yHskqLqt4t
 8l8uflOx8WcDtUvkxN2qo/l/gk/+or2f2J/ws7TmWBENPVHoilPXAf7NdJKtDMgnsZ
 yyRDUcUv6gyiBDNpxT2gf8gRMD/oN49zz8s8LLlWALiYR4tl8mh+yzKeQ0OssyzVPl
 8xXMXiZ/GAMoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/xe/mcu_i2c: Take over control of the
 controller enabling
To: "Heikki Krogerus" <heikki.krogerus@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625125939.429078-4-heikki.krogerus@linux.intel.com>
References: <20260625125939.429078-1-heikki.krogerus@linux.intel.com>
 <20260625125939.429078-4-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 13:16:20 +0000
Message-Id: <20260625131620.CBD041F000E9@smtp.kernel.org>
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
- [Critical] Faking the disabled state of the I2C controller while keeping =
it physically enabled causes an unhandled IRQ storm if the hardware generat=
es an unmasked interrupt.
- [Critical] Bypassing the core driver's wait loop shifts the wait into a m=
uch shorter atomic context, causing Target Address (TAR) writes to be silen=
tly dropped if the bus is active.
- [High] I2C timing and FIFO configuration registers are silently ignored b=
y the hardware because the controller is forcibly kept enabled and the regm=
ap interceptor fails to temporarily disable it.
- [High] Dereferencing `i2c->adapter` in `xe_i2c_disable` causes a NULL poi=
nter dereference if a timeout occurs during device probe.
--

commit ef1d705e3f064c441441c723d0ee6ac370743a6b
Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>

drm/xe/mcu_i2c: Take over control of the controller enabling

This commit modifies the mcu_i2c driver to maintain the I2C controller
in an enabled state to prevent incorrect low-power state assumptions by
the hardware. It intercepts writes to the IC_ENABLE register and
temporarily disables the controller when programming configuration
and target address registers.

> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index 0495b561957a2..e2d8e77653cf2 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
[ ... ]
> @@ -294,11 +295,40 @@ static void xe_i2c_remove_irq(struct xe_i2c *i2c)
>  	irq_domain_remove(i2c->irqdomain);
>  }
> =20
> +/* See "Disabling DW_apb_i2c" in the DesignWare DW_abp_i2c databook. */
> +static void xe_i2c_disable(struct xe_i2c *i2c)
> +{
> +	int timeout =3D 100;
> +	u32 status;
> +
> +	xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), 1, 0);
> +
> +	do {
> +		status =3D xe_mmio_read32(i2c->mmio, I2C_REG(DW_IC_ENABLE_STATUS));
> +		if (!(status & 1))
> +			return;
> +		/* Can't sleep here. */
> +		udelay(25);
> +	} while (timeout--);
> +
> +	dev_warn(&i2c->adapter->dev, "timeout in disabling adapter\n");

[Severity: High]
If a timeout occurs during device probe when i2c_dw_init() writes to
DW_IC_CON, does this dereference a NULL pointer?

During probe, xe_i2c_write() temporarily disables the hardware via
xe_i2c_disable(). If this times out, it logs a warning using i2c->adapter,
but i2c->adapter appears to only be assigned later during the
BUS_NOTIFY_ADD_DEVICE notifier.

> +}
> +
>  static int xe_i2c_read(void *context, unsigned int reg, unsigned int *va=
l)
>  {
>  	struct xe_i2c *i2c =3D context;
> =20
> -	*val =3D xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
> +	*val =3D xe_mmio_read32(i2c->mmio, I2C_REG(reg));
> +
> +	switch (reg) {
> +	case DW_IC_ENABLE:
> +	case DW_IC_ENABLE_STATUS:
> +		FIELD_MODIFY(DW_IC_ENABLE_ENABLE, val,
> +			     i2c->ic_enable & DW_IC_ENABLE_ENABLE);
> +		break;

[Severity: Critical]
Will this spoofed status cause an unhandled interrupt storm if the hardware
generates an unmasked interrupt?

Because the physical controller remains enabled while xe_i2c_read() returns
a faked disabled status, there is a window where an interrupt can fire.
When i2c_dw_isr_master() runs, it reads the spoofed disabled status,
assumes the interrupt is spurious, and immediately returns IRQ_NONE
without clearing it. Does this lead to the hardware continuously asserting
the interrupt?

> +	default:
> +		break;
> +	}
> =20
>  	return 0;
>  }
> @@ -307,7 +337,28 @@ static int xe_i2c_write(void *context, unsigned int =
reg, unsigned int val)
>  {
>  	struct xe_i2c *i2c =3D context;
> =20
> -	xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
> +	switch (reg) {
> +	case DW_IC_CON:
> +	case DW_IC_TAR:
> +	case DW_IC_SAR:
> +		/* Disable the controller. */
> +		xe_i2c_disable(i2c);
> +
> +		/* Write the register. */
> +		xe_mmio_write32(i2c->mmio, I2C_REG(reg), val);

[Severity: Critical]
Is it possible for Target Address writes to be silently dropped if the bus
is active and disabling takes longer than 2.5ms?

Since xe_i2c_read() spoofs DW_IC_ENABLE_STATUS, the core dw_i2c driver's
sleep-capable wait loop in __i2c_dw_disable() exits immediately. This shifts
the wait burden to xe_i2c_disable() which runs under a regmap spinlock with
a 2.5ms maximum timeout (100 iterations of udelay(25)).

If xe_i2c_disable() times out and returns silently, xe_i2c_write() blindly
writes the new target address (DW_IC_TAR) while the hardware is still
physically enabled. Because the hardware discards this write, could
subsequent data payloads be erroneously sent to the previously addressed
slave device?

> +
> +		/* Enable the controller. */
> +		xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), 0, 1);
> +		break;
> +	case DW_IC_ENABLE:
> +		i2c->ic_enable =3D val;
> +		/* Other fields can be updated except the enable bit. */
> +		val |=3D DW_IC_ENABLE_ENABLE;
> +		fallthrough;
> +	default:
> +		xe_mmio_write32(i2c->mmio, I2C_REG(reg), val);
> +		break;

[Severity: High]
Are timing and FIFO registers silently ignored by the hardware when they fa=
ll
through to this default case?

The DesignWare I2C Databook requires that timing registers
(e.g., DW_IC_SS_SCL_HCNT) and FIFO thresholds are written when the
controller is disabled. Since this patch forces the hardware to remain
enabled, any writes to registers that fall through to the default case are
executed while the hardware is still enabled, which causes the hardware to
silently discard them.

> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625125939.4290=
78-1-heikki.krogerus@linux.intel.com?part=3D3
