Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353F6085133
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahsEbMnF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5673A10FE73;
	Wed,  4 Nov 2026 19:41:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E2410FE73
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:41:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E2D6740961;
 Wed,  4 Nov 2026 19:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2E21F0093A;
 Wed,  4 Nov 2026 19:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793821262;
 bh=Dp7sSooWMguSrSQWYm7n5WBM775aoRxhTJFL+eJzfGM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ahsEbMnF9zcnNZOEONOoSIvu9cB/0nOat4pciljDJZ1lRY0gTRvKf65J2iztGwXL3
 huM4R9vSdALKqE8kuklKvnq27vYWQMAxmVgCUbvndK1O7Tscoma0nZZWjwIVr64Nal
 AguF3O8aWJZFNil7eQDAip8OreykLWStP3mR0+20AhcQutDlARzzDrgsOcfJyuKTN6
 vdVJbAcKxMemVfPCg44rHRG0jAUzxpbHUfkxmOrX/3nzu0dDu4UEZEcIMh6AtXzlrR
 YNfvqpYbAwxxqtku+uDd0CYMxaNswLdUGY69k2hI9b40vSqwE2XUaCbFuuw+4NdJ/Y
 Ag3SSqZroL+MQ==
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
Subject: [PATCH RESEND v2 21/23] platform/x86: toshiba_acpi: let procfs copy
 in writes
Date: Wed,  4 Nov 2026 20:40:48 +0100
Message-ID: <20261104-work-procfs-arch-v2-21-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4887; i=brauner@kernel.org;
 h=from:subject:message-id; bh=X71uAmUiQrc004XgHk8qpFAD0vRjbeKoDlL8dmgq77k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97mT79D1gq9YKw30dMYb3t286tu6JJ3vhh9JOzdMrP
 0zjEJKd2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRL6WMDL1XV200Vv8i9FyP
 5dKKV2rBdT1C2kUBc2IWsqk3ly321GdkeJbKYML7O6yyimPD375nuVGffSeFhjysV744+YTLs2I
 rHgA=
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

Implement ->proc_write_buf() for the files in /proc/acpi/toshiba so
procfs copies in what is written before it pins the entry, and parse
what was written from that copy. Commands longer than PAGE_SIZE - 1
bytes are rejected now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/platform/x86/toshiba_acpi.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 560e62da05a9..895e321ada03 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -1478,7 +1478,7 @@ static int set_lcd_status(struct backlight_device *bd)
 	return set_lcd_brightness(dev, bd->props.brightness);
 }
 
-static ssize_t lcd_proc_write(struct file *file, const char __user *buf,
+static ssize_t lcd_proc_write(struct file *file, char *buf,
 			      size_t count, loff_t *pos)
 {
 	struct toshiba_acpi_dev *dev = pde_data(file_inode(file));
@@ -1488,8 +1488,7 @@ static ssize_t lcd_proc_write(struct file *file, const char __user *buf,
 	int value;
 
 	len = min(count, sizeof(cmd) - 1);
-	if (copy_from_user(cmd, buf, len))
-		return -EFAULT;
+	memcpy(cmd, buf, len);
 	cmd[len] = '\0';
 
 	levels = dev->backlight_dev->props.max_brightness + 1;
@@ -1505,7 +1504,7 @@ static ssize_t lcd_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops lcd_proc_ops = {
 	.proc_show	= lcd_proc_show,
-	.proc_write	= lcd_proc_write,
+	.proc_write_buf	= lcd_proc_write,
 };
 
 /* Video-Out */
@@ -1541,24 +1540,17 @@ static int video_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t video_proc_write(struct file *file, const char __user *buf,
+static ssize_t video_proc_write(struct file *file, char *buf,
 				size_t count, loff_t *pos)
 {
 	struct toshiba_acpi_dev *dev = pde_data(file_inode(file));
-	char *buffer;
-	char *cmd;
+	char *buffer = buf;
 	int lcd_out = -1, crt_out = -1, tv_out = -1;
 	int remain = count;
 	int value;
 	int ret;
 	u32 video_out;
 
-	cmd = memdup_user_nul(buf, count);
-	if (IS_ERR(cmd))
-		return PTR_ERR(cmd);
-
-	buffer = cmd;
-
 	/*
 	 * Scan expression.  Multiple expressions may be delimited with ;
 	 * NOTE: To keep scanning simple, invalid fields are ignored.
@@ -1577,8 +1569,6 @@ static ssize_t video_proc_write(struct file *file, const char __user *buf,
 		} while (remain && *(buffer - 1) != ';');
 	}
 
-	kfree(cmd);
-
 	ret = get_video_status(dev, &video_out);
 	if (!ret) {
 		unsigned int new_video_out = video_out;
@@ -1602,7 +1592,7 @@ static ssize_t video_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops video_proc_ops = {
 	.proc_show	= video_proc_show,
-	.proc_write	= video_proc_write,
+	.proc_write_buf	= video_proc_write,
 };
 
 /* Fan status */
@@ -1644,7 +1634,7 @@ static int fan_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t fan_proc_write(struct file *file, const char __user *buf,
+static ssize_t fan_proc_write(struct file *file, char *buf,
 			      size_t count, loff_t *pos)
 {
 	struct toshiba_acpi_dev *dev = pde_data(file_inode(file));
@@ -1653,8 +1643,7 @@ static ssize_t fan_proc_write(struct file *file, const char __user *buf,
 	int value;
 
 	len = min(count, sizeof(cmd) - 1);
-	if (copy_from_user(cmd, buf, len))
-		return -EFAULT;
+	memcpy(cmd, buf, len);
 	cmd[len] = '\0';
 
 	if (sscanf(cmd, " force_on : %i", &value) != 1 ||
@@ -1671,7 +1660,7 @@ static ssize_t fan_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops fan_proc_ops = {
 	.proc_show	= fan_proc_show,
-	.proc_write	= fan_proc_write,
+	.proc_write_buf	= fan_proc_write,
 };
 
 /* Fan RPM */
@@ -1707,7 +1696,7 @@ static int keys_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t keys_proc_write(struct file *file, const char __user *buf,
+static ssize_t keys_proc_write(struct file *file, char *buf,
 			       size_t count, loff_t *pos)
 {
 	struct toshiba_acpi_dev *dev = pde_data(file_inode(file));
@@ -1716,8 +1705,7 @@ static ssize_t keys_proc_write(struct file *file, const char __user *buf,
 	int value;
 
 	len = min(count, sizeof(cmd) - 1);
-	if (copy_from_user(cmd, buf, len))
-		return -EFAULT;
+	memcpy(cmd, buf, len);
 	cmd[len] = '\0';
 
 	if (sscanf(cmd, " hotkey_ready : %i", &value) == 1 && value == 0)
@@ -1730,7 +1718,7 @@ static ssize_t keys_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops keys_proc_ops = {
 	.proc_show	= keys_proc_show,
-	.proc_write	= keys_proc_write,
+	.proc_write_buf	= keys_proc_write,
 };
 
 static int __maybe_unused version_proc_show(struct seq_file *m, void *v)

-- 
2.53.0

