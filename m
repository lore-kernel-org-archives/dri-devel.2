Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAAEC5DF9B
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E7F10E7D0;
	Mon, 24 Aug 2026 15:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KwpO5taU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D9510E7D0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:20:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0039140866;
 Mon, 24 Aug 2026 15:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA4B1F000E9;
 Mon, 24 Aug 2026 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787584820;
 bh=V6ZsKXO4eWIak24P9iGiDbWL/+AoVe+EYKTS2Dq4DCE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KwpO5taU+wd0x270k/swGoy1MLLHD+xDZ85rDjQYu/hOijCnzLJFjZb8mX8rIQLVm
 BtRVGF9ZspIsvTLsNw/kT5ibpKYx1qaxptxZ0hPo6tB7JRpSo3xLSiFjmxOUwSNsMh
 bCUupO9tbQ03bG3MNO3S+35EcbVs9tIVFAA5+PcLmANIdkAo69LUAT5n1KS5vSrz2Z
 k5vUNCtI4KCQEcPz68ri/t29mBiOQJRHc2gwFMy+brUZx22G/pMW8Sdz+PdY7/q3hh
 E5uRQ0tNPJRHp3SZ4IFZ+T1QNdmPPohQX/EBqM/Q3O+Cd6m0oOh/EmudVlMz1Lq8Ut
 1n8QAKtID/aEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 RESEND 1/5] platform/x86: Sort firmware attributes
 class includes
To: "Sean Rhodes" <sean@starlabs.systems>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <b967ec0f8adb69417a3d81ee5546e4a238e29e11.1787584107.git.sean@starlabs.systems>
References: <cover.1787584107.git.sean@starlabs.systems>
 <b967ec0f8adb69417a3d81ee5546e4a238e29e11.1787584107.git.sean@starlabs.systems>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:20:20 +0000
Message-Id: <20260824152020.BAA4B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds array read in get_instance_id macro due to an off-by=
-one error.
- [High] Out-of-bounds heap read and write in attribute_property_store macr=
o via memchr.
--

--- Patch [1]: [PATCH v13 RESEND 1/5] platform/x86: Sort firmware attribute=
s class includes ---
commit dff06344a1a1c35eb28b9e59670eeac00408066c
Author: Sean Rhodes <sean@starlabs.systems>

platform/x86: Sort firmware attributes class includes

Move firmware_attributes_class.h into the main include block and sort the
affected includes. This lets the header move replace each include in place.

> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers=
/platform/x86/dell/dell-wmi-sysman/sysman.c
> index ab46a023cc34d..4ff9003c6589b 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -8,18 +8,19 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =20
>  #include <linux/align.h>
> -#include <linux/fs.h>
>  #include <linux/dmi.h>
> -#include <linux/module.h>
> +#include "../../firmware_attributes_class.h"
> +#include <linux/fs.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/nls.h>
>  #include <linux/string.h>
>  #include <linux/sysfs.h>
>  #include <linux/wmi.h>
> +
>  #include "dell-wmi-sysman.h"

[Severity: High]
This is a pre-existing issue, but does the get_instance_id() macro in
dell-wmi-sysman.h have an off-by-one error in its loop condition?

drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h:get_instance_id=
() {
	...
	for (i =3D 0; i <=3D wmi_priv.type##_instances_count; i++) {
		if (!(strcmp(kobj->name, wmi_priv.type##_data[i].attribute_name)))
	...
}

If no match is found among the valid entries, the loop will evaluate=20
i =3D instances_count and access wmi_priv.type##_data[i].attribute_name, wh=
ich
is memory beyond the allocated array. The subsequent strcmp() function will
then dereference this out-of-bounds heap memory.

[Severity: High]
This is a pre-existing issue, but does the attribute_property_store() macro=
 in=20
dell-wmi-sysman.h have an out-of-bounds memory access?

drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h:attribute_prope=
rty_store() {
	...
	buf_cp =3D kstrdup(buf, GFP_KERNEL);
	if (!buf_cp)
		return -ENOMEM;
	p =3D memchr(buf_cp, '\n', count);
=09
	if (p !=3D NULL)
		*p =3D '\0';
	...
}

kstrdup() determines the allocation size using strlen(buf). If a user
provides an input buffer with an embedded null byte before the newline
character, kstrdup() will allocate a buffer smaller than the user-provided
count.

Subsequently, memchr() searches for a newline character up to count bytes,=
=20
reading beyond the dynamically allocated memory. Furthermore, if a newline=
=20
character happens to be found in the out-of-bounds memory block, the code=20
executes *p =3D '\0', causing an out-of-bounds heap write.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787584107.gi=
t.sean@starlabs.systems?part=3D1
