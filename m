Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07831C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CEB510E3AA;
	Sat,  5 Sep 2026 18:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z4fNwdw+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7966010E3AA
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:30:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34B0A43B4A;
 Sat,  5 Sep 2026 18:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41AA1F00A3A;
 Sat,  5 Sep 2026 18:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788633056;
 bh=A5K1EmdTNtXm+X1U1wDreaoFMyArfdGzYqk4EznIZBM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z4fNwdw+XyAM72BKFHg14JJzLwr1tfi+p2PXlVSklbiEJku3WVgynvaNsiC+pK3RL
 yC7gq2NLkmHGt4OlRfa+N94xcaK++siD2HtCH9R5mHDPLcpb3fWwAh0h5wZn3y66Kc
 s3gSSuLryqXmAstuB3hmgNW6ksd3ARa7kI3Yv15yAegkpQogWSdWXF6OqVIAkjj3HD
 gUgQhZbGgbDe+bSrx1Y7cQi7LvpTNR+H72wuVTCbE5swYes8F0USj6G2PddGiOGQgo
 7bHmUUUcXmV+C8B7PTktgMB/GfswnnkLNT+YeDCh8KaHv7vcVm1WWP2Q0YipX32Qjx
 XNqmiUxrm9//g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 29/43] dyndbg: detect class_id reservation conflicts
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-29-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-29-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:30:55 +0000
Message-Id: <20260905183055.D41AA1F00A3A@smtp.kernel.org>
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
- [High] A classmap conflict in a single built-in module causes dynamic_deb=
ug_init() to fail, completely disabling dynamic debugging system-wide.
--

commit 10601ffba9f53c0ad961efc6f72432bdf809f6d1
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: detect class_id reservation conflicts

This commit detects if a module defines multiple classmaps that overlap in =
the
0..62 class-id space. It adds overlap checking in ddebug_add_module() and
returns -EINVAL when conflicts are detected, ensuring that class_id to
classname lookup works properly.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index ba618dcf9677f..0f89b6784ab26 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -1409,16 +1425,24 @@ static int ddebug_add_module(struct _ddebug_info =
*di)
>  	dd_set_module_subrange(i, cm, &dt->info, maps);
>  	dd_set_module_subrange(i, cli, &dt->info, users);
> =20
> +	/* insure 2+ classmaps share the per-module 0..62 class_id space */
> +	for_subvec(i, cm, &dt->info, maps)
> +		if (ddebug_class_range_overlap(cm, &reserved_ids))
> +			goto cleanup;
> +
>  	mutex_lock(&ddebug_lock);
>  	list_add_tail(&dt->link, &ddebug_tables);
>  	mutex_unlock(&ddebug_lock);
> -
>  	if (dt->info.users.len)
>  		ddebug_apply_class_users(&dt->info);
> =20
>  	vpr_info("%3u debug prints in module %s\n",
>  		 dt->info.descs.len, dt->info.mod_name);
>  	return 0;
> +cleanup:
> +	WARN_ONCE(1, "dyndbg multi-classmap conflict in %s\n", di->mod_name);
> +	kfree(dt);
> +	return -EINVAL;
>  }

[Severity: High]
Does returning an error here cause a systemic failure for built-in modules?

Looking at dynamic_debug_init(), it iterates over all built-in modules
and calls ddebug_add_module() for each one. If any single module fails,
it aborts initialization:

lib/dynamic_debug.c:dynamic_debug_init() {
    ...
		if (strcmp(modname, iter->modname)) {
			...
			ret =3D ddebug_add_module(&di);
			if (ret)
				goto out_err;
    ...
out_err:
	ddebug_remove_all_tables();
	return 0;
}

If a single built-in module has an overlapping classmap, the new -EINVAL re=
turn
bubbles up and triggers the out_err path. This destroys all previously load=
ed
tables and completely disables dynamic debugging system-wide, rather than j=
ust
skipping the misconfigured module. Should ddebug_add_module() failure be
non-fatal for built-in modules, or perhaps handled more gracefully?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D29
