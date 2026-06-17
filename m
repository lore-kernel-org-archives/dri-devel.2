Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D806CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CEF810EA57;
	Wed, 17 Jun 2026 15:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="j52YnJ3T";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26EFB10EA57
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:02:44 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4624a44e152so923037f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1781708563; x=1782313363;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+7QC6LAPQa8dQnEwdpFa6EKhfpyuQLPCL3jRYAOfa4=;
 b=j52YnJ3Toz58n4UmdiclewrvK+7ZTk3xB/G/2iKEPh2ZN3mv+zbxrNJ0XZlkeSoSM+
 CP8gYFOnDn85OLTwWJQrIBj6uO6SacxEifL8KrC4E51cQNc61mAqUFRRNQXLHFOI6wd1
 pRH/OZB/zFvFlh5gE2prcXr5d0ksRQFX8Bh6wufysrf68N7PRz06YnbybckhFJZc/Tv5
 vviPmML48keIMQtyVNewdsqQ6CKPR0ypyXvqLf5ih0WOqTCu/KU8kI2JLWkY1o3y57RJ
 sEXkiR6xu3wy2wSrWUIRkXyZxLMyjlM/GfehBYHJl+hIZmUYNCPMmrdUJao88GoQuTv5
 h/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708563; x=1782313363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K+7QC6LAPQa8dQnEwdpFa6EKhfpyuQLPCL3jRYAOfa4=;
 b=GVjBFCHYp0QLMc/oJUjza8ei+OsUk7EM6z4rcxKC9cu7dTPr87y386m6aqJpsU8myg
 PJN2WV1EQ/JW2hvuvy8DXQURUnSldzzIy+7O7tqFuV2v2rDxdLy0XdTaXdltTkMhXoAY
 YVVpVdoo+w3srM7yG/W3FjN3YzArQnt4V0SJy4mAtR5f9fn3cJYyvSpweMEe8E8yd9i0
 UeAHgB5NVV45J+2hIxyqgUZnwLRl0YCH+IH5PgpvN0HW9E3hhrKIWFAmxIuiTv8iYEwg
 JY+4N0AJtB3lBiAqs8oolSspqUa8dvWtbWZgP0mgtFSynkzqpr3Dnk3VLDZvi1WNaq+J
 ISWQ==
X-Gm-Message-State: AOJu0YwXZo5vifzNNHP/k8RUc988ttr/W0GXIVkWRTdC5B9+yBAWvNTE
 ntbJwTKMDtvgmjA6fpx+h1DuNyOWwSbcp7tgmc5+7CU5giYWuvXcUNeWDatvgVRlZa5gZYNlFX8
 pVd/xn4fT
X-Gm-Gg: AfdE7ckrl0dSDtRBbM+bepeYfhoj2HTA4ubU789k7fUUSxOaDJdrZ5drPyoo6aRIzr4
 7EdjZn8iWuXqXLcYU4pTSwW+/Tk3Ow7LJwzdJX07bkcfoyOlLzRcdEc/N0R1M7dWod8JSj5jazh
 svHSJesHOS9jqhZsraqeZXUvWKkC9JG1TfUntieP78lNubE9VgpnAFBtGEnjceGFhW/l8FOL1qq
 qqeB+tJ031c5WOUmXzl/MtnH8Z5lM7ghFEZM0MGcdWnzXC7b6961+CbGjG4ZKFpYYLIYCPhzG/W
 1p9VXOw/9CTm2L38klR9N5YLH7fe4SKRrjyys6vnYWbcORao9+AILNo6X2SsMC6ZWaUW5r/mgrm
 LUjg+vMcz8aBqlh1TjJi0kj1HWBzP9YW/qNkJg2SMZFiqW6FsQ9B2JhAgnv9Kcxp+tcSVfD4OCL
 ahPQu+pK+CFmWZA3A4848uEdrwepRn561N7FP5KwWjW2Gide3NSlJUKw/j
X-Received: by 2002:adf:ef8d:0:b0:460:1f32:628d with SMTP id
 ffacd0b85a97d-4623683a4bdmr5928828f8f.11.1781708562488; 
 Wed, 17 Jun 2026 08:02:42 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm57264311f8f.11.2026.06.17.08.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:02:41 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Asahi Lina <lina+kernel@asahilina.net>, Lorenzo Stoakes <ljs@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] rust: drm: expose drm::Device::as_raw()
Date: Wed, 17 Jun 2026 16:02:25 +0100
Message-ID: <20260617150232.2210-4-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617150232.2210-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

A KMS driver built on the minimal bindings added earlier in this series
needs the raw `struct drm_device` pointer to hand to the C KMS helpers
(drm_simple_display_pipe_init, drm_connector_init, the drm_atomic_helper_*
family, …) until safe Rust KMS abstractions cover them.

Make drm::Device::as_raw() pub, documented as a temporary escape hatch
with the caller's locking/lifetime obligations spelled out. This is the
part of the KMS work most likely to draw objections, so it is split into
its own patch: it can be dropped or reworked (e.g. replaced by narrow safe
wrappers, or kept pub(crate) behind per-helper methods) without disturbing
the feature flags and header bindings, which are useful on their own.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/kernel/drm/device.rs | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 1d3319b713e2..c89c947b399a 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -296,7 +296,15 @@ pub struct Device<T: drm::Driver, C: DeviceContext = Registered> {
 }
 
 impl<T: drm::Driver, C: DeviceContext> Device<T, C> {
-    pub(crate) fn as_raw(&self) -> *mut bindings::drm_device {
+    /// Returns a raw pointer to the underlying `struct drm_device`.
+    ///
+    /// This is a temporary escape hatch for drivers that need to call C KMS helpers
+    /// not yet covered by safe Rust abstractions; it is expected to be removed (or
+    /// narrowed to `pub(crate)`) once the in-progress safe KMS layer can express
+    /// those operations. The returned pointer is valid for as long as `self` is
+    /// borrowed; the caller must uphold the locking and lifetime rules of every C
+    /// function it is passed to.
+    pub fn as_raw(&self) -> *mut bindings::drm_device {
         self.dev.get()
     }
 
-- 
2.54.0

