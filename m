Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888E7C79F82
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D4D10EE40;
	Wed,  9 Sep 2026 01:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D2qWd7wm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0365C10EE40
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 01:12:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C734642E3C;
 Wed,  9 Sep 2026 01:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA161F00A3A;
 Wed,  9 Sep 2026 01:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788916348;
 bh=JtVv2WvqnkzCo0JC1QdcbXMg2fg9dSp4FL8HOnMVuw0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D2qWd7wmfl+uxFnSTkKDaZL1jI1OXDysIZmxDpQ/4Bi5luBLn9njMSJSYSA2p1d3M
 TBteTrRwtRINAjGNXewbGXd8J2JL+7Z8ahI2mzbbQZ524C7xBVdveQYtrbCJHS/B+0
 045ZG3V1jHURJibVXYFWKwbLKxLqvqosIxZA7EjB258gl5ZEXj0dhpsiYzPgubf6KH
 4dtl7DurosNU8tYyNitcBstdLOQcTJQQ2qyJvmXhXKzvqICLq02Xy0ITuw5Ozi1ZJv
 ShjTWPonjeJx6V9XYiJIya1MB0ZXC7JAByvmzJvlKUJe1xEUWwCzmYu/Jeal+nlUeI
 RVhUBxl4tO3ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 39/39] dyndbg: add DEBUG-biased fallback stubs for
 _dynamic_func_call_cls
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-39-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-39-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:12:27 +0000
Message-Id: <20260909011228.5BA161F00A3A@smtp.kernel.org>
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
- [High] The fallback stub for _dynamic_func_call_cls silently compiles out=
 subsystem debug logs (like DRM) in production kernels when DEBUG is not de=
fined.
--

commit 4c2d1161afbd83349da0d51c36ebb02bc49b083c
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add DEBUG-biased fallback stubs for _dynamic_func_call_cls

When the dynamic debug core is enabled but global dynamic debug is disabled,
subsystems can face build failures due to undefined _dynamic_func_call_cls
macros. This commit adds stub definitions that mirror enabled behavior to f=
ix
the implicit declarations. When DEBUG is not defined, it uses an if (0)
statement to compile out the call while maintaining compile-time checking.

Closes: https://lore.kernel.org/oe-kbuild-all/202605201408.x1sHT6fx-lkp@int=
el.com/

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 064df695b3a4c..a04e8aeca0004 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
[ ... ]
> @@ -541,6 +541,23 @@ void ddebug_increment_call_count(void);
>  #define DYNAMIC_DEBUG_BRANCH(descriptor) false
>  #define DECLARE_DYNDBG_CLASSMAP(...)
> =20
> +#if defined(DEBUG)
> +#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
> +	do { func(NULL, ##__VA_ARGS__); } while (0)
> +#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
> +	do { func(__VA_ARGS__); } while (0)
> +#else
> +#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
> +	do { if (0) func(NULL, ##__VA_ARGS__); } while (0)

[Severity: High]
Does this unintentionally cause a regression by compiling out subsystem deb=
ug
logs in production kernels when DEBUG is not defined?

For example, DRM wraps its debug functions using this macro in
include/drm/drm_print.h:

#define drm_dev_dbg(dev, cat, fmt, ...) \
	_dynamic_func_call_cls(cat, fmt, __drm_dev_dbg, \
			       dev, cat, fmt, ##__VA_ARGS__)

With the if (0) condition, __drm_dev_dbg() is never executed. Could this
bypass subsystem-specific runtime parameter checks like drm.debug and
silently disable runtime debug logging capabilities for these subsystems?

> +#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
> +	do { if (0) func(__VA_ARGS__); } while (0)
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D39
