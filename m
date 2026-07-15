Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3176C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4143810E21C;
	Wed, 15 Jul 2026 20:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="E5LajhRs";
	dkim-atps=neutral
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B3F10E21C
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 20:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1784145650; x=1784404850;
 bh=ts6KE6n9Ht+WSmkN6ONmApmjSk5JKTR9+DlMVacsjHI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=E5LajhRsefXNoy3rcDwGCGO67DRluuBWqpjiQEEPR1Lw7AOCmdDSz7EZue5aRN/ec
 37pauODZIOytJ6flDk8w9xm5rtgExZTd5rm83jJv0rkatrI4ZXUgz7uOb+qH3Pe5ll
 Y+AV51Kb2RfeniZm3jCAmDuaDammoJILAdFs/hcjcoPKL7jFI7ZMagnH8nC5bVpXgA
 ALzTTm/Ttl2l+ZLN1WLpvv6xBs4ErEzFyW8+/Rqhn45aNdK1yAHuHcumfeU1hqcAty
 K8XCPCsmGwkw+YInrSj7ixtCVD1wNtTjhx/NviV574a03L7jZvxY9Xgroboc4OYTIM
 bGAKsXGvJvrNA==
X-Pm-Submission-Id: 4h0n9447T0z1DFgp
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Tamir Duberstein <tamird@kernel.org>, Mirko Adzic <adzicmirko97@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v5 4/5] rust: Add dma_fence abstractions
Date: Wed, 15 Jul 2026 23:00:34 +0300
Message-ID: <20260715200036.46182-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260703073141.3962604-6-phasta@kernel.org>
References: <20260703073141.3962604-2-phasta@kernel.org>
 <20260703073141.3962604-6-phasta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, 03 Jul 2026 09:31:40 +0200=0D
Philipp Stanner <phasta@kernel.org> wrote:=0D
=0D
> C's dma_fence's are synchronisation primitives that will be needed by all=
=0D
> Rust GPU drivers.=0D
> =0D
> The dma_fence framework sets a number of rules, notably:=0D
>   - fences must only be signalled once=0D
>   - all fences must be signalled at some point=0D
>   - fence error codes must only be set before signalling=0D
>   - every pointer to a fence must be backed by a reference=0D
> =0D
> All those rules are being addressed by these abstractions.=0D
> =0D
> To cleanly decouple fence issuers and consumers, two types are provided:=
=0D
>   - DriverFence: the only fence type that can be signalled and that=0D
>     carries driver-specific data.=0D
>   - Fence: the fence type to be shared with other drivers and / or=0D
>     userspace. The only type callbacks can be registered on.=0D
>     Cannot be signalled.=0D
> =0D
> Hereby, a Fence lives in the same chunk of memory as a DriverFence. Both=
=0D
> share the refcount of the underlying C dma_fence. Since this=0D
> implementation does not provide a custom dma_fence_backend_ops.release()=
=0D
> function, the memory is freed by the dma_fence backend once the refcount=
=0D
> drops to 0.=0D
> =0D
> To create a DriverFence, the user must first allocate a=0D
> DriverFenceAllocation, so that the creation of the DriverFence later on=0D
> can always succeed. Otherwise, deadlocks could occur if fences need to=0D
> be created in a GPU job submission path.=0D
> =0D
> Synchronization is ensured by the dma_fence backend.=0D
> =0D
> All DriverFence's created through this abstraction must be signalled by=0D
> the creator with an error code. In case a DriverFence drops without=0D
> being signalled beforehand, it is signalled with -ECANCELLED as its=0D
> error and a warning is printed. This allows the Rust abstraction to very=
=0D
> cleanly decouple fence issuer and consumer by relying on the decoupling=0D
> mechanisms in the C backend, which ensures through RCU and the=0D
> 'signalled' fence-flag that dma_fence_backend_ops functions cannot=0D
> access the potentially unloaded driver code anymore.=0D
> =0D
> Signalling fences on drop thus grants many advantages. Not signalling=0D
> fences on drop would risk deadlock and does not grant real advantages:=0D
> By definition only the drivers can ensure that a fence always represents=
=0D
> the hardware's state correctly.=0D
> =0D
> This implementation models a DmaFenceCtx (fence context) object on which=
=0D
> fences are to be created, thereby ensuring correct sequence numbering=0D
> according to the timeline.=0D
> =0D
> dma_fence supports a variety of callbacks. The mandatory callbacks=0D
> (get_timeline_name() and get_driver_name()) are implemented in this=0D
> patch. For convenience, they store those name parameters in the fence=0D
> context, saving the driver from implementing these two callbacks.=0D
> =0D
> Support for other callbacks (like for hardware signalling) is prepared=0D
> for through the fact that both DriverFence and Fence live in the same=0D
> allocation, allowing for usage of container_of from the callback to=0D
> access the driver-specific data.=0D
> =0D
> Synchronization for backend_ops callbacks is ensured by only running the=
=0D
> Rust deconstructor delayed with call_rcu(), which prevents UAF-bugs=0D
> should a DriverFence drop while a Fence callback is currently operating=0D
> on the associated driver data.=0D
> =0D
> Add abstractions for dma_fence in Rust.=0D
> =0D
> Signed-off-by: Philipp Stanner <phasta@kernel.org>=0D
> ---=0D
>  rust/bindings/bindings_helper.h  |   1 +=0D
>  rust/helpers/dma_fence.c         |  48 ++=0D
>  rust/helpers/helpers.c           |   1 +=0D
>  rust/kernel/dma_buf/dma_fence.rs | 894 +++++++++++++++++++++++++++++++=0D
>  rust/kernel/dma_buf/mod.rs       |  14 +=0D
>  rust/kernel/lib.rs               |   1 +=0D
>  6 files changed, 959 insertions(+)=0D
>  create mode 100644 rust/helpers/dma_fence.c=0D
>  create mode 100644 rust/kernel/dma_buf/dma_fence.rs=0D
>  create mode 100644 rust/kernel/dma_buf/mod.rs=0D
> =0D
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h=0D
> index 1124785e210b..54b62d952e01 100644=0D
> --- a/rust/bindings/bindings_helper.h=0D
> +++ b/rust/bindings/bindings_helper.h=0D
> @@ -53,6 +53,7 @@=0D
>  #include <linux/debugfs.h>=0D
>  #include <linux/device/faux.h>=0D
>  #include <linux/dma-direction.h>=0D
> +#include <linux/dma-fence.h>=0D
>  #include <linux/dma-mapping.h>=0D
>  #include <linux/dma-resv.h>=0D
>  #include <linux/errname.h>=0D
> diff --git a/rust/helpers/dma_fence.c b/rust/helpers/dma_fence.c=0D
> new file mode 100644=0D
> index 000000000000..0e08411098fa=0D
> --- /dev/null=0D
> +++ b/rust/helpers/dma_fence.c=0D
> @@ -0,0 +1,48 @@=0D
> +// SPDX-License-Identifier: GPL-2.0=0D
> +=0D
> +#include <linux/dma-fence.h>=0D
> +=0D
> +__rust_helper void rust_helper_dma_fence_get(struct dma_fence *f)=0D
> +{=0D
> +	dma_fence_get(f);=0D
> +}=0D
> +=0D
> +__rust_helper void rust_helper_dma_fence_put(struct dma_fence *f)=0D
> +{=0D
> +	dma_fence_put(f);=0D
> +}=0D
> +=0D
> +__rust_helper bool rust_helper_dma_fence_begin_signalling(void)=0D
> +{=0D
> +	return dma_fence_begin_signalling();=0D
> +}=0D
> +=0D
> +__rust_helper void rust_helper_dma_fence_end_signalling(bool cookie)=0D
> +{=0D
> +	dma_fence_end_signalling(cookie);=0D
> +}=0D
> +=0D
> +__rust_helper bool rust_helper_dma_fence_is_signaled(struct dma_fence *f=
)=0D
> +{=0D
> +	return dma_fence_is_signaled(f);=0D
> +}=0D
> +=0D
> +__rust_helper bool rust_helper_dma_fence_test_signaled_flag(struct dma_f=
ence *f)=0D
> +{=0D
> +	return dma_fence_test_signaled_flag(f);=0D
> +}=0D
> +=0D
> +__rust_helper void rust_helper_dma_fence_lock_irqsave(struct dma_fence *=
f, unsigned long *flags)=0D
> +{=0D
> +	dma_fence_lock_irqsave(f, *flags);=0D
> +}=0D
> +=0D
> +__rust_helper void rust_helper_dma_fence_unlock_irqrestore(struct dma_fe=
nce *f, unsigned long *flags)=0D
> +{=0D
> +	dma_fence_unlock_irqrestore(f, *flags);=0D
> +}=0D
> +=0D
> +__rust_helper void rust_helper_dma_fence_set_error(struct dma_fence *f, =
int error)=0D
> +{=0D
> +	dma_fence_set_error(f, error);=0D
> +}=0D
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c=0D
> index 998e31052e66..4ab8aa9da7e7 100644=0D
> --- a/rust/helpers/helpers.c=0D
> +++ b/rust/helpers/helpers.c=0D
> @@ -58,6 +58,7 @@=0D
>  #include "cred.c"=0D
>  #include "device.c"=0D
>  #include "dma.c"=0D
> +#include "dma_fence.c"=0D
>  #include "dma-resv.c"=0D
>  #include "drm.c"=0D
>  #include "drm_gpuvm.c"=0D
> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs=0D
> new file mode 100644=0D
> index 000000000000..cbe8f447a603=0D
> --- /dev/null=0D
> +++ b/rust/kernel/dma_buf/dma_fence.rs=0D
> @@ -0,0 +1,894 @@=0D
> +// SPDX-License-Identifier: GPL-2.0=0D
> +//=0D
> +// Copyright (T) 2025, 2026 Red Hat Inc.:=0D
> +//   - Philipp Stanner <pstanner@redhat.com>=0D
> +=0D
> +//! DriverFence support.=0D
> +//!=0D
> +//! Reference: <https://docs.kernel.org/driver-api/dma-buf.html#c.dma_fe=
nce>=0D
> +//!=0D
> +//! T header: [`include/linux/dma-fence.h`](srctree/include/linux/dma-fe=
nce.h)=0D
> +=0D
> +use crate::{=0D
> +    alloc::AllocError,=0D
> +    bindings,=0D
> +    container_of,=0D
> +    error::to_result,=0D
> +    prelude::*,=0D
> +    types::ForeignOwnable,=0D
> +    types::Opaque,=0D
> +    warn_on, //=0D
> +};=0D
> +=0D
> +use core::{=0D
> +    marker::PhantomData,=0D
> +    mem::ManuallyDrop,=0D
> +    ops::Deref,=0D
> +    ptr,=0D
> +    ptr::{=0D
> +        drop_in_place,=0D
> +        NonNull, //=0D
> +    },=0D
> +    sync::atomic::{=0D
> +        AtomicU64,=0D
> +        Ordering, //=0D
> +    }, //=0D
> +};=0D
> +=0D
> +use kernel::{=0D
> +    str::CString,=0D
> +    sync::{=0D
> +        aref::{=0D
> +            ARef,=0D
> +            AlwaysRefCounted, //=0D
> +        },=0D
> +        rcu::rcu_barrier, //=0D
> +    }, //=0D
> +};=0D
> +=0D
> +/// VTable for dma_fence backend_ops callbacks.=0D
> +//=0D
> +// Mandatory dma_fence backend_ops are implemented implicitly through=0D
> +// [`FenceCtx`]. Additional ones shall get implemented on this trait, wh=
ich then=0D
> +// shall be demanded for the fence context data.=0D
> +pub trait FenceCtxOps {=0D
> +    /// The generic payload data for [`DriverFence`]s created on this fc=
tx.=0D
> +    type FenceDataType: Send + Sync;=0D
> +}=0D
> +=0D
> +/// A dma-fence context. A fence context takes care of associating relat=
ed fences=0D
> +/// with each other, providing each with raising sequence numbers and a =
common=0D
> +/// identifier.=0D
> +#[pin_data(PinnedDrop)]=0D
> +pub struct FenceCtx<T: Send + Sync> {=0D
> +    /// The fence context number.=0D
> +    nr: u64,=0D
> +    /// The sequence number for the next fence created.=0D
> +    seqno: AtomicU64,=0D
> +    // The name parameters can be accessed by the dma_fence backend_ops.=
 UAF=0D
> +    // errors are prevented by the `call_rcu()` in `drop_driver_fence_da=
ta()`.=0D
> +    /// The name of the driver this FenceCtx's fences belong to.=0D
> +    driver_name: CString,=0D
> +    /// The name of the timeline this FenceCtx's fences belong to.=0D
> +    timeline_name: CString,=0D
> +    /// The user's data.=0D
> +    #[pin]=0D
> +    data: T,=0D
> +}=0D
> +=0D
> +#[allow(unused_unsafe)]=0D
=0D
Why is this needed?=0D
=0D
> +impl<'a, T: Send + Sync + FenceCtxOps> FenceCtx<T> {=0D
> +    // This can later be extended as a vtable in case other parties need=
 support=0D
> +    // for the more "exotic" callbacks.=0D
> +    const OPS: bindings::dma_fence_ops =3D bindings::dma_fence_ops {=0D
> +        get_driver_name: Some(Self::get_driver_name),=0D
> +        get_timeline_name: Some(Self::get_timeline_name),=0D
> +        enable_signaling: None,=0D
> +        signaled: None,=0D
> +        wait: None,=0D
> +        release: None,=0D
> +        set_deadline: None,=0D
> +    };=0D
> +=0D
> +    /// Create a new `FenceCtx`.=0D
> +    pub fn new<E>(=0D
> +        driver_name: CString,=0D
> +        timeline_name: CString,=0D
> +        data: impl PinInit<T, E>,=0D
> +    ) -> impl PinInit<Self, Error>=0D
> +    where=0D
=0D
[...]=0D
=0D
> +    unsafe { bindings::dma_fence_put(fence) };=0D
> +=0D
> +    // The actual memory the data associated with a `DriverFence` lives =
in=0D
> +    // gets freed by the C dma_fence backend once the fence's refcount r=
eaches 0.=0D
> +}=0D
> diff --git a/rust/kernel/dma_buf/mod.rs b/rust/kernel/dma_buf/mod.rs=0D
> new file mode 100644=0D
> index 000000000000..fb353ce042ce=0D
> --- /dev/null=0D
> +++ b/rust/kernel/dma_buf/mod.rs=0D
> @@ -0,0 +1,14 @@=0D
> +// SPDX-License-Identifier: GPL-2.0 OR MIT=0D
> +=0D
> +//! DMA-buf subsystem abstractions.=0D
> +=0D
> +pub mod dma_fence;=0D
> +=0D
> +pub use self::dma_fence::{=0D
> +    DriverFence,=0D
> +    Fence,=0D
> +    FenceCb,=0D
> +    FenceCbRegistration,=0D
> +    FenceCtx,=0D
> +    FenceCtxOps, //=0D
> +};=0D
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs=0D
> index 9512af7156df..dc54d8af471f 100644=0D
> --- a/rust/kernel/lib.rs=0D
> +++ b/rust/kernel/lib.rs=0D
> @@ -64,6 +64,7 @@=0D
>  pub mod device_id;=0D
>  pub mod devres;=0D
>  pub mod dma;=0D
> +pub mod dma_buf;=0D
>  pub mod driver;=0D
>  #[cfg(CONFIG_DRM =3D "y")]=0D
>  pub mod drm;=0D
> -- =0D
> 2.54.0=0D
> =0D
