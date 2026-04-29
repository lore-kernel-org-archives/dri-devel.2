Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE14FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA79C10EF2B;
	Wed, 29 Apr 2026 10:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lzYvYgZh";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C591510E26E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 05:08:46 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-35d965648a2so10862282a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777439326; x=1778044126; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KPbd8CPced3p+R7AG2gDS8UVQl+Rhqk52G90qEr4h9s=;
 b=lzYvYgZhlTRProbdG7MlzwF/4Fh/MWp4pzVU2+HW+BAouYmYr8JdpmvXu8qEW44lRh
 xrogadOpLqMHte40sxuw15erpkBzR7UUgn1MtYhS1fQ72MhYtiTka7rUkrrms8G4aneu
 kcAvbYnq1n/8f8wK5O7DBNt56zeQBKfG33DyhRSXJ4Io7rnMOW5dofIVCVk8uBtjVdcg
 kRvAYO9H14YrraetxivL5vrIJxZa7ApDD7OUsjM/p9RpFPsOEQOgY7MINY2QlsOxgUGq
 Ik268jzUqJSoUZd4rTi/43kgeYpZUUqsZYO4r9CtfxPho+xhNh9UYnS/7NJtuC8ySTXj
 T6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777439326; x=1778044126;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPbd8CPced3p+R7AG2gDS8UVQl+Rhqk52G90qEr4h9s=;
 b=RYV6ppjvQCMCYCl8DhchItVQGkrOeqZldhyhPCWGmAXtCrh7MDfyIDJhYg34XLwOgz
 0tmfRTrUfJJghSLvXtpC/lE9/PqlM5DdOa1fgJbt3Y1XAuTdmIXQK3BIupNCclCLZzTq
 k8FdXJkONDEb2P29y6WaZuRYa/fgB7fVfqTAkMW0KnEuiYhmgIeESH74mzNvMLzL/kmi
 +NnhZ+pWfEnPawbRp6pMl33MU5wath0qdiWbD6kaDlQQHpZAliu2roeQ4Z3L5mSojBlc
 PdOjcNrOkQCFk8A3CbJxOqPsAhqNsTOGVZZj4uYWbIubySQUjF7r0ZLbOuTTMLqkbBz3
 nusg==
X-Gm-Message-State: AOJu0Yx5YriRCJTC/GNjSgNGH5wMf2/AXj37kRwVY+s/XfJk+cPKIGfz
 uWvndSWQVAgZqBPNZnO2AbIG5AJ1j7BS+HSEQPo9UgISGudnnDx2STz4
X-Gm-Gg: AeBDiet3zaTz4q+1SAGmCEJDDb1H+dUlu7PhFTC9Zbz8cQtwaeQd09dfGTnq5pJnRzs
 61ZsukbMokx6xi5fVlz4aHCi/1mBUkIOOGhzQKjhLSs6JbLxRlLbSczerpQS8Ycqxw4W120Doq0
 tPucMrs4gd+Cv3gOrmaA1FxYd8mmjQcqTZQGWly5Z0XMTAmCN46ZiOHz5gMhTjijvdxDxVP+5Wt
 2N10re8hpr8s05fnz6kTF/3GJcwHZd5r7Reqt3DPcBFszlp3MR5Ujaj/xUagNWUt3rdLrB9jzHJ
 OtgGr5ogduNFCFlGGgz4A39qOAHAh9iSo4YdtH6vJKMhjMxYViCAU2q8Q7cN2/5LM3qLoZJTpWB
 s11F4NM6EgWscYQ/G4s6LyVhW8W5r6vS09v0fwgnpYtFHQNmyj9DFwaEcM+5eHKppOWEDRw78pc
 nEn4Pga26srlAdm+D/5CmJ1P3XBRYiDQxLnmRQ5GM44kcGkng=
X-Received: by 2002:a17:90b:1a8e:b0:35b:9b77:d7c with SMTP id
 98e67ed59e1d1-364a0d08580mr2433235a91.14.1777439326204; 
 Tue, 28 Apr 2026 22:08:46 -0700 (PDT)
Received: from yuwhisper-pc. ([49.213.140.88])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a4152b85sm1158871a91.4.2026.04.28.22.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 22:08:45 -0700 (PDT)
From: Hsiu Che Yu <yu.whisper.personal@gmail.com>
Date: Wed, 29 Apr 2026 13:08:14 +0800
Subject: [PATCH] rust: drm: fix incorrect type name in `Device` doc comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-fix-drm-device-comment-v1-1-d8876b44d688@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD2S8WkC/yWMQQqDMBAAvyJ7dkFTK9GviIe6WesKiSWxRRD/7
 lqPAzOzQ+IonKDNdoj8kyRLUCjzDGh6hTejOGUwhamLyjQ4yoYuenQqEyMt3nNYsSrts7H24Wg
 cQONPZDX/466/OX2HmWm9bnAcJ00Rqed6AAAA
X-Change-ID: 20260429-fix-drm-device-comment-41859883dcfb
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Maxime Ripard <mripard@kernel.org>, 
 Asahi Lina <lina+kernel@asahilina.net>, Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Hsiu Che Yu <yu.whisper.personal@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

The invariant documentation incorrectly referenced `struct device`
instead of `struct drm_device`. Fix it.

Fixes: 1e4b8896c0f3c ("rust: drm: add device abstraction")
Cc: stable@vger.kernel.org
Signed-off-by: Hsiu Che Yu <yu.whisper.personal@gmail.com>
---
 rust/kernel/drm/device.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index adbafe8db54d..301c9f7859e2 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -72,7 +72,7 @@ macro_rules! drm_legacy_fields {
 ///
 /// # Invariants
 ///
-/// `self.dev` is a valid instance of a `struct device`.
+/// `self.dev` is a valid instance of a `struct drm_device`.
 #[repr(C)]
 pub struct Device<T: drm::Driver> {
     dev: Opaque<bindings::drm_device>,
@@ -160,7 +160,7 @@ pub(crate) fn as_raw(&self) -> *mut bindings::drm_device {
 
     /// # Safety
     ///
-    /// `ptr` must be a valid pointer to a `struct device` embedded in `Self`.
+    /// `ptr` must be a valid pointer to a `struct drm_device` embedded in `Self`.
     unsafe fn from_drm_device(ptr: *const bindings::drm_device) -> *mut Self {
         // SAFETY: By the safety requirements of this function `ptr` is a valid pointer to a
         // `struct drm_device` embedded in `Self`.
@@ -184,7 +184,7 @@ unsafe fn into_drm_device(ptr: NonNull<Self>) -> *mut bindings::drm_device {
     /// to can't drop to zero, for the duration of this function call and the entire duration when
     /// the returned reference exists.
     ///
-    /// Additionally, callers must ensure that the `struct device`, `ptr` is pointing to, is
+    /// Additionally, callers must ensure that the `struct drm_device`, `ptr` is pointing to, is
     /// embedded in `Self`.
     #[doc(hidden)]
     pub unsafe fn from_raw<'a>(ptr: *const bindings::drm_device) -> &'a Self {

---
base-commit: b4e07588e743c989499ca24d49e752c074924a9a
change-id: 20260429-fix-drm-device-comment-41859883dcfb

Best regards,
--  
Hsiu Che Yu <yu.whisper.personal@gmail.com>

