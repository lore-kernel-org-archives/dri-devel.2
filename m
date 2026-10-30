Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDAF606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=TrYD7Ri0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9EB01129D0;
	Fri, 30 Oct 2026 20:52:17 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649411129CD
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=Fl8AVMR01kLZLDTcR+80gpLCrLsNjvibTELS+jVnqO8=; b=TrYD7Ri06jr1dDcyzWrOVICfSL
 BYlGbZY4WdXLxheS4HAO9Y2PMWPWtzy/dm+T6K9GPhZ+4hnT+OqsTKXmrVKT/E5wM3620nVHCEP3n
 O6T0OM8JmK5YLAdz0b5Yz1Osc1KAv8QZA3lCI2Ch7ixXP3yQWNfVZ5mSN2d8ImniorzIFESBQQ+eK
 DUs4rfPgD0pMMm+a0jxoaDmQVlTEI0/LyfwsMkZbiCWrbBU5jjRFPIU19PCURGTb6OgwERL+242oz
 XAOEj+k7+mahEjCg0MXNkZ5MTR4RN1xgy0SVjNspCcHZxi2dzVbfnTy4fZ4i7ki3EhrR6ogMpsgbt
 PG7hekJA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMtZt-00FLiF-ME; Fri, 30 Oct 2026 21:51:57 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 30 Oct 2026 17:50:26 -0300
Subject: [PATCH RFC 08/12] drm/amdgpu: Use drm_gem_prime_export_with_ops()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-v3d-cached-maps-v1-8-0a6a6b363382@igalia.com>
References: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
In-Reply-To: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 JaeHoon Lee <dlwognsdc610@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=xoWLCb7qF3FRDwC6kv8m4vexv/WiZUIw70NgFlIfMMM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq5QNDQIXEPkqWr9TPeU1XzYnXo7bnuCk7l9sYF
 7ycPiw+Y+CJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCauUDQwAKCRA/8w6Kdoj6
 qmIIB/9L3G4dQ893e8p6HaI7gJ3EDmIpbD+7ub5DxriAqjwDmbB16ylgzPXnmxzYOI6AkkYOktn
 fzu7uLCOPUynCL85fDbAbqMFm8gynaAuG/JpKRb3m+QMfFvdSc6kJMDkT1tPqZm2jr0w7oLgZm3
 MN/goROdDhxtIOrxG5nAuRT1MXRqwIP6+9PrdLPZIU5jo4Md7yjsBv0xAKK9v5xrMp00EbfukZS
 iEcjDNvk+5hCl/y3/cMoD530/MytYuSY5Pw5SLtFxvYlws9hmJ9R5+9Cd7Beo1j3XlKwep4ZaZY
 MRyYAnWr6+hJYMygh1wPvUebLNhQ/fRmImvJcTyxq39dF1L4
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu exports with the default PRIME dma_buf_ops and replaces them
afterwards. Instead of open-code the replacement of the DMA-BUF
operations, use the new helper drm_gem_prime_export_with_ops() to export
amdgpu_dmabuf_ops directly.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 4031ebe075d8..2e4a1d1b6322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -407,7 +407,7 @@ const struct dma_buf_ops amdgpu_dmabuf_ops = {
  * @gobj: GEM BO
  * @flags: Flags such as DRM_CLOEXEC and DRM_RDWR.
  *
- * The main work is done by the &drm_gem_prime_export helper.
+ * The main work is done by drm_gem_prime_export_with_ops().
  *
  * Returns:
  * Shared DMA buffer representing the GEM BO from the given device.
@@ -416,7 +416,6 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
 					int flags)
 {
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
-	struct dma_buf *buf;
 	struct ttm_operation_ctx ctx = {
 		.interruptible = true,
 		.no_wait_gpu = true,
@@ -434,11 +433,7 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
 	if (ret)
 		return ERR_PTR(ret);
 
-	buf = drm_gem_prime_export(gobj, flags);
-	if (!IS_ERR(buf))
-		buf->ops = &amdgpu_dmabuf_ops;
-
-	return buf;
+	return drm_gem_prime_export_with_ops(gobj, &amdgpu_dmabuf_ops, flags);
 }
 
 /**

-- 
2.56.0

