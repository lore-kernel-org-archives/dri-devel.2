Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7191AC54EFC
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9748710E543;
	Tue, 28 Jul 2026 08:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ef1KFYbY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD11A10E543
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 08:34:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A08F943EEC;
 Tue, 28 Jul 2026 08:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A16E1F000E9;
 Tue, 28 Jul 2026 08:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785227654;
 bh=oSgw9JKuyf5VJGRcraqf0O7rqLlJ0lkZHOdrngWFHX8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ef1KFYbYIUFBtkNycLs1pkUu799W/QqCBjmj89IlyqXSXP2Qke++f4ml85URItIYL
 brPZ1A8GAUZb1y1AIwqC8+D6afuQNNoprwSSRyHVKNCogTRHcCgdr4wme7jKhfZNGu
 AW4kwi+KqmRrdqInTZG8v4ca8Y1ym50t0MzJBU/KuqAYdQLeBthVRwiDV5giNeUnpy
 HogvRxzMy+y4Wv/MVum3xr9rj0k1oFU5nLkpNpVCsqXKsKwaq+linD/NkLNTwlNsrH
 r98sRzQnj5vslVYuToizYjiBXIgHhyEtRtmaLtQL3B7QZq52CzVOO1CIcjyutKolgO
 OSKTsVVa4hJ0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/4] firmware: coreboot: Add CFR firmware attributes
 driver
To: "Sean Rhodes" <sean@starlabs.systems>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <c0e5bc377342ef9a5e2e90f65cc00093f89fbb1c.1785226810.git.sean@starlabs.systems>
References: <cover.1785226809.git.sean@starlabs.systems>
 <c0e5bc377342ef9a5e2e90f65cc00093f89fbb1c.1785226810.git.sean@starlabs.systems>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 08:34:13 +0000
Message-Id: <20260728083414.5A16E1F000E9@smtp.kernel.org>
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
- [Medium] Mixing goto-based error handling with scope-based cleanup helper=
s (`__free` and `guard`) in the same function.
--

--- Patch [4]: [PATCH v10 4/4] firmware: coreboot: Add CFR firmware attribu=
tes driver ---
commit f075e88024f4dbd198791a1dc20f657a026b2206
Author: Sean Rhodes <sean@starlabs.systems>

firmware: coreboot: Add CFR firmware attributes driver

This commit adds a firmware-attributes driver for coreboot CFR settings. It
exposes runtime EFI variable-backed configuration options to userspace via
sysfs, allowing modification and handling of runtime-apply mechanisms.

Link: https://doc.coreboot.org/drivers/cfr.html
Link: https://doc.coreboot.org/drivers/cfr_internal.html

> diff --git a/drivers/firmware/coreboot/coreboot-cfr.c b/drivers/firmware/=
coreboot/coreboot-cfr.c
> new file mode 100644
> index 0000000000000..21b06aa363111
> --- /dev/null
> +++ b/drivers/firmware/coreboot/coreboot-cfr.c

[ ... ]

> +static int coreboot_cfr_write_value(struct coreboot_cfr_setting *setting,
> +				    u32 value)
> +{
> +	efi_char16_t *efi_name __free(kfree) =3D NULL;
> +	u32 attrs;
> +	u32 old;
> +	int restore_ret;
> +	int ret;
> +
> +	if (setting->read_only)
> +		return -EACCES;
> +
> +	efi_name =3D coreboot_cfr_efi_name(setting->name);
> +	if (IS_ERR(efi_name))
> +		return PTR_ERR(no_free_ptr(efi_name));
> +
> +	guard(mutex)(&setting->drvdata->lock);
> +
> +	ret =3D efivar_lock();
> +	if (ret)
> +		return ret;
> +
> +	ret =3D coreboot_cfr_read_efi_value(efi_name, &old, &attrs);
> +	if (ret)
> +		goto out_unlock_efi;

[ ... ]

> +
> +out_unlock_efi:
> +	efivar_unlock();
> +	return ret;
> +}

[Severity: Medium]
Does this mix goto-based error handling with scope-based cleanups in the sa=
me
function?

According to include/linux/cleanup.h, the expectation is that usage of goto
and cleanup helpers (like __free and guard) should never be mixed in the
same routine. Mixing them creates confusing resource ownership semantics and
increases the risk of future resource leaks.

Could this be unified to exclusively use either traditional goto labels or
scope-based cleanups? For instance, efivar_lock() could potentially use a
cleanup helper to avoid the goto out_unlock_efi labels entirely.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785226809.gi=
t.sean@starlabs.systems?part=3D4
