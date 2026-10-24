Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1189A606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ScTf3ovP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA5A10E4C7;
	Sat, 24 Oct 2026 22:59:19 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1EA210E64D
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 12:53:35 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-353804b591eso2959774eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792846415; x=1793451215; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eOAYbZiH4x6SHtvIeJhRKrK8ZEV2eHwdec8xlqf3xRY=;
 b=ScTf3ovPH1L0yGAdr0nOUaf63MObIcyRoT73EJsik9X11oBsZ/lsxj4Y0tyPGIqYho
 G9545vycPRyn9IdkDv1odC/v5jqOoBmu+cK9m4Vz2yvcSEV/XoSqL+w2hiZl7of5cXM9
 33U6HRXLqVLZaH1sYNhgleBgkS9vGZS8jiIOJ1CccV34xGCOxNrL0uyZuBhuyQDANCEl
 8kAxVQs160GEJcByEmF3D/afkVr4ugHLlCt6PpY4Y58FJOgMORRIAzONfF5oePN5orT1
 9YzPXgMcKE4xTF5fg0NOLcLSGDhd1+EAVB9GhPiA7C2K6ZnZ48Xbzl7JwJb/gwXrz9pb
 AdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792846415; x=1793451215;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eOAYbZiH4x6SHtvIeJhRKrK8ZEV2eHwdec8xlqf3xRY=;
 b=OBavy7ue6SOp7Yf58gEcUgD6PjyXOPNO39+JQMBT8gz2Bzt0WBYWLrO3rRhEzC987C
 SNwwLL7U6DkvsBOENICz9osFYGMMSGjXugFC7BE43D0zRUzd0mRfOuXi4bvZ5c5tlmJR
 dP7oYgURVd2IWLZBxtS2R60SkaYz8B6Ofck9I+TdA0oGkCXJWazd/2vbsjbDbm9wrv8H
 kjwkNIXiDzs+PVOatVPhm4mMa0JBny5zHLFvIU7AQmhH8EB6Bm7ZGQtn8loyZ1sbz3y7
 GRF7o9aAORF+qIc/qzs/5xkTzoshTECe82q3lZfOSNEQOfCscDs06xeDXyLbsZjIEIiw
 p+vA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxm2sOSFO3R/mnt6e7zqNwimCiNjcd3r2zghsJW5wea4yQLbP/6sPdijEA0fYz/ZudXpZ+wb4nXa4Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIk40nh1oInr8yp8vqvMsNCr/57JAsGr+kiiuHrnSkeEbBAzdTz
 ll3cJBX4zEoK8ohTNoyYt2hWPg5VySVgYkeE84IS7OgcYG4RcfrJug7q
X-Gm-Gg: AYBFou28nsrxOxlIfN7Do5wpW7pyX9cnZD0ziN6oua6dLjL74amLt4kIEkgtcDKb2SW
 EljopHBW4H/X3tY9wyFDxoe/AQPxD3WAtAyWcWBzsCmVeUwyudM78Po2ts93fT6xu8uL4y0ntV+
 4I0yfumi8Mz0duoMYt4bBEFgJNCQzT2zxOANIap1lrUHnn4IU/Fqts2mkmfBPZuw31/5aTW6zQe
 M5tXvf50AZoZTX8VJgBZ/610HvmrKAhNqvvOD65CbULaVHkFGWMeN4qFbhedfbQ1otSEgcAnKrq
 EOrncnYSANLqrX5VEFfTZNXtFOlvFjuh1Y2BHmil4+MQQRKYBBsY2DhAINed/h1uV+60Xpm3/zr
 Ck+k3rQNcSbnYsgwdT0a1ZVOdSDiXR6dS/1Q1QK/pgGmVRuGRUcmzFKOa7P4qnN+YxpX1vy3JjK
 Q/3SkB6oTyCyjoM4ecvD5i/PFkg7BewbfQMRsN5w9+fj29L9Fn4U0eC0bUfr29Nps3VpnANIsPe
 B+/+4y5SxbqORxSE48XBjdBshMCXd/+ko36KH4oWKJcp+cBTTDf6uTuw4ghsAhTredA
X-Received: by 2002:a05:693c:839b:20b0:365:cdcc:9f57 with SMTP id
 5a478bee46e88-369e83547aemr3342308eec.4.1792846414983; 
 Sat, 24 Oct 2026 05:53:34 -0700 (PDT)
Received: from [127.0.1.1] ([2406:7400:129:3e65:f4a6:5e8f:7da4:c9bb])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8d578casm8006260eec.6.2026.10.24.05.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 05:53:34 -0700 (PDT)
From: Aman Sharma <amansharma6122002@gmail.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 Aman Sharma <amansharma6122002@gmail.com>
Subject: [PATCH v3] drm/i915/hdmi: preserve cached EDID on DDC failure when
 connector is forced
Date: Sat, 24 Oct 2026 18:23:28 +0530
Message-ID: <179284640822.1672477.8751430644960613659@gmail.com>
In-Reply-To: <179284522321.1666644.7085985666852699043@gmail.com>
References: <179284356403.1659508.10439113185286055496@gmail.com>
 <179284522321.1666644.7085985666852699043@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:01 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When an HDMI connector is forced enabled (e.g. via video=HDMI-A-1:e for
laptop clamshell operation) and the external monitor enters DPMS standby,
some monitors (such as the BenQ GW2790Q) power down their internal DDC/I2C
controller, causing SCDC/EDID reads to fail with -ENXIO (-6).

Currently, intel_hdmi_detect() and intel_hdmi_force() unconditionally call
intel_hdmi_unset_edid() before calling intel_hdmi_set_edid(). When
drm_edid_read_ddc() returns NULL during monitor standby, the connector's
cached detect_edid is wiped out and
drm_helper_probe_single_connector_modes() falls back to the 1024x768 VESA
no-EDID mode. When the monitor wakes back up, because the connector status
remained forced to connector_status_connected, no hotplug state transition
occurs and the display remains stuck at 1024x768 until a manual mode probe
(such as toggling the laptop lid) is triggered.

Fix this by moving intel_hdmi_unset_edid() into intel_hdmi_set_edid() after
checking whether a forced-on connector (DRM_FORCE_ON or
DRM_FORCE_ON_DIGITAL) already has a valid cached EDID (detect_edid and
edid_blob_ptr) when DDC fails, and preserving connector_status_connected
on Gen11+ digital port disconnect when a forced-on connector has a cached
EDID. When the monitor is awake or a different monitor is plugged in,
drm_edid_read_ddc() succeeds, resets the previous EDID and dp_dual_mode
state via intel_hdmi_unset_edid(), and updates the connector with the new
EDID.

v3:
- Explicitly check for DRM_FORCE_ON / DRM_FORCE_ON_DIGITAL so DRM_FORCE_OFF
  still clears the cached EDID as expected.
- Report connector_status_connected on Gen11+ disconnect when a forced-on
  connector retains its cached EDID, and jump to out in
  intel_hdmi_set_edid() so CEC physical address remains valid and
  drm_helper_probe_detect_ctx() does not increment epoch_counter on
  standby HPD pulses.

v2:
- Move intel_hdmi_unset_edid() into intel_hdmi_set_edid() so hotplug
  detection via intel_hdmi_detect() also preserves the cached EDID on
  forced connectors and resets dp_dual_mode when updating EDID.
- Clear detect_edid on Gen11+ disconnect when the connector is unforced,
  and verify edid_blob_ptr is non-NULL before retaining detect_edid.

Signed-off-by: Aman Sharma <amansharma6122002@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 31 ++++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index b6fa1a1558b8..a14a857dfe94 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2570,6 +2570,21 @@ intel_hdmi_set_edid(struct drm_connector *_connector)
 		intel_gmbus_force_bit(ddc, false);
 	}
 
+	/*
+	 * If the connector is forced on (e.g. video=HDMI-A-1:e) and the sink's
+	 * DDC/I2C bus is powered down during DPMS standby, keep the previously
+	 * cached EDID rather than wiping it and falling back to 1024x768.
+	 */
+	if (!drm_edid &&
+	    (connector->base.force == DRM_FORCE_ON ||
+	     connector->base.force == DRM_FORCE_ON_DIGITAL) &&
+	    connector->detect_edid && connector->base.edid_blob_ptr) {
+		connected = true;
+		goto out;
+	}
+
+	intel_hdmi_unset_edid(&connector->base);
+
 	/* Below we depend on display info having been updated */
 	drm_edid_connector_update(&connector->base, drm_edid);
 
@@ -2580,6 +2595,7 @@ intel_hdmi_set_edid(struct drm_connector *_connector)
 		connected = true;
 	}
 
+out:
 	intel_display_power_put(display, POWER_DOMAIN_GMBUS, wakeref);
 
 	cec_notifier_set_phys_addr(intel_hdmi->cec_notifier,
@@ -2611,10 +2627,15 @@ intel_hdmi_detect(struct drm_connector *_connector, bool force)
 	wakeref = intel_display_power_get(display, POWER_DOMAIN_GMBUS);
 
 	if (DISPLAY_VER(display) >= 11 &&
-	    !intel_digital_port_connected(encoder))
+	    !intel_digital_port_connected(encoder)) {
+		if ((connector->base.force == DRM_FORCE_ON ||
+		     connector->base.force == DRM_FORCE_ON_DIGITAL) &&
+		    connector->detect_edid && connector->base.edid_blob_ptr)
+			status = connector_status_connected;
+		else
+			intel_hdmi_unset_edid(&connector->base);
 		goto out;
-
-	intel_hdmi_unset_edid(&connector->base);
+	}
 
 	if (intel_hdmi_set_edid(&connector->base))
 		status = connector_status_connected;
@@ -2638,10 +2659,10 @@ intel_hdmi_force(struct drm_connector *_connector)
 	if (!intel_display_driver_check_access(display))
 		return;
 
-	intel_hdmi_unset_edid(&connector->base);
-
-	if (connector->base.status != connector_status_connected)
+	if (connector->base.status != connector_status_connected) {
+		intel_hdmi_unset_edid(&connector->base);
 		return;
+	}
 
 	intel_hdmi_set_edid(&connector->base);
 }
-- 
2.43.0
