Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5D606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=cyUpWQ0N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 147191126F0;
	Thu, 19 Nov 2026 19:40:29 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB4310E861
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=em6IWM+LhxPNXSER8DBTTCbI5nQJm2m65Pe2Ze4oIM8=; t=1795117208; x=2110477208; 
 b=cyUpWQ0NlOV2sMHYV8HpWwptsuIh163fqmi57Df1T/JgtrzVyPdmeC2lm8hSu2GjJdhv5wWeih8
 WuczO2Rb0hESvMFJEgzdGz2wjJHKaNsEcYyZewBocnGHb80lTE1QvRI6xQlLPpK0b6fLMVtj0igIm
 R3Ul67Uu7Poa2AgaKMtqQbkTKsDyq8J+b985TON9XaIS6IgJOQXicyX0ts9nbrsW8jwPXeTEaIbNY
 QTaYTya/bcECO7lgG3BdP240pDGa0SgITDMFc/bjiSDki6tdBWdpzFhrHRydeZJbndHdkdnelJBcK
 NDvjOkPhUXK8Jw7foHtCNF+B9yoB3BouE7Yg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xU7zK-00000001bU7-0Car; Thu, 19 Nov 2026 20:40:06 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 19 Nov 2026 16:38:20 -0300
Subject: [PATCH 5/6] drm/panthor: Refuse to export WB_MMAP BOs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261119-pan-drop-dma-buf-hooks-v1-5-6c6f1629e7f9@igalia.com>
References: <20261119-pan-drop-dma-buf-hooks-v1-0-6c6f1629e7f9@igalia.com>
In-Reply-To: <20261119-pan-drop-dma-buf-hooks-v1-0-6c6f1629e7f9@igalia.com>
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
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFn/A/K3ng2sLDV/E5V2vE4toM07eO/Om098eKt+1/PIH
 H068ap8J6MxCwMjF4OsmCLLjyextYxi5eyay8ovwgxiZQKZwsDFKQATeXye/X9iaVhDWqOo4cfm
 bFdGGR0f00hfdrXQoO2Lk+YIRfRnqbPOvfP79fPqGfc2cjzK2O5+2GD7pslFuw/ULlrD75DoXh+
 f3chUa2N1eoF6pbfYWYvm5pjN+2XZ5JT2+uT4lXn0lhddq7oXbpOXpdTS0P0y/sGT2oV5XR+a+X
 fEHVrUyHOu+44Gx/cVpWLuXCH2Exa23OP7vmzObG1l29lfzO5HblW7JTMjPaiQ6xUbI1OqalIOZ
 0FZsb5H2G/PAGbBCL9Vmu4ZT3te3VKw6mDO59yb/1HEMkrazfWJ/Mm3jZpasvbdKVoFFcq2UzuP
 LT30dOUURrUnRk2lhgafrJlcP+07ef/MxYkGDZOVBQE=
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

