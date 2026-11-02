Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCB606D818
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoCb1xon
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D1E10E356;
	Mon,  2 Nov 2026 15:11:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85BC10E63B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:11:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 905ED4396E;
 Mon,  2 Nov 2026 15:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834C51F00A1A;
 Mon,  2 Nov 2026 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793632308;
 bh=Q/r9Fhg2Z0/w3CqoKnG0DKCxv08Z9PpiFGMKT+radK4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eoCb1xonaSPckn24MdF4TgpzPnhB0gLnhwB3+q7VZZ4/VwLP7qSPXNuTMQ/2dNldh
 eVFE9vGUSsn5YYaxGqoLLphvtZLuTJd+KylQIE7mCxvO73SPam6GZq8mc3b9CVyDie
 3exBK5rK2UuFrqmUvsRYmGiv0WPcd+dv1jT5VIdTEL0j46lSeijrTe4sxEh10rR5bK
 zOsOn6lvifS4MnTOAh0Y2SzLal5mx1R7DipSgL85s9IzFy3jc8hi6gaFxlmb2VYUgw
 Yg+IrbZgj5ldjUEp69Bi1JJ+66r8wybqWUuSMQZmJ6kfSVqJ9+zpEm7bXhkzV6eqzB
 WMso6y2HpsKNQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:12 +0100
Subject: [PATCH RFC 05/23] PCI/proc: let procfs handle the ioctls
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-drivers-v1-5-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
In-Reply-To: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2106; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2F6i7ISm6IP0WfraLShTjEfHw8rrOdRgm90gAFJMkQE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG6wz+y23KkZj6QTN7spL27IM+Bm2tTyUNrgV7+Tr
 M+uN3Y9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMJymT477j82eGua2tPP5/u
 /iU1KyGvJs8tjK3vYeGHHaWzRJ14ZzH8U7obxHZv93mOC8mXehiflUxYs0bd3NzPJcDnTdn/mMJ
 9vAA=
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

The PCIIOC_* commands take and return plain values and don't touch
userspace memory. Implement ->proc_ioctl_buf() and list them with
nothing to copy. 32-bit tasks go through the same table, so the compat
hook goes away. Unknown commands fail with -ENOTTY from procfs now
instead of -EINVAL, and instead of -EPERM under lockdown, since they
never reach the handler.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/pci/proc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index a8d7469f222b..6b0cb5bcbea3 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -192,8 +192,7 @@ struct pci_filp_private {
 };
 #endif /* HAVE_PCI_MMAP */
 
-static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
-			       unsigned long arg)
+static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd, void *arg)
 {
 	struct pci_dev *dev = pde_data(file_inode(file));
 #ifdef HAVE_PCI_MMAP
@@ -321,16 +320,23 @@ static int proc_bus_pci_release(struct inode *inode, struct file *file)
 }
 #endif /* HAVE_PCI_MMAP */
 
+/* The commands take and return plain values. */
+static const struct proc_ioctl_arg proc_bus_pci_ioctl_args[] = {
+	PROC_IOCTL_ARG(PCIIOC_CONTROLLER, 0, 0),
+	PROC_IOCTL_ARG(PCIIOC_MMAP_IS_IO, 0, 0),
+	PROC_IOCTL_ARG(PCIIOC_MMAP_IS_MEM, 0, 0),
+	PROC_IOCTL_ARG(PCIIOC_WRITE_COMBINE, 0, 0),
+};
+
 static const struct proc_ops proc_bus_pci_ops = {
 	.proc_flags	= PROC_ENTRY_SHORT_WRITES,
 	.proc_lseek	= proc_bus_pci_lseek,
 	.proc_read_buf	= proc_bus_pci_read,
 	.proc_write_buf	= proc_bus_pci_write,
 	.proc_write_size = PCI_CFG_SPACE_EXP_SIZE,
-	.proc_ioctl	= proc_bus_pci_ioctl,
-#ifdef CONFIG_COMPAT
-	.proc_compat_ioctl = proc_bus_pci_ioctl,
-#endif
+	.proc_ioctl_buf	= proc_bus_pci_ioctl,
+	.proc_ioctl_args = proc_bus_pci_ioctl_args,
+	.proc_nr_ioctl_args = ARRAY_SIZE(proc_bus_pci_ioctl_args),
 #ifdef HAVE_PCI_MMAP
 	.proc_open	= proc_bus_pci_open,
 	.proc_release	= proc_bus_pci_release,

-- 
2.53.0

