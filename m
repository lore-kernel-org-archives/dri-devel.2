Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE1606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=N+C3r2bS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB67210EB60;
	Tue, 17 Nov 2026 18:40:50 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E5910EB60
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 18:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=I51Cm6Ck9h4Ru+oeZIaLxqVx575L3vwgMDr+fkw6O44=; t=1794940843; x=1796150443; 
 b=N+C3r2bSQ4t2kJPjLBC0sHqIi9cbqXPfPvaAYHDR5Jl59Yiny6RCd8lHYCisdfrh+Tut4lTj6iA
 SHHdFbq0dqn03ijMPV+gcDKfQiIMbl3Xo8hFmdDbw8KXk0KCQlTlsdIEDl1PlvmVkUWGarnEQ+hE7
 ZDc8qVArmz9RzWR7ekuClWcERyQteqIutD3C11NYKW9QDR9fqS8s9r3sjDY6OlcDj9I90CbtJ8bOE
 XzeqCkI9mgWoFR6vXvRXmBSC3gaCuWwFqunjJ9v9cC9qTTuglsh1Hn5m9Z9PPFLp7JqsLyy/Z/0sQ
 HGzC7BXuv888eRUNd8UCMcpRR6pPU1Co0lDg==;
From: Andreas Kemnade <andreas@kemnade.info>
To: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, luca.ceresoli@bootlin.com, andreas@kemnade.info,
 louis.chauvet@bootlin.com, aesteve@redhat.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/omap: dss: simplify omapdss_device_init_output
Date: Tue, 17 Nov 2026 19:40:19 +0100
Message-ID: <20261117184019.430513-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

During reviewing of a regression fix is that function, questionable
possibly unbalanced drm_bridge_put/get came to light. Sashiko
review pointed out that of_drm_get_bridge_by_endpoint() does not return
NULL, so the questionable code is simply unreachable and therefore does
at least not harm. Remove the dead code.

Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/omapdrm/dss/output.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
index b5cef5093a883..cbb9b2f1a2133 100644
--- a/drivers/gpu/drm/omapdrm/dss/output.c
+++ b/drivers/gpu/drm/omapdrm/dss/output.c
@@ -20,7 +20,6 @@ int omapdss_device_init_output(struct omap_dss_device *out,
 			       struct drm_bridge *local_bridge)
 {
 	struct drm_bridge *bridge;
-	int ret;
 
 	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
 	if (IS_ERR(bridge)) {
@@ -34,20 +33,11 @@ int omapdss_device_init_output(struct omap_dss_device *out,
 	out->bridge = bridge;
 
 	if (local_bridge) {
-		if (!out->bridge) {
-			ret = -EPROBE_DEFER;
-			goto error;
-		}
-
 		out->next_bridge = out->bridge;
 		out->bridge = drm_bridge_get(local_bridge);
 	}
 
 	return 0;
-
-error:
-	omapdss_device_cleanup_output(out);
-	return ret;
 }
 
 void omapdss_device_cleanup_output(struct omap_dss_device *out)
-- 
2.47.3

