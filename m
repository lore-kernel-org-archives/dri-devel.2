Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E160C3127
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzeuR62X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C82B410EFA8;
	Mon,  2 Nov 2026 15:21:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F03A10EFD9
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:21:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0575160620;
 Mon,  2 Nov 2026 15:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FC41F00A16;
 Mon,  2 Nov 2026 15:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793632892;
 bh=u/RXCBD8nlX7BDzbpngWHwWfgPDQj7BVrPXrBF7wCv8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lzeuR62XFqOGUep6G0u/OgAm/OWRPnnvn8erL4ZU4coYsOJSODUSp+a+2jQzM89Na
 wls04y7KzCTFwf5dsKwoGQq4HsQJB+8Q/tyIUmNqi21phOIu62KpYImTlB0ls6aGae
 miRfVbxr3JZPL8lWk8CynKdRTAwmaRBTeg+t7O77J1JsURjyW/dH2I6mYOgaUrqxwj
 7KTrFfx3AkzJndWmhJ/H+my8YK+kelSQ4n+wOAuAD5nl7vHyDdtVgll57DDfY53FmE
 lZ2Bqq8ccnEcF5eVt6EqwlmszCQGg+ZSpjDAYPYr+Ujd6ANt6wT/4OLvqxEhsJ83lT
 c5mbm06d3Q7qw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:16 +0100
Subject: [PATCH RFC 06/27] nfsd: let procfs own the seq_file of
 /proc/fs/nfs/exports
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-fs-v1-6-d09a996317b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Og6i2j2RItYkKcPNuUOPBq0fveLG9Ax2TG7f5E6VSxk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG7kVLY5MLm6OZ2xjUVJp9EoIqQs8Har0dvS4Du/G
 zkXh5h3lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATCTOhZFh8mS2HN0Vqp439x5e
 2xeUd91V5e/Pzuqia7+Lj7wzdlPPYWTYZ8Q7MynkzsRjgb7VR/ifa84RfBwlO7dAjOFb++Stxc7
 8AA==
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

Declare the seq_operations and let procfs open and free the seq_file.
->proc_open() and ->proc_release() only set up ->private and take and
drop the reference to the network namespace now. Reading the file then
no longer holds up its removal.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/nfsd/nfsctl.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f8ce3c0fb077..5b2782f9dbbd 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1407,16 +1407,23 @@ MODULE_ALIAS_FS("nfsd");
 
 #ifdef CONFIG_PROC_FS
 
+/* procfs opens the seq_file */
 static int exports_proc_open(struct inode *inode, struct file *file)
 {
-	return exports_net_open(current->nsproxy->net_ns, file);
+	exports_net_init(current->nsproxy->net_ns, file->private_data);
+	return 0;
+}
+
+static int exports_proc_release(struct inode *inode, struct file *file)
+{
+	exports_net_put(file->private_data);
+	return 0;
 }
 
 static const struct proc_ops exports_proc_ops = {
+	.proc_seq_ops	= &nfs_exports_op,
 	.proc_open	= exports_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= exports_release,
+	.proc_release	= exports_proc_release,
 };
 
 static int create_proc_exports_entry(void)

-- 
2.53.0

