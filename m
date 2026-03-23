Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10838F483DB
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 23:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7003E10E2A0;
	Mon, 23 Mar 2026 23:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="MC0Zvl9m";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2470010E27E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 23:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774308460; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=df0PnsAi/fYQoxvhh62YTfmt+gDZNAZGU6KOnNTPlqWJ4SIdgLm6OguBWC3LOmMmk7Ld1lx2GxQ/vfQTxGe/dbuC9R4rY14qUA4h5v3cr/PvreRgMVSIaQPB9/A/zLu+94ghUtGfsVsbbh5qWP7v1q0X0IcsWqfRxiS+86tp6oY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774308460;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=B9GTeddBPRV1DGgLqH3Ls9PLkdYCJyyYaSiXhSEZxIo=; 
 b=ZuVP2nEfLGsgfjTzd49li6FuBEzElQOyGQq+5gWF/i4QLK56F9JBsDC7TyFA8Rvx9jdECFch8jAX7bDAvRL/B7zOaNONTdnDaXt5N5nRYZ407mkauxPGFMBGNrxcgQz3i5fL1DYWDFObWeTvVkfoFnWtqgzTQSlglJPIjHahccw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774308460; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=B9GTeddBPRV1DGgLqH3Ls9PLkdYCJyyYaSiXhSEZxIo=;
 b=MC0Zvl9mdBvmOwxtnsQ8bvSiKxQw+u4x9blxgOtHjIX9aWrwLQrGUGso3d8UE2qu
 NRGatnyplaMe/6vdIczwB6tnh6wPPXMG6h0CkpdC5rrCnohyvhww7CP/lIA0FKo87sP
 L82rW851feDinN4ESK66VTfsUfhTBgnAe8KSkLdE=
Received: by mx.zohomail.com with SMTPS id 1774308459125951.9327010750577;
 Mon, 23 Mar 2026 16:27:39 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 23 Mar 2026 20:27:01 -0300
Subject: [PATCH v3 3/4] rust: workqueue: add delayed work support for ARef<T>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-aref-workitem-v3-3-f59729b812aa@collabora.com>
References: <20260323-aref-workitem-v3-0-f59729b812aa@collabora.com>
In-Reply-To: <20260323-aref-workitem-v3-0-f59729b812aa@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
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

The preceding patches added support for ARef<T> work items. By the same
token, add support for delayed work items too.

The rationale is the same: it may be convenient or even necessary at times
to implement HasDelayedWork directly on ARef<T>. A follow up patch will
also implement support for drm::Device as the first user.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/workqueue.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 6ae7f3fb3496..4ee4ff567197 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -1007,6 +1007,17 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
     }
 }
 
+// SAFETY: By the safety requirements of `HasDelayedWork`, the `work_struct` returned by methods in
+// `HasWork` provides a `work_struct` that is the `work` field of a `delayed_work`, and the rest of
+// the `delayed_work` has the same access rules as its `work` field.
+unsafe impl<T, const ID: u64> RawDelayedWorkItem<ID> for ARef<T>
+where
+    T: WorkItem<ID, Pointer = Self>,
+    T: HasDelayedWork<T, ID>,
+    T: AlwaysRefCounted,
+{
+}
+
 /// Returns the system work queue (`system_wq`).
 ///
 /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are

-- 
2.53.0

