Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AAB606D80B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=AZE6qEQx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818A0112C73;
	Fri,  6 Nov 2026 09:19:06 +0000 (UTC)
X-Greylist: delayed 540 seconds by postgrey-1.36 at gabe;
 Thu, 05 Nov 2026 04:24:35 UTC
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn
 [61.135.153.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90D610E136
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 04:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1793852676; bh=I70JP2SqokASsJErmH/yPweM9if0dk4HKlTSDOwI09E=;
 h=From:Subject:Date:Message-ID;
 b=AZE6qEQx5fP7tH7D7VB6ImSZJ0lpx+IGMXW4Ruv5GmuLtbeHwGpSeLmMWe/udOj3H
 kLOwDi25q24CEf5UBYKZlcd9ZDGisjZKN2zBI0PwP5kAFqPNoFsp3t+KJL36X4Nzm0
 4u4Uif9eHd5Xu3vS9fG1nRB3O07UYz18Go7LbWqU=
X-SMAIL-HELO: lxu-pcd
Received: from unknown (HELO lxu-pcd)([111.198.231.89])
 by sina.com (10.54.253.32) with ESMTP
 id 6AEC02B6000003F6; Thu, 5 Nov 2026 12:14:48 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=eadavis@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 6194074457038
X-SMAIL-UIID: 9A5FDA986C1D4943BA931602A231C7D6-20261105-121448-1
From: Edward Adam Davis <eadavis@sina.com>
To: syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 robin.clark@oss.qualcomm.com
Subject: [PATCH] dma-buf/sw_sync: Optimize the retrieval of fence reference
 counts
Date: Thu,  5 Nov 2026 12:14:46 +0800
Message-ID: <20261105041446.51979-1-eadavis@sina.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6aead2eb.3c6f2eba.20048d.0000.GAE@google.com>
References: <6aead2eb.3c6f2eba.20048d.0000.GAE@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is a race condition between closing a sync file and the SW_SYNC_IOC_INC
operation on a sync obj. When a fence is created via SW_SYNC_IOC_CREATE_FENCE,
its reference count is initialized to 1. When the sync file is closed, the
fence's reference count drops to 0. A race occurs if SW_SYNC_IOC_INC accesses
the fence whose ref count has already reached 0 before dma_fence_release()
calls timeline_fence_release() to erase the corresponding pt_tree node from
the sync object, potentially hitting:

refcount_t: addition on 0; use-after-free.
------------[ cut here ]------------
kernel BUG at lib/refcount.c:34!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
Call Trace:
 kref_get include/linux/kref.h:45 [inline]
 dma_fence_get include/linux/dma-fence.h:323 [inline]
 sync_timeline_signal+0x6d9/0x8a0 drivers/dma-buf/sw_sync.c:224
 sw_sync_ioctl_inc drivers/dma-buf/sw_sync.c:405 [inline]
 sw_sync_ioctl+0x7b4/0x13f0 drivers/dma-buf/sw_sync.c:470

Use kref_get_unless_zero() to optimize dma_get_fence(), in order to avoid
acquiring an object with a reference count of 0.

Fixes: e531fdb5cd5e ("dma-buf/sw_sync: Avoid recursive lock during fence signal")
Reported-by: syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cba1a1f459230395a076
Signed-off-by: Edward Adam Davis <eadavis@sina.com>
---
 drivers/dma-buf/sw_sync.c | 3 ++-
 include/linux/dma-fence.h | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 8df20b0218a9..ad60ad5e5cd9 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -221,7 +221,8 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
 		if (!timeline_fence_signaled(&pt->base))
 			break;
 
-		dma_fence_get(&pt->base);
+		if (!dma_fence_get(&pt->base))
+			continue;
 
 		list_move_tail(&pt->link, &signalled);
 		rb_erase(&pt->node, &obj->pt_tree);
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index dd07d128adc3..4d885c8e1d4f 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -320,8 +320,9 @@ static inline void dma_fence_put(struct dma_fence *fence)
 static inline struct dma_fence *dma_fence_get(struct dma_fence *fence)
 {
 	if (fence)
-		kref_get(&fence->refcount);
-	return fence;
+		if (kref_get_unless_zero(&fence->refcount))
+			return fence;
+	return NULL;
 }
 
 /**
-- 
2.43.0

