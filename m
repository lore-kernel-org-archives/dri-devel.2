Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42B606A31E
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=UKJJEln7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE3D10E21B;
	Sun, 22 Nov 2026 22:15:10 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A61310E21B
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 22:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=jgxZ5udoHe2NUzwiDrLdSwF/Zqy5q5silmN63zU/Dts=; t=1795385703; x=2110745703; 
 b=UKJJEln7mu6fdEO80EAIwCBdugqZ4RmL7VcNOjKc6jUpV8TP4QKwWY2cv++zWU9wKTeVmG9iRmt
 uH4QHG6L/wlTIh0d9YFeko/eH5ABa9NpGIuX8jZjxLuaQIg4GZkUr/S4kW6oq5ghz7voEYspPPPbn
 8PxKKubtcsqaVrGM3+43cf3sHoW1HP3tNBG7HOV3QyN3OGaME8Zsg3JDuvcwH3N7Vvt2eKo9M1+98
 NM0O/bJlB8NclfN+dAOpesIDsrmm0saGGI9I/6FDcg+8ZiVRZKZyi5E5eP5rC8tdZ5s+fw7s0A7xJ
 w/nzc4idQjCAcz1aWXBHNgATUQiWImXHCaMw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVFps-00000002j1Q-0Y1Z; Sun, 22 Nov 2026 23:15:00 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/4] drm/panfrost,panthor: Refuse to export WB_MMAP BOs
Date: Sun, 22 Nov 2026 19:14:48 -0300
Message-Id: <20261122-pan-drop-dma-buf-hooks-v2-0-2ed42dce9db6@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7RimxmJdcQ/DokAHJgptWiUaw
 t2tXMDle8l/f4XkorgE12KF6BZJ4ucM6lBAN9p5cCh9ZlCl0kRkMNgZ++gD9pPF9sU4en9PaC5
 cMRk+tWeCPA7Rsbz38K3JPEp6+vjZfxb62b/JhbBE3WkmrYyr2NQy2IfYY+cnaLZt+wJWNjcQv
 QAAAA==
X-Change-ID: 20261119-pan-drop-dma-buf-hooks-98f7f19f3b51
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Karunika Choo <karunika.choo@arm.com>, 
 Lukas Zapolskas <lukas.zapolskas@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2877; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=3lRtVBgzw6syYBRQqdWMkBG3bVDnK4PN2Zf0ux5UNxM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBrA2ldx/XSGCfRb9QAwtp7Lb6ZPPIVNh1eJ2Ung
 dIJHJE82VWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCawNpXQAKCRA/8w6Kdoj6
 qqPeB/9SRTOzmC23vEQnhIyQLjn5kRofzayExYFoI9fCkfS2AMULD0F3K7hcGUHXaycJjAr7NK+
 z0nVWw9fbxDbJS+W7O1zV3aQalqbeZcpv9/qDsDW6nycnaENtH5y0HMb4YYAE0bqk5Hn+A22wKw
 oVeDSL0fVLbPhXPmnKqBMV6sU/Ka0aOHAXRetcdNG1KEgg4YrN7UzxBG17Zs3tIIlqjDIlOntaR
 aKCyIBOi6PoWJXeiHfK5J5/i1VdtALrNhc0SEGd2kvFiM525+SlkZnbAkYGQTYXL+HqvQNbZtcR
 Hjt+OV72WhMX66PPvBem+ZoVSmeWhSqWy24xMQU7csf16jP4
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series follows up on the discussion in the V3D cached maps series
[1], about how to handle CPU-cached BOs that are shared through dma-buf.

As pointed by Faith and Boris, when a buffer is shared through dma-buf,
there's no way to ensure that a client will properly bracket their CPU
accesses with DMA_BUF_IOCTL_SYNC. With WC mappings, waiting on fences is
enough to guarantee consistency. However, with WB mappings, a missed sync
can leave dirty cache lines behind, which another client can end up
writing over.

PanVK already keeps WB_MMAP BOs private, so this series only makes the
kernel enforce the same policy on Panfrost and Panthor. As discussed in
v1, the custom dma_buf_ops are kept, as they're still needed for
IO-coherent GPUs.

- Patch 1 adds the drm_gem_shmem_sync() helper, taken from [2], with
  locking around the sgt walk and handling of unbacked/purged BOs.
- Patch 2 converts Panfrost to drm_gem_shmem_sync(). V3D will also use it
  to implement its cached maps, which I'll send in a separate series.
- Patches 3 and 4 refuse to export WB_MMAP BOs in Panfrost and Panthor.

The Panthor changes were tested locally on hardware and the series was
also tested in Mesa CI (Panfrost and Panthor) without regressions.

[1] https://lore.kernel.org/dri-devel/20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com/T/
[2] https://lore.kernel.org/dri-devel/20251126124455.3656651-1-boris.brezillon@collabora.com/

Best regards,
- Maíra

---
Changes in v2:

- Dropped the patches "[PATCH 3/6] drm/panfrost: Drop custom dma_buf_ops"
  and "[PATCH 6/6] drm/panthor: Drop custom dma_buf_ops" (Boris Brezillon)
- [1/4] Dropped Steven Price's R-b, as the locking changed.
- [1/4] Added a resv lock across the sgt walk, similarly to what's done in
  panthor_gem_sync() (Sashiko)
- [1/4] Stop populating pages on purged or unbacked BOs (Sashiko)
- [2/4] Move right after the drm_gem_shmem_sync() patch, add Fixes: tag
  and reword the commit message.
- Link to v1: https://lore.kernel.org/r/20261119-pan-drop-dma-buf-hooks-v1-0-6c6f1629e7f9@igalia.com

---
Faith Ekstrand (1):
      drm/shmem: Add a drm_gem_shmem_sync() helper

Maíra Canal (3):
      drm/panfrost: Use drm_gem_shmem_sync()
      drm/panfrost: Refuse to export WB_MMAP BOs
      drm/panthor: Refuse to export WB_MMAP BOs

 drivers/gpu/drm/drm_gem_shmem_helper.c  | 108 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gem.c |  78 +++--------------------
 drivers/gpu/drm/panthor/panthor_gem.c   |   4 ++
 include/drm/drm_gem_shmem_helper.h      |  17 +++++
 include/uapi/drm/panfrost_drm.h         |   1 +
 include/uapi/drm/panthor_drm.h          |   2 +
 6 files changed, 141 insertions(+), 69 deletions(-)
---
base-commit: ce335050d9a670491139f5e4337934c3e963e7f4
change-id: 20261119-pan-drop-dma-buf-hooks-98f7f19f3b51

