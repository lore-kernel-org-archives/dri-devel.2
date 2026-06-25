Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC7ACDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F34310E207;
	Thu, 25 Jun 2026 13:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KfRj3pGa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFE610E207
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:14:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD9CF40B7B;
 Thu, 25 Jun 2026 13:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5931F000E9;
 Thu, 25 Jun 2026 13:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782393283;
 bh=UqscKKJnDo7H5mi0pK7yBoP94HADWM4ddZmhrV73cwA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KfRj3pGaevXc2RHRpZKYnk2Qk6SqjADtFV59gpTzgFGsqOuzJV9oH90jmEc71OMnN
 q1UGEGJ/bYg3eR6OlGZMIrHyirtUndhmLU5a7zjrqnzLZ79j47qLmF7/3txxpcxlBE
 cWC72PTKJW2+GkxPAQO8XQipX3MNvbmQnc3k93PEQk2IvYum/jTWC4xfNsorxHsGJB
 SKXeYbgAy+CQG2f9Hy5926Cq+H9BB+8jn0bRyxm6Ow5PXBNBpK8O6xW4pWBIJOgMv+
 yiDIYaGrFTC6p0UIlllvIyfO4EMEJV0kzEwCNJQt8+508hs6wkNXRXA9VtP8VF55FX
 XNH1hwuSzM3dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/xe/i2c: Handler for SMBus Alerts
To: "Heikki Krogerus" <heikki.krogerus@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625125939.429078-3-heikki.krogerus@linux.intel.com>
References: <20260625125939.429078-1-heikki.krogerus@linux.intel.com>
 <20260625125939.429078-3-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 13:14:42 +0000
Message-Id: <20260625131443.9C5931F000E9@smtp.kernel.org>
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
- [Critical] Unconditional dereference of a potentially NULL I2C client poi=
nter when handling SMBus alerts.
- [High] Normal I2C adapter interrupts are not propagated to the adapter dr=
iver on the XE_CRESCENTISLAND platform, breaking standard I2C transfers.
- [High] Writing to a read-to-clear interrupt status register will fail to =
clear the interrupt, leading to an interrupt storm.
- [Low] DRM_XE unconditionally selects I2C_SMBUS, causing unmet dependencie=
s and build failures when I2C is not enabled.

Pre-existing issues:
- [High] Missing `cancel_work_sync()` in the device cleanup path allows pen=
ding asynchronous work to access freed memory.
--

commit 99e285e8af69e8587ef5c6dca5bee3189103c64e
Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: drm/xe/i2c: Handler for SMBus Alerts

This commit adds support for handling SMBus alerts in the XE I2C driver.
It introduces a new client for the alert device and an interrupt handling
path to forward alerts to the SMBus core.

> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -46,6 +46,7 @@ config DRM_XE
>  	select WANT_DEV_COREDUMP
>  	select AUXILIARY_BUS
>  	select REGMAP if I2C
> +	select I2C_SMBUS

[Severity: Low]
Does this select statement need to be guarded conditionally or have a
dependency on I2C added to DRM_XE?

Selecting I2C_SMBUS unconditionally without inheriting its dependency on I2C
can cause unmet dependency warnings and build failures when I2C is disabled.

> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
[ ... ]
> @@ -61,6 +65,37 @@ static inline void xe_i2c_read_endpoint(struct xe_mmio=
 *mmio, void *ep)
>  	val[1] =3D xe_mmio_read32(mmio, REG_SG_REMAP_ADDR_POSTFIX);
>  }
> =20
> +static void xe_i2c_handle_smbus_alert(struct xe_i2c *i2c)
> +{
> +	u32 stat;
> +
> +	stat =3D xe_mmio_read32(i2c->mmio, I2C_REG(DW_IC_SMBUS_INTR_STAT));
> +	if (!stat)
> +		return;
> +
> +	xe_mmio_write32(i2c->mmio, I2C_REG(DW_IC_CLR_SMBUS_INTR), stat);

[Severity: High]
Will this successfully clear the interrupt?

Synopsys DesignWare I2C DW_IC_CLR_* registers typically use read-to-clear
semantics. Writing to this register might not clear the hardware interrupt,
potentially leading to an interrupt storm when the ISR returns.

> +
> +	if (stat & DW_IC_SMBUS_INTR_ALERT)
> +		i2c_handle_smbus_alert(i2c->client[XE_I2C_CLIENT_ALERT]);

[Severity: Critical]
Is it possible for i2c->client[XE_I2C_CLIENT_ALERT] to be NULL here?

The client registration happens asynchronously in xe_i2c_client_work(). If =
an
SMBus alert hardware interrupt fires before the async workqueue executes, or
if the client registration fails, passing a NULL pointer to
i2c_handle_smbus_alert() will cause a NULL pointer dereference.

> +}
[ ... ]
> @@ -182,7 +222,10 @@ void xe_i2c_irq_handler(struct xe_device *xe, u32 ma=
ster_ctl)
>  		return;
> =20
>  	/* Forward interrupt to I2C adapter */
> -	generic_handle_irq_safe(xe->i2c->adapter_irq);
> +	if (xe->info.platform =3D=3D XE_CRESCENTISLAND)
> +		xe_i2c_handle_smbus_alert(xe->i2c);
> +	else
> +		generic_handle_irq_safe(xe->i2c->adapter_irq);

[Severity: High]
Does this prevent regular I2C adapter interrupts from being handled on the
XE_CRESCENTISLAND platform?

By placing generic_handle_irq_safe() in the else branch, it seems normal I2C
transfers might time out and fail because their hardware interrupts are
entirely skipped on this platform.

>  	/* Deassert after I2C adapter clears the interrupt */
>  	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, 0, PCI_COMMAND_INTX_DISABLE);
[ ... ]
> @@ -307,8 +350,10 @@ static void xe_i2c_remove(void *data)
>  	struct xe_i2c *i2c =3D data;
>  	unsigned int i;
> =20
> -	for (i =3D 0; i < XE_I2C_MAX_CLIENTS; i++)
> +	for (i =3D 0; i < XE_I2C_MAX_CLIENTS; i++) {
>  		i2c_unregister_device(i2c->client[i]);
> +		i2c->client[i] =3D NULL;
> +	}
> =20
>  	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
>  	xe_i2c_unregister_adapter(i2c);

[Severity: High]
This is a pre-existing issue, but is there a missing call to
cancel_work_sync() in this teardown path?

The asynchronous workqueue item i2c->work is scheduled when the I2C adapter
is added. If this device is removed while the work is still pending or
running, xe_i2c_client_work() could dereference freed memory after
xe_i2c_remove() completes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625125939.4290=
78-1-heikki.krogerus@linux.intel.com?part=3D2
