Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFF2C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A9D10E685;
	Thu, 17 Sep 2026 09:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H+c+T6So";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6EB910E683;
 Thu, 17 Sep 2026 09:09:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B24B60210;
 Thu, 17 Sep 2026 09:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9651F00893;
 Thu, 17 Sep 2026 09:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789636197;
 bh=MyfKyJ2IFpUV90Fd+O/PB8hPgrmFQXEYPQE9FH2U5+0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=H+c+T6SoQ7bi7KDrdywXGdkUQno8IYfgoOVzvBXc3Nel3/0tmU8DEF2bj0ddSxyTA
 O5Ud3r8id3oPVDTbslazb9ysVE9ON6gawxat9WFfRF4Q+PLx3tYIdqDQvqfm0jTC6m
 /cgGcLDIbqt+VgC97EYTKWndcVJt15N6YxfgDmj5eu1UG9nTF1RZQgHnsvksdXMQ4J
 HeZT6FODg0Zu/NjiC+NyOdMvy6958db56K9fLSUbAfl+qnuWWJfqq2A6efvvaTYfVC
 yB/nZ71w6QgCB7D8AkTClKTn3kksvqPNqAXrGppLTexMhqcBqNHdlHzRY3+U9l7UwV
 l3kws5Udp65xA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 17 Sep 2026 11:09:42 +0200
Subject: [PATCH 1/4] file: simplify FD_PREPARE()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-work-file-fd_prepare-v1-1-b87534ca49f3@kernel.org>
References: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
In-Reply-To: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, 
 wine-devel@list.winehq.org, linux-xfs@vger.kernel.org, 
 io-uring@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=5584; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DV2T4c+4xkA8K7vcmtRlGodHYsmKM293QENU4hzkJCg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStXhep3M4ftMm/0tX7f+TWpDfvNhuyLq2zqitf971kY
 uliTU+TjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm43Wf4Z6Buav4mVHvnrLJ/
 F/qWul+VYpPL7NnUl7Jl6qoAjkVXrzD803sVsfDCxzW/N0zhWlmzN8d3Q+NUxk1xjkFhk3MLuXJ
 D+QE=
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

It was originally built as an ACQUIRE-style guard but most of the
infrastructure was never needed and introduced complexity that we really
didn't need. Drop the ACQUIRE machinery and compute the error where the
fd and file are set.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/file.h | 99 ++++++++++++++++++++++------------------------------
 1 file changed, 41 insertions(+), 58 deletions(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 27484b444d31..2b864f457211 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/cleanup.h>
 #include <linux/err.h>
+#include <linux/vfsdebug.h>
 
 struct file;
 
@@ -159,87 +160,69 @@ typedef struct fd_prepare class_fd_prepare_t;
 	(_Generic((_fdf), struct fd_prepare: (_fdf).__file))
 
 /* Do not use directly. */
-static inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
+static __always_inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
 {
-	if (unlikely(fdf->__fd >= 0))
+	if (unlikely(fdf->__fd >= 0)) {
 		put_unused_fd(fdf->__fd);
-	if (unlikely(!IS_ERR_OR_NULL(fdf->__file)))
 		fput(fdf->__file);
+	}
 }
 
 /* Do not use directly. */
-static inline int class_fd_prepare_lock_err(const struct fd_prepare *fdf)
+static __always_inline struct fd_prepare __fd_prepare(int fd, struct file *file)
 {
-	if (unlikely(fdf->err))
-		return fdf->err;
-	if (unlikely(fdf->__fd < 0))
-		return fdf->__fd;
-	if (unlikely(IS_ERR(fdf->__file)))
-		return PTR_ERR(fdf->__file);
-	if (unlikely(!fdf->__file))
-		return -ENOMEM;
-	return 0;
-}
+	if (fd >= 0 && IS_ERR_OR_NULL(file)) {
+		int err = file ? PTR_ERR(file) : -ENOMEM;
 
-/*
- * __FD_PREPARE_INIT - Helper to initialize fd_prepare class.
- * @_fd_flags: flags for get_unused_fd_flags()
- * @_file_owned: expression that returns struct file *
- *
- * Returns a struct fd_prepare with fd, file, and err set.
- * If fd allocation fails, fd will be negative and err will be set. If
- * fd succeeds but file_init_expr fails, file will be ERR_PTR and err
- * will be set. The err field is the single source of truth for error
- * checking.
- */
-#define __FD_PREPARE_INIT(_fd_flags, _file_owned)                 \
-	({                                                        \
-		struct fd_prepare fdf = {                         \
-			.__fd = get_unused_fd_flags((_fd_flags)), \
-		};                                                \
-		if (likely(fdf.__fd >= 0))                        \
-			fdf.__file = (_file_owned);               \
-		fdf.err = ACQUIRE_ERR(fd_prepare, &fdf);          \
-		fdf;                                              \
-	})
+		put_unused_fd(fd);
+		fd = err;
+		file = NULL;
+	}
+	return (struct fd_prepare){
+		.err = fd < 0 ? fd : 0,
+		.__fd = fd,
+		.__file = file,
+	};
+}
 
 /*
- * FD_PREPARE - Macro to declare and initialize an fd_prepare variable.
+ * FD_PREPARE - Declare and initialize an fd_prepare instance.
  *
- * Declares and initializes an fd_prepare variable with automatic
- * cleanup. No separate scope required - cleanup happens when variable
- * goes out of scope.
+ * This allocates a new fd and only evaluates @_file_owned if the
+ * allocation succeeded. Cleanup happens when the variable goes out of
+ * scope and the guard releases whichever of the descriptor and the file
+ * was allocated. If fd_publish() was called the fd and file are
+ * published and cleanup becomes a nop.
  *
  * @_fdf: name of struct fd_prepare variable to define
  * @_fd_flags: flags for get_unused_fd_flags()
  * @_file_owned: struct file to take ownership of (can be expression)
  */
-#define FD_PREPARE(_fdf, _fd_flags, _file_owned) \
-	CLASS_INIT(fd_prepare, _fdf, __FD_PREPARE_INIT(_fd_flags, _file_owned))
+#define FD_PREPARE(_fdf, _fd_flags, _file_owned)			\
+	CLASS_INIT(fd_prepare, _fdf, ({					\
+		int __fd = get_unused_fd_flags(_fd_flags);		\
+		__fd_prepare(__fd, __fd < 0 ? NULL : (_file_owned));	\
+	}))
+
+/* Do not use directly. */
+static __always_inline int __fd_publish(struct fd_prepare *fdf)
+{
+	VFS_WARN_ON_ONCE(fdf->__fd < 0);
+	fd_install(fdf->__fd, fdf->__file);
+	return take_fd(fdf->__fd);
+}
 
 /*
  * fd_publish - Publish prepared fd and file to the fd table.
  * @_fdf: struct fd_prepare variable
  */
-#define fd_publish(_fdf)                                       \
-	({                                                     \
-		struct fd_prepare *fdp = &(_fdf);              \
-		VFS_WARN_ON_ONCE(fdp->err);                    \
-		VFS_WARN_ON_ONCE(fdp->__fd < 0);               \
-		VFS_WARN_ON_ONCE(IS_ERR_OR_NULL(fdp->__file)); \
-		fd_install(fdp->__fd, fdp->__file);            \
-		retain_and_null_ptr(fdp->__file);              \
-		take_fd(fdp->__fd);                            \
-	})
+#define fd_publish(_fdf) __fd_publish(&(_fdf))
 
 /* Do not use directly. */
-#define __FD_ADD(_fdf, _fd_flags, _file_owned)            \
-	({                                                \
-		FD_PREPARE(_fdf, _fd_flags, _file_owned); \
-		s32 ret = _fdf.err;                       \
-		if (likely(!ret))                         \
-			ret = fd_publish(_fdf);           \
-		ret;                                      \
+#define __FD_ADD(_fdf, _fd_flags, _file_owned)			\
+	({							\
+		FD_PREPARE(_fdf, _fd_flags, _file_owned);	\
+		_fdf.err ?: fd_publish(_fdf);			\
 	})
 
 /*

-- 
2.53.0

