Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB1DCD6E64
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D49DC113C71;
	Wed,  3 Jun 2026 09:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="04B6lho+";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02A5113C6D;
 Wed,  3 Jun 2026 09:00:40 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4BE034E42DFE;
 Wed,  3 Jun 2026 09:00:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2072C5FD24;
 Wed,  3 Jun 2026 09:00:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2723110888413; 
 Wed,  3 Jun 2026 11:00:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780477237; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=YQGOVjJ70TJqHQ6t2vTYiGOL39RZYVDa4SJTFCWKyZo=;
 b=04B6lho+Bh//vim3TDYdAaLB6/BgNYrsH6G8def+gohQ4WgWK2QOntZiy/TTDyjGkLdJM6
 xT3A2e75f8OvhX4GZJ4pn/xI917zNPAopGnmTAanFRNzstyTO8xdSC/c1dv/kLudqcK2V0
 IDXHDfRcqjUMJMYJ6W45S/a4TkYWtA1Kb/KVVUSFkkV3yC1WcFtc5LIsLRfPbLj+swReab
 4gXvU7+o7GdnjYoERGvFoS8i+X+aNvyQfukBvoPX7+3UxpCGHtGKiAtoB9Dwt5pw/P2ZnR
 e3YRQACR5R/Jo1pgt/HVqLEBQMF4GLybIQ4xNYkTAnN34NT3m0OnVlBSAzZDuA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 03 Jun 2026 10:59:54 +0200
Subject: [PATCH 3/3] drm/i915/display/intel_dp: Drop redundant
 intel_dp_aux_fini() on init failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-fix_i915-v1-3-7479ff64e705@bootlin.com>
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

intel_dp_aux_fini() is already invoked via intel_dp_encoder_flush_work()
in the encoder destroy path (intel_dp_encoder_destroy() and
intel_ddi_encoder_destroy()). Calling it explicitly when
intel_edp_init_connector() fails before jumping to the fail label
therefore results in a double invocation. Drop the redundant call.

Cc: stable@vger.kernel.org
Fixes: c191eca110a37 ("drm/i915: Move intel_connector->unregister to connector->early_unregister")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index f01a6eed38395..f4fab568172f4 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -7310,10 +7310,8 @@ intel_dp_init_connector(struct intel_digital_port *dig_port,
 		connector->get_hw_state = intel_connector_get_hw_state;
 	connector->sync_state = intel_dp_connector_sync_state;
 
-	if (!intel_edp_init_connector(intel_dp, connector)) {
-		intel_dp_aux_fini(intel_dp);
+	if (!intel_edp_init_connector(intel_dp, connector))
 		goto fail;
-	}
 
 	intel_dp_set_source_rates(intel_dp);
 	intel_dp_set_common_rates(intel_dp);

-- 
2.43.0

