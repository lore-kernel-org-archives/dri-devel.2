Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7460C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ACDE10FF10;
	Wed, 14 Oct 2026 17:30:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC0E910FF09
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3961405DA;
 Wed, 14 Oct 2026 17:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6981F000C5;
 Wed, 14 Oct 2026 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999039;
 bh=K6UV+ASTpak6tQQcMbMhrP+Lon7baZizVAIHBAwoObg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=E4dNBIwSKgJt8/RxERVUzw6B+IdEeiTuC+7YpM0so7E2hYOVS+otmYD7TKV5x+d0y
 CcCvHGMimHg+wvE3Lc0HG8b0sflKexFEqo9vfGEt6r/WkZVA2q5RzMmKGP8AUhcCWp
 WMbJft/G0p0/dPr80PSkVsgkSCPPegSLqOaKayRKEZHNFBDIFTp4iS4xQ/v6YNKmcb
 deY4Y8QG7/2p9scohDkEw4VJNyZvsrEwxA610870snzbIiBNhJxjk1J6n9YnIbNNQh
 PBnmrzDt+EQ07nS0/qpBfslTqTEsF9qTLRZ15LOlNpnU6N0ZWUjTYUqfbjGTWmv1x6
 tqBaps0L9LNaQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:20 +0200
Subject: [PATCH 57/75] drm/bridge: synopsys: dw-hdmi: Convert to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-57-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kmMkMsjmqZ0AILXTxxaHBjRwZU9G4o7pZ/6g5VHF+Iw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndycLNa+WMTJaEcG8VvI79841y9ZMFj2iZvx4/YULE
 YqHrxYe7pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATifjH2DDLveDnvW9vbff9
 PKF7v6CRy0BgSaZ8XPW2QN6b05wrD+v27PzZIDgrIaX9wP+1U/ftNWNsWHHSZFWWYUbPb4PAf4K
 VZTn90j5GXvvfvS5+Wv5/22zJtpUPf77ZE747PehF18EzeXVbAQ==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The dw-hdmi driver calls drm_atomic_helper_connector_reset() during
connector creation to allocate an initial connector state needed by
drm_connector_attach_max_bpc_property(). However, the driver only
needs to allocate a pristine state, which is exactly what
atomic_create_state provides.

Convert to drm_atomic_helper_connector_create_state() with proper
error handling.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 917cf764c9c5..5f11707c67b5 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2603,11 +2603,19 @@ static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
 
 	/*
 	 * drm_connector_attach_max_bpc_property() requires the
 	 * connector to have a state.
 	 */
-	drm_atomic_helper_connector_reset(connector);
+	if (!connector->state) {
+		struct drm_connector_state *conn_state;
+
+		conn_state = drm_atomic_helper_connector_create_state(connector);
+		if (IS_ERR(conn_state))
+			return PTR_ERR(conn_state);
+
+		connector->state = conn_state;
+	}
 
 	drm_connector_attach_max_bpc_property(connector, 8, 16);
 
 	if (hdmi->version >= 0x200a && hdmi->plat_data->use_drm_infoframe)
 		drm_connector_attach_hdr_output_metadata_property(connector);

-- 
2.55.0

