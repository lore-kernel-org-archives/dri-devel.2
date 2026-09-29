Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E8ECA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BBBA10EE49;
	Tue, 29 Sep 2026 10:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U4VsB3+L";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E6E10EB27
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:59:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6BFF460008;
 Tue, 29 Sep 2026 10:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45301F00893;
 Tue, 29 Sep 2026 10:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790679593;
 bh=jQkt5NPZ4dCpcEyrIx8/Rsq8wg/P2/jcGzACz7YMtLA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U4VsB3+LuzgM+xs0do0XMRrbJJnhR/jPhThVe4SqNduUjv+DXcbR4dfCW7zAmJ0Cg
 9f9VPb9PaBfJmY6bBwZ+tvMY+Kd+DAHpwrwz6Qnt6/90h920s1UjohoM75/8d6FR26
 EJXzPkxfjWIUgF1WbgMO4o+Sa2us5Sr3pggMlnRKv4fQJDatJnk0Jl+iawx/eViNoa
 0lMHYq+5PVGnjWPJi9egm/QhW50PNjhbVCUJxGwEoYSADKZdVTp4IXc78nuCROUVJX
 cszVTnb6BSUX692HLIy2MZwDM9+wtavmK9wXxAcScpriMsQRB26gfIYZS3FyES0Ieo
 Hnm4j7hge5xAA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 1/3] rust: DmaFence: remove static lifetime
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, gary@garyguo.net, media-ci@linuxtv.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260929104703.934128-3-phasta@kernel.org>
References: <20260929104703.934128-2-phasta@kernel.org>
 <20260929104703.934128-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:59:52 +0000
Message-Id: <20260929105952.D45301F00893@smtp.kernel.org>
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
- [Medium] rust: dma_fence: missing safety doc for FenceCallbackRegistratio=
n::new()
--

commit 6cb68d1acd60ccf038d3c22a96a083dfc30b1a48
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: remove static lifetime

This commit removes the static lifetime requirement for FenceCallback,
allowing callbacks to hold non-static references. It also updates
FenceCallbackRegistration::new to be unsafe to account for this change.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 18a43e1bb442f..eef2b9e93f356 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs

[ ... ]

> @@ -326,7 +326,7 @@ impl<T: FenceCallback> FenceCallbackRegistration<T> {
>      /// On success the callback is pinned in place and will fire when th=
e fence
>      /// signals. On `AlreadySignaled` the callback is returned to the ca=
ller so
>      /// that owned resources can be reclaimed.
> -    pub fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit<Self, =
CallbackError<T>> + 'a
> +    pub unsafe fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit=
<Self, CallbackError<T>> + 'a

[Severity: Medium]
Are we missing the safety documentation for this newly marked unsafe functi=
on?

If a developer calls FenceCallbackRegistration::new with a callback holding
local stack references and leaks the registration, could this result in a
use-after-free when the C backend eventually invokes the callback?

Should there be an explicit safety contract explaining this anti-leak
precondition to prevent bypassing memory safety guarantees?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929104703.9341=
28-2-phasta@kernel.org?part=3D1
