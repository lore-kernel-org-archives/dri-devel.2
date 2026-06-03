Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDA8CD6E6B
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60FEC113C72;
	Wed,  3 Jun 2026 09:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dLJJnzFK";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 470DD113C60
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 09:00:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id BCE97C62217;
 Wed,  3 Jun 2026 09:00:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EE76D5FD24;
 Wed,  3 Jun 2026 09:00:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 80C8510888CC5; 
 Wed,  3 Jun 2026 11:00:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780477233; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=SWJLbwcw1LfuoUnP65FT41JauKFUhB7nEOh+Gt4WQSE=;
 b=dLJJnzFK0xuKU5smX78GcLw72hCR9Rf7iBilOH4NL8BPKQekXcEy/YH8lpyX1vFD548KSm
 NB4YXxMFI/0tFNp9Mo6kP3KtrnJszt9IolCxhPwtf1p5nLwHz6QM/A9CwNc090o/m8X/Nt
 HhpVHtNIJORCX1y/qs5NwU5Cf2rgdzz6yFGokKruyJ9WWmf5cC9o1jnoQL1kyuzpv2tiPh
 YOa2q3HlFxmIby9mxm4iyRjTi5AlouOat7vyfEtJuo6g9cj8xVG6dwAMzf5pfA2BQbP1Ir
 LkzRTp0XTgrgZAJIXs/tRPXQnmmZCqgMQqNHLuWhn6Fx/hPTkQVp/UpltjPk0w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 03 Jun 2026 10:59:52 +0200
Subject: [PATCH 1/3] drm/i915/display/intel_sdvo: Fix double connector
 destroy in error paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-fix_i915-v1-1-7479ff64e705@bootlin.com>
References: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
In-Reply-To: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@redhat.com>, 
 Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Kory Maincent <kory.maincent@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.0
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

Cc: stable@vger.kernel.org
Fixes: 32aad86fe88e7 ("drm/i915/sdvo: Propagate errors from reading/writing control bus.")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Not tested as I don't have such hardware.
---
 drivers/gpu/drm/i915/display/intel_sdvo.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
index d83d350959d88..0f3aa879e39e1 100644
--- a/drivers/gpu/drm/i915/display/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
@@ -2878,16 +2878,12 @@ intel_sdvo_tv_init(struct intel_sdvo *intel_sdvo, u16 type)
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
@@ -2950,7 +2946,7 @@ intel_sdvo_lvds_init(struct intel_sdvo *intel_sdvo, u16 type)
 	}
 
 	if (!intel_sdvo_create_enhance_property(intel_sdvo, intel_sdvo_connector))
-		goto err;
+		return false;
 
 	intel_bios_init_panel_late(display, &intel_connector->panel, NULL, NULL);
 
@@ -2972,13 +2968,9 @@ intel_sdvo_lvds_init(struct intel_sdvo *intel_sdvo, u16 type)
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

