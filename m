Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CBECCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 407D91126DD;
	Fri, 16 Oct 2026 09:06:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE1E1126DB
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:06:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9340A60008;
 Fri, 16 Oct 2026 09:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0521F000C4;
 Fri, 16 Oct 2026 09:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792141612;
 bh=pSZQuC7KKOQ9Msgqyde93O1zsq+Sw6mG/UKgoXcHzg8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CuwE1dj2NtyhYYPH9E2q2N9Db324a9+TVYtADyWshPiMvOjcoe5WehyECYiYXx32I
 NzoQLjywgb/O24403ar/3orQ4Z/ne7zImxZzCFfPceYJV72ct/ggvq2gEgXA6/3SU/
 Iv9sGE2fv/KykfwPSkbEbg0lK4sNx4mmwC23IeUpsJuQHVKAnx5gpjxYXcJt3V1Y4W
 nTTQv2c12UmAgbUF4ASXfAblCrOD3o5Nqiq/6bRDfOuQZFjXP0O5lsBGE60FJVwpAs
 StvGEdqZDTP4DOYZfAdZgBc1q2XS7WmxEElrB5WpmuPRbiZxWpfXomT4gYioYafIT+
 u69x40ipXo1Lw==
Message-ID: <sashiko-outbox-174052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v6 1/5] rust: DmaFence: remove static lifetime
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261016085724.1031766-3-phasta@kernel.org>
References: <20261016085724.1031766-2-phasta@kernel.org>
 <20261016085724.1031766-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 09:06:51 +0000
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
- [Medium] rust: missing `# Safety` documentation for `unsafe fn new` expos=
ing UAF on leak
--

commit beab119634d6183863230115e35c006b11edee53
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: remove static lifetime

(will be upstreamed separately)

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
Since this patch removes the 'static bound from FenceCallbackRegistration
and makes FenceCallbackRegistration::new() unsafe to prevent callbacks from
outliving their captured references, does this function also need a
/// # Safety documentation block?

According to the Rust coding guidelines, unsafe functions must document
their safety preconditions. Without it, callers aren't explicitly informed
of their obligation to prevent leaks (e.g. via core::mem::forget) which
could bypass the Drop implementation and leave a dangling callback pointer
that eventually causes a use-after-free when the fence signals.

>      where
>          T: 'a,
>      {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016085724.1031=
766-2-phasta@kernel.org?part=3D1
