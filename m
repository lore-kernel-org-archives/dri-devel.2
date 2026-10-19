Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B164CCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE46D10E53B;
	Mon, 19 Oct 2026 07:14:32 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B928610E53B
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:14:25 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e011d370dso1446345f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792394064; x=1792998864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3N4hEQnVScozkCXAtUHxCDfoyvbwHIV8uHsxZE1LpnQ=;
 b=meGpqE/qveUbhHuyu+Xn19hXMQHDUVenHv0D9BuS9ait+b2YZtcwVJWHT/nFMjWWEF
 6EyOxROnlPc0K0oJINOxZwZTjh/hHABpe6mA5KkPVC+rDOAre8pc5X5VcWjkIsEPqy4k
 UBbYhDL6gIacDcGo9j8Z+TK5lHKmBptKxQbb4kCte8z6ldadUpOgk42ND1wg4YR4OEeD
 K/TRYpxPfExgLQIZFZcqk0H9kBt0yLAhgSDUkaRrisePCZn6LYqpA5ZrS5GS/EO4wBwK
 0n9HEt5jPX6UHlVFW2pugFie6d0U43r/13Vxkc0bCgji00xT39EMH460MRec78bA0It3
 qPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792394064; x=1792998864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3N4hEQnVScozkCXAtUHxCDfoyvbwHIV8uHsxZE1LpnQ=;
 b=GlPhG6tvx71VK4Km4R7uZS/GB2136scEV48GLoGELNZ2pAVV0pyhZ7bgFDDrjTBsbx
 9EUQj+3wCFUZB2S3f4mnG8tWJMYhYljYjQJKOp5yCJz2WLp2ZEGvGdt60WJ9GwkYzkBP
 NwTmyo3QM81X3DymSLBkkhva8kuJDtsXBsEuZxNJEAW1+wcC1XagRHe7Q6aDteE5r+rZ
 09Za1tlvtKnZLdP5MRTrmrngtQmtwUgempP4E2OzoDziH4SA541wYnBTZg/uOGy1xaJ6
 9LCj8fPTEXM/IQWH184t+hyjnlN5epYNsFAFuRwfbNkBsvRpLxjSu/bCM1bKOC75HzPe
 KMaw==
X-Forwarded-Encrypted: i=1;
 AKwUvByEkvwUfZIk9WnWramNqTSbZfiGNUSJwP2JvOld9ufhK9jVt8TRR85MidYqJXdpBGMTE4vMSyZLSZo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJL940HXtEjcoSz+Q+M3yc16p5Wk7eUMmDS3yS6RcRmT4V8Guq/
 GpD4TicHwdckcUI/3XlhtcrL5WRazpp2d3UmELh6/xbuclflTwgf+PaAFm4Ghfx8
X-Gm-Gg: AYBFou0DYDwJtkQqVL5W+jZvYmn9YRK4KhHF/7bRp7y1+WfO3ZzoyvSXfQTtNszQeFI
 KPSvDenNgXCFc9woYtaaTwjnQ6QzEzsqe9CcGjdyKg8XQENt+tVnbgt4R7z9oGDH5+v6ZdEFeai
 MyDg2Cgcm3OBm9IKZkcphlUtnl+DKHCWSej4cD1Y4YeuJ/AOmd7f7m9caupmR5ZAwkigl6AxQkw
 ZOFG/zZJEw15MlbttQ7XrhHtgXiWPlB1VsYFxASE6EGzpnYvwScSCBr99uGDAa3fp0coRMVhjnG
 pGd9bomd0jGQ70CAog0jpo5oJPXhFDv4u+OmleXF0lbrL8nJzRdw8+0cWMfy/1ypB03GY327FZQ
 Ff0oXzzST0/5oIfeC3MmH/vwgzym/nIWNtD2iayfEzXrM7ocUEVTU7xyCwSnzEqFpRmj5oHbye3
 AFxeVaU0+B4t0W8ZZsSQ/N9N1SiGCtkYF3k66+sbDRuMynYNoRW5DmEapMNAeUCcP/NRkjhO3eM
 YRcLMjKyw1cekAiYEkTeZA96Zr41QFLEbVDftj43OckLQVMNyGC8fQ6jNICRgF6+s5TWkzfR3nE
 TbFth+teLpaXDxoR4SgVFAZCcNqmFa3FaS+VHXCoceQhYXaxaWHWCsxyN85sozMRVFH/YieZf3s
 c
X-Received: by 2002:a05:600c:a10b:b0:4a0:263c:704f with SMTP id
 5b1f17b1804b1-4a1d7601226mr96449385e9.16.1792394063736; 
 Mon, 19 Oct 2026 00:14:23 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a4e0-4601-c43a-536a-04a3-af7d.310.pool.telefonica.de.
 [2a02:3100:a4e0:4601:c43a:536a:4a3:af7d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd540bc4sm21559338f8f.2.2026.10.19.00.14.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Oct 2026 00:14:23 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: linux-media@vger.kernel.org
Cc: Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Tomasz Stanislawski <t.stanislaws@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 2/4] media: videobuf2: add opt-in DMA-BUF CPU access
Date: Mon, 19 Oct 2026 09:14:09 +0200
Message-Id: <673c04ad9dcc4f12685c076193ebad9e48e5f08d.1792392288.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1792392288.git.kmehltretter@gmail.com>
References: <cover.1792392288.git.kmehltretter@gmail.com>
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

Drivers must bracket CPU access to imported DMA-BUFs with
dma_buf_begin_cpu_access() and dma_buf_end_cpu_access().

Add a queue flag to do so from buf_prepare() through buf_finish(). Use
read access for output and write access for capture. Map imports
bidirectionally because CPU and device access directions are opposite.
Pass the mapping direction to attach_dmabuf() so USERPTR and MMAP keep
the queue's normal direction.

Keep this opt-in because some vb2-vmalloc drivers pass buffers to
hardware. End access in process context because DMA-BUF callbacks may
sleep.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 83 ++++++++++++++++++-
 .../common/videobuf2/videobuf2-dma-contig.c   |  5 +-
 .../media/common/videobuf2/videobuf2-dma-sg.c |  5 +-
 .../common/videobuf2/videobuf2-vmalloc.c      |  5 +-
 include/media/videobuf2-core.h                | 12 ++-
 5 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 460eaf4e82f78..d2a78cd0a86bb 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -371,6 +371,65 @@ static void __vb2_buf_mem_finish(struct vb2_buffer *vb)
 		call_void_memop(vb, finish, vb->planes[plane].mem_priv);
 }
 
+/* Output buffers are read by the driver; capture buffers are written. */
+static enum dma_data_direction vb2_cpu_access_dir(const struct vb2_queue *q)
+{
+	return q->is_output ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+}
+
+static bool __vb2_dmabuf_is_duplicate(const struct vb2_buffer *vb,
+				      unsigned int plane)
+{
+	unsigned int i;
+
+	for (i = 0; i < plane; i++)
+		if (vb->planes[i].dbuf == vb->planes[plane].dbuf)
+			return true;
+
+	return false;
+}
+
+static void __vb2_buf_end_cpu_access(struct vb2_buffer *vb,
+				     unsigned int num_planes)
+{
+	struct vb2_queue *q = vb->vb2_queue;
+	enum dma_data_direction dir = vb2_cpu_access_dir(q);
+	unsigned int plane;
+
+	for (plane = 0; plane < num_planes; plane++) {
+		int ret;
+
+		if (__vb2_dmabuf_is_duplicate(vb, plane))
+			continue;
+
+		ret = dma_buf_end_cpu_access(vb->planes[plane].dbuf, dir);
+		if (ret)
+			pr_warn_ratelimited("[%s] failed to end CPU access to dmabuf plane %u: %d\n",
+					    q->name, plane, ret);
+	}
+}
+
+static int __vb2_buf_begin_cpu_access(struct vb2_buffer *vb)
+{
+	struct vb2_queue *q = vb->vb2_queue;
+	enum dma_data_direction dir = vb2_cpu_access_dir(q);
+	unsigned int plane;
+	int ret;
+
+	for (plane = 0; plane < vb->num_planes; plane++) {
+		if (__vb2_dmabuf_is_duplicate(vb, plane))
+			continue;
+
+		ret = dma_buf_begin_cpu_access(vb->planes[plane].dbuf, dir);
+		if (ret) {
+			__vb2_buf_end_cpu_access(vb, plane);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * __setup_offsets() - setup unique offsets ("cookies") for every plane in
  * the buffer.
@@ -1423,6 +1482,9 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
 	}
 
 	if (reacquired) {
+		enum dma_data_direction attach_dir = q->uses_cpu_access ?
+			DMA_BIDIRECTIONAL : q->dma_dir;
+
 		if (vb->planes[0].mem_priv) {
 			vb->copied_timestamp = 0;
 			call_void_vb_qop(vb, buf_cleanup, vb);
@@ -1453,7 +1515,8 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
 						  vb,
 						  q->alloc_devs[plane] ? : q->dev,
 						  planes[plane].dbuf,
-						  planes[plane].length);
+						  planes[plane].length,
+						  attach_dir);
 			if (IS_ERR(mem_priv)) {
 				dprintk(q, 1, "failed to attach dmabuf\n");
 				ret = PTR_ERR(mem_priv);
@@ -1504,9 +1567,21 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
 		}
 	}
 
+	if (q->uses_cpu_access) {
+		ret = __vb2_buf_begin_cpu_access(vb);
+		if (ret) {
+			dprintk(q, 1, "failed to begin CPU access to dmabuf: %d\n",
+				ret);
+			call_void_vb_qop(vb, buf_cleanup, vb);
+			goto err_put_vb2_buf;
+		}
+	}
+
 	ret = call_vb_qop(vb, buf_prepare, vb);
 	if (ret) {
 		dprintk(q, 1, "buffer preparation failed\n");
+		if (q->uses_cpu_access)
+			__vb2_buf_end_cpu_access(vb, vb->num_planes);
 		call_void_vb_qop(vb, buf_cleanup, vb);
 		goto err_put_vb2_buf;
 	}
@@ -1756,6 +1831,8 @@ int vb2_core_remove_bufs(struct vb2_queue *q, unsigned int start, unsigned int c
 
 		__vb2_buf_mem_finish(vb);
 		call_void_vb_qop(vb, buf_finish, vb);
+		if (q->memory == VB2_MEMORY_DMABUF && q->uses_cpu_access)
+			__vb2_buf_end_cpu_access(vb, vb->num_planes);
 		vb->prepared = 0;
 	}
 
@@ -2160,6 +2237,8 @@ int vb2_core_dqbuf(struct vb2_queue *q, unsigned int *pindex, void *pb,
 	}
 
 	call_void_vb_qop(vb, buf_finish, vb);
+	if (q->memory == VB2_MEMORY_DMABUF && q->uses_cpu_access)
+		__vb2_buf_end_cpu_access(vb, vb->num_planes);
 	vb->prepared = 0;
 
 	if (pindex)
@@ -2296,6 +2375,8 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 
 		if (vb->prepared) {
 			call_void_vb_qop(vb, buf_finish, vb);
+			if (q->memory == VB2_MEMORY_DMABUF && q->uses_cpu_access)
+				__vb2_buf_end_cpu_access(vb, vb->num_planes);
 			vb->prepared = 0;
 		}
 		__vb2_dqbuf(vb);
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 9ce6284cd5f26..68c146c043fb1 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -768,7 +768,8 @@ static void vb2_dc_detach_dmabuf(void *mem_priv)
 }
 
 static void *vb2_dc_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
-				  struct dma_buf *dbuf, unsigned long size)
+				  struct dma_buf *dbuf, unsigned long size,
+				  enum dma_data_direction dma_dir)
 {
 	struct vb2_dc_buf *buf;
 	struct dma_buf_attachment *dba;
@@ -794,7 +795,7 @@ static void *vb2_dc_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
 		return dba;
 	}
 
-	buf->dma_dir = vb->vb2_queue->dma_dir;
+	buf->dma_dir = dma_dir;
 	buf->size = size;
 	buf->db_attach = dba;
 
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index b1d0695cda260..ab03f9d31391a 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -616,7 +616,8 @@ static void vb2_dma_sg_detach_dmabuf(void *mem_priv)
 }
 
 static void *vb2_dma_sg_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
-				      struct dma_buf *dbuf, unsigned long size)
+				      struct dma_buf *dbuf, unsigned long size,
+				      enum dma_data_direction dma_dir)
 {
 	struct vb2_dma_sg_buf *buf;
 	struct dma_buf_attachment *dba;
@@ -640,7 +641,7 @@ static void *vb2_dma_sg_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
 		return dba;
 	}
 
-	buf->dma_dir = vb->vb2_queue->dma_dir;
+	buf->dma_dir = dma_dir;
 	buf->size = size;
 	buf->db_attach = dba;
 	buf->vb = vb;
diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
index 63f023696f3ee..c38faa0188bc9 100644
--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -402,7 +402,8 @@ static void vb2_vmalloc_detach_dmabuf(void *mem_priv)
 static void *vb2_vmalloc_attach_dmabuf(struct vb2_buffer *vb,
 				       struct device *dev,
 				       struct dma_buf *dbuf,
-				       unsigned long size)
+				       unsigned long size,
+				       enum dma_data_direction dma_dir)
 {
 	struct vb2_vmalloc_buf *buf;
 
@@ -414,7 +415,7 @@ static void *vb2_vmalloc_attach_dmabuf(struct vb2_buffer *vb,
 		return ERR_PTR(-ENOMEM);
 
 	buf->dbuf = dbuf;
-	buf->dma_dir = vb->vb2_queue->dma_dir;
+	buf->dma_dir = dma_dir;
 	buf->size = size;
 
 	return buf;
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 4b4f4c15c53a7..8dfe22fa4423c 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -78,7 +78,8 @@ struct vb2_buffer;
  *		to the userspace, also optional.
  * @attach_dmabuf: attach a shared &struct dma_buf for a hardware operation;
  *		   used for DMABUF memory types; dev is the alloc device
- *		   dbuf is the shared dma_buf; returns ERR_PTR() on failure;
+ *		   dbuf is the shared dma_buf; dma_dir is the DMA mapping
+ *		   direction; returns ERR_PTR() on failure;
  *		   allocator private per-buffer structure on success;
  *		   this needs to be used for further accesses to the buffer.
  * @detach_dmabuf: inform the exporter of the buffer that the current DMABUF
@@ -136,7 +137,8 @@ struct vb2_mem_ops {
 	void		*(*attach_dmabuf)(struct vb2_buffer *vb,
 					  struct device *dev,
 					  struct dma_buf *dbuf,
-					  unsigned long size);
+					  unsigned long size,
+					  enum dma_data_direction dma_dir);
 	void		(*detach_dmabuf)(void *buf_priv);
 	int		(*map_dmabuf)(void *buf_priv);
 	void		(*unmap_dmabuf)(void *buf_priv);
@@ -510,6 +512,11 @@ struct vb2_buf_ops {
  *		->finish().
  * @non_coherent_mem: when set queue will attempt to allocate buffers using
  *		non-coherent memory.
+ * @uses_cpu_access: the driver transfers buffer data with the CPU instead of
+ *		DMA. For imported dma-bufs, videobuf2 brackets the interval from
+ *		buf_prepare through buf_finish with dma_buf_begin_cpu_access()
+ *		and dma_buf_end_cpu_access(). Imported attachments use
+ *		bidirectional DMA mappings.
  * @lock:	pointer to a mutex that protects the &struct vb2_queue. The
  *		driver must set this to a mutex to let the v4l2 core serialize
  *		the queuing ioctls. This lock is used when waiting for a new
@@ -614,6 +621,7 @@ struct vb2_queue {
 	unsigned int			uses_requests:1;
 	unsigned int			allow_cache_hints:1;
 	unsigned int			non_coherent_mem:1;
+	unsigned int			uses_cpu_access:1;
 
 	struct mutex			*lock;
 	void				*owner;
-- 
2.47.3

