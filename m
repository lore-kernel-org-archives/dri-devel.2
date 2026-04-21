Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BDBF94CB7
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 23:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C097010E949;
	Tue, 21 Apr 2026 23:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JxzVfOvL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDFB910EE15
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 23:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776815654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jpiw4NbDlnr2VDVswPGwDPVhLnXvWCUe2RwuNRF/TFk=;
 b=JxzVfOvLDjroWgo3RpkSES1X+p8YY9SGvq2HcY2YBFI3KPhz1NH4e39HB0JgivkB6D32xC
 899JdSBCIL4Pg5fLZS9LIr1MJSGN0uFixwUTvrSnYnJ0pTjQ+zWMRnUHK1CXjDhSYPD65S
 imtZMb1HHT84EQraAu3jRLYcnIAGALU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-CR3_lWuQOEGEpA1dfqRYJQ-1; Tue,
 21 Apr 2026 19:54:08 -0400
X-MC-Unique: CR3_lWuQOEGEpA1dfqRYJQ-1
X-Mimecast-MFC-AGG-ID: CR3_lWuQOEGEpA1dfqRYJQ_1776815645
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49BDE195608B; Tue, 21 Apr 2026 23:54:05 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.80.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCA861956095; Tue, 21 Apr 2026 23:54:01 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org, Gary Guo <gary@garyguo.net>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org
Cc: Matthew Maurer <mmaurer@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, christian.koenig@amd.com,
 Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, linux-media@vger.kernel.org,
 Shankari Anand <shankari.ak0208@gmail.com>,
 David Airlie <airlied@gmail.com>, Benno Lossin <lossin@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linaro-mm-sig@lists.linaro.org,
 Asahi Lina <lina+kernel@asahilina.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@vger.kernel.org
Subject: [PATCH v12 2/5] drm/gem/shmem: Introduce
 __drm_gem_shmem_free_sgt_locked()
Date: Tue, 21 Apr 2026 19:52:14 -0400
Message-ID: <20260421235346.672794-3-lyude@redhat.com>
In-Reply-To: <20260421235346.672794-1-lyude@redhat.com>
References: <20260421235346.672794-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 85-696v3Zaf8ENzZtzWluUfqptS_OeywhH5tRBxq3is_1776815645
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

One of the complications of trying to use the shmem helpers to create a
scatterlist for shmem objects is that we need to be able to provide a
guarantee that the driver cannot be unbound for the lifetime of the
scatterlist.

The easiest way of handling this seems to be just hooking up an unmap
operation to devres the first time we create a scatterlist, which allows us
to still take advantage of gem shmem facilities without breaking that
guarantee. To allow for this, we extract __drm_gem_shmem_free_sgt_locked()
- which allows a caller (e.g. the rust bindings) to manually unmap the sgt
for a gem object as needed.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

---
V10:
* Fix incorrect function name in documentation for
  __drm_gem_shmem_release_sgt_locked()

 drivers/gpu/drm/drm_gem_shmem_helper.c | 32 +++++++++++++++++++++-----
 include/drm/drm_gem_shmem_helper.h     |  1 +
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 4500deef41278..d2c34a0e573a1 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -158,6 +158,30 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
 
+/**
+ * __drm_gem_shmem_release_sgt_locked - Unpin and DMA unmap pages, and release the
+ * cached scatter/gather table for an shmem GEM object.
+ * @shmem: shmem GEM object
+ *
+ * If the passed shmem object has an active scatter/gather table for driver
+ * usage, this function will unmap it and release the memory associated with it.
+ * It is the responsibility of the caller to ensure it holds the dma_resv_lock
+ * for this object.
+ *
+ * Drivers should not need to call this function themselves, it is mainly
+ * intended for usage in the Rust shmem bindings.
+ */
+void __drm_gem_shmem_free_sgt_locked(struct drm_gem_shmem_object *shmem)
+{
+	dma_resv_assert_held(shmem->base.resv);
+
+	dma_unmap_sgtable(shmem->base.dev->dev, shmem->sgt, DMA_BIDIRECTIONAL, 0);
+	sg_free_table(shmem->sgt);
+	kfree(shmem->sgt);
+	shmem->sgt = NULL;
+}
+EXPORT_SYMBOL_GPL(__drm_gem_shmem_free_sgt_locked);
+
 /**
  * drm_gem_shmem_release - Release resources associated with a shmem GEM object.
  * @shmem: shmem GEM object
@@ -176,12 +200,8 @@ void drm_gem_shmem_release(struct drm_gem_shmem_object *shmem)
 
 		drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
 
-		if (shmem->sgt) {
-			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
-					  DMA_BIDIRECTIONAL, 0);
-			sg_free_table(shmem->sgt);
-			kfree(shmem->sgt);
-		}
+		if (shmem->sgt)
+			__drm_gem_shmem_free_sgt_locked(shmem);
 		if (shmem->pages)
 			drm_gem_shmem_put_pages_locked(shmem);
 
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 5ccdae21b94a9..b2c23af628e1a 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -111,6 +111,7 @@ int drm_gem_shmem_init(struct drm_device *dev, struct drm_gem_shmem_object *shme
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
 void drm_gem_shmem_release(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
+void __drm_gem_shmem_free_sgt_locked(struct drm_gem_shmem_object *shmem);
 
 void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem);
 int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
-- 
2.53.0

