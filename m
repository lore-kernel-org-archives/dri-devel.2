Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C197C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C680810EFA6;
	Wed,  8 Jul 2026 02:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VcC4PHx4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97E0B10EFA6
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:37:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4AD66001A;
 Wed,  8 Jul 2026 02:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B9E1F000E9;
 Wed,  8 Jul 2026 02:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783478245;
 bh=c1JuxJTYI9Cou+7ltriAtaCjSpE1PC98rSxYT5CMPr0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VcC4PHx4ClHt6zI+9/JsC7K2oBHyjSJnaLWgwr8ky/DABPGlUYzdAdhNJ21IvrGrk
 M7T03WTnKeozeB97VlMpX5dS+PWxR+kMnxGKQ+vBSVWvA664mFFxt/CPzlQXeAYrGi
 zxOE8kiwARQRdsHR4HGZo+gkt7FTo0UePBoS5vuoCbsgqn2RJlmNKhYsgNtBlIIQfc
 q0INN1mpPy3VH5VtTHDoI7nhSFBz9joRwE9CHYFNq5Ehsa4jAkiUHLM4o9sSZGQP1/
 q2kIIp/Za4VtJ080FdtksPyBDh/LcfMH+/FLWkIYaXEiFEalwSzbvrOplv6sIJ8IOS
 JXoloZpIESqYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 19/24] dyndbg: pin class param storage to u32
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-dd-maint-2-v6-19-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-19-381f3edb0045@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:37:24 +0000
Message-Id: <20260708023725.52B9E1F000E9@smtp.kernel.org>
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
- [Medium] Support for classmaps with more than 32 classes is broken, causi=
ng undefined behavior on 32-bit architectures and silent truncation on 64-b=
it architectures.
--

--- Patch [19]: [PATCH v6 19/24] dyndbg: pin class param storage to u32 ---
commit df6ebc9b56fab43581ec7860d30aab6f33272ee2
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: pin class param storage to u32

This commit changes the storage of dyndbg class parameters from unsigned lo=
ng
to u32 for consistency across architectures. It also shrinks __drm_debug ba=
ck
to u32.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index d99c69b9ad12f..af05f4ae3b55e 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -643,24 +643,27 @@ static int ddebug_apply_class_bitmap(const struct d=
debug_class_param *dcp,
>  	int bi, ct;
> =20
>  	if (*new_bits !=3D old_bits)
> -		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
> +		v2pr_info("apply bitmap: 0x%x to: 0x%x for %s\n", *new_bits,
>  			  old_bits, query_modname ?: "'*'");
> =20
>  	for (bi =3D 0; bi < map->length; bi++) {
> -		if (test_bit(bi, new_bits) =3D=3D test_bit(bi, &old_bits))
> +		bool new_b =3D !!(*new_bits & BIT(bi));
> +		bool old_b =3D !!(old_bits & BIT(bi));

[Severity: Medium]
Since classmaps can theoretically contain up to 63 classes (as mentioned in
the commit message), is there a risk of an out-of-bounds shift on 32-bit
architectures?

BIT(bi) expands to 1UL << bi, so if map->length is greater than 32, this
shift would exceed the capacity of an unsigned long on 32-bit systems.

On 64-bit systems, *new_bits is now a u32. When it is combined with BIT(bi)
using a bitwise AND, the u32 is zero-extended. Will this cause new_b and
old_b to always evaluate to 0 for classes >=3D 32, silently ignoring the
requested state?

[ ... ]
> @@ -704,24 +707,24 @@ static int param_set_dyndbg_module_classes(const ch=
ar *instr,
[ ... ]
>  	case DD_CLASS_TYPE_LEVEL_NUM:
>  		/* input is bitpos, of highest verbosity to be enabled */
>  		if (inrep > map->length) {
> -			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
> +			pr_warn("%s: level:%u exceeds max:%d, clamping\n",
>  				KP_NAME(kp), inrep, map->length);
>  			inrep =3D map->length;
>  		}
>  		old_bits =3D CLASSMAP_BITMASK(*dcp->lvl);
>  		new_bits =3D CLASSMAP_BITMASK(inrep);

[Severity: Medium]
Will this silently prevent enablement of classes >=3D 32?

CLASSMAP_BITMASK was changed to limit the generated mask to 32 bits, but
map->length is not restricted to 32.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint-2=
-v6-0-381f3edb0045@gmail.com?part=3D19
