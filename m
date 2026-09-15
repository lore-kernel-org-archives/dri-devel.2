Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A8DC88E7B
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 029D810FBD8;
	Tue, 15 Sep 2026 11:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fNFTQOJL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD5E10FBD9
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:37:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B699B602C5;
 Tue, 15 Sep 2026 11:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE621F00893;
 Tue, 15 Sep 2026 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789472245;
 bh=mjqLYqkFC5yCbrRzMMvOpmvK8b+wb1Az5sELRN6Iqmw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fNFTQOJL+iGGO+zzzm7cDe+/taoDcFY7fewDCdDuBMLNk844/5YTOXExel7EKsF9S
 oLRnzjguOrHBG/PK7ZC549dR4lB6cSOioaIssgENRRB/BPi7+UG74t/yS8GmkCNH9C
 SYkWW/2u8YiYHbyNYlVSLFpnBvaUvCIp4Mwu/abM5lLuo8GHPpD/0L9dCr6/bh0kxz
 Ano4WmSOQb609KJxhLhb4QylzFqFY4npF26OT03shrB8BqGetnHALS1L68dHSQxDHf
 lkgeVcI6ujFF+0WS99WYyuepbVTQzAmtrQq19Z8PUhZtIGApiugszVbmJFY6aacriE
 TeUsi9M9eNUTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:33 +0200
Subject: [PATCH RFC POC 47/50] iio: buffer: install the buffer descriptor
 when the ioctl returns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-47-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RM8/Ryi0JBjisB2tI5DXR2rE8sCF/AliS5Zp4F8Qhf4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KkPFJZ6IZfMtyJ0UsaFFiuPoGWsPxtn3v1o+e3z3
 stfX0943lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR6LMM/yNudM+8naelq7Sn
 g+X00Zpv+usvL13mfINZZtGLrdYV3KkMfzjPLfxTceTH7fV1ATe3FQTfd1Vd7vTqOWPz3spdkTu
 WLmIFAA==
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
 drivers/iio/industrialio-buffer.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2c9ec93dff47..9fb15bf82d0a 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2041,7 +2041,7 @@ static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg
 	int __user *ival = (int __user *)arg;
 	struct iio_dev_buffer_pair *ib;
 	struct iio_buffer *buffer;
-	int fd, idx, ret;
+	int idx, ret, fdno;
 
 	if (copy_from_user(&idx, ival, sizeof(idx)))
 		return -EFAULT;
@@ -2067,26 +2067,18 @@ static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg
 	ib->indio_dev = indio_dev;
 	ib->buffer = buffer;
 
-	fd = anon_inode_getfd("iio:buffer", &iio_buffer_chrdev_fileops,
-			      ib, O_RDWR | O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
+	FD_PREPARE(fdf, O_RDWR | O_CLOEXEC,
+		   anon_inode_getfile("iio:buffer", &iio_buffer_chrdev_fileops,
+				      ib, O_RDWR | O_CLOEXEC));
+	if (IS_ERR(fdf)) {
+		ret = PTR_ERR(fdf);
 		goto error_free_ib;
 	}
 
-	if (copy_to_user(ival, &fd, sizeof(fd))) {
-		/*
-		 * "Leak" the fd, as there's not much we can do about this
-		 * anyway. 'fd' might have been closed already, as
-		 * anon_inode_getfd() called fd_install() on it, which made
-		 * it reachable by userland.
-		 *
-		 * Instead of allowing a malicious user to play tricks with
-		 * us, rely on the process exit path to do any necessary
-		 * cleanup, as in releasing the file, if still needed.
-		 */
+	fdno = fd_prepare_fd(fdf);
+	/* The staged file is dropped with its descriptor if this faults. */
+	if (copy_to_user(ival, &fdno, sizeof(fdno)))
 		return -EFAULT;
-	}
 
 	return 0;
 

-- 
2.53.0

