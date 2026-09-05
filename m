Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41685C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BF110E404;
	Sat,  5 Sep 2026 18:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V050tsDS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A92210E404
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:31:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FD0760236;
 Sat,  5 Sep 2026 18:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2661F00A3A;
 Sat,  5 Sep 2026 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788633108;
 bh=pg+hRIuGW51lumXyhEXKouDViUan+wVFXOX3+cROFd4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V050tsDS2WCDoh3oPkiLHemSGNdR/ryCJBeuaNrodmSLvmiTL/PT5H1cb9rUoT1+X
 nVjr54AkC8q3LGt7BPmgGoAiG6lGcFL0Kzt6mQuA3dLzyQ+UqN0E9HE9Pg1TaC4ssL
 pdQqgLOUq/h0tBQjDnEKPSGYR0kjDe04z64P6k9fEgClQBlr1+ozEj1G6nauc/77G+
 1ZGCyqISjm6Zo0FnAaopJFVJuXGqk3Qj/GwK2CPyfXHuHzegSrdAhkLXfwjfbyQwlH
 CcnQgKjwMRy+9K9cu7NMqJUpdLrLxMXGi+ncOIdv8S+EsOJqEeD8yvG7gacP//Ix0m
 sBiyms1yYFZsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 39/43] dyndbg: Ignore additional arguments from pr_fmt
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-39-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-39-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:31:48 +0000
Message-Id: <20260905183148.9B2661F00A3A@smtp.kernel.org>
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
- [Medium] Change pr_debug_ratelimited to pass 'fmt' instead of 'pr_fmt(fmt=
)' to avoid masking the true invocation error via an improper variadic sink=
 in DEFINE_DYNAMIC_DEBUG_METADATA_CLS.
--

commit 6b20b9b19031937bd627698de6352c6bfec6e4f6
Author: Philipp Hahn <phahn-oss@avm.de>

dyndbg: Ignore additional arguments from pr_fmt

This commit alters the DEFINE_DYNAMIC_DEBUG_METADATA_CLS macro to accept and
discard variadic arguments. This is intended to workaround a build error wh=
en
pr_debug_ratelimited is used with a pr_fmt that adds arguments.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index d00605ef651ec..82cde8e6b46cb 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -362,7 +362,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  		dump_stack();					\
>  }
> =20
> -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
> +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\

[Severity: Medium]
Does taking variadic arguments here mask the underlying invocation error?

By taking '...' and discarding the extra arguments, the metadata descriptor
for pr_debug_ratelimited() incorrectly stores the prefixed format string
(with unresolved format specifiers like "%s"), while pr_debug() stores the
unprefixed format string.

This inconsistency breaks dynamic debug format queries when a module redefi=
nes
pr_fmt with multiple arguments.

Should pr_debug_ratelimited() in include/linux/printk.h be changed to pass
'fmt' instead of 'pr_fmt(fmt)' to DEFINE_DYNAMIC_DEBUG_METADATA(), similar
to how dev_dbg_ratelimited() handles it, rather than altering the metadata
macro to silently drop arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D39
