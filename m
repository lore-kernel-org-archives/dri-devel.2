Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43F8C44501
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 04:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB7C10E275;
	Sat, 11 Jul 2026 04:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GE3RLPSo";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BEB10E275
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 04:15:08 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso890093a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783743308; x=1784348108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cVmjO8YLPA661gTc9yInoWvB2zcY0L5sJjMyBUBdtk0=;
 b=GE3RLPSo1SaGd/fo5sCrERZyMrN1PeJHnenbTONPVO22jDylbQsDAlc7/WQL510Vr6
 8NwSlrOkLs444b8r3F1D6YB74h6wI5A3xd3xyNlU1GPsWqouF3gQOhpohOxeCDBjn6Oy
 l8tfLBDMqQMM/VFDRKeIrDwstJ2e4IC70ilBZYGRqYtcoYt2RDV+XNzfTlneFS/n/1fb
 uf5O8tlY1vH/55qq+dyf+DswKoKlBhBqMvkl/rmyUHZQeWZtS15oLUp9vn7/NESLd7Uo
 JXLJhvs3lFKgMW294ggdIm4Bqll5Yr43NpPBkOAOC2MjPG35BuVsO2YWwY2SxdVQGWf+
 Td/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783743308; x=1784348108;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cVmjO8YLPA661gTc9yInoWvB2zcY0L5sJjMyBUBdtk0=;
 b=Rr5uRfaoryP0FthzUo4Q5cYf8nzsH0zLOcBMjz+BfgE25CWPKGBQQftN8mMvT+9IF4
 jy8g867Zclv0FdiiSXAZY8+laNASMqlHraTCS1ImMjwLESbSKS+dVd1Cg+fyHezCP1HA
 GPMwZASUjAfniyDLci/jpjsROtV668fL2nfbaEHmGnt9iHus8+NYasVpsxBtHDADDfj8
 DAj0ny5QwdmTQuqj79keZbtA+H6HOxfchQUNa9fg55wJyUgl05bQ4VHOcfkN9fQyogY4
 zylqjMyafNalXa7tk7xa/81Ad7fMan391OwWr+RzpJCAIgLC7OhRu8Gl/JTi13McKJZM
 nClA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpE56Jdd9v6h96EIJmwhpfh5Sd4iVM2J+qrKq5ChIxM4N7ESZeyTX8GhD5n/vmMpPZ4PIEQIKEaYos=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMY90UoK5F6VjdRodXEfXwp8o7z6v+YXCULqxjY8eZ/90uqGnE
 urPV/xLVLfnNrhRBwSf2UnjoiEKb4IfkL1wXf6uM/6OrWjpqIWpr5WrO
X-Gm-Gg: AfdE7ckYgslNBSxI7Kq2MmEc3L7+zqgyVjX5ybAvV4p9sZi0EitWfoHdmFAsg3MebQR
 ugft/hDxPTVQN4GxCFIdTQC5H5rq/dwhCvdbMO0/KZbgDSE3CpQa9foQd6nxNmle7zJDE3ed3i6
 MGVVigvfgpS34ESu8CdPdhVoGoBqV1pEKnANZwXUk+eW7XcfLYv5EBE8e2rclE1Ut9A9elIi9SU
 3eflwec9jUDR2V7KNNa+m25jtYrvOSak+Tnrt3Bcey5t+78BYtytdotg9MzL9X/r9R4MdpTcdc/
 pH/O7MRvw2qhp9JMYx+ZAYv70A/jZaGSRNGw6RLAKfWYu+25aFdTm1L8MNX/6JmeVThb3P+MaAM
 HlK0BV8jmSQSYRd2EMp+bNkSNgCzcKY8SRlpfnWBvHZjhr0IUWYK37hy3Y7RXQZM7M0InqKCpMV
 vg79fSGWkj0SdMwp6CgMsh+0ZrvVc=
X-Received: by 2002:a05:6a21:4d8f:b0:3bf:d1f9:b1df with SMTP id
 adf61e73a8af0-3c110d2f025mr1812527637.54.1783743307902; 
 Fri, 10 Jul 2026 21:15:07 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5afbc1208sm5769419a12.9.2026.07.10.21.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 21:15:07 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>
Cc: stable@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v2] dma-buf: dma-heap: don't publish fd before copy_to_user()
 succeeds
Date: Sat, 11 Jul 2026 12:14:55 +0800
Message-Id: <20260711041455.3375292-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703080922.1838362-1-shoubaineng@gmail.com>
References: <20260703080922.1838362-1-shoubaineng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into the
caller's fd table via dma_buf_fd() -> fd_install() before
dma_heap_ioctl() copies the result back to userspace.  If the trailing
copy_to_user() fails, userspace never learns the fd number, but the
fd (and the underlying dma-buf reference) are already visible to
other threads in the same process and are leaked for the lifetime of
the process.

The obvious "close it on the failure path" fix is unsafe: once
fd_install() has run, another thread can already dup() the fd, send
it via SCM_RIGHTS, or close() it and let its number be reused, so a
subsequent close_fd() from the ioctl path can operate on an unrelated
file.  This was pointed out by Christian König on v1 [1].

Restructure the allocation path so that fd_install() is the last,
unfailable step of a successful ioctl:

  1. heap->ops->allocate()      creates the dma_buf.
  2. get_unused_fd_flags()      reserves an fd number in the caller's
                                fd table without publishing it, so
                                no other thread can observe it.
  3. copy_to_user()             delivers the fd number to userspace;
                                on failure the fd is returned with
                                put_unused_fd() and the dma_buf
                                reference is dropped with
                                dma_buf_put(), leaving no user-
                                visible state behind.
  4. fd_install()               publishes the fd -- from here on the
                                ioctl cannot fail.

To make this possible, dma_heap_ioctl_allocate() is refactored to
return the struct dma_buf * directly (returning ERR_PTR on failure)
so the caller holds the dmabuf reference across steps 3 and 4.
The fd is written into the kdata buffer before copy_to_user() so
the reserved fd number reaches userspace atomically with the install.

The failure at step 3 is easily reachable from userspace: pass a
struct dma_heap_allocation_data that lives in a page whose protection
is flipped to PROT_READ between copy_from_user() and copy_to_user()
(e.g. via mprotect()).  Before this change each such ioctl leaks one
dmabuf fd; after it, the fd table is unchanged on failure and only
/dev/dma_heap/<name> remains open.

No UAPI or heap-driver interface change.

[1] https://lore.kernel.org/dri-devel/175e98de-f414-47d7-81c1-c0fe0a8f7f62@amd.com/

Fixes: c02a81fba74f ("dma-buf: Add dma-buf heaps framework")
Cc: stable@vger.kernel.org
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/dma-buf/dma-buf.c  | 20 ++++++++++
 drivers/dma-buf/dma-heap.c | 80 +++++++++++++++++++-------------------
 include/linux/dma-buf.h    |  1 +
 3 files changed, 61 insertions(+), 40 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..4c9add51f9ef 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -803,6 +803,26 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
 
+/**
+ * dma_buf_fd_install - install a reserved fd for a dma-buf
+ * @dmabuf:	[in]	pointer to dma_buf
+ * @fd:		[in]	fd reserved with get_unused_fd_flags()
+ *
+ * Publishes a previously reserved fd into the caller's fd table.
+ * Must only be called after all fallible work (e.g. copy_to_user)
+ * has succeeded, as it cannot be undone safely once called.
+ *
+ * The caller is responsible for having emitted the trace event
+ * (via dma_buf_fd() or get_unused_fd_flags() + this function)
+ * before calling this.
+ */
+void dma_buf_fd_install(struct dma_buf *dmabuf, int fd)
+{
+	DMA_BUF_TRACE(trace_dma_buf_fd, dmabuf, fd);
+	fd_install(fd, dmabuf->file);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_fd_install, "DMA_BUF");
+
 /**
  * dma_buf_get - returns the struct dma_buf related to an fd
  * @fd:	[in]	fd associated with the struct dma_buf to be returned
diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index a76bf3f8b071..43c32fb28313 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -55,33 +55,6 @@ MODULE_PARM_DESC(mem_accounting,
 		 "Enable cgroup-based memory accounting for dma-buf heap allocations (default=false).");
 EXPORT_SYMBOL_NS_GPL(mem_accounting, "DMA_BUF_HEAP");
 
-static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
-				 u32 fd_flags,
-				 u64 heap_flags)
-{
-	struct dma_buf *dmabuf;
-	int fd;
-
-	/*
-	 * Allocations from all heaps have to begin
-	 * and end on page boundaries.
-	 */
-	len = PAGE_ALIGN(len);
-	if (!len)
-		return -EINVAL;
-
-	dmabuf = heap->ops->allocate(heap, len, fd_flags, heap_flags);
-	if (IS_ERR(dmabuf))
-		return PTR_ERR(dmabuf);
-
-	fd = dma_buf_fd(dmabuf, fd_flags);
-	if (fd < 0) {
-		dma_buf_put(dmabuf);
-		/* just return, as put will call release and that will free */
-	}
-	return fd;
-}
-
 static int dma_heap_open(struct inode *inode, struct file *file)
 {
 	struct dma_heap *heap;
@@ -99,30 +72,42 @@ static int dma_heap_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static long dma_heap_ioctl_allocate(struct file *file, void *data)
+static struct dma_buf *dma_heap_ioctl_allocate(struct file *file, void *data)
 {
 	struct dma_heap_allocation_data *heap_allocation = data;
 	struct dma_heap *heap = file->private_data;
+	struct dma_buf *dmabuf;
 	int fd;
+	size_t len;
 
 	if (heap_allocation->fd)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	if (heap_allocation->fd_flags & ~DMA_HEAP_VALID_FD_FLAGS)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
+
+	len = PAGE_ALIGN(heap_allocation->len);
+	if (!len)
+		return ERR_PTR(-EINVAL);
+
+	dmabuf = heap->ops->allocate(heap, len, heap_allocation->fd_flags,
+				     heap_allocation->heap_flags);
 
-	fd = dma_heap_buffer_alloc(heap, heap_allocation->len,
-				   heap_allocation->fd_flags,
-				   heap_allocation->heap_flags);
-	if (fd < 0)
-		return fd;
+	if (IS_ERR(dmabuf))
+		return dmabuf;
+
+	fd = get_unused_fd_flags(heap_allocation->fd_flags);
+	if (fd < 0) {
+		dma_buf_put(dmabuf);
+		return ERR_PTR(fd);
+	}
 
 	heap_allocation->fd = fd;
 
-	return 0;
+	return dmabuf;
 }
 
 static unsigned int dma_heap_ioctl_cmds[] = {
@@ -138,6 +123,8 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
 	unsigned int in_size, out_size, drv_size, ksize;
 	int nr = _IOC_NR(ucmd);
 	int ret = 0;
+	int fd;
+	struct dma_buf *dmabuf;
 
 	if (nr >= ARRAY_SIZE(dma_heap_ioctl_cmds))
 		return -EINVAL;
@@ -174,15 +161,28 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
 
 	switch (kcmd) {
 	case DMA_HEAP_IOCTL_ALLOC:
-		ret = dma_heap_ioctl_allocate(file, kdata);
+		dmabuf = dma_heap_ioctl_allocate(file, kdata);
+
+		if (IS_ERR(dmabuf)) {
+			ret = PTR_ERR(dmabuf);
+			break;
+		}
+
+		fd = ((struct dma_heap_allocation_data *)kdata)->fd;
+		if (copy_to_user((void __user *)arg, kdata, out_size) != 0) {
+			put_unused_fd(fd);
+			dma_buf_put(dmabuf);
+			ret = -EFAULT;
+		} else {
+			dma_buf_fd_install(dmabuf, fd);
+		}
+
 		break;
 	default:
 		ret = -ENOTTY;
 		goto err;
 	}
 
-	if (copy_to_user((void __user *)arg, kdata, out_size) != 0)
-		ret = -EFAULT;
 err:
 	if (kdata != stack_kdata)
 		kfree(kdata);
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d1203da56fc5..d15b2b31d3c9 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -567,6 +567,7 @@ void dma_buf_unpin(struct dma_buf_attachment *attach);
 struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info);
 
 int dma_buf_fd(struct dma_buf *dmabuf, int flags);
+void dma_buf_fd_install(struct dma_buf *dmabuf, int fd);
 struct dma_buf *dma_buf_get(int fd);
 void dma_buf_put(struct dma_buf *dmabuf);
 
-- 
2.34.1

