Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B923C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3A610E63D;
	Sun, 28 Jun 2026 15:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jWofa/cu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA8710E63D
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:13:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2124F6001D;
 Sun, 28 Jun 2026 15:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0F71F000E9;
 Sun, 28 Jun 2026 15:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782659624;
 bh=zeHJYyfPAkr0l4Ja8KELX9xSuRiOmdrbjVAjRRmkHjU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jWofa/cu6LJUyFCWmmKe4OiSUIhGJ7NMGrJ3IHZSSFpIcRbRreLLGalzqHPpieQap
 voYDq/mnjCtOD2vV3zD5VHmaDVvC52iHgoRMgNt9NE01OX/hRAjBYZ/F8rz0XZhK5I
 +0vdEpteU9+1hXj+XD2cgFf8giDxNOv4fHP+gFYpSNAPkIc97UpItfcCNPwdqA45A8
 TQ2hWkTKA7MOXL4ANy+LE7EBHM3fcSIj7WrypnTzpmaxCzBSCE1e1xXygRRLfHYVZR
 bNiTh4DyUTn3DFut5rnpyuI+nK3NrXdGToKI7qR9cZAMKMwtOXT+apu25XeJNrlNjn
 ydLJe3FnMmGuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/19] rust: drm: restrict AlwaysRefCounted to Normal
 GEM Object context
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260628145406.2107056-8-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-8-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 15:13:43 +0000
Message-Id: <20260628151344.0E0F71F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Type confusion leading to out-of-bounds memory access due to C-all=
ocated GEM objects being unsafely cast to Rust `Object<T>`.
--

commit c0b1cc771ed0a5a11fb0a16d94befa79e5c52a6d
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: restrict AlwaysRefCounted to Normal GEM Object context

This commit restricts AlwaysRefCounted for gem::Object and
gem::shmem::Object to the Normal context. It updates Object::new methods
to Normal-only blocks and simplifies DeviceContext usage.

> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 1023ddccd7857..d56cbe2663e29 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
[ ... ]
> @@ -198,8 +196,8 @@ fn create_handle<D, F>(&self, file: &drm::File<F>) ->=
 Result<u32>
>      /// Looks up an object by its handle for a given File.
>      fn lookup_handle<D, F>(file: &drm::File<F>, handle: u32) -> Result<A=
Ref<Self>>
>      where
> -        Self: AllocImpl<Driver =3D D>,
> -        D: drm::Driver<Object<Normal> =3D Self, File =3D F>,
> +        Self: AllocImpl<Driver =3D D> + AlwaysRefCounted,
> +        D: drm::Driver<Object =3D Self, File =3D F>,
>          F: drm::file::DriverFile<Driver =3D D>,
>      {
>          // SAFETY: The arguments are all valid per the type invariants.

[Severity: High]
This is a pre-existing issue, but can this lead to an out-of-bounds memory
access during type casting?

In rust/kernel/drm/gem/shmem.rs, ALLOC_OPS leaves gem_create_object as None.
When userspace creates a dumb buffer or imports a PRIME buffer, the C helpe=
rs
drm_gem_shmem_dumb_create() and drm_gem_shmem_prime_import_sg_table() fall=
=20
back to allocating a bare C struct drm_gem_shmem_object via kzalloc().

When the driver later calls lookup_handle() (defined here in=20
rust/kernel/drm/gem/mod.rs), the underlying code unsafely casts the raw
C object pointer to the Rust wrapper:

    let obj =3D unsafe { Self::from_raw(ptr) };

Since the C-allocated object lacks the trailing fields of the Rust Object
wrapper (such as inner and sgt_lock), would accessing those fields read or
write out of bounds? Is there a need to provide a gem_create_object callback
so the full Rust wrapper is always allocated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628145406.2107=
056-1-dakr@kernel.org?part=3D7
