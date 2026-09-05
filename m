Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17B2C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C1F10E3D7;
	Sat,  5 Sep 2026 18:29:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XaZ1FQeE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 505A810E3D7
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:29:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F49043589;
 Sat,  5 Sep 2026 18:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECE31F00A3A;
 Sat,  5 Sep 2026 18:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788632985;
 bh=wi1sauKhWvV4kPtTDgP3yGzbL5FEOtwaThHwBoQnDyw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XaZ1FQeEp+SpPEcczJTzqJnfzCiW670x3Wbic9pmHZs1uip56gDiDHKYxZ5Q2CVOP
 /qITO2fiYvP36LzBVRanoy2CK8yoQJZILXrUj+Kl3yvwzXc/Cwz0RWafWtY46LP0qE
 6HBNNGcJTqYG/ECO5Sy38goYS5JPT8ATa6hzqEIzlmDsPw4sSIqR08IrOLIJqycCTd
 5xfqJe3u0mK23n7stMXOJQ2fBougn6EmZs/QUW7KjTPZjlpifZqNA3HvBSU8aq+CnC
 XBBl116JHQBmSHNr+ewMEwNeEHc6ZCfHs0+Wppf1xCZ5ustJvwXUh2CCDoQ/lyrSkc
 VwNUrhjuybi4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 37/43] dyndbg: harden classmap and descriptor validation
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-37-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-37-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:29:44 +0000
Message-Id: <20260905182944.DECE31F00A3A@smtp.kernel.org>
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
- [Medium] Off-by-one error in runtime classmap offset validation restricts=
 the maximum valid class ID.
--

commit 9fc4489f7afee86c427de8b09e6f38f827d4fc24
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: harden classmap and descriptor validation

This commit improves classmap and descriptor validation by mirroring
compile-time limits of _DEFINE and adding run-time overlap checks for _USEd
classmaps. It scans module descriptors at load time to warn about missing
class_ids instead of waiting for a user query.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index a5d813ad323a1..b7ccf471b5efe 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -1524,10 +1543,47 @@ static int ddebug_add_module(struct _ddebug_info =
*di)
>  	dd_set_module_subrange(i, cm, &dt->info, maps);
>  	dd_set_module_subrange(i, cli, &dt->info, users);
> =20
> -	/* insure 2+ classmaps share the per-module 0..62 class_id space */
> +	/* validate the per-module shared 0..62 class_id space */
>  	for_subvec(i, cm, &dt->info, maps)
>  		if (ddebug_class_range_overlap(cm, &reserved_ids))
> -			goto cleanup;
> +			err =3D -EINVAL;
> +
> +	for_subvec(i, cli, &dt->info, users) {
> +		cm =3D cli->map;
> +		if (!cm) {
> +			pr_err("module %s: classmap not found for user\n", di->mod_name);
> +			err =3D -EINVAL;
> +			continue;
> +		}
> +
> +		if (cm->base + cm->length + cli->offset >=3D _DPRINTK_CLASS_DFLT) {

[Severity: Medium]
Does this condition have an off-by-one error that restricts the maximum val=
id
class ID?

The _DPRINTK_CLASS_DFLT macro is defined as 63, which means valid class IDs
range from 0 to 62. The maximum assigned class ID for a given map and offse=
t is
base + length + offset - 1. If base + length + offset =3D=3D 63, the maximum
assigned class ID is exactly 62, which should be valid.

Because the code checks if the sum is >=3D _DPRINTK_CLASS_DFLT, a valid
boundary case of 63 is erroneously flagged as an error. This shrinks the va=
lid
class ID space to 0..61 instead of the expected 0..62.

> +			pr_err("module %s: base:%d + classes.len:%d + cli.offset:%d must be <=
 %d\n",
> +			       di->mod_name, cm->base, cm->length,
> +			       cli->offset, _DPRINTK_CLASS_DFLT);
> +			err =3D -EINVAL;
> +			continue;
> +		}
> +
> +		if (ddebug_class_user_overlap(cli, &reserved_ids))
> +			err =3D -EINVAL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D37
