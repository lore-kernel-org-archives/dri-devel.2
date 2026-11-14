Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A2606F722
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AuAdV4hK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B698610F09C;
	Sat, 14 Nov 2026 18:04:29 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6BF10E7B5
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679459;
 bh=VA0rwkfjSh33P+agF41CZoRoNRegKroGX+B+IDlTDzs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AuAdV4hK6N8r3Qcr9K6kq7g2E4LPupergUw2gcirBQiganMOJegrSohQwdyi3G9pg
 cPnngILkVuJtELdWIPCN4t7kjnJSWNpzGuZvEFufwjF61LN2VP810AegVFkXrNopHn
 JqLvCfXb8tEcds8WDMnodqcpawVVWHzQnsEsShvx6HsOzuRVdqRWU9JANENRaU7LXl
 RhAJyNQyzNK0Lrju7R4BkRgVX0z7RepdRJ30m8MEHv7TJKXtTPDI0umGnND0hH+0iI
 kE9eO3bii8xuHmxu4qF9c33X4VHGaEUstoG2vW6tvtt7bEHhJbvQXrkhgVF+Cub4pG
 Z/+HpwIh5eu6A==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 67EAA17E0F3F;
 Sat, 14 Nov 2026 19:04:19 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:27 +0200
Subject: [PATCH 03/25] drm/display: hdmi-state-helper: Drop
 drm_atomic_helper_connector_hdmi_force()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-3-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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

With all callers converted to the .force_ctx() connector helper, this
function has no users left.  Remove it.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 15 ---------------
 include/drm/display/drm_hdmi_state_helper.h     |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 66ae678fc078..c50cedc7fa65 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1440,21 +1440,6 @@ int drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
 
-/**
- * drm_atomic_helper_connector_hdmi_force - HDMI Connector implementation of the force callback
- * @connector: A pointer to the HDMI connector
- *
- * This function implements the .force() callback for the HDMI connectors. It
- * can either be used directly as the callback or should be called from within
- * the .force() callback implementation to maintain the HDMI-specific
- * connector's data.
- */
-void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector)
-{
-	drm_atomic_helper_connector_hdmi_update(connector, NULL, connector->status);
-}
-EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_force);
-
 /**
  * drm_atomic_helper_connector_hdmi_force_ctx - HDMI Connector implementation
  * of the force_ctx callback
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 21e5a9215319..ddbfb5b80fa8 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -27,7 +27,6 @@ int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *con
 int drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 					     struct drm_modeset_acquire_ctx *ctx,
 					     enum drm_connector_status status);
-void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector);
 int drm_atomic_helper_connector_hdmi_force_ctx(struct drm_connector *connector,
 					       struct drm_modeset_acquire_ctx *ctx);
 

-- 
2.56.0

