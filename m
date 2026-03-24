Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676E9F54AD9
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9217E10E5F0;
	Tue, 24 Mar 2026 16:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rvVER+so";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0815210E5F0;
 Tue, 24 Mar 2026 16:39:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B2D8243A93;
 Tue, 24 Mar 2026 16:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025E3C19424;
 Tue, 24 Mar 2026 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1774370373;
 bh=SucaKA0NzyZJdhS9+9yt3dqHcXk76x3cifX9yRYxzWQ=;
 h=From:To:Cc:Subject:Date:From;
 b=rvVER+sodacBOuAVjTL/y1npPJvWbZdgWOpXhtIDcutqxMeFL5R6lcHudJBfyydmO
 tX0HuOv5Cl4e8LQ/qJmoBXtjfxY3qGFK/GzvyeCBFDQdfXRynveRdnIp+93u9bBols
 vTHwtEqZ7kEjZdOnZtDVXEM5a7nCHl6RdIrd9tME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 stable <stable@kernel.org>
Subject: [PATCH] drm/amdkfd: stop speculation on the kfd_ioctl path
Date: Tue, 24 Mar 2026 17:39:09 +0100
Message-ID: <2026032408-divided-racing-fe78@gregkh>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=SucaKA0NzyZJdhS9+9yt3dqHcXk76x3cifX9yRYxzWQ=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDJmH9ulc2zlhS4XwwX6Jm/4aZvueiunxJft5ZK812p7lk
 7rB8uSijlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIQiLDgmudB4Muql3+vZ/1
 mn1p6tuD8VoFExkW7FQ/9WxW7hzryKtPtx3TyD5/U34rFwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
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

The kfd_ioctl takes a user controlled pointer, and then dereferences it
into a table of function pointers, the signature method of spectre
problems.  Fix this up by calling array_index_nospec() on the index to
the function pointer list.

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 09dabb3b3297..d2ef693c63da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -35,6 +35,7 @@
 #include <linux/mman.h>
 #include <linux/ptrace.h>
 #include <linux/dma-buf.h>
+#include <linux/nospec.h>
 #include <linux/processor.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
@@ -3349,6 +3350,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	if ((nr >= AMDKFD_COMMAND_START) && (nr < AMDKFD_COMMAND_END)) {
 		u32 amdkfd_size;
 
+		nr = array_index_nospec(nr, AMDKFD_CORE_IOCTL_COUNT);
 		ioctl = &amdkfd_ioctls[nr];
 
 		amdkfd_size = _IOC_SIZE(ioctl->cmd);
-- 
2.53.0

