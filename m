Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC22EC4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 21:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4642410E287;
	Tue, 21 Jul 2026 21:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ONXXii7f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB8F10E287
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 21:10:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52D5860A65;
 Tue, 21 Jul 2026 21:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28351F000E9;
 Tue, 21 Jul 2026 21:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784668253;
 bh=knrpHStVOCVVxYCMRyxiaKE5pUbZPv/jIqbcEWBXL4w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ONXXii7f1qOoq6UFEABW1cRY9mc8NBzdY7/V23lOz5Zw9hp2uUSbnpDDTCCTNg14K
 eLd2WpEEkmyGRR8LDo9MIRbzgr69qRXkbobU4C3DLvqf6rnzBom4TkaYk1IYQSYvTb
 kLtu4ioTRMCLKKATH9KRkRFmkkNvH0Vgrg6wSSxgQcCyaoRxH1BNGbcSGPN2Y1A6v5
 vZH1Cen8x6fYqAc+/MNJRUH6pB5bWHhSaVvEJDGxKbqg2Lf6tVzM0ZAc+1/1aF1Pni
 HlEqJjsk0O0xbLDT1Ow3q0auD+TSnXxp1zFdU1lbWqLJvR7bmzliElrvW3wi5oKsZ7
 dErDnflNfki2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 24/29] dyndbg: pin class param storage to u32
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-dd-maint-2-v7-24-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
 <20260721-dd-maint-2-v7-24-010fbe73b311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 21:10:52 +0000
Message-Id: <20260721211052.D28351F000E9@smtp.kernel.org>
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
- [Medium] Bitwise shift out-of-bounds on 32-bit architectures when evaluat=
ing `BIT(bi)` in `ddebug_apply_class_bitmap()`.
--

--- Patch [24]: [PATCH v7 24/29] dyndbg: pin class param storage to u32 ---
commit 87a65c25e24b4e05bdc18ddf16105e9237d922db
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: pin class param storage to u32

This commit changes the bits and lvl fields in struct ddebug_class_param
to use u32 instead of unsigned long. This ensures consistent sizing across
different architectures.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 59e3c0eccbede..60b67face46e1 100644
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
Can this result in an out-of-bounds bitwise shift on 32-bit architectures?

The BIT(bi) macro expands to (1UL << bi). On 32-bit systems, 1UL is 32
bits wide. If a module defines a classmap with 32 or more classes
(map->length >=3D 32), shifting by 32 or more triggers undefined behavior.

On most 32-bit architectures, the CPU masks the shift count modulo 32, mean=
ing
BIT(32) evaluates to BIT(0). This causes the loop to incorrectly re-evaluate
and alter class 0 instead of processing the intended class, leading to
incorrect functional behavior when configuring dynamic debug.

> +		if (new_b =3D=3D old_b)
>  			continue;
> =20
>  		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dd-maint-2=
-v7-0-010fbe73b311@gmail.com?part=3D24
