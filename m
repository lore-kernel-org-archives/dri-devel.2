Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14203606E83C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxIENLz0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E68F10FE03;
	Wed,  4 Nov 2026 19:19:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35FE710FE03
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:19:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D28B43EF3;
 Wed,  4 Nov 2026 19:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C301F00919;
 Wed,  4 Nov 2026 19:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793819964;
 bh=+QMuJvtMuQ+CXnn6xLeWoxU7H9VJY0mzKEyTXi76/+M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gxIENLz0UJSM86XrOE1Sp3JOvLA1u1MA6tN2TKsN8z69sY8YtYsnY9pKSo3aFOcfQ
 It+yrAGN09WT7v77bOcS26Rrfp6yDzWLpkBPnc74ur6LeQ3oTzrvuG6Ky0kmVgi5Bb
 Z3j0QjnFD8aYVcI8yWVigWpiQHEHJJZHAuuleBaspMz1mpQ5rRYAMWLJX0zRU4vJo6
 RVoQiNLCqpiXG3Q/pt4TC6GrXdJ/RtFA4o6YSTd9QUZ7eQ0PuRnoorZ/GGmdi0VNty
 8+ElarT6h6fA4UlBB9caj85En7ce0T5GP9cwgZFrj2EBL5oKo+5dRL8rx9quzBAg6O
 vLwWBgOdvm1Pw==
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
Subject: [PATCH RESEND v2 13/51] sched/psi: don't drop the last byte of a
 trigger write
Date: Wed,  4 Nov 2026 20:19:09 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-13-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/5ST8groFWC3ZYrB9+5K2L5OtN8hrslkTr6MpvXzbng=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGrrgdqjlnhsS+Xn2bQzAZGlod8csUEIbzAtYr5Z7PKO7g1AP
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmrrgdoACgkQkcYbwGV43KLVfgEA1c1M
 +KyfIhJG/BAv6BFn00vAnDN1zj94NkCXNtd8aaQBAIjacXos/OXrlYuIrWKCfCTQiGjILl4kpqo
 N1Eyu2lMK
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

psi_write() copies at most 32 bytes of the write into its buffer and
terminates the buffer by overwriting its last byte. For a write shorter
than 32 bytes that is the last byte the writer sent. A trigger written
without a trailing newline loses its last digit then, "some 150000
1000000" turns into "some 150000 100000", and a shorter one like
"some 150 10000" fails with -EINVAL because the window doesn't fit
anymore. Only writes that end in a newline parse as intended.

Copy at most 31 bytes and terminate behind them.

Fixes: 0e94682b73bf ("psi: introduce psi monitor")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/sched/psi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7c5381423334..8b59635e95d4 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1566,11 +1566,11 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 	if (!nbytes)
 		return -EINVAL;
 
-	buf_size = min(nbytes, sizeof(buf));
+	buf_size = min(nbytes, sizeof(buf) - 1);
 	if (copy_from_user(buf, user_buf, buf_size))
 		return -EFAULT;
 
-	buf[buf_size - 1] = '\0';
+	buf[buf_size] = '\0';
 
 	seq = file->private_data;
 

-- 
2.53.0

