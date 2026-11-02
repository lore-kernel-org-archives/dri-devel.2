Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF656070DA1
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/TU5Bzo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F091610EF7A;
	Mon,  2 Nov 2026 15:02:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 435D410EF75
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:02:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 29E534085D;
 Mon,  2 Nov 2026 15:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174411F00A17;
 Mon,  2 Nov 2026 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793631747;
 bh=qVgyj+FYQ9g7uHqmkN/6kOivRqdCDmjAyQM7m79vY9A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=d/TU5BzoI0BtvHfYzajrrcPl1GXVCryRY1Ut48y/GJIvjjd3K9tAkOPoaubnTH8Cj
 sK1647iQobp60ZY24tDMaAx9NsKxFNjymF5IY5h/cKkK9nGKkyHoV7CZDZf8JNbRww
 IRIPJfTF97vUVSY7NrIvF3mdu1MbBY5I5i7z+xiQlEEZ26yJHEdd7bH89Gqlbow2Ks
 Vg0J9epC20U9E4NUHIBDGai+NMTOFT3rd71sgkTUJULyeOxAVxvB4aiLpCaS0sj7+K
 C1HjOmzglPQcf1LCUAmDC0bN3L5TxoShuNDSEnm0bhASQBWbCYoW6wiUfo3S3aSY11
 bUEfQJ+ZWGIIw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:29 +0100
Subject: [PATCH RFC 02/22] ARM: alignment: let procfs copy in writes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-arch-v1-2-c9492ab08480@kernel.org>
References: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
In-Reply-To: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
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
/proc/cpu/alignment before it pins the entry, and take the mode from
that copy. Writes larger than PAGE_SIZE - 1 bytes fail with -EINVAL now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/arm/mm/alignment.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 3e5e30968634..11ceefdfa388 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -144,14 +144,13 @@ static int alignment_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t alignment_proc_write(struct file *file, const char __user *buffer,
+static ssize_t alignment_proc_write(struct file *file, char *buffer,
 				    size_t count, loff_t *pos)
 {
 	char mode;
 
 	if (count > 0) {
-		if (get_user(mode, buffer))
-			return -EFAULT;
+		mode = buffer[0];
 		if (mode >= '0' && mode <= '5')
 			ai_usermode = safe_usermode(mode - '0', true);
 	}
@@ -160,7 +159,7 @@ static ssize_t alignment_proc_write(struct file *file, const char __user *buffer
 
 static const struct proc_ops alignment_proc_ops = {
 	.proc_show	= alignment_proc_show,
-	.proc_write	= alignment_proc_write,
+	.proc_write_buf	= alignment_proc_write,
 };
 #endif /* CONFIG_PROC_FS */
 

-- 
2.53.0

