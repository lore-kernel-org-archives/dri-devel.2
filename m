Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FA8606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+cnRP2X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB6C10E1E3;
	Mon, 19 Oct 2026 21:26:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67DC410E1E3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:25:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DE85160DB0;
 Mon, 19 Oct 2026 21:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6141F000C4;
 Mon, 19 Oct 2026 21:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792445158;
 bh=3aisROB166Q3kx4N6SPd461R/3NhpDE3Kj+7GC5Cgcc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g+cnRP2X/ie/vfX70lP7L9ZBLLKU6Rob8cpg60l7XnS3ZcaOCqQUN8A8cC4RV5mh+
 uCzWn9Pspvk8V36STY9I2su3JmHE39TIbILicseeJfsM6Dr2SoIj9302R30ANYcMFN
 Lgp1NbgCL1JCvr6ehMW6lBlZKK+IpORQ2K4ldK+qdC+Ll/W8qYHsS5RabdOjOWx41i
 V/GMulZ3p/iO5aQhk3BymS5dV2kKjjwBpBWD3puNccSnuY5ezedNf0gYs0q9spaoh7
 bNDfULjSFnrIf6vHr11L31HAWycBMMN8H1Y9iX3Q0eeA6mpCcCvHtBQBWdLSKHNmd/
 cZ1hDJkNkdQPQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, daniel.almeida@collabora.com, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, jhubbard@nvidia.com,
 apopple@nvidia.com, ecourtney@nvidia.com, lyude@redhat.com,
 kherbst@redhat.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 3/3] drm/nova: require explicit opt-in to unstable uAPI
Date: Mon, 19 Oct 2026 23:24:47 +0200
Message-ID: <20261019212535.88390-4-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019212535.88390-1-dakr@kernel.org>
References: <20261019212535.88390-1-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nova and its uAPI are under active upstream development. Require users
to acknowledge that the uAPI is not yet stable and may change
incompatibly before enabling the driver.

Refuse to load unless acknowledge_unstable_uapi=1 is set, and taint the
kernel when enabled. This keeps use of the unstable interfaces an
explicit opt-in while they are developed upstream.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/Kconfig | 11 +++++++-
 drivers/gpu/drm/nova/nova.rs | 55 ++++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nova/Kconfig b/drivers/gpu/drm/nova/Kconfig
index ba16c74401f8..2cb62517b2f9 100644
--- a/drivers/gpu/drm/nova/Kconfig
+++ b/drivers/gpu/drm/nova/Kconfig
@@ -12,6 +12,15 @@ config DRM_NOVA
 	  Choose this if you want to build the Nova DRM driver for Nvidia
 	  GSP-based GPUs.
 
-	  This driver is work in progress and may not be functional.
+	  This driver is under active upstream development and may not be
+	  functional. Its uAPI is intended to be developed upstream alongside
+	  the driver and is not yet stable. It may change incompatibly during
+	  development.
+
+	  Loading requires the acknowledge_unstable_uapi=1 module parameter, or
+	  nova-drm.acknowledge_unstable_uapi=1 on the kernel command line when
+	  built in.
+
+	  Enabling the driver taints the kernel.
 
 	  If M is selected, the module will be called nova-drm.
diff --git a/drivers/gpu/drm/nova/nova.rs b/drivers/gpu/drm/nova/nova.rs
index 1fd454c7e0df..ad68f6e1a613 100644
--- a/drivers/gpu/drm/nova/nova.rs
+++ b/drivers/gpu/drm/nova/nova.rs
@@ -2,16 +2,67 @@
 
 //! Nova DRM Driver
 
+use kernel::{
+    auxiliary,
+    driver::Registration,
+    panic::{
+        self,
+        Lockdep,
+        Taint, //
+    },
+    prelude::*,
+    InPlaceModule, //
+};
+
 mod driver;
 mod file;
 mod gem;
 
 use crate::driver::NovaDriver;
 
-kernel::module_auxiliary_driver! {
-    type: NovaDriver,
+module! {
+    type: NovaModule,
     name: "nova-drm",
     authors: ["Danilo Krummrich"],
     description: "Nova GPU driver",
     license: "GPL v2",
+    params: {
+        acknowledge_unstable_uapi: bool {
+            default: false,
+            description: "Acknowledge that Nova and its uAPI are under active upstream development \
+                          and the uAPI may change incompatibly; enable the driver (taints kernel)",
+        },
+    },
+}
+
+#[pin_data]
+struct NovaModule {
+    #[pin]
+    _driver: Registration<auxiliary::Adapter<NovaDriver>>,
+}
+
+impl NovaModule {
+    fn check_unstable_uapi() -> Result {
+        pr_warn!("Nova and its uAPI are under active upstream development\n");
+
+        if !module_parameters::acknowledge_unstable_uapi.value() {
+            pr_err!("Driver disabled: Nova's uAPI is unstable and may change incompatibly\n");
+            pr_info!("Set nova-drm.acknowledge_unstable_uapi=1 to enable (taints kernel)\n");
+            return Err(EPERM);
+        }
+
+        pr_warn!("Unstable uAPI enabled; userspace compatibility is not guaranteed\n");
+        panic::add_taint(Taint::User, Lockdep::StillOk);
+
+        Ok(())
+    }
+}
+
+impl InPlaceModule for NovaModule {
+    fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            _: { Self::check_unstable_uapi()? },
+            _driver <- Registration::new(<Self as kernel::ModuleMetadata>::NAME, module),
+        })
+    }
 }
-- 
2.56.0

