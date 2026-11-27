Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B1606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrdmPbgt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF9D10EABF;
	Fri, 27 Nov 2026 21:07:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF59810EABF
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 21:06:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E41A60238;
 Fri, 27 Nov 2026 21:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679081F00893;
 Fri, 27 Nov 2026 21:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795813614;
 bh=x2vbCxhKlDEYGyJLF8a1r9DvhsL84+yAuxXVlq9Dapc=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=VrdmPbgtrUh9fv6xn4MIpy2/VbzIxqsxaUK+so8t3HGTNxx5Fdf22S/BihAuOFu89
 FM/jVk1tzAxNs3OCGXQTOIrXrXSFKZFYG6S5TJVOyS78eVoIxN7cSdKLD3dQV4HHId
 uHCuSCFDn5Xg22M4GEw8Db3dMCxRboJHBFUZN/TMswBCbOy5KTzfrg2enlM/0E6qQY
 4+N5Z3x/YrPTHclUQHwUCOOwuxik+/BiZvRyBRH7yHfApp6Aqhc8n3FcAEYHfH5ckb
 eWPtnke6gZs0Fl5qyCplhwWYgZ9Lh/FInGRPLwVC1kXhR6BzyvD+aGSFMyPiomkIJA
 7RnkuRW/oU9ew==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 22:06:50 +0100
Message-Id: <DN6ASNF6NW8Q.13GAZAC9LHRN3@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] rust: dma_buf: dma_fence: add SignallingSection
Cc: "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Philipp
 Stanner" <phasta@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20261127-dma-fence-signalling-v1-0-c44e8f4910ca@collabora.com>
 <20261127-dma-fence-signalling-v1-1-c44e8f4910ca@collabora.com>
In-Reply-To: <20261127-dma-fence-signalling-v1-1-c44e8f4910ca@collabora.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 27, 2026 at 7:30 PM CET, Daniel Almeida wrote:
> dma_fence_begin_signalling() and dma_fence_end_signalling() mark the
> code that the completion of a dma-fence depends on, so that lockdep can
> check it against the dma-fence rules. However, up until now, it was not
> possible to use the signalling tokens from Rust.
>
> Thus, add SignallingSection, a guard that begins a section when it is
> created and ends it when it is dropped. Code on the signalling path can
> take a &SignallingSection to require that its caller opened one.
>
> Use it in the DriverFence example, which has a TODO for it.
>
> A later patch in this series makes DriverFence::signal() require one.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/dma_buf/dma_fence.rs | 70 ++++++++++++++++++++++++++++++++++=
+++++-
>  rust/kernel/dma_buf/mod.rs       |  3 +-
>  2 files changed, 71 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index a1d851656562..7ee87935d3be 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -17,6 +17,7 @@
>      error::to_result,
>      prelude::*,
>      types::ForeignOwnable,
> +    types::NotThreadSafe,
>      types::Opaque, //
>  };
> =20
> @@ -589,6 +590,71 @@ unsafe fn dec_ref(ptr: NonNull<Self>) {
>      }
>  }
> =20
> +/// A dma-fence signalling critical section on the current task.
> +///
> +/// All code needed to signal a [`DriverFence`] must run in such a secti=
on,

Hm...this makes an annotation policy sound like an unconditional prerequisi=
te
for signalling any DriverFence.

It is clarified below with "Without `CONFIG_LOCKDEP`, the section has no
effect.", but I'd probably first explain the annotation mechanism and then
explain what drivers are expected to do.

> +/// from the point where its [`Fence`] becomes visible to other threads =
up to
> +/// the point where it is signalled. With `CONFIG_PROVE_LOCKING`, the se=
ction

I'd add a bit more detail on what cases we need to protect once the fence
becomes visible to other threads or is published.

Especially the more subtle parts, such as indirect dependencies on memory
reclaim.

> +/// is a [DMA Fence Signalling Annotation], which validates that code ag=
ainst
> +/// the [DMA Fence Cross-Driver Contract]. Without `CONFIG_LOCKDEP`, the
> +/// section has no effect.
> +///
> +/// A function that is part of the signalling path can take a
> +/// `&SignallingSection` to require that its caller opened one. Sections=
 nest,
> +/// and only the outermost one is annotated.
> +///
> +/// [DMA Fence Signalling Annotation]: https://docs.kernel.org/driver-ap=
i/dma-buf.html#dma-fence-signalling-annotations
> +/// [DMA Fence Cross-Driver Contract]: https://docs.kernel.org/driver-ap=
i/dma-buf.html#dma-fence-cross-driver-contract
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::dma_buf::SignallingSection;
> +///
> +/// // Code on the signalling path takes a section to require that its c=
aller
> +/// // opened one.
> +/// fn on_signalling_path(_section: &SignallingSection) {}
> +///
> +/// let section =3D SignallingSection::begin();
> +/// on_signalling_path(&section);
> +/// ```

Hm...I'm not sure the example is overly useful. What about an example that =
shows
how it catches a violation? I'm usually not a fan of this, but in this case=
 it
kinda makes sense.

> @@ -704,9 +771,10 @@ struct DriverFenceData<'a, T: Send + Sync + FenceCon=
textOps> {
>  /// let cb_reg =3D unsafe { FenceCallbackRegistration::new(&waiting_fenc=
e, cb_data) };
>  /// let cb_reg =3D KBox::pin_init(cb_reg, GFP_KERNEL)?;
>  ///
> -/// // TODO signalling guards
> +/// let section =3D SignallingSection::begin();
>  /// assert_eq!(waiting_fence.is_signaled(), false);
>  /// fence.signal(Ok(()));
> +/// drop(section);
>  /// assert_eq!(waiting_fence.is_signaled(), true);

I think that's a separate patch, or actually the subsequent patch is a natu=
ral
fit.
