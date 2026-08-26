Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75F1C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0032910ED4D;
	Wed, 26 Aug 2026 16:36:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="b8s4PdEt";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E7D10ED4D
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:36:04 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so394035e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762163; x=1788366963;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3EL6Jw26lW1z9BDf8CloPoJWlkDCbIL/77zIh+v+UO4=;
 b=b8s4PdEthbVJxpij9ZhWaCIM8iTvs1XQfr4dmnaYbGfuqptMFHeNCZAGF0ZhM8uZMG
 bDTU2GNCKuYpaqgCawEUaub4fH6eioBdIRraRhVcs93n1Bd2ixdMspnyB3wE30RUEj5F
 HF+brIS/6s0r51JwGfF20zsaqsR+6lLa4pYE8Xn8hGRKXmQkS9evvivXbZMMAi5dGz9P
 D6jqVbSPDN0hbrwd+HLa0IqEyguB8i8fauvOXTrXpvDYHdrfp4d+EYKDNAwXgtOVnVH0
 c2HSDegMBs0rGGNuJROD4FcEovi0ThWXJmTgPWHyQIWgIaPhH2p8Hl1pgT4RxYthzObV
 qApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762163; x=1788366963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3EL6Jw26lW1z9BDf8CloPoJWlkDCbIL/77zIh+v+UO4=;
 b=YWKqTJVndEA4D2tp9llcbx2kCacp+U3kduxtd+SHT2S/zGxCtq2uF9Ydf6T/0dusOT
 EdVYGFSTDrFC1G/WJ512SpphbS7hejWIo1F3rj6tlSx7XOY6SPWiLBOMivcdIOSTCtyy
 c8uRc7VV0B5vlbGCjEC35cmq4qycOfBdyDXKu0GzyOlOG6vOjAiY8isUO38clKvb1dkc
 neeioweBbdWmlwWnbi9rmnITQ96sHM0tYhgRkKCcVtazSHabceQ4jfHAupimte8raOk7
 T1MVxWkAJF/bycx1ZnVsU9Lg4CjjxihAcsLS2na0jZB0vtSx3uxNA0njPv0Nh18JuLK+
 KgyA==
X-Gm-Message-State: AFuF++lIAyhwEe1fAqChBzZhhh06IRbXYiumXdbCyUYlEpMG4lgDY90i
 a3m4egJWKZUvVaBarD4GKiHpUAXuMp7mmKJnlcUuqXB0k8FEJXZHp3jm2m+FHXulGo0pRXtL4Z4
 qGHPfcEMh
X-Gm-Gg: AR+sD10PTeAsWR5NLnLZrvo9H7IcN3iPd3//rB4NUqdVuIvKRiJlwXe3CYV3zNG7424
 1kz2raZQW5NL4pjDaHf6lG9afK5jfS6JvgIbQHbIuo5a4J3FYc84AqChBcFpQuw2juZrllppvQ1
 9xcIaHf91Yti5Q4JIvOCHImb57jU+Tuf4q/NZarjvg7Ij/hiJSZFLVBkpqukP6/WWTliko670bP
 6qjShbMyEdrdIO/SGqMOuOAID7+RQayDRZVREgQePR9LY1Jvc/xZEso7E2X0GOokUI9lztfCfdy
 3RlMIq8rxeFyOBwXXnyzobejxjaLtgt/IFbpOPnJ0A+xvLbzuBrnm/x+82prGhE3pEkWdaOEhNZ
 PhmiGXT68pFaUC1bKPulVPoUCbAbXq036t3BzlF1S0V+bBKWGjXnwboDIC5f/uX8TS8d0KXA0XY
 wWpx343jBlhqncOnSqi1+GFTHlVkrfF/UnPdy5f8rdcibuRwKZ4A4MiLZr9KQgO7SQdeIVh694l
 lIvHOM/+MzRS3SxbM+HfhjHPrj/q3nPAIGw
X-Received: by 2002:a05:600c:800f:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-49b0dea9491mr4564165e9.1.1787762162730; 
 Wed, 26 Aug 2026 09:36:02 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:36:01 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/23] rust: drm: add a safe constructor for owned
 registration data
Date: Wed, 26 Aug 2026 17:31:45 +0100
Message-ID: <20260826163359.4998-15-mike@fireburn.co.uk>
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

A DRM registration whose associated data is 'static cannot outlive any
references held by that data. Add a safe constructor for this common
case so drivers do not have to promise manually that their registration
will never be forgotten.

Keep the existing unsafe constructor for registration data which
genuinely borrows from the bus binding.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/driver.rs | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 356be329a2b6..2e7987a71a7a 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -169,7 +169,8 @@ pub struct Registration<'a, T: Driver> {
 }
 
 impl<'a, T: Driver> Registration<'a, T> {
-    /// Register a new [`UnregisteredDevice`](drm::UnregisteredDevice) with userspace.
+    /// Registers a new [`UnregisteredDevice`](drm::UnregisteredDevice) with borrowed
+    /// registration data.
     ///
     /// # Safety
     ///
@@ -177,7 +178,7 @@ impl<'a, T: Driver> Registration<'a, T> {
     /// [`Drop`] implementation from running, since the registration data may contain borrowed
     /// references that become invalid after `'a` ends.
     pub unsafe fn new<E>(
-        dev: &'a device::Device<device::Bound>,
+        dev: &device::Device<device::Bound>,
         drm: drm::UnregisteredDevice<T>,
         reg_data: impl PinInit<T::RegistrationData<'a>, E>,
         flags: usize,
@@ -243,6 +244,29 @@ pub fn device(&self) -> &drm::Device<T> {
     }
 }
 
+impl<T: Driver> Registration<'static, T> {
+    /// Registers a new [`UnregisteredDevice`](drm::UnregisteredDevice) with owned registration
+    /// data.
+    ///
+    /// Unlike [`Registration::new`], this constructor is safe because its registration
+    /// data cannot contain non-static references. Forgetting the returned registration can leak
+    /// the DRM device and its parent reference, but cannot leave a live registration referring to
+    /// expired data.
+    pub fn new_static<E>(
+        dev: &device::Device<device::Bound>,
+        drm: drm::UnregisteredDevice<T>,
+        reg_data: impl PinInit<T::RegistrationData<'static>, E>,
+        flags: usize,
+    ) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        // SAFETY: `RegistrationData<'static>` cannot borrow data that expires while a forgotten
+        // registration remains accessible.
+        unsafe { Self::new(dev, drm, reg_data, flags) }
+    }
+}
+
 // SAFETY: `Registration` doesn't offer any methods or access to fields when shared between
 // threads, hence it's safe to share it.
 unsafe impl<T: Driver> Sync for Registration<'_, T> {}
