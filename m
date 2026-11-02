Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3460A6F4F
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtwKUokO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3121710EFDF;
	Mon,  2 Nov 2026 15:23:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0804C10EFDF
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:23:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E368343BCF;
 Mon,  2 Nov 2026 15:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB961F00A16;
 Mon,  2 Nov 2026 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793632991;
 bh=cbUv3n1tBnI1k6VxTZ3ZcHd/CVUe8/cnvkVP6mlO6Yc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gtwKUokOODP26lfp4y7mSUu6DYdG/zt2FxgYuDS+oho+JQ5cga5uqjc8YY6VgrcQs
 VTaytOyGE9Q36HAhmeQO/tpkWrmaem5nfcs9DoO11v1we3+YYyPqsUjQ0RtzlSJ/r7
 PjD7PtqydOyrhI0RMb58/TQgdn/JW1bEao0zBiP6y+8iVzXby6r+qrPSMfF1VCtR3o
 f+fxAzOWnAKXVVQlIcMAzpg04hv/Asv4XFoEe0YrkCVsCJLh0AlwObscrypUo3bOUD
 I88qZEPZKE9AXxN0jtQQ7Cv/rHCklqSSX1h/8YUYGnUDPn7pa9hj9iyObikXEB/IoK
 IjWpl3b9MOeCg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:20 +0100
Subject: [PATCH RFC 10/27] genirq/proc: let procfs copy in the affinity masks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-fs-v1-10-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3770; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WZPzG5+ElQbjbcTuZJJKbql/hLS5VpybW+Y2WsbSVy8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG6Uyh8z/eu1hrs32SIFLvZ8+rqj2fax/9rr51N3L
 TzROveFV0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE5soyMtz79dy2qTFnUlGi
 7Rv7nTPlZCfr1j9uiJscE3tp0bIdbPYM/10MrwvWc26+27EhfVkc7w0pUx3fZeee9Fxveua24pn
 WK1YA
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

Implement ->proc_write_buf() for smp_affinity, smp_affinity_list and
default_smp_affinity so procfs copies in what is written before it pins
the entry, and parse the masks from that copy. A list of CPUs can be
longer than a page on large machines, so the files take as much as
memdup_user_nul() could copy in before. Anything larger fails with
-EINVAL instead of -ENOMEM.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/irq/proc.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index aa3d5544cfc1..fe683457a088 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -9,6 +9,7 @@
 #include <linux/gfp.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/kernel_stat.h>
@@ -134,8 +135,11 @@ static inline int irq_select_affinity_usr(unsigned int irq)
 }
 #endif
 
+/* lists of CPUs can outgrow a page, take what memdup_user_nul() took */
+#define IRQ_AFFINITY_WRITE_SIZE	(KMALLOC_MAX_SIZE - 1)
+
 static ssize_t write_irq_affinity(int type, struct file *file,
-		const char __user *buffer, size_t count, loff_t *pos)
+		char *buffer, size_t count, loff_t *pos)
 {
 	unsigned int irq = (int)(long)pde_data(file_inode(file));
 	cpumask_var_t new_value;
@@ -148,9 +152,9 @@ static ssize_t write_irq_affinity(int type, struct file *file,
 		return -ENOMEM;
 
 	if (type)
-		err = cpumask_parselist_user(buffer, count, new_value);
+		err = cpulist_parse(buffer, new_value);
 	else
-		err = cpumask_parse_user(buffer, count, new_value);
+		err = cpumask_parse(buffer, new_value);
 	if (err)
 		goto free_cpumask;
 
@@ -177,25 +181,27 @@ free_cpumask:
 }
 
 static ssize_t irq_affinity_proc_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *pos)
+		char *buffer, size_t count, loff_t *pos)
 {
 	return write_irq_affinity(0, file, buffer, count, pos);
 }
 
 static ssize_t irq_affinity_list_proc_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *pos)
+		char *buffer, size_t count, loff_t *pos)
 {
 	return write_irq_affinity(1, file, buffer, count, pos);
 }
 
 static const struct proc_ops irq_affinity_proc_ops = {
 	.proc_show	= irq_affinity_proc_show,
-	.proc_write	= irq_affinity_proc_write,
+	.proc_write_buf	= irq_affinity_proc_write,
+	.proc_write_size = IRQ_AFFINITY_WRITE_SIZE,
 };
 
 static const struct proc_ops irq_affinity_list_proc_ops = {
 	.proc_show	= irq_affinity_list_proc_show,
-	.proc_write	= irq_affinity_list_proc_write,
+	.proc_write_buf	= irq_affinity_list_proc_write,
+	.proc_write_size = IRQ_AFFINITY_WRITE_SIZE,
 };
 
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -217,7 +223,7 @@ static int default_affinity_show(struct seq_file *m, void *v)
 }
 
 static ssize_t default_affinity_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *ppos)
+		char *buffer, size_t count, loff_t *ppos)
 {
 	cpumask_var_t new_value;
 	int err;
@@ -225,7 +231,7 @@ static ssize_t default_affinity_write(struct file *file,
 	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
 
-	err = cpumask_parse_user(buffer, count, new_value);
+	err = cpumask_parse(buffer, new_value);
 	if (err)
 		goto out;
 
@@ -249,7 +255,8 @@ out:
 
 static const struct proc_ops default_affinity_proc_ops = {
 	.proc_show	= default_affinity_show,
-	.proc_write	= default_affinity_write,
+	.proc_write_buf	= default_affinity_write,
+	.proc_write_size = IRQ_AFFINITY_WRITE_SIZE,
 };
 
 static int irq_node_proc_show(struct seq_file *m, void *v)

-- 
2.53.0

