Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A11C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 21:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE47F10E40C;
	Fri, 11 Sep 2026 21:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="lwuYwEPq";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E88E610E40C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 21:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1789162935;
 bh=5xcnpoD35EmZCq5dKKq2f9x4jElF9sti9rbyWs0IsIw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lwuYwEPqv19Pwy6bNYoMfy5/6A76BjqcJ+5RPM9dK0OY4mzZ7ZJpkR7/ANowRW+SW
 J8CEkuPHtummX3ZvxQnKWNvrcTQuUw97ShxcYxhJT2V/OWKJo0VJVAvq4nQC+LRVXN
 wsMhlYvP3pJa+dCAHsgJWqaMiK5SYBp7e3mzTIWKtHfV2oSb+C2uXmKCKMM7CF2ldQ
 WXcpt3Mw8sq7VQDtOHpa7zZYbJZggZNGH1hFCz1BUqRCrmFDNb+xrNOFQCW2ADRHzF
 8YfFhCv3yi12ZSRDsQA6qZgLCpCmWZ9GY4252AOGDoG7NrLhpiU9tADQuDodFKvnoL
 rA/WGqjqYUFDw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4hhSgV6hGgz4wDJ;
 Sat, 12 Sep 2026 07:42:14 +1000 (AEST)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: [PATCH v6 3/9] dma-buf: Export dma_buf_set_name()
Date: Fri, 11 Sep 2026 22:41:51 +0100
Message-ID: <20260911214200.33793-4-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260911214200.33793-1-matt@ozlabs.org>
References: <20260911214200.33793-1-matt@ozlabs.org>
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

dma_buf_set_name() originally took a __user string to duplicate for
the buffer name.  Make this function a generic set-name helper, taking
a kernel-allocated string.

Wrap this by a new dma_buf_set_name_user() to support the existing
ioctl path for a user-provided string.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/dma-buf/dma-buf.c | 58 ++++++++++++++++++++++++++++++---------
 include/linux/dma-buf.h   |  2 ++
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..8129ea11ff58 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -405,31 +405,29 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 }
 
 /**
- * dma_buf_set_name - Set a name to a specific dma_buf to track the usage.
- * It could support changing the name of the dma-buf if the same
- * piece of memory is used for multiple purpose between different devices.
+ * dma_buf_set_name_user - Set a dma_buf's name from a user string
+ *
+ * The string is up to DMA_BUF_NAME_LEN long, including the terminator.
  *
  * @dmabuf: [in]     dmabuf buffer that will be renamed.
  * @buf:    [in]     A piece of userspace memory that contains the name of
  *                   the dma-buf.
  *
- * Returns 0 on success. If the dma-buf buffer is already attached to
- * devices, return -EBUSY.
- *
+ * Returns 0 on success, and any previously-set name is freed.
  */
-static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
+static long dma_buf_set_name_user(struct dma_buf *dmabuf, const char __user *buf)
 {
 	char *name = strndup_user(buf, DMA_BUF_NAME_LEN);
+	int ret;
 
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
-	spin_lock(&dmabuf->name_lock);
-	kfree(dmabuf->name);
-	dmabuf->name = name;
-	spin_unlock(&dmabuf->name_lock);
+	ret = dma_buf_set_name(dmabuf, name);
+	if (ret)
+		kfree(name);
 
-	return 0;
+	return ret;
 }
 
 #if IS_ENABLED(CONFIG_SYNC_FILE)
@@ -578,7 +576,7 @@ static long dma_buf_ioctl(struct file *file,
 
 	case DMA_BUF_SET_NAME_A:
 	case DMA_BUF_SET_NAME_B:
-		return dma_buf_set_name(dmabuf, (const char __user *)arg);
+		return dma_buf_set_name_user(dmabuf, (const char __user *)arg);
 
 #if IS_ENABLED(CONFIG_SYNC_FILE)
 	case DMA_BUF_IOCTL_EXPORT_SYNC_FILE:
@@ -854,6 +852,40 @@ void dma_buf_put(struct dma_buf *dmabuf)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
 
+/**
+ * dma_buf_set_name - Set a dma_buf's name
+ * It could support changing the name of the dma-buf if the same piece
+ * of memory is used for multiple purpose between different devices.
+ *
+ * @dmabuf: [in]     dmabuf buffer that will be renamed.
+ * @name:   [in]     The name of the dma-buf, allocated with kmalloc() or
+ *                   similar.  This takes ownership of the allocation
+ *                   on success, which will be kfree()d when the
+ *                   dmabuf is released or a new name assigned.
+ *
+ * Returns 0 on success, -EINVAL if the name is NULL, or -E2BIG if the
+ * name exceeds DMA_BUF_NAME_LEN.
+ */
+int dma_buf_set_name(struct dma_buf *dmabuf, char *name)
+{
+	if (!name)
+		return -EINVAL;
+
+	/* dmabuffs_dname() won't use the string if the length
+	 * (including terminator) exceeds DMA_BUF_NAME_LEN:
+	 */
+	if (strlen(name) >= DMA_BUF_NAME_LEN)
+		return -E2BIG;
+
+	spin_lock(&dmabuf->name_lock);
+	kfree(dmabuf->name);
+	dmabuf->name = name;
+	spin_unlock(&dmabuf->name_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_set_name, "DMA_BUF");
+
 static int dma_buf_wrap_sg_table(struct sg_table **sg_table)
 {
 	struct scatterlist *to_sg, *from_sg;
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d1203da56fc5..14d3950b63c8 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -570,6 +570,8 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags);
 struct dma_buf *dma_buf_get(int fd);
 void dma_buf_put(struct dma_buf *dmabuf);
 
+int dma_buf_set_name(struct dma_buf *dmabuf, char *name);
+
 struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
 					enum dma_data_direction);
 void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
-- 
2.50.1 (Apple Git-155)

