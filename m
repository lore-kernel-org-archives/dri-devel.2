Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3EF606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B74210F33B;
	Tue, 27 Oct 2026 09:32:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C6D10F2ED
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 09:09:32 +0000 (UTC)
X-UUID: 1a58ffb4d1e611f19a56ed5b684f684d-20261027
X-CTIC-Tags: HR_CC_CHARSET, HR_CC_CHARSET_NUM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT,
 HR_CC_NAME
 HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS
 HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
 IP_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_EXISTED
 SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
 CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
 ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:096f0fea-8efb-4f92-ad16-056a18c09964, IP:10,
 URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:10
X-CID-INFO: VERSION:1.3.19, REQID:096f0fea-8efb-4f92-ad16-056a18c09964, IP:10,
 UR
 L:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:10
X-CID-META: VersionHash:7db8b62, CLOUDID:d58fc6dcd6843fb4ea2fe9b6f2f3f10d,
 BulkI
 D:261027170927OXGODN0I,BulkQuantity:1,SF:17|19|38|66|78|81|82|102|127|865|
 898,TC:nil,Content:0|15|50|99,EDM:5,IP:-2|1,URL:0,File:nil,RT:nil,Bulk:40,
 QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
 ,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_IBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1a58ffb4d1e611f19a56ed5b684f684d-20261027
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.169)] by mailgw.kylinos.cn
 (envelope-from <liwang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 342057761; Tue, 27 Oct 2026 17:09:23 +0800
From: Li Wang <liwang@kylinos.cn>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mengmeng Zhao <zhaomengmeng@kylinos.cn>, Li Wang <liwang@kylinos.cn>
Subject: [RFC PATCH v2 1/1] misc: fgds: introduce GPU-File direct I/O via
 dma-buf
Date: Tue, 27 Oct 2026 17:08:53 +0800
Message-Id: <20261027090853.30099-2-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027090853.30099-1-liwang@kylinos.cn>
References: <20260908131545.105987-1-liwang@kylinos.cn>
 <20261027090853.30099-1-liwang@kylinos.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mengmeng Zhao <zhaomengmeng@kylinos.cn>

This patch introduces a driver that allows moving data between a GPU
dma-buf and a regular file on NVME without staging it through the page 
cache. Userspace registers the GPU dma-buf with the device, then issues 
read and write requests via the device's ioctls. Each transfer is direct 
I/O: an ITER_DMABUF_MAP iterator is passed to the file's read_iter or
write_iter, and the filesystem's iomap path submits REQ_DMABUF bios that
already carry the dma addresses.

Signed-off-by: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 drivers/dma-buf/dma-buf-io.c                  |   3 +
 drivers/misc/Kconfig                          |  16 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/fgds.c                           | 506 ++++++++++++++++++
 fs/iomap/buffered-io.c                        |  11 +
 fs/iomap/direct-io.c                          |  23 +-
 fs/xfs/xfs_file.c                             |   4 +
 include/linux/iov_iter.h                      |   4 +
 include/uapi/linux/fgds.h                     | 124 +++++
 lib/iov_iter.c                                |   1 +
 mm/filemap.c                                  |  22 +-
 12 files changed, 713 insertions(+), 4 deletions(-)
 create mode 100644 drivers/misc/fgds.c
 create mode 100644 include/uapi/linux/fgds.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 2fc53093752d..5f93a252e773 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -306,6 +306,8 @@ Code  Seq#    Include File                                             Comments
 'v'   20-27  arch/powerpc/include/uapi/asm/vas-api.h                   VAS API
 'v'   C0-FF  linux/meye.h                                              conflict!
 'w'   all                                                              CERN SCI driver
+'x'   00-0F  linux/fgds.h                                              Fast GPU Direct Storage
+                                                                       <mailto:liwang@kylinos.cn>
 'y'   00-1F                                                            packet based user level communications
                                                                        <mailto:zapman@interlan.net>
 'z'   00-3F                                                            CAN bus card conflict!
diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
index 8440151de860..2ee4fc683c74 100644
--- a/drivers/dma-buf/dma-buf-io.c
+++ b/drivers/dma-buf/dma-buf-io.c
@@ -135,6 +135,7 @@ struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
 	dma_resv_unlock(ctx->dmabuf->resv);
 	return map;
 }
+EXPORT_SYMBOL_NS_GPL(dma_buf_io_create_map, "DMA_BUF");
 
 static void dma_buf_io_ctx_shutdown(struct dma_buf_io_ctx *ctx)
 {
@@ -190,6 +191,7 @@ int dma_buf_io_ctx_create(struct file *file,
 	*out_ctx = ctx;
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(dma_buf_io_ctx_create, "DMA_BUF");
 
 /**
  * dma_buf_io_ctx_release - Destroy the I/O context
@@ -211,6 +213,7 @@ void dma_buf_io_ctx_release(struct dma_buf_io_ctx *ctx)
 	dma_buf_put(ctx->dmabuf);
 	kfree(ctx);
 }
+EXPORT_SYMBOL_NS_GPL(dma_buf_io_ctx_release, "DMA_BUF");
 
 /**
  * dma_buf_io_invalidate_mappings - Invalidate the current map
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 7364931dad3a..b85fd64d27ad 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -568,6 +568,22 @@ config MCHP_LAN966X_PCI
 	    - lan966x-miim (MDIO_MSCC_MIIM)
 	    - lan966x-switch (LAN966X_SWITCH)
 
+config FGDS
+	tristate "Fast GPU Direct Storage support"
+	depends on DMA_SHARED_BUFFER && BLOCK
+	default n
+	help
+	  This driver exposes a misc device that moves data between a GPU
+	  dma-buf and a regular file with synchronous read/write ioctls,
+	  submitting the transfer as direct I/O (REQ_DMABUF bios) through
+	  the file system's iomap DIO path without a page cache bounce
+	  buffer.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called fgds.
+
+	  If unsure, say N.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e8d8d5d88c0d..cd98ef3d008e 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -70,4 +70,5 @@ obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
 obj-y				+= keba/
 obj-y				+= amd-sbi/
 obj-$(CONFIG_MISC_RP1)		+= rp1/
+obj-$(CONFIG_FGDS)		+= fgds.o
 obj-$(CONFIG_INTEL_SSEI)	+= issei/
diff --git a/drivers/misc/fgds.c b/drivers/misc/fgds.c
new file mode 100644
index 000000000000..3929a6514d23
--- /dev/null
+++ b/drivers/misc/fgds.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Fast GPU Direct Storage via dma-buf.
+ *
+ * Copyright (C) 2026 KylinSoft. Co., Ltd. All rights reserved.
+ *
+ * Synchronous read/write ioctls that move data between a GPU dma-buf and
+ * a regular file.
+ */
+
+#include <linux/blkdev.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-buf-io.h>
+#include <linux/device.h>
+#include <linux/fcntl.h>
+#include <linux/fileattr.h>
+#include <linux/fs.h>
+#include <linux/fsnotify.h>
+#include <linux/magic.h>
+#include <linux/math.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/pagemap.h>
+#include <linux/sched/xacct.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/uio.h>
+#include <linux/xarray.h>
+
+#include <linux/fgds.h>
+
+static struct miscdevice fgds_misc;
+
+/* One registered buffer: a dma-buf bound to a block device. */
+struct fgds_reg {
+	struct kref		kref;
+	struct dma_buf_io_ctx	*ctx;
+	struct file		*bdev_file;
+	struct block_device	*bdev;
+	u64			size;
+};
+
+/* State of one /dev/fgds open file description; handles are private to it. */
+struct fgds_state {
+	struct xarray		regs;
+	/* protects @regs and, with the reg kref, the lifetime of entries */
+	struct mutex		lock;
+};
+
+static void fgds_reg_release(struct kref *kref)
+{
+	struct fgds_reg *reg = container_of(kref, struct fgds_reg, kref);
+
+	dma_buf_io_ctx_release(reg->ctx);
+	fput(reg->bdev_file);
+	kfree(reg);
+}
+
+static void fgds_reg_put(struct fgds_reg *reg)
+{
+	kref_put(&reg->kref, fgds_reg_release);
+}
+
+static struct fgds_state *fgds_state(struct file *file)
+{
+	return file->private_data;
+}
+
+/*
+ * File and file-system level gate.
+ */
+static int fgds_gate(struct file *ffile)
+{
+	struct inode *inode = file_inode(ffile);
+	struct super_block *sb = inode->i_sb;
+	struct file_kattr fa;
+
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+	if (sb->s_magic != XFS_SUPER_MAGIC)
+		return -EOPNOTSUPP;
+	if (IS_DAX(inode))
+		return -EOPNOTSUPP;
+	if (mapping_stable_writes(inode->i_mapping))
+		return -EOPNOTSUPP;
+	if (!sb->s_bdev)
+		return -EOPNOTSUPP;
+	if (bdev_is_zoned(sb->s_bdev))
+		return -EOPNOTSUPP;
+	if (!sb->s_bdev->bd_disk->fops->init_dma_buf_io_ctx)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Realtime inodes live on a separate device whose DMA setup is not
+	 * covered here.
+	 */
+	if (vfs_fileattr_get(ffile->f_path.dentry, &fa))
+		return -EOPNOTSUPP;
+	if (fa.fsx_xflags & FS_XFLAG_REALTIME)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static unsigned int fgds_file_align(struct inode *inode, bool write)
+{
+	unsigned int lbs = bdev_logical_block_size(inode->i_sb->s_bdev);
+
+	if (!write)
+		return lbs;
+	return max(1U << inode->i_blkbits, lbs);
+}
+
+static unsigned int fgds_dma_align(struct inode *inode)
+{
+	return bdev_dma_alignment(inode->i_sb->s_bdev) + 1;
+}
+
+static struct fgds_reg *fgds_reg_get(struct fgds_state *state, u32 handle)
+{
+	struct fgds_reg *reg;
+
+	mutex_lock(&state->lock);
+	reg = xa_load(&state->regs, handle);
+	if (reg)
+		kref_get(&reg->kref);
+	mutex_unlock(&state->lock);
+	return reg;
+}
+
+static int fgds_unregister_handle(struct fgds_state *state, u32 handle)
+{
+	struct fgds_reg *reg;
+
+	mutex_lock(&state->lock);
+	reg = xa_erase(&state->regs, handle);
+	mutex_unlock(&state->lock);
+	if (reg)
+		fgds_reg_put(reg);
+	return reg ? 0 : -EINVAL;
+}
+
+static int fgds_register(struct file *file, struct fgds_register_args __user *uarg)
+{
+	struct fgds_register_args args;
+	struct fgds_state *state = fgds_state(file);
+	struct dma_buf_io_ctx *ctx = NULL;
+	struct block_device *bdev;
+	struct file *bdev_file;
+	struct dma_buf *dbuf;
+	struct fd bfdf;
+	struct fgds_reg *reg;
+	u32 id;
+	int ret;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+	if (args.handle || args.pad || args.reserved)
+		return -EINVAL;
+
+	dbuf = dma_buf_get(args.dfd);
+	if (IS_ERR(dbuf))
+		return PTR_ERR(dbuf);
+
+	bfdf = fdget(args.bdev_fd);
+	if (fd_empty(bfdf)) {
+		ret = -EBADF;
+		goto out_dmabuf;
+	}
+	bdev_file = fd_file(bfdf);
+	if (!S_ISBLK(file_inode(bdev_file)->i_mode)) {
+		ret = -EINVAL;
+		goto out_fdput;
+	}
+	/* blkdev_init_dma_buf_io_ctx() needs O_DIRECT. */
+	if (!(bdev_file->f_flags & O_DIRECT)) {
+		ret = -EINVAL;
+		goto out_fdput;
+	}
+
+	bdev = file_bdev(bdev_file);
+	if (!bdev->bd_disk->fops->init_dma_buf_io_ctx) {
+		ret = -EOPNOTSUPP;
+		goto out_fdput;
+	}
+
+	ret = -ENOMEM;
+	reg = kzalloc_obj(*reg);
+	if (!reg)
+		goto out_fdput;
+
+	get_file(bdev_file);
+
+	ret = dma_buf_io_ctx_create(bdev_file, dbuf, DMA_BIDIRECTIONAL, &ctx);
+	if (ret) {
+		dev_err(fgds_misc.this_device,
+			"dma-buf-io context on %pg failed: %pe\n",
+			bdev, ERR_PTR(ret));
+		goto out_file;
+	}
+
+	kref_init(&reg->kref);
+	reg->ctx = ctx;
+	reg->bdev_file = bdev_file;
+	reg->bdev = bdev;
+	reg->size = dbuf->size;
+
+	mutex_lock(&state->lock);
+	ret = xa_alloc(&state->regs, &id, reg, XA_LIMIT(1, UINT_MAX),
+		       GFP_KERNEL);
+	if (ret) {
+		mutex_unlock(&state->lock);
+		goto out_ctx;
+	}
+
+	args.handle = id;
+	/* the window must stay inside the buffer and within 32 bits */
+	args.max_doffset = min_t(u64, reg->size, UINT_MAX);
+
+	if (copy_to_user(uarg, &args, sizeof(args))) {
+		xa_erase(&state->regs, id);
+		mutex_unlock(&state->lock);
+		ret = -EFAULT;
+		goto out_ctx;
+	}
+	mutex_unlock(&state->lock);
+
+	fdput(bfdf);
+	dma_buf_put(dbuf);
+	return 0;
+
+out_ctx:
+	dma_buf_io_ctx_release(ctx);
+out_file:
+	fput(bdev_file);
+	kfree(reg);
+out_fdput:
+	fdput(bfdf);
+out_dmabuf:
+	dma_buf_put(dbuf);
+	return ret;
+}
+
+static int fgds_unregister(struct file *file, struct fgds_unregister_args __user *uarg)
+{
+	struct fgds_unregister_args args;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+	if (args.reserved)
+		return -EINVAL;
+	return fgds_unregister_handle(fgds_state(file), args.handle);
+}
+
+/*
+ * Launch one read_iter()/write_iter() call.
+ * Returns the number of bytes the file system moved, or a negative
+ * errno; a short read means the end of the file.
+ */
+static ssize_t fgds_do_rw(struct fgds_state *state,
+			  const struct fgds_rw_args *args, bool write)
+{
+	struct fgds_reg *reg;
+	struct dma_buf_io_map *map;
+	struct file *ffile;
+	struct inode *inode;
+	struct iov_iter iter;
+	struct kiocb kiocb;
+	struct fd fdf;
+	ssize_t (*iter_fn)(struct kiocb *kiocb, struct iov_iter *i);
+	unsigned int file_align, dma_align;
+	u64 length = args->length;
+	u64 dbuf_end;
+	loff_t offset, end;
+	ssize_t ret;
+
+	if (args->flags)
+		return -EINVAL;
+	if (length > MAX_RW_COUNT)
+		return -EINVAL;
+
+	offset = args->offset;
+	if (offset < 0 || check_add_overflow(offset, (loff_t)length, &end))
+		return -EINVAL;
+	/*
+	 * The block layer's dma-buf iterator truncates the segment offset to
+	 * 32 bits, and the window must stay inside the registered buffer.
+	 */
+	if (check_add_overflow(args->doffset, length, &dbuf_end))
+		return -EINVAL;
+	if (dbuf_end > UINT_MAX)
+		return -EINVAL;
+
+	fdf = fdget(args->ffd);
+	if (fd_empty(fdf))
+		return -EBADF;
+	ffile = fd_file(fdf);
+	inode = file_inode(ffile);
+
+	ret = -EINVAL;
+	if (!S_ISREG(inode->i_mode) || (ffile->f_flags & O_APPEND))
+		goto out_fdput;
+
+	if (write) {
+		if (!(ffile->f_mode & FMODE_WRITE) ||
+		    !(ffile->f_mode & FMODE_CAN_WRITE))
+			goto out_fdput;
+		iter_fn = ffile->f_op->write_iter;
+	} else {
+		if (!(ffile->f_mode & FMODE_READ) ||
+		    !(ffile->f_mode & FMODE_CAN_READ))
+			goto out_fdput;
+		iter_fn = ffile->f_op->read_iter;
+	}
+	if (!iter_fn) {
+		ret = -EOPNOTSUPP;
+		goto out_fdput;
+	}
+
+	ret = fgds_gate(ffile);
+	if (ret)
+		goto out_fdput;
+
+	reg = fgds_reg_get(state, args->handle);
+	if (!reg) {
+		ret = -EINVAL;
+		goto out_fdput;
+	}
+
+	if (inode->i_sb->s_bdev != reg->bdev) {
+		ret = -EXDEV;
+		goto out_reg;
+	}
+
+	file_align = fgds_file_align(inode, write);
+	dma_align = fgds_dma_align(inode);
+	if ((offset | (loff_t)length) & (file_align - 1) ||
+	    (args->doffset | (loff_t)length) & (dma_align - 1) ||
+	    dbuf_end > reg->size ||
+	    (!write && end > i_size_read(inode))) {
+		ret = -EINVAL;
+		goto out_reg;
+	}
+
+	ret = rw_verify_area(write ? WRITE : READ, ffile, &offset, length);
+	if (ret)
+		goto out_reg;
+	if (write)
+		inc_syscw(current);
+	else
+		inc_syscr(current);
+
+	if (!length) {
+		ret = 0;
+		goto out_reg;
+	}
+
+	map = dma_buf_io_get_map(reg->ctx, false);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		if (ret != -EAGAIN)
+			dev_err_ratelimited(fgds_misc.this_device,
+					    "dma-buf mapping failed on %pg: %pe\n",
+					    reg->bdev, ERR_PTR(ret));
+		goto out_reg;
+	}
+
+	/*
+	 * A direct I/O read would leave any cached pages of the range
+	 * stale, so flush and drop them before submitting.
+	 */
+	if (!write) {
+		ret = filemap_write_and_wait_range(ffile->f_mapping,
+						   offset, end - 1);
+		if (ret)
+			goto out_map;
+		ret = invalidate_inode_pages2_range(ffile->f_mapping,
+						    offset >> PAGE_SHIFT,
+						    (end - 1) >> PAGE_SHIFT);
+		if (ret) {
+			/*
+			 * Report a retryable error instead of letting
+			 * -EBUSY escape.
+			 */
+			if (ret == -EBUSY)
+				ret = -EAGAIN;
+			goto out_map;
+		}
+	}
+
+	if (write)
+		file_start_write(ffile);
+	iov_iter_dmabuf_map(&iter, write ? ITER_SOURCE : ITER_DEST,
+			    map, args->doffset, length);
+	init_sync_kiocb(&kiocb, ffile);
+	kiocb.ki_flags |= IOCB_DIRECT;
+	if (write)
+		kiocb.ki_flags |= IOCB_WRITE;
+	kiocb.ki_pos = offset;
+
+	ret = iter_fn(&kiocb, &iter);
+	if (WARN_ON_ONCE(ret == -EIOCBQUEUED))
+		ret = -EIO;
+	if (write)
+		file_end_write(ffile);
+
+	if (ret > 0) {
+		if (write) {
+			fsnotify_modify(ffile);
+			add_wchar(current, ret);
+		} else {
+			fsnotify_access(ffile);
+			add_rchar(current, ret);
+		}
+	}
+
+out_map:
+	dma_buf_io_map_drop(map);
+out_reg:
+	fgds_reg_put(reg);
+out_fdput:
+	fdput(fdf);
+	return ret;
+}
+
+static long fgds_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct fgds_state *state = fgds_state(file);
+	struct fgds_rw_args args;
+
+	switch (cmd) {
+	case FGDS_IOCTL_WRITE:
+	case FGDS_IOCTL_READ:
+		if (copy_from_user(&args, (void __user *)arg, sizeof(args)))
+			return -EFAULT;
+		return fgds_do_rw(state, &args, cmd == FGDS_IOCTL_WRITE);
+	case FGDS_IOCTL_REGISTER_BUF:
+		return fgds_register(file, (struct fgds_register_args __user *)arg);
+	case FGDS_IOCTL_UNREGISTER_BUF:
+		return fgds_unregister(file, (struct fgds_unregister_args __user *)arg);
+	}
+	return -ENOTTY;
+}
+
+static int fgds_open(struct inode *inode, struct file *file)
+{
+	struct fgds_state *state;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return -ENOMEM;
+
+	xa_init_flags(&state->regs, XA_FLAGS_ALLOC);
+	mutex_init(&state->lock);
+	file->private_data = state;
+	return 0;
+}
+
+static int fgds_release(struct inode *inode, struct file *file)
+{
+	struct fgds_state *state = fgds_state(file);
+	struct fgds_reg *reg;
+	unsigned long id;
+
+	xa_for_each(&state->regs, id, reg) {
+		xa_erase(&state->regs, id);
+		fgds_reg_put(reg);
+	}
+	xa_destroy(&state->regs);
+	mutex_destroy(&state->lock);
+	kfree(state);
+	return 0;
+}
+
+static const struct file_operations fgds_fops = {
+	.owner		= THIS_MODULE,
+	.open		= fgds_open,
+	.release	= fgds_release,
+	.unlocked_ioctl	= fgds_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+};
+
+static struct miscdevice fgds_misc = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "fgds",
+	.fops	= &fgds_fops,
+};
+
+static int __init fgds_init(void)
+{
+	return misc_register(&fgds_misc);
+}
+
+static void __exit fgds_exit(void)
+{
+	misc_deregister(&fgds_misc);
+}
+
+module_init(fgds_init);
+module_exit(fgds_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("DMA_BUF");
+MODULE_AUTHOR("Mengmeng Zhao <zhaomengmeng@kylinos.cn>, Li Wang <liwang@kylinos.cn>");
+MODULE_DESCRIPTION("Fast GPU Direct Storage");
+MODULE_VERSION("1.0.0");
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0a5ebfda90f1..a7ab28edab98 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1304,6 +1304,17 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 	};
 	ssize_t ret;
 
+	/*
+	 * The copy helpers have no source for a dma-buf iterator: the copy
+	 * would move zero bytes, ->write_end() would reject the untouched
+	 * folio, fault_in_iov_iter_readable() reports the iterator as
+	 * readable, and the loop below would never advance.  Refuse here
+	 * rather than at each caller's entry point, so no path can reach
+	 * the copy with such an iterator.
+	 */
+	if (iov_iter_is_dmabuf_map(i))
+		return -EOPNOTSUPP;
+
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iter.flags |= IOMAP_NOWAIT;
 	if (iocb->ki_flags & IOCB_DONTCACHE)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8b4039d16ce8..eccc07d53e9c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -595,8 +595,16 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 
 static int iomap_dio_hole_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 {
-	loff_t length = iov_iter_zero(iomap_length(iter), dio->submit.iter);
+	loff_t length;
 
+	/*
+	 * dmabuf maps do not support zero-filling holes or
+	 * unwritten extents.
+	 */
+	if (iov_iter_is_dmabuf_map(dio->submit.iter))
+		return -EOPNOTSUPP;
+
+	length = iov_iter_zero(iomap_length(iter), dio->submit.iter);
 	dio->size += length;
 	if (!length)
 		return -EFAULT;
@@ -683,8 +691,8 @@ static int iomap_dio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
  * the correct total number of bytes transferred; this is essential for
  * completing partial requests asynchronously.
  *
- * Returns -ENOTBLK In case of a page invalidation invalidation failure for
- * writes.  The callers needs to fall back to buffered I/O in this case.
+ * Returns -ENOTBLK in case of a page cache invalidation failure for writes.
+ * The caller needs to fall back to buffered I/O in this case.
  */
 struct iomap_dio *
 __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
@@ -794,6 +802,15 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 					 * the caller tries again.
 					 */
 					ret = -EAGAIN;
+				} else if (iov_iter_is_dmabuf_map(iter)) {
+					/*
+					 * Avoid -ENOTBLK (buffered fallback)
+					 * as dmabuf are not supported. Map
+					 * -EBUSY to -EAGAIN for transient
+					 * retires.
+					 */
+					if (ret == -EBUSY)
+						ret = -EAGAIN;
 				} else {
 					/* fall back to buffered write */
 					ret = -ENOTBLK;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 426a67b813a7..f16e9cb63e9e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1211,6 +1211,10 @@ xfs_file_write_iter(
 			return ret;
 	}
 
+	/* zoned and buffered I/O is not supported for dmabuf */
+	if (iov_iter_is_dmabuf_map(from))
+		return -EOPNOTSUPP;
+
 	if (xfs_is_zoned_inode(ip))
 		return xfs_file_buffered_write_zoned(iocb, from);
 	return xfs_file_buffered_write(iocb, from);
diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index 2f91884d733b..a3b99e6d8255 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -376,6 +376,10 @@ size_t iterate_and_advance_kernel(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_folioq(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
 		return iterate_xarray(iter, len, priv, priv2, step);
+	if (iov_iter_is_dmabuf_map(iter)) {
+		WARN_ON_ONCE(1);
+		return 0;
+	}
 	return iterate_discard(iter, len, priv, priv2, step);
 }
 
diff --git a/include/uapi/linux/fgds.h b/include/uapi/linux/fgds.h
new file mode 100644
index 000000000000..9a721c92cde2
--- /dev/null
+++ b/include/uapi/linux/fgds.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Fast GPU Direct Storage user-kernel ABI definitions.
+ *
+ * Copyright (C) 2026 KylinSoft. Co., Ltd. All rights reserved.
+ *
+ * Synchronous read/write ioctls that move data between a GPU dma-buf and
+ * a regular file.
+ */
+#ifndef _FGDS_H
+#define _FGDS_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/**
+ * struct fgds_register_args - arguments for %FGDS_IOCTL_REGISTER_BUF
+ *
+ * @dfd:         dma-buf file descriptor exported by the GPU runtime.
+ * @bdev_fd:     file descriptor of the underlying block device (the
+ *               device the target files live on), opened with %O_DIRECT.
+ *               The device is named separately from the file because:
+ *               building the dma-buf I/O context needs a file for the
+ *               device itself, and the device side requires %O_DIRECT
+ *               on that file, which a regular file descriptor cannot
+ *               provide.
+ * @handle:      Returned handle for use with the other ioctls.  Handles
+ *               are private to the /dev/fgds file descriptor they were
+ *               created on and are released automatically when that
+ *               descriptor is closed.  Output.
+ * @pad:         Must be 0.
+ * @max_doffset: Largest accepted value of @doffset plus @length: the
+ *               window must stay inside the registered dma-buf and
+ *               within the 32-bit offset bound of the block-layer
+ *               dma-buf iterator, so this reports the smaller of the
+ *               dma-buf size and %UINT_MAX.  Output.
+ * @reserved:    Must be 0.  Extension slot for further output fields.
+ *
+ * A registered handle keeps the device attachment alive, and once a
+ * transfer has mapped the buffer that mapping is held for the handle's
+ * lifetime.
+ *
+ * Returns 0, or a negative errno.
+ */
+struct fgds_register_args {
+	__s32 dfd;
+	__s32 bdev_fd;
+	__u32 handle;
+	__u32 pad;
+	__u64 max_doffset;
+	__u64 reserved;
+};
+
+/**
+ * struct fgds_unregister_args - arguments for %FGDS_IOCTL_UNREGISTER_BUF
+ *
+ * @handle:   Handle returned by %FGDS_IOCTL_REGISTER_BUF.  Input.
+ * @reserved: Must be 0.
+ *
+ * Returns 0, or -EINVAL if @handle is not registered on this file
+ * descriptor.
+ */
+struct fgds_unregister_args {
+	__u32 handle;
+	__u32 reserved;
+};
+
+/**
+ * struct fgds_rw_args - arguments for %FGDS_IOCTL_WRITE / %FGDS_IOCTL_READ
+ *
+ * @handle:      Handle from %FGDS_IOCTL_REGISTER_BUF naming both the
+ *               dma-buf and the block device to transfer between.  Input.
+ * @ffd:         Regular file descriptor.  %O_DIRECT is not required on
+ *               it, fgds forces the direct I/O path itself.  Its file
+ *               system's device must match the one registered with
+ *               @handle or the transfer fails with %EXDEV.  Input.
+ * @offset:      Byte offset inside the file. Input.
+ * @length:      Transfer length in bytes. Unlike pread() and pwrite(),
+ *               which silently truncate an oversized request, fgds rejects
+ *               it with %EINVAL. Input.
+ * @doffset:     Byte offset inside the dma-buf, i.e. the start of the
+ *               window the transfer reads from or writes to. Input.
+ * @flags:       Must be 0.  Input.
+ *
+ * Like pread() and pwrite(), the ioctl returns the number of bytes
+ * transferred or a negative errno. A return value below @length means a
+ * read stopped at the end of the file, or a write clamped by the calling
+ * process' RLIMIT_FSIZE.
+ *
+ * Contract and failure modes:
+ *
+ * - Alignment is enforced on two independent axes, both answered by
+ *   statx() with %STATX_DIOALIGN.  The file side applies to @offset and
+ *   @length: the device logical block size for a read, the max of that
+ *   and the file system block size for a write. The buffer side applies
+ *   to @doffset and @length: the device DMA alignment. A transfer must
+ *   satisfy both axes at once.
+ * - Ranges backed by file holes or unwritten extents are not supported
+ *   for reads and fail with %EOPNOTSUPP: there is no page cache bounce
+ *   to serve zeros from, and GPU memory is generally not CPU accessible.
+ * - Writes past the end of the file go through the file system's own
+ *   direct I/O extend path; no preallocation is performed by fgds.  An
+ *   application that wants the space reserved must call fallocate()
+ *   itself first.
+ * - Reads flush and drop any page cache of the transferred range before
+ *   submitting, so subsequent buffered reads observe the fresh data.
+ */
+struct fgds_rw_args {
+	__u32 handle;
+	__s32 ffd;
+	__u64 offset;
+	__u64 length;
+	__u64 doffset;
+	__u64 flags;
+};
+
+#define FGDS_IOCTL_MAGIC	'x'
+
+#define FGDS_IOCTL_WRITE		_IOW(FGDS_IOCTL_MAGIC, 1, struct fgds_rw_args)
+#define FGDS_IOCTL_READ			_IOW(FGDS_IOCTL_MAGIC, 2, struct fgds_rw_args)
+#define FGDS_IOCTL_REGISTER_BUF		_IOWR(FGDS_IOCTL_MAGIC, 3, struct fgds_register_args)
+#define FGDS_IOCTL_UNREGISTER_BUF	_IOW(FGDS_IOCTL_MAGIC, 4, struct fgds_unregister_args)
+
+#endif /* _FGDS_H */
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9b46f9ada8f9..b19bf7f5e4cf 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -790,6 +790,7 @@ void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
 		.iov_offset = off,
 	};
 }
+EXPORT_SYMBOL_GPL(iov_iter_dmabuf_map);
 
 /**
  * iov_iter_discard - Initialise an I/O iterator that discards data
diff --git a/mm/filemap.c b/mm/filemap.c
index 6afec636881f..ab8a5391a699 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3013,6 +3013,14 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			return retval;
 	}
 
+	/*
+	 * Buffered I/O read is not supported for dmabuf; a short direct
+	 * read before this point stands on its own, as in
+	 * direct_write_fallback().
+	 */
+	if (iov_iter_is_dmabuf_map(iter))
+		return retval > 0 ? retval : -EOPNOTSUPP;
+
 	return filemap_read(iocb, iter, retval);
 }
 EXPORT_SYMBOL(generic_file_read_iter);
@@ -4300,8 +4308,14 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 */
 	written = kiocb_invalidate_pages(iocb, write_len);
 	if (written) {
-		if (written == -EBUSY)
+		if (written == -EBUSY) {
+			/*
+			 * Avoid fallback to buffered write for dmabuf.
+			 */
+			if (iov_iter_is_dmabuf_map(from))
+				return -EAGAIN;
 			return 0;
+		}
 		return written;
 	}
 
@@ -4353,6 +4367,12 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	long status = 0;
 	ssize_t written = 0;
 
+	/*
+	 * Buffered write is not supported for dmabuf.
+	 */
+	if (iov_iter_is_dmabuf_map(i))
+		return -EOPNOTSUPP;
+
 	do {
 		struct folio *folio;
 		size_t offset;		/* Offset into folio */
-- 
2.34.1

