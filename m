Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6C4C61DC6
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2270610E314;
	Wed, 26 Aug 2026 16:34:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="dfJr9TQY";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9A510E314
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:34:48 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so8497835e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762087; x=1788366887;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dA2lE/gtA/CbYkkrJu7IaBkzRDM8/vT0VxRhU8+R4ns=;
 b=dfJr9TQYbjEwgCge5Y1abq4yaijPqu0DemSpqQ/3jOVmVNuv5AKpj5KRGoKJJsoPMQ
 Ab8fx1AFlnsPYW5b/p6vIpOgCchZFviMUWGzjg5sK3PbLyF1xkIFWoDsrN66ZV1ob+Jk
 +jyz3BsSFk+sM6FqWURsfQql2wordwJchXuMamyyj3zZYfu6R9R6rT6Ak9okd144dJH+
 BOYqoxf3L3rcP0d4iJK9Tf7QaFe9/OD3JiQgrVFiPykuvbvc7VRB6rYH5rtJ7GVKWukQ
 +I9hU1XNDyFeJ0ipJ8vKus2glps4uIjepBLlCXZc33sdhDBI5er2iY/i+F+TMCvEzo+K
 lWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762087; x=1788366887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dA2lE/gtA/CbYkkrJu7IaBkzRDM8/vT0VxRhU8+R4ns=;
 b=dr2PDz3AdGuWovcYQX7Vo3Ku6U9tStgnvPcgiYSKT02GdVr8AIBrKVQDSYpEJ+A8kl
 yKPgcjP84wDtoYjR2ubW23EpV01BfOlAIWhUk8/t3tPNFCQIwL2/mUyj3s7MGGbMOW6B
 8UHxMryM31RUFxRlyoTee4CtEHnZyFhvVjvZdWC+vfEqoKeprbU4y9gomFO6bLVyIg5V
 YxPUS6ysyzX+MuxT6WhhA+aWsqpBYZOH94QZv3bRjH/a5qxzZWXwPy3G3zCIeYIUzj9Z
 PQDgEBrEjEywO/TkcmEkejEqtDUeo2HkWyFmfoi8gUFACdiLX6P5uF9bjIZNHmMz4X2/
 JuIg==
X-Gm-Message-State: AFuF++ku+xq7nkdAy4Pl/1mHksdhdmitbEXMBA71yRyCBNmk7stK/gNy
 fl7g+UfCIJOtdm8r5TmUtYrm1LSO/b8v9mcDf1HTpHHR2WLGEXNsVYf3p+dajk+oy3UkEEIvDQz
 pydzPDje/
X-Gm-Gg: AR+sD12+lUxBZ8krkLQlfcc+c/pJ8hVA5iVscx7DT8On/JzVtdjbH/KdTAmWhkW+oYv
 yGLqC+rLMoEAAUViDyKU0AieCxF6D4OBjQuyo1AbtzW1lontorMCVpim+2Qa0kVbxHNEjvNTGY4
 BWF5uD/fK2Pvi8idwk5jN7CNxXIRCoqFV4Gi3SveKrlBYdquR6o95RQERYRKAQ4VDqzydI1lWm9
 YVwFCBN9AxXyJoJ3uQKCnVojSj0pXf3AgH3b+IiVA7TB0j7gxttb2nZuGUKFe5NNJVqLi2XC6Cc
 VMzW1hJ6cdXYXqidwTp6U08MFLUGVPJueqRb/B+OyG7LpGpt1vE7A82gIr+G7wZKwgl1qrE00c3
 T1SYxSxcGINRlt7PgtlV1WkRtBYXdaPwqx588B6Yx13K9ZbwxFmcTyVCsyQ6F2JKhmhg3CX/hnt
 ogq6CleqL9fArI6ger8HbRbIeN9NvnuNMWkRwVFCFzebNkU9IhrTnYjAZFrMWOFjneZ6foxz/Xf
 DfbGQikoGpukAWeCFDzhwHAooegq0i7z21h
X-Received: by 2002:a05:600c:190e:b0:499:a277:e8c8 with SMTP id
 5b1f17b1804b1-499dc725b50mr73945485e9.13.1787762086859; 
 Wed, 26 Aug 2026 09:34:46 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:45 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, Janne Grunau <j@jananu.net>,
 Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/23] rust: drm: reject cross-device GEM handle creation
Date: Wed, 26 Aug 2026 17:31:35 +0100
Message-ID: <20260826163359.4998-5-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826163359.4998-1-mike@fireburn.co.uk>
References: <20260826163359.4998-1-mike@fireburn.co.uk>
MIME-Version: 1.0
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

The Rust type bounds prove that a GEM object and file use the same
driver implementation, but one driver can own multiple DRM device
instances. drm_gem_handle_create() also requires the object and file
to belong to the same instance.

Expose the owning device pointer within the DRM crate and return
EINVAL for a mismatched instance.

Fixes: c284d3e42338 ("rust: drm: gem: Add GEM object abstraction")

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/file.rs    | 7 +++++++
 rust/kernel/drm/gem/mod.rs | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/rust/kernel/drm/file.rs b/rust/kernel/drm/file.rs
index 10160601ce5a..0abb7813f011 100644
--- a/rust/kernel/drm/file.rs
+++ b/rust/kernel/drm/file.rs
@@ -45,6 +45,13 @@ pub(super) fn as_raw(&self) -> *mut bindings::drm_file {
         self.0.get()
     }
 
+    /// Return the DRM device that owns this open file.
+    pub(crate) fn device_raw(&self) -> *mut bindings::drm_device {
+        // SAFETY: An open `drm_file` has a valid `minor`, whose `dev` pointer remains valid for
+        // the lifetime of the file.
+        unsafe { (*(*self.as_raw()).minor).dev }
+    }
+
     fn driver_priv(&self) -> *mut T {
         // SAFETY: By the type invariants of `Self`, `self.as_raw()` is always valid.
         unsafe { (*self.as_raw()).driver_priv }.cast()
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 60491e5521e4..334e946833fb 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -186,6 +186,13 @@ fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
         D: drm::Driver<Object = Self, File = F>,
         F: drm::file::DriverFile<Driver = D>,
     {
+        // The associated-type bounds prove a common driver type; separately reject another
+        // instance of that driver before passing the pair to the C API.
+        // SAFETY: `self.as_raw()` is a valid GEM object by the trait invariant.
+        if unsafe { (*self.as_raw()).dev } != file.device_raw() {
+            return Err(EINVAL);
+        }
+
         let mut handle: u32 = 0;
         // SAFETY: The arguments are all valid per the type invariants.
         to_result(unsafe {
