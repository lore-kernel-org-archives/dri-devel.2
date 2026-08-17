Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190B6C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7918910E767;
	Mon, 17 Aug 2026 11:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Hk+vgNJU";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421AA10E767
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786966893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eye+Imc/4M3S1qY3eqjb5bqUcZ4zH/Id72nS2Qv+iaA=;
 b=Hk+vgNJUJoxKiRTVFFFnCTWszdDov+oeeAtBz/kFpKcHgjl3H0AtvPYkxsGIe5c4hremFy
 YAj4kWyta5MlQnkcnNJBD2mFUPVWhpaPegz0I9tJvOVN9tBlWXVQ6GKWO1q4cWVcjPxn7/
 BOYexGhYP2V3mHQxr5UtlhZDElbC+So=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-NV6esz-kNvSZhbgo-XL6oQ-1; Mon,
 17 Aug 2026 07:41:26 -0400
X-MC-Unique: NV6esz-kNvSZhbgo-XL6oQ-1
X-Mimecast-MFC-AGG-ID: NV6esz-kNvSZhbgo-XL6oQ_1786966883
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6222018001DE; Mon, 17 Aug 2026 11:41:23 +0000 (UTC)
Received: from [192.168.1.153] (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F601422; Mon, 17 Aug 2026 11:41:18 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 17 Aug 2026 13:40:50 +0200
Subject: [PATCH 5/5] rust: drm: add KUnit tests for panel
MIME-Version: 1.0
Message-Id: <20260817-drm_panel_bindings-v1-5-1f974508a31c@redhat.com>
References: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
In-Reply-To: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786966849; l=4048;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=oTsFEHigKZDagVoAOr5IwLFtvYBBWBCaIx6vNhGa6+8=;
 b=6QwxHfNOkF/90Z13R5XUwzf52g9t5Ni068MYbGJL53bg9fbDgOYsTTjn3hXH5mBfps9ZKPqmb
 /2hmNzKs8CTBesR2zwdbQqUwz1eeXDavHMnJRjf4n8IR+assQYCtN9x
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: iy02Pl3OQwdGue6ebjzCySmakvuoEq3UEobKfL2RMwI_1786966883
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Add a test module to verify basic data type conversions
and layout. The tests covers:

- PanelOrientation and ConnectorType: TryFrom conversion for valid
  values and also out-of-range invalid inputs.
- PanelContainer: layout invariants (offset, alignment, size) on which
  Panel::new relies on for memory access.

Tests are gated on CONFIG_RUST_DRM_PANEL_KUNIT_TEST.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 rust/kernel/Kconfig.test | 10 ++++++
 rust/kernel/drm/panel.rs | 87 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/rust/kernel/Kconfig.test b/rust/kernel/Kconfig.test
index e6a5c7a795f0f..397b916dca0d4 100644
--- a/rust/kernel/Kconfig.test
+++ b/rust/kernel/Kconfig.test
@@ -83,4 +83,14 @@ config RUST_BITFIELD_KUNIT_TEST
 
 	  If unsure, say N.
 
+config RUST_DRM_PANEL_KUNIT_TEST
+	bool "KUnit tests for Rust panel API" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables KUnit tests for the Rust panel API.
+	  These are only for development and testing, not for regular
+	  kernel use cases.
+
+	  If unsure, say N.
+
 endif
diff --git a/rust/kernel/drm/panel.rs b/rust/kernel/drm/panel.rs
index 8f87774e06ed7..3da203c39edd6 100644
--- a/rust/kernel/drm/panel.rs
+++ b/rust/kernel/drm/panel.rs
@@ -595,3 +595,90 @@ pub(crate) const fn build() -> &'static bindings::drm_panel_funcs {
         &Self::VTABLE
     }
 }
+
+#[cfg(CONFIG_RUST_DRM_PANEL_KUNIT_TEST)]
+#[macros::kunit_tests(rust_kernel_drm_panel)]
+mod tests {
+    use super::*;
+    use core::mem::{align_of, offset_of, size_of, ManuallyDrop, MaybeUninit};
+
+    struct TestData {
+        _ptr: *const u8,
+        _byte: u8,
+    }
+
+    #[test]
+    fn panel_orientation() {
+        // Test valid values.
+        assert!(matches!(
+            PanelOrientation::try_from(-1),
+            Ok(PanelOrientation::Unknown)
+        ));
+        assert!(matches!(
+            PanelOrientation::try_from(0),
+            Ok(PanelOrientation::Normal)
+        ));
+        assert!(matches!(
+            PanelOrientation::try_from(1),
+            Ok(PanelOrientation::BottomUp)
+        ));
+        assert!(matches!(
+            PanelOrientation::try_from(2),
+            Ok(PanelOrientation::LeftUp)
+        ));
+        assert!(matches!(
+            PanelOrientation::try_from(3),
+            Ok(PanelOrientation::RightUp)
+        ));
+
+        // Test invalid values.
+        assert!(PanelOrientation::try_from(4).is_err());
+        assert!(PanelOrientation::try_from(-2).is_err());
+    }
+
+    #[test]
+    fn connector_type() {
+        // Test valid values.
+        assert!(matches!(
+            ConnectorType::try_from(0),
+            Ok(ConnectorType::Unknown)
+        ));
+        assert!(matches!(
+            ConnectorType::try_from(10),
+            Ok(ConnectorType::DisplayPort)
+        ));
+        assert!(matches!(
+            ConnectorType::try_from(14),
+            Ok(ConnectorType::eDP)
+        ));
+        assert!(matches!(
+            ConnectorType::try_from(16),
+            Ok(ConnectorType::DSI)
+        ));
+        assert!(matches!(
+            ConnectorType::try_from(20),
+            Ok(ConnectorType::USB)
+        ));
+
+        // Test invalid values.
+        assert!(ConnectorType::try_from(21).is_err());
+    }
+
+    #[test]
+    fn panel_container_layout() {
+        assert_eq!(offset_of!(PanelContainer<TestData>, data), 0);
+
+        assert_eq!(size_of::<ManuallyDrop<TestData>>(), size_of::<TestData>());
+
+        let panel_offset = offset_of!(PanelContainer<TestData>, panel);
+        assert_eq!(
+            panel_offset % align_of::<MaybeUninit<bindings::drm_panel>>(),
+            0
+        );
+
+        assert!(
+            size_of::<PanelContainer<TestData>>()
+                >= panel_offset + size_of::<bindings::drm_panel>()
+        );
+    }
+}

-- 
2.55.0

