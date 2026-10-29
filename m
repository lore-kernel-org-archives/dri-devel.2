Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE693606A335
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+M3hRU+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CB210FFD0;
	Thu, 29 Oct 2026 07:35:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA0110FFD0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:34:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6251543238;
 Thu, 29 Oct 2026 07:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01081F01825;
 Thu, 29 Oct 2026 07:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259289;
 bh=EQI04VHpvv1WklkT5I2KF8b9QZzeTGSdFkez0v/w4oQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=k+M3hRU+GmVLFJh/tRbH+O1VCQ8Npw6lUyjuRViDUO0UBWVQK91qvPvx4yOXqXvWj
 eKcoRkQXuzed6aMG5uFYzLekYC9TugPjLBbfnBv/YjwdyhhgdDrF0DwN2uBVV2UMU4
 iLuDRjNNFOGZ8yGFx5mH0yeea8Emrk7MM2ALsOrYL9pwtk/a18FpAdl7qHaUPzPv1J
 q/Ojqra8VxW6MCmonCy+G99FszumEeXmkBHes59bRgbEWFAXj/p9X0et6s3UIQZ4wA
 pVluJzED5D5mbn54MXSoUR7VTOOSAqX73tHQDbBM459cVv4TfmncCr08uTgsNXV5uI
 Vham7SoPTeDXg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:33:57 +0100
Subject: [PATCH v7 07/34] drm/bridge: Add drm_private_obj_is_bridge()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-7-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
In-Reply-To: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=mripard@kernel.org;
 h=from:subject:message-id; bh=RFO+tz+7yA7sDGQkmLk5CVUL2tZj94/guFNMVT9se9s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvr03n1OtbifIkzg7jkP9QlrqPKVjbIafs/8wcXhJr
 rLZ9n9Wx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI5A/Ghmnt1WoR5i94Dz5y
 3rzq5uoJz5M+Bb3cvGtqYWTGicsPKhSKRf7eafbVPto1kbMkOs92K2OtlMEp/qz/WlazwwV+zVk
 isoY7P7pM5XlYz4e0zleTNRXTTa8c/Mq57evBdNa3nzZP1wsDAA==
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

The SRO readout helpers need to distinguish bridge-backed private
objects from other private objects, because bridges require special
readout ordering through the encoder bridge chains.

Add drm_private_obj_is_bridge() which checks whether a private
object's funcs pointer matches the bridge private state funcs.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 15 +++++++++++++++
 include/drm/drm_bridge.h     |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index e237366199a7..b2d77824e4be 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -589,4 +589,19 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 };
 
+/**
+ * drm_private_obj_is_bridge - check if a private object backs a bridge
+ * @obj: private object to check
+ *
+ * RETURNS:
+ *
+ * True if @obj is the &drm_private_obj embedded in a &struct drm_bridge,
+ * false otherwise.
+ */
+bool drm_private_obj_is_bridge(struct drm_private_obj *obj)
+{
+	return obj && obj->funcs == &drm_bridge_priv_state_funcs;
+}
+EXPORT_SYMBOL(drm_private_obj_is_bridge);
+
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 54cf0d223bba..a22a0bdf3251 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1235,4 +1235,6 @@ drm_priv_to_bridge(struct drm_private_obj *priv)
 }
 
+bool drm_private_obj_is_bridge(struct drm_private_obj *obj);
+
 bool drm_bridge_enter(struct drm_bridge *bridge, int *idx);
 void drm_bridge_exit(int idx);

-- 
2.55.0

