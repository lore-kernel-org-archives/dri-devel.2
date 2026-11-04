Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA560CF94A
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dA0DNurZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB22510FE8C;
	Wed,  4 Nov 2026 19:48:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3351610FE8C
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:47:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CE2A60F15;
 Wed,  4 Nov 2026 19:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A231F0093A;
 Wed,  4 Nov 2026 19:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793821673;
 bh=o7mJ23mAcDTgScqej0oFhuq1h/6FvdBmFy6u6skOQc0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dA0DNurZqV4J9DbS0OyTvs1fyzf+tr+GnxjFgcPQAXyozxe/btBqIfQ8qv52kR1XH
 FUZ5gMbXt9OK2wJH/Q21p3te0KBNKoQmKmOkjKcIkbKYcHgCrR5Dr4Z5UBlA95Ho1N
 RZBF+D4QSJaIxJn6Y8WHPyeYdRN6+YuqVVO7YdSYR1PI9vvy2kuuar+gQyTcmGnjvo
 skcmgOf51D6shHyYWUMhtACHkrQpha6C3N03hx/u1Dd1WRqrNEqgG2OeXjq39V1Dp4
 i31YqmqhIyZZvJu67ZPvlEjwYe9Ikqs3ZGyd/wpMChb1hwGc5NYBbHFIVrVfRBvnFu
 8IfvxRbYh5cdw==
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
Subject: [PATCH RESEND v2 22/26] ALSA: info: let procfs own the seq_file of
 text entries
Date: Wed,  4 Nov 2026 20:47:38 +0100
Message-ID: <20261104-work-procfs-drivers-v2-22-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241; i=brauner@kernel.org;
 h=from:subject:message-id; bh=S+buwBt9DQjjWOReG2bmbtOto+rEgyDiARec22GsvW8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97ur7cKp5nuC/vvMVLfsjea7umM/MkrbBKuzcXst5/
 n7/szoFO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSPJPhf+m0E+VJ3WHGl58Z
 7Hv7Z/9Z1+vuQv7Tv4jdCrXmPr1L1I2RoUv/kNHdZDXZmqY/2/X6um5/m3PpyarXv97kK7nJn/o
 2gQ0A
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

Declare the show function and let procfs open and free the seq_file.
->proc_open() only sets up the private data and preallocates the buffer
now and ->proc_release() no longer releases the seq_file. Reading an
entry then no longer holds up its removal when the card goes away.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 sound/core/info.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index f608d335b6c9..42a4f8fb3198 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -346,9 +346,11 @@ static int snd_info_seq_show(struct seq_file *seq, void *p)
 	return 0;
 }
 
+/* procfs opens the seq_file */
 static int snd_info_text_entry_open(struct inode *inode, struct file *file)
 {
 	struct snd_info_entry *entry = pde_data(inode);
+	struct seq_file *m = file->private_data;
 	struct snd_info_private_data *data;
 	int err;
 
@@ -362,13 +364,12 @@ static int snd_info_text_entry_open(struct inode *inode, struct file *file)
 		err = -ENOMEM;
 		goto error;
 	}
-	if (entry->size)
-		err = single_open_size(file, snd_info_seq_show, data,
-				       entry->size);
-	else
-		err = single_open(file, snd_info_seq_show, data);
-	if (err < 0)
-		goto error;
+	if (entry->size) {
+		err = seq_preallocate(m, entry->size);
+		if (err < 0)
+			goto error;
+	}
+	m->private = data;
 	return 0;
 
  error:
@@ -387,7 +388,6 @@ static int snd_info_text_entry_release(struct inode *inode, struct file *file)
 	if (data->wbuffer && entry->c.text.write)
 		entry->c.text.write(entry, data->wbuffer);
 
-	single_release(inode, file);
 	kfree(data->rbuffer);
 	if (data->wbuffer) {
 		kvfree(data->wbuffer->buffer);
@@ -401,11 +401,10 @@ static int snd_info_text_entry_release(struct inode *inode, struct file *file)
 
 static const struct proc_ops snd_info_text_entry_ops =
 {
+	.proc_show	= snd_info_seq_show,
 	.proc_open	= snd_info_text_entry_open,
 	.proc_release	= snd_info_text_entry_release,
 	.proc_write	= snd_info_text_entry_write,
-	.proc_lseek	= seq_lseek,
-	.proc_read	= seq_read,
 };
 
 static struct snd_info_entry *create_subdir(struct module *mod,

-- 
2.53.0

