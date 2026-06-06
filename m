Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548AECD8C89
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 00:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C83A11ABF4;
	Sat,  6 Jun 2026 00:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f6mKFeXX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480A511ABF4
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 00:36:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E542601EF;
 Sat,  6 Jun 2026 00:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E591F00893;
 Sat,  6 Jun 2026 00:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780706199;
 bh=kCrhuZI313Qxk1UeGYpHs0wx0ewP4BHVAoFAPweO3Ts=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f6mKFeXX+bI1eQ+xG9J+pNLXa83n28plrXDAMNtAIcnGh458CfgNNCriWqYCmgrs3
 KqNW82KFo2nbhLG5lghIDPm3o93/qfDqun2Mqtab2A2zN45wxUJK7/mh780XYvIysY
 k4b4iOnDfdQxWsG1ZwliuorsfR0IqnZP0O6cinHYRmyDgW6ujUMz7HDFlDV52qQ/De
 ze6dM3lXZw+7P+JPxhjVHrusjjacB1HBKH38tV6x/Q14HI1dJTP+YlKg9kzfeq38yl
 WZYarosEP9dnuWwzPv3MPiq9/X/1xT9i0JEhbVQvG6Gv05TOeqbeHegcwHM66GYAQb
 wIYOq8d0PQUsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: drm: gpuvm: implement Send and Sync for
 GpuVaAlloc and GpuVmBo
To: "Sami Tolvanen" <samitolvanen@google.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260605222516.3138740-2-samitolvanen@google.com>
References: <20260605222516.3138740-2-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:36:38 +0000
Message-Id: <20260606003638.D4E591F00893@smtp.kernel.org>
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
- [High] The `Send` implementation for `GpuVmBo` is missing `T::Object: Syn=
c` and `T::Object: Send` bounds.
--

commit 0b3e6c9417da8e3bad6e8397aefb1b71a9755123
Author: Sami Tolvanen <samitolvanen@google.com>

rust: drm: gpuvm: implement Send and Sync for GpuVaAlloc and GpuVmBo

This commit implements Send and Sync traits for GpuVaAlloc and GpuVmBo.
It asserts that these objects can be safely moved between threads by
providing unsafe impls with bounds for the underlying data types.

> diff --git a/rust/kernel/drm/gpuvm/vm_bo.rs b/rust/kernel/drm/gpuvm/vm_bo=
.rs
> index c064ac63897be..016b10e3305b8 100644
> --- a/rust/kernel/drm/gpuvm/vm_bo.rs
> +++ b/rust/kernel/drm/gpuvm/vm_bo.rs

[ ... ]

> @@ -19,6 +19,21 @@ pub struct GpuVmBo<T: DriverGpuVm> {
>      data: T::VmBoData,
>  }
> =20
> +// SAFETY: The refcount in `self.inner` is atomic, so `dec_ref`'s deferr=
ed put is sound from any
> +// thread. `data` is dropped later by `drm_gpuvm_bo_deferred_cleanup`, o=
n whichever thread drains
> +// the queue, hence the `T::VmBoData: Send` bound.
> +unsafe impl<T: DriverGpuVm> Send for GpuVmBo<T> where T::VmBoData: Send =
{}

[Severity: High]
Is this implementation missing bounds for T::Object: Sync and T::Object: Se=
nd?

Since GpuVmBo acts as a refcounted handle to a GEM object and hands out
shared references to it via the obj() method, sending a GpuVmBo to another
thread allows that thread to obtain a shared reference concurrently. This
requires T::Object: Sync.

Additionally, when the deferred cleanup queue is drained, dropping the
C-side refcount could result in the final drop of the GEM object occurring
on that thread. This requires T::Object: Send.

Could omitting these bounds allow safe Rust code to bypass thread-safety
guarantees, potentially leading to data races when non-thread-safe GEM
objects are shared?

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605222516.3138=
740-2-samitolvanen@google.com?part=3D1
