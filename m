Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB321061B18
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 17:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99AD810E63A;
	Mon, 30 Mar 2026 17:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="B5HnbgT0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFD010E63A
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kx5Hvpk462Lwzq1+9JzU0yj0s/n4YyP/29WdCQDgofM=; b=B5HnbgT0Uiq/lrctzAa96FUpwX
 k8s48AwjISYdk3QjP+fEDbj0tiRcjPhjrepupZ16e497DP2D0koXPqa3lv13ptuK03TOYr3W8A7Ok
 XS095R1UacqHZU9+lpociJhwSH0xE3hhBOLbVMwAUqZbuaaolUgkrVvCeCupGvQMoU2prSG9qHU0q
 g+xv6gd5Z3Ddi9BdQ/MhnRt686eVlqv0cNASJeyGKLVsgwklTNbf4xvnZ6iDqCl4+hCkrrM2hrVaA
 f3JIjba3QechQ3HzFM+5LRRNlfaC6+ykgdJUcVAEn6+aNDu2zK2s9Z2NPI1TMEInFWWtKs2Ovs1Cn
 bbXmVyKw==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w7GmW-00961G-JI; Mon, 30 Mar 2026 19:52:08 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 30 Mar 2026 14:51:45 -0300
Subject: [PATCH 3/6] drm/vc4: Fix a memory leak in hang state error path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-vc4-misc-fixes-v1-3-92defc940a29@igalia.com>
References: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
In-Reply-To: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=XYKKl90VXfhBo2yti9X0EwlGNrG1YZGLpgD0kbYaz80=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpyrg5k6vj4uH+0uL2l7pXHzVvO41zQlO5ZVFgx
 Zhb3TcWU/eJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCacq4OQAKCRA/8w6Kdoj6
 qmuoB/oDSH32dwqxe/etiKn15rL9DNj3yuboATCy5hYpick3SObRBcFRej6cnlWA4LMVd5AVMuU
 mfowsXzG2E4hJh7jV4+dr4BXhQYt0aMttP6pgT0WV3Kemhoec+u9MlOhSg/CPfl2A+Xk7zMYXT/
 VBZ16S9J2fnaKG1uo6kGqDfiBgMSSZKV/VkRRyabiU9/U1eQTV+js8uSJRy9LvO8RDmaKheV+CA
 126h1ym5ok6obQdJrqGO7RnMg3CLD+kc5nCgGLsJy0MrQfITHhqh+ig72XUGJ5I1MtBMTdC+j92
 eqIVyf7cZMD0s10yIboJtTGcIIM6tFdP1RBarH65YmYM5U5K
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

When vc4_save_hang_state() encounters an early return condition, it
returns without freeing the previously allocated `kernel_state`,
leaking memory.

Add the missing kfree() calls by consolidating the early return paths
into a single place.

Fixes: 214613656b51 ("drm/vc4: Add an interface for capturing the GPU state after a hang.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 248c47665a193fa639a481f97ac2af634f415384..ab3c6d5d4eb446804877d6b8da01c3a9f65800df 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -171,10 +171,8 @@ vc4_save_hang_state(struct drm_device *dev)
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
 	exec[0] = vc4_first_bin_job(vc4);
 	exec[1] = vc4_first_render_job(vc4);
-	if (!exec[0] && !exec[1]) {
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
-		return;
-	}
+	if (!exec[0] && !exec[1])
+		goto err_free_state;
 
 	/* Get the bos from both binner and renderer into hang state. */
 	state->bo_count = 0;
@@ -191,10 +189,8 @@ vc4_save_hang_state(struct drm_device *dev)
 	kernel_state->bo = kzalloc_objs(*kernel_state->bo, state->bo_count,
 					GFP_ATOMIC);
 
-	if (!kernel_state->bo) {
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
-		return;
-	}
+	if (!kernel_state->bo)
+		goto err_free_state;
 
 	k = 0;
 	for (i = 0; i < 2; i++) {
@@ -286,6 +282,12 @@ vc4_save_hang_state(struct drm_device *dev)
 		vc4->hang_state = kernel_state;
 		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 	}
+
+	return;
+
+err_free_state:
+	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+	kfree(kernel_state);
 }
 
 static void

-- 
2.53.0

