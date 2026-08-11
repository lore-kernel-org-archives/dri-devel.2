Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C28C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED5F10EBFD;
	Tue, 11 Aug 2026 13:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aNEpZg1Q";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAD610EBF6;
 Tue, 11 Aug 2026 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=XUF9Fh6Vzy3zIJCsMwAyrUyR3W3KQ3DW6Ua10Q7SEDU=; b=
 aNEpZg1Qw/MYw5TL+C+cq8WTwWDJxcoMpcDHowI7HgeHhPQq07G6HXy1KHEDtxgKDfAM153ctB5lt
 Lj6CIhUsR40FvCqyS87CP5SExgHquiOqEpVIKifA2igUFm5e3TLQGJWqdWYsqQFqBbwDeReTgCJVc
 pY1ER2U5+pzQmCBFwNfp8ugeK4cNEDjj2EOPHY1akC+NZHmjw2q+v1e093LsDqt06y27M7uPURJiE
 sOdj7CCkdEsQ2RAwodgJ7UsJyeuUpr5+Yyxomj+6qswC6xA7mG0N+2BmgaY+oWGYbAl2/zD4vlifK
 yadFAalJzC+sVSObXpaGfOqrJEJZXp2kVg==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpx-00H9qY-F7; Tue, 11 Aug 2026 15:48:13 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 16/20] Revert "accel/amdxdna: Remove
 drm_sched_init_args->num_rqs usage"
Date: Tue, 11 Aug 2026 14:47:54 +0100
Message-ID: <20260811134758.96339-17-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
References: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
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

This reverts commit ac58121339db0178186d256a956bb65feb8b6e45.
---
 drivers/accel/amdxdna/aie2_ctx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 4b3a62aa8798..2b97d9707129 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -665,6 +665,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 	struct amdxdna_dev *xdna = client->xdna;
 	const struct drm_sched_init_args args = {
 		.ops = &sched_ops,
+		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = HWCTX_MAX_CMDS,
 		.timeout = tdr_timeout_ms ?
 			msecs_to_jiffies(tdr_timeout_ms) :
-- 
2.54.0

