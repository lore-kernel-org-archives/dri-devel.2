Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E544AF532C0
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 00:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1673210E572;
	Tue, 24 Mar 2026 00:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="ZPxBVz5c";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5974810E505
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 00:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774311504; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=juzoigt6ZbNKZBrhZYn0Uh9ftZYMxqq3UrbGB21ihYwBv7jWH0N7fRRUC04LCJApgdQOsChwLmJs2l7TNTd5m+giZ5huqf5hFO+Yq01MIYAlZPmpZn9Cn0oE5s3P9QeV+A0g5BmdVv/srO9swv7h+LtWKQCTir7HcYmwdKcBY+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774311504;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zhvlqhn4H64Wd5w1UfNAbWXDFDm4LAr2CnJKPhc8N9o=; 
 b=QuzCbHgIe3VzWzXsbzGcNVVyr2ygltPL2m+Y42dDRsCGvF/OreVz/93JDRi9hPhOt4xaLG//e2Kds+bSoVp4t6X6lePbg03DeP9/Sp/CPpccGxNRyJESvJ6dKr8VU9O2T6yEsYoGnmQ1eFvigKO+lOAmPTM9Eots91g/hqVsnPw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774311504; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=zhvlqhn4H64Wd5w1UfNAbWXDFDm4LAr2CnJKPhc8N9o=;
 b=ZPxBVz5cdoDyIlChrQKiGBad/8sld0BLDq7xCi07w6lADKVdH6JNIVpqlgaWRADd
 Y4wwcMLC0ATT+nLyJu89b4D1045CaYr7KKCLcBNtbZJ7Md8pzMzxrpZjXoGzCPt3FKU
 vPye698tYFd4bUHNWDtqO6h/CcyIoY2c5qL+Tybc=
Received: by mx.zohomail.com with SMTPS id 1774311504037658.3237178400765;
 Mon, 23 Mar 2026 17:18:24 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 23 Mar 2026 17:18:13 -0700
Subject: [PATCH v3 11/12] drm/tyr: Add fields for TRANSCFG register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-tyr-use-register-macro-v3-v3-11-a87daf9e4701@collabora.com>
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
In-Reply-To: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
To: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Boqun Feng <boqun@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9990;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=xYDSrMKGih7bnmrV5O3TtmJ7JBYKvJXUnW0nImcxWlk=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJkHbzj4SZ5IDrHevbpTnsXn9fMF5kc+nl28ak7sKa/bZ
 Xtbg1sOdZSyMIhxMciKKbKctTfqEa96b6Q7/38zzBxWJpAhDFycAjCRjnCG/w4+iw3frHpxoMtm
 uemiSad/Rez8v6K34PLkghs//s3ZeMSFkeF2ZNU15o9NBrfdky+aP2UtOHDfV+lS2X7+Xn9GNq3
 C98wA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

The translation configuration register for address spaces includes
fields that are limited in their possible values such as address
space modes, input and output restrictions, translation table
memory attributes.

Add these fields to the TRANSCFG register and enumerate their
possible values using the register! macro to ensure that only defined
values are used in this register.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/regs.rs | 225 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 224 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 3d96d3264952616112e77939dfa2c753039dea35..7e895b6e7deccc049a0ee3963d511c4b579e5ec7 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -1240,9 +1240,232 @@ fn from(access: MmuAccessType) -> Self {
                 /// Internal address space command is active, a 1-bit boolean flag.
                 1:1     active_int => bool;
             }
+        }
+
+        /// Helpers for TRANSCFG register.
+        ///
+        /// Address space mode for TRANSCFG register.
+        #[derive(Copy, Clone, Debug)]
+        #[repr(u8)]
+        pub(crate) enum AddressSpaceMode {
+            /// The MMU forces all memory access to fail with a decode fault.
+            Unmapped = 1,
+            /// All input addresses map to the same output address (deprecated).
+            Identity = 2,
+            /// Translation tables interpreted according to AArch64 4kB granule specification.
+            Aarch64_4K = 6,
+            /// Translation tables interpreted according to AArch64 64kB granule specification.
+            Aarch64_64K = 8,
+        }
+
+        impl TryFrom<Bounded<u64, 4>> for AddressSpaceMode {
+            type Error = Error;
+
+            fn try_from(val: Bounded<u64, 4>) -> Result<Self, Self::Error> {
+                match val.get() {
+                    1 => Ok(AddressSpaceMode::Unmapped),
+                    2 => Ok(AddressSpaceMode::Identity),
+                    6 => Ok(AddressSpaceMode::Aarch64_4K),
+                    8 => Ok(AddressSpaceMode::Aarch64_64K),
+                    _ => Err(EINVAL),
+                }
+            }
+        }
+
+        impl From<AddressSpaceMode> for Bounded<u64, 4> {
+            fn from(mode: AddressSpaceMode) -> Self {
+                Bounded::try_new(mode as u64).unwrap()
+            }
+        }
+
+        /// Input address range restriction for TRANSCFG register.
+        #[derive(Copy, Clone, Debug)]
+        #[repr(u8)]
+        pub(crate) enum InaBits {
+            /// Invalid VA range (reset value).
+            Reset = 0,
+            /// 48-bit VA range.
+            Bits48 = 7,
+            /// 47-bit VA range.
+            Bits47 = 8,
+            /// 46-bit VA range.
+            Bits46 = 9,
+            /// 45-bit VA range.
+            Bits45 = 10,
+            /// 44-bit VA range.
+            Bits44 = 11,
+            /// 43-bit VA range.
+            Bits43 = 12,
+            /// 42-bit VA range.
+            Bits42 = 13,
+            /// 41-bit VA range.
+            Bits41 = 14,
+            /// 40-bit VA range.
+            Bits40 = 15,
+            /// 39-bit VA range.
+            Bits39 = 16,
+            /// 38-bit VA range.
+            Bits38 = 17,
+            /// 37-bit VA range.
+            Bits37 = 18,
+            /// 36-bit VA range.
+            Bits36 = 19,
+            /// 35-bit VA range.
+            Bits35 = 20,
+            /// 34-bit VA range.
+            Bits34 = 21,
+            /// 33-bit VA range.
+            Bits33 = 22,
+            /// 32-bit VA range.
+            Bits32 = 23,
+            /// 31-bit VA range.
+            Bits31 = 24,
+            /// 30-bit VA range.
+            Bits30 = 25,
+            /// 29-bit VA range.
+            Bits29 = 26,
+            /// 28-bit VA range.
+            Bits28 = 27,
+            /// 27-bit VA range.
+            Bits27 = 28,
+            /// 26-bit VA range.
+            Bits26 = 29,
+            /// 25-bit VA range.
+            Bits25 = 30,
+        }
+
+        impl TryFrom<Bounded<u64, 5>> for InaBits {
+            type Error = Error;
+
+            fn try_from(val: Bounded<u64, 5>) -> Result<Self, Self::Error> {
+                match val.get() {
+                    0 => Ok(InaBits::Reset),
+                    7 => Ok(InaBits::Bits48),
+                    8 => Ok(InaBits::Bits47),
+                    9 => Ok(InaBits::Bits46),
+                    10 => Ok(InaBits::Bits45),
+                    11 => Ok(InaBits::Bits44),
+                    12 => Ok(InaBits::Bits43),
+                    13 => Ok(InaBits::Bits42),
+                    14 => Ok(InaBits::Bits41),
+                    15 => Ok(InaBits::Bits40),
+                    16 => Ok(InaBits::Bits39),
+                    17 => Ok(InaBits::Bits38),
+                    18 => Ok(InaBits::Bits37),
+                    19 => Ok(InaBits::Bits36),
+                    20 => Ok(InaBits::Bits35),
+                    21 => Ok(InaBits::Bits34),
+                    22 => Ok(InaBits::Bits33),
+                    23 => Ok(InaBits::Bits32),
+                    24 => Ok(InaBits::Bits31),
+                    25 => Ok(InaBits::Bits30),
+                    26 => Ok(InaBits::Bits29),
+                    27 => Ok(InaBits::Bits28),
+                    28 => Ok(InaBits::Bits27),
+                    29 => Ok(InaBits::Bits26),
+                    30 => Ok(InaBits::Bits25),
+                    _ => Err(EINVAL),
+                }
+            }
+        }
+
+        impl From<InaBits> for Bounded<u64, 5> {
+            fn from(bits: InaBits) -> Self {
+                Bounded::try_new(bits as u64).unwrap()
+            }
+        }
+
+        /// Translation table memory attributes for TRANSCFG register.
+        #[derive(Copy, Clone, Debug)]
+        #[repr(u8)]
+        pub(crate) enum PtwMemattr {
+            /// Invalid (reset value, not valid for enabled address space).
+            Invalid = 0,
+            /// Normal memory, inner/outer non-cacheable.
+            NonCacheable = 1,
+            /// Normal memory, inner/outer write-back cacheable.
+            WriteBack = 2,
+        }
+
+        impl TryFrom<Bounded<u64, 2>> for PtwMemattr {
+            type Error = Error;
+
+            fn try_from(val: Bounded<u64, 2>) -> Result<Self, Self::Error> {
+                match val.get() {
+                    0 => Ok(PtwMemattr::Invalid),
+                    1 => Ok(PtwMemattr::NonCacheable),
+                    2 => Ok(PtwMemattr::WriteBack),
+                    _ => Err(EINVAL),
+                }
+            }
+        }
+
+        impl From<PtwMemattr> for Bounded<u64, 2> {
+            fn from(attr: PtwMemattr) -> Self {
+                Bounded::try_new(attr as u64).unwrap()
+            }
+        }
+
+        /// Translation table memory shareability for TRANSCFG register.
+        #[derive(Copy, Clone, Debug)]
+        #[repr(u8)]
+        #[allow(clippy::enum_variant_names)]
+        pub(crate) enum PtwShareability {
+            /// Non-shareable.
+            NonShareable = 0,
+            /// Outer shareable.
+            OuterShareable = 2,
+            /// Inner shareable.
+            InnerShareable = 3,
+        }
+
+        impl TryFrom<Bounded<u64, 2>> for PtwShareability {
+            type Error = Error;
+
+            fn try_from(val: Bounded<u64, 2>) -> Result<Self, Self::Error> {
+                match val.get() {
+                    0 => Ok(PtwShareability::NonShareable),
+                    2 => Ok(PtwShareability::OuterShareable),
+                    3 => Ok(PtwShareability::InnerShareable),
+                    _ => Err(EINVAL),
+                }
+            }
+        }
+
+        impl From<PtwShareability> for Bounded<u64, 2> {
+            fn from(sh: PtwShareability) -> Self {
+                Bounded::try_new(sh as u64).unwrap()
+            }
+        }
 
+        register! {
             /// Translation configuration and control.
-            pub(crate) TRANSCFG(u64)[MAX_AS, stride = STRIDE] @ 0x2430 {}
+            pub(crate) TRANSCFG(u64)[MAX_AS, stride = STRIDE] @ 0x2430 {
+                /// Address space mode.
+                3:0     mode ?=> AddressSpaceMode;
+                /// Address input restriction.
+                10:6    ina_bits ?=> InaBits;
+                /// Address output restriction.
+                18:14   outa_bits;
+                /// Translation table concatenation enable, a 1-bit boolean flag.
+                22:22   sl_concat_en => bool;
+                /// Translation table memory attributes.
+                25:24   ptw_memattr ?=> PtwMemattr;
+                /// Translation table memory shareability.
+                29:28   ptw_sh ?=> PtwShareability;
+                /// Inner read allocation hint for translation table walks, a 1-bit boolean flag.
+                30:30   r_allocate => bool;
+                /// Disable hierarchical access permissions.
+                33:33   disable_hier_ap => bool;
+                /// Disable access fault checking.
+                34:34   disable_af_fault => bool;
+                /// Disable execution on all writable pages.
+                35:35   wxn => bool;
+                /// Enable execution on readable pages.
+                36:36   xreadable => bool;
+                /// Page-based hardware attributes for translation table walks.
+                63:60   ptw_pbha;
+            }
 
             /// Extra fault information for each address space. Read only.
             pub(crate) FAULTEXTRA(u64)[MAX_AS, stride = STRIDE] @ 0x2438 {

-- 
2.52.0

