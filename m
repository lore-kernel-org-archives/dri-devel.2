Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC97CD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 14:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0612E10E0A4;
	Sun, 14 Jun 2026 14:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nj9Vks/9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A744010E0A4
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 14:37:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CF7A43DE4;
 Sun, 14 Jun 2026 14:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA0E1F000E9;
 Sun, 14 Jun 2026 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781447831;
 bh=tRT49JWsFPWNQjgPaZwbIh84la4FNsn04AiOygn2F7U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Nj9Vks/96BDu1ewuqIa7RS0eiHbVBPEUd6YTzwQIpV+tKkVBWU9tSXVRyic7+vG+z
 4FObznAB1enZBtZV+T5d+/s73YVQGdh0ylE8/Zl4aZbgVehwyn9lQ0cy2mM1WcPWi5
 nKDmoIpUOz7nrq/1OL3LzfBwSMiM+hOuwmL6+8ShgT3Sm5O/YtDJ4HbQ9TdmdpQJAJ
 OzVAbM5d4zt2zug7736uGYza66f0NuN/eDZHiGIo3W8M6AaPckw2F+mgxpLcGW5fBP
 ZcSagmfR7YQhdYMZTyQzxF4BB+Kd9RjOktaxudkQJXzmaheN70AhsNkzNYYpK0RFFp
 NSsn+Qm+BP07A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/dsi: fix i2c adapter reference leak in
 i2c_adapter_lookup()
To: "Ma Ke" <make_ruc2021@163.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260614142250.2001136-1-make_ruc2021@163.com>
References: <20260614142250.2001136-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 14:37:10 +0000
Message-Id: <20260614143711.1BA0E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The static array `soc_gpio_table` caches `devm_`-managed `gpio_des=
c` pointers, leading to a Use-After-Free across driver reload.
- [Medium] Preexisting memory leak of the I2C adapter reference in i2c_acpi=
_new_device_by_fwnode().
- [Medium] Missing `pinctrl_unregister_mappings()` for `soc_pwm_pinctrl_map=
` leads to memory leaks and list growth on every driver probe.
--

commit 4de09f19213ae7f3a3c535d632462c31364389c5
Author: Ma Ke <make_ruc2021@163.com>

drm/i915/dsi: fix i2c adapter reference leak in i2c_adapter_lookup()

This commit addresses a reference leak in i2c_adapter_lookup(). It adds
a put_device() call to release the adapter returned by
i2c_acpi_find_adapter_by_handle(), preventing resource exhaustion over
repeated driver load/unload cycles.

> diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/d=
rm/i915/display/intel_dsi_vbt.c
> index fe12041e913cd..2097c5d17cb7a 100644
> --- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> +++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> @@ -460,8 +460,10 @@ static int i2c_adapter_lookup(struct acpi_resource *=
ares, void *data)
>  		return 1;
> =20
>  	adapter =3D i2c_acpi_find_adapter_by_handle(adapter_handle);
> -	if (adapter)
> +	if (adapter) {
>  		intel_dsi->i2c_bus_num =3D adapter->nr;
> +		put_device(&adapter->dev);
> +	}
> =20
>  	return 1;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed a potential use-after-free with soc_gpio_table:

drivers/gpu/drm/i915/display/intel_dsi_vbt.c:soc_gpio_set_value() {
	/* XXX: this table is a quick ugly hack. */
	static struct gpio_desc *soc_gpio_table[U8_MAX + 1];
	struct gpio_desc *gpio_desc =3D soc_gpio_table[gpio_index];

	if (gpio_desc) {
		gpiod_set_value(gpio_desc, value);
	} else {
		gpio_desc =3D devm_gpiod_get_index(display->drm->dev, con_id, idx,
						 value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
		...
		soc_gpio_table[gpio_index] =3D gpio_desc;
	}
}

Since soc_gpio_table is static, its lifetime spans across driver unbind
and rebind cycles.

When the driver is unbound, the devm-managed gpio_desc pointers are freed
by the device-managed resource infrastructure.

If the driver is later rebound, will soc_gpio_table still hold those
dangling pointers?

Could this lead to a use-after-free when soc_gpio_set_value() sees
gpio_desc is not NULL and passes the freed pointer to gpiod_set_value()?

[Severity: Medium]
This is another pre-existing issue in the same file. I noticed a potential
memory leak with pinctrl_register_mappings():

drivers/gpu/drm/i915/display/intel_dsi_vbt.c:intel_dsi_vbt_gpio_init() {
	...
	if (display->platform.valleyview && mipi_config->pwm_blc =3D=3D PPS_BLC_SO=
C) {
		...
		/* Ensure PWM0 pin is muxed as PWM instead of GPIO */
		ret =3D pinctrl_register_mappings(soc_pwm_pinctrl_map,
					     ARRAY_SIZE(soc_pwm_pinctrl_map));
		...
}

The pinctrl_register_mappings() function dynamically allocates memory for
the mappings and adds them to a global list.

Since there is no matching pinctrl_unregister_mappings() during driver
teardown, and it does not use a devm variant, does this leak memory and
indefinitely append duplicate entries to the global list every time the
driver is unbound and rebound?

[Severity: Medium]
This is a pre-existing issue in the I2C ACPI core code that resembles the f=
ix
in this patch. Does i2c_acpi_new_device_by_fwnode() also leak the adapter
reference?

drivers/i2c/i2c-core-acpi.c:i2c_acpi_new_device_by_fwnode() {
	...
	adapter =3D i2c_acpi_find_adapter_by_handle(lookup.adapter_handle);
	if (!adapter)
		return ERR_PTR(-EPROBE_DEFER);

	return i2c_new_client_device(adapter, info);
}

The function i2c_acpi_find_adapter_by_handle() returns an i2c_adapter point=
er
with its device reference count incremented.

If i2c_new_client_device() takes its own reference to the adapter during
registration but doesn't consume this initial lookup reference, does this
cause a permanent reference leak since we return immediately without
calling put_device(&adapter->dev)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614142250.2001=
136-1-make_ruc2021@163.com?part=3D1
