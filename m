Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7832CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1793410E0F4;
	Sun,  4 Oct 2026 15:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="j/elv+nm";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51B0110E04F
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=Ws61K1hcGdQpwbja0WY3ojBKo8oZhtPf9d5pv9XrkdY=; b=j/elv+nm7RxiOcQ8KBCWbmw/Jk
 lzte3amZeH9mZVsqW4YJLmM+ZCHd8G2kQgwv6zKS72cFPOkCtNrj5BF3NGkItjG/AdG8hPXAy62WB
 WYVFF8wBX+YX7URMfLBM+8PIvnJJkz1UMk032OgAmXXuvQtq5pz+ITWUqxsRzM78K803TD8mib97Y
 7nbTBCYlxWquq5vTKKXrnOM7GGk7m7RkJWrB8MMxgjP8gpUsPb8jAdmfcYYWrJw6dVjerQb/oSp0g
 87wo5PzfckIrLnqE36YMilUj5WIpgQqB1VcKoqRaeDzmqseRwFUBbbaqQ3/0as0hgh/NApZv/GdAG
 yxpnCIWg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xDOM8-00BNsh-N4; Sun, 04 Oct 2026 17:42:28 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 04 Oct 2026 12:42:03 -0300
Subject: [PATCH 03/11] drm/vc4: Refcount vc4_exec_info
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-vc4-misc-fixes-v1-3-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3950; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=0kIuC94Jx4CFGfAmu9dQjFLeby5QV65JoIyH6Wt9wIM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqwnPWeAGq4dTE5ei+8Miz6nVG0hqn455RRspFF
 7V4CjrxZuGJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCasJz1gAKCRA/8w6Kdoj6
 qh/wCADYqk1+Oa5kI+VfnM8TrpABf55YHJx0xWrr4FzuDZOd9K6KjXHHZlgHTuR+5UyW13IHw74
 IKWs2tynZdlI3QHFSNj4iwNXWl0Bq2xY4aJPREb2AwQko68TMYLGGiHaz+C1Ey/73BaQHbj/6aK
 CDSM+2qHXX2nTtO0RLe44eJU7dWK7Wl/ccuFbs+a1C5O8lyATJHA8B0s4XxJZCemeIQOXIvPQdF
 L5rKoar9IQJseJEyoD6QxNqH6FK87b8T541JJDIx2OKG6y9nFic+W8gSSVfd2i7Jm7Hf21vzVRM
 VnB+Wt78M+0VHxAktiSJF/01cShn308ULeKC/bWN1SiuA/2J
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

A queued job is owned by whoever reaches it last: the submit ioctl hands
it to the job lists and the job done worker frees it. This means that the
ioctl cannot touch vc4_exec_info once job_lock is dropped. That forces
everything that touches `exec` to sit inside the critical section, even
work that has nothing to do with the job queues.

Give the vc4_exec_info a refcount. The submit path holds one until it is
done with the job and the job lists hold another from the moment the job is
queued. The teardown happens when the last one goes away.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h |  2 ++
 drivers/gpu/drm/vc4/vc4_gem.c | 30 ++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index b0e82c2dc1ba..d18a0fece93c 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -671,6 +671,8 @@ struct vc4_crtc_state {
 struct vc4_exec_info {
 	struct vc4_dev *dev;
 
+	struct kref refcount;
+
 	/* Sequence number for this bin/render job. */
 	uint64_t seqno;
 
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 0fef9b48d3c6..b56952bb6b97 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -639,6 +639,8 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
 	fence->seqno = exec->seqno;
 	exec->fence = &fence->base;
 
+	kref_get(&exec->refcount);
+
 	/* The job can complete and drop exec->fence as soon as job_lock is
 	 * released, so hold our own reference.
 	 */
@@ -719,11 +721,11 @@ vc4_cl_lookup_bos(struct drm_device *dev,
 
 fail_dec_usecnt:
 	/* Decrease usecnt on acquired objects.
-	 * We cannot rely on  vc4_complete_exec() to release resources here,
-	 * because vc4_complete_exec() has no information about which BO has
-	 * had its ->usecnt incremented.
+	 * We cannot rely on vc4_release_exec() to release resources here,
+	 * because it has no information about which BO has had its ->usecnt
+	 * incremented.
 	 * To make things easier we just free everything explicitly and set
-	 * exec->bo to NULL so that vc4_complete_exec() skips the 'BO release'
+	 * exec->bo to NULL so that vc4_release_exec() skips the 'BO release'
 	 * step.
 	 */
 	for (i-- ; i >= 0; i--)
@@ -854,9 +856,11 @@ vc4_get_bcl(struct drm_device *dev, struct vc4_exec_info *exec)
 }
 
 static void
-vc4_complete_exec(struct drm_device *dev, struct vc4_exec_info *exec)
+vc4_release_exec(struct kref *ref)
 {
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_exec_info *exec = container_of(ref, struct vc4_exec_info,
+						  refcount);
+	struct vc4_dev *vc4 = exec->dev;
 	unsigned long irqflags;
 	unsigned i;
 
@@ -908,6 +912,12 @@ vc4_complete_exec(struct drm_device *dev, struct vc4_exec_info *exec)
 	kfree(exec);
 }
 
+static void
+vc4_exec_put(struct vc4_exec_info *exec)
+{
+	kref_put(&exec->refcount, vc4_release_exec);
+}
+
 void
 vc4_job_handle_completed(struct vc4_dev *vc4)
 {
@@ -924,7 +934,7 @@ vc4_job_handle_completed(struct vc4_dev *vc4)
 		list_del(&exec->head);
 
 		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
-		vc4_complete_exec(&vc4->base, exec);
+		vc4_exec_put(exec);
 		spin_lock_irqsave(&vc4->job_lock, irqflags);
 	}
 
@@ -1071,6 +1081,8 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
 		return ret;
 	}
 
+	kref_init(&exec->refcount);
+
 	exec->args = args;
 	INIT_LIST_HEAD(&exec->unref_list);
 
@@ -1160,12 +1172,14 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
 	/* Return the seqno for our job. */
 	args->seqno = vc4->emit_seqno;
 
+	vc4_exec_put(exec);
+
 	return 0;
 
 fail_unreserve:
 	drm_exec_fini(&exec_ctx);
 fail:
-	vc4_complete_exec(&vc4->base, exec);
+	vc4_exec_put(exec);
 
 	return ret;
 }

-- 
2.55.0

