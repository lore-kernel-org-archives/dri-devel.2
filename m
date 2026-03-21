Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C246D1094489
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 18:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93C210E211;
	Sat, 21 Mar 2026 18:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="In99FVRi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A23D10E211;
 Sat, 21 Mar 2026 18:22:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B61760097;
 Sat, 21 Mar 2026 18:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F40C19421;
 Sat, 21 Mar 2026 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774117364;
 bh=DxozQ+XKxQ0fD6TkCuvC+HyBcPkFBTcRM0Dqohddfo0=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=In99FVRiLVR8JAEuAUj37ZAcjEfc/J9DLBPt7ErZAudMrz9sxPDkUu7kINQ53iphh
 j4Y0tIsVIqCz28Y3qLSPlKHUN9V9U2iNt8bkhYaZTx9w3ESus1B3hfYqAQmGShk83Y
 2jBI11W/0fVaX3WroucaUZ7HQMTvR6a7EY0ImrGrGRmIwl67Ea0cbgWxk/0d4xl/ZH
 lDCTE9MEU7KNpB0SCqizoTGi8tTq1NCoerX1CNN1gWwMgeNIun78FOMf/x9iMlNOQf
 vXtF8z+NLhwUn8dr2eBFpXV66WQXNC8mQr5mXzK/WsIqlU+2ONFN0GAGkqJ4sdEPt1
 oX2ybLE9f/J7w==
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 19:22:39 +0100
Message-Id: <DH8O47F2GM1Z.3H3E13RSKIV22@kernel.org>
Cc: <aliceryhl@google.com>, <acourbot@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 8/8] gpu: nova-core: convert to new dma::Coherent API
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
References: <20260320194626.36263-1-dakr@kernel.org>
 <20260320194626.36263-9-dakr@kernel.org>
 <DH8M5QZKZETW.3TA4YS1SBAXDP@garyguo.net>
Content-Language: en-US
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=0
X-Identity-Key: id8
Fcc: imap://kernel%40dakr.org@imap.dakr.org/Sent
In-Reply-To: <DH8M5QZKZETW.3TA4YS1SBAXDP@garyguo.net>
Content-Transfer-Encoding: 7bit
X-TUID: 9r29XOjfZmFI
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

On 3/21/26 5:50 PM, Gary Guo wrote:
> It looks like with Alex's "gpu: nova-core: create falcon firmware DMA objects
> lazily" landed, all others users of the old API are now gone.

Good catch.

> So this line could be dropped and `impl CoherentAllocation` and the type alias
> can be removed after this patch.

I will drop the line on apply and add the below patch to remove
CoherentAllocation.

- Danilo

commit e96bc0b65bec48ac0f1cf2fc15b39c1b26b9d973 (HEAD -> drm-rust-next)
Author: Danilo Krummrich <dakr@kernel.org>
Date:   Sat Mar 21 19:18:08 2026 +0100

    rust: dma: remove dma::CoherentAllocation<T>

    Now that everything has been converted to the new dma::Coherent<T> API,
    remove dma::CoherentAllocation<T>.

    Suggested-by: Gary Guo <gary@garyguo.net>
    Signed-off-by: Danilo Krummrich <dakr@kernel.org>

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 6d2bec52806b..779d4babab9a 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -841,156 +841,6 @@ pub fn len(&self) -> usize {
     }
 }

-// Type alias for compatibility.
-#[doc(hidden)]
-pub type CoherentAllocation<T> = Coherent<[T]>;
-
-impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
-    /// Allocates a region of `size_of::<T> * count` of coherent memory.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// # use kernel::device::{Bound, Device};
-    /// use kernel::dma::{attrs::*, CoherentAllocation};
-    ///
-    /// # fn test(dev: &Device<Bound>) -> Result {
-    /// let c: CoherentAllocation<u64> =
-    ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
-    /// # Ok::<(), Error>(()) }
-    /// ```
-    pub fn alloc_attrs(
-        dev: &device::Device<Bound>,
-        count: usize,
-        gfp_flags: kernel::alloc::Flags,
-        dma_attrs: Attrs,
-    ) -> Result<CoherentAllocation<T>> {
-        Coherent::alloc_slice_with_attrs(dev, count, gfp_flags, dma_attrs)
-    }
-
-    /// Performs the same functionality as [`CoherentAllocation::alloc_attrs`], except the
-    /// `dma_attrs` is 0 by default.
-    pub fn alloc_coherent(
-        dev: &device::Device<Bound>,
-        count: usize,
-        gfp_flags: kernel::alloc::Flags,
-    ) -> Result<CoherentAllocation<T>> {
-        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attrs(0))
-    }
-
-    /// Returns the base address to the allocated region in the CPU's virtual address space.
-    pub fn start_ptr(&self) -> *const T {
-        self.as_ptr().cast()
-    }
-
-    /// Returns the base address to the allocated region in the CPU's virtual address space as
-    /// a mutable pointer.
-    pub fn start_ptr_mut(&mut self) -> *mut T {
-        self.as_mut_ptr().cast()
-    }
-
-    /// Returns a DMA handle starting at `offset` (in units of `T`) which may be given to the
-    /// device as the DMA address base of the region.
-    ///
-    /// Returns `EINVAL` if `offset` is not within the bounds of the allocation.
-    pub fn dma_handle_with_offset(&self, offset: usize) -> Result<DmaAddress> {
-        if offset >= self.len() {
-            Err(EINVAL)
-        } else {
-            Ok(self.dma_handle + (offset * core::mem::size_of::<T>()) as DmaAddress)
-        }
-    }
-
-    /// Common helper to validate a range applied from the allocated region in the CPU's virtual
-    /// address space.
-    fn validate_range(&self, offset: usize, count: usize) -> Result {
-        if offset.checked_add(count).ok_or(EOVERFLOW)? > self.len() {
-            return Err(EINVAL);
-        }
-        Ok(())
-    }
-
-    /// Returns the data from the region starting from `offset` as a slice.
-    /// `offset` and `count` are in units of `T`, not the number of bytes.
-    ///
-    /// For ringbuffer type of r/w access or use-cases where the pointer to the live data is needed,
-    /// [`CoherentAllocation::start_ptr`] or [`CoherentAllocation::start_ptr_mut`] could be used
-    /// instead.
-    ///
-    /// # Safety
-    ///
-    /// * Callers must ensure that the device does not read/write to/from memory while the returned
-    ///   slice is live.
-    /// * Callers must ensure that this call does not race with a write to the same region while
-    ///   the returned slice is live.
-    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
-        self.validate_range(offset, count)?;
-        // SAFETY:
-        // - The pointer is valid due to type invariant on `CoherentAllocation`,
-        //   we've just checked that the range and index is within bounds. The immutability of the
-        //   data is also guaranteed by the safety requirements of the function.
-        // - `offset + count` can't overflow since it is smaller than `self.count` and we've checked
-        //   that `self.count` won't overflow early in the constructor.
-        Ok(unsafe { core::slice::from_raw_parts(self.start_ptr().add(offset), count) })
-    }
-
-    /// Performs the same functionality as [`CoherentAllocation::as_slice`], except that a mutable
-    /// slice is returned.
-    ///
-    /// # Safety
-    ///
-    /// * Callers must ensure that the device does not read/write to/from memory while the returned
-    ///   slice is live.
-    /// * Callers must ensure that this call does not race with a read or write to the same region
-    ///   while the returned slice is live.
-    pub unsafe fn as_slice_mut(&mut self, offset: usize, count: usize) -> Result<&mut [T]> {
-        self.validate_range(offset, count)?;
-        // SAFETY:
-        // - The pointer is valid due to type invariant on `CoherentAllocation`,
-        //   we've just checked that the range and index is within bounds. The immutability of the
-        //   data is also guaranteed by the safety requirements of the function.
-        // - `offset + count` can't overflow since it is smaller than `self.count` and we've checked
-        //   that `self.count` won't overflow early in the constructor.
-        Ok(unsafe { core::slice::from_raw_parts_mut(self.start_ptr_mut().add(offset), count) })
-    }
-
-    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
-    /// number of bytes.
-    ///
-    /// # Safety
-    ///
-    /// * Callers must ensure that this call does not race with a read or write to the same region
-    ///   that overlaps with this write.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -> Result {
-    /// let somedata: [u8; 4] = [0xf; 4];
-    /// let buf: &[u8] = &somedata;
-    /// // SAFETY: There is no concurrent HW operation on the device and no other R/W access to the
-    /// // region.
-    /// unsafe { alloc.write(buf, 0)?; }
-    /// # Ok::<(), Error>(()) }
-    /// ```
-    pub unsafe fn write(&mut self, src: &[T], offset: usize) -> Result {
-        self.validate_range(offset, src.len())?;
-        // SAFETY:
-        // - The pointer is valid due to type invariant on `CoherentAllocation`
-        //   and we've just checked that the range and index is within bounds.
-        // - `offset + count` can't overflow since it is smaller than `self.count` and we've checked
-        //   that `self.count` won't overflow early in the constructor.
-        unsafe {
-            core::ptr::copy_nonoverlapping(
-                src.as_ptr(),
-                self.start_ptr_mut().add(offset),
-                src.len(),
-            )
-        };
-        Ok(())
-    }
-}
-
 /// Note that the device configured to do DMA must be halted before this object is dropped.
 impl<T: KnownSize + ?Sized> Drop for Coherent<T> {
     fn drop(&mut self) {
