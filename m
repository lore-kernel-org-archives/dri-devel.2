Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BA7C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D94710FBDB;
	Tue, 15 Sep 2026 11:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nIsDG6ms";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2538610FBDB
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:37:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D1E3602C4;
 Tue, 15 Sep 2026 11:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE2E1F00898;
 Tue, 15 Sep 2026 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789472269;
 bh=GNDTkXQI7mGdcVaT7SDrw9M8MIqod2XUSoHG2zw3J2w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nIsDG6msZxm9ifdIIaNBb4DSvDwZjxBexDpBy0k5+c0EEQRfRNHCnvgHTIY4Q0gZ4
 5Y4GAqy+82PffLbcvJlnpDdJKam2a1RZ/lmTtWzv5yc2Qa3CGs1EC2lgotUwdrCtPN
 R+e8tN55H2q/lzjefH/7MqxCwUMd/aRzXVOqaq/JIPnIQz/fh1lk4mDieRcetKm0Vz
 We6QD5SZZpeWs1skjtjC95uTXtri2f8p0027MOwC2PJ2AtBz1eyxEa8oFwDdJ/4IbQ
 1oi4l5RBwZ4QhEmCd9i4/Ab6QCou55Lo2D/xSrTRR5npBOhYvLPf8mp8Z+7okOyPo6
 hMky5BV0f8Xcg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:36 +0200
Subject: [PATCH RFC POC 50/50] Drivers: hv: mshv: stop putting descriptors
 back on failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-50-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SzeXPqGJtllJZEGwqHGcwxzZWYTunmeJfrbckytXGkI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KmPkjZIUeG9e+1R07epv8QvrSgMsrt/1D2tpUnF+
 Ty/n9jUjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlo3mb4Hx4+8+W/E5svyCgt
 bpvwatmUgujlCXflfc2DLyvdmH/HYCPDH44Jiw0OZie7VZtm8ZzaXLrdzmx2uNpNg59n94iEL7/
 iyAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/hv/mshv_root_main.c | 27 +++++++--------------------
 drivers/hv/mshv_vtl_main.c  | 20 +++++---------------
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index cc2cfce2aefd..c95cee0bae85 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1072,8 +1072,6 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	struct mshv_vp *vp;
 	struct page *intercept_msg_page, *register_page, *ghcb_page;
 	struct hv_stats_page *stats_pages[2];
-	struct file *file;
-	int fd;
 	long ret;
 
 	if (copy_from_user(&args, arg, sizeof(args)))
@@ -1148,19 +1146,14 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (ret)
 		goto put_partition;
 
-	fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
+	FD_PREPARE(fdf, O_RDWR | O_CLOEXEC,
+		   anon_inode_getfile("mshv_vp", &mshv_vp_fops, vp,
+				      O_RDWR | O_CLOEXEC));
+	if (IS_ERR(fdf)) {
+		ret = PTR_ERR(fdf);
 		goto remove_debugfs_vp;
 	}
 
-	file = anon_inode_getfile("mshv_vp", &mshv_vp_fops, vp,
-				  O_RDWR | O_CLOEXEC);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto put_unused_vp_fd;
-	}
-
 	/* already exclusive with the partition mutex for all ioctls */
 	partition->pt_vp_count++;
 	/*
@@ -1171,17 +1164,11 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	 */
 	smp_store_release(&partition->pt_vp_array[args.vp_index], vp);
 
-	/*
-	 * fd_install() is the userspace-visibility commit point.  Must be the
-	 * last operation that can fail or be observed.
-	 */
-	fd_install(fd, file);
-	ret = fd;
+	/* The syscall exit installs the file; nothing after this can fail. */
+	ret = fd_prepare_fd(fdf);
 
 	goto out;
 
-put_unused_vp_fd:
-	put_unused_fd(fd);
 remove_debugfs_vp:
 	mshv_debugfs_vp_remove(vp);
 put_partition:
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 6e3c11c68171..f14203d76da1 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -114,29 +114,19 @@ static long
 mshv_ioctl_create_vtl(void __user *user_arg, struct device *module_dev)
 {
 	struct mshv_vtl *vtl;
-	struct file *file;
-	int fd;
 
 	vtl = kzalloc_obj(*vtl);
 	if (!vtl)
 		return -ENOMEM;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		kfree(vtl);
-		return fd;
-	}
-	file = anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
-				  vtl, O_RDWR);
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   anon_inode_getfile("mshv_vtl", &mshv_vtl_fops, vtl, O_RDWR));
+	if (IS_ERR(fdf)) {
 		kfree(vtl);
-		return PTR_ERR(file);
+		return PTR_ERR(fdf);
 	}
 	vtl->module_dev = module_dev;
-	fd_install(fd, file);
-
-	return fd;
+	return fd_prepare_fd(fdf);
 }
 
 static long

-- 
2.53.0

