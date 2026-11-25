Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D0606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=retsim.com header.i=@retsim.com header.a=rsa-sha256 header.s=abaygg6onarqet2uti4t4yyiczbpngnf header.b=xOJVmZVr;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=z8lWZEJ0;
	dkim=temperror header.d=retsim.com header.i=@retsim.com header.a=rsa-sha256 header.s=dkim header.b=asa0Q+Ub
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A5E810E376;
	Thu, 26 Nov 2026 08:09:01 +0000 (UTC)
X-Greylist: delayed 987 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 08:43:12 UTC
Received: from a27-116.smtp-out.us-west-2.amazonses.com
 (a27-116.smtp-out.us-west-2.amazonses.com [54.240.27.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C94710FA1B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=abaygg6onarqet2uti4t4yyiczbpngnf; d=retsim.com; t=1795595204;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=HDa5c1pncVtqwAILklwmhPHA/9Encbeipusse6h8CTE=;
 b=xOJVmZVrOA2WCJdOz+YI7WfoYnXGf7L9Ld4Yc7+MVzIQzn6phQgRRBqGoxjh/2Nx
 oBJVoy1Buf3/LsU7HLFJ5PQw2L8En5VpkcqRQL6HBswRZJmy0hi14wh3se1vMxU1X2M
 D29VHTVLBa1FP19qHOZmcbYzjpStiF0Cqp/fGLjo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1795595204;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=HDa5c1pncVtqwAILklwmhPHA/9Encbeipusse6h8CTE=;
 b=z8lWZEJ0nIYeuHH9ZJg6A77wQOSY3gj85SRoLL8AG+7uWNm1ZwllsxlcKobCNvSy
 /dR8IhHB/fvbJBaow45NlkAmsH6MgEpH1tQaXd01x3ZHmMrNJqompZfboEjbder3mFp
 0fWJNNraoxED3UEOU9n6HWzSdMLFzjvWcGuLEC6s=
Authentication-Results: mailserver.retsim.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=retsim.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=retsim.com; h=
 content-transfer-encoding:mime-version:references:in-reply-to
 :x-mailer:message-id:date:subject:to:from; s=dkim; t=1795595197;
 x=1798187198; bh=HDa5c1pncVtqwAILklwmhPHA/9Encbeipusse6h8CTE=; b=
 asa0Q+UbL47O/5lBf3tmFAL+d6kSUzdi7pwciQwwrDdaF6a5tfgwJnrLHiOK83IE
 0EITwZaGbtOOkA0/6TdurfjL2xlHUOamN1L/IbX/N7oiyJ2bs8ZS1IuahsYO60Tn
 6qiJVG3xN4Z1NK5LGVPr3vCI00DTeMqsMexUZBvgiK2bSZrzLkFbmpeuBqSNjv9S
 6Y/++QcjyVPJgwZK19Ii1ejWZv/0LXxf1YaOSQQcR1Q0wJjOBj7voJKdFNPto7NV
 tScABCAbBanFf7SDyjURfm1b9jUFTFaWj6xwmaPSGGTZG5ijqMOcQ5+CLCo1t5P+
 YOtPb66H59qBSsFpIlpkhw==
X-Virus-Scanned: Debian amavis at 
From: Lewis Lakerink <lewis@retsim.com>
To: imagination@lists.freedesktop.org
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Ryan Brue <ryanbrue.dev@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Lewis Lakerink <lewis@retsim.com>
Subject: [PATCH 1/2] drm/imagination: guard fence release against device
 removal
Date: Wed, 25 Nov 2026 08:26:44 +0000
Message-ID: <010101a211d07798-70c4219d-e457-43d8-835c-321a7c035057-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125082637.2839673-1-lewis@retsim.com>
References: <20261125082637.2839673-1-lewis@retsim.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Feedback-ID: ::1.us-west-2.jZ+gdeR9TqNTaB6Dq50UPG8S0IjuYZETsFsi7SlhF6Q=:AmazonSES
X-SES-Outgoing: 2026.11.25-54.240.27.116
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pvr_queue_fence_release() queues fence->release_work onto
pvr_dev->sched_wq to drop the context reference and free the fence.
In drm_file_free(), drm_syncobj_release() runs before postclose; if a
syncobj holds the last reference on a job's finished fence after
pvr_remove() has destroyed sched_wq, releasing it dereferences the freed
workqueue:

  pc : __queue_work+0x240/0x550
  x25: 0xdead000000000100
  Call trace:
   queue_work_on
   pvr_queue_fence_release
   drm_sched_fence_release_scheduled
   drm_sched_fence_release_finished
   drm_syncobj_release
   drm_file_free

Guard pvr_queue_fence_release() with drm_dev_enter().  When unplugged,
call dma_fence_free() directly and leak the context reference: the
callback runs under rcu_read_lock() in dma_fence_release(), and the
device state needed by pvr_context_release() may already be torn down.

Fixes: df1a1ed5e1bd ("drm/imagination: avoid deadlock on fence release")
Cc: stable@vger.kernel.org # 6.14+
Assisted-by: LLM
Signed-off-by: Lewis Lakerink <lewis@retsim.com>
---
 drivers/gpu/drm/imagination/pvr_queue.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
index 34b8263..2a6bfb0 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 /* Copyright (c) 2023 Imagination Technologies Ltd. */
=20
+#include <drm/drm_drv.h>
 #include <drm/drm_managed.h>
 #include <drm/gpu_scheduler.h>
 #include <linux/overflow.h>
@@ -122,8 +123,19 @@ static void pvr_queue_fence_release(struct dma_fence=
 *f)
 {
 	struct pvr_queue_fence *fence =3D container_of(f, struct pvr_queue_fenc=
e, base);
 	struct pvr_device *pvr_dev =3D fence->queue->ctx->pvr_dev;
+	int idx;
=20
-	queue_work(pvr_dev->sched_wq, &fence->release_work);
+	/*
+	 * Fences held by drm_syncobj are released in drm_file_free() before
+	 * postclose. After unplug, sched_wq and kernel_vm_ctx may already be
+	 * torn down; free the fence directly and leak the context reference.
+	 */
+	if (drm_dev_enter(from_pvr_device(pvr_dev), &idx)) {
+		queue_work(pvr_dev->sched_wq, &fence->release_work);
+		drm_dev_exit(idx);
+	} else {
+		dma_fence_free(&fence->base);
+	}
 }
=20
 static const char *
--=20
2.43.0

