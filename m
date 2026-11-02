Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D590D606F200
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=he+g2nWN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39E4310E0E5;
	Mon,  2 Nov 2026 15:16:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A02F10E0E5
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:16:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CEE186021E;
 Mon,  2 Nov 2026 15:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A681F00A1B;
 Mon,  2 Nov 2026 15:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793632612;
 bh=IWME5YXmp+uBTllQI4bmngqtIL2M/ij2LxSZ5nW/iXQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=he+g2nWN2axpHrzARSjuGxsrot205DCjbsjks2Uy9TZYl0RHdg/P9KBOh5oGD9JND
 DVayfm5Hfkeg2m/r223WtfRPwcGKlWcjL6gYiHh273PXIhoEhxNZiDNavPF6Cbag50
 rPSzGmz5EtQ1p1vq/YpFygUITCoUKTT249ouaHForUJOn3MhYmmCCKyIX0biE13ady
 0Xf3M/tsk29ygP+6Atj+xx/0LarrE/V/7VcEpc9Mo2h1gkeCSTTvoKfOUhKqdH7Eyh
 0y2lDzckjbfLpnh9+FD/2sWiSUe/HNZYfhNhwqWfP/i5T/FrHXFUuf714grP6oMM1K
 gpSJo+mPThsHQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:26 +0100
Subject: [PATCH RFC 19/23] tty: sysrq: let procfs copy in writes to
 /proc/sysrq-trigger
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-drivers-v1-19-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=brauner@kernel.org;
 h=from:subject:message-id; bh=izKwZpZInQuHEIn3CG+CtVNE9UBdLWUqDQ+VPsYIx8o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG6YzB/Ns2fpXStd8VP3V2XLLXvKV1i9aZtRzvQP/
 3g8wg9e7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIx3iG/04To6e1njQ6Mb9X
 dZKjsZxt3pH1lyYLZmw6XzB9b7lNLCvDfwcOT28tyyr+0J58PqZfrU9bfa+80lv3Xmue0ZOQ3RL
 BDAA=
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

Implement ->proc_write_buf() so procfs copies in what is written before
it pins the entry, and handle the keys from that copy. Writes larger
than PAGE_SIZE - 1 bytes fail with -EINVAL now. They used to trigger the
first key, or all of them in bulk mode. procfs allocates the copy, which
is as small as the write, opening the file allocated as much already.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/tty/sysrq.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f4571d05b496..99363e1b59ed 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -1200,17 +1200,14 @@ EXPORT_SYMBOL(unregister_sysrq_key);
  * However, if the first character is an underscore,
  * all characters are processed.
  */
-static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
+static ssize_t write_sysrq_trigger(struct file *file, char *buf,
 				   size_t count, loff_t *ppos)
 {
 	bool bulk = false;
 	size_t i;
 
 	for (i = 0; i < count; i++) {
-		char c;
-
-		if (get_user(c, buf + i))
-			return -EFAULT;
+		char c = buf[i];
 
 		if (c == '_')
 			bulk = true;
@@ -1225,7 +1222,7 @@ static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
 }
 
 static const struct proc_ops sysrq_trigger_proc_ops = {
-	.proc_write	= write_sysrq_trigger,
+	.proc_write_buf	= write_sysrq_trigger,
 	.proc_lseek	= noop_llseek,
 };
 

-- 
2.53.0

