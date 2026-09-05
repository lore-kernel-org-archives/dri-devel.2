Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BB5C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC0010E328;
	Sat,  5 Sep 2026 18:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dF2jsHfr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDE410E328
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:31:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5E8760258;
 Sat,  5 Sep 2026 18:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736841F00A3A;
 Sat,  5 Sep 2026 18:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788633097;
 bh=2YnLwjFJtuLkOnSBWkTH18B61ZLYhwjcpCTMjDJkasE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dF2jsHfrtEv4GwdtNVdtT7TqelVGBTV1a+w5+GR7RJouAM2vwldch21UeOB9vrf6A
 7g0V1mTKaJn38/MwaTsk7EADDx+XGJ2Jt5+B2ShXULAxfIuhGYMIltaqfd6wImNvzR
 xcbhog1quWe2GQYrKSKi24dGhpgc2K8F97We1WtTKyGstYrQN3poueDll3zGcTGekU
 O0t+eNx2gFOKyosXLQAYqb+iteMad1Ja+E8k74sLsWjxwK2Nd1BFzghiIgTlGsYXan
 OEjN6q6MzigMJYUmqL2ATVVAFSs1kHOHiWTc+L4tfVXK3Xs1t9S52XFUTsYc2q9U9W
 PCmLWBHsyWGog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 27/43] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-27-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-27-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:31:37 +0000
Message-Id: <20260905183137.736841F00A3A@smtp.kernel.org>
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
- [Medium] TOCTOU race in cross-module dynamic debug parameter synchronizat=
ion during module load.
- [Low] Missing fallback macro for `DYNAMIC_DEBUG_CLASSMAP_USE_` when `CONF=
IG_DYNAMIC_DEBUG` is disabled.
--

commit 094b72a96b9738b25bbc12d704057690585b0e4e
Author: Jim Cromie <jim.cromie@gmail.com>
Subject: dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP

This commit deprecates DECLARE_DYNDBG_CLASSMAP and replaces it with
DYNAMIC_DEBUG_CLASSMAP_DEFINE and DYNAMIC_DEBUG_CLASSMAP_USE. It
introduces the __dyndbg_class_users section to coordinate module
classmap use across the DRM subsystem. This decoupling resolves a
regression where child drivers failed to initialize properly.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 661599a1302de..17fc3a29d97b8 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
[ ... ]
> @@ -327,6 +457,8 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  #include <linux/errno.h>
>  #include <linux/printk.h>
> =20
> +#define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)
> +#define DYNAMIC_DEBUG_CLASSMAP_USE(_var)

[Severity: Low]
Is there a missing fallback definition for DYNAMIC_DEBUG_CLASSMAP_USE_ here?

Drivers using DYNAMIC_DEBUG_CLASSMAP_USE_ with a custom offset will likely=
=20
fail to compile due to an undeclared macro when CONFIG_DYNAMIC_DEBUG is=20
disabled.

>  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
>  #define DYNAMIC_DEBUG_BRANCH(descriptor) false

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 5f1cf9d76080b..c0e95442871ce 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -1238,12 +1404,17 @@ static int ddebug_add_module(struct _ddebug_info =
*di)
>  	 */
>  	dt->info =3D *di;
>  	dd_set_module_subrange(i, cm, &dt->info, maps);
> +	dd_set_module_subrange(i, cli, &dt->info, users);
> =20
>  	mutex_lock(&ddebug_lock);
>  	list_add_tail(&dt->link, &ddebug_tables);
>  	mutex_unlock(&ddebug_lock);
> =20
> -	vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mod_name=
);
> +	if (dt->info.users.len)
> +		ddebug_apply_class_users(&dt->info);

[Severity: Medium]
Does dropping ddebug_lock before calling ddebug_apply_class_users() introdu=
ce=20
a TOCTOU race window?

When a new module is added to ddebug_tables under ddebug_lock, it becomes
visible to sysfs. If a concurrent sysfs write triggers a parameter update,
it will apply the class bitmap and update the parameter value across all
loaded modules.

Since ddebug_apply_class_users() (which eventually calls=20
ddebug_sync_classbits()) executes without the lock, it might read a stale=20
parameter value if the sysfs thread updates the callsites but hasn't yet=20
updated the parameter itself.

Could this result in the newly loaded module having its callsites improperly
overwritten with a stale value?

> +
> +	vpr_info("%3u debug prints in module %s\n",
> +		 dt->info.descs.len, dt->info.mod_name);
>  	return 0;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D27
