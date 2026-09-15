Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E4AC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D92610FBA3;
	Tue, 15 Sep 2026 11:34:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JyIhvS+J";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB35610FBA4
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:34:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9286F4187C;
 Tue, 15 Sep 2026 11:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405011F000FF;
 Tue, 15 Sep 2026 11:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789472064;
 bh=KlocZhp7qjck9olR3klidY4UlF+C5OwdG3ef0fBmbDU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JyIhvS+JT82mqNUDoQEI5NLWlLHGSvHqAL4SSQ1kt8SKfEf+HfcjXdwmraSKCHGE8
 ZOy1pOhBVyA8CD8/PMtsr6/M5DyMiVViu2ENl+54eY1cvO87TiRTHmWjqOn6VYaBoZ
 R+EwigxYuUkdDx++PpQix7gADr1dTufOLv25uLow4e3SSmRhk6Xa/nk8d3fLnQOYYC
 Ydpt0fW4a/KY4J+ehGRp+fITQ9UnHopTKNJg1/CR1zut9A3qFE0J3crkfG5HDtEzwq
 G8elLfwAFZ2cfYNwrhA3h2Y1eTB9tlgjFj5+2pZKNm3kY5rb7mp2PNhr6wwTmKvzYc
 atFGIdRwNt4XQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:10 +0200
Subject: [PATCH RFC POC 24/50] file: make FD_ADD() a standalone immediate
 install
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-24-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484; i=brauner@kernel.org;
 h=from:subject:message-id; bh=T3KSWcji/YSytHTghs9Kt5BT4n+B/RVkFjKfZEpUiUE=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGqpLH2gnJPMvFkt0o4MjNDtgkqII7AmPHUY9LRg5JJdYim/g
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmqpLH0ACgkQkcYbwGV43KIfFQEAxyCZ
 bG8G/x+eu+vLdk6b9eKItI7HciqUsL6XwpabfYsA/1x0tYtG16iv2X3gSieaXgcMCW+XfqmAtez
 piRVBKO4N
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

FD_ADD() was built on FD_PREPARE() + fd_publish(). Give it its own small
macro that allocates the descriptor so it stays an immediate one-shot
for the hot descriptor-is-the-result paths (open, socket, accept, memfd
etc.).

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/file.h | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 04dd85cdd9bf..1ee7f058a882 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -259,24 +259,30 @@ static inline int class_fd_prepare_lock_err(const struct fd_prepare *fdf)
 		take_fd(fdp->__fd);                            \
 	})
 
-/* Do not use directly. */
-#define __FD_ADD(_fdf, _fd_flags, _file_owned)            \
-	({                                                \
-		FD_PREPARE(_fdf, _fd_flags, _file_owned); \
-		s32 ret = _fdf.err;                       \
-		if (likely(!ret))                         \
-			ret = fd_publish(_fdf);           \
-		ret;                                      \
-	})
-
 /*
- * FD_ADD - Allocate and install an fd and file in one step.
+ * FD_ADD - allocate a descriptor, build the file and install it in one step.
  * @_fd_flags: flags for get_unused_fd_flags()
- * @_file_owned: struct file to take ownership of
+ * @_file_owned: struct file to take ownership of (can be an expression)
  *
- * Returns the allocated fd number, or negative error code on failure.
+ * The file expression is evaluated only after the descriptor is allocated, so
+ * a full table does not run its side effects. Drops the file and returns a
+ * negative errno on failure. Installs immediately: for anything more than a
+ * bare install-and-return (reporting the number, configuring the file,
+ * installing several descriptors) use fd_prepare()/fd_stage().
  */
-#define FD_ADD(_fd_flags, _file_owned) \
-	__FD_ADD(__UNIQUE_ID(fd_prepare), _fd_flags, _file_owned)
+#define FD_ADD(_fd_flags, _file_owned)					\
+({									\
+	int __fd = get_unused_fd_flags(_fd_flags);			\
+	if (likely(__fd >= 0)) {					\
+		struct file *__file = (_file_owned);			\
+		if (unlikely(IS_ERR_OR_NULL(__file))) {			\
+			put_unused_fd(__fd);				\
+			__fd = __file ? PTR_ERR(__file) : -ENOMEM;	\
+		} else {						\
+			fd_install(__fd, __file);			\
+		}							\
+	}								\
+	__fd;								\
+})
 
 #endif /* __LINUX_FILE_H */

-- 
2.53.0

