Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E14C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4AB10ED71;
	Wed, 26 Aug 2026 16:37:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="e6BHfIWc";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A545E10ED71
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:37:04 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so1163535e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762223; x=1788367023;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mdJB+7gpvS5WCvpUSsJAui6rgsKkc8CSJW/uARo52jk=;
 b=e6BHfIWcrCROcSMBv+GrWezKI6QkVZ7RyisZENV6ZoLRQlEPg6iXaRg9AQ99zmAezv
 yrAk5QGn5BFhCESLkp4gubsC6dwTrsLOLAdl7Cp0JS/GVOIa7rsBYoCNWLGFaDKzjUKc
 e8L6zUJeF0Yhn2jW3YteTniHR9PJNJSrg/RyJqhnZRrSQsiEtOAN4iO8IQxgA1e0vzck
 LSDNCMMg5nfdNPTMeNXq0RlMKKxN9Hv3JtqmmHRqtulVmEPdxOV/DgNBnbM8zeciiIzN
 91MmS7FDDIaHX3D/Tauxk4PakkB6yl+E4D1PIu0ThIlf7MQUo3doqAjOk7JxuwCz0dXq
 uzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762223; x=1788367023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mdJB+7gpvS5WCvpUSsJAui6rgsKkc8CSJW/uARo52jk=;
 b=qKHcpavnz25kssE+E554/Tu8r/+sWwIVeawwy/cap/w1b9KgR88qHrI3UArGdOnvn+
 6Fzagq7777vZEw09FsX1L/NRr4lNkn9bsqsP13YX5qE6xyDbTscNXJ288kkMIMShcKne
 xQOQ3KJQMBxPE9GzuLcP5VFoYPtlw9pQm0JlcS+FLtoVJ+dJCjuPf5ZLH1f9TEs+DsFs
 1GZ3qctpM7Biv/xzIzxzfuM6CiNCATjhMPSjh7RQtZBx8qrzeOPGpnjROV/TQLEf8aHb
 jXKn91q6UVzphWfTciB9mXgeBI0G8Vd1o9pqo4J0g/J4KELfkYuFjHClQLnrBLxhmjO6
 fg+A==
X-Gm-Message-State: AFuF++n8jXBxpQMEWcIx0jcnptgO/86Ge0VwKkXHdDZ6ZXdSisBZ+vEg
 S4mRf/ghGxhR2eH7cKANWxS5ik9vE4CIupENozncq2toDx2959VhkgMud/ijV59JzIcGva2hIOz
 c5qx2CvUa
X-Gm-Gg: AR+sD1095o5362X1a63lA+sI6ZJ4NbJ15kMqQ5ZcFT63Ux5BsyHgr6A2zFeTcRS3S2h
 E9JpAZDDSilrucLTf1tlQAFcy6mR2UKtOsVut1U5lDkA9f/b0/W3A63kO9hcLoECSEsx/2fEGKK
 ievkLeM/I7YC+VTuj0Ga80/YLpjWYe/V3sbhF5HJq/M/HShf9CeTC/jpamnvP7DOEMdkJbPs1zA
 S36y607BzHVulaH+3BYhaJP6vS+cACXIc2koWbcIa3T4SEfqGa1hlkjWve8JVvGFw9x1uy3KTUv
 mGg1Ux9NCU7Y0mrhbwRG6tF+D76JD8aAiwshG8uDgbtifSzP1HSjShHr9Amg4gLute14u+FWx+y
 k1WsMkAKf2odRa2RKdYX70pFp/qXqK4L4d252E6Is3imwWw1dxKICVytoL7rPlRPBMQEQhkUf6A
 9CaOigKcJJYPrK2nrO4rcn8ojCO31iIkFsPHJ1SbWdZx/ncSgpZ4lAaH18HUs9nOHxdE/1B3YoO
 HNkHzCEBkru1Vy8YqGJNd155MBGkpGygejQMA==
X-Received: by 2002:a05:600c:8486:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-499dc6e1267mr91011085e9.3.1787762223039; 
 Wed, 26 Aug 2026 09:37:03 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:37:02 -0700 (PDT)
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
 Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 23/23] rust: drm: kms: expose a connector's requested link
 depth
Date: Wed, 26 Aug 2026 17:31:54 +0100
Message-ID: <20260826163359.4998-24-mike@fireburn.co.uk>
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

`max bpc` is how userspace asks for the number of bits the link
carries, and it is deliberately independent of the framebuffer's
format: scanning out an eight-bit surface over a ten-bit link is the
ordinary case. A driver could attach the property but had no way to
read back what was asked for, so the request could only be ignored.

Add the accessor, and make the linear format modifier nameable outside
the crate so a driver that accepts only linear scanout can say so in
its plane's modifier list rather than leaving userspace to infer it.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/fourcc.rs        |  5 ++++-
 rust/kernel/drm/kms/connector.rs | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/fourcc.rs b/rust/kernel/drm/fourcc.rs
index 010823c4c86c..3a68af66f236 100644
--- a/rust/kernel/drm/fourcc.rs
+++ b/rust/kernel/drm/fourcc.rs
@@ -13,7 +13,10 @@ const fn fourcc_code(a: u8, b: u8, c: u8, d: u8) -> u32 {
 // function-like macros in bindgen yet.
 pub(crate) const FORMAT_MOD_INVALID: u64 = 0xffffffffffffff;
 /// Linear framebuffer layout (`DRM_FORMAT_MOD_LINEAR`).
-pub(crate) const FORMAT_MOD_LINEAR: u64 = 0;
+///
+/// A driver that accepts only linear scanout has to say so through the plane's format-modifier
+/// list, or userspace sees no `IN_FORMATS` property and has to guess what the plane will take.
+pub const FORMAT_MOD_LINEAR: u64 = 0;
 
 /// 32 bpp RGB with unused alpha.
 pub const XRGB8888: u32 = fourcc_code(b'X', b'R', b'2', b'4');
diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index 231857cc1f20..633f4f76a610 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -935,6 +935,22 @@ fn colorspace(&self) -> u32 {
         self.as_raw().colorspace
     }
 
+    /// The bits per colour channel userspace has asked the link to carry, through the `max bpc`
+    /// property.
+    ///
+    /// This is a property of the *link*, not of the framebuffer: userspace routinely scans out an
+    /// eight-bit surface over a ten-bit link, and a driver that derives its output depth from the
+    /// framebuffer format alone silently ignores what was asked for.
+    ///
+    /// Meaningful only on a connector that
+    /// [`UnregisteredConnector::attach_max_bpc_property`] was called for; everything else leaves
+    /// it at zero.
+    fn max_requested_bpc(&self) -> u32 {
+        // `max_requested_bpc` is an `unsigned int` clamped by DRM to the range the driver gave
+        // `drm_connector_attach_max_bpc_property()`, so it needs no validation here.
+        self.as_raw().max_requested_bpc as u32
+    }
+
     /// The electro-optical transfer function from the `HDR_OUTPUT_METADATA` blob, or [`None`] if
     /// userspace has not set one.
     ///
