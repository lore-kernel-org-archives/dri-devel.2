Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC9FC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 773B210E2F0;
	Sat, 11 Jul 2026 06:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lIBzf7N+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EB610E2F0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:44:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 15B3643970;
 Sat, 11 Jul 2026 06:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80E61F000E9;
 Sat, 11 Jul 2026 06:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783752295;
 bh=Te45nAF8NrZ7lSerCwRdZjZ5bDcjCgyWOkKbEgSGRDU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lIBzf7N+OTsX3PU7We6A5cEVsLId0PaaI9pjvSyVZZGx8TSBL/6ZOQ+NeLpI5zh8i
 7jaNUrL5KPL39yI9Lt4SfSmtOdC/6D99BuV0M4cJran9yG1BBFqC7nJ2eExOpyiGBc
 s+cZM1q7BpoUTAeF0YbZEaFohXJ2I52nhlO4h/f4ah+Q6/GA/7qmrhqnEkCycDk0Ai
 4wuOKAQ1IhyUdtdjpYKtqiFpWSy4pyLMuzSlPWoYpKwfUC4d4jNMi359CSezOxp/Rt
 xiuTy+fKA9smA8jnB7QtINE0mpip/+5o9odqPwj3Gg3L5N6pZGrL1h8q3Yx1bePy8K
 NwStAaQpbabiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] lib: test bitmap vs IDA vs Maple Tree performance
 for region allocations
To: "Yury Norov" <ynorov@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260711063602.426311-1-ynorov@nvidia.com>
References: <20260711063602.426311-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:44:54 +0000
Message-Id: <20260711064454.A80E61F000E9@smtp.kernel.org>
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
- [Medium] The benchmark allocates over 9.1 MB of static arrays in `.init.d=
ata`, which bloats the kernel image and can cause boot failures on memory-c=
onstrained architectures.
--

--- Patch [1]: [PATCH v2] lib: test bitmap vs IDA vs Maple Tree performance=
 for region allocations ---
commit 3ff59b7f49e8b1a285e39778b952abbfe86e1ed9
Author: Yury Norov <ynorov@nvidia.com>

lib: test bitmap vs IDA vs Maple Tree performance for region allocations

This commit adds a microbenchmark to compare the cost of allocating and
freeing variable-sized regions using a bitmap, IDA, and a Maple Tree. It
processes a randomly generated sequence of region sizes until the configured
capacity is exhausted.

Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvi=
dia.com/

> diff --git a/lib/region_alloc_benchmark.c b/lib/region_alloc_benchmark.c
> new file mode 100644
> index 0000000000000..46cd0dfe935f6
> --- /dev/null
> +++ b/lib/region_alloc_benchmark.c
> @@ -0,0 +1,174 @@
[ ... ]
> +#define MAP_SIZE	(1000000UL)
> +#define REGION_MAX_SIZE	32
> +
> +static DECLARE_BITMAP(alloc_bitmap, MAP_SIZE) __initdata;
> +/* One more request guarantees that even an all-ones trace reaches ENOSP=
C. */
> +static u8 region_sizes[MAP_SIZE + 1] __initdata;
> +static unsigned long region_indexes[MAP_SIZE] __initdata;

[Severity: Medium]
Is it safe to allocate over 9.1 MB of static arrays in .init.data here?

This inflates the uncompressed kernel image size and can cause build failur=
es
like relocation truncation or boot failures on memory-constrained architect=
ures,
especially when built-in via allmodconfig.

Could these large benchmark buffers be dynamically allocated at runtime usi=
ng
kvmalloc_array() or vmalloc() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711063602.4263=
11-1-ynorov@nvidia.com?part=3D1
