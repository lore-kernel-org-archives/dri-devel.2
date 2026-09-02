Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D732FC624DA
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C956210E512;
	Wed,  2 Sep 2026 19:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bXOOn9Xg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2FAE10E512
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 19:40:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B270600D1;
 Wed,  2 Sep 2026 19:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CA71F00A3D;
 Wed,  2 Sep 2026 19:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788378019;
 bh=PALKTjy0D+OvkoFBib2UtmVziFV+rpFKjYlKBxwNLgs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bXOOn9XgRLVwYm0Ye6llhFb0LNmKeBzhQGbKrqK96D2oNAKyBUSdN4JqG2Gshgujw
 WKWmnX8goSsYssOsPpsqJZAjbP/XKuvoTUcz2ovuOXf5GzAdoW7/4cz5kf59KBsomQ
 5H0CYs8RK8Sqm5jc09dZwjcvzXKET2dbyEQ5aSC0PHj5PyDV5DIiDpXxMXsi+CkeMm
 RgX/7kk29BBuCLLxhKyciZnGB1+AbSkr8TiA49uvW8hPdYU9lLtLEwv9ItUWGxeiav
 8qVwAhiWhr7yHT88qdW/UVeB10iX+P+meRlU9YyNci2RfhSI1D0UNJQSf3tDVjPtn4
 By1OoZkJzpA9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
To: mohit.dsor@oss.qualcomm.com
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260903-lt9611c-v7-v12-2-9414d2b3bd6d@oss.qualcomm.com>
References: <20260903-lt9611c-v7-v12-0-9414d2b3bd6d@oss.qualcomm.com>
 <20260903-lt9611c-v7-v12-2-9414d2b3bd6d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 19:40:19 +0000
Message-Id: <20260902194019.89CA71F00A3D@smtp.kernel.org>
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
- [High] Double-free of device nodes `dsi0_node` and `dsi1_node` on error p=
ath due to mixing manual `of_node_put()` with `__free(device_node)`.
- [High] Regmap page cache becomes desynchronized after hardware resets, ca=
using subsequent I2C operations to access the wrong registers.
- [Medium] Mixing `__free()` scope-based cleanup with `goto`-based error ha=
ndling.
- [Medium] Bitwise operations in the IRQ handler corrupt the interrupt clea=
r register if multiple interrupts are pending.
- [Low] I2C device ID array is not declared const and uses positional initi=
alizers.
--

commit 79126746072fd218bc214fab821198cac4bc10bd
Author: Sunyun Yang <syyang@lontium.com>

drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

This commit adds a new DRM bridge driver for the Lontium LT9611C(EX/UXD)
MIPI DSI to HDMI bridge chip. It supports configuring the hardware, handling
interrupts, and triggering firmware upgrades over I2C.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/b=
ridge/lontium-lt9611c.c
> new file mode 100644
> index 0000000000000..ef1e9726fdd3c
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
[ ... ]
> +static void lt9611c_reset(struct lt9611c *lt9611c)
> +{
> +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> +	usleep_range(10000, 12000);
> +
> +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> +	msleep(400);
> +}

[Severity: High]
Does resetting the hardware here desynchronize the regmap page cache?

The physical reset via GPIO clears the chip's internal page register back
to 0x00, but regmap's cached page selector isn't explicitly cleared. If the
last I2C operation was on a different page (like 0xe0), subsequent writes
might skip the page selector write because regmap thinks it is already set,
causing those operations to mistakenly target page 0x00 instead.

[ ... ]
> +static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
> +{
[ ... ]
> +	/* Clear interrupt: hardware requires two writes with delay */
> +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & BIT(0));
> +	usleep_range(10000, 12000);
> +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & (~BIT(0)));

[Severity: Medium]
Will this corrupt the clear register if multiple interrupts are pending?

By writing irq_status & (~BIT(0)) back to the hardware clear register, if
there are other interrupts pending in irq_status (for example, bit 1 is set=
),
this will mistakenly write a 1 to those other bits during the final clear=20
step for bit 0.

[ ... ]
> +static int lt9611c_parse_dt(struct device *dev,
> +			    struct lt9611c *lt9611c,
> +			    struct device_node **dsi0_node,
> +			    struct device_node **dsi1_node)
> +{
[ ... ]
> +err_put_dsi1:
> +	of_node_put(*dsi1_node);
> +	of_node_put(*dsi0_node);
> +	return ret;
> +}
[ ... ]
> +static int lt9611c_probe(struct i2c_client *client)
> +{
[ ... ]
> +	struct device_node *dsi0_node __free(device_node) =3D NULL;
> +	struct device_node *dsi1_node __free(device_node) =3D NULL;
[ ... ]
> +	ret =3D lt9611c_parse_dt(dev, lt9611c, &dsi0_node, &dsi1_node);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to parse device tree\n");

[Severity: High]
Can this cause a double-free of the device nodes?

The pointers dsi0_node and dsi1_node are declared with __free(device_node).
If lt9611c_parse_dt() fails, it manually calls of_node_put() on both nodes
but does not set the caller's pointers to NULL. When lt9611c_probe() returns
an error here, its scope ends and the automatic cleanup will call of_node_p=
ut()
again on the same pointers, leading to a reference count underflow.

[ ... ]
> +	/* Attach primary DSI */
> +	dsi =3D lt9611c_attach_dsi(lt9611c, dsi0_node);
> +	if (IS_ERR(dsi)) {
> +		ret =3D PTR_ERR(dsi);
> +		goto err_remove_bridge;
> +	}

[Severity: Medium]
Does this mix scope-based cleanup with goto-based error handling?

The function declares variables with __free(device_node) at the top but uses
goto err_remove_bridge and goto err_disable_regulators for cleanup here and
below. The kernel cleanup subsystem prohibits mixing goto and __free() in t=
he
same function to avoid confusing ownership semantics and resource leaks.

[ ... ]
> +static struct i2c_device_id lt9611c_id[] =3D {
> +	{ "lt9611c",   (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611C]   },
> +	{ "lt9611ex",  (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611EX]  },
> +	{ "lt9611uxd", (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611UXD] },
> +	{ /* sentinel */ }
> +};

[Severity: Low]
Is this missing a const qualifier and named initializers?

The I2C subsystem dictates that initialized arrays of type struct i2c_devic=
e_id
must be declared const and use named initializers instead of positional one=
s.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-lt9611c-v7=
-v12-0-9414d2b3bd6d@oss.qualcomm.com?part=3D2
