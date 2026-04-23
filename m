Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED143F99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A5610F036;
	Thu, 23 Apr 2026 10:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bZEqdHUw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5270010F039
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:07:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CA3D96014C;
 Thu, 23 Apr 2026 10:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21451C2BCB5;
 Thu, 23 Apr 2026 10:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776938850;
 bh=NfpXRHDfjtbdTLaohoWAMhjlabdMXeldWPufpwAeQ3M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bZEqdHUwGBn0XK+exCeY3Xf7PvFUkOFAgfR1Nhd0YAUP9smSg5K/SW27mR2B47P15
 08MEO6ipf7eKl4lQxfNcCJxMBIhVgop2zkxjwZElXxp47oB01oczJmOCWDasw4/OUQ
 ebXq3FSPb6gz4yKPLML/Yaw2doY/2Mm/vC2uoy4YaRY8YJhUWQ//2rEgKjy2XWpM+1
 bgLuoS7fHU5/sw4EdUOfqG5xu+Tx9gPXkUSUyPl46ALAp0IvZJPPtBmqFeYR29jAs4
 dkenHbNsz55WcemdxU63isua9RMqN5XmzCAjGq3dwici3HZr2i2MfBzQGjXGIXYC5w
 iQSPBqtNVtvhQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:06:42 +0200
Subject: [PATCH v2 04/28] drm/atomic: Convert drm_priv_to_bridge_state to
 container_of_const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-4-6cde1a9910ed@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NfpXRHDfjtbdTLaohoWAMhjlabdMXeldWPufpwAeQ3M=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkv33vcWLzQTptPZr5WNP+Mywcqq5+cXXAu9ZQme22t5
 Y7Tui89O6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBENBMZ69StNhlWzxd7JfNN
 KqM41r73Vf3Gp7dcrbS5/KUWMYvte5fOkfj1sn+pRi6jVbB4mtt2xjqjhxm+K9J4/9/Y+lf0c8V
 mE8cr4ilf7f37GmwMr9aX3fuvmZmpIqt684tRK09jaOx7PwA=
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

container_of_const is more flexible than container_of when
it comes to mixing pointers constness. Switch to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_atomic.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index b9e7281cfc97..537092d3ed16 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1375,15 +1375,12 @@ struct drm_bridge_state {
 	 * @output_bus_cfg: output bus configuration
 	 */
 	struct drm_bus_cfg output_bus_cfg;
 };
 
-static inline struct drm_bridge_state *
-drm_priv_to_bridge_state(struct drm_private_state *priv)
-{
-	return container_of(priv, struct drm_bridge_state, base);
-}
+#define drm_priv_to_bridge_state(priv)		\
+	container_of_const(priv, struct drm_bridge_state, base)
 
 struct drm_bridge_state *
 drm_atomic_get_bridge_state(struct drm_atomic_state *state,
 			    struct drm_bridge *bridge);
 struct drm_bridge_state *

-- 
2.53.0

