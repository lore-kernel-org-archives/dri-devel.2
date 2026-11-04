Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F2160B6B63
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EaLRWWjc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55CA10FE62;
	Wed,  4 Nov 2026 19:38:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B1D10FE62
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:38:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 75DDA406FD;
 Wed,  4 Nov 2026 19:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DFA1F000C1;
 Wed,  4 Nov 2026 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793821114;
 bh=XEKsvRvbQWppTyh1wQqi6XPYHGzRxd9NXleDa7PK/rs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EaLRWWjcN4LLtMOZCh1DK40g1/b6+I6lfVBt9n9EF90MTHukgj10jc7nnxg9IofMR
 GsjkGzfQKuhKOZ+n3/LW++jhgPDusZmmjz6slzPCN4lXGLSEShUFZEJIC20Khv1Qea
 BGx6s9+LOr0H4FffGoKVCTJI6Ox55pPB2uJk3qh/GT5DTKhi1tn3D4FIlveOjDIU6b
 mKrYG8hw6tkNgyXfyvZin/Q7MUwaN2ZXQsXOtudCeeuRmmy8PaA7teUhlewcJMvgHe
 mVgidIbouLxKCLXkR7E6TgFrG6bkV22opE3xoLYbtq0zUE746RrGpkbGpCqYQxYjdM
 22p7i8EAfY8SA==
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
Subject: [PATCH RESEND v2 11/23] sparc: led: let procfs copy in writes
Date: Wed,  4 Nov 2026 20:38:20 +0100
Message-ID: <20261104-work-procfs-arch-v2-11-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AqaUJeRV3kbpXVh8nmhEIr+kHQG3PHbqm52TQh+zorQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97vjpvd0rM2/K/IZazunNazZslZwnnKe7oWiOz5a9r
 +eECD5T7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIaCUjw8/DEZOOcC31OhN2
 f1ax7FPvDa8lyu+sOCFkmxv8bxebMA8jw8uyVjH2g1fyQq9GrFjLuy9g09x/Z3+8EmheILZS646
 OBgMA
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

Implement ->proc_write_buf() so procfs copies in what is written to
/proc/led before it pins the entry, and parse the command from that
copy. Writes larger than PAGE_SIZE - 1 bytes fail with -EINVAL now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/sparc/kernel/led.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index 0f7376b51a04..1f244e394207 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -60,18 +60,14 @@ static int led_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t led_proc_write(struct file *file, const char __user *buffer,
+static ssize_t led_proc_write(struct file *file, char *buf,
 			      size_t count, loff_t *ppos)
 {
 	size_t len = count;
-	char *buf = NULL;
 
 	if (count > LED_MAX_LENGTH)
 		count = LED_MAX_LENGTH;
-
-	buf = memdup_user_nul(buffer, count);
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
+	buf[count] = '\0';
 
 	/* work around \n when echo'ing into proc */
 	if (count > 0 && buf[count - 1] == '\n')
@@ -96,14 +92,12 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
 		auxio_set_led(AUXIO_LED_OFF);
 	}
 
-	kfree(buf);
-
 	return len;
 }
 
 static const struct proc_ops led_proc_ops = {
 	.proc_show	= led_proc_show,
-	.proc_write	= led_proc_write,
+	.proc_write_buf	= led_proc_write,
 };
 #endif
 

-- 
2.53.0

