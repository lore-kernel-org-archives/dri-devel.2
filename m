Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F360A260B
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jibRBINp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F8F112C21;
	Fri, 20 Nov 2026 17:36:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019C9112C21
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 17:35:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B126C45AD4;
 Fri, 20 Nov 2026 17:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518511F000C6;
 Fri, 20 Nov 2026 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795196159;
 bh=Nl1Or4/RqHVo14H9oZrjoDqyLRV2PIKQnbpOqdxD/50=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jibRBINpqV7ZRcEQD17A4ETa/2BO6GIHJnYpeTeA5noXvM7JEBYdtdT5vhxwG8fiV
 0qAZymBymv/qxZ/V/qlc/EUTloYVenA0w9unpRBN3um5RXLqGJw57LupIzWkSZctNl
 wXwctkyXIcaztarjJ8hKIBE5xL9RZ80+gYNXCjCBtCncQI/P+V4ununOsVTuAvmoSS
 tgjRGe7ZAAUTxXSdX1BiDzatpmROtcJFrFx+VB0CTbByvIymdyD2VjVjGIBoQCUiUT
 QaAUu3BnqEcJwTYvfzPX/DoAMj2tH4KLWRe3T1m2xCKkibYJc1oOV34UU7XGd9Au3g
 MG2cEblZpHz+A==
Message-ID: <sashiko-outbox-225691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] drm-dyndbg: drop BROKEN on DRM_USE_DYNAMIC_DEBUG
 for testing (DONT_APPLY)
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-rd-mostly-v2-5-88056ede02a8@gmail.com>
References: <20261120-rd-mostly-v2-0-88056ede02a8@gmail.com>
 <20261120-rd-mostly-v2-5-88056ede02a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 17:35:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm: build failure in drivers/accel/ with
  CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy
- [Medium] drm: broken debug logging in ddebug_change() and
  ddebug_add_module()
- [Medium] drm/print: unconditional debug output in __drm_printfn_dbg()
--

commit e718019be2a4836ac3663a62da5e819f0a591c63
Author: Jim Cromie <jim.cromie@gmail.com>

drm-dyndbg: drop BROKEN on DRM_USE_DYNAMIC_DEBUG for testing (DONT_APPLY)

This commit removes the BROKEN dependency from CONFIG_DRM_USE_DYNAMIC_DEBUG
so the option can be enabled for testing.

> diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
> index b909cd0a619fe..b0aa56281413c 100644
> --- a/drivers/gpu/drm/Kconfig.debug
> +++ b/drivers/gpu/drm/Kconfig.debug
> @@ -1,7 +1,6 @@
>  config DRM_USE_DYNAMIC_DEBUG
>  	bool "use dynamic debug to implement drm.debug"
>  	default n
> -	depends on BROKEN
>  	depends on DRM
>  	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
>  	depends on JUMP_LABEL

[Severity: High]
Does enabling CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy with
CONFIG_DYNAMIC_DEBUG_CORE=3Dy and CONFIG_DYNAMIC_DEBUG=3Dn break the build
for drivers under drivers/accel/ that call drm_dbg() (such as amdxdna,
ethosu, and rocket)?

When CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy, include/drm/drm_print.h expands
drm_dev_dbg() and __drm_dbg() to _dynamic_func_call_cls().  In
include/linux/dynamic_debug.h, _dynamic_func_call_cls() is only defined
when CONFIG_DYNAMIC_DEBUG is set or when both CONFIG_DYNAMIC_DEBUG_CORE
and DYNAMIC_DEBUG_MODULE are defined, with no fallback stub in the #else
branch.  Unlike drivers/gpu/drm/Makefile, drivers/accel/Makefile does not
add -DDYNAMIC_DEBUG_MODULE to ccflags-y or subdir-ccflags-y, leaving
_dynamic_func_call_cls undeclared.

[Severity: Medium]
Does enabling CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy leave drm_dbg*() callsites
impossible to enable in most DRM modules, and suppress debug output during
module probe when drm.debug is set prior to loading a driver module?

With CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy, drm_dev_dbg() and __drm_dbg() tag
descriptors with DRM_UT_* class IDs rather than _DPRINTK_CLASS_DFLT.  In
ddebug_change(), class-tagged descriptors only match when the module has
a registered classmap in dt->maps, which currently only drm,
drm_kms_helper, drm_display_helper, amdgpu, i915, and nouveau declare via
DECLARE_DYNDBG_CLASSMAP.  In addition, ddebug_add_module() ->
ddebug_attach_module_classes() attaches a newly loaded module's classmap
without applying the active __drm_debug bitmap to its callsites.

[Severity: Medium]
Does enabling CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy cause __drm_printfn_dbg() to
emit KERN_DEBUG messages unconditionally even when drm.debug is 0?

include/drm/drm_print.h defines __drm_debug_enabled(category) as true
when CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy, assuming callsites are gated by a
dynamic debug jump label.  However, drm_dbg_printer() uses
__drm_printfn_dbg() directly without a jump label:

drivers/gpu/drm/drm_print.c:__drm_printfn_dbg() {
	...
	if (!__drm_debug_enabled(p->category))
		return;

	__drm_dev_vprintk(dev, KERN_DEBUG, p->origin, p->prefix, vaf);
}

As a result, any drm_printf() or drm_vprintf() call on a drm_dbg_printer()
without an external check (such as in intel_display_driver_register() or
ttm_bo_mem_space_debug()) always prints to the kernel log.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-rd-mostly-=
v2-0-88056ede02a8@gmail.com?part=3D5
