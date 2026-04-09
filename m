Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10D5F364A4
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69FFB10E061;
	Thu,  9 Apr 2026 17:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MIZWIZeI";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E039F10E061
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:08:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8B53CC5C18B;
 Thu,  9 Apr 2026 17:09:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C09BA603E4;
 Thu,  9 Apr 2026 17:08:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9BAF410450194; 
 Thu,  9 Apr 2026 19:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775754534; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=wQHs+xJKsUMQO+6CCh7X3NX/2yXBo/WKUOrvcvLPWfg=;
 b=MIZWIZeI6SDzL7xElyXrZcp1xP5FU/iv6TVLEMIzJzuy69V14+eWik9kRKFGixgQaD6ciS
 Ddf0uG5jq9ljh6Qn4Bfo3Lo4wh3XkM6VJnIAAGk9dBUjHNGHVUxP2CdnVN7cr8dJaD0IMj
 J0Syiixw7j9TNbIZj6PVG1Ugn2d1/iCHei/yCZMmd68Rx+dsZQxLDuWDrcTWQIm7QeB+QA
 164m9FfPe/Owoxjn26H4BCuDi+FulELgNLV8kTRt7/wicDSenIEtyWuk+lzDtW7/7QYFln
 hwwOk/KBfs0c9gD6gPRrMcw5DivnFR3liiquTWK6mqxqzChKFRM/bHEfHbbn+Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Apr 2026 19:08:17 +0200
Subject: [PATCH RFC 01/12] drm/i915/display/intel_sdvo: Fix double
 connector destroy in error paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-feat_link_cap-v1-1-7069e8199ce2@bootlin.com>
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

intel_sdvo_connector_funcs registers intel_connector_destroy() as the
.destroy callback. Once drm_connector_init_with_ddc() succeeds inside
intel_sdvo_connector_init(), the DRM core takes ownership of the
connector object and will call .destroy on teardown.

The error labels in intel_sdvo_tv_init() and intel_sdvo_lvds_init()
call intel_connector_destroy() explicitly before returning false,
causing it to be invoked twice: once in the error path and again by
the DRM core through the registered .destroy callback.

Remove the manual intel_connector_destroy() calls from the error labels
and return false directly instead.

Fixes: 32aad86fe88e7 ("drm/i915/sdvo: Propagate errors from reading/writing control bus.")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Not tested as I don't have such hardware.
---
 drivers/gpu/drm/i915/display/intel_sdvo.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
index 2e1af9e869ded..6eb2b4b45a9b4 100644
--- a/drivers/gpu/drm/i915/display/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
@@ -2873,16 +2873,12 @@ intel_sdvo_tv_init(struct intel_sdvo *intel_sdvo, u16 type)
 	}
 
 	if (!intel_sdvo_tv_create_property(intel_sdvo, intel_sdvo_connector, type))
-		goto err;
+		return false;
 
 	if (!intel_sdvo_create_enhance_property(intel_sdvo, intel_sdvo_connector))
-		goto err;
+		return false;
 
 	return true;
-
-err:
-	intel_connector_destroy(connector);
-	return false;
 }
 
 static bool
@@ -2945,7 +2941,7 @@ intel_sdvo_lvds_init(struct intel_sdvo *intel_sdvo, u16 type)
 	}
 
 	if (!intel_sdvo_create_enhance_property(intel_sdvo, intel_sdvo_connector))
-		goto err;
+		return false;
 
 	intel_bios_init_panel_late(display, &intel_connector->panel, NULL, NULL);
 
@@ -2967,13 +2963,9 @@ intel_sdvo_lvds_init(struct intel_sdvo *intel_sdvo, u16 type)
 	intel_panel_init(intel_connector, NULL);
 
 	if (!intel_panel_preferred_fixed_mode(intel_connector))
-		goto err;
+		return false;
 
 	return true;
-
-err:
-	intel_connector_destroy(connector);
-	return false;
 }
 
 static u16 intel_sdvo_filter_output_flags(u16 flags)

-- 
2.43.0

