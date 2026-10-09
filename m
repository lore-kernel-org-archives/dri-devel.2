Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4451CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B8B10FF71;
	Fri,  9 Oct 2026 12:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="rpO4/3FB";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A028810FF71
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1791549397;
 bh=XmAenBlP7DbUUemymePNJYiKbLwTRwfdH+7X2z65zF4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rpO4/3FBI2p6NdLT9MjohIOgcfY7N65MicI4FXbdSQHy2j4R3LZVl8vBYBcMLI2aV
 /nLnT2pDYZIBa9a7Hg11FMv6SSL2gsNl7GfMvmfFopryKfoe2jSQO6KbxVLJUJMKsN
 0V5aZPWhX8wOlfPflqfdbNK1GN5JeKCk9qsD+RYP4WTWvoRKwlJuSi5atinEU3JT/H
 Ws6AKcE5tRAjGMakPMKK1KGeKiGCoeTVX7QDRJGIeqT8XI4MqMQh9o4a+q4tuDTZsw
 VxIwA9Xbn9ACnmmRehidEZti+XsXss5hdqacuFPWaS50ZVc9bWVCA0YjW2+w4YG1ke
 WmYN+US4g95UQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4j1RF05YG1z4wSy;
 Fri, 09 Oct 2026 23:36:36 +1100 (AEDT)
From: Matt Evans <matt@ozlabs.org>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Zack Rusin <zack.rusin@broadcom.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v2 2/2] dma-buf: Annul dmabuf->file on file release
Date: Fri,  9 Oct 2026 13:35:56 +0100
Message-ID: <20261009123601.94079-3-matt@ozlabs.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009123601.94079-1-matt@ozlabs.org>
References: <20261009123601.94079-1-matt@ozlabs.org>
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

The dmabuf release path is split between file and dentry release:
dma_buf_file_release() is called shortly before the file is freed, and
dma_buf_release() calls an exporter's dmabuf->ops->release when the
dentry is freed.  However, the dentry can outlive the file (for
example, if opened with O_PATH), meaning .release might be called some
time after the file is freed.

This presents a window, when closing a DMABUF file, in which
dmabuf->file points to freed memory yet .release op has not yet been
called.

For VFIO, if a buffer's .release has not been called it's considered
still active and subject to move/cleanup.  If so, it attempts to
get_file_active() on dmabuf->file: a file close with dentry held open
will call this function with a stale pointer, a UAF.

To make this pattern safe, set dmabuf->file to NULL in
dma_buf_file_release() to reflect that the associated file is now dead
even if the DMABUF is not yet gone.  A get_file_active() ... fput()
sequence concurrent with a file close then only executes as one of:

 - Gets the file before file_ref_put() (dmabuf->file valid)
 - Observes dmabuf->file pointing to a file, but it's DEAD (no file)
 - Observes dmabuf->file = NULL (no file)

Originally, drivers could assume dmabuf->file was valid until .release
was called from fops->release.  This assumption was no longer valid
after 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
dentry_ops"), which moved the callback to the dentry release (by which
point the file might have been freed).  With this commit, drivers must
still consider that dmabuf->file could be NULL before .release.

Cc: stable@vger.kernel.org
Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentry_ops")
Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/dma-buf/dma-buf.c | 21 ++++++++++++++++++---
 include/linux/dma-buf.h   |  4 +++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 4c9add51f9ef..61485fc28b8b 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -193,11 +193,26 @@ static void dma_buf_release(struct dentry *dentry)
 
 static int dma_buf_file_release(struct inode *inode, struct file *file)
 {
-	if (!is_dma_buf_file(file))
-		return -EINVAL;
+	struct dma_buf *dmabuf = file->private_data;
+
+	if (!dmabuf)
+		return 0;
 
-	__dma_buf_list_del(file->private_data);
+	__dma_buf_list_del(dmabuf);
 
+	/*
+	 * As the file is being closed, dmabuf->file is no longer
+	 * valid and NULL replaces an otherwise stale pointer.  If a
+	 * reference to the file isn't already held, the file can be
+	 * closed at any time, including before dmabuf->ops->release()
+	 * happens: dmabuf->file _must not_ be accessed directly.  An
+	 * exporter should use get_file_active(&dmabuf->file) which
+	 * atomically tests and acquires a reference to the file (or
+	 * returns NULL if the file has closed).  The barrier ensures
+	 * get_file_active() observes the store before file_free()
+	 * frees the memory.
+	 */
+	smp_store_mb(dmabuf->file, NULL);
 	return 0;
 }
 
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d15b2b31d3c9..9f3c92c71c29 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -303,7 +303,9 @@ struct dma_buf {
 	 * @file:
 	 *
 	 * File pointer used for sharing buffers across, and for refcounting.
-	 * See dma_buf_get() and dma_buf_put().
+	 * See dma_buf_get() and dma_buf_put().  Exporters can use
+	 * get_file_active(&dma_buf->file) to safely acquire a reference;
+	 * the file could otherwise be closed at any time.
 	 */
 	struct file *file;
 
-- 
2.47.3

