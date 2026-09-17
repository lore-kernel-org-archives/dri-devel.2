Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3D1C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A3610E689;
	Thu, 17 Sep 2026 09:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l3gjnXE7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1610E10E687;
 Thu, 17 Sep 2026 09:10:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8AF5A60233;
 Thu, 17 Sep 2026 09:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812851F00898;
 Thu, 17 Sep 2026 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789636201;
 bh=7Hss+tphsWYYElyG0udvHfxNWLscjSFYocLTPr6cLgQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=l3gjnXE7hyT5hOLZNPuXtJreEraAnkHGYjZOWrcBMNjrzVCWdvetpyMslrwhSfAkO
 dRQF4mzZw8Y2oBrhxgj1+KlIDVtCllYMWw6nEV2QDqvjo+PpIsY3F4eSkb7CFXTq5g
 6ie6SAioCC9t3pGh2WqYiA1cVlB9RwhtH36z7l8mtgypnmlNz1f6coAtrJoiGo7Ic6
 6bsNfAy8z4WRfiuNSoBwsbSg691wK9hc7SgDLYTu17XLnT1aSqTcvtkCnScw6mneEs
 xNybY3vM3kCYqY6KHxfBrts0RxMC6vlY8bnK4wzq921kn+rwbhbK1xm5mfT6Le9Y7q
 2xoHozTmkIevA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 17 Sep 2026 11:09:43 +0200
Subject: [PATCH 2/4] file: declare the FD_PREPARE() variable with
 __cleanup() directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-work-file-fd_prepare-v1-2-b87534ca49f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; i=brauner@kernel.org;
 h=from:subject:message-id; bh=h8FDYLEJ2wCbTw+8dTetJhDBaeIOwFIz8qAAMf8e6eA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStXhe5uVx3TjxPZLCm+imW81Fc3kEKSm+U25QOvTeX1
 yj62pDUUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBEuTYb/Tue6jnQpfGRSycj4
 7OZ9mvk0u8L1e66vj/06JZdSrMvxleF/vLJdkGZv25roipfn7P9vT3sQN/f+5M0M00LYou33PPz
 OCgA=
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

The whole CLASS_INIT() detour isn't needed. Use __cleanup() directly and
give the destructor a private name.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/file.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 2b864f457211..926cc58d0b7f 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -146,9 +146,6 @@ struct fd_prepare {
 	struct file *__file; /* do not access directly */
 };
 
-/* Typedef for fd_prepare cleanup guards. */
-typedef struct fd_prepare class_fd_prepare_t;
-
 /*
  * Accessors for fd_prepare class members.
  * _Generic() is used for zero-cost type safety.
@@ -160,7 +157,7 @@ typedef struct fd_prepare class_fd_prepare_t;
 	(_Generic((_fdf), struct fd_prepare: (_fdf).__file))
 
 /* Do not use directly. */
-static __always_inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
+static __always_inline void __fd_prepare_cleanup(const struct fd_prepare *fdf)
 {
 	if (unlikely(fdf->__fd >= 0)) {
 		put_unused_fd(fdf->__fd);
@@ -199,10 +196,10 @@ static __always_inline struct fd_prepare __fd_prepare(int fd, struct file *file)
  * @_file_owned: struct file to take ownership of (can be expression)
  */
 #define FD_PREPARE(_fdf, _fd_flags, _file_owned)			\
-	CLASS_INIT(fd_prepare, _fdf, ({					\
+	struct fd_prepare _fdf __cleanup(__fd_prepare_cleanup) = ({	\
 		int __fd = get_unused_fd_flags(_fd_flags);		\
 		__fd_prepare(__fd, __fd < 0 ? NULL : (_file_owned));	\
-	}))
+	})
 
 /* Do not use directly. */
 static __always_inline int __fd_publish(struct fd_prepare *fdf)

-- 
2.53.0

