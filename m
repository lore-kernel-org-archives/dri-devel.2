Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06364C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689BB10E08A;
	Tue,  7 Jul 2026 07:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cj8r0CIM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C1710E08A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA85541210;
 Tue,  7 Jul 2026 07:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC001F00A3A;
 Tue,  7 Jul 2026 07:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409596;
 bh=UY7vdOYOh7IizQC9qUZpc+8YSz74+ikqi2X5HQcOMLA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cj8r0CIMG21Zan6slL9MW4gvtYOD5iu9BjMMZjH5jC1TfqyvPqc7GIWP+X+PUptiw
 HhdyPNf+Iy8Uhxa1ypSZu3l2GRN23qpvog6KGUHutH13fuALHXHMmYLzsJ+ZfhghYK
 82bCGSXbcyfSl6uGrQJo3FwUXdJBNmPadKfJ7uBgt/Q1eOCzs64oNfkeIfmx9UkU5j
 PfeRDp9dNYDoyoUPZacjiMwlPUs7wzOaDHL9/p8UCcCyL9BAUfB4hyADnU+tJSqbls
 qtU37xVvceOVLYfnmZewLQu/JII5GDOggoUo/rY3+o/vaMkO0qlLUfrvlYiXpmwCGV
 nPe81XlW7jQXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 03/40] dept: add lock dependency tracker APIs
To: "Byungchul Park" <byungchul@sk.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 cassel@kernel.org, linux-ide@vger.kernel.org, "Anna
 Schumaker" <anna@kernel.org>, tytso@mit.edu, linux-rt-devel@lists.linux.dev,
 dlemoal@kernel.org, ojeda@kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260706061928.66713-4-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-4-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:15 +0000
Message-Id: <20260707073316.0EC001F00A3A@smtp.kernel.org>
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
- [Medium] `ldt_set_class` silently drops the lock name parameter, causing =
newly assigned lock classes to be registered in DEPT with the old lock name.
--

commit ca6be2708025c25889ef609a2203d1465096983d
Author: Byungchul Park <byungchul@sk.com>

dept: add lock dependency tracker APIs

Wrap the base APIs for easier annotation on typical lock.

> diff --git a/include/linux/dept_ldt.h b/include/linux/dept_ldt.h
> new file mode 100644
> index 0000000000000..8047d0a531f10
> --- /dev/null
> +++ b/include/linux/dept_ldt.h
[ ... ]
> +#define ldt_downgrade(m, i)						\
> +	do {								\
> +		if (dept_ecxt_holding(m, LDT_EVT_W))			\
> +			dept_map_ecxt_modify(m, LDT_EVT_W, NULL, LDT_EVT_R, i, "downgrade", "=
read_unlock", -1);\
> +	} while (0)
> +
> +#define ldt_set_class(m, n, k, sl, i)	dept_map_ecxt_modify(m, LDT_EVT_AL=
L, k, 0UL, i, "lock_set_class", "(any)unlock", sl)

[Severity: Medium]
Does this code inadvertently drop the lock name parameter `n`?

When a caller invokes `lock_set_class` on a held lock, it passes the new
name `n`. Because `n` is completely omitted from the replacement list here,
`dept_map_ecxt_modify` won't receive the new name. This could cause newly
assigned lock classes to be registered in DEPT with the old lock name, which
might lead to incorrect lock names in dependency deadlock reports.

Inside `dept_map_ecxt_modify()`, `dept_map_reinit()` is called with `NULL`
for the name, leaving `m->name` unchanged. `check_new_class()` is then
called, which registers the new class key using the old `m->name`. Lockdep
subsequently updates `m->name` via `ldt_init`, but it is too late as the
DEPT class was already created with the old name.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D3
