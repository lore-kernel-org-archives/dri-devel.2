Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F0E606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nj+HjLJ/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC6E1125C1;
	Thu, 22 Oct 2026 12:36:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D35881125C1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 57F7160DCA;
 Thu, 22 Oct 2026 12:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616F81F000C2;
 Thu, 22 Oct 2026 12:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672584;
 bh=XOjykYAdgYsccRJhzsi09Ey317QqV7GbK9J3mGe2MLQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nj+HjLJ/zIdVg/fTVp0CCCaJaOsywhpwNeFGq4rbI8ZThxHeKHrdiZ1ZY8BCWc60K
 5nKqbnmRlknkO47AYuKc3jcUmXgZ6AotP8wJUG3nd4QDIUN4C7XelseoMGVRn3sl6T
 SL2l4PlbGtXVXOAvOGT+TL1LrgE9sFtZVo0uPyBLz7F7QfdTJ7QPCd+Pz7k4qWlIAY
 ppqNqAxS2Cy4iVjRvpAS+HC3j+DTK8MwaPkC3QCrsR4Bk3hXjuYIi1fS08kgXPjVE6
 sZpaVWcG2duaqwMjfeiabFfqioUp7ChQ8JHVgqkotQzuzkBbFFz/JKb/oVKU8OHa5E
 H8T5PulTsDd2Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:43 +0200
Subject: [PATCH v2 44/59] drm/bridge: synopsys: dw-hdmi: Convert to
 atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-44-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/JvqtQtKv594a2+n+48TjG0+d6rHCtxSIbeZwzC4wpg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mBY8f3JbIWvzngebula+rpsnF7Kg+v+L19I55wpnf
 w5zid22pWMqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBMRKiRseHwpYWOO65YHb7v
 9+TqVeddvk0s0d/vqoQ9rm80S/3h+Y6PX1a34Gb+Pd6ajdmcRjmscxgbfl5/Z7Zz76sO99Xzwv4
 aZNita93q03x3TYdxo+F83cDFa6SkfLZybV4Yrhczyb3t4ozHAA==
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
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 917cf764c9c5..5f11707c67b5 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2606,5 +2606,13 @@ static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
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

-- 
2.55.0

