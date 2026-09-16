Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D73C982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5366510E145;
	Wed, 16 Sep 2026 16:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L4Wm+ZFN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFDBC10E145
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:40:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D774E41090;
 Wed, 16 Sep 2026 16:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3471F000FF;
 Wed, 16 Sep 2026 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789576859;
 bh=vZgyQidYMLyvGq4E+oKRD3Z1765ODD0CdTnReGLUSHI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L4Wm+ZFNS5w7vNj4K5F2Es3vG240ISRRl+2ufBfbMwfHbdyMUbMmmeb2YisDIYcie
 TYQqeXDz3ODz2H2JX09Gyf5I+O7KbTA6rX+SerE6cCQCtfNSnW3tpwWvIfnhzR1egp
 Wqx6j19sAZQkZmIILYILU0gv1mgclj3lGNChW1waIeYVW4qipUKR2DmxSilqdV5nAB
 NKzwIZlIm6teRr//sFo7Ej5L1hUHjC2+aaW5UqOWH7cZfwg7RaKiEh6HlFO5nA6Reh
 6GIKKd7Q7n3ya38vXnqeXPRhiRKzRbumg5iLs5LI/3QjzLthtcfl50im614KVk78wn
 kf/EFM9AnWF6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 28/38] dyndbg-API: promote
 DYNAMIC_DEBUG_CLASSMAP_PARAM to API
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-28-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-28-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:40:59 +0000
Message-Id: <20260916164059.8E3471F000FF@smtp.kernel.org>
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
- [Low] macro: redefinition of _DPRINTK_CLASSBITS_INIT
--

commit 0781b4eba8375be337f6f650796b2d759c24bf73
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: promote DYNAMIC_DEBUG_CLASSMAP_PARAM to API

This commit moves the DYNAMIC_DEBUG_CLASSMAP_PARAM macro into the header
and refines it into two separate macros for different use cases. It also ad=
ds
stub macros for !CONFIG_DYNAMIC_DEBUG and cleans up the test code.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 26c858588eb16..3114f4f28be44 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -60,6 +60,8 @@ struct _ddebug {
>  #else
>  #define _DPRINTK_FLAGS_DEFAULT 0
>  #endif
> +#define _DPRINTK_CLASSBITS_INIT ((_DPRINTK_FLAGS_DEFAULT & _DPRINTK_FLAG=
S_PRINT) ? ~0U : 0U)
> +
>  	unsigned int flags:8;
>  #ifdef CONFIG_JUMP_LABEL
>  	union {

[ ... ]

> @@ -466,9 +506,20 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  #include <linux/errno.h>
>  #include <linux/printk.h>
> =20
> +#if defined(DEBUG)
> +#define _DPRINTK_CLASSBITS_INIT ~0U
> +#else
> +#define _DPRINTK_CLASSBITS_INIT 0U
> +#endif

[Severity: Low]
Does this redefine _DPRINTK_CLASSBITS_INIT when CONFIG_DYNAMIC_DEBUG is
disabled? The macro is already defined unconditionally earlier in this file
(just before the flags field of struct _ddebug), which causes a
-Wmacro-redefined compiler warning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D28
