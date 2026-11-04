Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5335609A804
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6D8wYD2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB8D10FEB0;
	Wed,  4 Nov 2026 19:55:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F203E10FEB0
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:55:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8944407FE;
 Wed,  4 Nov 2026 19:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33681F0093A;
 Wed,  4 Nov 2026 19:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793822118;
 bh=5GRAUZH2kX1HsIdPeFBozE83iEr60/LUxZUEqoYcqBA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K6D8wYD2MHxLc1A6I8beamV0pObJvicvKCtgWawx7vbSi7zLo3j2ctn3RCT02IH2B
 cs/tE+wlgkfJiw8pdoz1fsAs6shdk6/KKU+Vqvvu6Kw7dZYVL6fYJJWHQ8SIn7iNdF
 TnUIjUB+uZ3A9X1DPGPnTdZdNrZ1/73uYR+WVppUld9IugsG6rBtfC8gP3fTmrRMj9
 qYaYgJLjjARtox7+0nxjwIaOsw0/fuBmnCeO6C0HS1fLvltm4b8P3C8jv1U+rPQ0ON
 GxEtqpsz5ApwsZslZD+5hRjMG1muJ5LkH0aAOA6g+jUkHI3osPUl5ugHlGAfBvXM5P
 CPyCC7CRsX/ag==
From: Christian Brauner <brauner@kernel.org>
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
Subject: [PATCH RESEND v2 22/30] module: procfs: let procfs own the seq_file
 of /proc/modules
Date: Wed,  4 Nov 2026 20:55:04 +0100
Message-ID: <20261104-work-procfs-fs-v2-22-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=brauner@kernel.org;
 h=from:subject:message-id; bh=flwsY9W3AwD1el1fvMS4MRjAzw7empBDyCTwiYsv/MA=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGrrjEahTK6pLNLSh47T+LUN95C9eqt3XPPOGWBkVwXBxoDAb
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmrrjEYACgkQkcYbwGV43KJwLQD9FSDg
 Bzu78LkPNN8YTsitZGfMvsvgXjVHC0ovLkYyc60BAKlpMERm5dXxCOBigxteDNBXTI9lWTa/zws
 AB9/l+qwF
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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

Declare the seq_operations and let procfs open and free the seq_file.
->proc_open() only decides whether to hide the addresses now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/module/procfs.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index 90712aa9dd13..a759bd916df7 100644
--- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -117,31 +117,24 @@ static const struct seq_operations modules_op = {
 };
 
 /*
- * This also sets the "private" pointer to non-NULL if the
- * kernel pointers should be hidden (so you can just test
+ * procfs opens the seq_file. This sets the "private" pointer to non-NULL
+ * if the kernel pointers should be hidden (so you can just test
  * "m->private" to see if you should keep the values private).
  *
  * We use the same logic as for /proc/kallsyms.
  */
 static int modules_open(struct inode *inode, struct file *file)
 {
-	int err = seq_open(file, &modules_op);
+	struct seq_file *m = file->private_data;
 
-	if (!err) {
-		struct seq_file *m = file->private_data;
-
-		m->private = kallsyms_show_value(file->f_cred) ? NULL : (void *)8ul;
-	}
-
-	return err;
+	m->private = kallsyms_show_value(file->f_cred) ? NULL : (void *)8ul;
+	return 0;
 }
 
 static const struct proc_ops modules_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
+	.proc_seq_ops	= &modules_op,
 	.proc_open	= modules_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release,
 };
 
 static int __init proc_modules_init(void)

-- 
2.53.0

