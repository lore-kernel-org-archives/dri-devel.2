Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F76C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 19:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7DF810F56F;
	Thu,  2 Jul 2026 19:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="5dkZKhmM";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 759C410E4FF
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 19:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Subject:Cc:To:From:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=vnKcB5Qc5uYgBIQJbJyNv68MQyNqvImhS2o+Y5iALao=; t=1783019800; x=1784229400; 
 b=5dkZKhmM07i0UhDEckMQMOI2bi4z99nHWGR++Wq2b+A+k5IRPoCDVbL/g2+Fux6SurYqvbXd0C9
 4tZkth8JM+2D/qo6CzhWdJqWX+YTMKdPiqWiqCSmXqO6CZbGYK53Ny2jinzwnH1cM1XYpXTF+aO4n
 w+Iz+ZvnM3rt3hBpL6RQncg1idJqaLX05ROqq2hRQHHqLiTKVE9uYn35PbQi+hIJPftoymPRQQ1uQ
 Hq/FBkn3NOHvNtlYGwhziaMw+ILuwVQBN9XmxW4F2O7myKDKsVKJo2SACFzCNFYznqqPHUVZ/P+2m
 ycmypUTSwN4wBLxiwb3eaM6VKjYg2RXhfXKw==;
From: Andreas Kemnade <andreas@kemnade.info>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RESEND] drm/connector: check if destroy function exist
Date: Thu,  2 Jul 2026 21:14:53 +0200
Message-ID: <20260702191453.611070-1-andreas@kemnade.info>
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

