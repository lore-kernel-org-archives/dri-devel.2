Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C28C79FA1
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0178610EE35;
	Wed,  9 Sep 2026 01:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oPABHvmu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A319F10EE35
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 01:08:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8826B42B57;
 Wed,  9 Sep 2026 01:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C71C1F00A3A;
 Wed,  9 Sep 2026 01:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788916125;
 bh=QwRpdg8NcrFFvxWTqNXfbksaWl9qNZnHPrjgsilbqQc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oPABHvmuqjxTVt9Qovzg3Dq2umJEf3o+AiVoCtA8QhIa6SMy23TvqyD+qxEEdJLqz
 9EcIaKY9XtQFHWWdCxIzXFtwnEvaVDx2HJnCqkQ0vpIpctbtdOP4iO5fkKYBx2btm7
 DGSJMT67wtlPYPpBnxrHUer+tASm2MjeT3xNUNXHgMg8qhwJIzSMaiX5qNMnwLixbD
 d4SkjcRD5/KqxoS4IlIX7wg82YyRNXODl1Ylx+3oEC9QUblf5attwXBcPmpRlS1gGC
 cdS7eaa8CXNI6vVV1AEDB/ZYVgx3Z0cP8nwbZVOnz22+1AsyiRWUGXwlivNX6knQN7
 gtqWxVMlxX7uA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 29/39] dyndbg-API: promote
 DYNAMIC_DEBUG_CLASSMAP_PARAM to API
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-29-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-29-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:08:44 +0000
Message-Id: <20260909010845.3C71C1F00A3A@smtp.kernel.org>
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
- [High] When CONFIG_DYNAMIC_DEBUG is disabled, DYNAMIC_DEBUG_CLASSMAP_PARA=
M_REF evaluates to an empty macro, which will silently drop the module para=
meter for consumers like DRM.
- [Medium] The commit message claims a modification to `ddebug_sync_classbi=
ts()` that does not exist in the patch.
- [Medium] DYNAMIC_DEBUG_CLASSMAP_PARAM zeroes the bitvector regardless of =
the `DEBUG` macro, causing state desynchronization and an inability to disa=
ble debug classes when compiled with DEBUG.
--

commit a5fb641199d77a5e65f10185304cd8aae102e99f
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: promote DYNAMIC_DEBUG_CLASSMAP_PARAM to API

move the DYNAMIC_DEBUG_CLASSMAP_PARAM macro from test-dynamic-debug.c into
the header, and refine it, by distinguishing the 2 use cases.

> Modify ddebug_sync_classbits() argtype deref inside the fn, to give
> access to all kp members.

[Severity: Medium]
The commit message claims a modification to ddebug_sync_classbits() that do=
es
not exist in the patch. Is this an oversight or an artifact from an older
revision?

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index b53e7488b7f7d..cc203b6c1b565 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -293,6 +293,44 @@ struct ddebug_class_param {
>  		.offset =3D _offset					\
>  	}
> =20
> +/**
> + * DYNAMIC_DEBUG_CLASSMAP_PARAM - control a ddebug-classmap from a sys-p=
aram
> + * @_name:  sysfs node name
> + * @_var:   name of the classmap var defining the controlled classes/bits
> + * @_flags: flags to be toggled, typically just 'p'
> + *
> + * Creates a sysfs-param to control the classes defined by the
> + * exported classmap, with bits 0..N-1 mapped to the classes named.
> + * This version keeps class-state in a private long int.
> + */
> +#define DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _var, _flags)		\
> +	static u32 _name##_bvec;					\
> +	__DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _name##_bvec, _var, _flags)

[Severity: Medium]
Does this macro unconditionally zero-initialize the state bitvector, breaki=
ng
synchronization with the actual enabled state of call sites if the module is
compiled with DEBUG?

If a module using this macro is compiled with -DDEBUG, its dynamic debug ca=
ll
sites are enabled by default. However, the static state vector _name##_bvec
is forcibly zero-initialized.

If a user writes 0 to the sysfs parameter to disable the logs,
param_set_dyndbg_module_classes() compares the new 0 against the old 0 state
and skips sending the -p queries, leaving the logs permanently enabled.

[ ... ]

> @@ -476,6 +514,8 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  #define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)
>  #define DYNAMIC_DEBUG_CLASSMAP_USE(_var)
>  #define DYNAMIC_DEBUG_CLASSMAP_USE_(_var, _offset)
> +#define DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _var, _flags)
> +#define DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(_name, _bits, _var, _flags)
>  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)

[Severity: High]
When CONFIG_DYNAMIC_DEBUG is disabled, DYNAMIC_DEBUG_CLASSMAP_PARAM_REF
evaluates to an empty macro. Will this silently drop the module parameter
for consumers like DRM?

Consumers of this macro will completely lose their sysfs module parameters
(e.g., /sys/module/drm/parameters/debug) on kernels built without
CONFIG_DYNAMIC_DEBUG.

Does the macro need to provide a fallback like module_param_named() to avoid
breaking kernel ABI expectations for these debugging parameters?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D29
