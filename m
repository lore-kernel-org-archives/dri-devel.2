Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1542ACC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C0510E188;
	Thu, 15 Oct 2026 15:09:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C2710E188
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:09:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9C0643BA3;
 Thu, 15 Oct 2026 15:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469AC1F000C5;
 Thu, 15 Oct 2026 15:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792076969;
 bh=7TdQEai0WuwjF9NB5GU+xrkEh3Ocqi3w3SZG0IevMKU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eab5AZcvAxw5WsjFsQz2aEvgBR+3W+nmP+7Xp85R+il01EUwDwasOeRgsMsMS4YiO
 L3PpHOjrjhs+pXh/xGx8lfb2J4i/mPJF181khIpDz76LQu4E+uTtm0dG1xWKayLlhn
 ez0xgotjwIC15keA1BA4vCJpF+ZzjKZAVflLrx0EJCkRuqdPdokZlhvI5v8XK40HBM
 Dfjoi/pnSh1CVAZ+v2rK1mUOWLgtpr4KO2yhfSkKj6wMlROqt+ewYSae24jra30K/g
 Y0VTj0Dnq0b/38RBoWmj5iQLEHoL5QJ2UCXTpkD1qqVqgCFno1jsH9iECZK9MWzs0z
 8wAQg4wCVgmEg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:08:56 +0200
Subject: [PATCH v6 04/28] drm/bridge: Add drm_private_obj_is_bridge()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-4-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200; i=mripard@kernel.org;
 h=from:subject:message-id; bh=boA5XNGgoNqoCRcKZhM8RfRKY0G1DvImk6W8E7QE2Jk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3vT89gk8cWbKqoZDBy8eWcXV9S/EM0NO1eOASvDPG
 Yr/Iw9f6JjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATWbCEsc6eW1793KWmsnd6
 5/6x+ylwKm8WfW9Su3nNll2vdHPXh5XWrlzcIyBZIF2w679awAEDK8ZakW9XohQzOxomvdie98J
 x+5WDCf9u1nPfiC13ZjynH20g+qlQPuib5PpajQXxATeSfh8DAA==
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

The SRO readout helpers need to distinguish bridge-backed private
objects from other private objects, because bridges require special
readout ordering through the encoder bridge chains.

Add drm_private_obj_is_bridge() which checks whether a private
object's funcs pointer matches the bridge private state funcs.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 15 +++++++++++++++
 include/drm/drm_bridge.h     |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 447fe6d333b3..9d5529765f5f 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -580,10 +580,25 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 	.atomic_print_state = drm_bridge_atomic_print_priv_state,
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
+	return obj->funcs && obj->funcs == &drm_bridge_priv_state_funcs;
+}
+EXPORT_SYMBOL(drm_private_obj_is_bridge);
+
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
  *
  * @encoder: DRM encoder
  * @bridge: bridge to attach
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 54cf0d223bba..a22a0bdf3251 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1232,10 +1232,12 @@ static inline struct drm_bridge *
 drm_priv_to_bridge(struct drm_private_obj *priv)
 {
 	return container_of(priv, struct drm_bridge, base);
 }
 
+bool drm_private_obj_is_bridge(struct drm_private_obj *obj);
+
 bool drm_bridge_enter(struct drm_bridge *bridge, int *idx);
 void drm_bridge_exit(int idx);
 void drm_bridge_unplug(struct drm_bridge *bridge);
 
 struct drm_bridge *drm_bridge_get(struct drm_bridge *bridge);

-- 
2.55.0

