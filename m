Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0761ECC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573C610E7E3;
	Tue, 13 Oct 2026 12:02:37 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AAE210E7E3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1791892949;
 bh=U/+44aFm82lOehtBhiUwBP7f3FJAaVghj1VqiT/9BO0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WcnltKix5mSq7CHBsfUeErV+lQhE0kzuk3XsCi3Wh/UGpm2t4xkc1UirarIP2amTO
 hbPkz8uVEmmvYrxJlw5PkFxiALmd4yqCUQL2o1um9VkwStFmk99dHs79D2rG3ewAcq
 pwB2EoAkcYAfUzSiwLUkZIY5IgF8btMzV01Gj/gMGr7JK3yDiC/4mNeUe/cRwWgNk4
 54do3kZG+/Ou+mJ/5+2ATN6ft+mCkOH8NbldgT9E59cxI9dEenrlcneWBXzo32Clok
 uH3KvaJ/rx9HStgGCuQMVGFWK1Av+jGIWcgKEC7p9Bc9RDV8GpKLhsdcEaQpg5P5j2
 2TwjP+nLyhMSQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4j3tHm4SW6z4xgv;
 Tue, 13 Oct 2026 23:02:28 +1100 (AEDT)
From: Matt Evans <matt@ozlabs.org>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gfx@lists.freedesktop.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Alex Mastro <amastro@fb.com>,
 Alex Williamson <alex@shazbot.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v3 2/3] drm/i915/gvt: Read dmabuf->file only while valid
Date: Tue, 13 Oct 2026 13:02:05 +0100
Message-ID: <20261013120211.135807-3-matt@ozlabs.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013120211.135807-1-matt@ozlabs.org>
References: <20261013120211.135807-1-matt@ozlabs.org>
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

After 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
dentry_ops"), dmabuf->file can close prior to the .release callback
being invoked.

intel_vgpu_get_dmabuf() exports the dmabuf, then dma_buf_fd()
effectively transfers its file's reference to the fd.  A debug print
dereferences dmabuf->file after the dma_buf_fd(); however, the fd
could be closed by another thread, making dmabuf->file stale.

Read file_count() while the reference to dmabuf->file is still held,
for later debug printing.

Cc: stable@vger.kernel.org
Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentry_ops")
Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/gpu/drm/i915/gvt/dmabuf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index 8a1d6c5636c2..b6f50f2b912d 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -503,6 +503,7 @@ int intel_vgpu_get_dmabuf(struct intel_vgpu *vgpu, unsigned int dmabuf_id)
 	struct drm_device *dev = &vgpu->gvt->gt->i915->drm;
 	struct intel_vgpu_dmabuf_obj *dmabuf_obj;
 	struct drm_i915_gem_object *obj;
+	unsigned long db_fcount;
 	struct dma_buf *dmabuf;
 	int dmabuf_fd;
 	int ret = 0;
@@ -531,6 +532,7 @@ int intel_vgpu_get_dmabuf(struct intel_vgpu *vgpu, unsigned int dmabuf_id)
 		ret = PTR_ERR(dmabuf);
 		goto out_free_gem;
 	}
+	db_fcount = file_count(dmabuf->file);
 
 	ret = dma_buf_fd(dmabuf, DRM_CLOEXEC | DRM_RDWR);
 	if (ret < 0) {
@@ -552,8 +554,7 @@ int intel_vgpu_get_dmabuf(struct intel_vgpu *vgpu, unsigned int dmabuf_id)
 		    "        file count: %ld, GEM ref: %d\n",
 		    vgpu->id, dmabuf_obj->dmabuf_id,
 		    kref_read(&dmabuf_obj->kref),
-		    dmabuf_fd,
-		    file_count(dmabuf->file),
+		    dmabuf_fd, db_fcount,
 		    kref_read(&obj->base.refcount));
 
 	i915_gem_object_put(obj);
-- 
2.47.3

