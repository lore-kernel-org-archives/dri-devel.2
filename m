Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FD7CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE5E10E529;
	Tue,  9 Jun 2026 17:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Pc2G/oDJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9FD10E56E
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zi5PocG+dRwOESh9Y57j4Br4OdxqJHBzGtMvl7pcM48=; b=Pc2G/oDJgKGoQpwg2JU6Hah4Ol
 Q6DasH/CAM5ZPzPR1vk3cgzdd2Tj9HObmSxgSNr1fMGoFN6/sJodRPPahW/u627uHZldkai0foRaY
 zxGPSPG+0pl1RT0OkM1uMwM3d0ECadQ+v6QqUqkL/uHZbxGC5gCokQYPOFVNSjRYPwDXQD78RL2oU
 0OvcVmak1lMRfIcAHhXlZHC/Z9iUI1Lg8bo+VGHLhuK9ZwBFzO2C7b4oZr71BLWhrgjlieWLaMesR
 uKRdS6Rkt4sbS+1OkAABMDN8c+R0GgO5wEX6AHZX0ufPzzFYBC3w85rBKJVmjh/7AA4zAv4kMBHYI
 TCjt8Y9w==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wX088-00F5FG-Lz
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 19:20:49 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 8/8] drm/colorop: Check that requested colorop is the root
 of a pipeline
Date: Tue,  9 Jun 2026 10:19:41 -0700
Message-ID: <20260609171941.169104-9-John.Harrison@Igalia.com>
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

When assigning a colorop pipeline to a plane, the assignment is done
via the id of the root colorop in the pipeline. Add a check to ensure
that only root colorops are assigned and not something further down a
chain.

Signed-off-by: John Harrison <John.Harrison@Igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 530576850239..18193a270d40 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -613,6 +613,13 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		if (val && !colorop)
 			return -EACCES;
 
+		/* Colorop must be the start of a pipeline, not the middle */
+		if (colorop && !list_is_first(&colorop->pipeline_list, &colorop->pipeline_head)) {
+			drm_dbg_atomic(plane->dev, "[PLANE:%d:%s] Colorop %d is not head of a pipeline\n",
+				plane->base.id, plane->name, colorop->index);
+			return -EINVAL;
+		}
+
 		set_colorop_for_plane(state, colorop);
 	} else if (property == config->prop_fb_damage_clips) {
 		ret = drm_property_replace_blob_from_id(dev,
-- 
2.43.0

