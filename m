Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF9606F6A7
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdWrZpQZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CF710FDB7;
	Wed,  4 Nov 2026 17:56:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8E010FDB7
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:56:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 72DB96021C;
 Wed,  4 Nov 2026 17:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B8A1F00919;
 Wed,  4 Nov 2026 17:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793814983;
 bh=xlRe6ByN3zpYNOlJQq83OVbC6fU3d9RayIfuGISBpLE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WdWrZpQZG3jkjCCQpsfQrBfgI1HDfynUYNY6vSK8rFGYC+yFDlqVfIlEyf4lUkT0P
 47Qva0HSuMAdzfViLwsaTOh+Gv11NHerf7rOfu6InrqZM/g/ogcoP2D8FesuH1O8lI
 hy7orIASJbsGEcOppEShVEs3qXLaqbCm2X1l58C/mLO7S3SSho647wFT/6dMID+10o
 OEsRp/bw90rGUnntzwTIKbrSuRSgPWrqC9DAx8itOX9VTQCmMsQmbO+kpoEevaaznU
 jpanOJfr9ANyVI0+/ZlgBo3nJ2sRa69PFXETlEYKduVxU+xF7MZ1giUdKYjN5C4/6X
 bQ/q4gyj9YA2A==
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
 Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 37/51] proc/vmcore: don't let vmcore_cleanup() run twice at
 once
Date: Wed,  4 Nov 2026 18:47:23 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-37-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gmON/Vwu30bm66aR7FLjt15bWl4pslPspuVjwp92LoI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zntzeuekQwxr7P0OOe39UCH++f+GeYsr8k/NVg0Tb
 VTs/Xvpc0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEwtsZGWZcnzuvlVNJw+uO
 fOP1dOFrwRJ3O9wSfjxvbSqZ8obd7yEjw9/p+SJB0Us0z7YI1mVedF7t1tNceCBK08xCfvPP1Pt
 LeAA=
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

vmcore_cleanup() has a single caller, fadump's release_mem_store() on
powerpc. That checks fw_dump.dump_active without a lock and calls
vmcore_cleanup() without one, and kernfs only serializes the writers of
one open file. So two tasks that write to
/sys/kernel/fadump/release_mem through different files run
vmcore_cleanup() at the same time.

The first one removes /proc/vmcore and waits for its readers in
proc_remove(). The second one finds the entry already unlinked, returns
from proc_remove() right away and frees vmcore_list, the ELF headers
and the device dumps while those readers still walk them. Or both of
them free the same lists at once.

Serialize vmcore_cleanup() with a mutex of its own. It can't be
vmcore_mutex, removing /proc/vmcore calls release_vmcore() which takes
it. The second caller then finds nothing left to free.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: b500afff11f6 ("fadump: Invalidate registration and release reserved memory for general use.")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/vmcore.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fe70c4ecc54..ccb795b85509 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1764,6 +1764,11 @@ fs_initcall(vmcore_init);
 /* Cleanup function for vmcore module. */
 void vmcore_cleanup(void)
 {
+	/* Not vmcore_mutex, removing /proc/vmcore calls release_vmcore(). */
+	static DEFINE_MUTEX(vmcore_cleanup_mutex);
+
+	/* Two writers of fadump's release_mem can get here at once. */
+	guard(mutex)(&vmcore_cleanup_mutex);
 	if (proc_vmcore) {
 		proc_remove(proc_vmcore);
 		proc_vmcore = NULL;

-- 
2.53.0

