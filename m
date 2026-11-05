Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F923606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=CVujYt/6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0864112C5A;
	Fri,  6 Nov 2026 09:18:54 +0000 (UTC)
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn
 [61.135.153.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7562910E2CD
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 09:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1793871352; bh=Rn4PUmQlghV6bDqelAkHDxWUrP063U3OOv3SoBPx5ys=;
 h=From:Subject:Date:Message-ID;
 b=CVujYt/6Im+SZW7O/5EWHKAhAsicCYffaDYvS87rQZYd69v3IRTV+8dnZoPDxGh+y
 UuSa+nbWnc7+ynYFzCVtfPT5PPEa/18y9n/hDiSEqBb+RHVq2PPfQFpLRsbEPKXyMX
 LiN6zUbWJ7R/ndQ0Cg28ataedWZZ45KJKLB+qoJc=
X-SMAIL-HELO: lxu-pcd
Received: from unknown (HELO lxu-pcd)([111.198.231.89])
 by sina.com (10.54.253.32) with ESMTP
 id 6AEC4DF20000355A; Thu, 5 Nov 2026 17:35:49 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=eadavis@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 212874456816
X-SMAIL-UIID: A9199AE68AA0430E97AE7DDE3DE72AD8-20261105-173549-1
From: Edward Adam Davis <eadavis@sina.com>
To: phasta@mailbox.org
Cc: media-ci@linuxtv.org, sashiko-reviews@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 robin.clark@oss.qualcomm.com
Subject: [PATCH v2] dma-buf/sw_sync: Optimize the retrieval of fence reference
 counts
Date: Thu,  5 Nov 2026 17:35:46 +0800
Message-ID: <20261105093546.61098-1-eadavis@sina.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <75367a9a19c1e9a007422e0a1b8ed0acaca2492a.camel@mailbox.org>
References: <75367a9a19c1e9a007422e0a1b8ed0acaca2492a.camel@mailbox.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 05 Nov 2026 08:49:49 +0100, Philipp Stanner wrote:
> > 
> >  drivers/dma-buf/sw_sync.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> > index 8df20b0218a9..261bc98b1ed6 100644
> > --- a/drivers/dma-buf/sw_sync.c
> > +++ b/drivers/dma-buf/sw_sync.c
> > @@ -221,7 +221,11 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
> >  		if (!timeline_fence_signaled(&pt->base))
> >  			break;
> >  
> > -		dma_fence_get(&pt->base);
> > +		if (!dma_fence_get_rcu(&pt->base)) {
> 
> You must hold the rcu_read_lock() while doing that, don't you?
dma_fence_get_rcu() is simply a wrapper around kref_get_unless_zero(),
it has nothing to do with RCU. For instance, the use of dma_fence_get_rcu()
within sync_pt_create(), as seen in the SW_SYNC_IOC_CREATE_FENCE code path
does not require an RCU lock.
> 
> This probably works "by coincidence" since the surrounding spinlock
> also disables preemption, like the rcu lock does.
> 
> That spinlock, why can't it guard the dma_fence reference? Doesn't obj-
> >pt_list hold its own reference?
This is neither a coincidence nor related to any outer spinlock.
The comments I included in my patch provide a complete explanation of
the fence's reference counting, from the moment of its creation to its
final destruction.

BR,
Edward
