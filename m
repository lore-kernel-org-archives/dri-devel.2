Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692B606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=s6zkJ6f+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563AE112CC3;
	Fri, 23 Oct 2026 18:17:15 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AAE10E09C
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 11:21:29 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jB0vq66w3zMlRG;
 Fri, 23 Oct 2026 13:21:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792754487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QIbRduFPpCg49J6sKBw6kbel4NImvjAYuxGSKO+X2OY=;
 b=s6zkJ6f+zClPkwezqXZnc5Y2cp721EhnkKkyh5KzYL54RHCjspwPT5HVVOXbCEjAj8Z4gf
 ynIrfiIlVWlO+xMjfXGQggnR5y2QJwAVEnSyTjGgurIUTLkpM0yoFBnjn1rgrVYoP124Ob
 L0DDnQ8rXBYLduHk9xEnW1bCqlrO5TPtCmTK1xRUSnuvYjMDGGDgfpHW1NWZk3dXo4ie0n
 TKe8N4USqFrxbyD4Yqj9zOBJxW0vFW8kYslJfBp1ZdJcjo514ARcvUUUMNFkT1YqCTe/tb
 tvhFvDiUyWVOkmTDGxytd+XtZT7Q4Wm5HXADirAGxv29M3NOCmTcfLsfuOTdfg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: [PATCH v2] drm/client: Don't print a NULL firmware config mode
Date: Fri, 23 Oct 2026 12:21:25 +0100
Message-ID: <20261023112125.2855499-1-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jB0vq66w3zMlRG
X-Mailman-Approved-At: Fri, 23 Oct 2026 18:17:02 +0000
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

Print "(none)" as the mode name instead. A connector whose mode is NULL
is skipped by drm_client_modeset_probe(), so it is left off, as before

While at it, drop the extra colon in "[CONNECTOR::%d:%s]". Every other
DRM debug message prints [CONNECTOR:%d:%s], and the double colon breaks
grepping the log for a connector id

Sashiko found this while reviewing a series that makes the fallback
return NULL more often, by also skipping modes larger than the client

Fixes: cf1d0180f571 ("drm/fbdev: Fallback to non tiled mode if all tiles not present")
Link: https://lore.kernel.org/all/sashiko-outbox-173425@kernel.org/
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
Changes in v2:
- Use modes[i] ? modes[i]->name : "(none)" in the existing message
  instead of a second drm_dbg_kms() (Thomas)
- Drop the extra colon in "[CONNECTOR::%d:%s]" on the same line
- v1: https://lore.kernel.org/r/20261022114356.669988-1-hugo@hsal.es

I ran checkpatch and built drm_client_modeset.o with W=1

 drivers/gpu/drm/drm_client_modeset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 0080a8e9556a..67f90e5d1512 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -754,10 +754,10 @@ static bool drm_client_firmware_config(struct drm_client_dev *client,
 		}
 		crtcs[i] = crtc;
 
-		drm_dbg_kms(dev, "[CONNECTOR::%d:%s] on [CRTC:%d:%s] using %s mode: %s\n",
+		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] on [CRTC:%d:%s] using %s mode: %s\n",
 			    connector->base.id, connector->name,
 			    crtc->base.id, crtc->name,
-			    mode_type, modes[i]->name);
+			    mode_type, modes[i] ? modes[i]->name : "(none)");
 
 		fallback = false;
 		conn_configured |= BIT(i);
-- 
2.55.0

