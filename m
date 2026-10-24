Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89218606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HM8o6IHb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6461010E2C2;
	Sat, 24 Oct 2026 22:59:02 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85AE810E1CE
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 12:06:12 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so2718992c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792843572; x=1793448372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bVCdTHtpt7GG8JcgCc7bG+9s3eoRT/FFD1Bgu+2KeOg=;
 b=HM8o6IHb+uwOb/+hjTypwpkScIgroGRz91pLu8BkGVAUD1bOMzLLFQq/1rx8pseZeD
 j+eDgD56yXLhX0ZvNMRaPNrOYuqZRptWRR5DCt9n4TIIDT8prhgPHzMpybwrJ8CWaCqE
 jcftNf3+GqKs+F2etKyFA9zOWiqFHzcpg9602MizaDEYLh0EmS6HES686DGwCyIaXHo6
 d9RAiRh1Jla7fmnQmS2tApVox7zhkDyXp/97aif89kTMs0F+vAbcm/yI61GWr2I1E+TT
 vgnacQWusYIFnAoDROPLl8hwPFw9A2st880WrZkd9iqwrX6B1jUI3yzK65OT9UmHclkY
 AFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792843572; x=1793448372;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bVCdTHtpt7GG8JcgCc7bG+9s3eoRT/FFD1Bgu+2KeOg=;
 b=hTll2QxY13deBh9SVDWZSjjyyqPAekug3bCxCXj//hZUWD6j4Nmif3Sl/xUIJsozcn
 k4hfLyR/dkweyvKIe7BiH2zrlTiNc7+RymdAyTgXKS9qKZhN14esiCSbF7lhBSTvYeVn
 rwsG059tLMzgaMnbKnL2nY/cp3TO0erkwhcqOrjas25Ed8w6iz0OFRwyhXQlREuiDZ+D
 cl+n83v0XzsHnY6oJfNq+BunyMIj+AkUYTClHiOgZWr7v3tJZYbfuqMjhZ+bqI9HDDDG
 D7ty86kS+TL0YyLFAa8Lt+pDP2Ur40SSmoINAQ4c0YyZ9Dl8EvXwWOMRJySvwnNngeW7
 yyFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBymfNQzPPiIHIWe6VzMDmmWrsEMmsmDQuaWO2k8ywOQrmMcqrJ2ZHsB0qjZjY/yZQO2jm9FiyHN2Wk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKqLOzw6mXrRNFsHe803UmB5fyrlXHALVMDNc39pAWSBf//X9CE
 4gKaM7BOuRMiIa+mLXIt5Be0xQanCA+tmSl0k3+JyczlyqFaEoQn406X
X-Gm-Gg: AYBFou2y8FYDDGIlQPo5gcMVmksQUwT3GGKFwRrkZYtRrpR/iTsjK3xYv07ZeI8UArL
 cE/+sXQ7cViHXWsHDHy4wOtTJGpZ41mKJFKwvDDi5HLB9osTCThJZeqOBFd8F+va6/+sHaK9EpH
 oO+XqAQ5TH3yud3kpHP57zBdkN6nYdd661jpmmnvs5VCC1hoyp2TMH4Jk8b2owB0+pDaQfSjTrD
 7M89zZftJP08yiuub2RQrPo43n0Nm9XLVhLi9FnVEH7yfcvEtM5LxAlOtsWoludoiEzg29eBZp6
 1s9eU9oDJwnCCiY7UwfC+GKcULxNMqmb1LBG4poToJqr8gkbd47haIpIedCUeZSQPMVeT+XukTj
 ExSN60f2ZlSzzPIyRUB4M49acWwhKC89IZNohU6Z7d5Tn031JBqzmKfvtk3NJ9v6KRPehyTAdew
 0xva2y7lyKpMEoF+CpmV7nnBr3ZMMC1AXGU3Ca6s6XLg4TsY9WupJZH7h7NDbEbqsN1Fk9ucPzY
 JWdhsCGSK1HISOxCKlMrzouI0Y3gu40nJ6TppQZyktdgBZG5vmrs3Z8NNAqvp2g5AwQ
X-Received: by 2002:a05:7022:7e0b:b0:143:2982:1043 with SMTP id
 a92af1059eb24-1993639f0f2mr2801303c88.36.1792843571494; 
 Sat, 24 Oct 2026 05:06:11 -0700 (PDT)
Received: from [127.0.1.1] ([2406:7400:129:3e65:f4a6:5e8f:7da4:c9bb])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm15569309c88.17.2026.10.24.05.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 05:06:10 -0700 (PDT)
From: Aman Sharma <amansharma6122002@gmail.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 Aman Sharma <amansharma6122002@gmail.com>
Subject: [PATCH] drm/i915/hdmi: preserve cached EDID on DDC failure when
 connector is forced
Date: Sat, 24 Oct 2026 17:36:04 +0530
Message-ID: <179284356403.1659508.10439113185286055496@gmail.com>
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

Currently, intel_hdmi_force() unconditionally calls intel_hdmi_unset_edid()
before calling intel_hdmi_set_edid(). When drm_edid_read_ddc() returns NULL
during monitor standby, the connector's cached detect_edid is wiped out and
drm_helper_probe_single_connector_modes() falls back to the 1024x768 VESA
no-EDID mode. When the monitor wakes back up, because the connector status
remained forced to connector_status_connected, no hotplug state transition
occurs and the display remains stuck at 1024x768 until a manual mode probe
(such as toggling the laptop lid) is triggered.

Fix this by retaining the previously cached detect_edid when a DDC read
fails on a forced-on connector. When the monitor is awake or a different
monitor is plugged in, drm_edid_read_ddc() succeeds and replaces the
cached EDID normally.

Signed-off-by: Aman Sharma <amansharma6122002@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index b6fa1a1558b8..140d98a61a9c 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2570,6 +2570,18 @@ intel_hdmi_set_edid(struct drm_connector *_connector)
 		intel_gmbus_force_bit(ddc, false);
 	}
 
+	/*
+	 * If the connector is forced on (e.g. video=HDMI-A-1:e) and the sink's
+	 * DDC/I2C bus is powered down during DPMS standby, keep the previously
+	 * cached EDID rather than wiping it and falling back to 1024x768.
+	 */
+	if (!drm_edid && connector->base.force && connector->detect_edid) {
+		intel_display_power_put(display, POWER_DOMAIN_GMBUS, wakeref);
+		return true;
+	}
+
+	drm_edid_free(connector->detect_edid);
+
 	/* Below we depend on display info having been updated */
 	drm_edid_connector_update(&connector->base, drm_edid);
 
@@ -2638,10 +2650,10 @@ intel_hdmi_force(struct drm_connector *_connector)
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
