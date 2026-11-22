Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AE7606A31D
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=m4t5bSJd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF3E10E6C1;
	Sun, 22 Nov 2026 22:15:38 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D2C10E6C1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 22:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=em6IWM+LhxPNXSER8DBTTCbI5nQJm2m65Pe2Ze4oIM8=; t=1795385727; x=2110745727; 
 b=m4t5bSJdiNtUTNRHKf/OGbxgzXPc2HI71PHLpasHRztmdvxI2wTbeQoz/EiORfCZu7gEgkLM1Bt
 9eDK3+0MIIy7GAocX32Z7gIfLc7WfgF/PWEnbioXlGrgJnv3ClrVGa7s1iU5O/OTbGVnAeEQ/isRd
 N2yOG3AtFi9N/hK0vuZ+gXGfpEjZB5KLAZIZV3B4DhLkMI+9QzJYs7Kg4eqfuc3TywVXLPGlNYsx2
 ryzQ9l3meatpgStFIrqEQ9JOCUxtBwWdxCoypgL9KGtjmYevqkDPzeoeEnEZL8S+vGxfPmSLMMFOX
 ABT7N9g19cXSqd2HlA20j2v+YNm5Jv9R2Qyw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVFqH-00000002j1Q-2tTO; Sun, 22 Nov 2026 23:15:25 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 22 Nov 2026 19:14:52 -0300
Subject: [PATCH v2 4/4] drm/panthor: Refuse to export WB_MMAP BOs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261122-pan-drop-dma-buf-hooks-v2-4-2ed42dce9db6@igalia.com>
References: <20261122-pan-drop-dma-buf-hooks-v2-0-2ed42dce9db6@igalia.com>
In-Reply-To: <20261122-pan-drop-dma-buf-hooks-v2-0-2ed42dce9db6@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=2T5m7AnEjwVDczwlWuGW9Tmdh5xr5mIrjKjHYPYDvnI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBrA2le1u6O/XZul9pOsFgBhIdb06j8VZgXZPE4a
 OcPV42PCLWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCawNpXgAKCRA/8w6Kdoj6
 qvkQCACxWT6NX9rZPVOhcM78V9cYzzGeLGOtnEJS/4Y9yzvrLMzCVhlvAP6RX6XXKIBr6tiBcum
 unNyEhkmbYrlOaAIxCfdSznhEa7+LGO9bH6r8O7PMzC2AP0JDY45nWK0Nxm6BpIj8/S3lZd6NZZ
 n+EfIPZE9o9KSoffv0Gl0n3Um7q4tdjBTI+NljLknuhgagD875whoib0vMKv04Ci5fMjoClNO//
 5Wmn6CTAU2NdNYaUYnCHrXo9jGofKaHSNOQm4WlILDOrWkIXpU5/qyLbWYTkjEyIIlszbWe/zrG
 dlNU1hF5WJOo9+2IvllsvvEQnm1NL5gg+Zpx7+TfrhWZ/H3V
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a buffer is shared through dma-buf, clients are expected to bracket
their CPU accesses with DMA_BUF_IOCTL_SYNC, but there's no way to ensure
they do. With WC mappings, there are no CPU cache lines to maintain, so
waiting on fences is enough. With WB mappings, a missed sync can leave
dirty cache lines behind, which may later be written back over data the
GPU produced for another client.

To avoid this, don't allow WB_MMAP BOs to be shared. PanVK already keeps
WB_MMAP BOs private, so this makes the kernel enforce the same policy.

Suggested-by: Faith Ekstrand <faith.ekstrand@collabora.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 4 ++++
 include/uapi/drm/panthor_drm.h        | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 22b57ab6f929..730567d97f46 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -577,6 +577,10 @@ panthor_gem_prime_export(struct drm_gem_object *obj, int flags)
 	if (to_panthor_bo(obj)->exclusive_vm_root_gem)
 		return ERR_PTR(-EINVAL);
 
+	/* WB_MMAP BOs can't be shared. */
+	if (to_panthor_bo(obj)->flags & DRM_PANTHOR_BO_WB_MMAP)
+		return ERR_PTR(-EINVAL);
+
 	return drm_gem_dmabuf_export(dev, &exp_info);
 }
 
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index a2ff0f4ec691..8f3a3e680264 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -771,6 +771,8 @@ enum drm_panthor_bo_flags {
 	 * CPU map the buffer object in userspace by forcing the "Write-Back
 	 * Cacheable" cacheability attribute. The mapping otherwise uses the
 	 * "Non-Cacheable" attribute if the GPU is not IO coherent.
+	 *
+	 * Buffer objects created with this flag can't be exported.
 	 */
 	DRM_PANTHOR_BO_WB_MMAP = (1 << 1),
 };

-- 
2.56.0

