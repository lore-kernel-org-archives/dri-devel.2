Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B926FCD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD90111283C;
	Sat, 30 May 2026 14:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eMuGFhgE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B8F8112824
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 046B4429FA;
 Sat, 30 May 2026 14:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636541F00893;
 Sat, 30 May 2026 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149718;
 bh=86RQseK1x3RYpcqAxhfX0PcWRDq0d0elpvrh0WS+2CQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eMuGFhgEhHn+uJz393LklEZg8Fbpbaesaox8eGpCPFva4RB6U7/x3WKrIehKSc4mL
 3otSip6BL2t7Eq+ASRw2tGcqYE/aqZro5/3RukuMaDtzHu0Za5SHRVjpWSIBpMcNvs
 9GtpM2km4KLSi+/RhFUuES/suyFuDNz2/25EkMKnY+3t88QNdG/QDKI50VZT5MZPCz
 IDKn5+AVfs24p/StnVFS8aq+23UtRF+iGhsfSUvPvKhbSiOgZXb2C7GSkUYJjo5qD7
 83qAAIVY67S5jM//CovKtdV51y0EpGpGpLGhWpXk6mzqmXElo4mB++3HGZDoWQc1WZ
 5p/81GKwy2c0A==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:51 +0200
Subject: [PATCH 46/76] drm/ingenic: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-46-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
 linux-mips@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=mripard@kernel.org;
 h=from:subject:message-id; bh=I20Q//RFK7ao359GomgqHXMDHn8VA8hI476OwudF+zM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSbz0ZF9wNvjZR8/NzrdZIngcRwjM8jnTmhAtxls84r
 3uJ6eDtjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRaV8Zq1l7BfYnS+x7rauW
 8O3BqevHq0os3/ozvPz4IF5jzbbm9OTl7BtUKtXYGectt/sXtMvpF2PD+mXTK3ocFv74+Jrljli
 38r3eWh6nZ0yWUW9X236eXWy78GLhn/+euk18Erc7cj4pLrcDAA==
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

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---
To: Paul Cercueil <paul@crapouillou.net>
Cc: linux-mips@vger.kernel.org
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 42c86f195c66..7e569af22391 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1029,11 +1029,11 @@ static const struct drm_encoder_helper_funcs ingenic_drm_encoder_helper_funcs =
 static const struct drm_bridge_funcs ingenic_drm_bridge_funcs = {
 	.attach			= ingenic_drm_bridge_attach,
 	.atomic_enable		= ingenic_drm_bridge_atomic_enable,
 	.atomic_disable		= ingenic_drm_bridge_atomic_disable,
 	.atomic_check		= ingenic_drm_bridge_atomic_check,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = ingenic_drm_bridge_atomic_get_input_bus_fmts,
 };
 

-- 
2.54.0

