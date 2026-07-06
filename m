Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8281BC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E89AD10E37C;
	Mon,  6 Jul 2026 13:09:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ag68XJGM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286D710E37C
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:09:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 907CD600C3;
 Mon,  6 Jul 2026 13:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2F11F00A3A;
 Mon,  6 Jul 2026 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783343382;
 bh=qhBXz5dJ8J33VxtVL+B77S+FOyeSsvTuCKfkzGt7t48=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ag68XJGMkV4VYqQbqc6QJpiPvzIQ31+NsuJEsS/vSYNAbqbfKokcgeuY70uFi+/aK
 SEbSYcNiVfnNjX3VQeQyC98zUNdQlMgkveVzRbFIRTQYoGU8haB23LJtvBz4x7EsdA
 8Cb+tcwCG4kPDlJGk8mNKfmptScnkYp8bpQTjL5oCypQnWcnVvc9lKboc/oyzWk0cb
 1EkIVDcqbHeqgzxp3Ne4GL3wcn53ueCz5q1WR2k31I+URlPbprVV50ojCHoY4OxFBL
 evAkPanS83aNsBTTQADCjru5zOQVs1gihhm4/krbr+NGcpmZlwgnmB7CdA3Wy0QiOV
 DXyf5eGr4aklA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 19/20] rust: io: add copying methods
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260706-io_projection-v6-19-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-19-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:09:41 +0000
Message-Id: <20260706130941.EA2F11F00A3A@smtp.kernel.org>
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
- [High] Exposing `copy_read` and `copy_write` for arbitrary generic types =
(`T: FromBytes`/`IntoBytes`) on `MmioBackend` maps to stream accessors (`me=
mcpy_{from,to}io`), which bypasses CPU-to-device byte-swapping. This confla=
tes stream and register I/O semantics, creating a severe footgun for MMIO r=
egister structs on big-endian architectures.

Pre-existing issues:
- [High] The use of `fence(Ordering::SeqCst)` emits a CPU-domain memory bar=
rier, which is insufficient for synchronizing memory between the CPU and th=
e device (GSP) when updating command queues.
--

commit b39304c44ce9723636b250bacb9f2e99203d514d
Author: Gary Guo <gary@garyguo.net>

rust: io: add copying methods

This commit introduces copy_read and copy_write methods to the Io trait
to allow reading and writing structures and slices. It implements the
IoCopyable trait for I/O backends, mapping the MMIO operations to
memcpy_fromio and memcpy_toio.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index c423125870b75..9df4e982c5d8a 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> @@ -442,6 +524,121 @@ fn write_val(self, value: Self::Target)
>          Self::Backend::io_write(self.as_view(), value)
>      }
> =20
> +    /// Copy-read from I/O memory.
> +    ///
> +    /// This is equivalent to reading from the I/O memory with byte-wise=
 copy, although the actual
> +    /// implementation might be more efficient. There is no atomicity gu=
arantee. Note that for some
> +    /// backends (e.g. `Mmio`), this can read different value compared t=
o [`read_val`] as
> +    /// byte-swapping is not performed.
> +    ///
> +    /// [`read_val`]: Io::read_val
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// # use kernel::io::*;
> +    /// # fn test_copy_read(mmio: Mmio<'_, [u8; 6]>) {
> +    /// // let mmio: Mmio<'_, [u8; 6]>;
> +    /// let val: [u8; 6] =3D mmio.copy_read();
> +    /// # }
> +    /// ```
> +    #[inline]
> +    fn copy_read(self) -> Self::Target
> +    where
> +        Self::Backend: IoCopyable,
> +        Self::Target: Sized + FromBytes,
> +    {
> +        Self::Backend::copy_read(self.as_view())
> +    }

[Severity: High]
Does exposing this generic copy_read() for any FromBytes target conflate=20
stream and register I/O semantics?

When used with a struct representing MMIO control registers, this method
eventually maps to stream accessors like memcpy_fromio() in MmioBackend,
which bypasses CPU-to-device byte-swapping.

Could this lead to data corruption on big-endian systems, where drivers mig=
ht
expect the byteswapped register layout but receive unswapped data instead?
Would it be safer to restrict bulk stream copying strictly to [u8] targets
via copy_from_slice and copy_to_slice?

[ ... ]

While reviewing these I/O accessor changes, I also noticed an issue in
the GPU driver code introduced earlier in the series.

drivers/gpu/nova-core/gsp/cmdq.rs:advance_cpu_read_ptr() {
    ...
    // Ensure read pointer is properly ordered.
    fence(Ordering::SeqCst);
    ...
}

drivers/gpu/nova-core/gsp/cmdq.rs:advance_cpu_write_ptr() {
    ...
    // Ensure all command data is visible before triggering the GSP read.
    fence(Ordering::SeqCst);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but is this CPU-domain memory
barrier sufficient for synchronizing memory between the CPU and the device
when updating command queues?

Rust's atomic fences map to CPU-domain memory barriers (e.g., dmb ish on
ARM64), which only guarantee ordering within the inner-shareable domain
between CPUs.

To properly order memory accesses visible to a device in the outer-shareable
domain, a device DMA barrier like dma_wmb() or dma_rmb() is strictly
required.

Can using a CPU fence here lead to data corruption or lost commands on weak=
ly
ordered architectures, since the GSP could read stale command payloads befo=
re
the CPU writes are visible?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D19
