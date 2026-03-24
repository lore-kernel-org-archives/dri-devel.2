Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004ACF532C0
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 00:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6981610E505;
	Tue, 24 Mar 2026 00:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="aQacBQ7x";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D47D710E505
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 00:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774311500; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Df25MEW0bxJEtlwfoWmjbKYlHNOtFu/NcDi0omv7cLEwFSY4AvxKxa1M3fyeNQGixagnTrO77pV3pU/IaNITT6BKqqQmVD0FVsRFDFjmIWdT504I91oHr+wSha5yD3ZgbHyuPcvQKFJMP02vgqkVnIdaAe03p6MCwjq5Iq01oQU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774311500;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qwxyHuRy4QI6iJjsyNo13tIDj1LNcC227smo5YkbHFs=; 
 b=jch2En/i+Usn85Y1+4yUiFPEvJR7mYQfXO/VNeHChP8rYP7pFAuY2REz53XJ3pWYp/cVu73d2eADFF5a/kJYdrWcQQjHop2WyIPeoAgpU/W52sDjrT9PVF6mgU03fh0e9CR0VBzwioMrrGArZad3u8IECAa/aGdEiq3nxJkhKwc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774311500; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=qwxyHuRy4QI6iJjsyNo13tIDj1LNcC227smo5YkbHFs=;
 b=aQacBQ7xpNpnXdTwdbNGjADJacysBt8DDnIAUo5DpTIpDy6P/4dVdFbveOt2IpL6
 tXaHbH0TiFMzI2TySNxBrNH8YLOOoL/l6c6boxoGmQEOcvuaPlnTHdfnGQqAW+MrCVC
 RlNJVT30+sgyugx5ZmJKfI27RCg2zAo/7Z2v0mqE=
Received: by mx.zohomail.com with SMTPS id 177431149903018.030199007247916;
 Mon, 23 Mar 2026 17:18:19 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 23 Mar 2026 17:18:10 -0700
Subject: [PATCH v3 08/12] drm/tyr: Add fields for MEMATTR register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-tyr-use-register-macro-v3-v3-8-a87daf9e4701@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7842;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=DsGqg3hQuoL53saiCA6YZm0yndu9u7JYAMULbhRtTeo=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJkHbzikfIqflPDe7pNS7HKvy9lKax7USkW8nbE+3mTRz
 9pn1c9zO0pZGMS4GGTFFFnO2hv1iFe9N9Kd/78ZZg4rE8gQBi5OAZiIcCXDP/vp6w8k3/j+4Ebw
 Pcbaea+u3N+xsaYhzszpax4fc0w7tynDP53GHEGDqxXM/NHhn4S0znrcZzUxqv+hqbYjqq37qvF
 PDgA=
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

The MEMATTR register allows up to eight memory attributes to be
defined simultaneously. Add these attribute fields and helpers to
define them.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/regs.rs | 162 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 428b6d8c4d6bfd341713bbb7d79e0556a2d04415..9bf2723ab6412034be9a77930532cc89d0adb128 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -857,7 +857,16 @@ pub(crate) mod mmu_control {
     ///
     /// This array contains 16 instances of the MMU_AS_CONTROL register page.
     pub(crate) mod mmu_as_control {
-        use kernel::register;
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
 
         /// Maximum number of hardware address space slots.
         /// The actual number of slots available is usually lower.
@@ -875,12 +884,161 @@ pub(crate) mod mmu_as_control {
                 /// Base address of the translation table.
                 63:0    base;
             }
+        }
+
+        /// Helpers for MEMATTR Register.
+
+        #[derive(Copy, Clone, Debug)]
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
 
+        /// Coherency policy for memory attributes. Indicates the shareability of cached accesses.
+        ///
+        /// The hardware spec defines different interpretations of these values depending on
+        /// whether TRANSCFG.MODE is set to IDENTITY or not. IDENTITY mode does not use translation
+        /// tables (all input addresses map to the same output address); it is deprecated and not used
+        /// by the driver. This enum assumes that TRANSCFG.MODE is not set to IDENTITY.
+        #[derive(Copy, Clone, Debug)]
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
+        #[derive(Copy, Clone, Debug)]
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
             /// Memory attributes.
             ///
             /// Each address space can configure up to 8 different memory attribute profiles.
             /// Each attribute profile follows the MMU_MEMATTR_STAGE1 layout.
-            pub(crate) MEMATTR(u64)[MAX_AS, stride = STRIDE] @ 0x2408 {}
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
 
             /// Lock region address for each address space.
             pub(crate) LOCKADDR(u64)[MAX_AS, stride = STRIDE] @ 0x2410 {

-- 
2.52.0

