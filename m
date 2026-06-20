Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A71CD4F26
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 21:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC3910E2A9;
	Sat, 20 Jun 2026 21:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gI8eCAKB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361DB10E1BA
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 21:00:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 575A8601E2;
 Sat, 20 Jun 2026 21:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CD71F000E9;
 Sat, 20 Jun 2026 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781989232;
 bh=GIy8woE/xsvlMMqkXihR8xnTyHwv/l97N/iBFbaD1PY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gI8eCAKBMVxAldh0wNWhDj33u2kOvQBAFoY+R7N1A4e3xSzL5DTMd+c4GKRoaopJv
 8Ny3SwumkjVUIVSxJDO2KwEnjqsL69Rk9emI8w/P7mgNsrptVUQQghkEz71Wq6oBqv
 mZBVrxqYxm/PR4e+8ay2lHR+w928DaiUal553GxFxhQQJb/XWP0L3gDOF2s6TX68Pr
 T0rv7OX9dDcshNoOe4dluk3EVd9Ir23eYV/MRjemO8ua9Mv7fSpXeNlzd1ivVAWMzi
 iT4FN+a9BsSXl43gm12imvYgI/AyDNNVPOUtbYooYUJqs3+yEhY/lF6IRt+V4U0bUQ
 dVtg7TMGFnU/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/16] rust: drm: restrict AlwaysRefCounted to Normal
 GEM Object context
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260620184924.2247517-7-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-7-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 21:00:31 +0000
Message-Id: <20260620210031.C6CD71F000E9@smtp.kernel.org>
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
- [Critical] Missing `gem_create_object` callback in `shmem::Object` causes=
 the DRM core to allocate bare C structs, leading to out-of-bounds reads/wr=
ites when Rust drivers access them via `lookup_handle`.
--

commit 21c57b4cda527522a0ac16331bcf2d0d3de21563
Author: Danilo Krummrich <dakr@kernel.org>
Subject: rust: drm: restrict AlwaysRefCounted to Normal GEM Object context

Restrict AlwaysRefCounted for gem::Object and gem::shmem::Object to the Nor=
mal
context. This simplifies generic parameters, removes AlwaysRefCounted from
IntoGEMObject's supertraits, and adds it as an explicit bound on
lookup_handle().

> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 1023ddccd7857..d56cbe2663e29 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs

[ ... ]

> @@ -198,8 +196,8 @@ fn create_handle<D, F>(&self, file: &drm::File<F>) ->=
 Result<u32>
>      /// Looks up an object by its handle for a given `File`.
>      fn lookup_handle<D, F>(file: &drm::File<F>, handle: u32) -> Result<A=
Ref<Self>>
>      where
> -        Self: AllocImpl<Driver =3D D>,
> -        D: drm::Driver<Object<Normal> =3D Self, File =3D F>,
> +        Self: AllocImpl<Driver =3D D> + AlwaysRefCounted,
> +        D: drm::Driver<Object =3D Self, File =3D F>,
>          F: drm::file::DriverFile<Driver =3D D>,
>      {

[Severity: Critical]
This is a pre-existing issue, but since we are modifying the bounds on
lookup_handle(), could the current implementation of shmem::Object lead to
out-of-bounds heap accesses?

In rust/kernel/drm/gem/shmem.rs, ALLOC_OPS sets gem_create_object to None
while enabling dumb_create and gem_prime_import_sg_table:

rust/kernel/drm/gem/shmem.rs:ALLOC_OPS {
    gem_create_object: None,
    ...
    gem_prime_import_sg_table: Some(bindings::drm_gem_shmem_prime_import_sg=
_table),
    dumb_create: Some(bindings::drm_gem_shmem_dumb_create),
}

When userspace creates a dumb buffer, __drm_gem_shmem_create() sees a NULL
gem_create_object and falls back to a pure C allocation using
kzalloc(sizeof(*shmem), GFP_KERNEL). This allocation lacks the trailing
Rust wrapper fields (inner and parent_resv_obj).

If a Rust driver later retrieves this handle via Object::lookup_handle(),
it casts the C-allocated struct back to the larger Rust wrapper:

rust/kernel/drm/gem/mod.rs:lookup_handle() {
    let ptr =3D unsafe { bindings::drm_gem_object_lookup(file.as_raw().cast=
(), handle) };
    if ptr.is_null() {
        return Err(ENOENT);
    }

    let obj =3D unsafe { Self::from_raw(ptr) };
    ...
}

Does this cause any subsequent access to obj.inner or obj.parent_resv_obj
by the Rust driver to read or write out of bounds on the kernel heap?

Should shmem::Object provide a gem_create_object callback to ensure the
full Rust struct is always allocated?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620184924.2247=
517-1-dakr@kernel.org?part=3D6
