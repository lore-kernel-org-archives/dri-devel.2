Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B02606A331
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WwDrp5mE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176B010F0E2;
	Thu, 19 Nov 2026 19:40:01 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E869510F0E2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=5j7UK+9n1OMxCIhXE+8rDBZi1XD1YIhndjXYoqIzT4I=; t=1795117188; x=2110477188; 
 b=WwDrp5mEbqhCPjTzUW58JPgpDoQS2+mPxrV5J9+ksv4wnIbw4Jzab63gwVjwmxdUOTaEdUhWVbg
 0xNPpYPHrjVZO8R34es7nFTDppRSF32IeKisZeyLav4f8Sp7Q1h7FfocJfRQQJuqC4V/mAOVsgAsX
 eAoG69Hzvwssvg91dHw3tTj28lsZHReZnfGpEm+AYxjnXkQhRfAIHljFJLdvz9xgalOrZetGAu/+u
 Xd99we9x5vYyinAZXjIJofbUAKWS20vyU3pz1ygnsY3nzdVZPKz8L7gw903FzB7V8PIuXsrVTyarY
 VuOwUFhsskpbBLxO5OomiKFUqgaNmfVWAxdA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xU7z1-00000001bU7-0FUH; Thu, 19 Nov 2026 20:39:47 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 19 Nov 2026 16:38:17 -0300
Subject: [PATCH 2/6] drm/panfrost: Refuse to export WB_MMAP BOs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261119-pan-drop-dma-buf-hooks-v1-2-6c6f1629e7f9@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=kHsCu07vLYzJBS9hhIvAPFACqFoR5A30TlP5GeUsWb0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq/1BvVDYsTX+xABd9QtrYqul92NU0shGKhVSvA
 asEf8U+WqSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCav9QbwAKCRA/8w6Kdoj6
 qlnkCACRRVrN6ceiQIeqLVw+M6hD/XrKRcjFYlJCSFylxu7outx5oqhN7vafO9+yEK6e7cIleKc
 a9dogPW33pdi8uMlCPWBNjTsAF75DSkdF4NKXWUI9EjA8wcOI89Wtcu/y4KEYG3zQqphWrs6fDy
 pXv6wkDv9Yg1nK+QYXFcukTiz1L8TB7p0lQtyC8nfpVLQPxwxSjXWH+r83tco8xqgI9zr9X6nDp
 +SaAeyGnFHYtnruwUi8sWPbE76RgxOOAFqcx8pACzd6Dgx9uy4VUQWlmIDuWvhZjhbMCHPYvUzX
 dA+0RxVybWFJNU/kaHBOiI5SBcdMnWxBW4IhEkKCtDDgld73
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
WB_MMAP BOs private, so this makes the kernel follow the same policy.

Suggested-by: Faith Ekstrand <faith.ekstrand@collabora.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 4 ++++
 include/uapi/drm/panfrost_drm.h         | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 518f24549b9d..c7160223ea17 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -391,6 +391,10 @@ panfrost_gem_prime_export(struct drm_gem_object *obj, int flags)
 		.resv = obj->resv,
 	};
 
+	/* WB_MMAP BOs can't be shared. */
+	if (to_panfrost_bo(obj)->wb_mmap)
+		return ERR_PTR(-EINVAL);
+
 	return drm_gem_dmabuf_export(dev, &exp_info);
 }
 
diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index 7831c48c59c0..2cc44591e82b 100644
--- a/include/uapi/drm/panfrost_drm.h
+++ b/include/uapi/drm/panfrost_drm.h
@@ -126,6 +126,7 @@ struct drm_panfrost_wait_bo {
 
 /* Valid flags to pass to drm_panfrost_create_bo.
  * PANFROST_BO_WB_MMAP can't be set if PANFROST_BO_HEAP is.
+ * Also, PANFROST_BO_WB_MMAP BOs can't be exported.
  */
 #define PANFROST_BO_NOEXEC	1
 #define PANFROST_BO_HEAP	2

-- 
2.56.0

