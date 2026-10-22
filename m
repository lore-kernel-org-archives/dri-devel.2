Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60766606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cswfRlBX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D561125CB;
	Thu, 22 Oct 2026 12:36:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614001125AF
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D9B4B60018;
 Thu, 22 Oct 2026 12:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEFE1F000C1;
 Thu, 22 Oct 2026 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672595;
 bh=LUcl12gwkN8B7VfualkhTFi3SbBn5mj0wBC5eClpxhE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cswfRlBXSmu5Mf4wULxcuKDDwWwZVpnZtPbJVn+Pnn3Mx9bV8cUq9FrPs65Kj2udo
 j8r7bdY2G57A9CICKPS7OVn5H0rwEqnTtdMvl3EL0JCnNAO0VHXznJKm3buV2UmJzC
 0qi5iG0XoRnGTfHuhbiv2vBpuig9rabuUbo5un5scReQcaWfey6CeRLcIBZ/iVRil5
 ArUy6XZAMYYhFI1oTQ9bfHIPrtU4KAwXFvCBu1EnOmMyYMc64za2IZQ2XzZvwO4Mtw
 yK6U468EmHmA8WtO4inedGH+LCxyH6YS7VUr5WllA3nfEHGJ9UbUPQBZNic24cu6yU
 TjM4k/zpMaUGg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:46 +0200
Subject: [PATCH v2 47/59] drm/sun4i: hdmi: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-47-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2001; i=mripard@kernel.org;
 h=from:subject:message-id; bh=w9nESPjYXbVij1sc0qXET6/o4C+Z94CFJROMxWaY4s4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mBbFnSo1su/UKjKwK88JnW+9uFD55b0lVndrhT37l
 yRfWhXSMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZyWoOxVlQua5f721N//mTX
 hq+f/KHPlW3lSUsxKZ/QlSc0OpjX35m5XMdk9R+xcvdpna7H2E5/Y2yYdHfzm/tPVU/3BQslOGx
 7diA41M5RPIJB65iMsNa07Iq/bJobmHcs2fFa7XFegfblZk4A
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The sun4i HDMI connector reset implementation creates a pristine
state and initializes the HDMI state. It does not perform any
hardware reset.

Since this is equivalent to what atomic_create_state expects, convert
the reset function to an atomic_create_state hook that returns the
initialized state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-sunxi@lists.linux.dev
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 3084f6570c29..58626d0562ae 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -291,9 +291,17 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
 }
 
-static void sun4i_hdmi_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+sun4i_hdmi_connector_create_state(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_reset(connector);
-	__drm_atomic_helper_connector_hdmi_state_init(connector->state,
+	struct drm_connector_state *connector_state;
+
+	connector_state = drm_atomic_helper_connector_create_state(connector);
+	if (IS_ERR(connector_state))
+		return connector_state;
+
+	__drm_atomic_helper_connector_hdmi_state_init(connector_state,
 						      connector);
+
+	return connector_state;
 }
 
@@ -302,5 +310,5 @@ static const struct drm_connector_funcs sun4i_hdmi_connector_funcs = {
 	.detect			= sun4i_hdmi_connector_detect,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
-	.reset			= sun4i_hdmi_connector_reset,
+	.atomic_create_state	= sun4i_hdmi_connector_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

