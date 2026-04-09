Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7370DF364A6
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9559B10E84F;
	Thu,  9 Apr 2026 17:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="aAPKZYRL";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E3A10E849
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775757127; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fOJ+70q48d4X8o1nN0twZumhD1HpkPyaqo9QRkrF7W9j/YF9hNxaBLb9DAWwsIWyn68otYao2uO40v1ewzjILkGTC/xNQ1LyDymbwV8As6CtcXfkLNyGCAqYSqk62yT8IJ2fSYHW+15WzwzIvEWEYegSy9NSbz/xGvf/6N9RoNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775757127;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=o3I9sQtpOp+Nmu9vKIPFZv569u4sWsisCRYnpsINLKQ=; 
 b=Chph+CTkOEP7kW37Fp2fhcp7KcHmFUcoDTdjfEOlr+hwX/HPq3lc2M5/JmpyLGcg2N1Fj3sIAMvNq33sNfTnNcZUMHVHBvG3w/9hB8ft303U6ZdKRYyZNEsh07KsCihXB4lIUIgm6xKlEfUPTzqSBwSGZ+NFUJFTgKlW2N7NvqE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775757127; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=o3I9sQtpOp+Nmu9vKIPFZv569u4sWsisCRYnpsINLKQ=;
 b=aAPKZYRLE7oa34Lco1YaVsJ1LJGzsl76lX71RfTSYS0iliICwAsGNGAYbL1NyNRR
 WT4djpvX6bVKC0/lnQI8Gi7ibWa8gXp2UQuxkMaaxdY8rlapw/B/xRkn0sP0mWBvzW8
 zJbVVsdaxCHtAT3u3q9JweX4KhC0EPxStGjOYXNo=
Received: by mx.zohomail.com with SMTPS id 1775757126518504.5050380146604;
 Thu, 9 Apr 2026 10:52:06 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Thu, 09 Apr 2026 10:51:28 -0700
Subject: [PATCH v5 5/6] drm/tyr: Remove custom register struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-tyr-use-register-macro-v5-v5-5-8abfff8a0204@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=XcwVLzcnmDNmajb/NFAtI22RZe4GkyTp3xSGbzZIaDQ=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJnXnzu8jpuu4b/ruXKxyIsDa8+/6nAOdvhRs32eb3NWV
 F6RlvC0jlIWBjEuBlkxRZaz9kY94lXvjXTn/2+GmcPKBDKEgYtTACYS9YORYaOfwdTS7hBG87I6
 nb6bVe6314XUh5SLpoVcmj2l+sWWaoa/8veXS3s4uTvGcsocXKC/+OqWbz+OOF11E37iaCz17OI
 kBgA=
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

Now that Tyr uses the register! macro, it no longer needs to define a
custom register struct or read/write functions, so delete them.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/regs.rs | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 36ecedb01196..97de0a735ff8 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -27,39 +27,6 @@
 // does.
 #![allow(dead_code)]
 
-use kernel::{
-    device::{
-        Bound,
-        Device, //
-    },
-    devres::Devres,
-    io::Io,
-    prelude::*, //
-};
-
-use crate::driver::IoMem;
-
-/// Represents a register in the Register Set
-///
-/// TODO: Replace this with the Nova `register!()` macro when it is available.
-/// In particular, this will automatically give us 64bit register reads and
-/// writes.
-pub(crate) struct Register<const OFFSET: usize>;
-
-impl<const OFFSET: usize> Register<OFFSET> {
-    #[inline]
-    pub(crate) fn read(&self, dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<u32> {
-        let value = (*iomem).access(dev)?.read32(OFFSET);
-        Ok(value)
-    }
-
-    #[inline]
-    pub(crate) fn write(&self, dev: &Device<Bound>, iomem: &Devres<IoMem>, value: u32) -> Result {
-        (*iomem).access(dev)?.write32(value, OFFSET);
-        Ok(())
-    }
-}
-
 /// Combine two 32-bit values into a single 64-bit value.
 pub(crate) fn join_u64(lo: u32, hi: u32) -> u64 {
     (u64::from(lo)) | ((u64::from(hi)) << 32)

-- 
2.53.0

