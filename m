Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8798606A32F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 01:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XMIIqRUR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FFB10E846;
	Mon, 16 Nov 2026 01:25:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB2910E56E;
 Mon, 16 Nov 2026 01:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794792350; x=1826328350;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qsy0T5aKmwDzRBcFaKjk10EI6YxjToMVtNlqFdNk2FQ=;
 b=XMIIqRURgSGhqsLMnbl/T2wHgFl92GHSX4Kf9GJ5SEhhxbT1pAYQsVx2
 GOhfPDru/V5hpEtsSh0f8zMgRC1gU6ddkFu/o5g/bHN810SKV5Ht47oF0
 eGkmNdsHYb4xG3a1x58P7Lktbnd8dBtSJ9lnu+XN+x2KKeddlSLq8CP39
 kuzhBH0wvByqp8Vowsaz7/He4o+ZJGwKY/FR+5IzBHiGl5TswgChVrfYR
 MEW01Qq45XKAdkoMrygu2fpSQndolrNwaWJ79UGWjSRJlC1eVG4Re3iOO
 Tu/xU5Qi0kzGSk/ERZinKRUxTbpZMrp9R0A4q7+l+1iJI22ZkrQEXRh9r A==;
X-CSE-ConnectionGUID: 8s9E3uNoTKioonRX0eCshA==
X-CSE-MsgGUID: 49wnt+U3TMSxMu9Wgo+dMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3398637"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3398637"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 17:25:49 -0800
X-CSE-ConnectionGUID: 5MCurInsR7myLTctmy3Kvg==
X-CSE-MsgGUID: GDaIs8z8S/WG3I01Bcv5+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9295489"
Received: from emr-371.sh.intel.com ([10.112.106.129])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 17:25:47 -0800
From: Baoli Zhang <baoli.zhang@linux.intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 matthew.auld@intel.com, airlied@gmail.com, simona@ffwll.ch,
 andriy.shevchenko@linux.intel.com,
 Baoli Zhang <baoli.zhang@linux.intel.com>,
 Yanx L Liu <yanx.l.liu@intel.com>
Subject: [PATCH 1/3] drm/i915/display: Tear down encoder hardware state in a
 separate hook
Date: Mon, 16 Nov 2026 09:15:02 +0800
Message-ID: <20261116011504.3910139-2-baoli.zhang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116011504.3910139-1-baoli.zhang@linux.intel.com>
References: <20261116011504.3910139-1-baoli.zhang@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some encoder ->destroy() callbacks do more than freeing memory: the DDI
and g4x DP encoders tear down MST, DP tunnels, PPS and AUX and flush the
power work, and SDVO removes its I2C adapters. All of this needs the
hardware or is visible to userspace, so it has to happen on driver
remove, while the encoder memory should only be freed once the last
reference to the DRM device is gone.

Add an intel_encoder ->remove() hook for that part, move the hardware
teardown of those encoders there, and call it for all encoders from
intel_mode_config_cleanup() right before drm_mode_config_cleanup(). The
encoders are the first objects drm_mode_config_cleanup() destroys, and
->remove() walks them in the same order, the order they were registered
in, so the order of the teardown doesn't change. None of the ->remove()
callbacks depends on another encoder.

No functional change intended.

Tested-by: Yanx L Liu <yanx.l.liu@intel.com>
Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
---
 drivers/gpu/drm/i915/display/g4x_dp.c            |  8 ++++++--
 drivers/gpu/drm/i915/display/intel_ddi.c         | 16 +++++++++++-----
 .../gpu/drm/i915/display/intel_display_driver.c  |  3 ++-
 .../gpu/drm/i915/display/intel_display_types.h   |  7 +++++++
 drivers/gpu/drm/i915/display/intel_encoder.c     |  9 +++++++++
 drivers/gpu/drm/i915/display/intel_encoder.h     |  1 +
 drivers/gpu/drm/i915/display/intel_sdvo.c        | 11 +++++++++--
 7 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/g4x_dp.c b/drivers/gpu/drm/i915/display/g4x_dp.c
index b867443ff2272..184c5c1d8ede0 100644
--- a/drivers/gpu/drm/i915/display/g4x_dp.c
+++ b/drivers/gpu/drm/i915/display/g4x_dp.c
@@ -1251,12 +1251,15 @@ static void g4x_dp_suspend_complete(struct intel_encoder *encoder)
 	intel_encoder_link_check_flush_work(encoder);
 }
 
+static void intel_dp_encoder_remove(struct intel_encoder *encoder)
+{
+	intel_dp_encoder_flush_work(&encoder->base);
+}
+
 static void intel_dp_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct intel_digital_port *dig_port = enc_to_dig_port(to_intel_encoder(encoder));
 
-	intel_dp_encoder_flush_work(encoder);
-
 	drm_encoder_cleanup(encoder);
 	intel_dp_link_cleanup(&dig_port->dp);
 	kfree(dig_port);
@@ -1332,6 +1335,7 @@ bool g4x_dp_init(struct intel_display *display,
 	intel_encoder->suspend = intel_dp_encoder_suspend;
 	intel_encoder->suspend_complete = g4x_dp_suspend_complete;
 	intel_encoder->shutdown = intel_dp_encoder_shutdown;
+	intel_encoder->remove = intel_dp_encoder_remove;
 	if (display->platform.cherryview) {
 		intel_encoder->pre_pll_enable = chv_dp_pre_pll_enable;
 		intel_encoder->pre_enable = chv_pre_enable_dp;
diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index d7c7ef22b73c5..2e7a68dc247e4 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4699,15 +4699,20 @@ static int intel_ddi_compute_config_late(struct intel_atomic_state *state,
 	return 0;
 }
 
-static void intel_ddi_encoder_destroy(struct drm_encoder *encoder)
+static void intel_ddi_encoder_remove(struct intel_encoder *encoder)
 {
-	struct intel_display *display = to_intel_display(encoder->dev);
-	struct intel_digital_port *dig_port = enc_to_dig_port(to_intel_encoder(encoder));
+	struct intel_display *display = to_intel_display(encoder);
+	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
 
-	intel_dp_encoder_flush_work(encoder);
-	if (intel_encoder_is_tc(&dig_port->base))
+	intel_dp_encoder_flush_work(&encoder->base);
+	if (intel_encoder_is_tc(encoder))
 		intel_tc_port_cleanup(dig_port);
 	intel_display_power_flush_work(display);
+}
+
+static void intel_ddi_encoder_destroy(struct drm_encoder *encoder)
+{
+	struct intel_digital_port *dig_port = enc_to_dig_port(to_intel_encoder(encoder));
 
 	drm_encoder_cleanup(encoder);
 	kfree(dig_port->hdcp.port_data.streams);
@@ -5355,6 +5360,7 @@ void intel_ddi_init(struct intel_display *display,
 	encoder->initial_fastset_check = intel_ddi_initial_fastset_check;
 	encoder->suspend = intel_ddi_encoder_suspend;
 	encoder->shutdown = intel_ddi_encoder_shutdown;
+	encoder->remove = intel_ddi_encoder_remove;
 	encoder->get_power_domains = intel_ddi_get_power_domains;
 
 	encoder->type = INTEL_OUTPUT_DDI;
diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index 204810a11e463..d513cfc881069 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -159,6 +159,7 @@ static void intel_mode_config_init(struct intel_display *display)
 static void intel_mode_config_cleanup(struct intel_display *display)
 {
 	intel_atomic_global_obj_cleanup(display);
+	intel_encoder_remove_all(display);
 	drm_mode_config_cleanup(display->drm);
 }
 
@@ -612,7 +613,7 @@ void intel_display_driver_remove(struct intel_display *display)
 	/*
 	 * MST topology needs to be suspended so we don't have any calls to
 	 * fbdev after it's finalized. MST will be destroyed later as part of
-	 * drm_mode_config_cleanup()
+	 * intel_encoder_remove_all().
 	 */
 	intel_dp_mst_suspend(display);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 0e3083e852d5f..6293c53c93768 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -274,6 +274,13 @@ struct intel_encoder {
 	 * all encoders have been called.
 	 */
 	void (*shutdown_complete)(struct intel_encoder *encoder);
+	/*
+	 * Called on driver remove after interrupts are disabled, to release
+	 * everything needing the hardware or exposed to userspace. The encoder
+	 * itself may be destroyed later, once the last reference to the DRM
+	 * device is gone.
+	 */
+	void (*remove)(struct intel_encoder *encoder);
 	/*
 	 * Enable/disable the clock to the port.
 	 */
diff --git a/drivers/gpu/drm/i915/display/intel_encoder.c b/drivers/gpu/drm/i915/display/intel_encoder.c
index d01b081a60740..e3c303352a9cf 100644
--- a/drivers/gpu/drm/i915/display/intel_encoder.c
+++ b/drivers/gpu/drm/i915/display/intel_encoder.c
@@ -104,6 +104,15 @@ void intel_encoder_shutdown_all(struct intel_display *display)
 			encoder->shutdown_complete(encoder);
 }
 
+void intel_encoder_remove_all(struct intel_display *display)
+{
+	struct intel_encoder *encoder;
+
+	for_each_intel_encoder(display->drm, encoder)
+		if (encoder->remove)
+			encoder->remove(encoder);
+}
+
 struct intel_digital_port *intel_dig_port_alloc(void)
 {
 	struct intel_digital_port *dig_port;
diff --git a/drivers/gpu/drm/i915/display/intel_encoder.h b/drivers/gpu/drm/i915/display/intel_encoder.h
index ace0fe1a8f27a..a368c1bd4684c 100644
--- a/drivers/gpu/drm/i915/display/intel_encoder.h
+++ b/drivers/gpu/drm/i915/display/intel_encoder.h
@@ -17,6 +17,7 @@ void intel_encoder_link_check_flush_work(struct intel_encoder *encoder);
 
 void intel_encoder_suspend_all(struct intel_display *display);
 void intel_encoder_shutdown_all(struct intel_display *display);
+void intel_encoder_remove_all(struct intel_display *display);
 
 void intel_encoder_block_all_hpds(struct intel_display *display);
 void intel_encoder_unblock_all_hpds(struct intel_display *display);
diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
index 3075ef04df566..50e9387e18092 100644
--- a/drivers/gpu/drm/i915/display/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
@@ -2548,9 +2548,8 @@ static const struct drm_connector_helper_funcs intel_sdvo_connector_helper_funcs
 	.atomic_check = intel_sdvo_atomic_check,
 };
 
-static void intel_sdvo_encoder_destroy(struct drm_encoder *_encoder)
+static void intel_sdvo_encoder_remove(struct intel_encoder *encoder)
 {
-	struct intel_encoder *encoder = to_intel_encoder(_encoder);
 	struct intel_sdvo *sdvo = to_sdvo(encoder);
 	int i;
 
@@ -2558,6 +2557,12 @@ static void intel_sdvo_encoder_destroy(struct drm_encoder *_encoder)
 		if (sdvo->ddc[i].ddc_bus)
 			i2c_del_adapter(&sdvo->ddc[i].ddc);
 	}
+}
+
+static void intel_sdvo_encoder_destroy(struct drm_encoder *_encoder)
+{
+	struct intel_encoder *encoder = to_intel_encoder(_encoder);
+	struct intel_sdvo *sdvo = to_sdvo(encoder);
 
 	drm_encoder_cleanup(&encoder->base);
 	kfree(sdvo);
@@ -3439,6 +3444,7 @@ bool intel_sdvo_init(struct intel_display *display,
 	intel_encoder->audio_disable = intel_sdvo_disable_audio;
 	intel_encoder->get_hw_state = intel_sdvo_get_hw_state;
 	intel_encoder->get_config = intel_sdvo_get_config;
+	intel_encoder->remove = intel_sdvo_encoder_remove;
 
 	/* In default case sdvo lvds is false */
 	if (!intel_sdvo_get_capabilities(intel_sdvo, &intel_sdvo->caps))
@@ -3518,6 +3524,7 @@ bool intel_sdvo_init(struct intel_display *display,
 	intel_sdvo_output_cleanup(intel_sdvo);
 err:
 	intel_sdvo_unselect_i2c_bus(intel_sdvo);
+	intel_sdvo_encoder_remove(intel_encoder);
 	intel_sdvo_encoder_destroy(&intel_encoder->base);
 
 	return false;
-- 
2.43.0

