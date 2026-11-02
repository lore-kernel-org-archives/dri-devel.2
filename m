Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05F607229C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbE/GY/P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D180210F007;
	Mon,  2 Nov 2026 15:31:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD6410F007
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:31:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F68C41B56;
 Mon,  2 Nov 2026 15:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ABC1F00A17;
 Mon,  2 Nov 2026 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793633486;
 bh=vwjxO3TYvy6WGJQYdN5saH6B1iVdIocyydf/9B8LfXQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UbE/GY/PYzhi2Fi7si7/s3It7tNz4DO7UQGlprH7NLzpJSufJcUt6S7sLl4ETioTn
 lSrxhrhtFMtQb6rZpoE6MoG5MG9eu/oVVRZmwnTVdQmH/Uc8YanZxUbAPJ3I9S4O7q
 z0m2i9CWxWD03GNLvtDJCEzS1ywzTD672wOGOyzXiiTxjSmYm4JDOfioeSmLQa60Ds
 a3wnZ+yTE9KkhVTKNfGA/bKsony/u5hTU2nvptIrn6VLRSoxE92Hyqh1vP22R1USo3
 fnoX0h5mvFahCSUZxRECbsbRhCqA2NVJbxVIwTQPsraXYkSxXkM4wzwb15ZC+dp27b
 y5/kCl5AgK1UA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:16 +0100
Subject: [PATCH RFC 02/11] l2tp: let procfs own the seq_file of
 /proc/net/pppol2tp
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-net-v1-2-982104a4f592@kernel.org>
References: <20261102-work-procfs-net-v1-0-982104a4f592@kernel.org>
In-Reply-To: <20261102-work-procfs-net-v1-0-982104a4f592@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/g5R4n0Ms+FYrKqMM/T6cxyrF8YI/t11/rZZuOTaMss=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG78rF41UVcn6s+kRfI/lJTvq/TI+ez8kiHKd3vOn
 QnBrmtYO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi9oyRYf/NOSUiv50MPlxP
 STf7vX/f6RkVu0Vzktw3n+teH3BIfwcjQ6e+2UWHa43H2pdHS7s1ZT76oqVzw0iU/67rXo/gM16
 nuAA=
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

Declare the seq_operations and the size of the iterator state and let
procfs open and free the seq_file. ->proc_open() only takes the
reference to the network namespace now and ->proc_release() drops that
and the references the iterator holds. Reading the file then no longer
holds up its removal.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/l2tp/l2tp_ppp.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 4f311d473a64..499e37eb788a 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1596,21 +1596,17 @@ static const struct seq_operations pppol2tp_seq_ops = {
 	.show		= pppol2tp_seq_show,
 };
 
+/* procfs opened the seq_file and allocated @pd */
 static int pppol2tp_proc_open(struct inode *inode, struct file *file)
 {
-	struct net *net = pde_data(inode);
-	struct pppol2tp_seq_data *pd;
+	struct seq_file *seq = file->private_data;
+	struct pppol2tp_seq_data *pd __maybe_unused = seq->private;
+	struct net *net;
 
-	net = maybe_get_net(net);
+	net = maybe_get_net(pde_data(inode));
 	if (!net)
 		return -ENXIO;
 
-	pd = __seq_open_private(file, &pppol2tp_seq_ops, sizeof(*pd));
-	if (!pd) {
-		put_net(net);
-		return -ENOMEM;
-	}
-
 #ifdef CONFIG_NET_NS
 	pd->p.net = net;
 	netns_tracker_alloc(net, &pd->p.ns_tracker, GFP_KERNEL);
@@ -1633,13 +1629,13 @@ static int pppol2tp_proc_release(struct inode *inode, struct file *file)
 #else
 	put_net(&init_net);
 #endif
-	return seq_release_private(inode, file);
+	return 0;
 }
 
 static const struct proc_ops pppol2tp_proc_ops = {
+	.proc_seq_ops	= &pppol2tp_seq_ops,
+	.proc_state_size = sizeof(struct pppol2tp_seq_data),
 	.proc_open	= pppol2tp_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
 	.proc_release	= pppol2tp_proc_release,
 };
 

-- 
2.53.0

