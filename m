Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5648C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A9410F6AD;
	Fri,  3 Jul 2026 07:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K5u44Rxf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C1210F6AD
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 07:40:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9AD3060103
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 07:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FCB1F00A3A;
 Fri,  3 Jul 2026 07:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783064447;
 bh=TEYwMbAuauze9SEo1okcCv/rBT1QYhOj+UekS9U6LT4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K5u44Rxf0oy29adphqQqNVL6xG7qPClLw/ab9XIl68A5U49Zs86ZaZOxAzoALpAWO
 /bUEXzC3AjEMvjbWlnG9OF3WM1d0A9MS/mIOlr1D8GGAWsiFRATU1oZtk5TqCRHan/
 fuBBMm+bOsqROatYfPM+oHF4f7RST2q5Ma8siY3w0lhraQJQoiCbcW2gpNbDofFNF2
 /mUD1tUxip37B1hrzA85INC8hzLy1dF9tcB/ADRw9b7pux+JCwpcKE53KHAtloPldL
 VpamXtj3LvEnzVPhkbA0t8r+7FTJRfJZZBmcFI1wEyDIDjlp28ynuJTFGO/xIqaYzo
 CibiuWbGnc50Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] rust: sync: Add abstraction for rcu_barrier()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260703073141.3962604-5-phasta@kernel.org>
References: <20260703073141.3962604-2-phasta@kernel.org>
 <20260703073141.3962604-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 07:40:45 +0000
Message-Id: <20260703074047.21FCB1F00A3A@smtp.kernel.org>
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
- [Low] The function name `rcu_barrier` causes module-level stuttering (`rc=
u::rcu_barrier()`).
--

commit 7b2bfcaf9137cfae11ac6cf2b69d559a4e731460
Author: Philipp Stanner <phasta@kernel.org>

rust: sync: Add abstraction for rcu_barrier()

This commit adds a safe Rust abstraction for the C function rcu_barrier(),
which waits for all in-flight call_rcu() callbacks to complete.

> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index a32bef6e490b0..7031ca5d24738 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
[ ... ]
> @@ -50,3 +50,23 @@ fn drop(&mut self) {
>  pub fn read_lock() -> Guard {
>      Guard::new()
>  }
> +
> +/// Wait until all in-flight call_rcu() callbacks complete.
> +///
> +/// Note that this primitive does not necessarily wait for an RCU grace =
period
> +/// to complete.  For example, if there are no RCU callbacks queued anyw=
here
> +/// in the system, then rcu_barrier() is within its rights to return
> +/// immediately, without waiting for anything, much less an RCU grace pe=
riod.
> +/// In fact, rcu_barrier() will normally not result in any RCU grace per=
iods
> +/// beyond those that were already destined to be executed.
> +///
> +/// In kernels built with CONFIG_RCU_LAZY=3Dy, this function also hurrie=
s all
> +/// pending lazy RCU callbacks.
> +///
> +/// Note that this is one of the RCU primitives which must not be called=
 in
> +/// atomic context.
> +#[inline]
> +pub fn rcu_barrier() {

[Severity: Low]
This isn't a bug, but naming this function rcu_barrier() inside the rcu
module leads to stuttering when called (i.e., rcu::rcu_barrier()). Would it
be better to name this simply barrier() so it can be called as
rcu::barrier(), similar to how rcu_read_lock() is exposed as
rcu::read_lock()?

> +    // SAFETY: `rcu_barrier()` is always safe to be called. It just migh=
t wait for a grace period.
> +    unsafe { bindings::rcu_barrier() };
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703073141.3962=
604-2-phasta@kernel.org?part=3D3
