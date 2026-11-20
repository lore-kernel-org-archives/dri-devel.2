Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD9606A33C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gj0OP50B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEFD1129FF;
	Fri, 20 Nov 2026 12:58:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E0F10E8D1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:57:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B62A405D5;
 Fri, 20 Nov 2026 12:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FF11F000CA;
 Fri, 20 Nov 2026 12:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179449;
 bh=aWJTeL7Ozo2HzQmve/WDsHjc8kKWq2KB+ZW9fpBdCR4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Gj0OP50ByznDYhsmR3NDsESaJT5pH5C/NmGA6Uj/3a6oDXIyX4X+cSULqfxuFpvk4
 NqKsRmsI9gEz6CNm+MqKgfR1y9mMnV+s6XpMBoiyIqkgO+wQDTRRv9/CgJdzwKkIVM
 q6TxXMKrqNTh2PDsnvjj9gto4p4+8FJYg32BTOzcHysFk255AYdvitC51mzyktzpvq
 u55Bm1gaMwhNKEB36h6+AuLKFKKld54uN3OIq5fLABX05zlJpli8nVauEMiuHyRULE
 Bv1Vcl96gF+9W9PvK7LuQBmuKYZeUJcx4dD2a+n8cOKfIoMmb215eHLx5Z0Fjf6B8N
 0zPvghd+RMThA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:29 +0100
Subject: [PATCH v9 37/42] drm/tidss: encoder: Implement
 atomic_sro_get_current_crtc
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-37-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=mripard@kernel.org;
 h=from:subject:message-id; bh=u9MwwmlPLYCzfzQbhmdbR9mEber98RiZwNegxR5zeaU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzkaRjpYP1HXKz+nNLk4QNG/e63jqcvju0ym2kUwta
 fXPnrZ2TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIkcD2CsU166lUcuTNRu34vj
 k71XXFW/cuH6l/zQME3dhq9znC5KtD3Z8ej0i4jWws+rfrLeq1sgwljvKfD5pn/M6zcssUJliZV
 NDYaaCtGarlrbRS5myBb2+i/qfevfE19SZi2pI6nlJJuZCwA=
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

The tidss driver doesn't really implement anything with encoders, it
just relies on simple encoders, bridges and drm_bridge_connector.

In order to figure out the CRTC -> connector association from the
hardware state, we do need encoder support though, through the
get_current_crtc callback.

Since the tidss encoders are always connected to a single CRTC, we don't
really need to read the hardware state though, we can simply return the
one we know we are always connected to.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_encoder.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 5034e601ac86..1ca054a3cd87 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -121,11 +121,26 @@ static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 	.atomic_sro_readout_state	= tidss_readout_state,
 	.atomic_sro_compare_state	= drm_atomic_helper_bridge_compare_state,
 };
 
+static struct drm_crtc *tidss_encoder_get_current_crtc(struct drm_encoder *encoder)
+{
+	struct drm_crtc *crtc;
+
+	WARN_ON(hweight32(encoder->possible_crtcs) > 1);
+
+	drm_for_each_crtc(crtc, encoder->dev) {
+		if (encoder->possible_crtcs == (1 << drm_crtc_index(crtc)))
+			return crtc;
+	}
+
+	return NULL;
+}
+
 static const struct drm_encoder_funcs tidss_encoder_funcs = {
+	.atomic_sro_get_current_crtc = tidss_encoder_get_current_crtc,
 	.destroy = drm_encoder_cleanup,
 };
 
 int tidss_encoder_create(struct tidss_device *tidss,
 			 struct drm_bridge *next_bridge,

-- 
2.56.1

