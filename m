Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8746C61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1780A10F0AD;
	Thu, 27 Aug 2026 14:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MYtxYWc/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C833210F0AD
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:35:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9448F41AFB;
 Thu, 27 Aug 2026 14:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C0C1F00A3A;
 Thu, 27 Aug 2026 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787841308;
 bh=EvdSgdwUCpeYNuudRxU/aiKwLOsgvCwPyfnHAQ0XN9c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MYtxYWc/ej1iOrKEBFEKoiTzLj5kmRJLa1Smdr9UVjIbRrtQw7GHD0T3TH992Gj0c
 ejEdhn2Ng23Ef2WMijJMDGyVJbU+lQQak+oOKQ5cLB75SrZoEEocaLrMXJ1QQWXk5T
 A5ZaWRxsugD5nZolP517l2PfAch2TG37MJaPx16pFgg6UaURjiDrsoHc1BBo75LXMR
 2lWXQP9RN3dyNCZeUxNafVHdFDoHOCiKGY4PpNjb+J/O3rJFVxNYHF8i3Q5Q3ph2LG
 kALAPHbo7AwXb7Ik9ucluXLBj7YmSFxdDkDeSbGeXgU/9JQm6pp1cfjPExwEYXVEay
 czwpA9xnmC+uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] gpu: nova-core: add NVKV encoder
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-4-0de9d5c8658c@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-4-0de9d5c8658c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:35:07 +0000
Message-Id: <20260827143508.33C0C1F00A3A@smtp.kernel.org>
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
- [High] The NVKV wire format encoder improperly depends on the host's nati=
ve endianness, generating a different sequence of 64-bit values on big-endi=
an versus little-endian architectures. This corrupts the GPU command stream=
 on big-endian systems.
- [Low] Missing `#[inline(always)]` on the `From<Opcode>` implementation th=
at delegates to an assertion requiring constant evaluation.
--

commit dbc5c487fe7e32cc1bab7a9eae25bab7cbbe966a
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: add NVKV encoder

This commit introduces an NVKV encoder for GMCAPI wire formats, converting
sequences of key-value operations into a stream of 64-bit words. The driver
encodes primitives like 32-bit/64-bit values and arrays using specific opco=
des.
Tests are included to verify the binary layout of the encoded output.

> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gs=
p/nvkv.rs
> new file mode 100644
> index 0000000000000..a8e16687a134b
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
[ ... ]
> +    fn extend_with_padding<T: IntoBytes + Immutable + ?Sized>(&mut self,=
 data: &T) -> Result {
> +        let bytes =3D data.as_bytes();
> +        let padded =3D bytes.len().next_multiple_of(size_of::<u64>());
> +        // Reserve so that a failed allocation can't leave the invariant=
 violated.
> +        self.0.reserve(padded, GFP_KERNEL)?;
> +        self.0.extend_from_slice(bytes, GFP_KERNEL)?;

[Severity: High]
Does copying the memory representation directly using data.as_bytes() rely
on the host's native endianness? On big-endian architectures, this
host-endian byte slice will mix incorrectly when grouped into 64-bit words,
corrupting the NVKV stream for the GPU hardware which expects a fixed
little-endian layout.

> +        // INVARIANT: The padding ensures the total length remains a mul=
tiple of
> +        // size_of::<u64>().
> +        Ok(self.0.extend_with(padded - bytes.len(), 0u8, GFP_KERNEL)?)
> +    }
> +}
[ ... ]
> +impl Deref for EncodedStream {
> +    type Target =3D [u64];
> +
> +    fn deref(&self) -> &Self::Target {
> +        // An empty Vec's pointer isn't necessarily aligned by StreamAll=
ocator::MIN_ALIGN.
> +        if self.0.is_empty() {
> +            return &[];
> +        }
> +
> +        // PANIC: By the type invariants the byte length is a multiple o=
f size_of::<u64>(), and
> +        // the backing buffer of a non-empty vector has at least u64 ali=
gnment per
> +        // StreamAllocator's minimum alignment.
> +        <[u64]>::ref_from_bytes(&self.0).expect("EncodedStream invariant=
 violated")

[Severity: High]
Can casting the host-endian byte stream directly to a slice of native-endian
u64s cause data corruption? Since the hardware expects a little-endian
layout, interpreting these bytes via ref_from_bytes on big-endian hosts will
result in functionally incorrect GPU commands.

> +    }
> +}
[ ... ]
> +impl From<Opcode> for Bounded<u64, 4> {
> +    fn from(value: Opcode) -> Self {
> +        Bounded::from_expr(value as u64)
> +    }
> +}

[Severity: Low]
Is it possible this function will fail compilation if not heuristically
inlined by the compiler? Since it delegates to Bounded::from_expr() which
uses build_assert!() on its parameter, subsystem guidelines require an
explicit #[inline(always)] annotation to ensure the optimizer can perform
constant folding and evaluate the assertion at compile time.

> diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-=
core/gsp/nvkv/encode.rs
> new file mode 100644
> index 0000000000000..6c1a9cbd90e84
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
Will this test fail on big-endian hosts? The test explicitly asserts a
little-endian memory layout for the Array32 values (placing the first 32-bit
element in the lower 32 bits of the u64). On big-endian systems, the values
will be in the upper 32 bits, causing the test to fail and confirming that
the generated payloads will be unreadable by the GPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-b4-nvkv-v2=
-0-0de9d5c8658c@nvidia.com?part=3D4
