Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829CBCCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16141126B8;
	Fri, 16 Oct 2026 09:01:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500E71126B8
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:01:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2024843898;
 Fri, 16 Oct 2026 09:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF6F1F000C4;
 Fri, 16 Oct 2026 09:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792141284;
 bh=KRyBd5RZyM4BSoO25/dpfH/PiP02uiFNTNg1hEOu9Rs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UXB12co1BZ0TBVPRzLNlrEneHNYAoYE+4XCQyaPm/8olOfzG7J7m7mARSbGQpnpwU
 G3aHJnEh9EoEkPqSGg6L4+9nHFFjGRsJGzKC43lMGYjYWAAAcCIa+M1XgPBcRUL/80
 fO/csN0ry1PA1bTbXiNW8qNjevOHzey0TaTPZnAIUL0im1cJdTFptk5A+t7pCPjUGn
 e8pDgrGIKNoWRvQ/unmKRe5LMaNMnA3ab7zC9AHVi3OaWKrEc1vIXCmUjNa8EGpqOS
 oOq+r+qQGWcvA4w1OKosPRlXo1e/TwAm3uAG/eE9S9qQWG/ll+WcPvyPv7YZllIaUz
 eAFkKph2nkCAA==
Message-ID: <sashiko-outbox-174041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v6 2/5] rust: DmaFence: Implement Deref for
 FenceContext
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261016085724.1031766-4-phasta@kernel.org>
References: <20261016085724.1031766-2-phasta@kernel.org>
 <20261016085724.1031766-4-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 09:01:23 +0000
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
- [Low] rust: missing #[inline] on Deref::deref in abstraction
--

commit f7dee333951179025d9c4ebf4f5a3d49e66c7f5e
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Implement Deref for FenceContext

This commit implements the Deref trait for FenceContext. This allows users
to easily access the data carried by the context.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index eef2b9e93f356..0028124e6aa64 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
[ ... ]
> @@ -86,6 +86,14 @@ pub struct FenceContext<T: FenceContextOps + Send + Sy=
nc> {
>      data: T,
>  }
> =20
> +impl<T: Send + Sync + FenceContextOps> Deref for FenceContext<T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {

[Severity: Low]
This isn't a bug, but should this method be marked with the #[inline]
attribute?

The Rust subsystem guidelines recommend that small functions within
abstractions (such as the kernel crate) be annotated with #[inline]. Since
this deref implementation is a trivial getter returning a reference to a
struct field, omitting the attribute might lead to unnecessary function call
overhead when used frequently.

> +        &self.data
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016085724.1031=
766-2-phasta@kernel.org?part=3D2
