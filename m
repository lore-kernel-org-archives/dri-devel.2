Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57AB606A6AA
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=CnGDaOZ9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B6810FFF6;
	Wed, 25 Nov 2026 22:48:16 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E61510FFE6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795646874; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=T1977zerzDbblLEHB4lmzINsgZqTNhXd9pMx0tT03WNNIG8gHYTUDNw01WzGruglpscBYVuOvCzVgw8LW8sOcyJxzqcdLOCiHMnNdK6gg46IpivZhHGseQ/xCsipNUu2o6gUIsLQZoNrGbL77YSneUehVpuKfjhriOT1a8UCVD4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795646874;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OcoNfhRzueM4nmkVOl/eWUDadIuxLOkb0KKg/ezBuXI=; 
 b=GJEw8elqYtGBNmuL6467K5u2S3gutYtca6xXGMXGX/kegX66mG0XQmclz+E9LlL5dKlGzPTAGoy83pMfBOigtGVDzqgZsdWkRK65HpynT0UU6DT+p6SfhnIy/RNYs2Yt2c2Kfg+bZ9SFSYw/rz9+FWSWlLiwZRfpL/VYSwUl1ME=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=CnGDaOZ9OyvERxzenT1Sk8r0lUExIS7ZKfAH1mcXZv6wL6uSxpxvOmS+7xERTPPPGF+GPzLdxCOuGWRE84HTqtSnfTaOYJ7aGf8JABsLZmgKEt1A2X1z1yrE3fUNngOj1lFM1A+lQmm5eettDpWuo34Dhxej/dn7cn/X1CbI6rY=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=OcoNfhRzueM4nmkVOl/eWUDadIuxLOkb0KKg/ezBuXI=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795646871124918.3804823342383;
 Wed, 25 Nov 2026 14:47:51 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 25 Nov 2026 19:47:00 -0300
Subject: [PATCH 09/13] drm/tyr: justify the casts of enums to their integer
 value
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-b4-tyr-as-casts-v1-9-2b2f53164d86@collabora.com>
References: <20261125-b4-tyr-as-casts-v1-0-2b2f53164d86@collabora.com>
In-Reply-To: <20261125-b4-tyr-as-casts-v1-0-2b2f53164d86@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An `as` cast silently drops the bits that do not fit the target type,
and nothing at the cast shows whether that can happen. As part of a
larger effort to reduce the number of `as` casts in Tyr, justify the
casts that convert an enum to its integer value. These stay, since
`as` is how Rust reads the value of an enum.

Each of them gets a `// CAST:` comment and an
`#[expect(clippy::as_conversions)]`, so that the lint can be enabled
for the driver.

No functional change intended.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/fw.rs   |  2 ++
 drivers/gpu/drm/tyr/regs.rs | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 14cfe2884d5a..2fa9852e0b83 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -98,7 +98,9 @@ fn from(value: Bounded<u32, 2>) -> Self {
 }
 
 impl From<CacheMode> for Bounded<u32, 2> {
+    #[expect(clippy::as_conversions)]
     fn from(value: CacheMode) -> Self {
+        // CAST: `CacheMode` is `#[repr(u8)]`, so the cast is lossless.
         Bounded::try_new(value as u32).unwrap()
     }
 }
diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 49e4adf2231d..443e9a1e7a21 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -251,7 +251,9 @@ fn try_from(val: Bounded<u32, 8>) -> Result<Self, Self::Error> {
     }
 
     impl From<GpuCommand> for Bounded<u32, 8> {
+        #[expect(clippy::as_conversions)]
         fn from(cmd: GpuCommand) -> Self {
+            // CAST: `GpuCommand` is `#[repr(u8)]`, so the cast is lossless.
             (cmd as u8).into()
         }
     }
@@ -279,7 +281,9 @@ fn try_from(val: Bounded<u32, 4>) -> Result<Self, Self::Error> {
     }
 
     impl From<ResetMode> for Bounded<u32, 4> {
+        #[expect(clippy::as_conversions)]
         fn from(mode: ResetMode) -> Self {
+            // CAST: `ResetMode` is `#[repr(u8)]`, so the cast is lossless.
             Bounded::try_new(mode as u32).unwrap()
         }
     }
@@ -313,7 +317,9 @@ fn try_from(val: Bounded<u32, 4>) -> Result<Self, Self::Error> {
     }
 
     impl From<FlushMode> for Bounded<u32, 4> {
+        #[expect(clippy::as_conversions)]
         fn from(mode: FlushMode) -> Self {
+            // CAST: `FlushMode` is `#[repr(u8)]`, so the cast is lossless.
             Bounded::try_new(mode as u32).unwrap()
         }
     }
@@ -434,7 +440,9 @@ fn try_from(val: Bounded<u32, 8>) -> Result<Self, Self::Error> {
     }
 
     impl From<ExceptionType> for Bounded<u32, 8> {
+        #[expect(clippy::as_conversions)]
         fn from(exc: ExceptionType) -> Self {
+            // CAST: `ExceptionType` is `#[repr(u8)]`, so the cast is lossless.
             (exc as u8).into()
         }
     }
@@ -465,7 +473,9 @@ fn from(val: Bounded<u32, 2>) -> Self {
     }
 
     impl From<AccessType> for Bounded<u32, 2> {
+        #[expect(clippy::as_conversions)]
         fn from(access: AccessType) -> Self {
+            // CAST: `AccessType` is `#[repr(u8)]`, so the cast is lossless.
             Bounded::try_new(access as u32).unwrap()
         }
     }
@@ -772,7 +782,9 @@ fn try_from(val: Bounded<u32, 32>) -> Result<Self, Self::Error> {
     }
 
     impl From<CoherencyMode> for Bounded<u32, 32> {
+        #[expect(clippy::as_conversions)]
         fn from(mode: CoherencyMode) -> Self {
+            // CAST: `CoherencyMode` is `#[repr(u8)]`, so the cast is lossless.
             (mode as u8).into()
         }
     }
@@ -814,7 +826,9 @@ fn try_from(val: Bounded<u32, 2>) -> Result<Self, Self::Error> {
     }
 
     impl From<McuControlMode> for Bounded<u32, 2> {
+        #[expect(clippy::as_conversions)]
         fn from(mode: McuControlMode) -> Self {
+            // CAST: `McuControlMode` is `#[repr(u8)]`, so the cast is lossless.
             Bounded::try_new(mode as u32).unwrap()
         }
     }
@@ -857,7 +871,9 @@ fn from(val: Bounded<u32, 2>) -> Self {
     }
 
     impl From<McuStatus> for Bounded<u32, 2> {
+        #[expect(clippy::as_conversions)]
         fn from(status: McuStatus) -> Self {
+            // CAST: `McuStatus` is `#[repr(u8)]`, so the cast is lossless.
             Bounded::try_new(status as u32).unwrap()
         }
     }
@@ -1050,7 +1066,9 @@ fn try_from(val: Bounded<u8, 2>) -> Result<Self, Self::Error> {
         }
 
         impl From<AllocPolicySelect> for Bounded<u8, 2> {
+            #[expect(clippy::as_conversions)]
             fn from(val: AllocPolicySelect) -> Self {
+                // CAST: `AllocPolicySelect` is `#[repr(u8)]`, so the cast is lossless.
                 Bounded::try_new(val as u8).unwrap()
             }
         }
@@ -1095,7 +1113,9 @@ fn try_from(val: Bounded<u8, 2>) -> Result<Self, Self::Error> {
         }
 
         impl From<Coherency> for Bounded<u8, 2> {
+            #[expect(clippy::as_conversions)]
             fn from(val: Coherency) -> Self {
+                // CAST: `Coherency` is `#[repr(u8)]`, so the cast is lossless.
                 Bounded::try_new(val as u8).unwrap()
             }
         }
@@ -1126,7 +1146,9 @@ fn from(val: Bounded<u8, 2>) -> Self {
         }
 
         impl From<MemoryType> for Bounded<u8, 2> {
+            #[expect(clippy::as_conversions)]
             fn from(val: MemoryType) -> Self {
+                // CAST: `MemoryType` is `#[repr(u8)]`, so the cast is lossless.
                 Bounded::try_new(val as u8).unwrap()
             }
         }
@@ -1379,7 +1401,9 @@ fn try_from(val: Bounded<u32, 8>) -> Result<Self, Self::Error> {
         }
 
         impl From<MmuCommand> for Bounded<u32, 8> {
+            #[expect(clippy::as_conversions)]
             fn from(cmd: MmuCommand) -> Self {
+                // CAST: `MmuCommand` is `#[repr(u8)]`, so the cast is lossless.
                 (cmd as u8).into()
             }
         }
@@ -1476,7 +1500,9 @@ fn try_from(val: Bounded<u32, 8>) -> Result<Self, Self::Error> {
         }
 
         impl From<MmuExceptionType> for Bounded<u32, 8> {
+            #[expect(clippy::as_conversions)]
             fn from(exc: MmuExceptionType) -> Self {
+                // CAST: `MmuExceptionType` is `#[repr(u8)]`, so the cast is lossless.
                 (exc as u8).into()
             }
         }
@@ -1508,7 +1534,9 @@ fn from(val: Bounded<u32, 2>) -> Self {
         }
 
         impl From<MmuAccessType> for Bounded<u32, 2> {
+            #[expect(clippy::as_conversions)]
             fn from(access: MmuAccessType) -> Self {
+                // CAST: `MmuAccessType` is `#[repr(u8)]`, so the cast is lossless.
                 Bounded::try_new(access as u32).unwrap()
             }
         }
@@ -1575,7 +1603,9 @@ fn try_from(val: Bounded<u64, 4>) -> Result<Self, Self::Error> {
         }
 
         impl From<AddressSpaceMode> for Bounded<u64, 4> {
+            #[expect(clippy::as_conversions)]
             fn from(mode: AddressSpaceMode) -> Self {
+                // CAST: `AddressSpaceMode` is `#[repr(u8)]`, so the cast is lossless.
                 Bounded::try_new(mode as u64).unwrap()
             }
         }
@@ -1672,7 +1702,9 @@ fn try_from(val: Bounded<u64, 5>) -> Result<Self, Self::Error> {
         }
 
         impl From<InaBits> for Bounded<u64, 5> {
+            #[expect(clippy::as_conversions)]
             fn from(bits: InaBits) -> Self {
+                // CAST: `InaBits` is `#[repr(u8)]`, so the cast is lossless.
                 Bounded::try_new(bits as u64).unwrap()
             }
         }
@@ -1703,7 +1735,9 @@ fn try_from(val: Bounded<u64, 2>) -> Result<Self, Self::Error> {
         }
 
         impl From<PtwMemattr> for Bounded<u64, 2> {
+            #[expect(clippy::as_conversions)]
             fn from(attr: PtwMemattr) -> Self {
+                // CAST: `PtwMemattr` is `#[repr(u8)]`, so the cast is lossless.
                 Bounded::try_new(attr as u64).unwrap()
             }
         }
@@ -1735,7 +1769,9 @@ fn try_from(val: Bounded<u64, 2>) -> Result<Self, Self::Error> {
         }
 
         impl From<PtwShareability> for Bounded<u64, 2> {
+            #[expect(clippy::as_conversions)]
             fn from(sh: PtwShareability) -> Self {
+                // CAST: `PtwShareability` is `#[repr(u8)]`, so the cast is lossless.
                 Bounded::try_new(sh as u64).unwrap()
             }
         }

-- 
2.56.0

