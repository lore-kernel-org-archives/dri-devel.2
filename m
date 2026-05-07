Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC50CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 23:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5F810E5B1;
	Thu,  7 May 2026 23:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="AnYlSpPC";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9304110E5B1
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 23:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778196767; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Z14Bj7DC4eNrGghUKaej8B9EyEr6aJlt54767kgVsjfSY+v2GDWo9k8q6FsodFpj4l9iPm5qQSZVX85Im/soanzyiLO6kJFvp6eO+VogOyV1Texfns6ZL641RrP8cKAI+dawYBoTeUbPChH4LCSt+DQkPgyDwr38LXPMJLhvC14=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778196767;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2NLY72APnZcOWaicaOBiY0/NfOa0z6RzbN6RJkb//zI=; 
 b=FPH9RnopzOOqgfTnfQDFSN4/2l7YcPTesrNrf1IeboROfmxihJYy2K7jvqm3l7bP7VZENSDv4qfWNB4ZZydkjMxmF5BIrnti+SJXTjSYfWppbS7AEpx6ipkoLjQ/x7Q3Uh3oygKhHGJ4u26vFnw7PJEACrNqYUFyGuwkunzWX7o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778196767; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=2NLY72APnZcOWaicaOBiY0/NfOa0z6RzbN6RJkb//zI=;
 b=AnYlSpPCYOmyvmVegZhccULOjc6A2OXwMe8xbCFeG38X/bF3Fqsg9Z+zs/a1YN1N
 NSFJP425GMy3csNmJRQWRhMwkpMZQ3mbCXX+CYg2LxAyoCBlD2LyL9QBbOgX22fqhhW
 ylHSREN/6DCqlyAqbkth3SlQD77kCVRf4yhGz+o4=
Received: by mx.zohomail.com with SMTPS id 1778196765290540.1630003755475;
 Thu, 7 May 2026 16:32:45 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Thu, 07 May 2026 16:32:40 -0700
Subject: [PATCH 2/7] mm: rust: add VMA page offset helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-tyr-mmap-v1-2-eec048a23c25@collabora.com>
References: <20260507-tyr-mmap-v1-0-eec048a23c25@collabora.com>
In-Reply-To: <20260507-tyr-mmap-v1-0-eec048a23c25@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 boris.brezillon@collabora.com, beata.michalska@arm.com, lyude@redhat.com, 
 acourbot@nvidia.com, work@onurozkan.dev, alvin.sun@linux.dev, 
 Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=3UoXpSu7KF/dfK+s5Hc4A4XTkRi7kKOM3Xgjk6aPxIU=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl/FSVdSlzlPubFRC68xhprNO/CTfev10TqDBInbAx60
 H9OkiO9o5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgImUVzD8FZp34dVrmzN7FnIl
 Sn4t2RFUFOJYHyPuGmgVquC370vJNYZ/moq8NZdWCZhl3TqZODlFv17+1YxLc3ZFbV9rlaV1/eI
 GBgA=
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

From: Daniel Almeida <daniel.almeida@collabora.com>

Add VmaRef::pgoff() to expose vm_area_struct::vm_pgoff through the Rust
VMA abstractions.

vm_pgoff stores the mmap file offset in PAGE_SIZE units and can be used to
distinguish different mmap regions and dispatch mmap or fault handling
logic based on the requested offset.

This matches the existing start()/end()/flags() helpers and avoids
open-coded raw vm_area_struct access in Rust drivers.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 rust/kernel/mm/virt.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index 63eb730b0b05..cb670e9d5fd9 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -92,6 +92,16 @@ pub fn end(&self) -> usize {
         unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_end }
     }
 
+    /// Returns the page offset of the virtual memory area.
+    ///
+    /// This is the offset in pages from the start of the file being mapped.
+    #[inline]
+    pub fn pgoff(&self) -> usize {
+        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
+        // access is not a data race.
+        unsafe { (*self.as_ptr()).vm_pgoff }
+    }
+
     /// Zap pages in the given page range.
     ///
     /// This clears page table mappings for the range at the leaf level, leaving all other page

-- 
2.53.0

