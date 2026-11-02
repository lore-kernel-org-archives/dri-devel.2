Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497360A1D8B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OooUTIri
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56EF10F014;
	Mon,  2 Nov 2026 15:36:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83BC510F014
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:36:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 04A8C609D4;
 Mon,  2 Nov 2026 15:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73BE1F00A18;
 Mon,  2 Nov 2026 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793633777;
 bh=X6qJRwazLqAMPBxaQUbfUiKhNVd3swwk7S8hV3QbYLU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OooUTIrihLmaX0ecOMxc1pdtRBYajzq9meyXmQkeP0DiaQKyKrS+8sMUnwdr+7PiP
 5MgBgASfz4Cqs3pFNaXpJK7ZTjO7vgGI3My2/antPBnrI1+MOdSd1zj+qooiJ4ICaV
 BIJ52/VvF/FCa6hizbbV+uOwmFskzerAf8voVYGHnV3D1EZAmyEFP6IWX0i7Zr6339
 csbKCtxOQwMs8/SfLOFSVcNDZ361AMeNPRTONuJu2+JifqXyjyZKXaErhyFtf3w5kk
 F6scfOYl8JZcfW3ErmUit1d0hhKRBJNWMeoLXzwNFCNKHxlvWVpfIrrby5JjZ4oVDC
 ui/aihse0jGAw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:15:54 +0100
Subject: [PATCH RFC 1/5] proc: drop ->proc_write()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-cleanup-v1-1-c40014bc12f5@kernel.org>
References: <20261102-work-procfs-cleanup-v1-0-c40014bc12f5@kernel.org>
In-Reply-To: <20261102-work-procfs-cleanup-v1-0-c40014bc12f5@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, 
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-cifs@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org, 
 linux-usb@vger.kernel.org, samba-technical@lists.samba.org, 
 sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, 
 linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-debuggers@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2803; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8NQNxLblfbpsxn3sguBDLl0w5nxAqb/wMxctobr9n4U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WJn43XZq7IsLj08Wbz6eU7B1wmqjv5Fep+R5QvvLx
 JNEp7ErdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExktyQjw5pXjyzW+OzOmZdw
 vz7EubB41eJzrQUpTydtX64uY92vMIGRYe+JqY8NeiT1Qz9fThVgWbbFcKLF5tm1mj9TRJe9XyI
 dwgkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Every writable entry implements ->proc_write_buf() now and procfs
copies in what is written before it pins the entry. Remove
->proc_write().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/generic.c       |  2 --
 fs/proc/inode.c         | 15 +--------------
 include/linux/proc_fs.h |  1 -
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 35dd745a0357..7b2ed3c42d32 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -469,8 +469,6 @@ static int pde_set_flags(struct proc_dir_entry *pde)
 			pde->flags |= PROC_ENTRY_proc_lseek;
 	}
 	if (proc_ops->proc_write_buf) {
-		if (WARN_ON_ONCE(proc_ops->proc_write))
-			return -EINVAL;
 		pde->flags |= PROC_ENTRY_proc_write_buf;
 		pde->write_size = proc_ops->proc_write_size ?: PAGE_SIZE - 1;
 		if (proc_ops->proc_flags & PROC_ENTRY_SHORT_WRITES)
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 7e4ca5751abb..dac5974d4652 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -491,14 +491,6 @@ static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count,
 	return rv;
 }
 
-static ssize_t pde_write(struct proc_dir_entry *pde, struct file *file, const char __user *buf, size_t count, loff_t *ppos)
-{
-	const auto write = pde->proc_ops->proc_write;
-	if (write)
-		return write(file, buf, count, ppos);
-	return -EIO;
-}
-
 /*
  * procfs copies in what is written before it pins the entry. A writer that
  * faults on its buffer then doesn't hold up remove_proc_entry().
@@ -533,15 +525,10 @@ static ssize_t pde_write_buf(struct proc_dir_entry *pde, struct file *file,
 static ssize_t proc_reg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
-	ssize_t rv;
 
 	if (pde_has_proc_write_buf(pde))
 		return pde_write_buf(pde, file, buf, count, ppos);
-	if (!pde_pin(pde))
-		return -EIO;
-	rv = pde_write(pde, file, buf, count, ppos);
-	pde_unpin(pde);
-	return rv;
+	return -EIO;
 }
 
 static __poll_t pde_poll(struct proc_dir_entry *pde, struct file *file, struct poll_table_struct *pts)
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 2ba4e4a39e13..f21dd826eaa6 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -74,7 +74,6 @@ struct proc_ops {
 	int	(*proc_open)(struct inode *, struct file *);
 	ssize_t	(*proc_read)(struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*proc_read_iter)(struct kiocb *, struct iov_iter *);
-	ssize_t	(*proc_write)(struct file *, const char __user *, size_t, loff_t *);
 	/*
 	 * mandatory unless nonseekable_open() or equivalent is used, procfs
 	 * seeks seq_file entries itself

-- 
2.53.0

