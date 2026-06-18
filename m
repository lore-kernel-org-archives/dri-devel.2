Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13347CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD4110ED9B;
	Thu, 18 Jun 2026 11:14:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L/j/dcez";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4272510ED9B
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 11:14:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 11E7543D8C;
 Thu, 18 Jun 2026 11:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC71C1F000E9;
 Thu, 18 Jun 2026 11:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781781287;
 bh=fhLvHlaH/dx5tuhRFwBhEvxZgQhA3CZ5Ds5+pMfWVII=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L/j/dceze3H6pQt2uUN1dnm8kiLighbEg4BU/bQ5XG41ymSUk3o6Uowv/ezoDo2WN
 fC1KLx2z0JXRK9heVxRD2JoduGvhUz1eYZ5dqkuQTlqbsTu+XTuusbH6off+2RZ3bJ
 hht6GzwYbR3CsMZ+b/NYg2d/oVxlsoI4giVl3i+R1X/evVzCxromFL2Vk+x48oBWmR
 0LamI6iBjEDw5/Y/yiTLN7Pd874nUR0hDnZBdhsmEcR+loGTBSXz7Io8HnYozpdNIZ
 oJX+9YcutTMBDdLu1WNA2UwyhoaDYjT8YgPzobJ0e55mKbPRMKWkpbqGLAzytNACto
 /1l+ZNvfLf4CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/i915/dsi: fix i2c adapter reference leak in
 i2c_adapter_lookup()
To: "Ma Ke" <make_ruc2021@163.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618110446.518501-1-make_ruc2021@163.com>
References: <20260618110446.518501-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 11:14:46 +0000
Message-Id: <20260618111446.CC71C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing memory leak of an I2C adapter device reference in i2c=
_acpi_new_device_by_fwnode().
--

commit 66de974c089b4da323236a8e423198078a9b4d70
Author: Ma Ke <make_ruc2021@163.com>

drm/i915/dsi: fix i2c adapter reference leak in i2c_adapter_lookup()

This commit fixes an I2C adapter device reference leak in
i2c_adapter_lookup() by adding a put_device() call to release the
reference acquired by i2c_acpi_find_adapter_by_handle().

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
This is a pre-existing issue, but while reviewing this fix, it appears the
same leak exists in the I2C ACPI core.

Does i2c_acpi_new_device_by_fwnode() in drivers/i2c/i2c-core-acpi.c also ne=
ed
to release the adapter reference?

drivers/i2c/i2c-core-acpi.c:i2c_acpi_new_device_by_fwnode() {
    ...
	adapter =3D i2c_acpi_find_adapter_by_handle(lookup.adapter_handle);
	if (!adapter)
		return ERR_PTR(-EPROBE_DEFER);

	return i2c_new_client_device(adapter, info);
}

The adapter reference is acquired through bus_find_device() internally but
never released.

Since i2c_del_adapter() waits for the adapter's reference count to reach ze=
ro
via wait_for_completion(&adap->dev_released), could this leak cause any
subsequent attempts to unbind or remove the underlying I2C adapter to hang
forever in uninterruptible sleep, blocking system power management
transitions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618110446.5185=
01-1-make_ruc2021@163.com?part=3D1
