Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A389F99367
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F77810F03B;
	Thu, 23 Apr 2026 10:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IH7QRsW2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC4210F046
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:07:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 21EE7600AE;
 Thu, 23 Apr 2026 10:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6CEC2BCB2;
 Thu, 23 Apr 2026 10:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776938855;
 bh=Nk4dOoFLxVzCJfJnsEvhWmANR87bE+u/Y8+lSXias/M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IH7QRsW2iPktlk0aAJ26icdTmfn9rbpfmSv4f193ejl68bze6myifCHv+7fdN/lCC
 gVAKwJZNWlohD27z9chC3ZPPvWb9kSGfeQ3kYJmB0aUhc8iiszQo0tny6CdltWOtBC
 smMElO6cNtyr6keJfsovq5aKFNg6DpWdXmmqiEokbrdppN2pXaKwntcHqKyon5AfOH
 hmYPdE3LLhXnaib8M3BD0uM71XX1iQiWu6hNSGNcBHrjmXEg5sgb1xs0yWk1ryNLV8
 DOJH9AkGuBB+LCdW8+DfY0VAx1JUHo0RJlRjenlLF5cgQnlz7YGdsCVzm5x2YKu7lH
 /HgQowhloHYXA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:06:44 +0200
Subject: [PATCH v2 06/28] drm/bridge: Add drm_private_obj_is_bridge()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-6-6cde1a9910ed@kernel.org>
References: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2188; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Nk4dOoFLxVzCJfJnsEvhWmANR87bE+u/Y8+lSXias/M=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkv33vuP7q/cl1u/ZUrPVKHOhdrMjlPUKyRnBu+U2yu7
 oO+M780O6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEDlxmrK8oV5f2CZdRzhCx
 fBSiIDb9f2+NvOfLEzcfHj1Z7PXum8l1jlJWu8AoljNn0ybvMF9wnbE+Tqxz30Qx0yUni0W5NOz
 8e45eerZHlEfN/0T0Ves1JwMb1i672vVAReZXQX6whPLxmY8B
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
index 44d53906e4c5..5b8e171afbe5 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -512,10 +512,25 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_create_state = drm_bridge_atomic_create_priv_state,
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
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
 static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
 {
 	return bridge->funcs->atomic_reset != NULL;
 }
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 84b5517726c1..425f3ca03d95 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1285,10 +1285,12 @@ static inline struct drm_bridge *
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
2.53.0

