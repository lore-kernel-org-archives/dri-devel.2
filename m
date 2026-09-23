Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B06C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8798910F222;
	Wed, 23 Sep 2026 22:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LhH3PxDW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DF210F222
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:49:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 33524600AA;
 Wed, 23 Sep 2026 22:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEB51F00893;
 Wed, 23 Sep 2026 22:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790203780;
 bh=oEVINwN1fsaBxbTWTmB9UveFtaUrQhkMplONQt/zYhg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LhH3PxDWqbDzwdS17+H0D3CuXIHYNf3UfLXhkJVjYePKD4Drr5wubCEc+XndP+XOd
 mhTNqXbyZYGKGzdHrNvXtaCgV8odtKJ2gcq6iVRiEZ+g3ku4CCf7MGR3QvG+Q1OW/p
 poAdCzQ3itBx3B6dSD0C2WsyNBiDTfFfb78x4Y4JsVQxyYzhFy+0YBLlwYiBdBnBrQ
 b3c6p9fSceYe21WD6AuBowRyv+CMVB5EoEz8GEPw8LbmJEGvIHlKdUGPKD2Un5mIlY
 To/exwyT2tpF0NMYlRJRvMgTHjxNeAG/hPfveUX8oKP+/dFkCHWPWU+YEYGjqCAnoL
 UP2sO4RDh4zGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 23/38] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-23-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-23-9b6c217fdf2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:49:40 +0000
Message-Id: <20260923224940.ABEB51F00893@smtp.kernel.org>
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
- [Medium] dyndbg: TOCTOU race in ddebug_sync_classbits allows stale module=
 settings
- [Low] dyndbg: incompatible pointer type in module section load
--

commit 0e12bed35baa8c038def6b06ffc95416176ee997
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP

This commit replaces DECLARE_DYNDBG_CLASSMAP with an explicit client-server
model using DEFINE and USE macros. It resolves boot-time parameter
propagation failures by establishing a robust reference linkage. At module
load time, dyndbg now scans and resolves parent classmap references.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
[ ... ]
> @@ -2791,6 +2791,9 @@ static int find_module_sections(struct module *mod,=
 struct load_info *info)
>  	mod->dyndbg_info.maps.start =3D section_objs(info, "__dyndbg_class_maps=
",
>  						   sizeof(*mod->dyndbg_info.maps.start),
>  						   &mod->dyndbg_info.maps.len);
> +	mod->dyndbg_info.users.start =3D section_objs(info, "__dyndbg_class_use=
rs",
> +						   sizeof(*mod->dyndbg_info.users.start),
> +						   &mod->dyndbg_info.users.len);

[Severity: Low]
The len field in struct _ddebug_class_users is declared as a signed int, but
section_objs() expects an unsigned int pointer for its num parameter. Could
passing &mod->dyndbg_info.users.len here trigger an incompatible pointer
type compiler warning and result in a build error under standard
configurations?

[ ... ]
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> +static void ddebug_sync_classbits(const struct kernel_param *kp, const c=
har *modname)
> +{
> +	const struct ddebug_class_param *dcp =3D kp->arg;
> +	u32 val, new_bits;
> +
> +	if (!dcp || !dcp->map)
> +		return;
> +
> +	switch (dcp->map->map_type) {
> +	case DD_CLASS_TYPE_DISJOINT_BITS:
> +		val =3D READ_ONCE(*dcp->bits);
> +		new_bits =3D val;
> +		v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bits);
> +		ddebug_apply_class_bitmap(dcp, &new_bits, 0, modname);

[Severity: Medium]
Because dcp->bits is read locklessly via READ_ONCE() before
ddebug_apply_class_bitmap() takes ddebug_lock, is there a race condition
here?

If a user concurrently writes to the corresponding sysfs parameter, the sys=
fs
thread will update existing modules under the lock, release it, and then
update the parameter value.

If a concurrent module load thread executing ddebug_sync_classbits() reads
the old parameter value right before the sysfs thread writes the new value,
and then acquires the lock to apply the settings:

sysfs thread:
param_set_dyndbg_module_classes()
    mutex_lock(&ddebug_lock);
    // updates existing modules
    mutex_unlock(&ddebug_lock);

Module load thread in ddebug_sync_classbits():
    val =3D READ_ONCE(*dcp->bits); // reads old stale value

sysfs thread:
    *dcp->bits =3D new_value;

Module load thread in ddebug_sync_classbits():
    ddebug_apply_class_bitmap(...)
        mutex_lock(&ddebug_lock);
        // applies stale value

Would the newly loading module miss the concurrent sysfs update and
initialize with stale debug class settings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-pa=
rt2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D23
