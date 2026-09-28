Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8F9CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3895110E827;
	Mon, 28 Sep 2026 08:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H8gfGoPR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E088C10E2E0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:52:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C9FB0407A4;
 Mon, 28 Sep 2026 08:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6040E1F000FF;
 Mon, 28 Sep 2026 08:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790585563;
 bh=pGwORhcQBfPF8jMMQ+iSpCmtAL7wkjGnlVtfczHvKfc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H8gfGoPRqpQ8PhgimxOpDq0tKNQFFvavXpW7K5VocKy3FM5Qe0YlNKcUE+80jd5Xv
 lUiA+FSVGOIz2pUDhfqwvZVnZj0iYLrb9HVUuUwh+sfAekuDa4KpgtqazBWVEQ77S1
 i/qQ05UenSpyn8+hAksqa5r6QVzow2SsjvZXDwzts1WF/wECQo3GZCYFiaKd84SxS4
 sROa2/2PyFL3pUhT5dKyWw+mUua8yPzdujpyCneY1g1RQsoUHvYg3OSBQYfrgYwJPx
 pGrVey8jnnPzAzWC3P1Tol2xlVjH4v6pfaAA+ZJdSnSe4wobW6F/I3ZsR6d3m+xz+i
 ayI/BrfCcZIyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] gpu: nova-core: add NVKV encoder
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 "Alexandre
 Courbot" <acourbot@nvidia.com>, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20260928-b4-nvkv-v3-4-f04504c262c2@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-4-f04504c262c2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:52:42 +0000
Message-Id: <20260928085243.6040E1F000FF@smtp.kernel.org>
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
- [High] gpu: nova-core: NVKV encoder generates host-endian command streams=
 instead of little-endian
--

commit cc2f9c62ac197576039ac68784d3a562225a92be
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: add NVKV encoder

Add an encoder for NVKV, which is the wire format for GMCAPI. The
encoded stream is a sequence of 64-bit values.

> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gs=
p/nvkv.rs
> new file mode 100644
> index 0000000000000..0957dce92f962
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
[ ... ]
> +impl EncodedStream {
> +    /// Creates an empty stream.
> +    fn new() -> Self {
> +        // INVARIANT: An empty stream's byte length is 0, a multiple of =
`size_of::<u64>()`.
> +        Self(Vec::new())
> +    }
> +
> +    /// Appends a single `u64` to the stream.
> +    fn push_u64(&mut self, value: u64) -> Result {
> +        // INVARIANT: Appending `size_of::<u64>()` bytes keeps the byte =
length a multiple of
> +        // `size_of::<u64>()`.
> +        Ok(self.0.extend_from_slice(&value.to_ne_bytes(), GFP_KERNEL)?)

[Severity: High]
Is it intentional to serialize u64 values, such as operation words and scal=
ar
payloads, using native endianness instead of little-endian?

The GPU firmware interface expects a little-endian wire format. On big-endi=
an
architectures, this will generate corrupted, misordered commands and cause
initialization to fail. Should this use to_le_bytes() instead?

> +    }
> +
> +    /// Appends `data` as bytes to the stream, zero-padded to a `u64` bo=
undary.
> +    fn extend_with_padding<T: IntoBytes + Immutable + ?Sized>(&mut self,=
 data: &T) -> Result {
> +        let bytes =3D data.as_bytes();

[Severity: High]
Does this convert multi-byte arrays, such as [u32], to bytes using the nati=
ve
memory layout?

This outputs big-endian elements on big-endian hosts, which will also result
in corrupted command streams for the GPU firmware.

> +        let padded =3D bytes.len().next_multiple_of(size_of::<u64>());
> +        // Reserve so that a failed allocation can't leave the invariant=
 violated.
> +        self.0.reserve(padded, GFP_KERNEL)?;
> +        self.0.extend_from_slice(bytes, GFP_KERNEL)?;
> +        // INVARIANT: The padding ensures the total length remains a mul=
tiple of
> +        // `size_of::<u64>()`.
> +        Ok(self.0.extend_with(padded - bytes.len(), 0u8, GFP_KERNEL)?)
> +    }
> +}
[ ... ]
> diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-=
core/gsp/nvkv/encode.rs
> new file mode 100644
> index 0000000000000..8b66ddb151892
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
[ ... ]
> +        // The ARRAY32 op word has the element count. The two elements f=
ollow in little endian.
> +        assert_eq!(
> +            encoded[5],
> +            Op::zeroed()
> +                .with_key(ARRAY32_KEY)
> +                .with_index(Index::new::<3>())
> +                .with_opcode(Opcode::Array32)
> +                .with_value(2u32)
> +                .into_raw()
> +        );
> +        assert_eq!(
> +            encoded[6],
> +            u64::from(ARRAY32_VALUE[1]) << 32 | u64::from(ARRAY32_VALUE[=
0])
> +        );

[Severity: High]
Will this test fail deterministically on big-endian hosts?

The test strictly expects little-endian element packing, which confirms the
wire format requirement, but the data is encoded using native endianness in
extend_with_padding() above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-b4-nvkv-v3=
-0-f04504c262c2@nvidia.com?part=3D4
