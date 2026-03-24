Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52758F532C4
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 00:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8235410E55B;
	Tue, 24 Mar 2026 00:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="iSOClt4N";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D19410E505
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 00:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774311504; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=m7KD13O8jJRYZoMZugG/94q43x7aqXnEGZHzaO1SMfsOIdUVpP5X05bJvRTQZYZNL2n/QfC5BduPlOdz5CIdRhqY7MERosiS6ZZgZAU4UzBx6MEAyXKKd/uD8fwHF7SXUJhkFx9jfedyZAR2eFB+vPuuODa0d3/iz5/E64GytYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774311504;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RBQU1rjLma4WXfgna014AegyHu6sqEYiPo/nUFs00GU=; 
 b=grEAUWpqalLkx4NBvE/1u9rLOJ+pBVmpE3zDFWUVkgMugG1D2wD0ruCRhMX3Ty2UjQ3FgKsqXSMRBCPqBA7iSKWe/E2LWtXsktQUO7aam9/rqUOyz7QJ8vLT4iGbvsfbEehuGBH9wl3hWY9fhWSyW4BxHXq4wbqfXtIpIsMjmO4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774311504; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=RBQU1rjLma4WXfgna014AegyHu6sqEYiPo/nUFs00GU=;
 b=iSOClt4NthyhxWhZGo8a8Fh4tZ1HXg856u04Ly/jZkkEXrCNtRyjDOPDdYCTVoJy
 hykAby183V9OzDHVtSllLv43wvD840ah0WFXzvEeHagLKTTWRl+SCvaczMeodqd2CLR
 POvOavtJE+GKlT9zNxPFbhKvPpn0Mi/3V0UAL5Xg=
Received: by mx.zohomail.com with SMTPS id 1774311503063881.1387007043594;
 Mon, 23 Mar 2026 17:18:23 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 23 Mar 2026 17:18:12 -0700
Subject: [PATCH v3 10/12] drm/tyr: Add fields for FAULTSTATUS register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-tyr-use-register-macro-v3-v3-10-a87daf9e4701@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6911;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=rAOGmQSPmteAsP+qFQdsUfzUcoAj1pSeZOi8fleGARw=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJkHbzg87stsDo5UWf3c8qCWv+yVFokv3/fem5n3c0Ht6
 c+ZAlbZHaUsDGJcDLJiiixn7Y16xKveG+nO/98MM4eVCWQIAxenAEyEN5iR4d3Kj9Mtvy35sPTe
 4syT0rb2j+zY5nz+trGvbr7A/S5utjaGP/w2UX4/X2z5P8OpoHH+lbmHH3ytWx8Vk9r71Ovd7N2
 2JhwA
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

The MMU FAULTSTATUS register communicates specific information about
fault exception, access type, and source. Enumerate this information and
use the register! macro to decode the defined values from this register.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/regs.rs | 131 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 6fbd6268724eb6b2ea8d76c5d991353dcbe87068..3d96d3264952616112e77939dfa2c753039dea35 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -1095,9 +1095,138 @@ fn from(cmd: MmuCommand) -> Self {
             pub(crate) COMMAND(u32)[MAX_AS, stride = STRIDE] @ 0x2418 {
                 7:0     command ?=> MmuCommand;
             }
+        }
+
+        /// MMU exception types for FAULTSTATUS register.
+        #[derive(Copy, Clone, Debug)]
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
+        #[derive(Copy, Clone, Debug)]
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
 
+        impl From<MmuAccessType> for Bounded<u32, 2> {
+            fn from(access: MmuAccessType) -> Self {
+                Bounded::try_new(access as u32).unwrap()
+            }
+        }
+
+        register! {
             /// Fault status register for each address space. Read only.
-            pub(crate) FAULTSTATUS(u32)[MAX_AS, stride = STRIDE] @ 0x241c {}
+            pub(crate) FAULTSTATUS(u32)[MAX_AS, stride = STRIDE] @ 0x241c {
+                /// Exception type.
+                7:0     exception_type ?=> MmuExceptionType;
+                /// Access type.
+                9:8     access_type => MmuAccessType;
+                /// ID of the source that triggered the fault.
+                31:16   source_id;
+            }
 
             /// Fault address for each address space. Read only.
             pub(crate) FAULTADDRESS(u64)[MAX_AS, stride = STRIDE] @ 0x2420 {

-- 
2.52.0

