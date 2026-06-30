Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EA4C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8543C10EB1E;
	Tue, 30 Jun 2026 07:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aT1nWzY6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1BA10EAE9
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 07:09:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5EE843279;
 Tue, 30 Jun 2026 07:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7608D1F000E9;
 Tue, 30 Jun 2026 07:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782803356;
 bh=0SEZfo6B23SsGLra1B+f2fyYNsiIW/ITVtBXjwTHhc8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aT1nWzY6SxVQ8163Jvey9jIem/9N34XG8S7xCZufF/8WRyETnI6dk02XDPpXacAb0
 rhFn9ZR1ejIXGJDDHVqseNBv4wQgQQwTZqPtEeYoOo8K7g3OAYisf1ZbkOuctL6n5O
 51fhqsXQmrrH/Kmv6vHs/qS1CCAGFUr2FNplFcxj6U1VZZtuDDLSW/JyX7ZQ+OMxRR
 rAG6s1mnDB+Z5SnBTFGM6R+FgvWS0dgpOYfp6nD26SZkOXImzb/oBUCVJxJSCdD3eD
 AmPG94HBeIvVhU+a19rLudTthzSQufcc3rRHcUAmOTrFJbi8+QiDjjpM+c/8i5P/Q3
 xHCG2ev9q3xhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] block: rnull: use vertical import style
To: "Guru Das Srinagesh" <linux@gurudas.dev>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-4-98bc71d4810b@gurudas.dev>
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-4-98bc71d4810b@gurudas.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:09:16 +0000
Message-Id: <20260630070916.7608D1F000E9@smtp.kernel.org>
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
- [Low] Incomplete conversion to the vertical import style.
--

commit 6c2e9db0f7ba63fbe028e5d4f157502143caf612
Author: Guru Das Srinagesh <linux@gurudas.dev>
Subject: block: rnull: use vertical import style

This commit converts the use imports in the rnull block driver to a vertical
layout to improve readability and maintainability.

> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/config=
fs.rs
> index 7c2eb5c0b7228..07ce21a440813 100644
> --- a/drivers/block/rnull/configfs.rs
> +++ b/drivers/block/rnull/configfs.rs
> @@ -2,14 +2,26 @@
> =20
>  use super::{NullBlkDevice, THIS_MODULE};

[Severity: Low]
This isn't a bug, but should this import also be converted to the vertical
layout since it contains multiple items in braces?

[ ... ]

>      new_mutex,
>      page::PAGE_SIZE,
>      prelude::*,
> -    str::{kstrtobool_bytes, CString},
> +    str::{
> +        kstrtobool_bytes,
> +        CString, //
> +    },
>      sync::Mutex,
>  };

[Severity: Low]
This isn't a bug, but does this final item of the outer block also need a
trailing // to ensure rustfmt preserves the vertical formatting?

> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
> index 0ca8715febe83..d58d2c4c5f635 100644
> --- a/drivers/block/rnull/rnull.rs
> +++ b/drivers/block/rnull/rnull.rs

[ ... ]

>      prelude::*,
> -    sync::{aref::ARef, Arc},
> +    sync::{
> +        aref::ARef,
> +        Arc, //
> +    },
>  };

[Severity: Low]
Similar to the configfs.rs file, does the sync block need a trailing //
after its closing brace to keep the outer block vertically formatted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628-b4-rust-ve=
rtical-imports-v1-0-98bc71d4810b@gurudas.dev?part=3D4
