Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A843C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA9110E74B;
	Mon, 29 Jun 2026 08:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LzgdEU0j";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD4510E753
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:17:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 073A943E7D;
 Mon, 29 Jun 2026 08:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C741F00A3A;
 Mon, 29 Jun 2026 08:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721049;
 bh=TXBjlXOuIzSrWNFuwq6lmUymlxGxtUbQXfctI3omd38=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LzgdEU0jtCqCAE1qNJD1XfoVhTdK7TlWaLZeKVz6yPv6eBltxvKURb4kRSYcyGLSb
 CnVHa3zYa4TD4gewYKQ/o28DgQDsqfkBIKcQG7OOuKM9mHQhcl1kG0BNMEprhpp7NO
 0lXWVtYGXGsauLMyQNVIIPIUbZziXnqSm7JYsOxgCJrOs1LKtW/J4eRWhLPQvg+tj4
 TfZObOFd4XxlyiARyjdHhOkIkJanDWXtT14IBIUUeNQvBjE7A+ci1eSwUa25M2RXis
 Yb8AkUFSjuwlIIXtN60Fx2Md3mzktFiA77/2Smu4KW3/lzceswNfwEy2At6iKqco65
 MNRB4A5VWpTXw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:02 +0200
Subject: [PATCH v4 04/30] drm/atomic: Convert drm_priv_to_bridge_state to
 container_of_const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-4-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
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
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWkyedwz9F//asUjvzq6pbdq2iTM2ha8oczl2tnrbT
 q+iqH7ejqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRVGnG+qTZ0VL+X28vambO
 /O6mEyTs+6TNQ1En+KxSGi/nDsVZuvJXA5n9Nm9g5P5n0r+MjdOIsd5/xuuLBxnjdyqKvDg0aXL
 K3eOiycsuRepOuz27O/S1gUUeS234evt2NbUk7u3mnyfYvAYA
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

