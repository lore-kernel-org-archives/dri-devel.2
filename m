Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C5606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcF5A0YF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230131128B1;
	Fri, 30 Oct 2026 15:15:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379D211289F
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:15:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 210C740442;
 Fri, 30 Oct 2026 15:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9701F000C1;
 Fri, 30 Oct 2026 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373328;
 bh=SmQJ/QOgciiA3oLyaKwDCTX47w+dkmN/GfTl5w0GINs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IcF5A0YF8+o39tT5L8UaLNZjgRbJMyn7uL9ExYcvoVv7lMlNnGRkpU3B38gs7bz0x
 ldTLe2YTS3qEagS+SKZGO0RACH0cZThCt4Fn1kTM47UW96Pz/1H0RolugMBTr6SFGB
 ASKdhBuQ3Tb4+1IHqalbq7TWYNUSzZTDc5JvDRcXFciKNdQH372Q4A/Qqy6KafkgKo
 fiVyI3hiAV0+kX/9L0TP4D1A1i7yJbhxfQ2JJbbkVa1L3u0rPX/eInV3N1HT4Z9Ziq
 lsN47MBmCtYlP9vrJgp9QyS2rro7zUsqXcHdgl80JaGJHoZNvV00Kis+V44EbqrMq2
 pq0lCw6Tv13vQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:56 +0100
Subject: [PATCH v3 26/37] drm/bridge: synopsys: dw-hdmi: Convert to
 atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-26-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+f4UHB+hW9f/Rz3iTVWucX6tPnxmGSmvT4DfyWnFVPo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtmh85Nl5rWKCZLRHdFf6r1f8jXuKkxQ+1VU9l5aXl
 vTOZj3WMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYy5QJjncVzcymHCx/rXX69
 2ML35ef74q0PzjubvSnVeFpa2KqvsXXh+y2ZR9PnXF+cllLl/DqynLHhvP6eusXLPu2aq//M+xe
 LeMe+ZCNeo70HD1dvnFPaISbF82GB+7qWLY0PinWj9k0uDUoAAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dw-hdmi driver calls drm_atomic_helper_connector_reset() during
connector creation to allocate an initial connector state needed by
drm_connector_attach_max_bpc_property(). However, the driver only
needs to allocate a pristine state, which is exactly what
atomic_create_state provides.

Convert to drm_atomic_helper_connector_create_state() with proper
error handling.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 917cf764c9c5..2d49fa92b8e2 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2606,5 +2606,15 @@ static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
 	 * connector to have a state.
 	 */
-	drm_atomic_helper_connector_reset(connector);
+	if (!connector->state) {
+		struct drm_connector_state *conn_state;
+
+		conn_state = drm_atomic_helper_connector_create_state(connector);
+		if (IS_ERR(conn_state)) {
+			drm_connector_cleanup(connector);
+			return PTR_ERR(conn_state);
+		}
+
+		connector->state = conn_state;
+	}
 
 	drm_connector_attach_max_bpc_property(connector, 8, 16);

-- 
2.55.0

