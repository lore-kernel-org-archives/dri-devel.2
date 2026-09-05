Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98668C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D0D10E3ED;
	Sat,  5 Sep 2026 18:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q7S8ChZj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0207710E3ED
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:31:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 798DD60258;
 Sat,  5 Sep 2026 18:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118661F00A3A;
 Sat,  5 Sep 2026 18:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788633103;
 bh=0ZKxG3lTb+sc8o0nvZOvTnqeEbqQ4CBN/jypgh5Vac4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q7S8ChZjuPTFon0bXOJbx2x/cIsjagvDKqTzxTu9poRK9c/lnmmLMDVvsw6MjyWaM
 L64CNQQ+L4WOvset3UKC0m8Gj8Tf8XjJwfws2KYJiU8XWPuM8Y3qleWZe9pmtQVxiZ
 rMUerAyOVgOkcYHlUA+F0eFVBaNJD0iV2hSNsXigLX/dJZlQiUaYk1EpDk9DRB3VPB
 tmKXUPzET6YewG/YURqXbAh9WNLuKPgHGyCnAX35Rr4C5i7nPlJuIbxpp738w9soZP
 SoS/YWUXBzpl32JwFBjM8hVttneH6es0nwmbhRbOq2lnYqu7GJN89zkdQwNOuZ58Bv
 MwXhwH01d9b8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 42/43] dyndbg: add DEBUG-biased fallback stubs for
 _dynamic_func_call_cls
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-42-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-42-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:31:42 +0000
Message-Id: <20260905183143.118661F00A3A@smtp.kernel.org>
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
- [Medium] Commit message and code mismatch regarding macro evaluation and =
return type.
--

commit 540d64bf950ba97fca84806f776637334569e3d7
Author: Jim Cromie <jim.cromie@gmail.com>
Subject: dyndbg: add DEBUG-biased fallback stubs for _dynamic_func_call_cls

This commit adds fallback stubs for the _dynamic_func_call_cls family of
macros when dynamic debug is disabled. It ensures that subsystems wrapping
these functions do not fail to build due to implicit declarations.

Closes: https://lore.kernel.org/oe-kbuild-all/202605201408.x1sHT6fx-lkp@int=
el.com/

> If DEBUG is not defined, they use an if (0) statement-expression to compi=
le
> out the call while returning 0, achieving zero overhead while maintaining
> compile-time argument checking.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h

[ ... ]

> +#else
> +#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
> +	do { if (0) func(NULL, ##__VA_ARGS__); } while (0)
> +#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
> +	do { if (0) func(__VA_ARGS__); } while (0)
> +#endif

[Severity: Medium]
Is there a discrepancy here between the commit message and the implementati=
on?

The commit message states that the fallback stubs in=20
include/linux/dynamic_debug.h use a statement-expression to return 0.
However, the actual implementation of _dynamic_func_call_cls uses a
do-while(0) loop, which evaluates to void rather than 0.

Since these macros are typically used as statements, evaluating to void see=
ms
functionally correct for compilation. Could the commit message be updated to
accurately reflect the do-while(0) implementation to avoid confusion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D42
