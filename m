Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5B9CD98CC
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD58110E54F;
	Tue,  9 Jun 2026 17:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="n29P2q1Z";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 799B910E54F
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MdpszZ1em2Nhx5e/MYDoZsD+yxmekJprEX9gY0AikeQ=; b=n29P2q1Zke6h+N564l5CXKY+LJ
 HPqbFrXLXEw06bowpHEDve5l8/I6z1xQcoAeIJErbXlVNUSqhqtAh7O05mv2lBPB+PSyv+AvVb4J/
 0PLhJI2oxqj3wOJdXK6zT6G4Ft+uityr4qr/tk57ygqv62G6cSBSXqRNCxAfgldCt9JAgelOervof
 CqPobn3qfcEpjxJY32nUnJ/GxGwqoCuRmaE++MwErvwO4n8+WrZ7EQBDWTZoE1geCfLGI2v8JMSQ5
 E3D+LBjDJ7ad/g78ZbFoHVQrwJ+e/K3IoFGPwCpdj0sRHBTbeaQnrNmWrjtedP+5yVTDfN5M/BMFs
 n/2RmOjg==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wX085-00F5FG-Dr; Tue, 09 Jun 2026 19:20:45 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH 5/8] drm/vkms/colorop: Update to new pipeline API
Date: Tue,  9 Jun 2026 10:19:38 -0700
Message-ID: <20260609171941.169104-6-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609171941.169104-1-John.Harrison@Igalia.com>
References: <20260609171941.169104-1-John.Harrison@Igalia.com>
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

Switch to using the new method for building colorop pipelines.

Signed-off-by: John Harrison <John.Harrison@Igalia.com>
CC: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/vkms/vkms_colorop.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_colorop.c b/drivers/gpu/drm/vkms/vkms_colorop.c
index 071f3a8d2e7c..ecb4fd56eb8c 100644
--- a/drivers/gpu/drm/vkms/vkms_colorop.c
+++ b/drivers/gpu/drm/vkms/vkms_colorop.c
@@ -41,6 +41,8 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
 	if (ret)
 		goto cleanup;
 
+	drm_colorop_add_to_pipeline(ops[0], ops[i]);
+
 	list->type = ops[i]->base.id;
 
 	i++;
@@ -58,7 +60,7 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
 	if (ret)
 		goto cleanup;
 
-	drm_colorop_set_next_property(ops[i - 1], ops[i]);
+	drm_colorop_add_to_pipeline(ops[0], ops[i]);
 
 	i++;
 
@@ -75,7 +77,7 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
 	if (ret)
 		goto cleanup;
 
-	drm_colorop_set_next_property(ops[i - 1], ops[i]);
+	drm_colorop_add_to_pipeline(ops[0], ops[i]);
 
 	i++;
 
@@ -93,7 +95,7 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
 	if (ret)
 		goto cleanup;
 
-	drm_colorop_set_next_property(ops[i - 1], ops[i]);
+	drm_colorop_add_to_pipeline(ops[0], ops[i]);
 
 	list->name = kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.id);
 
-- 
2.43.0

