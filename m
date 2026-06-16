Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAC5CD98E3
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6542810E8EE;
	Tue, 16 Jun 2026 08:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GKlcqzZR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 216F810E8EE
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:35:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6E08441CE
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09741F00A3A;
 Tue, 16 Jun 2026 08:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781598932;
 bh=h1eRxlJGme1KrHeyrxXL1Lerc17s2SVKIRFzx64a2+M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GKlcqzZRjRMRkjBvK526TMu2o1T7bilqCbgDsg8jD7Zr24SbvmT6wrbZiMkQ+Ahu9
 E8GTHjckXSVKMv/M7qlqQ96ly5OQkOpKdmoW0tjJiD41ZT84tGG1WKa3OI3+PHyHEx
 bpgmdMLXeOEWzomnVJpGAQWfz4wOTA0frq6ZUN2bvwUbsyKzhoUqndaSr+EsHQ4gCa
 vaWvqWAuOAHkaR+ds4rYBN9yiNDxWscLq8VqYcusjcL29qCztbFo0SAMhbwapGHNjl
 HMohxE1GtcxrdcgQbt+JjsDH9BRQxcL/5MCQsaee0OsUBYazWGhZGKO5H5lV/SdRVT
 LqYvh4UJceXfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] rust: sync: Add abstraction for rcu_barrier()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260616082819.2943886-4-phasta@kernel.org>
References: <20260616082819.2943886-4-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 08:35:32 +0000
Message-Id: <20260616083532.B09741F00A3A@smtp.kernel.org>
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
- [Low] Missing `#[inline]` annotation on the `rcu_barrier` abstraction fun=
ction.
--

commit 429e3c9d9e99f90b82501282309c58b5cf00107c
Author: Philipp Stanner <phasta@kernel.org>

rust: sync: Add abstraction for rcu_barrier()

This commit introduces a safe Rust abstraction for the C function
rcu_barrier(), allowing Rust code to wait for all pending call_rcu()
callbacks to complete.

> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index a32bef6e490b0..eef34bf862596 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
[ ... ]
> +/// Wait for all pending call_rcu() callbacks, if there are any.
> +pub fn rcu_barrier() {

[Severity: Low]
This isn't a bug, but should this abstraction function be annotated with
#[inline]? The Rust subsystem guidelines indicate that small functions
or those that simply forward to a binding call should include the inline
annotation.

> +    // SAFETY: `rcu_barrier()` is always safe to be called. It just migh=
t wait for a grace period.
> +    unsafe { bindings::rcu_barrier() };
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616082819.2943=
886-2-phasta@kernel.org?part=3D2
