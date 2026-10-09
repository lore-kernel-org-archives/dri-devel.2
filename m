Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B66CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C709210EB51;
	Fri,  9 Oct 2026 19:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MLI/jP+O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374D810EB51
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 19:19:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05F4340905;
 Fri,  9 Oct 2026 19:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B081F000FF;
 Fri,  9 Oct 2026 19:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791573552;
 bh=iVlEDtZVl/cdT6KL0RlHlaibrfM3Ddi9whZN+dY4sbY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MLI/jP+O92vxKSOfqdiQ4g08VwPCUICeZyguCXP8UK3Q2wwpK1LZta7GxFMbhnDFd
 2HKstgUphcr3qP3smtUpZHNKhIYBYL7H6ZMWN+Luymb31zxSEQKWuEMb7+wIK4jBtc
 HdrAuu1rZ5IfpjlaM3MahNZv+rAltDIcy8LhotT/KfvzFQJtEE9RD+EVLlUoaf55n3
 YaJb5f9GKP/AssqmrvIHybjExIto0s5MeFbVAXrnYKqyEUdXGTgaR857kw6sDxR8iV
 JJhOILY/aj821hm90aYHRvvtx0/twi+jCfHAWYvy9qSI/Zwhw5GMpQ+ODUfS1gJUNm
 +J6O1o9KGNu9A==
Message-ID: <sashiko-outbox-165994@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 2/6] rust: DmaFence: Implement Deref for
 FenceContext
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, gary@garyguo.net, ojeda@kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261009191124.1022902-4-phasta@kernel.org>
References: <20261009191124.1022902-2-phasta@kernel.org>
 <20261009191124.1022902-4-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 19:19:11 +0000
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
- [Low] rust: missing `#[inline]` on `Deref::deref` in abstraction crate
--

commit 5ced5828ef2b966abecf7589e50ceba496fd2ff8
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Implement Deref for FenceContext

This commit implements the Deref trait for FenceContext. It allows users
to easily access the data carried by a FenceContext by dereferencing it.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index eef2b9e93f356..0028124e6aa64 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
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
This isn't a bug, but according to the Rust subsystem guidelines, small
abstraction functions in the kernel crate should be annotated with #[inline=
].
Since this deref implementation is a trivial getter, should #[inline] be
added here to allow optimal inlining across crate boundaries?

> +        &self.data
> +    }
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009191124.1022=
902-2-phasta@kernel.org?part=3D2
