Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA86F436A8
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBB110E2BE;
	Fri, 17 Apr 2026 14:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nyDTjNdv";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E0110EA30
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 14:14:51 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-671ab90fc1fso1420171a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776435289; x=1777040089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bE/23HHr5NxJFT3TiQRbeJBBfxsF0ZdYwl1CCK2/W0=;
 b=nyDTjNdvY9DPQhvvhbHh0ISYdpyWveO40DnoCDPn2llV7ItcRE4fifg4RmBVtB4Yq7
 8qsF2WoU9BjAWYxIPJDgce2H8KtxL79KpAViz67oZV+vAkAkN0jmY29oU5SVmK9mnMpR
 cl55bVb+By1+joCrCD6lBX9q6QuyFRo10JsAVNaMG/FhX6zLam4J9s9GXLJz2LPvOOB6
 aZgBtMZ6gwl14a0HAHBJ8O0eWfFb51GzIrAb8FSc/h3eWF76BdLjcByoR/9OqKbP6tyb
 YItEsjQOqA3j4teQsvUzSiGTlAETd0o3HfSM2/nvJac0cCmSfpJacKBDvklJ0PK7TgAk
 bCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776435289; x=1777040089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9bE/23HHr5NxJFT3TiQRbeJBBfxsF0ZdYwl1CCK2/W0=;
 b=R++MrSuHoDO8IvQUr64HgGREPZDqBIeEuenI1p7JvSgVCvsAB3FqiVGHiJ7uYJEkmH
 xBI+kBnQ74QdxGLazDM4vgUJeGSxRwMZhzZy+TFOHvAkQyQpQWDQ5scsFIu3H+x04IDc
 u0tbSuNPSQGpK2AbDiiB5iCm5WLTNGmjg6J9uR2hBm+QY/euHSbfa+ECkOCrxgZoZhHy
 P4FaICY5PEgNDeVPx6TjiSJpQv5i5mCIZ6XmnNahe5UtYZuW5GSfnQUnY43uM76VRlZ4
 g93XTH1erTdT2ztBYOvZ001QmfPn3G45hp2gY3ZmwAYpute0G+TczeWahVcaSzMbzxo2
 LEuA==
X-Gm-Message-State: AOJu0YxFwDcAi7k7lho/8MvF8zx4ir5qGmPV6qpXk1K6guEwPF30bg4M
 74WYRSgtLO+ECHaM9fyCKq8CkizOoJtczkOn5c/I/FYOJh9WEL+IP1PY
X-Gm-Gg: AeBDiesIX/zV9mVw0npKAx01ShsjplJCXpOYmsXeo4gWy8JkgItC2B8o+p0jxUP+Cv3
 uTzdMC+X/Pl4ogS2EIRYbX038Mrf3JtQgJQ4Lm8sQoQdPwzmCMGtNyxQmc+B9BMOZQn/Jwp+K6Y
 aczl3Q+4dd3IsOCQtzyono1G53y4FZcVvQQ+/mZmg87kvdE0iDG6nJl7raSMDQ80eX719tFzqyh
 8U2MBpDtNogXZRDGTBcL/BqZy9cNeTrgg6Hq1fRaRFH8pmLhPrDRqdCI/uvpTioQWwsuDuPXzuK
 fqKQ2rshrKZgIuxhGnsZJjhzu8NxFUYfeLzQ6NyjUShm5UZ3nxwDIPIAy1Corc/M7kq+PtXmeHV
 LAqjNBBoWcqT7cqVyo4ECCU9jwQ3lCmxPAvss21HdhTV/7Dh3ASRPSrB2mj9AA255i5r8rPpqUz
 ow/P0rU7DbzFvnh9O+ytF3T2YRKAplyn9pRHsNlMHmBF2b+6ZPs/6ztVBVwo6KkbewFIf8Tnpnd
 mYae0F2flu/
X-Received: by 2002:a05:6402:34cd:b0:672:c1b0:1f3d with SMTP id
 4fb4d7f45d1cf-672c1b020bcmr1345145a12.8.1776435289044; 
 Fri, 17 Apr 2026 07:14:49 -0700 (PDT)
Received: from JTOLLET-M-FKW7.cisco.com
 ([2603:5004:20a0:100c:b964:8d24:d15b:f122])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-672c4d455e9sm458744a12.14.2026.04.17.07.14.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Apr 2026 07:14:48 -0700 (PDT)
From: Jerome Tollet <jerome.tollet@gmail.com>
X-Google-Original-From: Jerome Tollet <jtollet@cisco.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 ville.syrjala@linux.intel.com, ankit.k.nautiyal@intel.com,
 arun.r.murthy@intel.com, jani.nikula@linux.intel.com,
 Jerome Tollet <jtollet@cisco.com>
Subject: [PATCH v3] drm/i915/hdmi: Poll for 200 msec for TMDS_Scrambler_Status
Date: Fri, 17 Apr 2026 16:14:32 +0200
Message-ID: <20260417141432.7556-1-jtollet@cisco.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260113143107.1446909-1-ankit.k.nautiyal@intel.com>
References: <20260113143107.1446909-1-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

HDMI 2.0 section 6.1.3.1 specifies that after enabling
Scrambling_Enable and starting scrambled video transmission, the source
should poll Scrambling_Status until it reads 1 or until a timeout of
200 ms expires.

Add a polling step after enabling the HDMI port to check the scrambling
status when HDMI scrambling is enabled.

On some HDMI 2.0 sinks, omitting this check can result in 4K@60Hz
(594 MHz) failing to come up correctly because the sink has not yet
finished its scrambling setup. In practice, waiting for the scrambling
status here fixes such sinks.

While this synchronous polling is not itself explicitly required for
correct modeset sequencing, HDMI 2.0 section 6.1.3.1 does recommend it
as the way for the source to verify that the TMDS link is functioning
correctly with scrambling enabled.

v3:
 - Add explicit HDMI 2.0 section reference in code comment
 - Clarify commit message around the observed sink fix

v2:
 - Poll TMDS_Scrambler_Status for up to 200 ms instead of using a fixed
   delay

Reported-by: Jerome Tollet <jtollet@cisco.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6868
Link: https://lore.kernel.org/dri-devel/20251230091037.5603-1-jerome.tollet@gmail.com/
Signed-off-by: Jerome Tollet <jtollet@cisco.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Arun R Murthy <arun.r.murthy@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c  |  2 ++
 drivers/gpu/drm/i915/display/intel_hdmi.c | 25 +++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_hdmi.h |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index cb91d07cdaa6..c708b713f0e8 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3506,6 +3506,8 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 	}

 	intel_ddi_buf_enable(encoder, buf_ctl);
+
+	intel_hdmi_poll_for_scrambling_enable(crtc_state, connector);
 }

 static void intel_ddi_enable(struct intel_atomic_state *state,
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 055e68810d0d..958d939ae6ee 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2694,6 +2694,31 @@ intel_hdmi_add_properties(struct intel_hdmi *intel_hdmi, struct drm_connector *_
 	drm_connector_attach_max_bpc_property(&connector->base, 8, 12);
 }

+/*
+ * HDMI 2.0 spec, section 6.1.3.1 (Scrambling Control): after
+ * enabling Scrambling_Enable and starting scrambled video
+ * transmission, poll Scrambling_Status for up to 200 ms.
+ */
+void
+intel_hdmi_poll_for_scrambling_enable(const struct intel_crtc_state *crtc_state,
+				      struct drm_connector *_connector)
+{
+	struct intel_connector *connector = to_intel_connector(_connector);
+	struct intel_display *display = to_intel_display(crtc_state);
+	bool scrambling_enabled = false;
+	int ret;
+
+	if (!crtc_state->hdmi_scrambling)
+		return;
+
+	/* Poll for a max of 200 msec as per HDMI spec */
+	ret = poll_timeout_us(scrambling_enabled = drm_scdc_get_scrambling_status(&connector->base),
+			      scrambling_enabled, 1000, 200 * 1000, false);
+	if (ret)
+		drm_dbg_kms(display->drm,
+			    "[CONNECTOR:%d:%s] Timed out waiting for scrambling enable\n",
+			    connector->base.base.id, connector->base.name);
+}
+
 /*
  * intel_hdmi_handle_sink_scrambling: handle sink scrambling/clock ratio setup
  * @encoder: intel_encoder
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index be2fad57e4ad..0fa3661568e8 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -70,5 +70,7 @@ void hsw_read_infoframe(struct intel_encoder *encoder,
 			const struct intel_crtc_state *crtc_state,
 			unsigned int type,
 			void *frame, ssize_t len);
+void intel_hdmi_poll_for_scrambling_enable(const struct intel_crtc_state *crtc_state,
+					   struct drm_connector *_connector);

 #endif /* __INTEL_HDMI_H__ */
--
2.45.2
