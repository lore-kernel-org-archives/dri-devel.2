Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73BDCD98CF
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28EC310E8FE;
	Tue, 16 Jun 2026 08:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OpAIluEg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1607F10E8FE
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:36:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 441AC601DD
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D323D1F00A3D;
 Tue, 16 Jun 2026 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781598985;
 bh=FJGfs0NInI7uUJajV/S6dlTONFFIxwA5P3lSNifOxaU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OpAIluEgYdLCUHKj2E6pyhWPz5GSzzbyMAjl7t/DYSPZDNSk1h3SKnHBo2RCdBHMd
 VNdTcwQci7jWx4sNacByuyBRK6OMvMuGSNqIflAlmC0C/cMZEUtH3PmDu/KBBgUksa
 Y/4hXLadcjC+tTxrfx8dJtEUKnYPHW8lIZH0SsytkAFFNGNaXDP9dG4IJm4lQQyly7
 X6w5sxYSZ1yxFrMu4SSyrVnQeghcFrNElNbsas55fH5Vp/93eTTqeOwO2cOO3GKUIc
 zqWG6+jte1ynJ6N9V2rd0vhdJF2SOXnuXh2vK1Ja6giTwTT4Td0Ya+fWQq2W12Piy0
 yuzJZR46I1M6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] rust: sync: Add abstraction for synchronize_rcu()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260616082819.2943886-5-phasta@kernel.org>
References: <20260616082819.2943886-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 08:36:24 +0000
Message-Id: <20260616083624.D323D1F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing `#[inline]` annotation on the `synchronize_rcu()` abstracti=
on.
- [Low] Existing uses of `bindings::synchronize_rcu()` were not updated to =
use the new safe abstraction.
--

commit 3f3ebd383ebd5385e032e8ee41ba8e2dc2c9f4e9
Author: Philipp Stanner <phasta@kernel.org>

rust: sync: Add abstraction for synchronize_rcu()

This commit adds a safe Rust abstraction for the synchronize_rcu() function
to wait for a grace period.

> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index eef34bf862596..d86d615467b1e 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
[ ... ]
> @@ -56,3 +56,11 @@ pub fn rcu_barrier() {
>      // SAFETY: `rcu_barrier()` is always safe to be called. It just migh=
t wait for a grace period.
>      unsafe { bindings::rcu_barrier() };
>  }
> +
> +/// Wait for one RCU grace period.
> +///
> +/// You typically do this to wait for everyone holding a [`Guard`].
> +pub fn synchronize_rcu() {

[Severity: Low]
This isn't a bug, but should this function have an #[inline] annotation?

According to the Rust subsystem guidelines, functions in abstractions that
are small or simply forward to a binding call should be annotated with
#[inline].

Additionally, should the existing usages of the raw C binding be updated
to use this new safe abstraction?

For example, drop() in rust/kernel/sync/poll.rs currently does:

    unsafe { bindings::synchronize_rcu() };

And revoke_internal() in rust/kernel/revocable.rs:

    unsafe { bindings::synchronize_rcu() };

Updating these existing callers would help reduce unnecessary unsafe blocks
across the codebase now that a safe wrapper is available.

> +    // SAFETY: `synchronize_rcu()` is always safe to be called. It just =
waits for a grace period.
> +    unsafe { bindings::synchronize_rcu() };
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616082819.2943=
886-2-phasta@kernel.org?part=3D3
