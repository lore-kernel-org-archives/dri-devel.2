Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D636F364A6
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6AC10E067;
	Thu,  9 Apr 2026 17:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Esilw5jB";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F7410E063;
 Thu,  9 Apr 2026 17:09:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7A5C81A3253;
 Thu,  9 Apr 2026 17:08:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4E569603E4;
 Thu,  9 Apr 2026 17:08:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 63A85104500F2; 
 Thu,  9 Apr 2026 19:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775754537; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=NhYzqxeLYhJJ/6ErxgYsDp7OCqAbT6h4r7mS/NeBN9E=;
 b=Esilw5jBNt2HrURjOGXsg52LiDQiFuR0QII4Q91Rpe6T0eEUWE3VvQMHZ+yKKX+MzIInVx
 3roiCnEIl7sK/Fr89SK+iIVzA3aSLyUJpoSanEFRF/PUhnZide9jpzZBl2ql4TVzB0w5Jy
 LketgkWtt6ykso5AUT4CbjuyQcVFnYbFo6hZAYsEQJK6mcsV5/fOfmMibllUS1SJL0eIOr
 8dQxWlx4hITtWuQWnURGImJNSoHUjGMi0ZvaiW2tux7699tL+xK3EcK4Xd/2EUQWkThmuU
 OwDnYjTfVFwSjKHvtXFGcZGePvXwyZy/qN6G69EvEzyBFbOtXBTcNd80Pmw9CQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Apr 2026 19:08:18 +0200
Subject: [PATCH RFC 02/12] drm/i915/display/intel_lvds: Drop redundant
 manual cleanup on init failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-feat_link_cap-v1-2-7069e8199ce2@bootlin.com>
References: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
In-Reply-To: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
 Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chris Wilson <chris@chris-wilson.co.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev-d4707
X-Last-TLS-Session-Version: TLSv1.3
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

intel_lvds_init() had a goto-based error path that manually called
drm_connector_cleanup(), drm_encoder_cleanup(), kfree() and
intel_connector_free() when no LVDS panel mode could be found.

Once drm_connector_init_with_ddc() and drm_encoder_init() have been
called, the DRM core takes ownership of these objects and will invoke
their .destroy callbacks (intel_connector_destroy and
intel_encoder_destroy) during device teardown. The manual cleanup in
the failed: label is therefore redundant.

Remove it and replace the goto with a simple early return.

Fixes: 79e539453b34e ("DRM: i915: add mode setting support")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Not tested as I don't have such hardware.
---
 drivers/gpu/drm/i915/display/intel_lvds.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lvds.c b/drivers/gpu/drm/i915/display/intel_lvds.c
index cc6d4bfcff102..e78a41e2b268c 100644
--- a/drivers/gpu/drm/i915/display/intel_lvds.c
+++ b/drivers/gpu/drm/i915/display/intel_lvds.c
@@ -991,8 +991,10 @@ void intel_lvds_init(struct intel_display *display)
 	mutex_unlock(&display->drm->mode_config.mutex);
 
 	/* If we still don't have a mode after all that, give up. */
-	if (!intel_panel_preferred_fixed_mode(connector))
-		goto failed;
+	if (!intel_panel_preferred_fixed_mode(connector)) {
+		drm_dbg_kms(display->drm, "No LVDS modes found, disabling.\n");
+		return;
+	}
 
 	intel_panel_init(connector, drm_edid);
 
@@ -1005,12 +1007,4 @@ void intel_lvds_init(struct intel_display *display)
 	lvds_encoder->a3_power = lvds & LVDS_A3_POWER_MASK;
 
 	return;
-
-failed:
-	drm_dbg_kms(display->drm, "No LVDS modes found, disabling.\n");
-	drm_connector_cleanup(&connector->base);
-	drm_encoder_cleanup(&encoder->base);
-	kfree(lvds_encoder);
-	intel_connector_free(connector);
-	return;
 }

-- 
2.43.0

