Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FC5C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA76610F5FF;
	Fri, 26 Jun 2026 13:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TWLLo4kD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9263B10F5FF
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:57:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B1F041336;
 Fri, 26 Jun 2026 13:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D473C1F000E9;
 Fri, 26 Jun 2026 13:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782482254;
 bh=TXBjlXOuIzSrWNFuwq6lmUymlxGxtUbQXfctI3omd38=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TWLLo4kD0wO7jqnFVsa/rt8PsFszyhGK6P32jKMPvMT8h4EjTC3zObnGfP3oCZIEt
 L0H2AAs891uTs24ztE4l/2aLgaIpIBjjw4BuJWnpvbzMIbhxl+LIDGj9IIduZ4UXeD
 ES26EDk2YkAE16H9MRWe/dkDisN4pqtbcsd9sfTFTlA2kB6Puz/0T4u3P51GZgPyS+
 N+JEayxkUXoi5AUEdWz1X232nXLpi92xjf7LoxFBOcMbeoZWyowO5a2dnfZto0yIfo
 fub6BRLNxGjPU635eG+SYUOVkD7Tcvt/SwyJeaGiK2KJ3lyOpFogrBN+8onWgSa69z
 6NvWhTNMYiViw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 26 Jun 2026 15:57:05 +0200
Subject: [PATCH v3 04/30] drm/atomic: Convert drm_priv_to_bridge_state to
 container_of_const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-drm-state-readout-v3-4-d5825e3299a8@kernel.org>
References: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
In-Reply-To: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=mripard@kernel.org;
 h=from:subject:message-id; bh=p0HgvSYqVmO94aLFUUWAxjbWWUHzOiOF4TSBVczweo0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl2rUbeN0+6R1Ud2OTwL1gp613QSaXc720sVVILdxie3
 uW745ppx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIku2MDUeedJycsqH//8uX
 2zfqLNrm/KmqiuPFirU5zN0ujwOjskIWHNyydvuuG/nqy49tvL1p8ynG+sSW5lsnXnlY17oaRa9
 67/gxrlfd7qw0r6PkzvrcNx8qp3qtT3jSVGdpVfnwmsHkin1ZAA==
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
index 1d05d5d7162e..def18b60a106 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1379,15 +1379,12 @@ struct drm_bridge_state {
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
 drm_atomic_get_bridge_state(struct drm_atomic_commit *state,
 			    struct drm_bridge *bridge);
 struct drm_bridge_state *

-- 
2.54.0

