Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD0606A684
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=g5cmLssW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB7A10E437;
	Thu, 26 Nov 2026 20:11:20 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624001126D9
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 20:11:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795723862; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gC6Qr1R4CUZld0Kj2qvSSm5+aMxDg+2kERty2f5bECfH4B3f1FpaJYN+uBjUgd1iQfh1P0ryNbHUc3Vy+OHKri98sVcCjG1xX2o2SQq6NsZZ910xYVy8O+O2MGLs5d2WrtkpMBtCwAj09TJexuSVART+ipYF4NvDfk6q82HNkWs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795723862;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wg7anhdkqxYEXj+qn6O2geHDjkq19k/1tlUFrrKs28Y=; 
 b=QwWVOhcGksO53efRBsWIl27b9v9S14KIwg9z3iM8GhvYMEUPwNADeEgVCzFPEyzBmswBJDowft8HCFKmhbvsweHASK6AI9Y4ftfqqPIwsH05dfGleOilsWtmNfVpeEeGYHbxrTQOket+d19IzGMFqhYfX5PmhellaTbXpDLCOJc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=g5cmLssWK3W8Agxw+n4tj74ZXAiAazoyaumwfMnw8NjOa2HKWu3XsUhmFOoHltyvzqvXwoZr6EjOdlXaKchZrlQuTOq/9+3HZ8z6oaeMaZ7uutfSAbgBJh3CSn+FNuCDX5edCV9AfwsaPusFBtjbhvwZPrWD1CwEJ8Kxaq7V7q4=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=wg7anhdkqxYEXj+qn6O2geHDjkq19k/1tlUFrrKs28Y=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795723860818406.7334629431689;
 Thu, 26 Nov 2026 12:11:00 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 26 Nov 2026 17:10:45 -0300
Subject: [PATCH 3/4] drm/tyr: use the conversion derives for `CacheMode`
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-tyr-enum-derives-v1-3-a487b0e1bee3@collabora.com>
References: <20261126-tyr-enum-derives-v1-0-a487b0e1bee3@collabora.com>
In-Reply-To: <20261126-tyr-enum-derives-v1-0-a487b0e1bee3@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Kaiqi Guo <chaoji_xinren@163.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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
larger effort to reduce the number of `as` casts in Tyr, derive the
conversions between `CacheMode` and `Bounded` instead of writing them
by hand. This removes the cast that converts `CacheMode` to its integer
value.

No functional change intended.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/fw.rs | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 2fa9852e0b83..cf880f685922 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -26,10 +26,11 @@
         poll,
         Io, //
     },
-    num::{
-        casts::FromSafeCast,
-        Bounded, //
+    macros::{
+        From,
+        Into, //
     },
+    num::casts::FromSafeCast,
     prelude::*,
     str::CString,
     sync::{
@@ -76,7 +77,8 @@
 
 pub(super) const CSF_MCU_SHARED_REGION_START: u32 = 0x04000000;
 
-#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+#[derive(Copy, Clone, Debug, PartialEq, Eq, From, Into)]
+#[convert(Bounded<u32, 2>)]
 #[repr(u8)]
 pub(super) enum CacheMode {
     None = 0,
@@ -85,26 +87,6 @@ pub(super) enum CacheMode {
     CachedCoherent = 3,
 }
 
-impl From<Bounded<u32, 2>> for CacheMode {
-    fn from(value: Bounded<u32, 2>) -> Self {
-        match value.get() {
-            0 => Self::None,
-            1 => Self::Cached,
-            2 => Self::UncachedCoherent,
-            3 => Self::CachedCoherent,
-            _ => unreachable!(),
-        }
-    }
-}
-
-impl From<CacheMode> for Bounded<u32, 2> {
-    #[expect(clippy::as_conversions)]
-    fn from(value: CacheMode) -> Self {
-        // CAST: `CacheMode` is `#[repr(u8)]`, so the cast is lossless.
-        Bounded::try_new(value as u32).unwrap()
-    }
-}
-
 bitfield! {
     pub(super) struct SectionFlags(u32) {
         0:0 read => bool;

-- 
2.56.0

