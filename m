Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D05CF54ABA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A1310E6E7;
	Tue, 24 Mar 2026 14:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c+GG5n3k";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BF710E6E9;
 Tue, 24 Mar 2026 14:00:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 01BF460120;
 Tue, 24 Mar 2026 14:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4D8C2BCB2;
 Tue, 24 Mar 2026 14:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774360852;
 bh=nFDs461qGRQbZs3PvToXFNe9Yue8j0z6IlgIHuLx5a4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=c+GG5n3k/xxHG4snLQ1EG5kug4Nq1Cmfjoz9ogNaXvCvfIBd5iAXGuxp7qggPkxj5
 AqyiHCNzem3YnkLqqsZnt7zkALfB6K2GMfiUcLDTGcHwva7ASJNqg8F1ZEWiVEDfb1
 yDzgBpJmUTp3QhkPZQxPHMdrSJFRZFmvkVv1kgtETcfKmPxRoCO3mY3gNoG8HL70pY
 UCgOUeIq4JlysINNVPNLQUHHFge1cemwUbsPNMM4TxE1rNcCmREQbR24j6dX/Cs10s
 ywV8Hgqr3S5Av0TBfFEsZ5Ys+WeCNz33hZkE+S9bx3Z/0bh//ZcGpKuinGq1qTRvBV
 GAKXlR2CxyDHQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com,
 acourbot@nvidia.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com
Cc: driver-core@lists.linux.dev, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 5/8] rust: dma: add Coherent:init() and
 Coherent::init_with_attrs()
In-Reply-To: <20260320194626.36263-6-dakr@kernel.org>
References: <20260320194626.36263-1-dakr@kernel.org>
 <4yknLBbwY93Ty2ltbpxjHgto-m99xkoTgDlKv8cJTK2tbFL0_V6eQDjwbbXI70M6uMKT6RLRxBoYR_XeymmnHA==@protonmail.internalid>
 <20260320194626.36263-6-dakr@kernel.org>
Date: Tue, 24 Mar 2026 15:00:38 +0100
Message-ID: <87y0jhpbsp.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

"Danilo Krummrich" <dakr@kernel.org> writes:

> Analogous to Coherent::zeroed() and Coherent::zeroed_with_attrs(), add
> Coherent:init() and Coherent::init_with_attrs() which both take an impl
> Init<T, E> argument initializing the DMA coherent memory.
>
> Compared to CoherentInit, Coherent::init() is a one-shot constructor
> that runs an Init closure and immediately exposes the DMA handle,
> whereas CoherentInit is a multi-stage initializer that provides safe
> &mut T access by withholding the DMA address until converted to
> Coherent.

You forgot to update this to CoherentBox

>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/dma.rs | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index cefb54f0424a..6d2bec52806b 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -709,6 +709,44 @@ pub fn zeroed(dev: &device::Device<Bound>, gfp_flags: kernel::alloc::Flags) -> R
>          Self::zeroed_with_attrs(dev, gfp_flags, Attrs(0))
>      }
>
> +    /// Same as [`Coherent::zeroed_with_attrs`], but instead of a zero-initialization the memory is
> +    /// initialized with `init`.
> +    pub fn init_with_attrs<E>(
> +        dev: &device::Device<Bound>,
> +        gfp_flags: kernel::alloc::Flags,
> +        dma_attrs: Attrs,
> +        init: impl Init<T, E>,
> +    ) -> Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        let dmem = Self::alloc_with_attrs(dev, gfp_flags, dma_attrs)?;
> +        let ptr = dmem.as_mut_ptr();
> +
> +        // SAFETY:
> +        // - `ptr` is valid, properly aligned, and points to exclusively owned memory.
> +        // - If `__init` fails, `self` is dropped, which safely frees the underlying `Coherent`'s
> +        //   DMA memory. `T: AsBytes + FromBytes` ensures there are no complex `Drop` requirements
> +        //   we are bypassing.
> +        unsafe { init.__init(ptr)? };
> +
> +        Ok(dmem)
> +    }
> +
> +    /// Same as [`Coherent::zeroed`], but instead of a zero-initialization the memory is initialized
> +    /// with `init`.
> +    #[inline]
> +    pub fn init<E>(
> +        dev: &device::Device<Bound>,
> +        gfp_flags: kernel::alloc::Flags,
> +        init: impl Init<T, E>,
> +    ) -> Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        Self::init_with_attrs(dev, gfp_flags, Attrs(0), init)
> +    }
> +

I think we are missing an array initializer for `Coherent<[T]>`.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



