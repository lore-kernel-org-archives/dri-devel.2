Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0243606A323
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djNs4lHS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BC110E1BD;
	Mon, 19 Oct 2026 21:25:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5013C10E1BD
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:25:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ADA12602BE;
 Mon, 19 Oct 2026 21:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF591F000C5;
 Mon, 19 Oct 2026 21:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792445148;
 bh=d9aoKjxS6qhYVI6w51sbVkLLqubyF2HTpok40ksJGY8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=djNs4lHSiBJXqiXNLNHwiofqO90HXeODn+md15Q5GFuw7nOB9kkVhH5OQXoYC6x1c
 pOcjwzEhz2l5lirKTPpBXpKD38kHkZBbw+m6I6yGwV8HEADmRAfNNgZ+jUncrEWIuU
 mmozb32uuOtHbv17zL+tjxkRznZLKm6s8IVSWnFDR5dVWbKqPlTmFZe6Hmx9wHCiGr
 EeIPnWWRcs8iAj9r7fj71bv94cvOlwec/UA5gu5Mh410jeb3neqDC44fynTVErJ0c4
 WEmBL24KQLRGBJapYBv8PI9hv1l9AHkR4V8SbTSLBy0nqTOC+DNNdVuKQe2rt1F6hL
 LrpL1K+CuWB+g==
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
Subject: [PATCH 1/3] drm/nova: mark the uAPI header as unstable
Date: Mon, 19 Oct 2026 23:24:45 +0200
Message-ID: <20261019212535.88390-2-dakr@kernel.org>
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

The header already documents that its uAPI is unstable and intended for
development. It may change incompatibly as it is developed upstream.
Rename it to nova_drm_unstable.h and move it out of include/uapi/ to
make this more explicit.

As individual interfaces become stable, move them to
include/uapi/drm/nova_drm.h.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/nova_drm_unstable.h | 212 +++++++++++++++++++++++
 include/uapi/drm/nova_drm.h              | 204 +---------------------
 rust/uapi/uapi_helper.h                  |   2 +
 3 files changed, 217 insertions(+), 201 deletions(-)
 create mode 100644 drivers/gpu/drm/nova/nova_drm_unstable.h

diff --git a/drivers/gpu/drm/nova/nova_drm_unstable.h b/drivers/gpu/drm/nova/nova_drm_unstable.h
new file mode 100644
index 000000000000..3577dede15a6
--- /dev/null
+++ b/drivers/gpu/drm/nova/nova_drm_unstable.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef __NOVA_DRM_UNSTABLE_H__
+#define __NOVA_DRM_UNSTABLE_H__
+
+#include <drm/drm.h>
+
+/* DISCLAIMER: Do not use, this is not a stable uAPI.
+ *
+ * This uAPI serves only testing purposes as long as this driver is still in
+ * development. It is required to implement and test infrastructure which is
+ * upstreamed in the context of this driver. See also [1].
+ *
+ * The uAPI in this file may change incompatibly. Stable interfaces should
+ * be moved to include/uapi/drm/nova_drm.h.
+ *
+ * [1] https://lore.kernel.org/dri-devel/Zfsj0_tb-0-tNrJy@cassiopeiae/
+ */
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+/**
+ * enum drm_nova_architecture - GPU architecture identifier
+ */
+enum drm_nova_architecture {
+	NOVA_DRM_ARCHITECTURE_TURING		= 0x16,
+	NOVA_DRM_ARCHITECTURE_AMPERE		= 0x17,
+	NOVA_DRM_ARCHITECTURE_HOPPER		= 0x18,
+	NOVA_DRM_ARCHITECTURE_ADA		= 0x19,
+	NOVA_DRM_ARCHITECTURE_BLACKWELL_GB10X	= 0x1a,
+	NOVA_DRM_ARCHITECTURE_BLACKWELL_GB20X	= 0x1b,
+};
+
+/**
+ * enum drm_nova_chipid - opaque GPU chip identifier
+ *
+ * These values identify the chip a GPU is based on. They are otherwise
+ * opaque: userspace must not assume the values carry any particular meaning
+ * or encoding, only that they may be compared against this enum.
+ */
+enum drm_nova_chipid {
+	/* Turing */
+	NOVA_DRM_CHIPID_TU102			= 0x162,
+	NOVA_DRM_CHIPID_TU104			= 0x164,
+	NOVA_DRM_CHIPID_TU106			= 0x166,
+	NOVA_DRM_CHIPID_TU117			= 0x167,
+	NOVA_DRM_CHIPID_TU116			= 0x168,
+	/* Ampere */
+	NOVA_DRM_CHIPID_GA100			= 0x170,
+	NOVA_DRM_CHIPID_GA102			= 0x172,
+	NOVA_DRM_CHIPID_GA103			= 0x173,
+	NOVA_DRM_CHIPID_GA104			= 0x174,
+	NOVA_DRM_CHIPID_GA106			= 0x176,
+	NOVA_DRM_CHIPID_GA107			= 0x177,
+	/* Hopper */
+	NOVA_DRM_CHIPID_GH100			= 0x180,
+	/* Ada */
+	NOVA_DRM_CHIPID_AD102			= 0x192,
+	NOVA_DRM_CHIPID_AD103			= 0x193,
+	NOVA_DRM_CHIPID_AD104			= 0x194,
+	NOVA_DRM_CHIPID_AD106			= 0x196,
+	NOVA_DRM_CHIPID_AD107			= 0x197,
+	/* Blackwell GB10x */
+	NOVA_DRM_CHIPID_GB100			= 0x1a0,
+	NOVA_DRM_CHIPID_GB102			= 0x1a2,
+	/* Blackwell GB20x */
+	NOVA_DRM_CHIPID_GB202			= 0x1b2,
+	NOVA_DRM_CHIPID_GB203			= 0x1b3,
+	NOVA_DRM_CHIPID_GB205			= 0x1b5,
+	NOVA_DRM_CHIPID_GB206			= 0x1b6,
+	NOVA_DRM_CHIPID_GB207			= 0x1b7,
+};
+
+/**
+ * struct drm_nova_gem_create - create a new DRM GEM object
+ */
+struct drm_nova_gem_create {
+	/**
+	 * @handle: The handle of the new DRM GEM object.
+	 */
+	__u32 handle;
+
+	/**
+	 * @pad: 32 bit padding, should be 0.
+	 */
+	__u32 pad;
+
+	/**
+	 * @size: The size of the new DRM GEM object.
+	 */
+	__u64 size;
+};
+
+/**
+ * struct drm_nova_gem_info - query DRM GEM object metadata
+ */
+struct drm_nova_gem_info {
+	/**
+	 * @handle: The handle of the DRM GEM object to query.
+	 */
+	__u32 handle;
+
+	/**
+	 * @pad: 32 bit padding, should be 0.
+	 */
+	__u32 pad;
+
+	/**
+	 * @size: The size of the DRM GEM object.
+	 */
+	__u64 size;
+};
+
+/**
+ * struct drm_nova_info - query device information
+ */
+struct drm_nova_info {
+	/**
+	 * @id: The identifier of the information to query.
+	 */
+	__u32 id;
+
+	/**
+	 * @size: The amount of space allocated by userspace at @data. The kernel
+	 * will return the number of bytes it wrote, or the size of the queried
+	 * information structure if @data is NULL.
+	 */
+	__u32 size;
+
+	/**
+	 * @data: Pointer to the userspace buffer into which the queried
+	 * information will be written. May be NULL, in which case nothing is
+	 * written and @size is set to the size of the information structure so
+	 * userspace can allocate a suitably sized buffer.
+	 */
+	__u64 data;
+};
+
+/**
+ * DRM_NOVA_INFO_GPU
+ *
+ * Query GPU information. The result is returned in a
+ * &struct drm_nova_info_gpu.
+ */
+#define DRM_NOVA_INFO_GPU		0x00
+
+/**
+ * struct drm_nova_info_gpu - GPU information
+ */
+struct drm_nova_info_gpu {
+	/**
+	 * @architecture: GPU architecture identifier.
+	 *
+	 * See &enum drm_nova_architecture for currently known architectures.
+	 */
+	__u32 architecture;
+
+	/**
+	 * @chipid: Opaque GPU chip identifier.
+	 *
+	 * See &enum drm_nova_chipid for currently known chips.
+	 */
+	__u32 chipid;
+
+	/**
+	 * @vram_size: Amount of usable FB, excluding GSP carveouts and protected
+	 * regions.
+	 */
+	__u64 vram_size;
+
+	/**
+	 * @vram_bar_size: Size of the PCI BAR aperture used to access VRAM, in bytes.
+	 */
+	__u64 vram_bar_size;
+
+	/**
+	 * @gpu_name: NUL-terminated full GPU name.
+	 */
+	__u8 gpu_name[64];
+
+	/**
+	 * @gpu_short_name: NUL-terminated short GPU name.
+	 */
+	__u8 gpu_short_name[64];
+
+	/**
+	 * @gpu_gid: 16-byte SHA-1 GPU identifier supplied by GSP-RM.
+	 */
+	__u8 gpu_gid[16];
+};
+
+#define DRM_NOVA_INFO			0x00
+#define DRM_NOVA_GEM_CREATE		0x01
+#define DRM_NOVA_GEM_INFO		0x02
+
+/* Note: this is an enum so that it can be resolved by Rust bindgen. */
+enum {
+	DRM_IOCTL_NOVA_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_INFO,
+						   struct drm_nova_info),
+	DRM_IOCTL_NOVA_GEM_CREATE	= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_CREATE,
+						   struct drm_nova_gem_create),
+	DRM_IOCTL_NOVA_GEM_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_INFO,
+						   struct drm_nova_gem_info),
+};
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* __NOVA_DRM_UNSTABLE_H__ */
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index d7017ed17143..ad362301e3b1 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -3,207 +3,9 @@
 #ifndef __NOVA_DRM_H__
 #define __NOVA_DRM_H__
 
-#include "drm.h"
-
-/* DISCLAIMER: Do not use, this is not a stable uAPI.
- *
- * This uAPI serves only testing purposes as long as this driver is still in
- * development. It is required to implement and test infrastructure which is
- * upstreamed in the context of this driver. See also [1].
- *
- * [1] https://lore.kernel.org/dri-devel/Zfsj0_tb-0-tNrJy@cassiopeiae/T/#u
- */
-
-#if defined(__cplusplus)
-extern "C" {
-#endif
-
-/**
- * enum drm_nova_architecture - GPU architecture identifier
- */
-enum drm_nova_architecture {
-	NOVA_DRM_ARCHITECTURE_TURING		= 0x16,
-	NOVA_DRM_ARCHITECTURE_AMPERE		= 0x17,
-	NOVA_DRM_ARCHITECTURE_HOPPER		= 0x18,
-	NOVA_DRM_ARCHITECTURE_ADA		= 0x19,
-	NOVA_DRM_ARCHITECTURE_BLACKWELL_GB10X	= 0x1a,
-	NOVA_DRM_ARCHITECTURE_BLACKWELL_GB20X	= 0x1b,
-};
-
-/**
- * enum drm_nova_chipid - opaque GPU chip identifier
- *
- * These values identify the chip a GPU is based on. They are otherwise
- * opaque: userspace must not assume the values carry any particular meaning
- * or encoding, only that they may be compared against this enum.
- */
-enum drm_nova_chipid {
-	/* Turing */
-	NOVA_DRM_CHIPID_TU102			= 0x162,
-	NOVA_DRM_CHIPID_TU104			= 0x164,
-	NOVA_DRM_CHIPID_TU106			= 0x166,
-	NOVA_DRM_CHIPID_TU117			= 0x167,
-	NOVA_DRM_CHIPID_TU116			= 0x168,
-	/* Ampere */
-	NOVA_DRM_CHIPID_GA100			= 0x170,
-	NOVA_DRM_CHIPID_GA102			= 0x172,
-	NOVA_DRM_CHIPID_GA103			= 0x173,
-	NOVA_DRM_CHIPID_GA104			= 0x174,
-	NOVA_DRM_CHIPID_GA106			= 0x176,
-	NOVA_DRM_CHIPID_GA107			= 0x177,
-	/* Hopper */
-	NOVA_DRM_CHIPID_GH100			= 0x180,
-	/* Ada */
-	NOVA_DRM_CHIPID_AD102			= 0x192,
-	NOVA_DRM_CHIPID_AD103			= 0x193,
-	NOVA_DRM_CHIPID_AD104			= 0x194,
-	NOVA_DRM_CHIPID_AD106			= 0x196,
-	NOVA_DRM_CHIPID_AD107			= 0x197,
-	/* Blackwell GB10x */
-	NOVA_DRM_CHIPID_GB100			= 0x1a0,
-	NOVA_DRM_CHIPID_GB102			= 0x1a2,
-	/* Blackwell GB20x */
-	NOVA_DRM_CHIPID_GB202			= 0x1b2,
-	NOVA_DRM_CHIPID_GB203			= 0x1b3,
-	NOVA_DRM_CHIPID_GB205			= 0x1b5,
-	NOVA_DRM_CHIPID_GB206			= 0x1b6,
-	NOVA_DRM_CHIPID_GB207			= 0x1b7,
-};
-
-/**
- * struct drm_nova_gem_create - create a new DRM GEM object
- */
-struct drm_nova_gem_create {
-	/**
-	 * @handle: The handle of the new DRM GEM object.
-	 */
-	__u32 handle;
-
-	/**
-	 * @pad: 32 bit padding, should be 0.
-	 */
-	__u32 pad;
-
-	/**
-	 * @size: The size of the new DRM GEM object.
-	 */
-	__u64 size;
-};
-
-/**
- * struct drm_nova_gem_info - query DRM GEM object metadata
- */
-struct drm_nova_gem_info {
-	/**
-	 * @handle: The handle of the DRM GEM object to query.
-	 */
-	__u32 handle;
-
-	/**
-	 * @pad: 32 bit padding, should be 0.
-	 */
-	__u32 pad;
-
-	/**
-	 * @size: The size of the DRM GEM obejct.
-	 */
-	__u64 size;
-};
-
-/**
- * struct drm_nova_info - query device information
+/*
+ * Stable Nova uAPI. Interfaces should be moved here from
+ * drivers/gpu/drm/nova/nova_drm_unstable.h as they become stable.
  */
-struct drm_nova_info {
-	/**
-	 * @id: The identifier of the information to query.
-	 */
-	__u32 id;
-
-	/**
-	 * @size: The amount of space allocated by userspace at @data. The kernel
-	 * will return the number of bytes it wrote, or the size of the queried
-	 * information structure if @data is NULL.
-	 */
-	__u32 size;
-
-	/**
-	 * @data: Pointer to the userspace buffer into which the queried
-	 * information will be written. May be NULL, in which case nothing is
-	 * written and @size is set to the size of the information structure so
-	 * userspace can allocate a suitably sized buffer.
-	 */
-	__u64 data;
-};
-
-/**
- * DRM_NOVA_INFO_GPU
- *
- * Query GPU information. The result is returned in a
- * &struct drm_nova_info_gpu.
- */
-#define DRM_NOVA_INFO_GPU		0x00
-
-/**
- * struct drm_nova_info_gpu - GPU information
- */
-struct drm_nova_info_gpu {
-	/**
-	 * @architecture: GPU architecture identifier.
-	 *
-	 * See &enum drm_nova_architecture for currently known architectures.
-	 */
-	__u32 architecture;
-
-	/**
-	 * @chipid: Opaque GPU chip identifier.
-	 *
-	 * See &enum drm_nova_chipid for currently known chips.
-	 */
-	__u32 chipid;
-
-	/**
-	 * @vram_size: Amount of usable FB, excluding GSP carveouts and protected
-	 * regions.
-	 */
-	__u64 vram_size;
-
-	/**
-	 * @vram_bar_size: Size of the PCI BAR aperture used to access VRAM, in bytes.
-	 */
-	__u64 vram_bar_size;
-
-	/**
-	 * @gpu_name: NUL-terminated full GPU name.
-	 */
-	__u8 gpu_name[64];
-
-	/**
-	 * @gpu_short_name: NUL-terminated short GPU name.
-	 */
-	__u8 gpu_short_name[64];
-
-	/**
-	 * @gpu_gid: 16-byte SHA-1 GPU identifier supplied by GSP-RM.
-	 */
-	__u8 gpu_gid[16];
-};
-
-#define DRM_NOVA_INFO			0x00
-#define DRM_NOVA_GEM_CREATE		0x01
-#define DRM_NOVA_GEM_INFO		0x02
-
-/* Note: this is an enum so that it can be resolved by Rust bindgen. */
-enum {
-	DRM_IOCTL_NOVA_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_INFO,
-						   struct drm_nova_info),
-	DRM_IOCTL_NOVA_GEM_CREATE	= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_CREATE,
-						   struct drm_nova_gem_create),
-	DRM_IOCTL_NOVA_GEM_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_INFO,
-						   struct drm_nova_gem_info),
-};
-
-#if defined(__cplusplus)
-}
-#endif
 
 #endif /* __NOVA_DRM_H__ */
diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
index 489748ef642c..44fb6203c0ad 100644
--- a/rust/uapi/uapi_helper.h
+++ b/rust/uapi/uapi_helper.h
@@ -6,6 +6,8 @@
  * Sorted alphabetically.
  */
 
+#include "../../drivers/gpu/drm/nova/nova_drm_unstable.h"
+
 #include <uapi/drm/drm.h>
 #include <uapi/drm/nova_drm.h>
 #include <uapi/drm/panthor_drm.h>
-- 
2.56.0

