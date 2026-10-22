Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61828606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=iqBI3hGF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46AC41129E0;
	Fri, 23 Oct 2026 07:28:41 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8DD510E3FB
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:44:01 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j9PSG1LQ6zMldX;
 Thu, 22 Oct 2026 13:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792669438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GvtSA2Shz25CrsYn4ZnOQ56BgUS6CKhMK1jzzc7BlSc=;
 b=iqBI3hGFppLyJK0ygEG3k+8qzzDCPGXFNg3aGJzdw3V7spcNMS/Y4PW4fyoTtUNzRihgzu
 rfEi9Y2VwzOkru+7tkN3JSIwkLimW1oq08EEeNs1RF8THkoQ4Pe0G1h1OdRN8dc+Z5ODS6
 4OL8gm/G60Q22WcKwWMTa5w/37bLlTScU/l8xdEkDaX4i7y8m61ZM5AD85ZRoRbfPoS69O
 Vot3rTrh8LLuZN4FtJTEuyMfoV1OmygSSwalIe5flpToektLnJyVYS/7HJZJbJtKreCFZg
 25/Qex8dJoKmVVXXrJ9sPcgqY2vd37ZI/CVEOIWyFRzRfU6hIzjO5xTM4NMlqA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Hugo Sales <hugo@hsal.es>
Subject: [PATCH] drm/client: Don't print a NULL firmware config mode
Date: Thu, 22 Oct 2026 12:43:56 +0100
Message-ID: <20261022114356.669988-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j9PSG1LQ6zMldX
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:28:18 +0000
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

When some tiles of a tiled display are missing,
drm_client_firmware_config() replaces the connector's mode with
drm_connector_fallback_non_tiled_mode(). That returns NULL when
connector->modes has no mode other than the tile size, but the debug
message after it still reads modes[i]->name. Accessing a member through
a NULL pointer is undefined behaviour. Today printk happens to get an
address below PAGE_SIZE and prints "(efault)"

Print which step found no mode instead, "no non tiled mode found" in
this case, from the mode_type the function already tracks. A connector
whose mode is NULL is skipped by drm_client_modeset_probe(), so it is
left off, as before

Sashiko found this while reviewing a series that makes the fallback
return NULL more often, by also skipping modes larger than the client

Fixes: cf1d0180f571 ("drm/fbdev: Fallback to non tiled mode if all tiles not present")
Link: https://lore.kernel.org/all/sashiko-outbox-173425@kernel.org/
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
Sashiko found this while reviewing my fbdev probe series:
https://lore.kernel.org/all/20261015212545.1989962-1-hugo@hsal.es/
That series makes the fallback return NULL more often

I ran checkpatch and built drm_client_modeset.o with W=1

 drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 0080a8e9556a..a8cbe4c0e166 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -754,10 +754,15 @@ static bool drm_client_firmware_config(struct drm_client_dev *client,
 		}
 		crtcs[i] = crtc;
 
-		drm_dbg_kms(dev, "[CONNECTOR::%d:%s] on [CRTC:%d:%s] using %s mode: %s\n",
-			    connector->base.id, connector->name,
-			    crtc->base.id, crtc->name,
-			    mode_type, modes[i]->name);
+		if (modes[i])
+			drm_dbg_kms(dev, "[CONNECTOR::%d:%s] on [CRTC:%d:%s] using %s mode: %s\n",
+				    connector->base.id, connector->name,
+				    crtc->base.id, crtc->name,
+				    mode_type, modes[i]->name);
+		else
+			drm_dbg_kms(dev, "[CONNECTOR:%d:%s] on [CRTC:%d:%s] no %s mode found\n",
+				    connector->base.id, connector->name,
+				    crtc->base.id, crtc->name, mode_type);
 
 		fallback = false;
 		conn_configured |= BIT(i);

base-commit: cf5d8e390e2ac2cfa24a50645efdbb9f0eebe65f
-- 
2.56.0

