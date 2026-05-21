Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9A7CD4F5E
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 11:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C0010E195;
	Thu, 21 May 2026 11:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="J38OrXTH";
	dkim-atps=neutral
X-Greylist: delayed 2529 seconds by postgrey-1.36 at gabe;
 Thu, 21 May 2026 11:15:55 UTC
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5740310E195
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=vnKcB5Qc5uYgBIQJbJyNv68MQyNqvImhS2o+Y5iALao=; b=J38OrXTH32HpQ12aHh+9mXCUKb
 JxRr3GlwM/07+j3vPOmiS3QYQ2K6KcjWKj2pbFvOMZeLgkKLQHuvYjUiIFVAnPSJzbV51Ixi9CjX4
 up2/zuRhqU7ujiwh4UD1bE1puVVHJNkCdi2HjBuodTRYJue+8CrOSe5RbapRtVnyzLRTSjEQ61wJr
 KQsm5LHgvoq0f6IONFZAXHU38K+Pz46uXFsuVJRe/JUmUBhsSimCNfIK0vwTGxPmnVdSqAYWt8gMZ
 XTQS5c6E/Ms7zmFacZlSmnfHVhkx8CjLuqdkwjtH3QyjeuNoKMuhfi3b3fUBOmsN/bgeEimqkzD4T
 U/nVTh+g==;
From: Andreas Kemnade <andreas@kemnade.info>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] drm/connector: check if destroy function exist
Date: Thu, 21 May 2026 12:33:29 +0200
Message-ID: <20260521103329.140064-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
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

Connectors might have not resources needed to be manually freed.
E.g. the drm_bridge_connector does not have such a callback.

Fixes: c12907be57b1 ("drm/bridge-connector: switch to using drmm allocations")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/drm_connector.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 47dc53c4a738..d2dfc6e8f7d0 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -198,7 +198,9 @@ static void drm_connector_free(struct kref *kref)
 	struct drm_device *dev = connector->dev;
 
 	drm_mode_object_unregister(dev, &connector->base);
-	connector->funcs->destroy(connector);
+
+	if (connector->funcs->destroy)
+		connector->funcs->destroy(connector);
 }
 
 void drm_connector_free_work_fn(struct work_struct *work)
@@ -216,7 +218,9 @@ void drm_connector_free_work_fn(struct work_struct *work)
 
 	llist_for_each_entry_safe(connector, n, freed, free_node) {
 		drm_mode_object_unregister(dev, &connector->base);
-		connector->funcs->destroy(connector);
+
+		if (connector->funcs->destroy)
+			connector->funcs->destroy(connector);
 	}
 }
 
-- 
2.47.3

