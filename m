Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AEBC61CE2
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F24910E745;
	Mon, 24 Aug 2026 11:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="koaA1ISI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53DF910E745
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91685600C8
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073301F00A3E;
 Mon, 24 Aug 2026 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787570911;
 bh=8/tW0TyCR6k8V7upVOktGvHHRsL/XcZogxOO7+LrO4Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=koaA1ISIvY3Y6yAyuJMj+Z00zs+NL6OhKsw0baAxKAp1wPH164LKSitoNLPuviqQJ
 qa/ytHOqZayZGSkUkyxTuDEmDwGxNcmlQ6pa6YJodZQQe7KmUsf39hZ0yzM/YePFlb
 EQ8FBApBgBisE7bXdFgZzE9Cv8lvCGzy8NJOfP6BYLm74WGN1byoyNezcf86d/uMhF
 OMmwuQKZiAU2OVJ7NaQVfPN7+SwXWzScq3qifHME/4MSqcW6HiyBOkcpLshiFcScb6
 2VlXzKPgVciis6uP/ablhRUcZ45Itt60O/ESdV6AjGYTKYWIRbUA7ee8pvx08wZ+aV
 HaQlDT7pgCK5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 5/8] rust: rename `AlwaysRefCounted` to `RefCounted`.
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260824-unique-ref-v20-5-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-5-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:28:30 +0000
Message-Id: <20260824112831.073301F00A3E@smtp.kernel.org>
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
- [Low] The `GpuVm` and `GpuVmBo` types in the DRM GPUVM subsystem were not=
 updated to reflect the `AlwaysRefCounted` and `RefCounted` trait split, re=
sulting in a compilation failure.
--

--- Patch [5]: [PATCH v20 5/8] rust: rename `AlwaysRefCounted` to `RefCount=
ed`. ---
commit 7d343e09ba4b06050b444e30c1113ca349f25a78
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: rename AlwaysRefCounted to RefCounted.

This commit splits the AlwaysRefCounted trait into RefCounted and a new=20
marker trait AlwaysRefCounted. It updates several subsystems to implement=20
the new RefCounted trait while preserving the AlwaysRefCounted marker where=
=20
appropriate.

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 3bd5eb8a1a526..ea5a16b8163a6 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
[ ... ]
> @@ -45,9 +43,8 @@
>  /// at least until matching decrements are performed.
>  ///
>  /// Implementers must also ensure that all instances are reference-count=
ed. (Otherwise they
> -/// won't be able to honour the requirement that [`AlwaysRefCounted::inc=
_ref`] keep the object
> -/// alive.)
> -pub unsafe trait AlwaysRefCounted {
> +/// won't be able to honour the requirement that [`RefCounted::inc_ref`]=
 keep the object alive.)
> +pub unsafe trait RefCounted {
>      /// Increments the reference count on the object.
>      fn inc_ref(&self);

[Severity: Low]
Did this patch miss updating the DRM GPUVM subsystem?=20

When CONFIG_RUST_DRM_GPUVM is enabled, the build fails because GpuVm and=20
GpuVmBo are still trying to implement inc_ref() and dec_ref() under the=20
AlwaysRefCounted trait instead of RefCounted.

For example, in rust/kernel/drm/gpuvm/mod.rs:

unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVm<T> {
    fn inc_ref(&self) {
        // SAFETY: By type invariants, the allocation is managed by the ref=
count in self.vm.
        unsafe { bindings::drm_gpuvm_get(self.vm.get()) };
    }
    ...
}

And similarly in rust/kernel/drm/gpuvm/vm_bo.rs for GpuVmBo:

unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVmBo<T> {
    fn inc_ref(&self) {
        // SAFETY: By type invariants, the allocation is managed by the ref=
count in self.inner.
        unsafe { bindings::drm_gpuvm_bo_get(self.inner.get()) };
    }
    ...
}

Should these implementations be updated to use the new RefCounted trait to=
=20
match the changes made to the other subsystems?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D5
