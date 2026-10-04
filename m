Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4623FCA5FEF
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB9710E9CD;
	Sun,  4 Oct 2026 15:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="B186e5PE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636DE10E9C2
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=HmrD8spRZco7CFJp7KO7DlRD8X9Z6ZREaZkngUmRwUc=; b=B186e5PEN1lLbwRqkbjFLkxzB1
 s29K/3GKc002VBoc/o1hOWxfGYPELn0RzYWfYcm+vE+hfzQ8g2jDKb+eiQXmX7qvYbKX1pt1NS2/n
 B9Nreodf034Y5v5E01fXy8dIXXlmy/wywSKIaXhnXjaAAwcQHZ6pHK8PwkG7kxG9p5loogj/4l5D5
 LFYZbEivk7mM9TZX/SXMjt9ReqYswpj+E/BQOGs23XaD0KZ41glh9KTsu16twxuODq8Hylgwh3Mgx
 dyiulWTzh9MKA0zDjKATng3zV4rpJATRxt637Eb84DWiAnTCnnjSnkvroip/VUlHTjAQKnEt9yLD/
 VUPFEQmw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xDOMP-00BNsh-1v; Sun, 04 Oct 2026 17:42:45 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 04 Oct 2026 12:42:08 -0300
Subject: [PATCH 08/11] drm/vc4: Take job_lock only once to drain job_done_list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-vc4-misc-fixes-v1-8-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=7Jp4bRwTnU82H+VZlDL+hFFkpgbR1YF0furBsZiQx2U=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqwnPXGh27+LcI/ZzdRcxZO30+Aga8VMgy1PoGd
 2O9he+sRd+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCasJz1wAKCRA/8w6Kdoj6
 qpNBB/9+NL+IA989YnYICKoxdqnG5hksF97hGoqzTov4BYtYwl2IwXjcTJwrDrowQXrARi1s7Ij
 ljAUsqwB5aoEFGss+SR5Tow/xhbnRcksscnO6ZzrPe12IGehnL0sisG6eSUojAO2oy/+svzg0LM
 3k08P0SZDUzLWGvjHqBpwVV7LjohriYhYNBPorx4TFDYBGIeXcz+jaTmDt6WyW5dkatL15S6rUH
 uNZQzp61wlSWZ/F4i6lNri8XRt2K/ObW+vB1M/MK4rEQ0nv1JKqnwoNo7/osPZo19fguKnA72lC
 2O1SIFALkT4dwJWJPdVcOoTOqdppiwtQ4oImjpw6yGHctB/N
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

vc4_job_handle_completed() drops and retakes job_lock around every job it
completes, so a batch of N finished jobs costs N + 1 acquisitions of a
lock the interrupt handler takes on every bin and render done. Each retake
can contend with the handler.

Splice job_done_list onto a local list under a single acquisition and
complete the jobs from there. Jobs finishing meanwhile requeue the done
work, which picks them up on its next run.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index b65b3f62b098..b61f9b0a7c09 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -908,24 +908,19 @@ vc4_exec_put(struct vc4_exec_info *exec)
 void
 vc4_job_handle_completed(struct vc4_dev *vc4)
 {
-	unsigned long irqflags;
+	struct vc4_exec_info *exec, *next;
+	LIST_HEAD(done);
 
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return;
 
-	spin_lock_irqsave(&vc4->job_lock, irqflags);
-	while (!list_empty(&vc4->job_done_list)) {
-		struct vc4_exec_info *exec =
-			list_first_entry(&vc4->job_done_list,
-					 struct vc4_exec_info, head);
+	scoped_guard(spinlock_irqsave, &vc4->job_lock)
+		list_splice_init(&vc4->job_done_list, &done);
+
+	list_for_each_entry_safe(exec, next, &done, head) {
 		list_del(&exec->head);
-
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 		vc4_exec_put(exec);
-		spin_lock_irqsave(&vc4->job_lock, irqflags);
 	}
-
-	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 }
 
 /* Scheduled when any job has been completed, this walks the list of

-- 
2.55.0

