Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BD4C79FA1
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17CD410EE46;
	Wed,  9 Sep 2026 01:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EjS17R7s";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07B110EE46
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 01:14:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 67A77601FB;
 Wed,  9 Sep 2026 01:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE101F00A3A;
 Wed,  9 Sep 2026 01:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788916496;
 bh=3G28ph8nlkLDHYZzD7M3IBfjRAu92jVUXnDoeGbhZT4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EjS17R7sGMwyA+7rTXrdoAA/61q4a0JFdjAQ/rkbokO8zzwUczceGTeav7i7P2cA2
 IGGEYraHC4hlL+D0mYFr3auBqUev0hVnJixoAdiIpCPh4tBSq+2+84BPPdefc5mcYd
 l82Oi8HEb7xeALLVfwmJ58ogdMq/HTqlCEARmktgE3yEji2x6Yu1DQdolE6DG/o25H
 tuimwH2bY7oVigDHgjYC5sQXVZC6wmdB8MKhiAtQsM9shYRQUi7qgrXna9KwwY4j1H
 JD51e2GKxbnKWwA0bFHBylbIbJAiv9CARiMAz4pc9yM9z5s2Jt0yEZwvoBO0lFpjyx
 jNzPMJPimxolg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 36/39] dyndbg: Ignore additional arguments from pr_fmt
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-36-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-36-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:14:55 +0000
Message-Id: <20260909011455.DCE101F00A3A@smtp.kernel.org>
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
- [Medium] The patch papers over a compilation error in `pr_debug_ratelimit=
ed` by modifying `DEFINE_DYNAMIC_DEBUG_METADATA_CLS` to silently discard va=
riadic arguments, instead of fixing the root cause API inconsistency where =
`pr_fmt(fmt)` is incorrectly passed to the descriptor.
--

commit 187c89f348922db282033311e2fc8e7a59f688c1
Author: Philipp Hahn <phahn-oss@avm.de>

dyndbg: Ignore additional arguments from pr_fmt

This commit adds a variadic arguments slurping parameter to
DEFINE_DYNAMIC_DEBUG_METADATA_CLS to avoid a compile error when
pr_debug_ratelimited is used with a pr_fmt that includes additional argumen=
ts.
It also updates lib/test_dynamic_debug.c to test this behavior.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 32a34a80672b3..39de59c8bac2c 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -364,7 +364,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  		dump_stack();					\
>  }
> =20
> -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
> +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
>  	static struct _ddebug  __aligned(8)			\
>  	__section("__dyndbg_descs") name =3D {			\
>  		.modname =3D DDEBUG_MODNAME,			\

[Severity: Medium]
Does adding the variadic arguments here and silently discarding them corrupt
the stored format string in the dynamic debug control file?

If a module defines pr_fmt(fmt) with additional arguments (such as __func__=
),
DEFINE_DYNAMIC_DEBUG_METADATA_CLS will capture a mangled format string like
"test_dd_submod: %s " fmt while discarding the format arguments. This leaves
unresolvable %s specifiers in the control file.

This change also makes the stored format string inconsistent with pr_debug,
dev_dbg_ratelimited, and net_dbg_ratelimited, which correctly use fmt witho=
ut
the pr_fmt prefix.

Instead of discarding the arguments here, should the root cause in
include/linux/printk.h be fixed so that pr_debug_ratelimited passes fmt to
DEFINE_DYNAMIC_DEBUG_METADATA rather than pr_fmt(fmt)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D36
