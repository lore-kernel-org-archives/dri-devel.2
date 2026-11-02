Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55886074A66
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ej70vPT/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C1D10EFBC;
	Mon,  2 Nov 2026 15:16:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3331110EFD7
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:16:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0CD442A88;
 Mon,  2 Nov 2026 15:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B757A1F00A16;
 Mon,  2 Nov 2026 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793632574;
 bh=goLGxFor5aDHmq+/63YZ7VsFVk0WPo8/IlwPxf0/q/E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ej70vPT/y7NrhBgRnVeJZJCWCJCY4Ir+tDI0qb3+EynguB83LrhQsFn2l3M5OZtXE
 2VH+S87/JA3tEOQ5oF6NbafdeM5dvCGs7k+Pl66iGGY0VzHGdvfeTuOHMGET++saO9
 8CMGsO+isRtfapDtsUOvJJ1+uTuGk8RHjvFSx0T6P4hnrtLPTR2SSKodt/mLQIBmk2
 SzbEgwffy1kv1xXhMujkkGK8afuda14vw1NrfhyqY3qJhPF7pdO3kkpnpsfKhmpNYh
 jxGaC2jmsD4TftiMbXuIK38lcVEqXr7YxWPTdZiDHhvMHLfLf4/cExgZfn7c5HC9H0
 J+psMOIMcn0fQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:24 +0100
Subject: [PATCH RFC 17/23] usb: gadget: function: rndis: let procfs copy in
 writes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-drivers-v1-17-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=brauner@kernel.org;
 h=from:subject:message-id; bh=saz4p5rW2UOPmCRi+6zEslqjX7E5721ehvji7/y2TLU=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGropzGhaJWnu9+4zvQgXLhUThJNad18i/diIL3NsOXTHFLIm
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmropzEACgkQkcYbwGV43KIUZwD+IHp+
 nA7hxed0nI3IkqLBHaX8l90Mx69iUsGXRMOlkboA/3KH9SLJ/MMw6rQ8ujZlKhQxzG1q+lU/vjC
 oZkDuYDUH
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

Implement ->proc_write_buf() so procfs copies in what is written to
/proc/driver/rndis-<n> before it pins the entry, and handle the
commands from that copy. Writes larger than PAGE_SIZE - 1 bytes fail
with -EINVAL now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/usb/gadget/function/rndis.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index 3c7bd30b8a3a..e05e0c6ae8fb 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -1138,7 +1138,7 @@ static int rndis_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t rndis_proc_write(struct file *file, const char __user *buffer,
+static ssize_t rndis_proc_write(struct file *file, char *buffer,
 				size_t count, loff_t *ppos)
 {
 	rndis_params *p = pde_data(file_inode(file));
@@ -1146,9 +1146,8 @@ static ssize_t rndis_proc_write(struct file *file, const char __user *buffer,
 	int i, fl_speed = 0;
 
 	for (i = 0; i < count; i++) {
-		char c;
-		if (get_user(c, buffer))
-			return -EFAULT;
+		char c = *buffer;
+
 		switch (c) {
 		case '0':
 		case '1':
@@ -1185,7 +1184,7 @@ static ssize_t rndis_proc_write(struct file *file, const char __user *buffer,
 
 static const struct proc_ops rndis_proc_ops = {
 	.proc_show	= rndis_proc_show,
-	.proc_write	= rndis_proc_write,
+	.proc_write_buf	= rndis_proc_write,
 };
 
 #define	NAME_TEMPLATE "driver/rndis-%03d"

-- 
2.53.0

