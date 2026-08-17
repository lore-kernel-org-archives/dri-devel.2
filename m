Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E94C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFA7A10E69E;
	Mon, 17 Aug 2026 07:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eevEPbGh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1124310E6AA
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:12:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D632601DE;
 Mon, 17 Aug 2026 07:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB8E1F000E9;
 Mon, 17 Aug 2026 07:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786950728;
 bh=oAnMa/ByB9B0ygEbRtgnyxN5lIddlYjlyL7Ih6gbfcI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eevEPbGhkFNxc4McI1oKTu2Nqa4IRUCi4hAvje1Y2xvh2Aja2RWV0CrS1gedZKCOM
 FM9+bNYUH/Jm9+KFrOQkZCinsaEx4Pyg+SbTcnFyvjcIuO/wpbT/eCZ6Z0Ib8m3xRs
 TOEZRRs8B1EOib3FxxMn9xUsT1MVDFe+d+QsY3ddP/D51cBge9gdJ27UNSDKle+//5
 n5TIS54d0QKKTaLTOoC1gT8Z7Ovly3+3AfJXpqR8qaFr0AUKD0spIHc0t0aRTxHA9r
 mn3cFeYZxa3HbQ0LdQCy6Qw8iZvLz5j2MRLPrqSJW7PfUZgcECVHDTTjc/qjkB3lPv
 POnvI8a3tivOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] rust: id_pool: take a NonZero capacity in
 with_capacity
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260817-chid-v7-6-a5872e64d8f4@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-6-a5872e64d8f4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 07:12:08 +0000
Message-Id: <20260817071208.8FB8E1F000E9@smtp.kernel.org>
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
- [Low] The modified imports in the doc test do not fully adhere to the ker=
nel vertical import style.
--

--- Patch [6]: [PATCH v7 06/10] rust: id_pool: take a NonZero capacity in w=
ith_capacity ---
commit f4b7961ebb7650ae12d08eb8b7b640d56c620f68
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: id_pool: take a NonZero capacity in with_capacity

This commit modifies IdPool::with_capacity to accept a NonZero capacity
type instead of a standard integer. It updates the implementation to extract
the non-zero value and adjusts the corresponding documentation tests to use
the nz macro.

> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 384753fe0e44a..9494fde701eea 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -23,10 +23,13 @@
>  /// Basic usage
>  ///
>  /// ```
> -/// use kernel::alloc::AllocError;
> -/// use kernel::id_pool::{IdPool, UnusedId};
> +/// use kernel::{
> +///     alloc::AllocError,
> +///     id_pool::{IdPool, UnusedId},

[Severity: Low]
This isn't a bug, but the modified imports in this doc test do not fully ad=
here
to the kernel vertical import style.

Should IdPool and UnusedId be split onto their own lines?

> +///     nz, //
> +/// };
>  ///
> -/// let mut pool =3D IdPool::with_capacity(64, GFP_KERNEL)?;
> +/// let mut pool =3D IdPool::with_capacity(nz!(64), GFP_KERNEL)?;
>  /// for i in 0..64 {
>  ///     assert_eq!(i, pool.find_unused_id(i).ok_or(ENOSPC)?.acquire());
>  /// }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-chid-v7-0-=
a5872e64d8f4@nvidia.com?part=3D6
