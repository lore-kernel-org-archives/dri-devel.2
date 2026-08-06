Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3847C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9BFB10E28C;
	Thu,  6 Aug 2026 13:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="fsSYEHfs";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id AA76910E28C
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 13:06:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A08DB153B;
 Thu,  6 Aug 2026 06:06:19 -0700 (PDT)
Received: from [10.57.42.103] (unknown [10.57.42.103])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FB883F632;
 Thu,  6 Aug 2026 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1786021583; bh=+1xfi0W07K1z1MC3MApW7voZeROhgwfoJlxbzKpR2r0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fsSYEHfsUZ15lnBqhHSfYJcvNTmm7IqWscjC/FMEEEuw2uLNkF95yPgrJDlyQ+xn7
 W+FFUBn+sJrdbhfTmln/aTOh48TeobtdTpzrs0Iz/D14oocH0wH0i+UBBcQzd0G3aG
 1ekjRXZbD8Dus9sRkOobpdV9KHVLtXkbmOESIOMg=
Message-ID: <3fcca119-82c1-421a-9822-d115dbc1a60b@arm.com>
Date: Thu, 6 Aug 2026 14:06:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: dma: add abstraction for the single-buffer
 streaming DMA API
To: Maurice Hieronymus <mhi@mailbox.org>, Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
References: <20260805-dma-streaming-v1-0-03974c86b141@mailbox.org>
 <20260805-dma-streaming-v1-2-03974c86b141@mailbox.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260805-dma-streaming-v1-2-03974c86b141@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026-08-05 10:54 pm, Maurice Hieronymus wrote:
> Add `Streaming`, a safe abstraction around `dma_map_single_attrs()`.
> 
> Between map and unmap the buffer belongs to the device, and the CPU may
> only access it in between a `dma_sync_single_for_cpu()` /
> `dma_sync_single_for_device()` pair. The types encode that protocol:
> 
> - `Streaming` owns the backing storage, so no other CPU-side reference
>    to the region exists.
> - `submit()` consumes it and returns a `StreamingInFlight`, the only
>    source of the `DmaAddress`. It owns the buffer, so the contents stay
>    unreachable while a transfer may be in flight, no matter where the
>    driver stores the address.
> - `for_cpu()` is therefore safe: no transfer can have been started from
>    a `Streaming`. It syncs for the CPU, returns a guard dereferencing to
>    the contents, and syncs for the device again on drop.
> - `complete()` turns a `StreamingInFlight` back into a `Streaming`.
>    Whether the device has finished cannot be checked by any abstraction,
>    so this is the one `unsafe` operation.

So while the for_cpu() operation itself is the one which could actually 
break coherency and corrupt the buffer contents if the device is still 
writing, we attribute that to the caller having to have erroneously 
declared complete() already in order to be able to do so. But when used 
correctly, we can cycle through complete()/for_cpu()/submit() to recycle 
the same buffer and mapping for multiple transfers within the lifetime 
of the Streaming object. Took me a moment to get it, but this seems like 
a pretty OK design to me.

> Dropping a `StreamingInFlight` leaks the mapping and the backing
> storage, with a warning. A transfer may still be in flight: freeing the
> storage would leave the device writing through a dangling handle, and
> even unmapping could recycle a SWIOTLB bounce slot mid-transfer.
> Reclaiming either takes the assertion only `complete()` can make, so an
> early `?` return between `submit()` and `complete()` costs a leak
> instead of a device-side use-after-free.
> 
> The mapping is torn down on drop of a `Streaming`, or by
> `into_inner()`, which returns the backing storage. Unmapping already
> hands the buffer back to the CPU, so `into_inner()` skips a
> synchronization nothing would consume.
> 
> The `'a` lifetime binds the mapping to a `Device<Bound>`: the DMA API
> may only be called while a driver is bound, and `Drop` unmaps.
> 
> `DataDirection::None` (a `BUG_ON()` in the DMA core) and empty buffers
> (not representable by `dma_map_single()`) are rejected with `EINVAL`.
> So are `DMA_ATTR_SKIP_CPU_SYNC`, which disables the implicit CPU cache
> maintenance the type invariants are built on with no way to compensate
> through this API, and `DMA_ATTR_MMIO`, which describes memory a
> `ContiguousBuffer` cannot represent.

Yeah, SKIP_CPU_SYNC is a little tricky as it effectively has two 
different use-cases - one is publishing the same buffer to multiple 
devices, which I guess might best be encapsulated as some new variant to 
be created from an existing Streaming object and a different device, 
while the other is effectively still the same model as here, just with 
the object starting in, and/or being torn down directly from, the 
for_cpu state.

Indeed we can safely say that we should never need to accept MMIO here 
though - dma_map_resource() can have its own Rust abstraction if and 
when anyone wants that, and the P2P dma-buf business would also be its 
own whole other issue anyway.

Thanks,
Robin.

> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
> ---
>   rust/helpers/dma.c |  35 +++++
>   rust/kernel/dma.rs | 392 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 427 insertions(+)
> 
> diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
> index 9fbeb507b08c..7e1e5c67431a 100644
> --- a/rust/helpers/dma.c
> +++ b/rust/helpers/dma.c
> @@ -49,3 +49,38 @@ __rust_helper void rust_helper_dma_set_max_seg_size(struct device *dev,
>   {
>   	dma_set_max_seg_size(dev, size);
>   }
> +
> +__rust_helper dma_addr_t rust_helper_dma_map_single_attrs(struct device *dev,
> +							  void *ptr, size_t size,
> +							  enum dma_data_direction dir,
> +							  unsigned long attrs)
> +{
> +	return dma_map_single_attrs(dev, ptr, size, dir, attrs);
> +}
> +
> +__rust_helper void rust_helper_dma_unmap_single_attrs(struct device *dev,
> +						      dma_addr_t addr, size_t size,
> +						      enum dma_data_direction dir,
> +						      unsigned long attrs)
> +{
> +	dma_unmap_single_attrs(dev, addr, size, dir, attrs);
> +}
> +
> +__rust_helper int rust_helper_dma_mapping_error(struct device *dev, dma_addr_t addr)
> +{
> +	return dma_mapping_error(dev, addr);
> +}
> +
> +__rust_helper void rust_helper_dma_sync_single_for_cpu(struct device *dev,
> +						       dma_addr_t addr, size_t size,
> +						       enum dma_data_direction dir)
> +{
> +	dma_sync_single_for_cpu(dev, addr, size, dir);
> +}
> +
> +__rust_helper void rust_helper_dma_sync_single_for_device(struct device *dev,
> +							  dma_addr_t addr, size_t size,
> +							  enum dma_data_direction dir)
> +{
> +	dma_sync_single_for_device(dev, addr, size, dir);
> +}
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 8a8af5ab7feb..cbaf30a2de86 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -24,6 +24,7 @@
>       uaccess::UserSliceWriter,
>   };
>   use core::{
> +    mem::ManuallyDrop,
>       ops::{
>           Deref,
>           DerefMut, //
> @@ -345,6 +346,14 @@ const fn const_cast(val: bindings::dma_data_direction) -> u32 {
>           // is within the representable range of `u32`.
>           wide_val as u32
>       }
> +
> +    /// Returns whether this direction may be passed to a mapping or synchronization primitive.
> +    ///
> +    /// Equivalent to `valid_dma_direction()`; [`Self::None`] is a debugging aid the DMA core
> +    /// rejects with a `BUG_ON()`.
> +    const fn is_valid(self) -> bool {
> +        !matches!(self, Self::None)
> +    }
>   }
>   
>   impl From<DataDirection> for bindings::dma_data_direction {
> @@ -621,6 +630,389 @@ fn data(&mut self) -> &mut Self::Data {
>       }
>   }
>   
> +/// An abstraction of the `dma_map_single` API.
> +///
> +/// Unlike [`Coherent`], a streaming mapping is a temporary lease on memory the caller already
> +/// owns: between mapping and unmapping the buffer belongs to the device, and the CPU may only
> +/// access it in between a `dma_sync_single_for_cpu()` / `dma_sync_single_for_device()` pair.
> +///
> +/// [`Streaming`] owns the backing storage and is one of two states: [`submit`](Self::submit)
> +/// consumes it and returns a [`StreamingInFlight`], the only source of the [`DmaAddress`];
> +/// [`complete`](StreamingInFlight::complete) turns that back into a [`Streaming`], whose
> +/// [`for_cpu`](Self::for_cpu) yields a [`StreamingCpuGuard`] dereferencing to the contents.
> +///
> +/// The mapping is torn down on drop of a [`Streaming`], or by [`into_inner`](Self::into_inner),
> +/// which returns the backing storage. Dropping a [`StreamingInFlight`] instead leaks the mapping
> +/// and the storage: safe code cannot prove the device is done, so it cannot be allowed to reclaim
> +/// either.
> +///
> +/// The `'a` lifetime keeps the device bound for the life of the mapping.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::device::{Bound, Device};
> +/// use kernel::dma::{
> +///     DataDirection,
> +///     Streaming, //
> +/// };
> +///
> +/// # fn test(dev: &Device<Bound>) -> Result {
> +/// let buf = KBox::new(0u64, GFP_KERNEL)?;
> +/// let mut dma = Streaming::new(dev, buf, DataDirection::Bidirectional)?;
> +///
> +/// // The CPU prepares the buffer, and hands it back to the device by dropping the guard.
> +/// *dma.for_cpu() = 42;
> +///
> +/// // Hand the buffer to the device; `dma` is consumed, so its contents are now unreachable.
> +/// let dma = dma.submit();
> +///
> +/// // Program `dma.dma_handle()` and `dma.size()` into the device.
> +///
> +/// // SAFETY: For the sake of the example, assume the transfer has been waited for.
> +/// let mut dma = unsafe { dma.complete() };
> +///
> +/// assert_eq!(*dma.for_cpu(), 42);
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// * `dma_addr` denotes a live mapping of `container` for the lifetime of the instance, and
> +///   `container`, `direction` and `dma_attrs` are unchanged since it was established.
> +/// * `direction` is not [`DataDirection::None`].
> +/// * The buffer is synchronized for the device whenever no [`StreamingCpuGuard`] borrowed from
> +///   this instance is alive.
> +pub struct Streaming<'a, C: ContiguousBuffer> {
> +    container: C,
> +    direction: DataDirection,
> +    dma_addr: DmaAddress,
> +    dma_attrs: Attrs,
> +    dev: &'a device::Device<Bound>,
> +}
> +
> +impl<'a, C: ContiguousBuffer> Streaming<'a, C> {
> +    /// Maps `container` for streaming DMA in `direction`.
> +    ///
> +    /// Ownership of `container` is moved into the returned [`Streaming`]; the buffer belongs to
> +    /// the device until [`for_cpu`](Self::for_cpu) is called.
> +    ///
> +    /// Returns [`EINVAL`] for an empty buffer, for [`DataDirection::None`], or if `dma_attrs`
> +    /// contains [`DMA_ATTR_SKIP_CPU_SYNC`](attrs::DMA_ATTR_SKIP_CPU_SYNC) or
> +    /// [`DMA_ATTR_MMIO`](attrs::DMA_ATTR_MMIO).
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # use kernel::device::{Bound, Device};
> +    /// use kernel::dma::{
> +    ///     attrs::*,
> +    ///     DataDirection,
> +    ///     Streaming, //
> +    /// };
> +    ///
> +    /// # fn test(dev: &Device<Bound>) -> Result {
> +    /// let buf = KBox::new(0u64, GFP_KERNEL)?;
> +    /// let dma = Streaming::new_with_attrs(
> +    ///     dev,
> +    ///     buf,
> +    ///     DataDirection::ToDevice,
> +    ///     DMA_ATTR_WEAK_ORDERING,
> +    /// )?;
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub fn new_with_attrs(
> +        dev: &'a device::Device<Bound>,
> +        mut container: C,
> +        direction: DataDirection,
> +        dma_attrs: Attrs,
> +    ) -> Result<Self> {
> +        // The DMA core `BUG_ON()`s on `DMA_NONE`, bail early.
> +        if !direction.is_valid() {
> +            return Err(EINVAL);
> +        }
> +
> +        // The type invariants are built on the implicit CPU cache maintenance performed by
> +        // `dma_map_single_attrs()` and `dma_unmap_single_attrs()`; `DMA_ATTR_SKIP_CPU_SYNC`
> +        // disables it, with no way to compensate through this API. `DMA_ATTR_MMIO` describes
> +        // memory a `ContiguousBuffer` cannot represent.
> +        if dma_attrs.contains(attrs::DMA_ATTR_SKIP_CPU_SYNC)
> +            || dma_attrs.contains(attrs::DMA_ATTR_MMIO)
> +        {
> +            return Err(EINVAL);
> +        }
> +
> +        let size = container.size();
> +
> +        // `dma_map_single_attrs` cannot handle zero-length mappings, bail early.
> +        if size == 0 {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY:
> +        // - Device pointer is guaranteed as valid by the type invariant on `Device`.
> +        // - By the safety requirements of `ContiguousBuffer`, `container.ptr()` points to a single
> +        //   physically contiguous region of `size` bytes in the kernel's linear mapping.
> +        // - `container` is moved into `Self` below, so the region stays alive and at a stable
> +        //   address until the mapping is torn down in `Drop`.
> +        let dma_addr = unsafe {
> +            bindings::dma_map_single_attrs(
> +                dev.as_raw(),
> +                container.ptr(),
> +                size,
> +                direction.into(),
> +                dma_attrs.as_raw(),
> +            )
> +        };
> +
> +        // SAFETY: Device pointer is valid per the above, and `dma_addr` was just returned by
> +        // `dma_map_single_attrs()` for this device.
> +        to_result(unsafe { bindings::dma_mapping_error(dev.as_raw(), dma_addr) })?;
> +
> +        // INVARIANT:
> +        // - The mapping was just established with these exact parameters, none of which is
> +        //   mutated afterwards.
> +        // - `direction` was checked above.
> +        Ok(Streaming {
> +            container,
> +            direction,
> +            dma_addr,
> +            dma_attrs,
> +            dev,
> +        })
> +    }
> +
> +    /// Performs the same functionality as [`Streaming::new_with_attrs`], except the `dma_attrs`
> +    /// is 0 by default.
> +    #[inline]
> +    pub fn new(
> +        dev: &'a device::Device<Bound>,
> +        container: C,
> +        direction: DataDirection,
> +    ) -> Result<Self> {
> +        Self::new_with_attrs(dev, container, direction, Attrs(0))
> +    }
> +
> +    /// Returns the size of the mapping in bytes.
> +    #[inline]
> +    pub fn size(&self) -> usize {
> +        self.container.size()
> +    }
> +
> +    /// Returns the direction this buffer was mapped with.
> +    #[inline]
> +    pub fn direction(&self) -> DataDirection {
> +        self.direction
> +    }
> +
> +    /// Hands the buffer to the device.
> +    ///
> +    /// This performs no synchronization: by the type invariants the buffer is already
> +    /// synchronized for the device.
> +    #[inline]
> +    pub fn submit(self) -> StreamingInFlight<'a, C> {
> +        StreamingInFlight(ManuallyDrop::new(self))
> +    }
> +
> +    /// Transfers ownership of the buffer back to the CPU and returns a guard granting access to
> +    /// its contents.
> +    ///
> +    /// Dropping the guard transfers ownership back to the device. If the buffer is not handed to
> +    /// the device again, prefer [`into_inner`](Self::into_inner), which unmaps instead.
> +    pub fn for_cpu(&mut self) -> StreamingCpuGuard<'_, C::Data> {
> +        let dev = self.dev;
> +        let dma_addr = self.dma_addr;
> +        let direction = self.direction;
> +        let size = self.container.size();
> +
> +        // SAFETY: By the type invariants, `dev` is bound and `dma_addr` denotes a live mapping of
> +        // `size` bytes established with `direction`, which is the range synced here.
> +        unsafe {
> +            bindings::dma_sync_single_for_cpu(dev.as_raw(), dma_addr, size, direction.into())
> +        };
> +
> +        // INVARIANT: The buffer is now owned by the CPU, and dropping the guard hands it back.
> +        StreamingCpuGuard {
> +            data: self.container.data(),
> +            dev,
> +            dma_addr,
> +            size,
> +            direction,
> +        }
> +    }
> +
> +    /// Tears the mapping down and returns the backing storage.
> +    ///
> +    /// Unmapping transfers ownership of the buffer back to the CPU, so no separate
> +    /// [`for_cpu`](Self::for_cpu) is needed.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # use kernel::device::{Bound, Device};
> +    /// use kernel::dma::{
> +    ///     DataDirection,
> +    ///     Streaming, //
> +    /// };
> +    ///
> +    /// # fn test(dev: &Device<Bound>) -> Result {
> +    /// let dma = Streaming::new(
> +    ///     dev,
> +    ///     KBox::new(0u64, GFP_KERNEL)?,
> +    ///     DataDirection::FromDevice,
> +    /// )?
> +    /// .submit();
> +    ///
> +    /// // Program `dma.dma_handle()` into the device.
> +    ///
> +    /// // SAFETY: For the sake of the example, assume the transfer has been waited for.
> +    /// let dma = unsafe { dma.complete() };
> +    ///
> +    /// // Take the buffer back; the mapping is gone once this returns.
> +    /// let buf: KBox<u64> = dma.into_inner();
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub fn into_inner(self) -> C {
> +        let mut this = ManuallyDrop::new(self);
> +
> +        this.unmap();
> +
> +        // SAFETY: `this` is wrapped in a `ManuallyDrop`, so `Streaming::drop()` never runs and
> +        // `this.container` is never read again. The remaining fields are all `Copy`.
> +        unsafe { core::ptr::read(&this.container) }
> +    }
> +
> +    /// Tears the mapping down.
> +    ///
> +    /// Shared by [`Drop`] and [`into_inner`](Self::into_inner), both of which run it exactly once.
> +    fn unmap(&mut self) {
> +        // SAFETY: By the type invariants, `self.dev` is bound and the mapping is still live, with
> +        // exactly the address, size, direction and attributes it was created with. Both callers
> +        // run this at most once, so the mapping cannot be torn down twice.
> +        unsafe {
> +            bindings::dma_unmap_single_attrs(
> +                self.dev.as_raw(),
> +                self.dma_addr,
> +                self.container.size(),
> +                self.direction.into(),
> +                self.dma_attrs.as_raw(),
> +            )
> +        };
> +    }
> +}
> +
> +impl<C: ContiguousBuffer> Drop for Streaming<'_, C> {
> +    fn drop(&mut self) {
> +        self.unmap();
> +    }
> +}
> +
> +/// A [`Streaming`] mapping whose [`DmaAddress`] has been handed out.
> +///
> +/// Returned by [`Streaming::submit`]. It owns the buffer, so the contents are unreachable while
> +/// it exists. [`complete`](Self::complete) is the only way back: it is the caller's assertion
> +/// that the device has finished, which nothing else can establish. Dropping this instead leaks
> +/// the mapping and the backing storage, since reclaiming either while the device may still
> +/// access the buffer would be a use-after-free.
> +pub struct StreamingInFlight<'a, C: ContiguousBuffer>(ManuallyDrop<Streaming<'a, C>>);
> +
> +impl<'a, C: ContiguousBuffer> StreamingInFlight<'a, C> {
> +    /// Returns the DMA address to program into the device.
> +    #[inline]
> +    pub fn dma_handle(&self) -> DmaAddress {
> +        self.0.dma_addr
> +    }
> +
> +    /// Returns the size of the mapping in bytes.
> +    #[inline]
> +    pub fn size(&self) -> usize {
> +        self.0.size()
> +    }
> +
> +    /// Returns the direction this buffer was mapped with.
> +    #[inline]
> +    pub fn direction(&self) -> DataDirection {
> +        self.0.direction()
> +    }
> +
> +    /// Takes the buffer back from the device.
> +    ///
> +    /// This performs no synchronization; [`Streaming::for_cpu`] does that.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The device must have finished accessing the buffer.
> +    #[inline]
> +    pub unsafe fn complete(self) -> Streaming<'a, C> {
> +        let mut this = ManuallyDrop::new(self);
> +
> +        // SAFETY: `this` is wrapped in a `ManuallyDrop`, so `StreamingInFlight::drop()` never
> +        // runs and `this.0` is never touched again.
> +        unsafe { ManuallyDrop::take(&mut this.0) }
> +    }
> +}
> +
> +impl<C: ContiguousBuffer> Drop for StreamingInFlight<'_, C> {
> +    fn drop(&mut self) {
> +        // A transfer may still be in flight: freeing the storage would leave the device writing
> +        // through a dangling handle, and unmapping could recycle a SWIOTLB bounce slot
> +        // mid-transfer. Reclaiming either requires the assertion only `complete()` can make, so
> +        // leak both.
> +        dev_warn!(
> +            self.0.dev,
> +            "StreamingInFlight dropped without complete(); leaking the mapping and its storage\n"
> +        );
> +    }
> +}
> +
> +/// A guard granting the CPU access to the contents of a [`Streaming`] buffer.
> +///
> +/// Returned by [`Streaming::for_cpu`]. Dropping it issues a `dma_sync_single_for_device()`, which
> +/// hands the buffer back to the device.
> +///
> +/// # Invariants
> +///
> +/// * `dev`, `dma_addr`, `size` and `direction` describe the live mapping of the [`Streaming`] this
> +///   guard borrows, and are unchanged for the lifetime of the guard.
> +/// * `data` refers to exactly the mapped region.
> +pub struct StreamingCpuGuard<'a, T: ?Sized> {
> +    data: &'a mut T,
> +    dev: &'a device::Device<Bound>,
> +    dma_addr: DmaAddress,
> +    size: usize,
> +    direction: DataDirection,
> +}
> +
> +impl<T: ?Sized> Drop for StreamingCpuGuard<'_, T> {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, `self.dev` is bound and `self.dma_addr` denotes a live
> +        // mapping of `self.size` bytes established with `self.direction`, which is the range
> +        // synced here.
> +        unsafe {
> +            bindings::dma_sync_single_for_device(
> +                self.dev.as_raw(),
> +                self.dma_addr,
> +                self.size,
> +                self.direction.into(),
> +            )
> +        };
> +    }
> +}
> +
> +impl<T: ?Sized> Deref for StreamingCpuGuard<'_, T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        self.data
> +    }
> +}
> +
> +impl<T: ?Sized> DerefMut for StreamingCpuGuard<'_, T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        self.data
> +    }
> +}
> +
>   /// An abstraction of the `dma_alloc_coherent` API.
>   ///
>   /// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
> 

