Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E800D60CEE76
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QF6gmPvv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56CBB10EFF4;
	Mon,  2 Nov 2026 15:28:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C4C10EFF4
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:28:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CBB46060F;
 Mon,  2 Nov 2026 15:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6F21F00A1A;
 Mon,  2 Nov 2026 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793633280;
 bh=bHsrJPm/ZeqC2f4KHWHp4g5ab6c3NA3BCncgylXTsH8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QF6gmPvvMhVIUnvfEWpOhclpup0CA8TlPXjbdyZoJ5eHHottSdWyEB8dnEL8gE+16
 +NMTcLA+lSyxfB4A2sssxnrjT27TURn+q9fb6EnoUxg8Yyx0e5WuEJiSfN7UK64Yk7
 M71NEt3PF9V3opwc5qhvB0ySjBgQpSnX6SLvetxtSlWQ7UbJBBm0cEI8Db9z+OfJiT
 UbqSRDXLlT+u/FwUviVKJjrbliPxSHAfAfK+6Du50Xl8/IUrxGmmj6PAamNXmVtJwr
 rFI9slgiDJSCwopklmTL0/5bZsDu9nFx5+BzfkNZYS3VgFas5NIMFcrO4XgsNGTkjG
 Cn31JaQ8gITOg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:33 +0100
Subject: [PATCH RFC 23/27] alloc_tag: let procfs own the seq_file of
 /proc/allocinfo
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-fs-v1-23-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
In-Reply-To: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OegWGZzazPKoDyS3ACH3h7I4I60OObQ5gHBtJminp7E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG5s+6yxUv34SeXi7J5n7qzCAkVZxT8X/Pb00xL8E
 VB/8254RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES0jjP8T/88X+a04N4pxUkm
 8SeS5KbZ9Jb57p5yoEJPwC/q3ENFT4Z/WuFSu3pmln4JyBR9cuVT175i7j0sp/TvFR349iDBQ0+
 JHQA=
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

Declare the seq_operations and the size of the private state and let
procfs open and free the seq_file. ->proc_open() and ->proc_release()
only set up and destroy the ioctl lock now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 mm/alloc_tag.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 82e2c3448dcf..788c9d7f7151 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -151,27 +151,21 @@ static const struct seq_operations allocinfo_seq_op = {
 };
 
 /*
- * Initializes seq_file operations and allocates private state when opening
- * the /proc/allocinfo procfs entry.
+ * Initializes the private state when opening the /proc/allocinfo procfs
+ * entry. procfs opened the seq_file and allocated the state.
  */
 static int allocinfo_open(struct inode *inode, struct file *file)
 {
-	int ret;
-
-	ret = seq_open_private(file, &allocinfo_seq_op,
-			       sizeof(struct allocinfo_private));
-	if (!ret) {
-		struct seq_file *m = file->private_data;
-		struct allocinfo_private *priv = m->private;
+	struct seq_file *m = file->private_data;
+	struct allocinfo_private *priv = m->private;
 
-		mutex_init(&priv->ioctl_lock);
-	}
-	return ret;
+	mutex_init(&priv->ioctl_lock);
+	return 0;
 }
 
 /*
- * Cleans up the seq_file state and frees up the private state allocated in
- * allocinfo_open() when closing the /proc/allocinfo file descriptor.
+ * Undoes allocinfo_open() when closing the /proc/allocinfo file descriptor.
+ * procfs frees the seq_file and the private state.
  */
 static int allocinfo_release(struct inode *inode, struct file *file)
 {
@@ -179,7 +173,7 @@ static int allocinfo_release(struct inode *inode, struct file *file)
 	struct allocinfo_private *priv = m->private;
 
 	mutex_destroy(&priv->ioctl_lock);
-	return seq_release_private(inode, file);
+	return 0;
 }
 
 /*
@@ -474,9 +468,9 @@ static long allocinfo_compat_ioctl(struct file *file, unsigned int cmd,
 #endif
 
 static const struct proc_ops allocinfo_proc_ops = {
+	.proc_seq_ops		= &allocinfo_seq_op,
+	.proc_state_size	= sizeof(struct allocinfo_private),
 	.proc_open		= allocinfo_open,
-	.proc_read_iter		= seq_read_iter,
-	.proc_lseek		= seq_lseek,
 	.proc_release		= allocinfo_release,
 	.proc_ioctl		= allocinfo_ioctl,
 #ifdef CONFIG_COMPAT

-- 
2.53.0

