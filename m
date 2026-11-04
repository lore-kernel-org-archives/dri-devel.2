Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614BF606A904
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k29wYoDm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85A510FDBB;
	Wed,  4 Nov 2026 17:29:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A383310FDA0
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:29:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8AA6140888;
 Wed,  4 Nov 2026 17:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7C51F000C1;
 Wed,  4 Nov 2026 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793813389;
 bh=jP/hayhlpAKZdjJKk3r9BHeVVOYyvJcLU3d1z3kH9u8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=k29wYoDmBb6ORIk/YigyTAaPtSyeooMT9Gehkig8HAb2s5/Z8UK6XLxRTz9EDVGnx
 eGiDz9bKPGnbG5+h4f2SaQeQuToessREwOdzcuVK45laKtepD5/4l2EkSVetuFazGP
 CpZi4D+axCqGJyyCzcjUodz4iFV75O3vIJZr+FuouuBv26oCOdXws7TH/pp445vvA+
 XWOP3PhxdwKX/fQLJFUO/FuU7suEDOp3lVbp7cTbUmYfkzbYCBmWMOBUGP0APptS+H
 BJ5uoSpfpKEmuDle2PpFnddFwy9xwQS99ffHUVrrShSkfHcu9R7iUf2ztEg6CLx6Z0
 avdFtYzV4BmjA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Nov 2026 18:27:22 +0100
Subject: [PATCH v2 05/51] xtensa: simdisk: remove the proc entry before the
 disk
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-work-procfs-bugfixes-v2-5-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=brauner@kernel.org;
 h=from:subject:message-id; bh=f7Qg/00vnZM3tuJ138yAFxD6JPv6/GBN+HDx2x0z8gg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zvo3+8l6vuY9izMzGv+zF0+8zvxIgy/yWdNkY/Huk
 2e/XjWN6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIUDXDX1nmkANzS/S1E9dt
 3WFX/Lro3morHw1n24ovs6+YTz8QwsjwT6HT/Ztok6F1lkCbjcPRzduKzU87T1/j1tyZf3L9t5Y
 fLAA=
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

simdisk_teardown() frees the gendisk and only then removes
/proc/simdisk/<n>. A write to that entry in between attaches the file
that was written to the disk, and simdisk_attach() sets the capacity of
the gendisk that is gone. Remove the entry first, remove_proc_entry()
waits for a writer that is in the middle of that.

Fixes: b6c7e873daf7 ("xtensa: ISS: add host file-based simulated disk")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/xtensa/platforms/iss/simdisk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index a2ddb49c269d..e51edb8cf872 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -379,12 +379,13 @@ static void simdisk_teardown(struct simdisk *dev, int which,
 {
 	char tmp[2] = { '0' + which, 0 };
 
+	/* a write to the entry attaches a file to the disk, so it goes first */
+	remove_proc_entry(tmp, procdir);
 	simdisk_detach(dev);
 	if (dev->gd) {
 		del_gendisk(dev->gd);
 		put_disk(dev->gd);
 	}
-	remove_proc_entry(tmp, procdir);
 }
 
 static void __exit simdisk_exit(void)

-- 
2.53.0

