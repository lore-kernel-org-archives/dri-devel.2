Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631C7C5DF6D
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 10:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6B710E1B0;
	Sat, 15 Aug 2026 10:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="YoVENFNM";
	dkim-atps=neutral
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A7B10E1B0
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1786789528; x=1787048728;
 bh=+v9o+NRXK5CCGWPth43KlQ7r3Y+hk4xRaz/0tYZOqNo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=YoVENFNM/6GiXMCKoKVf/e8x5o4OFa0+8WpY0bLj3FsNsFUNuD+0yNZEj+ikg//Ep
 d7h8CycnaDLbGDi3JkH+NAw97lLbkfliYBkk2xmlZOQwMMJg5/b7kADUOY5jh/K4ua
 kXI9fFsztOAEAQAzEOtDwa8IMkxXIRk/D+WXTWHRmNM0zVEkVLRR9+I7MRlmJkdY/V
 6yuHLyV+oBbQZBkcs7NYpzDXMqAg7W7N6XJlv0fyERJ+zND1GvOFI3yuVfLBs6vKac
 GLUhuPYXoDnGIfuU699Ad0NIXoTAOK6+hlMr+cpp7PXZy/PHvLDHBhUcFP+T0ZOSoQ
 gDiW2L+/yNcBA==
X-Pm-Submission-Id: 4hMZwx5vMnz2SchQ
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v4 1/4] rust: workqueue: impl Send and Sync for OwnedQueue
Date: Sat, 15 Aug 2026 13:23:57 +0300
Message-ID: <20260815-tyr-reset-impl-v4-1-578df9a5e576@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260815-tyr-reset-impl-v4-0-578df9a5e576@onurozkan.dev>
References: <20260815-tyr-reset-impl-v4-0-578df9a5e576@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

Allows OwnedQueue to be used across thread boundaries which is needed
from the tyr reset implementation.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/workqueue/mod.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/workqueue/mod.rs b/rust/kernel/workqueue/mod.rs
index 933032fc4a85..d766cd9b9175 100644
--- a/rust/kernel/workqueue/mod.rs
+++ b/rust/kernel/workqueue/mod.rs
@@ -383,6 +383,14 @@ pub struct OwnedQueue {
     queue: NonNull<Queue>,
 }
 
+// SAFETY: `OwnedQueue` has exclusive ownership of the workqueue and accesses to workqueues
+// are thread safe as documented by the `Send` implementation for `Queue`.
+unsafe impl Send for OwnedQueue {}
+
+// SAFETY: Shared access to an `OwnedQueue` only provides shared access to its `Queue` which
+// is thread safe as documented by the `Sync` implementation for `Queue`.
+unsafe impl Sync for OwnedQueue {}
+
 impl Deref for OwnedQueue {
     type Target = Queue;
     fn deref(&self) -> &Queue {

-- 
2.51.2
