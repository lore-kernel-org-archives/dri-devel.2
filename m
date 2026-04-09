Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BEFF364A3
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A7010E850;
	Thu,  9 Apr 2026 17:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="BKaNoapm";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72EF110E849
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775757127; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UDsSfJut/O3d9x6phGBiWByZtnIfQpdsMi2drddL1Yn09KyURS79CBMehy0+TmdT9UFxA3m6YtkuHU9jAwlpZlw/qMH6GyULzogjbFzuaSPZzhgsSAtBBRm1dGEtsRSKL8MobG6Q1D1d2wRifL5qBjLRxKUH8FpmDhE1OCB87SI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775757127;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=onekeV2Q+coUt0mQt3VVAyazPEpmDONB2myv3b9GglI=; 
 b=Uq9MciG/l6974JUX3HZzYEB4rwgEmYY8ppnhNq52itC5/Y9KAs3N12dQyls/RnGVRtbjZgHC7ANeTvgOn4YTLFeC0SeKxfeoe+gpmrJWb6mPB59g6bo6BtayT3NFdKuDkSMXAkLjN+clrG4T6xP3vJJG7IKJhXjpJJWhhT1bZlU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775757127; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=onekeV2Q+coUt0mQt3VVAyazPEpmDONB2myv3b9GglI=;
 b=BKaNoapmEzttsLhFoa71NAgFci/zgK0khCyoYTTUwiMoFT9wQ/i9PQbVvU7B9gLW
 Ibo0xG6LThKvyLXGd8E9/9SsGE1+e3lVy0c6JJPW0iZPAxtPYPH+475CYVrw7utuFQD
 /p0yyUkaTMqh3Hn4zLmUG+pbTT8I6bZP7GmGaA8I=
Received: by mx.zohomail.com with SMTPS id 1775757125529646.2967776835437;
 Thu, 9 Apr 2026 10:52:05 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Thu, 09 Apr 2026 10:51:27 -0700
Subject: [PATCH v5 4/6] drm/tyr: Use register! macro for MMU_CONTROL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-tyr-use-register-macro-v5-v5-4-8abfff8a0204@collabora.com>
References: <20260409-b4-tyr-use-register-macro-v5-v5-0-8abfff8a0204@collabora.com>
In-Reply-To: <20260409-b4-tyr-use-register-macro-v5-v5-0-8abfff8a0204@collabora.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=31493;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=W1p2ZIM0odhjCmtctHu4Rt2VKzPDopjTtuQPbuKL47g=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJnXnzs8Wvtf/Yn+XLcX+oVvevOD5HkFBAoiOZXKa23uz
 7l27EN+RykLgxgXg6yYIstZe6Me8ar3Rrrz/zfDzGFlAhnCwMUpABPJrGD4w53zxTlmWtdPD/0/
 TlN7BbcuqfdQXOrrFWoae/+l+zF5V4b/ZeZbBdLnPMyXvXBx6f5VFptUqxeeyShOtKnIyF6fN9G
 MEwA=
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

Define the MMU_CONTROL register block with the kernel's register! macro
and replace the existing hand-written MMU register definitions with typed
register and field accessors.

This adds typed definitions for the MMU IRQ registers and the per-address
space MMU_AS_CONTROL registers, including TRANSTAB, MEMATTR, LOCKADDR,
COMMAND, FAULTSTATUS, STATUS, and TRANSCFG. It also introduces typed
enums for MMU commands, fault types, access types, address space modes,
memory attributes, and related MMU configuration fields.

For logical 64-bit MMU registers that are exposed as split 32-bit MMIO
registers, define both the typed 64-bit view and explicit low/high 32-bit
registers so the register layout remains documented without relying on
native 64-bit MMIO accesses.

This reduces open-coded bit manipulation, keeps MMU register layout
knowledge in one place, and makes the definitions easier to read and
maintain.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/regs.rs | 728 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 723 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 946bb795d4ab..36ecedb01196 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -892,11 +892,6 @@ fn from(status: McuStatus) -> Self {
     }
 }
 
-pub(crate) const MMU_IRQ_RAWSTAT: Register<0x2000> = Register;
-pub(crate) const MMU_IRQ_CLEAR: Register<0x2004> = Register;
-pub(crate) const MMU_IRQ_MASK: Register<0x2008> = Register;
-pub(crate) const MMU_IRQ_STAT: Register<0x200c> = Register;
-
 /// These registers correspond to the JOB_CONTROL register page.
 /// They are involved in communication between the firmware running on the MCU and the host.
 pub(crate) mod job_control {
@@ -946,3 +941,726 @@ pub(crate) mod job_control {
         }
     }
 }
+
+/// These registers correspond to the MMU_CONTROL register page.
+/// They are involved in MMU configuration and control.
+pub(crate) mod mmu_control {
+    use kernel::register;
+
+    register! {
+        /// IRQ sources raw status.
+        ///
+        /// This register contains the raw unmasked interrupt sources for MMU status and exception
+        /// handling.
+        ///
+        /// Writing to this register forces bits on.
+        /// Use [`IRQ_CLEAR`] to clear interrupts.
+        pub(crate) IRQ_RAWSTAT(u32) @ 0x2000 {
+            /// Page fault for address spaces.
+            15:0    page_fault;
+            /// Command completed in address spaces.
+            31:16   command_completed;
+        }
+
+        /// IRQ sources to clear.
+        /// Write a 1 to a bit to clear the corresponding bit in [`IRQ_RAWSTAT`].
+        pub(crate) IRQ_CLEAR(u32) @ 0x2004 {
+            /// Clear the PAGE_FAULT interrupt.
+            15:0    page_fault;
+            /// Clear the COMMAND_COMPLETED interrupt.
+            31:16   command_completed;
+        }
+
+        /// IRQ sources enabled.
+        ///
+        /// Set each bit to 1 to enable the corresponding interrupt source, and to 0 to disable it.
+        pub(crate) IRQ_MASK(u32) @ 0x2008 {
+            /// Enable the PAGE_FAULT interrupt.
+            15:0    page_fault;
+            /// Enable the COMMAND_COMPLETED interrupt.
+            31:16   command_completed;
+        }
+
+        /// IRQ status for enabled sources. Read only.
+        ///
+        /// This register contains the result of ANDing together [`IRQ_RAWSTAT`] and [`IRQ_MASK`].
+        pub(crate) IRQ_STATUS(u32) @ 0x200c {
+            /// PAGE_FAULT interrupt status.
+            15:0    page_fault;
+            /// COMMAND_COMPLETED interrupt status.
+            31:16   command_completed;
+        }
+    }
+
+    /// Per-address space registers ASn [0..15] within the MMU_CONTROL page.
+    ///
+    /// This array contains 16 instances of the MMU_AS_CONTROL register page.
+    pub(crate) mod mmu_as_control {
+        use core::convert::TryFrom;
+
+        use kernel::{
+            error::{
+                code::EINVAL,
+                Error, //
+            },
+            num::Bounded,
+            register, //
+        };
+
+        /// Maximum number of hardware address space slots.
+        /// The actual number of slots available is usually lower.
+        pub(crate) const MAX_AS: usize = 16;
+
+        /// Address space register stride. The elements in the array are spaced 64B apart.
+        const STRIDE: usize = 0x40;
+
+        register! {
+            /// Translation table base address. A 64-bit pointer.
+            ///
+            /// This field contains the address of the top level of a translation table structure.
+            /// This must be 16-byte-aligned, so address bits [3:0] are assumed to be zero.
+            pub(crate) TRANSTAB(u64)[MAX_AS, stride = STRIDE] @ 0x2400 {
+                /// Base address of the translation table.
+                63:0    base;
+            }
+
+            // TRANSTAB is a logical 64-bit register, but it is laid out in hardware as two
+            // 32-bit halves. Define it as separate low/high u32 registers so accesses match
+            // the MMIO register layout and do not rely on native 64-bit MMIO transactions.
+            pub(crate) TRANSTAB_LO(u32)[MAX_AS, stride = STRIDE] @ 0x2400 {
+                   31:0 value;
+            }
+
+            pub(crate) TRANSTAB_HI(u32)[MAX_AS, stride = STRIDE] @ 0x2404 {
+                31:0 value;
+            }
+        }
+
+        /// Helpers for MEMATTR Register.
+
+        #[derive(Copy, Clone, Debug, PartialEq)]
+        #[repr(u8)]
+        pub(crate) enum AllocPolicySelect {
+            /// Ignore ALLOC_R/ALLOC_W fields.
+            Impl = 2,
+            /// Use ALLOC_R/ALLOC_W fields for allocation policy.
+            Alloc = 3,
+        }
+
+        impl TryFrom<Bounded<u8, 2>> for AllocPolicySelect {
+            type Error = Error;
+
+            fn try_from(val: Bounded<u8, 2>) -> Result<Self, Self::Error> {
+                match val.get() {
+                    2 => Ok(Self::Impl),
+                    3 => Ok(Self::Alloc),
+                    _ => Err(EINVAL),
+                }
+            }
+        }
+
+        impl From<AllocPolicySelect> for Bounded<u8, 2> {
+            fn from(val: AllocPolicySelect) -> Self {
+                Bounded::try_new(val as u8).unwrap()
+            }
+        }
+
+        /// Coherency policy for memory attributes. Indicates the shareability of cached accesses.
+        ///
+        /// The hardware spec defines different interpretations of these values depending on
+        /// whether TRANSCFG.MODE is set to IDENTITY or not. IDENTITY mode does not use translation
+        /// tables (all input addresses map to the same output address); it is deprecated and not used
+        /// by the driver. This enum assumes that TRANSCFG.MODE is not set to IDENTITY.
+        #[derive(Copy, Clone, Debug, PartialEq)]
+        #[repr(u8)]
+        pub(crate) enum Coherency {
+            /// Midgard inner domain coherency.
+            ///
+            /// Most flexible mode - can map non-coherent, internally coherent, and system/IO
+            /// coherent memory. Used for non-cacheable memory in MAIR conversion.
+            MidgardInnerDomain = 0,
+            /// CPU inner domain coherency.
+            ///
+            /// Can map non-coherent and system/IO coherent memory. Used for write-back
+            /// cacheable memory in MAIR conversion to maintain CPU-GPU cache coherency.
+            CpuInnerDomain = 1,
+            /// CPU inner domain with shader coherency.
+            ///
+            /// Can map internally coherent and system/IO coherent memory. Used for
+            /// GPU-internal shared buffers requiring shader coherency.
+            CpuInnerDomainShaderCoh = 2,
+        }
+
+        impl TryFrom<Bounded<u8, 2>> for Coherency {
+            type Error = Error;
+
+            fn try_from(val: Bounded<u8, 2>) -> Result<Self, Self::Error> {
+                match val.get() {
+                    0 => Ok(Self::MidgardInnerDomain),
+                    1 => Ok(Self::CpuInnerDomain),
+                    2 => Ok(Self::CpuInnerDomainShaderCoh),
+                    _ => Err(EINVAL),
+                }
+            }
+        }
+
+        impl From<Coherency> for Bounded<u8, 2> {
+            fn from(val: Coherency) -> Self {
+                Bounded::try_new(val as u8).unwrap()
+            }
+        }
+
+        #[derive(Copy, Clone, Debug, PartialEq)]
+        #[repr(u8)]
+        pub(crate) enum MemoryType {
+            /// Normal memory (shared).
+            Shared = 0,
+            /// Normal memory, inner/outer non-cacheable.
+            NonCacheable = 1,
+            /// Normal memory, inner/outer write-back cacheable.
+            WriteBack = 2,
+            /// Triggers MEMORY_ATTRIBUTE_FAULT.
+            Fault = 3,
+        }
+
+        impl From<Bounded<u8, 2>> for MemoryType {
+            fn from(val: Bounded<u8, 2>) -> Self {
+                match val.get() {
+                    0 => Self::Shared,
+                    1 => Self::NonCacheable,
+                    2 => Self::WriteBack,
+                    3 => Self::Fault,
+                    _ => unreachable!(),
+                }
+            }
+        }
+
+        impl From<MemoryType> for Bounded<u8, 2> {
+            fn from(val: MemoryType) -> Self {
+                Bounded::try_new(val as u8).unwrap()
+            }
+        }
+
+        register! {
+            /// Stage 1 memory attributes (8-bit bitfield).
+            ///
+            /// This is not an actual register, but a bitfield definition used by the MEMATTR
+            /// register. Each of the 8 bytes in MEMATTR follows this layout.
+            MMU_MEMATTR_STAGE1(u8) @ 0x0 {
+                /// Inner cache write allocation policy.
+                0:0     alloc_w => bool;
+                /// Inner cache read allocation policy.
+                1:1     alloc_r => bool;
+                /// Inner allocation policy select.
+                3:2     alloc_sel ?=> AllocPolicySelect;
+                /// Coherency policy.
+                5:4     coherency ?=> Coherency;
+                /// Memory type.
+                7:6     memory_type => MemoryType;
+            }
+        }
+
+        impl TryFrom<Bounded<u64, 8>> for MMU_MEMATTR_STAGE1 {
+            type Error = Error;
+
+            fn try_from(val: Bounded<u64, 8>) -> Result<Self, Self::Error> {
+                Ok(Self::from_raw(val.get() as u8))
+            }
+        }
+
+        impl From<MMU_MEMATTR_STAGE1> for Bounded<u64, 8> {
+            fn from(val: MMU_MEMATTR_STAGE1) -> Self {
+                Bounded::try_new(u64::from(val.into_raw())).unwrap()
+            }
+        }
+
+        register! {
+            /// Memory attributes.
+            ///
+            /// Each address space can configure up to 8 different memory attribute profiles.
+            /// Each attribute profile follows the MMU_MEMATTR_STAGE1 layout.
+            pub(crate) MEMATTR(u64)[MAX_AS, stride = STRIDE] @ 0x2408 {
+                7:0     attribute0 ?=> MMU_MEMATTR_STAGE1;
+                15:8    attribute1 ?=> MMU_MEMATTR_STAGE1;
+                23:16   attribute2 ?=> MMU_MEMATTR_STAGE1;
+                31:24   attribute3 ?=> MMU_MEMATTR_STAGE1;
+                39:32   attribute4 ?=> MMU_MEMATTR_STAGE1;
+                47:40   attribute5 ?=> MMU_MEMATTR_STAGE1;
+                55:48   attribute6 ?=> MMU_MEMATTR_STAGE1;
+                63:56   attribute7 ?=> MMU_MEMATTR_STAGE1;
+            }
+
+            // MEMATTR is a logical 64-bit register, but it is laid out in hardware as two
+            // 32-bit halves. Define it as separate low/high u32 registers so accesses match
+            // the MMIO register layout and do not rely on native 64-bit MMIO transactions.
+            pub(crate) MEMATTR_LO(u32)[MAX_AS, stride = STRIDE] @ 0x2408 {
+                31:0 value;
+            }
+
+            pub(crate) MEMATTR_HI(u32)[MAX_AS, stride = STRIDE] @ 0x240c {
+                31:0 value;
+            }
+
+            /// Lock region address for each address space.
+            pub(crate) LOCKADDR(u64)[MAX_AS, stride = STRIDE] @ 0x2410 {
+                /// Lock region size.
+                5:0     size;
+                /// Lock region base address.
+                63:12   base;
+            }
+
+            // LOCKADDR is a logical 64-bit register, but it is laid out in hardware as two
+            // 32-bit halves. Define it as separate low/high u32 registers so accesses match
+            // the MMIO register layout and do not rely on native 64-bit MMIO transactions.
+            pub(crate) LOCKADDR_LO(u32)[MAX_AS, stride = STRIDE] @ 0x2410 {
+               31:0 value;
+            }
+
+            pub(crate) LOCKADDR_HI(u32)[MAX_AS, stride = STRIDE] @ 0x2414 {
+                31:0 value;
+            }
+        }
+
+        /// Helpers for MMU COMMAND register.
+        #[derive(Copy, Clone, Debug, PartialEq)]
+        #[repr(u8)]
+        pub(crate) enum MmuCommand {
+            /// No operation, nothing happens.
+            Nop = 0,
+            /// Propagate settings to the MMU.
+            Update = 1,
+            /// Lock an address region.
+            Lock = 2,
+            /// Unlock an address region.
+            Unlock = 3,
+            /// Clean and invalidate the L2 cache, then unlock.
+            FlushPt = 4,
+            /// Clean and invalidate all caches, then unlock.
+            FlushMem = 5,
+        }
+
+        impl TryFrom<Bounded<u32, 8>> for MmuCommand {
+            type Error = Error;
+
+            fn try_from(val: Bounded<u32, 8>) -> Result<Self, Self::Error> {
+                match val.get() {
+                    0 => Ok(MmuCommand::Nop),
+                    1 => Ok(MmuCommand::Update),
+                    2 => Ok(MmuCommand::Lock),
+                    3 => Ok(MmuCommand::Unlock),
+                    4 => Ok(MmuCommand::FlushPt),
+                    5 => Ok(MmuCommand::FlushMem),
+                    _ => Err(EINVAL),
+                }
+            }
+        }
+
+        impl From<MmuCommand> for Bounded<u32, 8> {
+            fn from(cmd: MmuCommand) -> Self {
+                (cmd as u8).into()
+            }
+        }
+
+        register! {
+            /// MMU command register for each address space. Write only.
+            pub(crate) COMMAND(u32)[MAX_AS, stride = STRIDE] @ 0x2418 {
+                7:0     command ?=> MmuCommand;
+            }
+        }
+
+        /// MMU exception types for FAULTSTATUS register.
+        #[derive(Copy, Clone, Debug, PartialEq)]
+        #[repr(u8)]
+        pub(crate) enum MmuExceptionType {
+            /// No error.
+            Ok = 0x00,
+            /// Invalid translation table entry, level 0.
+            TranslationFault0 = 0xC0,
+            /// Invalid translation table entry, level 1.
+            TranslationFault1 = 0xC1,
+            /// Invalid translation table entry, level 2.
+            TranslationFault2 = 0xC2,
+            /// Invalid translation table entry, level 3.
+            TranslationFault3 = 0xC3,
+            /// Invalid block descriptor.
+            TranslationFault4 = 0xC4,
+            /// Page permission error, level 0.
+            PermissionFault0 = 0xC8,
+            /// Page permission error, level 1.
+            PermissionFault1 = 0xC9,
+            /// Page permission error, level 2.
+            PermissionFault2 = 0xCA,
+            /// Page permission error, level 3.
+            PermissionFault3 = 0xCB,
+            /// Access flag not set, level 1.
+            AccessFlag1 = 0xD9,
+            /// Access flag not set, level 2.
+            AccessFlag2 = 0xDA,
+            /// Access flag not set, level 3.
+            AccessFlag3 = 0xDB,
+            /// Virtual address out of range.
+            AddressSizeFaultIn = 0xE0,
+            /// Physical address out of range, level 0.
+            AddressSizeFaultOut0 = 0xE4,
+            /// Physical address out of range, level 1.
+            AddressSizeFaultOut1 = 0xE5,
+            /// Physical address out of range, level 2.
+            AddressSizeFaultOut2 = 0xE6,
+            /// Physical address out of range, level 3.
+            AddressSizeFaultOut3 = 0xE7,
+            /// Page attribute error, level 0.
+            MemoryAttributeFault0 = 0xE8,
+            /// Page attribute error, level 1.
+            MemoryAttributeFault1 = 0xE9,
+            /// Page attribute error, level 2.
+            MemoryAttributeFault2 = 0xEA,
+            /// Page attribute error, level 3.
+            MemoryAttributeFault3 = 0xEB,
+        }
+
+        impl TryFrom<Bounded<u32, 8>> for MmuExceptionType {
+            type Error = Error;
+
+            fn try_from(val: Bounded<u32, 8>) -> Result<Self, Self::Error> {
+                match val.get() {
+                    0x00 => Ok(MmuExceptionType::Ok),
+                    0xC0 => Ok(MmuExceptionType::TranslationFault0),
+                    0xC1 => Ok(MmuExceptionType::TranslationFault1),
+                    0xC2 => Ok(MmuExceptionType::TranslationFault2),
+                    0xC3 => Ok(MmuExceptionType::TranslationFault3),
+                    0xC4 => Ok(MmuExceptionType::TranslationFault4),
+                    0xC8 => Ok(MmuExceptionType::PermissionFault0),
+                    0xC9 => Ok(MmuExceptionType::PermissionFault1),
+                    0xCA => Ok(MmuExceptionType::PermissionFault2),
+                    0xCB => Ok(MmuExceptionType::PermissionFault3),
+                    0xD9 => Ok(MmuExceptionType::AccessFlag1),
+                    0xDA => Ok(MmuExceptionType::AccessFlag2),
+                    0xDB => Ok(MmuExceptionType::AccessFlag3),
+                    0xE0 => Ok(MmuExceptionType::AddressSizeFaultIn),
+                    0xE4 => Ok(MmuExceptionType::AddressSizeFaultOut0),
+                    0xE5 => Ok(MmuExceptionType::AddressSizeFaultOut1),
+                    0xE6 => Ok(MmuExceptionType::AddressSizeFaultOut2),
+                    0xE7 => Ok(MmuExceptionType::AddressSizeFaultOut3),
+                    0xE8 => Ok(MmuExceptionType::MemoryAttributeFault0),
+                    0xE9 => Ok(MmuExceptionType::MemoryAttributeFault1),
+                    0xEA => Ok(MmuExceptionType::MemoryAttributeFault2),
+                    0xEB => Ok(MmuExceptionType::MemoryAttributeFault3),
+                    _ => Err(EINVAL),
+                }
+            }
+        }
+
+        impl From<MmuExceptionType> for Bounded<u32, 8> {
+            fn from(exc: MmuExceptionType) -> Self {
+                (exc as u8).into()
+            }
+        }
+
+        /// Access type for MMU faults.
+        #[derive(Copy, Clone, Debug, PartialEq)]
+        #[repr(u8)]
+        pub(crate) enum MmuAccessType {
+            /// An atomic (read/write) transaction.
+            Atomic = 0,
+            /// An execute transaction.
+            Execute = 1,
+            /// A read transaction.
+            Read = 2,
+            /// A write transaction.
+            Write = 3,
+        }
+
+        impl From<Bounded<u32, 2>> for MmuAccessType {
+            fn from(val: Bounded<u32, 2>) -> Self {
+                match val.get() {
+                    0 => MmuAccessType::Atomic,
+                    1 => MmuAccessType::Execute,
+                    2 => MmuAccessType::Read,
+                    3 => MmuAccessType::Write,
+                    _ => unreachable!(),
+                }
+            }
+        }
+
+        impl From<MmuAccessType> for Bounded<u32, 2> {
+            fn from(access: MmuAccessType) -> Self {
+                Bounded::try_new(access as u32).unwrap()
+            }
+        }
+
+        register! {
+            /// Fault status register for each address space. Read only.
+            pub(crate) FAULTSTATUS(u32)[MAX_AS, stride = STRIDE] @ 0x241c {
+                /// Exception type.
+                7:0     exception_type ?=> MmuExceptionType;
+                /// Access type.
+                9:8     access_type => MmuAccessType;
+                /// ID of the source that triggered the fault.
+                31:16   source_id;
+            }
+
+            /// Fault address for each address space. Read only.
+            pub(crate) FAULTADDRESS_LO(u32)[MAX_AS, stride = STRIDE] @ 0x2420 {
+                31:0    pointer;
+            }
+
+            pub(crate) FAULTADDRESS_HI(u32)[MAX_AS, stride = STRIDE] @ 0x2424 {
+                31:0    pointer;
+            }
+
+            /// MMU status register for each address space. Read only.
+            pub(crate) STATUS(u32)[MAX_AS, stride = STRIDE] @ 0x2428 {
+                /// External address space command is active, a 1-bit boolean flag.
+                0:0     active_ext => bool;
+                /// Internal address space command is active, a 1-bit boolean flag.
+                1:1     active_int => bool;
+            }
+        }
+
+        /// Helpers for TRANSCFG register.
+        ///
+        /// Address space mode for TRANSCFG register.
+        #[derive(Copy, Clone, Debug, PartialEq)]
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
+        #[derive(Copy, Clone, Debug, PartialEq)]
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
+        #[derive(Copy, Clone, Debug, PartialEq)]
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
+        #[derive(Copy, Clone, Debug, PartialEq)]
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
+
+        register! {
+            /// Translation configuration and control.
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
+
+            // TRANSCFG is a logical 64-bit register, but it is laid out in hardware as two
+            // 32-bit halves. Define it as separate low/high u32 registers so accesses match
+            // the MMIO register layout and do not rely on native 64-bit MMIO transactions.
+            pub(crate) TRANSCFG_LO(u32)[MAX_AS, stride = STRIDE] @ 0x2430 {
+                31:0 value;
+            }
+
+            pub(crate) TRANSCFG_HI(u32)[MAX_AS, stride = STRIDE] @ 0x2434 {
+                31:0 value;
+            }
+
+            /// Extra fault information for each address space. Read only.
+            pub(crate) FAULTEXTRA_LO(u32)[MAX_AS, stride = STRIDE] @ 0x2438 {
+                31:0    value;
+            }
+
+            pub(crate) FAULTEXTRA_HI(u32)[MAX_AS, stride = STRIDE] @ 0x243c {
+                31:0    value;
+            }
+        }
+    }
+}

-- 
2.53.0

