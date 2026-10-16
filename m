Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51502CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 02:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A864A10E20D;
	Fri, 16 Oct 2026 02:01:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0731210E20D
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:00:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E3ACA43236;
 Fri, 16 Oct 2026 02:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E82D1F000C4;
 Fri, 16 Oct 2026 02:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792116057;
 bh=WrAhFT75iG01wckpU+08pAhzVcHyqZ2mMr1iWIBV2nM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bJ3JxsGCR8wlp8P28aClHN17WfiqKrewncfp6r4C830qq5XAi1+4yA0XQZoYGiBQl
 v/kpX2P/hFo/mWPgDe3J6f7llg3h8N3AUHa9avdlbce9ttqViCUPyi8exm0deuNTA0
 jnr1zr4poDhZYb28JzKiJppKCDVtdDpZ/igmTPLYDwuVVHb2oZFUqm3/znmqWaC74W
 ZG0SE6lBefijQ2c7oZ9TVB+yzWBd4NcuazGGyG3+aD1LdW5M6s4H76UKk7AusnzutC
 LlcFGi0dnX3JofjqftLCNrvPFh/TDnHrizVgZTOIzcTP00pT3Uo1D6RenD/EaZN9yh
 LDeJGnWu6uToA==
Message-ID: <sashiko-outbox-173606@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] gpu: nova-core: add NVKV decoder
To: "Eliot Courtney" <ecourtney@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, 
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261016-b4-nvkv-v4-4-e8b92b91aa5b@nvidia.com>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
 <20261016-b4-nvkv-v4-4-e8b92b91aa5b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 02:00:56 +0000
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
- [High] gpu: nova-core: endianness bug when extracting u8/u32 arrays from =
native &[u64] stream
--

commit 60056513188e14b734dcdb09e45f7f46bb4688b6
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: add NVKV decoder

This commit adds an NVKV decoder for parsing messages from GSP for GMCAPI
calls. It reads an encoded stream of (key, index, value) tuples and invokes
a Schema/Visit trait interface to consume the values.

> diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-=
core/gsp/nvkv/decode.rs
> new file mode 100644
> index 0000000000000..6496fab1c0c62
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
[ ... ]
> +    /// Takes `count` bytes. If `count` is not a multiple of 8 (`u64` si=
ze), bytes are discarded up
> +    /// to the next multiple.
> +    fn take_u8s(&mut self, count: usize) -> Result<&'a [u8]> {
> +        let values =3D self.take_u64s(count.div_ceil(size_of::<u64>()))?;
> +        values.as_bytes().get(..count).ok_or(EINVAL)
> +    }

[Severity: High]
Does casting a native u64 slice to bytes extract the wrong payload on
big-endian architectures?

Because Cursor::take_u64s() reads host-native 64-bit integers, using
.as_bytes() reverses the byte layout on big-endian hosts compared to
little-endian.

For example, if a 3-byte payload is stored inside a 64-bit word, a big-endi=
an
host will have the payload at the end of the word and zero-padding at the
beginning, causing .get(..count) to extract the zeros instead of the actual
data payload.

> +
> +    /// Takes `count` 32-bit values. If `count` is not a multiple of 2 (=
`u32` values per `u64`),
> +    /// bytes are discarded up to the next multiple.
> +    fn take_u32s(&mut self, count: usize) -> Result<&'a [u32]> {
> +        let values =3D self.take_u64s(count.div_ceil(size_of::<u64>() / =
size_of::<u32>()))?;
> +        <[u32]>::ref_from_prefix_with_elems(values.as_bytes(), count)
> +            .map(|(elems, _)| elems)
> +            .map_err(|_| EINVAL)
> +    }

[Severity: High]
Can this result in swapped 32-bit words on big-endian systems?

Similar to the byte array extraction above, passing the native memory
representation through .as_bytes() to recreate a [u32] slice will swap
the order of the 32-bit halves on big-endian architectures compared to
little-endian ones.

[ ... ]
> +    /// Decodes every pair into `schema` and returns the result of [`Sch=
ema::finish`].
> +    pub(crate) fn decode<'s, S: Schema + Visit<'a>>(
> +        &self,
> +        schema: &'s mut S,
> +    ) -> Result<impl Init<S::Target, Error> + 's> {
> +        let mut cursor =3D Cursor::new(self.data);
> +        while !cursor.is_empty() {
> +            let op: Op =3D cursor.take_u64()?.into();

[Severity: High]
Does this misalign the operation bitfields on big-endian hosts?

The 64-bit operation word is read as a host-native integer via take_u64().
If the NVKV stream comes from a little-endian GSP, parsing it directly as a
native u64 on a big-endian host will misalign the key, index, and value
fields inside Op.

Should this explicitly handle endianness (e.g., using little-endian read
functions) instead of relying on native host integers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-b4-nvkv-v4=
-0-e8b92b91aa5b@nvidia.com?part=3D4
