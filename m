Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA48CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 00:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6BB10E029;
	Tue,  9 Jun 2026 00:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A3Q1acqP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08D910E032
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 00:49:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB9AA601FD;
 Tue,  9 Jun 2026 00:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC061F00893;
 Tue,  9 Jun 2026 00:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780966180;
 bh=tcDm9ICdeFsjp5zLUFw1nd01+IK2yWq5OIgnISrTlFE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A3Q1acqP55Si2kvvV20aooho5s2xSt215oVf1ww+6I7Lu8/wFII8HHofD502J99YC
 7EVjNdNlY3X0OZxUPXQqsXti6LfSv9fuiRVnEMpfktciWB0dJHwrvTxoeW5el6Pqjk
 Pjjj8fBzcicf4nvjmZnjaPpOK91PwnR/70AFtFtqz3NkATiy7gfjdEzO1IH4aV7RYm
 27HK0J77iVEBlGYiKl0j622OBH/g1RXQEo+4m+QhCAhHocCvqquI7z7Np2sdo6872W
 mvWt4vq0yyWQeN3BjEPhcqcvHmFBb0EN8cc0tUeJEYz1JRnJtDPOX3weK06kbPYFof
 eJ03kStr44pOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] rust: drm: gpuvm: require Send and Sync for
 GpuVm's shared data
To: "Sami Tolvanen" <samitolvanen@google.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260609003256.1829625-6-samitolvanen@google.com>
References: <20260609003256.1829625-6-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 00:49:40 +0000
Message-Id: <20260609004940.7BC061F00893@smtp.kernel.org>
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
- [Critical] GpuVm's Send and Sync implementations omit bounds for T::VaDat=
a, allowing !Send data to be moved across threads, leading to data races.
--

commit 2dbb42abd1672fd0f3c87ba84b8650b37d9c9e84
Author: Sami Tolvanen <samitolvanen@google.com>

rust: drm: gpuvm: require Send and Sync for GpuVm's shared data

This commit adds explicit Send and Sync bounds for T::VmBoData and
T::Object to the GpuVm Send and Sync implementations. It addresses
unsoundness when obtain() aliases these types across threads.

> diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
> index ae58f6f667c1f..398068f2eb4f7 100644
> --- a/rust/kernel/drm/gpuvm/mod.rs
> +++ b/rust/kernel/drm/gpuvm/mod.rs
> @@ -74,9 +74,25 @@ pub struct GpuVm<T: DriverGpuVm> {
> =20
>  // SAFETY: The GPUVM api does not assume that it is tied to a specific t=
hread. The destructor will
>  // drop the `data` field, which is okay because it is guaranteed `Send` =
by the `DriverGpuVm` trait.
> -unsafe impl<T: DriverGpuVm> Send for GpuVm<T> {}
> -// SAFETY: The GPUVM api is designed to allow &self methods to be called=
 in parallel.
> -unsafe impl<T: DriverGpuVm> Sync for GpuVm<T> {}
> +// `obtain()` called from several threads can return `ARef`s to the same=
 bo, aliasing `T::VmBoData`
> +// and `T::Object`, and `deferred_cleanup()` can drop them from any thre=
ad, so both must be
> +// `Send + Sync`.
> +unsafe impl<T: DriverGpuVm> Send for GpuVm<T>
> +where
> +    T::VmBoData: Send + Sync,
> +    T::Object: Send + Sync,
> +{
> +}

[Severity: Critical]
This is a pre-existing issue, but does GpuVm also need Send + Sync bounds
for T::VaData here?

T::VaData is stored within GpuVa<T>, which is logically owned by the GPUVM's
interval tree. Because GpuVm<T> does not require T::VaData to be Send + Syn=
c,
a user could implement DriverGpuVm with a !Send type for VaData.

Since GpuVm<T> explicitly bypasses the lack of Send on VaData,
UniqueRefGpuVm<T> automatically derives Send. This allows safe code to map
a VA containing !Send data on one thread, send the UniqueRefGpuVm<T> to
another thread, and unmap the VA there.

Unmapping via sm_unmap() returns a GpuVaRemoved<T> which drops the !Send
VaData on the wrong thread, potentially causing data races.

> +// SAFETY: The GPUVM api is designed to allow &self methods to be called=
 in parallel. `obtain()`
> +// called from several threads can return `ARef`s to the same bo, aliasi=
ng `T::VmBoData` and
> +// `T::Object`, and `deferred_cleanup()` can drop them from any thread, =
so both must be
> +// `Send + Sync`.
> +unsafe impl<T: DriverGpuVm> Sync for GpuVm<T>
> +where
> +    T::VmBoData: Send + Sync,
> +    T::Object: Send + Sync,
> +{
> +}

[Severity: Critical]
This is a pre-existing issue, but should the Sync implementation also inclu=
de
Send + Sync bounds for T::VaData for the same reasons?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609003256.1829=
625-4-samitolvanen@google.com?part=3D2
