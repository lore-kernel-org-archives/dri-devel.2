Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAB3C5CFE7
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A3E510EC3F;
	Tue, 11 Aug 2026 14:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QJuZCA4r";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BA910EC2F;
 Tue, 11 Aug 2026 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=ZrQ9CMTKEljzVy7sWhpmjOLtNymM5crqE9zxqEICNso=; b=QJuZCA4rIDrm1HjxKm8BNHbbHK
 22jY2Nsmv4K2k51k7hAbPDq/1qcQEszkLM+XeEDyTB10w3nG4wKR6WJGCpuspDl7j1KRIg4n5h+w+
 IbTg3p8u6ikUJA+9A4eUS87L4sekoofDWN0Z/WhaEHAs3sTg4K585Dl6QRvKEgGAKNKbwYXXZOi1s
 cLInYI7LS64/M9/OAtlU02Rbtt/4/H8cxDvo0BSLaNNGJv2085qgBL6ZnKj+AL44Y7CkFXelu+LUR
 n6E2fFiUJnFfYymenwXYZGt6N1Of4gOtLYAyEKslrbAlZfx7hjxxDsazKYMILrXgqDdaQWqinV5Oq
 icxNN7fg==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtn8v-00HBh2-L4; Tue, 11 Aug 2026 16:07:49 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luke.Wildhardt@proton.me, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH v2 11/20] Revert "drm/imagination: Remove
 drm_sched_init_args->num_rqs usage"
Date: Tue, 11 Aug 2026 15:07:28 +0100
Message-ID: <20260811140738.96974-12-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811140738.96974-1-tvrtko.ursulin@igalia.com>
References: <20260811140738.96974-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This reverts commit f84d73d2a08498174d950ba5935930dd94df7d3c.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Luke.Wildhardt@proton.me
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 9e759421f075..24a8645aa913 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -1285,6 +1285,7 @@ struct pvr_queue *pvr_queue_create(struct pvr_context *ctx,
 	const struct drm_sched_init_args sched_args = {
 		.ops = &pvr_queue_sched_ops,
 		.submit_wq = pvr_dev->sched_wq,
+		.num_rqs = 1,
 		.credit_limit = 64 * 1024,
 		.hang_limit = 1,
 		.timeout = msecs_to_jiffies(SCHED_TIMEOUT_PERIOD),
-- 
2.54.0

