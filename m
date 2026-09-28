Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193A7C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE3C886A4;
	Mon, 28 Sep 2026 08:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aoRwgTn+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DDE886A4
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:52:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 18CE660052;
 Mon, 28 Sep 2026 08:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F421F000FF;
 Mon, 28 Sep 2026 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790585526;
 bh=BjD5Fvm11dWbShOpzJONILgbyY5tnzTaiYKGrUdjIZ4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aoRwgTn+qVO5zsoSmmAmcmaPr/yBG/nb3B68wb7PzZFYyAjI7AOH1xfNxq5fgt05K
 45EYG5pxJuCrXRv1p1dgmKfV08rtElb/DG13EAfP8HpYuOga9gLy1WmrMfBpj55+Iu
 wv+XS7qlSOvCwoekWtrrj22igzmyWyKEx6iac+VJDuHMz/ZhvHWxbhUItoCjhrzCHu
 dIT84piML8KQyITvgkpWT9ZcvizlsZrz1C4wbLIavy5HyhNC3R2KKb0L0BIZhVkmnN
 AwBARLmRlRTfUUA272YzjYVS/LJ1hjcOCGp8xizY0w6qtZsnD1RxxxpY0mH3pJhxum
 SIiCz8gxzMjaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] rust: alloc: add Vec::push_init
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 gary@garyguo.net, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-2-f04504c262c2@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-2-f04504c262c2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:52:06 +0000
Message-Id: <20260928085206.74F421F000FF@smtp.kernel.org>
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
- [Low] rust: kvec: missing #[inline] on push_init abstraction wrapper
--

commit 2d97ec4af5ca11c18cc395db7012f9c000c27f11
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: alloc: add Vec::push_init

This commit adds Vec::push_init, which serves as the init-infallible
version of try_push_init.

> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index a2b72a7779d9d..1b7b3a1ca770a 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
[ ... ]
> @@ -369,7 +369,24 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result=
<(), AllocError> {
[ ... ]
> +    /// let mut v =3D KVec::<[u8; 200]>::new();
> +    /// v.push_init(init_zeroed(), GFP_KERNEL)?;
> +    /// assert_eq!(v[0], [0; 200]);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn push_init(&mut self, init: impl Init<T>, flags: Flags) -> Res=
ult<(), AllocError> {

[Severity: Low]
This isn't a bug, but should this abstraction wrapper include an #[inline]
annotation?

The push_init function is a small wrapper in the kernel abstraction crate
that simply forwards to try_push_init and maps the error. The Rust
subsystem guidelines mandate that small functions in abstraction crates
should be annotated with #[inline].

> +        self.try_push_init(init, flags)
> +            .map_err(|PushInitError::AllocError(_)| AllocError)
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-b4-nvkv-v3=
-0-f04504c262c2@nvidia.com?part=3D2
