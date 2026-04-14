Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AA9F9D0CF
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D24010E60E;
	Tue, 14 Apr 2026 13:38:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LIa3WnO9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD3D10E60E;
 Tue, 14 Apr 2026 13:38:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 21C2543FB1;
 Tue, 14 Apr 2026 13:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E806C19425;
 Tue, 14 Apr 2026 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776173933;
 bh=Kku6nJKrBYOq+QAdCBbdd+MU0pFbD9UDQdUDbtSpiVI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LIa3WnO9MAjxllNO5O9RRgVcE+n1pQW3gYwB7LDlPyGmPFe68WMbgUbczs8M+RJVH
 WAenISCputl55ibCQT5cpqHGZzzbX1RiNnq5evLNDqR9q3pRaLVPTlpfLWhEYPaZnl
 HJgPIm6V97vqVclk6P1oXH1Xef0uBnfZTqVC3eJJSq4DaRqP2rloT1Mg5K1NyKvQPM
 hMA58tKQWxb6Uh8UDVJ9VPKFnlx8w5BgseWD8044lnYsa1LL1DAsAdZVvy/5XqGr6I
 f2vp6HZuE2mIBwyjeP4aWo068TmHgNK8ZFLFMMPW49cRqRd9MFCfrt1jF+txAZuFQD
 9fJJ3JW/qr1Xw==
From: Philipp Stanner <phasta@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Dave Airlie <airlied@redhat.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@kernel.vger.org
Subject: [PATCH 2/2] drm/nouveau: Fix double call to drm_sched_entity_fini()
Date: Tue, 14 Apr 2026 15:37:35 +0200
Message-ID: <20260414133734.130115-3-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260414133734.130115-2-phasta@kernel.org>
References: <20260414133734.130115-2-phasta@kernel.org>
MIME-Version: 1.0
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

nouveau_abi16_chan_fini() does invoke drm_sched_entity_fini() twice:
Once directly, and a second time through nouveau_sched_destroy().

That's likely undesired behavior and might be a bug since
drm_sched_entity_fini() decrements reference counts.

Fix the issue by using the appropriate function,
drm_sched_entity_flush(), to ensure that the entity becomes idle.

Cc: stable@kernel.vger.org
Fixes: 9a0c32d698c1 ("drm/nouveau: don't fini scheduler if not initialized")
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index 7860877d909b..291203121f0c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -176,7 +176,7 @@ nouveau_abi16_chan_fini(struct nouveau_abi16 *abi16,
 
 	/* Cancel all jobs from the entity's queue. */
 	if (chan->sched)
-		drm_sched_entity_fini(&chan->sched->entity);
+		drm_sched_entity_kill(&chan->sched->entity);
 
 	if (chan->chan)
 		nouveau_channel_idle(chan->chan);
-- 
2.49.0

