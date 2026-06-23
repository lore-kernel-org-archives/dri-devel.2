Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C4DCDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B3A10ECB3;
	Tue, 23 Jun 2026 20:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SvxpPSTt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23E210ECB3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:54:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BEAD41AA4
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5288C1F000E9;
 Tue, 23 Jun 2026 20:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782248060;
 bh=FNj4loRxTH1qQy+ik4lyIUGJ8tr7Z012SphR+c1WsiU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SvxpPSTtStLEvm/JYUVF0fpRD9t5HygM5gkR9ud/GvhC1KlOdH48AO4B2PHTzH4ae
 OmBb23x4MRydDNa7INmT7lHVpD/4Wo7DaFETcy0f8TreBE8sz2Y/WTY3zWyR+Umztw
 0F8oxr1CGTGT2AsL/yKEkY6k/6LrLra2betZh0KrWdYt+4GCl2CiOc62f2sL2J/TTg
 jBmfHSmrNDuE3PwxWV8lE6f2QRrhtzvTbmS6mwbaYyoC7pfCT8rUb7Zb9WNLUD/4TR
 /NTfBF0GPgfwr0gbuhcPwkyHCnDCxR3TYRYH/eyJksTPLjtK55xYnG/VQrtABsggUh
 asNcop8pjL6mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] rust: sync: Add abstraction for rcu_barrier()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260622135654.334961-5-phasta@kernel.org>
References: <20260622135654.334961-2-phasta@kernel.org>
 <20260622135654.334961-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:54:19 +0000
Message-Id: <20260623205420.5288C1F000E9@smtp.kernel.org>
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
- [Low] The `rcu_barrier()` abstraction function is missing the mandatory `=
#[inline]` attribute.
--

commit 9b4d6fad89b434f3d9d6204b87f3b0eed4df4bb6
Author: Philipp Stanner <phasta@kernel.org>

rust: sync: Add abstraction for rcu_barrier()

This commit adds a safe Rust abstraction for the C function rcu_barrier(),
wrapping the underlying C binding so it can be called safely from Rust.

> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index a32bef6e490b0..9196feb62d6de 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
> @@ -50,3 +50,9 @@ fn drop(&mut self) {
>  pub fn read_lock() -> Guard {
>      Guard::new()
>  }
> +
> +/// Wait for all pending [`bindings::call_rcu()`] callbacks, if there ar=
e any.
> +pub fn rcu_barrier() {

[Severity: Low]
This isn't a bug, but according to the Rust subsystem guidelines, functions
in abstractions that are small or simply forward to a C binding call should
be annotated with #[inline].

Could we add the #[inline] attribute to rcu_barrier() since it just forwards
to the C binding?

> +    // SAFETY: `rcu_barrier()` is always safe to be called. It just migh=
t wait for a grace period.
> +    unsafe { bindings::rcu_barrier() };
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622135654.3349=
61-2-phasta@kernel.org?part=3D3
