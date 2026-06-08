Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CF2CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBD910F5FB;
	Mon,  8 Jun 2026 15:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fvxTUXFu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0ED810F5FB
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:32:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B60743724;
 Mon,  8 Jun 2026 15:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A251F00893;
 Mon,  8 Jun 2026 15:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780932755;
 bh=XnDLua9OEiiGx63ZF41RNuz9dlxK828dfDcM65+U5gM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fvxTUXFuWnUpnNciDvdEDej1nQHqJ/ohkhtQNELCHY/6hwn4LokweYFAaldH3ET9P
 vJXUY51w2kttXMqz8fPanxfqQHcDP8QPWEbEHbqhoEPma/pFyBpwYJ6k+zIL5MTvwK
 A7OmauqhuTN3GJ1YmOwGclY2wWTW7UnEqtKkvEoy52eXhYoXr6h5or7JvOYnZm/mQu
 jJUO1TVZtjYEqJ2vRXFvJHcRoeW10iY7Nc2XEvHAnCVvbUmX4dFCOwrbjMbNQLdhjS
 Isza+dPhUkWngzkwHkFcSPvLhUFhQAd1L2dkB5O5K5tQkEVvC5ZT9oz6kUBA+uNq/U
 psZyqNElpJxDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rust: drm: gpuvm: implement Send and Sync for
 GpuVaAlloc and GpuVmBo
To: "Sami Tolvanen" <samitolvanen@google.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260608150929.1327394-2-samitolvanen@google.com>
References: <20260608150929.1327394-2-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:32:34 +0000
Message-Id: <20260608153235.40A251F00893@smtp.kernel.org>
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

New issues:
- [High] Missing `Send` bounds in the newly added `Sync` implementation for=
 `GpuVmBo<T>`, allowing `!Send` types to be dropped across threads.

Pre-existing issues:
- [High] Thread-safety violation due to C-level deferred cleanup queue bypa=
ssing conditional `Send` bounds.
--

commit 34b8a98e3e88f5d7b03fbb66084e780d4c56de5f
Author: Sami Tolvanen <samitolvanen@google.com>

rust: drm: gpuvm: implement Send and Sync for GpuVaAlloc and GpuVmBo

Moving a GpuVaAlloc or GpuVmBo between threads currently forces drivers
to write their own unsafe Send and Sync impls. Provide the markers in
the abstraction instead.

> diff --git a/rust/kernel/drm/gpuvm/vm_bo.rs b/rust/kernel/drm/gpuvm/vm_bo=
.rs
> index c064ac63897be..fa183f6306ff8 100644
> --- a/rust/kernel/drm/gpuvm/vm_bo.rs
> +++ b/rust/kernel/drm/gpuvm/vm_bo.rs

[ ... ]

> @@ -19,6 +19,27 @@ pub struct GpuVmBo<T: DriverGpuVm> {
>      data: T::VmBoData,
>  }
> =20
> +// SAFETY: The refcount in `self.inner` is atomic, so `dec_ref`'s deferr=
ed put is sound from any
> +// thread. `drm_gpuvm_bo_deferred_cleanup` drops `data` and the last GEM=
-object reference on
> +// whichever thread drains the queue, hence the `T::VmBoData: Send` and =
`T::Object: Send` bounds.
> +// [`Self::obj`] hands out `&T::Object` for a shared object, so the move=
 needs `T::Object: Sync`.
> +unsafe impl<T: DriverGpuVm> Send for GpuVmBo<T>
> +where
> +    T::VmBoData: Send,
> +    T::Object: Send + Sync,
> +{
> +}

[Severity: High]
This is a pre-existing issue, but does the C-level deferred cleanup queue
bypass these conditional Send bounds?

Since the bo_defer queue acts as a hidden cross-thread channel, when a local
ARef<GpuVmBo<T>> is dropped by its creating thread, it is unconditionally
placed on the GpuVm's bo_defer queue via dec_ref.

Because GpuVm<T> is universally Send + Sync, a second thread can safely call
gpuvm.deferred_cleanup(). This pops the BO and executes its destructor on t=
he
second thread, bypassing the conditional Send bounds on GpuVmBo, because the
BO is never explicitly moved via Rust semantics.

Would it be safer to enforce Send bounds unconditionally on the VmBoData and
VaData associated types within the DriverGpuVm trait itself?

> +
> +// SAFETY: The fields of `inner` read by shared-reference methods are im=
mutable after construction.
> +// [`Self::data`] hands out `&T::VmBoData` and [`Self::obj`] hands out `=
&T::Object`, so sharing
> +// `&Self` across threads requires both to be `Sync`.
> +unsafe impl<T: DriverGpuVm> Sync for GpuVmBo<T>
> +where
> +    T::VmBoData: Sync,
> +    T::Object: Sync,
> +{
> +}

[Severity: High]
Since GpuVmBo<T> implements the AlwaysRefCounted trait, can a thread with a
shared reference &GpuVmBo<T> upgrade it to an owned reference ARef<GpuVmBo<=
T>>
via ARef::from(&*bo)?

If a thread does this and becomes the last reference holder, dropping the A=
Ref
will execute the GpuVmBo<T> destructor, dropping T::VmBoData and T::Object =
on
that thread.

Similar to Arc<T>, should Sync for GpuVmBo<T> also require the dropped types
to be Send (i.e. T::VmBoData: Send and T::Object: Send) to prevent a safe R=
ust
program from dropping a !Send type on another thread?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608150929.1327=
394-2-samitolvanen@google.com?part=3D1
