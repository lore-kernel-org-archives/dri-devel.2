Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380F606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDG7W1ed
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7003B10E14B;
	Mon, 26 Oct 2026 11:53:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0DA210EE67
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:53:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F2FB60239;
 Mon, 26 Oct 2026 11:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201031F01825;
 Mon, 26 Oct 2026 11:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793015613;
 bh=KPI6HH/W/aEYa7420sHzRciVfHFyHqvQMBmPbXCoemQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iDG7W1edYi8C7nc3DQyr0o6A5MiIWhWSwuUTmKlYz04He39jhnaqgNntu5ToF8Jkt
 fjNho7pst4At49tdy30Q2wAuA4sM7OSM0ZEeZX+bEhcPiS4BWDY/QShDGHRsfYabq6
 8Al9Unsw6ovlLd3anVAej3yE7YYfmYxEotaFcU+/occrEO+zihLOwhF1mbpcHqAvUD
 sEOZqyOHYxNYpD//ukPOCBLG7UEiIbbEoi9xsGvaNNjiDnLiTWptvQMn/cGgmqKx1b
 VmTjywDtv0uOTqfR5UDA4OKMHNnKciXjZ5CJCsV5I4UknDM+J5GuN8iWHEdlEIEx3H
 P/gvcR9/WIcKQ==
Message-ID: <sashiko-outbox-185127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] rust: drm: gem: add an is_imported() accessor
To: "Janne Grunau" <j@jannau.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, =?utf-8?b?Qmo=?=
 =?utf-8?b?w7ZybiBSb3kgQmFyb24=?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Janne
 Grunau" <j@jananu.net>, "Sami Tolvanen" <samitolvanen@google.com>, "Lyude
 Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev
In-Reply-To: <20261026-rust-drm-gem-shmem-imported-sgt-v1-2-36f15ace04b1@jannau.net>
References: <20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net>
 <20261026-rust-drm-gem-shmem-imported-sgt-v1-2-36f15ace04b1@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:53:31 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: drm: gem: missing #[inline] on BaseObject::is_imported()
--

commit 870fd74aba497ab1671a05a6bf7eca2012bd1ed7
Author: Sami Tolvanen <samitolvanen@google.com>

rust: drm: gem: add an is_imported() accessor

This commit adds BaseObject::is_imported() and a corresponding C helper
shim to check whether a DRM GEM object is PRIME-imported.

> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index e01b8311dd895..5da8627275a29 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -187,6 +187,13 @@ fn size(&self) -> usize {
>          unsafe { (*self.as_raw()).size }
>      }
> =20
> +    /// Returns whether the object's backing buffer is imported from ano=
ther
> +    /// driver.
> +    fn is_imported(&self) -> bool {
> +        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a va=
lid `struct drm_gem_object`.
> +        unsafe { bindings::drm_gem_is_imported(self.as_raw()) }
> +    }

[Severity: Low]
This isn't a bug, but since BaseObject::is_imported() in
rust/kernel/drm/gem/mod.rs is a small abstraction method in the kernel
crate that directly forwards to bindings::drm_gem_is_imported(), should it
be annotated with #[inline] per the Rust coding guidelines?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-rust-drm-g=
em-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net?part=3D2
