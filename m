Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C22C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D278510E700;
	Mon, 24 Aug 2026 11:27:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N1XJ/dQP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE43810E700
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:27:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C709D4114F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1321F000E9;
 Mon, 24 Aug 2026 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787570854;
 bh=U7SgFVjZxa3fzThGKmaXeVtMA5IypPrOPDUHiEGN9qY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N1XJ/dQPM0ESVHrS1DF+VjsyswG7Hv87JXmogszLE/Z+gkyGCnN/e2CFMt+jZg1Op
 Wf9hGvPqkwC6uHzyd27BF24EeGR5kwP8FIDfnuf11nid/9Sg5TfDck/ol+lf8huFoR
 EK8cBel+usgF8rtz7MIgyeRQBayxlS1NL5/rC+Fej7pbPzBl6CR2g8nkqlEtfgsvHQ
 5C7IzkCVC1AuVFcAo8mOydQzX72ZhuVvYEZkJdiWimzfI39i8wiEGR3L20wenSTtWA
 yhdJTlwgTJu4iu2nRv8TFu3s0K5nytfZATfjXxghAojqkuyv22gfRmxoUw2IxFUW1i
 SM0r4kjGErD7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 2/8] rust: types: Add Ownable/Owned types
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260824-unique-ref-v20-2-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-2-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:27:34 +0000
Message-Id: <20260824112734.7B1321F000E9@smtp.kernel.org>
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
- [Medium] The safety documentation for `Owned::from_raw` fails to require =
the caller to uphold the pinning invariant.
--

--- Patch [2]: [PATCH v20 2/8] rust: types: Add Ownable/Owned types ---
commit 82ccf756b593f4c76a8a6694855add1d65c27d53
Author: Asahi Lina <lina+kernel@asahilina.net>
rust: types: Add Ownable/Owned types

This commit introduces Ownable and Owned types for unique ownership of obje=
cts
with custom drop logic. It provides a mechanism for C-allocated objects to =
be=20
owned by Rust without generic allocators, delegating resource management to=
=20
the type itself.

Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asah=
ilina.net/

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> new file mode 100644
> index 0000000000000..7fe9ec3e55126
> --- /dev/null
> +++ b/rust/kernel/owned.rs
[ ... ]
> +    /// Creates a new instance of [`Owned`].
> +    ///
> +    /// This function takes over ownership of the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    /// - `ptr` points to a valid instance of `T`.
> +    /// - Until `T::release` is called, the returned `Owned<T>` exclusiv=
ely owns the underlying `T`.
> +    #[inline]
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {

[Severity: Medium]
Should the safety documentation for from_raw() explicitly require the caller
to uphold the pinning invariant?

Since as_pin_mut() returns a Pin<&mut T> and the internal comments note that
T is treated as pinned from now on, it seems the caller must guarantee this.

If a caller provides an unpinned allocation, retrieves the pointer later wi=
th
into_raw(), and safely moves the object, it could violate the pinning
assumptions established here. Could this lead to memory corruption if the
pinned object is self-referential or registered elsewhere?

> +        // INVARIANT: By function safety requirement we satisfy the firs=
t invariant of `Self`.
> +        // We treat `T` as pinned from now on.
> +        Self { ptr }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D2
