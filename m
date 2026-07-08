Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6B0C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C1010EFA8;
	Wed,  8 Jul 2026 02:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b+1vuZg5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A0C10EFA8
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:41:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BDB2E40F1B;
 Wed,  8 Jul 2026 02:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777E71F000E9;
 Wed,  8 Jul 2026 02:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783478507;
 bh=CYYcLX6j+6rkzw6OOapXwFbq6F4yyNdKuEWGnkImX58=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b+1vuZg5oPDCKOgGqnFSQ3njuCnRK0Vda/gXu8rtSDs7N4BCrxe0xqH/7yGWMwbI8
 tWFLEw/hu1oegLdWV3qIOyHL33RQ2zVmz17/6bbJJNSjPzQ8KR/kZtmKy9WzZX9yKR
 s0yOcy3BMoJkT40xSypM/6vzFfzTd9E2Q2tlEKrX0625UydOIUVsDkrpb8IuEH2sY4
 fnxGU4Wm4sr6vRigNA/vqb2tuww2gYSGJr42aALDwnf5YvXIasTMZ1dzGDXmLFkqPn
 HBNZvUn5hESYeB2ip/BExcfXRWtRnlX2D3DHj+hZ/4gQ9/NcE4csJ7P0G9g/NxQGTS
 dy/vYJV7JBDDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 23/24] dyndbg: change __dynamic_func_call_cls* macros
 into expressions
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260707-dd-maint-2-v6-23-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-23-381f3edb0045@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:41:47 +0000
Message-Id: <20260708024147.777E71F000E9@smtp.kernel.org>
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
- [Low] API Consistency / Build Breakage Trap: Dynamic debug wrappers evalu=
ate to int when enabled but void when disabled
--

--- Patch [23]: [PATCH v6 23/24] dyndbg: change __dynamic_func_call_cls* ma=
cros into expressions ---
commit 003daac5c2950ded79f06209b5d0ab4dfeb11a5a
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: change __dynamic_func_call_cls* macros into expressions

This patch modifies the __dynamic_func_call_cls* macros to use statement
expressions instead of do-while loops, allowing them to return 0. It also
updates the fallback dynamic_hex_dump() macro to ensure it behaves
consistently by returning 0, allowing debug macros to be used inside
conditional expressions.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 355f2cb117334..8822f9a3605f6 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -238,24 +238,26 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>   * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
>   * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
>   */
> -#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
> +#define __dynamic_func_call_cls(id, cls, fmt, func, ...) ({	\
>  	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
>  	if (DYNAMIC_DEBUG_BRANCH(id)) {				\
>  		func(&id, ##__VA_ARGS__);			\
>  		__dynamic_dump_stack(id);			\
>  	}							\
> -} while (0)
> +	0; /* match no_printk return value */			\
> +})

[Severity: Low]
Does this introduce a build breakage trap for configurations where
CONFIG_DYNAMIC_DEBUG is disabled?

While this macro now evaluates to an int (0) when enabled, the fallback
macros used when dynamic debug is disabled often evaluate to void.

For example, dev_dbg() falls back to dev_no_printk(), which evaluates to vo=
id:

include/linux/dev_printk.h:
#define dev_no_printk(level, dev, fmt, ...) 				\
	({								\
		if (0)							\
			_dev_printk(level, dev, fmt, ##__VA_ARGS__);	\
	})

Similarly, drm_dbg() falls back to the __drm_dev_dbg() function which retur=
ns
void, and print_hex_dump_debug() falls back to a void inline function.

If a driver developer uses these macros in a boolean expression (such as
if (cond && dev_dbg(...))), it will compile successfully during development
with CONFIG_DYNAMIC_DEBUG enabled, but will break the build with an invalid
operands to binary && error when compiled without dynamic debugging.

Could the fallback macros be updated to consistently return 0 as well to
prevent this mismatch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint-2=
-v6-0-381f3edb0045@gmail.com?part=3D23
