Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA5606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z/gYSgaP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8B410E576;
	Sat,  7 Nov 2026 10:47:44 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EED910E330
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 10:47:38 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso9394635e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 02:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794048457; x=1794653257; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gs6IOJ2d9nrR4hk6rBiqyfNHtcU7Qx4Hjf4P/81L2vQ=;
 b=Z/gYSgaP5grFBY/PoDlMh73pPAn8cfHY9SxDLp0AIz89N21a4g/+tuQG5N+xxtzcFn
 y5Jl3OSzgWSej7X+Ul30UDTXZtl/npwmOYTzziTTitG8IsFcTrqTcj2Lh7a6CrO9VK5v
 f/pfHSEVSOAJa9qncpw/W0zvQnU4iOwGgHToylmIosGPrVxXertq1QChPMprMQdOG1c8
 QPcgeBjrlQ+qeho5Mn2pFrzZyh3XyxwF9bOqdnoKlScxKXXfCJZBX04IaeIy2KQDhkMA
 z9l2DuoSRyMiGy9hXpVJmA3cP8CGuUzJqDO7nognQvawMmn5tkQ3n5gu41sRzFcRatjC
 HtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794048457; x=1794653257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gs6IOJ2d9nrR4hk6rBiqyfNHtcU7Qx4Hjf4P/81L2vQ=;
 b=K/ceYw12QLPjWq5jSw8dfeZCvC2eQ0y8xwM/GFBSLkLadZ/1Oh2zASkGJuvTZTFbfx
 kEH5Zdxvin8krp02LBGUX0GwR5kvLBqDOkRze5JI3bA5MGcEdH1Ph9mZPUdxiLjfYFoT
 LDIIGaSTF3mXHxOyCcW3QtNf/VyhtarcRk+ThKU1Gzng61UzXWfwGMmXtjizxCZCd66e
 2191VAXfHcmu16HvBzFhb67T0rzaZNqlmpKYdeKbqsuN9rSf3BW5WyBQh0cN5XEcuwZ0
 yTVUShoDsqbf6S6B3Za2V96Ks/khgKzWW4h8wbDqeQJg1eii6qNksZQQXaQaxpW8rqqs
 jKbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfnj2m+pLBm+HduEpYVRToReAOpdh3z61sTX6uKQlMoowKF6CfMfdJdnWpNmZOXEB/wzAqSwPwaao=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8A+rBrkr/5/dUcopjPCxaNHS6AmYMMlPMaPaRNhqDZGh6t4S85
 fzEWo5jOsfFcaO1ou6QPdl0otmtJzR+km2TXyJ0gEbdzovmAZxHPSccG
X-Gm-Gg: AYBFou0p/4IivhmLVd5jaX7EHbO05Gj8xDC3QHtLOYKExzig01wBuSB68Pp0KrQWC/c
 iHgL+ZSER6IceC8ys0H2SJahnbwBTAC9pO49H/Mm18fz5gZSEK9EfrzO6G/G1taXaFzdjz+GCNb
 juHppy0m2TTq+QLlup5EdwujNoZnhncwoFgP40Skjtm259TH9Xw842umZ6qX9jkX6qUeOfDkva7
 /YXYRk7sFYevibBJDxvXoEjTjwCNjPh2lENeuxuVqRnFTnj5HQTxx34nP1nTEq7MoJl9oHoGi2q
 ACiDpX1Ywwb2HT0upGE4VcPK3wSw+A1Az38wZC4l3hqIj7qr2/O0ylsLMTTfz8bxlLpFtDZX+sg
 qGZphE7wWzSc/junuVjXEYXHe86sLJvk7Ujz0gbyqOA9PAL2a1I0pQ3XyCvDN2xBYETLPwGQDny
 33wyTXcShcJpUEcjddX+ejiVZHvIwmxLYrdWrHM6K5Q9Qo1Itl9Yj1i3c1a8d3ySZ3FwxpBFmAd
 iMWtUX5d5C3893y6mug0HlSCQFC7c5AtcrxRTC5Jp0gVIAGvCNMx4vTWuLbCYo/UVABaR62xfLJ
 U+Mc9Z9SyiwnMSy1MLmd0DwtNbfOCrEo9aoUDyzvbtc403h2856uY8Z6rZ++2tzlAjYP6q/6jfV
 VPFGgN7T5skURRGxHe3m1K5ABddIVg5mtnIGnKdMQLk4e9AZRxRZ2od5OXa7IXSLd6AAlk0AIUL
 QkmbCeEsAZHwqbhAqOlpVCQ5/pI5JR64oljvm7
X-Received: by 2002:a05:600d:82e1:b0:4a1:9663:7639 with SMTP id
 5b1f17b1804b1-4b6e0cf4464mr101136445e9.34.1794048456657; 
 Sat, 07 Nov 2026 02:47:36 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de.
 [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b795024730sm47935635e9.4.2026.11.07.02.47.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Nov 2026 02:47:36 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] media: videobuf2: add opt-in DMA-BUF CPU access
Date: Sat,  7 Nov 2026 11:47:01 +0100
Message-Id: <20261107104703.44111-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107104703.44111-1-kmehltretter@gmail.com>
References: <20261107104703.44111-1-kmehltretter@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drivers that transfer buffer contents with the CPU must bracket access to
imported DMA-BUFs with dma_buf_begin_cpu_access() and
dma_buf_end_cpu_access().

Add a uses_cpu_access queue flag for vb2-vmalloc queues to bracket the
interval from buf_prepare() through buf_finish(), using read access for
output queues and write access for capture queues.

Keep this opt-in because some vb2-vmalloc drivers pass imported buffers to
hardware, and end access in process context because DMA-BUF callbacks may
sleep and return errors.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2:
- Scope uses_cpu_access to vb2-vmalloc queues and drop the attach_dmabuf
  dma_dir parameter from vb2_mem_ops and the allocators (Tomasz Figa).
- Call __vb2_buf_end_cpu_access() from __vb2_buf_cancel() (Tomasz Figa).

 .../media/common/videobuf2/videobuf2-core.c   | 76 +++++++++++++++++++
 include/media/videobuf2-core.h                |  5 ++
 2 files changed, 81 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 29e539ee002e..6c32d3cccb93 100644
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
@@ -1504,9 +1563,21 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
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
@@ -1720,6 +1791,7 @@ EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
 static void __vb2_buf_cancel(struct vb2_buffer *vb)
 {
 	struct media_request *req = vb->req_obj.req;
+	struct vb2_queue *q = vb->vb2_queue;
 
 	/*
 	 * If a request is associated with this buffer, then
@@ -1743,6 +1815,8 @@ static void __vb2_buf_cancel(struct vb2_buffer *vb)
 
 	if (vb->prepared) {
 		call_void_vb_qop(vb, buf_finish, vb);
+		if (q->memory == VB2_MEMORY_DMABUF && q->uses_cpu_access)
+			__vb2_buf_end_cpu_access(vb, vb->num_planes);
 		vb->prepared = 0;
 	}
 	__vb2_dqbuf(vb);
@@ -2191,6 +2265,8 @@ int vb2_core_dqbuf(struct vb2_queue *q, unsigned int *pindex, void *pb,
 	}
 
 	call_void_vb_qop(vb, buf_finish, vb);
+	if (q->memory == VB2_MEMORY_DMABUF && q->uses_cpu_access)
+		__vb2_buf_end_cpu_access(vb, vb->num_planes);
 	vb->prepared = 0;
 
 	if (pindex)
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 4b4f4c15c53a..bbcdd8c8989a 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -510,6 +510,10 @@ struct vb2_buf_ops {
  *		->finish().
  * @non_coherent_mem: when set queue will attempt to allocate buffers using
  *		non-coherent memory.
+ * @uses_cpu_access: the driver transfers buffer data with the CPU instead of
+ *		DMA. For imported dma-bufs on vb2-vmalloc queues, videobuf2
+ *		brackets the interval from buf_prepare through buf_finish with
+ *		dma_buf_begin_cpu_access() and dma_buf_end_cpu_access().
  * @lock:	pointer to a mutex that protects the &struct vb2_queue. The
  *		driver must set this to a mutex to let the v4l2 core serialize
  *		the queuing ioctls. This lock is used when waiting for a new
@@ -614,6 +618,7 @@ struct vb2_queue {
 	unsigned int			uses_requests:1;
 	unsigned int			allow_cache_hints:1;
 	unsigned int			non_coherent_mem:1;
+	unsigned int			uses_cpu_access:1;
 
 	struct mutex			*lock;
 	void				*owner;
-- 
2.39.5 (Apple Git-154)

