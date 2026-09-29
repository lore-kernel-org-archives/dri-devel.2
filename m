Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6133DCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD80010EE3F;
	Tue, 29 Sep 2026 10:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BxeqFp7/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D6E10EE3F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:55:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D28D43DD0;
 Tue, 29 Sep 2026 10:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37AD1F000FF;
 Tue, 29 Sep 2026 10:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790679355;
 bh=/lqjm6lp8S+fg/Jf1gxb2o6MCtqQPAXEXBgw15KB35w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BxeqFp7/CFPE9L8vMzzhwSR5IL+VhHlKhsOIzJsKQmO/hZYdKJdm4TGOHJ8DbpC5E
 dI1FpUhM0rs3ARXCfyN8arKtzCFaMGWjz/xweWABP8BCJq0oUsvbnUhfJMHyw6z0ef
 WchRlgQn3HTSHZyd3K6I3EPOJEihU/6g6/LnFQH1GNNk9ly73Tqqw2e3gVc2Gnnboh
 53mMoqMuTf5NbhCqzWkHjBpN8nRF4O9bAeuZD8KMNn6RsGKm5Qv4yaXzwr45JkmDnY
 ynDaA6Ke1UOPk9Ro9U4Oymp2oQP/PeI1MM4MKRPfYOG9pA9EMvmz6bl75UwS2Golog
 FV7fbLI3p2kZg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 2/3] rust: DmaFence: Implement Deref for
 FenceContext
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, media-ci@linuxtv.org,
 gary@garyguo.net
In-Reply-To: <20260929104703.934128-4-phasta@kernel.org>
References: <20260929104703.934128-2-phasta@kernel.org>
 <20260929104703.934128-4-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:55:53 +0000
Message-Id: <20260929105554.C37AD1F000FF@smtp.kernel.org>
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
- [Low] rust: dma_fence: missing #[inline] on FenceContext::deref
--

commit 4617358e176ca58ef1fbb67c98355887062d6801
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Implement Deref for FenceContext

This commit implements the Deref trait for FenceContext, allowing users
to directly access the underlying data field.

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
Should this method be annotated with #[inline]?

According to the Rust subsystem guidelines, small functions in abstraction
crates like the kernel crate should be annotated with the #[inline] attribu=
te
to ensure optimal inlining across crate boundaries. The newly added deref
method is a trivial one-line accessor but lacks this attribute.

> +        &self.data
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929104703.9341=
28-2-phasta@kernel.org?part=3D2
