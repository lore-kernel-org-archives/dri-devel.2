Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E383606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=yNIkVzER
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC74112C3D;
	Fri,  6 Nov 2026 09:18:47 +0000 (UTC)
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn
 [61.135.153.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A7E1123CD
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1793882246; bh=K5laUMU2KJoz9qNykR8nk12tulWxuY+wCYFSFpscv3s=;
 h=From:Subject:Date:Message-ID;
 b=yNIkVzER9dJrTZhTXdarUZla2epgBE/v/W6/Xdu84pXwrhFlkSGWoVBWCt95S0VLa
 V9C3/y2U5zBL43NDz3u9VusDAS0IKLfGKDLBgZulY4pPoqzpRQhut+eDO3+Sqb79Uh
 Qp0711/JmBeg7d1Ha0yt3ohhHujpYveOTZqtMwp0=
X-SMAIL-HELO: lxu-pcd
Received: from unknown (HELO lxu-pcd)([111.198.231.89])
 by sina.com (10.54.253.32) with ESMTP
 id 6AEC787D000079EE; Thu, 5 Nov 2026 20:37:20 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=eadavis@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 8249174456693
X-SMAIL-UIID: A4384A86C4F04932A99FAA12BF8C2C2B-20261105-203720-1
From: Edward Adam Davis <eadavis@sina.com>
To: christian.koenig@amd.com
Cc: media-ci@linuxtv.org, sashiko-reviews@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 sumit.semwal@linaro.org, phasta@kernel.org, robin.clark@oss.qualcomm.com
Subject: [PATCH v2] dma-buf/sw_sync: Optimize the retrieval of fence reference
 counts
Date: Thu,  5 Nov 2026 20:37:13 +0800
Message-ID: <20261105123717.66572-1-eadavis@sina.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ad203438-ddbe-4445-bb3e-9632e738c1a5@amd.com>
References: <ad203438-ddbe-4445-bb3e-9632e738c1a5@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 5 Nov 2026 11:03:10 +0100, Christian König wrote:
> > There is a race condition between closing a sync file and the SW_SYNC_IOC_INC
> > operation on a sync obj. When a fence is created via SW_SYNC_IOC_CREATE_FENCE,
> > its reference count is initialized to 1. When the sync file is closed, the
> > fence's reference count drops to 0. A race occurs if SW_SYNC_IOC_INC accesses
> > the fence whose ref count has already reached 0 before dma_fence_release()
> > calls timeline_fence_release() to erase the corresponding pt_tree node from
> > the sync object, potentially hitting:
> >
> > refcount_t: addition on 0; use-after-free.
> > ------------[ cut here ]------------
> > kernel BUG at lib/refcount.c:34!
> > Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> > Call Trace:
> >  kref_get include/linux/kref.h:45 [inline]
> >  dma_fence_get include/linux/dma-fence.h:323 [inline]
> >  sync_timeline_signal+0x6d9/0x8a0 drivers/dma-buf/sw_sync.c:224
> >  sw_sync_ioctl_inc drivers/dma-buf/sw_sync.c:405 [inline]
> >  sw_sync_ioctl+0x7b4/0x13f0 drivers/dma-buf/sw_sync.c:470
> >
> > Use dma_fence_get_rcu() to replace dma_get_fence(), if fence reference
> > count is 0 then do like timeline fence release things: remove pt link
> > and erase pt node.
> >
> > Fixes: e531fdb5cd5e ("dma-buf/sw_sync: Avoid recursive lock during fence signal")
> 
> Please completely drop that. This is not something which has any justification to be backported.
OK.
> 
> > Reported-by: syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=cba1a1f459230395a076
> > Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> > ---
> > v1 -> v2: use dma_fence_get_rcu() and remove link & erase pt node
> >
> >  drivers/dma-buf/sw_sync.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> > index 8df20b0218a9..261bc98b1ed6 100644
> > --- a/drivers/dma-buf/sw_sync.c
> > +++ b/drivers/dma-buf/sw_sync.c
> > @@ -221,7 +221,11 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
> >                 if (!timeline_fence_signaled(&pt->base))
> >                         break;
> >
> > -               dma_fence_get(&pt->base);
> > +               if (!dma_fence_get_rcu(&pt->base)) {
> 
> Well that is at least better than before but still needs a code comment explaining why this is possible without holding the RCU read side lock.
> 
> Something like /* It's possible to race with timeline_fence_release() here */.
> 
> > +                       list_del_init(&pt->link);
> > +                       rb_erase(&pt->node, &obj->pt_tree);
> 
> What happens is that you race with timeline_fence_release(), so that here is superfluous and potentially even harmful.
timeline_fence_release() and sync_timeline_signal() are synchronized using
the same spinlock(timeline obj->lock is same as fence->extern_lock), so
there is no race condition between them. Instead, a race condition exists
between sync_timeline_signal() and sync_file_release(), which causes the
fence reference count to drop to zero prematurely.

By removing the link and re-initializing it here, list_empty(&pt->link) will
evaluate to true when the spinlock is acquired within timeline_fence_release(),
preventing the redundant execution of the link-removal and node-erase operation.

BR,
Edward
