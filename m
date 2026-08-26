Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED00C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6878F10E312;
	Wed, 26 Aug 2026 16:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="z0Pp2ziU";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3121510E30D
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:34:46 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so10267275e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762084; x=1788366884;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m7iMM34EcFPmhnGpJzLucaa/0lRT/oiuDhD8v2Q+RQs=;
 b=z0Pp2ziUJ+yCwAghINXUoZdTxGFTBcjrE9s9KNlTF/bA4mw6itFdnmdgWkmX6v+Otg
 2CMbkPe+YGuGi0yg3NNaLegwtHiVlYBf5on7YOhdXNkBAGHqMgATGMrx3MwSg7oeNthL
 zsaI79zB5Xgz9ebazbGn5pI0421vHUxx+bGRmNddIcRgPqBhy0FISmKzAjfJM+wU1tT0
 Xfk/M0zwgJ2hZWkk8SaP8GNWS6BJs0ISRgIFIYIJx3Hi+c6rLeG4c3QeL8w+1Brp+rI+
 cg3f1RZsTpg3f8Vb0qZsg9uKMBvVplHj1Ewc7/Dl7qdqbYI86n1weWK70U/Rb4Jp2EcZ
 0vBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762084; x=1788366884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m7iMM34EcFPmhnGpJzLucaa/0lRT/oiuDhD8v2Q+RQs=;
 b=iap6j5YW63bejtC/x/Oa4P3EEoA0ArXqGAEu1z+UpdKTj3EusyiMFJPKZtQya4B7kZ
 TWB1B7rf+vcYCnv15gynd2M9Ttb3KMFmw75h1FTnNK6ypcfXfxRdmtUNYNc9A6e9NOu6
 HeCjlgdTduYqAAPXAy1fC5PHy3m+Mr6oabVVIGnyh1i3/jqadD/XhFaEWFUT0F3IvJHB
 lARF0sBvj97mB6lJqx4dAKUCDBZdymKmnIEs/D+MYhlU/OHHxHfqrkR7n6SlsKStjIiR
 7/OjW/IA5mkoblb6sNKmmQhekF1hxShh56HY6HcmWgKR7Z2WrFQwI67JQxUrJYQR7jIz
 QQeQ==
X-Gm-Message-State: AFuF++mVoX7JGXdpyZfLRVjurNkvcz5U+XS7FgHmutW960PnH3PGHIvQ
 Aonp9wbqEZ+YFG8T8yqYWUqM0u4C3PmnHZ2wpwXlxA0v1gPYjEZBPl7AYL3ghfdK6mcK2kTujWw
 +OOIQM8kC
X-Gm-Gg: AR+sD133POasTeAMNMUju3STatNwCjNnfLetyHjtdikhRSYC6/XyA80SYDuNy9lvN3W
 gfyacb4Oks1qsfly0vGzvukjsNZI8zqzFCXqzUf6hPRZcycdB7Bybotw7FdMq+GlxI/Zeh2aVqb
 QWejPEioBnBPclZNSJxXeXlXV2kALjtvhAmbKrfn3GYqeStVpNXjMe21lHwbRp++920tya87Q95
 tL/86BUpVdQd510MpkI1YXXS9dcvFutl8G1tRGaAn5rDtPJUd+BFuWkXVG8F3l4WhoHNEz1Gl4v
 gUkl4oCPJBmsmhVkOWthfg3BO+Rq79B/9lzuD2x+GH+K84je/83/PrGmxzcOu9gXQua9DxffVxW
 YcYXGEqJJ0wRid6JDYfoamRI76VPiJY8JD8Z97c7EoEXncBImBuamCiaNG8UB/mJ1aAm0IbX4/n
 vXW4/17Kw5ceQ74vRi3/nAEeJsSVIf4Z6RMapBQ3EuS9Dau4ybjqgK991wFLbFIdL+tiTQkki7o
 0/HDPbBN+lhYlLVrTKamoprl/ORatbd58mVN9QfvGZizcI=
X-Received: by 2002:a05:600c:c87:b0:495:7888:281c with SMTP id
 5b1f17b1804b1-499dc693e38mr69082575e9.0.1787762084591; 
 Wed, 26 Aug 2026 09:34:44 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:43 -0700 (PDT)
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
 Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/23] rust: drm: kms: constrain connector encoder attachment
Date: Wed, 26 Aug 2026 17:31:34 +0100
Message-ID: <20260826163359.4998-4-mike@fireburn.co.uk>
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

drm_connector_attach_encoder() requires both objects to belong to the same
DRM device. The safe wrapper previously accepted any AsRawEncoder,
including an encoder from another driver or device.

Accept only an UnregisteredEncoder from the same KMS driver and reject a
different device instance before entering C.

Fixes: 322a9b8d699b ("rust: drm/kms: Add UnregisteredConnector::attach_encoder()")

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/connector.rs | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index 78b08b94587b..b36d138ae950 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -404,11 +404,22 @@ pub fn new<'a>(
 
     /// Attach an encoder to this [`Connector`].
     #[must_use]
-    pub fn attach_encoder(&self, encoder: &impl AsRawEncoder) -> Result {
+    pub fn attach_encoder<E>(&self, encoder: &UnregisteredEncoder<E>) -> Result
+    where
+        E: DriverEncoder<Driver = T::Driver>,
+    {
+        // SAFETY: Both unregistered objects have been initialized, so their parent device
+        // pointers are valid and invariant for their lifetimes.
+        let same_device = unsafe { (*self.as_raw()).dev == (*encoder.as_raw()).dev };
+        if !same_device {
+            return Err(EINVAL);
+        }
+
         // SAFETY:
-        // - Both as_raw() calls are guaranteed to return a valid pointer
-        // - We're guaranteed this connector is not registered via our type invariants, thus this
-        //   function is safe to call
+        // - Both `as_raw()` calls return valid pointers.
+        // - The generic bound and check above prove that both objects belong to the same driver
+        //   and device.
+        // - `self` is unregistered, as required by the C API.
         to_result(unsafe {
             bindings::drm_connector_attach_encoder(self.as_raw(), encoder.as_raw())
         })
