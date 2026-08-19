Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FF2C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E3910E162;
	Wed, 19 Aug 2026 16:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PiVjJnit";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CEDD10E162
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:32:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A8B161133;
 Wed, 19 Aug 2026 16:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657071F00A3A;
 Wed, 19 Aug 2026 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787157167;
 bh=06b5Z3LkJLMqHIiwOWKcjdPL9grUVe/yZBFhJxRVI5g=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=PiVjJnitJkvcur9AK8GPKU+AyUjUJ92tH/KxdoISESsl/GowiMShm6nwex1keVLsZ
 FvzGCwLWr2A7kexyRrlVdBWV/DLHkvP1uvsgcvm+6CuqFe0wTY4M1p1Uci8U6oYJZG
 RyVbTK85wwrr15O9woleCGgfVW5l6YDPD9kivJr6p9NDnqQBjQ9blFSL6mLlAOhDG9
 C59ota9jFS0XPfDDORw0i7fDlnTLKdOeSQx5/cjHSlVFs9SBeBnEL7AjGIwhOtFDEZ
 K+HK+batNiWxmDntZERyOazTctjzFCfxgILgQLZyVcfXG5DC2GivwYd4DXG5nXGIWy
 U3Xv4h3l3x+Aw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 18:32:40 +0200
Message-Id: <DKT2C9FT6IBW.3L5PJN1J8IVLD@kernel.org>
Subject: Re: [PATCH 2/6] gpu: nova-core: add NVKV encoder
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-2-b84db5e84b67@nvidia.com>
In-Reply-To: <20260817-b4-nvkv-v1-2-b84db5e84b67@nvidia.com>
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

On Mon Aug 17, 2026 at 2:56 PM CEST, Eliot Courtney wrote:
> +    fn push_bytes_with_padding(&mut self, bytes: &[u8]) -> Result {
> +        let num_entries =3D bytes.len().div_ceil(size_of::<u64>());
> +        self.backing.reserve(num_entries, GFP_KERNEL)?;
> +
> +        let spare =3D self.backing.spare_capacity_mut();
> +        let dst =3D spare.as_mut_ptr().cast::<u8>();
> +
> +        // SAFETY: At least `bytes.len()` bytes of space are guaranteed =
since `num_entries`
> +        // worth of space was just reserved.
> +        unsafe { core::ptr::copy_nonoverlapping(bytes.as_ptr(), dst, byt=
es.len()) };
> +
> +        let padding =3D num_entries * size_of::<u64>() - bytes.len();
> +        if padding > 0 {
> +            // SAFETY: At least `num_entries * size_of::<u64>()` bytes o=
f space are guaranteed.
> +            unsafe { core::ptr::write_bytes(dst.add(bytes.len()), 0, pad=
ding) };
> +        }
> +
> +        // SAFETY: These bytes were just initialized and every bit patte=
rn is valid for `u64`.
> +        unsafe { self.backing.inc_len(num_entries) };
> +
> +        Ok(())
> +    }

Ick! That's a lot of unsafe code. I think we can avoid this by using KVVec<=
u8>
instead of KVVec<u64>, ideally in a new type that upholds the padding invar=
iant.

Here's a diff of what I came up with; note that it also gets us rid of the
unsafe in take_u32s() in the decoder by using zerocopy.

(Technically it would also be possible to make Cursor operate on a byte str=
eam
and let zerocopy to the rest, as all the take methods are fallible already.=
 But
I think the invariant on EncodedStream makes sense.)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/=
nvkv.rs
index 0afd6d5c48bd..564a9a93f7cd 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -27,6 +27,43 @@
 mod decode;
 pub(crate) use decode::*;

+/// An encoded NVKV byte stream.
+///
+/// # Invariants
+///
+/// The byte length is always a multiple of `size_of::<u64>()`.
+pub(crate) struct EncodedStream(KVVec<u8>);
+
+impl EncodedStream {
+    /// Creates an empty stream.
+    fn new() -> Self {
+        Self(KVVec::new())
+    }
+
+    /// Appends a single `u64` to the stream.
+    fn push_u64(&mut self, value: u64) -> Result {
+        Ok(self.0.extend_from_slice(&value.to_ne_bytes(), GFP_KERNEL)?)
+    }
+
+    /// Appends `bytes` to the stream, zero-padded to a `u64` boundary.
+    fn extend_with_padding(&mut self, bytes: &[u8]) -> Result {
+        self.0.extend_from_slice(bytes, GFP_KERNEL)?;
+        let padding =3D bytes.len().next_multiple_of(size_of::<u64>()) - b=
ytes.len();
+        // INVARIANT: The padding ensures the total length remains a multi=
ple of `size_of::<u64>()`.
+        Ok(self.0.extend_with(padding, 0u8, GFP_KERNEL)?)
+    }
+}
+
+impl Deref for EncodedStream {
+    type Target =3D [u64];
+
+    fn deref(&self) -> &[u64] {
+        let count =3D self.0.len() / size_of::<u64>();
+        <[u64]>::ref_from_bytes_with_elems(&self.0, count)
+            .expect("EncodedStream invariant violated: not u64-aligned")
+    }
+}
+
 /// The identifier of an NVKV key.
 pub(crate) type KeyId =3D u16;

diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-co=
re/gsp/nvkv/decode.rs
index 9112dcf1aaca..d1271917c62e 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -381,9 +381,9 @@ fn take_u8s(&mut self, count: usize) -> Result<&[u8]> {

     fn take_u32s(&mut self, count: usize) -> Result<&[u32]> {
         let values =3D self.take_u64s(count.div_ceil(2))?;
-        // SAFETY: `values` is 8 byte aligned and only 4 byte alignment is=
 required. All bit
-        // patterns are valid for `u32`.
-        Ok(unsafe { core::slice::from_raw_parts(values.as_ptr().cast::<u32=
>(), count) })
+        let bytes =3D values.as_bytes();
+        <[u32]>::ref_from_bytes_with_elems(&bytes[..count * size_of::<u32>=
()], count)
+            .map_err(|_| EINVAL)
     }

     fn take_u64s(&mut self, count: usize) -> Result<&[u64]> {
@@ -401,8 +401,11 @@ pub(crate) struct Decoder<'a> {

 impl<'a> Decoder<'a> {
     /// Creates a decoder for `data` that handles unknown keys per `policy=
`.
-    pub(crate) fn new(data: &'a [u64], policy: UnknownKeyPolicy) -> Self {
-        Self { data, policy }
+    pub(crate) fn new(data: &'a super::EncodedStream, policy: UnknownKeyPo=
licy) -> Self {
+        Self {
+            data: &**data,
+            policy,
+        }
     }

     fn visit<S: Schema>(
diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-co=
re/gsp/nvkv/encode.rs
index 31ea5788e772..88f2a03a593f 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/encode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -156,51 +156,26 @@ fn encode(&self, encoder: &mut Encoder) -> Result {

 /// An encoder for an NVKV stream.
 pub(crate) struct Encoder {
-    backing: KVVec<u64>,
+    stream: super::EncodedStream,
 }

 impl Encoder {
     /// Creates an empty encoder.
     pub(crate) fn new() -> Self {
         Self {
-            backing: KVVec::new(),
+            stream: super::EncodedStream::new(),
         }
     }

-    /// Appends `bytes` to the stream, padded to a multiple of 8 bytes.
-    fn push_bytes_with_padding(&mut self, bytes: &[u8]) -> Result {
-        let num_entries =3D bytes.len().div_ceil(size_of::<u64>());
-        self.backing.reserve(num_entries, GFP_KERNEL)?;
-
-        let spare =3D self.backing.spare_capacity_mut();
-        let dst =3D spare.as_mut_ptr().cast::<u8>();
-
-        // SAFETY: At least `bytes.len()` bytes of space are guaranteed si=
nce `num_entries`
-        // worth of space was just reserved.
-        unsafe { core::ptr::copy_nonoverlapping(bytes.as_ptr(), dst, bytes=
.len()) };
-
-        let padding =3D num_entries * size_of::<u64>() - bytes.len();
-        if padding > 0 {
-            // SAFETY: At least `num_entries * size_of::<u64>()` bytes of =
space are guaranteed.
-            unsafe { core::ptr::write_bytes(dst.add(bytes.len()), 0, paddi=
ng) };
-        }
-
-        // SAFETY: These bytes were just initialized and every bit pattern=
 is valid for `u64`.
-        unsafe { self.backing.inc_len(num_entries) };
-
-        Ok(())
-    }
-
     /// Returns the encoded data.
     #[must_use =3D "encoded data must be consumed"]
-    pub(crate) fn finish(self) -> KVVec<u64> {
-        self.backing
+    pub(crate) fn finish(self) -> super::EncodedStream {
+        self.stream
     }

     #[inline(always)]
     fn encode_op(&mut self, op: Op) -> Result {
-        self.backing.push(op.into_raw(), GFP_KERNEL)?;
-        Ok(())
+        self.stream.push_u64(op.into_raw())
     }

     /// Encodes a 32-bit value as an IMM32 pair, with the value in the op =
word.
@@ -213,8 +188,7 @@ pub(crate) fn encode_u32(&mut self, key: KeyId, index: =
Index, value: u32) -> Res
                 .with_index(index)
                 .with_opcode(Opcode::Imm32)
                 .with_value(value),
-        )?;
-        Ok(())
+        )
     }

     /// Encodes a 64-bit value as a single-element SEQ64 pair.
@@ -222,7 +196,6 @@ pub(crate) fn encode_u32(&mut self, key: KeyId, index: =
Index, value: u32) -> Res
     pub(crate) fn encode_u64(&mut self, key: KeyId, index: Index, value: u=
64) -> Result {
         // TODO: Consider automatically merging sequential keys.
         const KEY_COUNT: u32 =3D 1;
-        self.backing.reserve(2, GFP_KERNEL)?;
         self.encode_op(
             Op::zeroed()
                 .with_key(key)
@@ -230,16 +203,13 @@ pub(crate) fn encode_u64(&mut self, key: KeyId, index=
: Index, value: u64) -> Res
                 .with_opcode(Opcode::Seq64)
                 .with_value(KEY_COUNT),
         )?;
-        self.backing.push_within_capacity(value)?;
-        Ok(())
+        self.stream.push_u64(value)
     }

     /// Encodes a byte array as an ARRAY8 pair, zero-padded to a multiple =
of 8 bytes.
     #[inline(always)]
     pub(crate) fn encode_array8(&mut self, key: KeyId, index: Index, array=
: &[u8]) -> Result {
         let value_count =3D u32::try_from(array.len()).map_err(|_| EMSGSIZ=
E)?;
-        let num_entries =3D array.len().div_ceil(size_of::<u64>());
-        self.backing.reserve(num_entries + 1, GFP_KERNEL)?;
         self.encode_op(
             Op::zeroed()
                 .with_key(key)
@@ -247,16 +217,13 @@ pub(crate) fn encode_array8(&mut self, key: KeyId, in=
dex: Index, array: &[u8]) -
                 .with_opcode(Opcode::Array8)
                 .with_value(value_count),
         )?;
-        self.push_bytes_with_padding(array.as_bytes())?;
-        Ok(())
+        self.stream.extend_with_padding(array.as_bytes())
     }

     /// Encodes a 32-bit array as an ARRAY32 pair, zero-padded to a multip=
le of 8 bytes.
     #[inline(always)]
     pub(crate) fn encode_array32(&mut self, key: KeyId, index: Index, arra=
y: &[u32]) -> Result {
         let value_count =3D u32::try_from(array.len()).map_err(|_| EMSGSIZ=
E)?;
-        let num_entries =3D array.len().div_ceil(2);
-        self.backing.reserve(num_entries + 1, GFP_KERNEL)?;
         self.encode_op(
             Op::zeroed()
                 .with_key(key)
@@ -264,15 +231,13 @@ pub(crate) fn encode_array32(&mut self, key: KeyId, i=
ndex: Index, array: &[u32])
                 .with_opcode(Opcode::Array32)
                 .with_value(value_count),
         )?;
-        self.push_bytes_with_padding(array.as_bytes())?;
-        Ok(())
+        self.stream.extend_with_padding(array.as_bytes())
     }

     /// Encodes a 64-bit array as an ARRAY64 pair.
     #[inline(always)]
     pub(crate) fn encode_array64(&mut self, key: KeyId, index: Index, arra=
y: &[u64]) -> Result {
         let value_count =3D u32::try_from(array.len()).map_err(|_| EMSGSIZ=
E)?;
-        self.backing.reserve(array.len() + 1, GFP_KERNEL)?;
         self.encode_op(
             Op::zeroed()
                 .with_key(key)
@@ -280,8 +245,7 @@ pub(crate) fn encode_array64(&mut self, key: KeyId, ind=
ex: Index, array: &[u64])
                 .with_opcode(Opcode::Array64)
                 .with_value(value_count),
         )?;
-        self.push_bytes_with_padding(array.as_bytes())?;
-        Ok(())
+        self.stream.extend_with_padding(array.as_bytes())
     }
 }

@@ -292,8 +256,6 @@ mod tests {
     // Tests that each kind of value is encoded to NVKV wire format proper=
ly.
     #[test]
     fn encode_all_value_kinds() -> Result {
-        // All keys, indexes, and values are distinct but arbitrary values=
 to make it easier for the
-        // test to catch bugs in the encoded output.
         const U32_KEY: KeyId =3D 0x1001;
         const U64_KEY: KeyId =3D 0x1002;
         const ARRAY8_KEY: KeyId =3D 0x1003;
