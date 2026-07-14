Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44402C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4ECF10EDED;
	Tue, 14 Jul 2026 16:08:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JDooNuiG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E763410EDED
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 16:08:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B14F9413C9;
 Tue, 14 Jul 2026 16:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA9B1F000E9;
 Tue, 14 Jul 2026 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784045294;
 bh=JE9aoAyM+Ji9IJXJXeicEhJkiknwGEHk7yrb4zd+SIk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JDooNuiG86fiOrjetlceQkGsxICbeghHbQu1F9Xb4kbQGS49Jo+U0LEi9Gv1xcmGk
 0+rnORbH+zw7OW6sfqGmNT/pmWii8YAMDJYFgrzb+fawJz6sfLmXVsTFqBTH1Nuk31
 mO4BggfQAZuTETAZV9IwAPuAwo4maSjfOIwjAHm/LB7kS5hOjENzS9igBkDQxynbrO
 1z4X83O9yPbtLt9ZaSDUkAS/FzqfeNsUtre0i82FE5Vv998F9cA97N5ulo7uj811/F
 F9StFVbAuhcV3/uxDaWULHQP3z6m1cxaJcrFa1/1MOKDHX4dhkXa5Hwm4zOsa0T0uI
 lQUb4Wl1ftfxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] Add Advantech EIO driver
To: "Ramiro Oliveira" <ramiro.oliveira@advantech.com>
Cc: linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-watchdog@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org
In-Reply-To: <20260714-upstream-v2-v2-1-76e5e41026db@advantech.com>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-1-76e5e41026db@advantech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 16:08:13 +0000
Message-Id: <20260714160814.3CA9B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 15 potential issue=
(s) to consider:
- [Critical] Driver uses zero-initialized `pmc[0]` array without verifying =
if the primary EC was successfully initialized, causing unintended I/O on s=
ystem port 0x00.
- [High] Missing success return for supported legacy code bases in `firmwar=
e_code_base()`.
- [High] Incorrect validation of `devm_ioport_map()` return value.
- [Medium] The `mfd_cell` array `eio_devs` is not declared as `const`.
- [Medium] The driver uses `PLATFORM_DEVID_NONE` instead of `PLATFORM_DEVID=
_AUTO`, risking sysfs naming collisions.
- [Medium] `acpi_ram_access()` truncates negative error codes into positive=
 8-bit integers.
- [Medium] The requested region for the PNP base ports is off-by-one and fa=
ils to reserve the data port.
- [Medium] Missing resource request for the dynamically discovered PMC comm=
and port.
- [Medium] Unaligned memory access and endianness assumptions in `info_show=
()`.
- [Medium] The IO port memory mapping is sized statically up to `0x49A`, bu=
t accesses dynamically discovered hardware registers which can exceed the m=
apped bounds.
- [Medium] `pmc_clear` checks the wrong status bit (`IBF` instead of `OBF`)=
 before attempting to clear pending garbage data.
- [Medium] Hardware PNP configuration mode is left unlocked on error and sk=
ip paths in `eio_init()`.
- [Low] The commit message prefix violates MFD subsystem naming conventions.
- [Low] `MFD_EIO` uses the `isa_driver` API but lacks a Kconfig dependency =
on `ISA_BUS_API`.
- [Low] Driver-specific header file is improperly placed in the global `inc=
lude/linux/mfd/` directory.
--

--- Patch [1]: [PATCH v2 1/8] Add Advantech EIO driver ---
commit d4de2a217ca69b28de748d9dadb7323cafed3d8e
Author: Ramiro Oliveira <ramiro.oliveira@advantech.com>
Subject: Add Advantech EIO driver

Creating the core driver for Advantech EIO, all other drivers depend on thi=
s.

> Add Advantech EIO driver

[Severity: Low]
This isn't a bug, but the commit message prefix violates MFD subsystem nami=
ng
conventions. Should it follow the mfd: <Driver>: <Capitalized description>
format?

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 35f6e9b76d056..42d133a2eb8dc 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig

[ ... ]

> @@ -517,6 +517,16 @@ config MFD_DLN2
>  	  etc. must be enabled in order to use the functionality of
>  	  the device.
> =20
> +config MFD_EIO
> +	tristate "Advantech EIO core"

[Severity: Low]
Does this config need a dependency on ISA_BUS_API? This driver uses the
isa_driver API which requires CONFIG_ISA_BUS_API to avoid build errors on
architectures lacking ISA support.

> +	select MFD_CORE

[ ... ]

> diff --git a/drivers/mfd/eio_core.c b/drivers/mfd/eio_core.c
> new file mode 100644
> index 0000000000000..25873c0618127
> --- /dev/null
> +++ b/drivers/mfd/eio_core.c

[ ... ]

> +static struct mfd_cell eio_devs[] =3D {

[Severity: Medium]
Should this array be declared as static const? The MFD subsystem guidelines
require child platform data arrays to reside in read-only memory.

> +	MFD_CELL_NAME("eio_wdt"),
> +	MFD_CELL_NAME("gpio_eio"),
> +	MFD_CELL_NAME("eio_hwmon"),

[ ... ]

> +static ssize_t info_show(struct device *dev, struct device_attribute *at=
tr, char *buf)
> +{
> +	uint i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(attrs); i++) {
> +		int ret;
> +		char str[32] =3D "";
> +		int val;

[ ... ]

> +		if (attrs[i].size !=3D 4)
> +			return sysfs_emit(buf, "%s\n", str);
> +
> +		val =3D *(u32 *)str;

[Severity: Medium]
Can this cast cause read corruption on big-endian platforms or potential
alignment faults? Would using get_unaligned_le32() be safer here?

> +
> +		if (attrs[i].type =3D=3D HEX)

[ ... ]

> +static void pmc_clear(struct device *dev, int id)
> +{
> +	struct eio_dev *eio =3D dev_get_drvdata(dev);
> +	unsigned int val;
> +
> +	/* Check if input buffer blocked */
> +	if ((pmc_read_status(dev, id) & EIO_PMC_STATUS_IBF) =3D=3D 0)

[Severity: Medium]
Is this checking the wrong status bit? To check if there is residual output
data to clear from the EC buffer, shouldn't this check OBF (Output Buffer
Full) instead of IBF (Input Buffer Full)?

> +		return;
> +
> +	/* Read out previous garbage */

[ ... ]

> +static int get_pmc_port(struct device *dev, int id,
> +			struct eio_dev_port *port)
> +{

[ ... ]

> +	/* Make sure IO ports are not occupied */
> +	if (!devm_request_region(dev, pmc->data, 2, KBUILD_MODNAME)) {

[Severity: Medium]
Does this leave the PMC command port (pmc->cmd) unprotected? It looks like
only the data port is requested here.

> +		dev_err(dev, "Request region %X error\n", pmc->data);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int eio_init(struct device *dev)
> +{
> +	struct eio_dev *eio =3D dev_get_drvdata(dev);
> +	u16 chip_id;
> +	unsigned int msb, lsb;
> +	int tmp;
> +	int ret =3D -ENOMEM;
> +
> +	for (int chip =3D 0; chip < ARRAY_SIZE(pnp_port); chip++) {
> +		struct eio_dev_port *port =3D pnp_port + chip;
> +
> +		if (!devm_request_region(dev, pnp_port[chip].idx_port,
> +					 pnp_port[chip].data_port -
> +						 pnp_port[chip].idx_port,

[Severity: Medium]
Is this calculation off-by-one? The subtraction data_port - idx_port evalua=
tes
to 1, which only requests the index port. Should it include a + 1 to reserve
the data port as well?

> +					 KBUILD_MODNAME))
> +			continue;
> +
> +		ret =3D eio_unlock_port(dev, port);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D eio_pnp_read(dev, port, EIO_CHIPID1, &msb);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D eio_pnp_read(dev, port, EIO_CHIPID2, &lsb);
> +		if (ret)
> +			return ret;
> +
> +		chip_id =3D (msb << 8) | lsb;
> +
> +		if (chip_id !=3D EIO200_CHIPID && chip_id !=3D EIO201_211_CHIPID)
> +			continue;

[Severity: Medium]
Does this continue bypass eio_lock_port() and leave the hardware PNP
configuration mode unlocked on error and skip paths? This might leave the
index and data ports susceptible to accidental modification.

[Severity: Critical]
Additionally, if this loop completes without finding a valid chip_id, the l=
oop
exits and returns ret =3D 0. This causes eio_init() to succeed, and the=20
uninitialized pmc[0] array is then passed to acpi_ram_access(). This could
trigger regmap operations on system port 0x00 (system DMA controller base),
potentially leading to hardware corruption or a system hang on unsupported
hardware.

> +
> +		/* Turn on the enable flag */
> +		ret =3D eio_pnp_read(dev, port, EIO_SIOCTRL, &tmp);

[ ... ]

> +static uint8_t acpi_ram_access(struct device *dev, uint8_t offset)

[Severity: Medium]
Does this function truncate negative error codes into positive 8-bit intege=
rs?
Since standard negative error codes (like -110 for timeout) can be returned=
 by
PMC operations, the caller might misinterpret corrupted error codes as valid
ACPI RAM data.

> +{
> +	uint8_t val;
> +	int ret;
> +	struct eio_dev *eio =3D dev_get_drvdata(dev);

[ ... ]

> +static int firmware_code_base(struct device *dev)
> +{
> +	struct eio_dev *eio =3D dev_get_drvdata(dev);
> +	u8 ic_vendor, ic_code, code_base;
> +
> +	ic_vendor =3D acpi_ram_access(dev, EIO_ACPIRAM_ICVENDOR);
> +	ic_code =3D acpi_ram_access(dev, EIO_ACPIRAM_ICCODE);
> +	code_base =3D acpi_ram_access(dev, EIO_ACPIRAM_CODEBASE);
> +
> +	if (ic_vendor !=3D 'R')
> +		return -ENODEV;
> +
> +	if (ic_code !=3D EIO200_ICCODE && ic_code !=3D EIO201_ICCODE &&
> +	    ic_code !=3D EIO211_ICCODE)
> +		goto err;
> +
> +	if (code_base =3D=3D EIO_ACPIRAM_CODEBASE_NEW) {
> +		eio->flag |=3D EIO_F_NEW_CODE_BASE;
> +		return 0;
> +	}
> +
> +	if (code_base =3D=3D 0 &&
> +	    (ic_code !=3D EIO201_ICCODE && ic_code !=3D EIO211_ICCODE)) {
> +		dev_info(dev, "Old code base not supported.");
> +		return -ENODEV;
> +	}
> +
> +err:

[Severity: High]
Does this logic miss a success return for supported legacy code bases? If
code_base =3D=3D 0 and ic_code is a supported legacy code, the if block is
skipped and execution falls through to the err: label, erroneously returning
-ENODEV and failing to probe on supported hardware.

> +	/* Codebase error. This should only happen on firmware error. */
> +	dev_err(dev,
> +		"Codebase check fail: vendor: 0x%X, code: 0x%X, base: 0x%X\n",

[ ... ]

> +static int eio_probe(struct device *dev, unsigned int id)
> +{
> +	int ret =3D 0;
> +	struct eio_dev *eio;
> +
> +	eio =3D devm_kzalloc(dev, sizeof(*eio), GFP_KERNEL);
> +	if (!eio)
> +		return -ENOMEM;
> +
> +	eio->dev =3D dev;
> +	mutex_init(&eio->mutex);
> +
> +	eio->iomem =3D devm_ioport_map(dev, 0, EIO_SUB_PNP_DATA + 1);

[Severity: Medium]
Is this static mapping bound potentially too small? The mapping strictly co=
vers
up to EIO_SUB_PNP_DATA + 1 (0x49B), but the driver accesses dynamically
discovered hardware registers which can exceed these bounds anywhere in the
16-bit IO space.

> +	if (IS_ERR(eio->iomem))

[Severity: High]
Will this error check incorrectly pass on memory exhaustion?
devm_ioport_map() returns NULL on failure, so checking IS_ERR instead of
NULL could lead to a NULL pointer dereference in devm_regmap_init_mmio().

> +		return PTR_ERR(eio->iomem);
> +
> +	eio->map =3D devm_regmap_init_mmio(dev, eio->iomem, &pnp_regmap_config);
> +	if (IS_ERR(eio->map))
> +		return PTR_ERR(eio->map);
> +
> +	/* Publish instance for subdrivers (dev_get_drvdata(dev->parent)) */
> +	dev_set_drvdata(dev, eio);
> +
> +	if (eio_init(dev))
> +		return -ENODEV;
> +
> +	ret =3D firmware_code_base(dev);
> +	if (ret) {
> +		dev_err(dev, "Chip code base check fail\n");
> +		return ret;
> +	}
> +
> +	ret =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,

[Severity: Medium]
Should PLATFORM_DEVID_AUTO be used here instead of PLATFORM_DEVID_NONE?
The MFD subsystem guidelines require using PLATFORM_DEVID_AUTO for automatic
cell indexing to avoid sysfs naming collisions.

> +				   eio_devs, ARRAY_SIZE(eio_devs),
> +				   NULL, 0, NULL);

[ ... ]

> diff --git a/include/linux/mfd/eio.h b/include/linux/mfd/eio.h
> new file mode 100644
> index 0000000000000..c2daad41318bf
> --- /dev/null
> +++ b/include/linux/mfd/eio.h
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Advantech Co., Ltd.
> + */
> +
> +#ifndef _MFD_EIO_H_
> +#define _MFD_EIO_H_

[Severity: Low]
This isn't a bug, but should this driver-specific header file be placed in
drivers/mfd/ instead of the global include/linux/mfd/ directory? The MFD
subsystem guidelines explicitly dictate keeping headers local if they are o=
nly
used by the parent and immediate children.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-upstream-v=
2-v2-0-76e5e41026db@advantech.com?part=3D1
