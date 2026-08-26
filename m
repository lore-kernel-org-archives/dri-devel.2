Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86408C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C76C810ED5B;
	Wed, 26 Aug 2026 16:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="cgF6G+rz";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF7AF10ED51
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:36:15 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4998590d392so7504085e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762174; x=1788366974;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lg0T4eac/Y9rCRkDaKLkO7bKQ8WziroJWF3w/38eu1A=;
 b=cgF6G+rzskpjhWoswgosQ3ok5e8UtWjHNpc+rwRZCGkrOeLazaOFTM4Ei2y0yFjd50
 jaHOr/0bTRDP1hfdned+I0/utqBeQked2CIL44IsK9JOvmawtXHmA9eWiib0D3vF5ZGz
 ayq1GGWqMRCeF8+zTc5/k62+5eomK8P7tv7aSnKyEnr1zbiu1aSEkXa6USFQPyO5Qr+G
 T7F5OR7IIl8G75sBHIuSF/Rzp7Y3+h4630fEl9ckWczo3sk3iTssLIiBvjjGh1SzIby6
 hwhVLHwIqQaGe3TP5ptx7fUo5CDGJ4ohbFK6Wr6FzB5Hn+PF9BhS3FYy8hhIYP3bbZuk
 JSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762174; x=1788366974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lg0T4eac/Y9rCRkDaKLkO7bKQ8WziroJWF3w/38eu1A=;
 b=WmD+JK1iymDyhU4S2lyTZOkKKQJ8jul0GXUx+wJqlE7lN5vnQqHGx9aNobWvnMghkV
 yQpY8PoAgozCXquoYPFdjMUjCWNY1UTC1ABVW/TfK76+h75BzvmBw1VJoH7NjqVMiaw8
 hm93nX9vQ67ahGPk1xKEpUm7oxiVc8GumnE3fmICc6IHTIMHfKizpI9hJzDhv6W6ZxGy
 54ibU/1PPLBZxdHVqXAmV2tTDM+2f6XiZku7VujzopqocmvzBL3dpiHJoRHzIh5RL3v3
 7Ah/4f84kF5I78UFQemYwziHPc52R6nFPkf4eFLZzlzHpWYXbNDfjVVuzYi5IpTg6+x5
 hstg==
X-Gm-Message-State: AFuF++lUeUitNDtWMY5XH3D3pDs7V3uFOFFg3WVymKiryo9If0ArdkH0
 XCGqL3hNFyJYKQCfwNVGNFY8uvDN3ejR4GP12xWzMDBfUyljwFu186dwvzyKBYoX1qnaVKgRuBF
 gFpBECY32
X-Gm-Gg: AR+sD10cL0tnS9ozOfklbJwoYWOtG/zOa4wMdSTg1zH/1dFSuRWB/SXUBk4mNmSOmRj
 ZkqVkgedkT4sFB/dFe3YBR7Ebd4TvW5BrjRNmnvNbp90WXR4TSyxDj/2M0Jxtjv0noEqgOMvRwX
 Yo8cS6/6LPS8FLY3Kbu5uvHv+5IJZMJdkGs4tV9DmaFwBT0UwUWE0azf2X3SMyJE7XEOdBzLYtZ
 jIZ6jSNFY5QLvr6mfmQVnh/mn4fPJTR1FyqU6txJI8Ng/O4KQYIcu0jyhgRa1xY5d7kvD0tNZHW
 SXi5+03uZM1Wu/cHfCqz2YrvGUdIZmH9pVTkhto20mcLQww1VYQWt618a3+99wKupRswuxQXOri
 dQ+/iZi1zqmm9MNTyM5WnysPzRSY7n7XGhdqtj7p0095RIBxdCSs+b4z/UJLdl+x1lqRkabGz63
 nc8vPUkcDqKOhlLbEJEx2y+EQkIWci/LmBUI1BEtY4vmjRcMdInVBOQlEoNcertaKFsHIytOc0P
 c3hpVOB28CBEEdvAZFaUJd+3vJ8CdCi4W71
X-Received: by 2002:a05:600c:3105:b0:49a:5b88:f54f with SMTP id
 5b1f17b1804b1-49a5b890381mr45490455e9.15.1787762174080; 
 Wed, 26 Aug 2026 09:36:14 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:36:12 -0700 (PDT)
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
Subject: [PATCH v3 16/23] rust: drm: kms: add the plane blend-mode property
Date: Wed, 26 Aug 2026 17:31:47 +0100
Message-ID: <20260826163359.4998-17-mike@fireburn.co.uk>
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

Expose drm_plane_create_blend_mode_property() so Rust KMS drivers
advertising alpha formats can declare how userspace should interpret
the alpha channel.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/plane.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 62de8a1dad19..f148aed812f2 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -459,6 +459,22 @@ pub fn enable_fb_damage_clips(&self) {
         // registration is exactly what this helper is for.
         unsafe { bindings::drm_plane_enable_fb_damage_clips(self.as_raw()) }
     }
+
+    /// Attaches the `pixel blend mode` property to this plane.
+    ///
+    /// `supported_modes` is a bitmask of `BIT(DRM_MODE_BLEND_*)`; `DRM_MODE_BLEND_PREMULTI` must
+    /// always be included. Any plane that advertises a pixel format with an alpha channel is
+    /// required to have this property -- `drm_mode_config_validate()` `WARN`s at registration
+    /// otherwise, because userspace has no way to know how the alpha will be interpreted.
+    ///
+    /// Call this during [`KmsDriver::create_objects`](crate::drm::kms::KmsDriver::create_objects),
+    /// before the device is registered.
+    pub fn create_blend_mode_property(&self, supported_modes: BlendModes) -> Result {
+        // SAFETY: `as_raw()` is a valid, not-yet-registered plane.
+        to_result(unsafe {
+            bindings::drm_plane_create_blend_mode_property(self.as_raw(), supported_modes.bits())
+        })
+    }
 }
 
 /// A trait implemented by any type that acts as a [`struct drm_plane`] interface.
