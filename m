Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D51C61DE1
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 19:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F7810E16D;
	Sun, 30 Aug 2026 19:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EBmHCT9+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEED110E16D
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 19:53:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C0431600E2;
 Sun, 30 Aug 2026 19:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FE51F000E9;
 Sun, 30 Aug 2026 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788119607;
 bh=nD44Pbr1syJLsv/aIKg5wc3DJIhlDLq4slDVzbsoF8Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EBmHCT9+gG+TgS/C9M3umwsmJ4H8cNVeb8bupfz6e4BuY6Kyo+mYbETi7Uv9yp+tG
 laSL6zalOhsDuMVBLIS4r6gmIfhobWYTtVaCZ3F1t8nyTrzMOcavRhXnWCckDDI0nu
 QbP5yZnN8nDbC2Re0HuiYyI7zvy5oMuKa+4O7tJCEaxdTd1DVsegipeai8BTpjwIbJ
 oV3iqYBrMhRxDnCTzX71C6q2mUdZCgmH/3vvprmQcSZPHkl2d+dSvK4KedM4YGf1XN
 caR/LQAbS9RLkB+ItpqYNSee9/ceU3RMBezQ4Dheyt/hqbVpardnNdbWKcHbKBiVdF
 KwsFd4aeDYVeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] rust: debugfs: drop 'static bound from ScopedDir
 file creation methods
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260830193824.471089-2-dakr@kernel.org>
References: <20260830193824.471089-1-dakr@kernel.org>
 <20260830193824.471089-2-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 19:53:26 +0000
Message-Id: <20260830195327.28FE51F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Unsound transmute in `FileOps::fops` leads to Stack Use-After-=
Free due to silent constant promotion failure for non-'static types.
- [High] Unsound reliance on RAII (Drop) to manage C API unregistration for=
 non-'static types allows a Use-After-Free via `mem::forget`.
- [Medium] The patch missed dropping the `T: 'static` bound from `ScopedDir=
`'s callback-based file creation methods.
- [Low] Missing `#[inline]` annotation on the small abstraction function `f=
ops`.
--

commit 7b2fa56e56ab7cdc906ac4f77ac3f200f9ffe65e
Author: Danilo Krummrich <dakr@kernel.org>

rust: debugfs: drop 'static bound from ScopedDir file creation methods

This commit drops the T: 'static bound from various ScopedDir file creation
methods to support registering debugfs files backed by types that contain
non-'static references. It formalizes a type invariant that FileOps instanc=
es
reside in static storage and replaces the Deref implementation with an
explicit fops() method.

> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
> index d7b8014a64746..2beb55d444ca1 100644
> --- a/rust/kernel/debugfs.rs
> +++ b/rust/kernel/debugfs.rs
[ ... ]
> @@ -550,7 +550,7 @@ fn create_file<T: Sync>(&self, name: &CStr, data: &'d=
ata T, vtable: &'static Fil
>      /// This function does not produce an owning handle to the file. The=
 created
>      /// file is removed when the [`Scope`] that this directory belongs
>      /// to is dropped.
> -    pub fn read_only_file<T: Writer + Send + Sync + 'static>(&self, name=
: &CStr, data: &'data T) {
> +    pub fn read_only_file<T: Writer + Send + Sync>(&self, name: &CStr, d=
ata: &'data T) {
>          self.create_file(name, data, &T::FILE_OPS)
>      }

[Severity: High]
Does removing the 'static bound introduce a potential use-after-free if the
directory scope is leaked?

If a developer safely leaks a Pin<KBox<Scope<T>>> (e.g., via core::mem::for=
get)
where T borrows a local stack variable, the Drop-based unregistration will =
be
skipped. The local variables borrowed by T will still expire, but the C VFS=
 will
retain a pointer to them, leading to a dangling pointer when the debugfs fi=
le is
later accessed.

[ ... ]
> @@ -596,11 +592,7 @@ pub fn read_callback_file<T, F>(&self, name: &CStr, =
data: &'data T, _f: &'static
>      /// This function does not produce an owning handle to the file. The=
 created
>      /// file is removed when the [`Scope`] that this directory belongs
>      /// to is dropped.
> -    pub fn read_write_file<T: Writer + Reader + Send + Sync + 'static>(
> -        &self,
> -        name: &CStr,
> -        data: &'data T,
> -    ) {
> +    pub fn read_write_file<T: Writer + Reader + Send + Sync>(&self, name=
: &CStr, data: &'data T) {
>          let vtable =3D &<T as ReadWriteFile<_>>::FILE_OPS;
>          self.create_file(name, data, vtable)
>      }

[Severity: Medium]
Was it intended to leave the T: 'static bound in place for the callback-bas=
ed
methods like read_callback_file() and read_write_callback_file()?

The commit states the goal is to drop the 'static bound from ScopedDir's fi=
le
creation methods, but looking at the full file, it appears it was retained =
on
the callback variants.

[ ... ]
> diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_o=
ps.rs
> index f15908f71c4a2..7e1dd8c75ad92 100644
> --- a/rust/kernel/debugfs/file_ops.rs
> +++ b/rust/kernel/debugfs/file_ops.rs
[ ... ]
> @@ -65,11 +67,11 @@ pub(super) const fn adapt(&self) -> &FileOps<T::Inner=
> {
>  }
> =20
>  #[cfg(CONFIG_DEBUG_FS)]
> -impl<T> Deref for FileOps<T> {
> -    type Target =3D bindings::file_operations;
> -
> -    fn deref(&self) -> &Self::Target {
> -        &self.operations
> +impl<T> FileOps<T> {
> +    /// Returns a `'static` reference to the inner `file_operations`.
> +    pub(crate) fn fops(&self) -> &'static bindings::file_operations {

[Severity: Low]
Does this small abstraction function need the #[inline] attribute?

The subsystem coding guidelines specify that small functions in the kernel =
crate
that forward to a C binding call or wrap basic data access should be annota=
ted
with #[inline].

> +        // SAFETY: By the type invariant, `self` resides in static stora=
ge.
> +        unsafe { core::mem::transmute(&self.operations) }
>      }
>  }

[Severity: Critical]
Can this transmute cause a stack use-after-free by extending a short-lived
reference to 'static?

Since the T: 'static bound was dropped from methods like read_only_file(), =
using
a non-'static T will cause constant promotion to fail when evaluating
&T::FILE_OPS. This creates a temporary FileOps<T> on the local stack instea=
d of
in static storage.

When fops() is called on this stack temporary, the transmute bypasses the a=
ctual
lifetime and returns a 'static reference to stack memory. When the stack fr=
ame
pops, the C VFS is left holding a dangling pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830193824.4710=
89-1-dakr@kernel.org?part=3D1
