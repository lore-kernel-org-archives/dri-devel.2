Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C60DCD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 09:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4604910E483;
	Thu, 21 May 2026 09:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="G8+CQlTQ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B251010E483
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779354662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/PCaVPAbPc0wJCZVNgUDA/e9ykpfDoQlMxFOJwanDFI=;
 b=G8+CQlTQdh38UCDGXAu859X2vQuA5kLjYOv0TsFDxtVTU94My9C7+Qh5zrL9k06Z8UIOBY
 zNyQDqFl40Fk+A95LLg5akQL1Wvqfz5m+0L24O4H058hmO16qY4QEmu85PWIDtc1XJZSVS
 jKC40kIu0vL71ZU0OeAgxjx+Q9cNfoM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-5AfHoqXmMYqWQbFsJppvBA-1; Thu,
 21 May 2026 05:10:57 -0400
X-MC-Unique: 5AfHoqXmMYqWQbFsJppvBA-1
X-Mimecast-MFC-AGG-ID: 5AfHoqXmMYqWQbFsJppvBA_1779354656
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0774180035D; Thu, 21 May 2026 09:10:55 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D16AC19560A6; Thu, 21 May 2026 09:10:52 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 21 May 2026 11:10:14 +0200
Subject: [PATCH 1/2] dma-buf: add DMA_BUF_IOCTL_DERIVE for
 reduced-permission aliases
MIME-Version: 1.0
Message-Id: <20260521-dmabuf-limit-access-v1-1-26c01e27365a@redhat.com>
References: <20260521-dmabuf-limit-access-v1-0-26c01e27365a@redhat.com>
In-Reply-To: <20260521-dmabuf-limit-access-v1-0-26c01e27365a@redhat.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779354648; l=6318;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=5Tv/PuOUE3lMfNJIxFBx6QKMiev0LMyHcGnY1FLbFjI=;
 b=+HlK3v2Xzm8Vf64ep+Nz1sznpvOeM1j58Tv1jogL0OTcxB9lXU3UhW8W5us50KJpKHWWv4Txy
 v3oGcjCaj+vAhNnTiz1EEsvzhBfy0/oKY/TzaUxusdwJ6eugzuQVYQB
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: CYcbrDz6LBDjMjYGcZhvwN1bBHwL9DLxFjmgO9Aqb4s_1779354656
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

When sharing a dma-buf between components of different trust levels,
the allocator may need to hand out a read-only view of a buffer it
holds with read-write access. Currently there is no mechanism to do
this: the file flags set at allocation time are fixed for the
lifetime of the dma-buf, and dup(2) and dup3(2) cannot change the
access mode of the new fd.

Add DMA_BUF_IOCTL_DERIVE, which takes a struct dma_buf_derive carrying
the desired access flags and returns a new file descriptor for the same
buffer with those flags applied. Permission escalation is rejected with
EACCES.

The new fd aliases the same struct dma_buf, same dma_resv, same exporter
ops, same underlying memory. Importers that attach to either fd operate
on the same object and observe the same fence timeline.

To support multiple struct file instances sharing one struct dma_buf,
two small internal adjustments are required. First, move
__dma_buf_list_del() to dma_buf_release() so that list removal fires
exactly once when the dentry is destroyed. Second, update
dma_buf_file_release() to call dma_buf_put() only for the files that
are not primary dmabuf files, leaving the primary fd's refcount managed
by the normal dentry lifecycle.

Finally, enforce the access restriction in dma_buf_mmap_internal():
a shared writable mapping (MAP_SHARED + PROT_WRITE) on a read-only fd
is rejected with -EACCES. Without this check, O_RDONLY on a dma-buf
fd would be cosmetic, as the VFS does not enforce f_mode for writable
mmap on anonymous inodes.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/dma-buf/dma-buf.c    | 58 +++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/dma-buf.h | 28 +++++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 71f37544a5c61..34a3872365730 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -180,6 +180,7 @@ static void dma_buf_release(struct dentry *dentry)
 	 */
 	BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
 
+	__dma_buf_list_del(dmabuf);
 	dmabuf->ops->release(dmabuf);
 
 	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
@@ -193,10 +194,13 @@ static void dma_buf_release(struct dentry *dentry)
 
 static int dma_buf_file_release(struct inode *inode, struct file *file)
 {
+	struct dma_buf *dmabuf = file->private_data;
+
 	if (!is_dma_buf_file(file))
 		return -EINVAL;
 
-	__dma_buf_list_del(file->private_data);
+	if (file != dmabuf->file)
+		dma_buf_put(dmabuf);
 
 	return 0;
 }
@@ -232,6 +236,11 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
 	if (!is_dma_buf_file(file))
 		return -EINVAL;
 
+	if ((vma->vm_flags & VM_WRITE) &&
+	    (vma->vm_flags & VM_SHARED) &&
+	    !(file->f_mode & FMODE_WRITE))
+		return -EACCES;
+
 	dmabuf = file->private_data;
 
 	/* check if buffer supports mmap */
@@ -537,6 +546,50 @@ static long dma_buf_import_sync_file(struct dma_buf *dmabuf,
 }
 #endif
 
+static const struct file_operations dma_buf_fops;
+
+static int dma_buf_ioctl_derive(struct dma_buf *dmabuf, struct file *file,
+				void __user *udata)
+{
+	struct dma_buf_derive params;
+	struct file *new_file;
+	int new_fd;
+
+	if (copy_from_user(&params, udata, sizeof(params)))
+		return -EFAULT;
+
+	if (params.flags & ~(O_ACCMODE | O_CLOEXEC))
+		return -EINVAL;
+
+	/* Escalating permissions is not allowed. */
+	if ((params.flags & O_ACCMODE) == O_RDWR &&
+	    !(file->f_mode & FMODE_WRITE))
+		return -EACCES;
+
+	new_file = alloc_file_clone(dmabuf->file, params.flags, &dma_buf_fops);
+	if (IS_ERR(new_file))
+		return PTR_ERR(new_file);
+
+	get_dma_buf(dmabuf);
+	new_file->private_data = dmabuf;
+
+	new_fd = get_unused_fd_flags(params.flags & O_CLOEXEC ? O_CLOEXEC : 0);
+	if (new_fd < 0) {
+		fput(new_file);
+		return new_fd;
+	}
+
+	params.fd = new_fd;
+	if (copy_to_user(udata, &params, sizeof(params))) {
+		put_unused_fd(new_fd);
+		fput(new_file);
+		return -EFAULT;
+	}
+
+	fd_install(new_fd, new_file);
+	return 0;
+}
+
 static long dma_buf_ioctl(struct file *file,
 			  unsigned int cmd, unsigned long arg)
 {
@@ -587,6 +640,9 @@ static long dma_buf_ioctl(struct file *file,
 		return dma_buf_import_sync_file(dmabuf, (const void __user *)arg);
 #endif
 
+	case DMA_BUF_IOCTL_DERIVE:
+		return dma_buf_ioctl_derive(dmabuf, file, (void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
index e827c9d20c5d3..d0cf616228e55 100644
--- a/include/uapi/linux/dma-buf.h
+++ b/include/uapi/linux/dma-buf.h
@@ -168,6 +168,33 @@ struct dma_buf_import_sync_file {
 	__s32 fd;
 };
 
+/**
+ * struct dma_buf_derive - Obtain a dma-buf fd with reduced access permissions
+ *
+ * Userspace can perform a DMA_BUF_IOCTL_DERIVE to obtain a second file
+ * descriptor for the same dma-buf with a subset of the calling fd's
+ * permissions.  This allows a producer holding read-write access to hand a
+ * read-only view to a less-privileged consumer without giving up its own
+ * write access or allocating a separate buffer.
+ *
+ * Unlike first-export ioctls, the new fd is not a re-export. It shares the
+ * same reservation object, exporter ops, and underlying memory as the
+ * original.
+ *
+ * The requested permissions must not exceed those of the calling fd.
+ */
+struct dma_buf_derive {
+	/**
+	 * @flags: Requested access flags.
+	 *
+	 * Accepts O_RDONLY or O_RDWR, optionally combined with O_CLOEXEC.
+	 * All other bits must be zero.
+	 */
+	__u32 flags;
+	/** @fd: Returned file descriptor with the requested permissions */
+	__s32 fd;
+};
+
 #define DMA_BUF_BASE		'b'
 #define DMA_BUF_IOCTL_SYNC	_IOW(DMA_BUF_BASE, 0, struct dma_buf_sync)
 
@@ -179,5 +206,6 @@ struct dma_buf_import_sync_file {
 #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
 #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2, struct dma_buf_export_sync_file)
 #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct dma_buf_import_sync_file)
+#define DMA_BUF_IOCTL_DERIVE		_IOWR(DMA_BUF_BASE, 4, struct dma_buf_derive)
 
 #endif

-- 
2.53.0

