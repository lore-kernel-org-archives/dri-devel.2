Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3377606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=twzTSXIn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CD9112A10;
	Fri, 27 Nov 2026 10:27:50 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B27410E9DF
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:14:38 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c50d3ac6b51so1548088566b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795774476; x=1796379276; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AanAh9kUpFsvj61PDy3xC4hTGFLWOOg8Pq3sgXBBnsg=;
 b=twzTSXInfFv611wqG8CGUjatSPdRID/03fLQmvV5i1QDdHfSTnyD5iS+nrjLLi1NH9
 2DXI2QW3OC22Lbte7L2JRqNBeE0Ik5Npla6boIxSD84xCPhIahr9n2Y6yfaDz70rMZ7B
 YThUvHKXtKHXPJ0mZ8aKQ41MgJObUP3x4KogwZfF+9NZAg1MJgeKO4cb6rA8xawVPIFL
 mj5Yk+AOM9S3/vUMZrDfrD8xK4ko1p5o1Sj9zcWltNNVZ6d/KVI+ae2go57Dfg5eHgV6
 nvFauluBCH+CGCJutM8DpUU+KoD/vY76DS6wwn+mzgMPX6bLiV+DpyZaP/zltZTjotyq
 pzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774476; x=1796379276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AanAh9kUpFsvj61PDy3xC4hTGFLWOOg8Pq3sgXBBnsg=;
 b=aD+MJV/1yiVp4TnCk/xHxS5U+a36h8ePbBds0RInt5o53TZY0z9MN0rghsQEcbcc5T
 RBqrQfR/v4LQ0LN6/Ugk7C4+wOv96kkCOML1M116mQlT1bn/J4zcxza8q9cPRQnlEIIR
 w0ircwLyCNzrKIjuEUKek1iOFHV979UBFc+ubvY5G3r7ArwfuUInS+OQ5U4mHPcLyPEZ
 HfH8bOltYTeIHrN+ieD5IlICecChUwrgZfQE7Y4P1CwY+CEASsxWNIXRE6EVpBKQ89Rx
 MDJ+MYqdxXjkt563vbpC2jU51AfTfzRrVd6hjuzB07FCRw/NV0pTLdxI5F8R/TfBTqwM
 qi2w==
X-Forwarded-Encrypted: i=1;
 AL+hErFm8NWuTbHeRXxdaSDe6aV6bHp5T+DDw52yJ/je0NNR02sa8h4qH7bzp9xVp+pczd1qadHW0Q7nnV8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8EHA2ESW4kbNgCvboinP1SHtvZ3CWTDRcKVdX0r8C3SOShvjGw
 hb3i8p0oZVog346HEjIgC98Wv8jYDXS63rvPRe5Fnw1MpCsjD2jjDlc=
X-Gm-Gg: AZFdTZexK8eSuZuymlFPUTHcjX5xRi1Q09+ekCwUVqCFlY8xvI/9Mlh9SRwYe0UYBSY
 dY6xg2PmRCeY2CHyJ/XwvUN6OK4yLk0AqwrtaprjgopW6ZVXyT4Ju2Wx19uQpm/fR8NdxxkUwIq
 s3BrLhOZtl2nO1UM1YdjFNVz5Z9fboZuQamVveyz61zfbiK777+i9NHKHLcOwrugL1553HLsbda
 Od6eH2so9Uzwc5Aj3ztu544LSjbgb/kSpAktlUyaL7TWbCqPH5gIx4QZcwlrYxXdVcgNaAL4eAH
 wZ1i34U9vNsO7Z6HcZT7kIEInWgq4MVToI07qVG62sWBvjKifm7OJcCY8lTn0zyPARp3Jru6u8T
 09eHg3xOsEPIChQ20Rcz6UJ2b0vziZZYj77X2IkwkblovNht9CVZZikuXxHAVtw5codfBWeVE80
 5CufN26spAFsmbe6cxdzTYu+ouijCZMcr99hKGHpLM2mHo68zbGCrlqRR53oFVGs+/oL7qMRyFq
 PyjP4Px901RDhH2cgzpHFa1QI/FDxVSMFIe4TzC9RYJ8PTWcaZzmyPsOPCxYw/5BUPvE4I3/FIT
 biO3i79eduFVyMarjFArA0KSUEQ7JwPjiZiXm+lgidqWd6wS6dtF92t6wQfzj6+TgCBZgXzkHTj
 EvYFH/t2xtkljHCMSRmk3P6Dd4TnwpF+5WxG89s5QEwhYxHZW5dlvBheSVCE=
X-Received: by 2002:a17:907:3f18:b0:c46:9711:e30e with SMTP id
 a640c23a62f3a-c5131a1601amr2025588766b.29.1795774476374; 
 Fri, 27 Nov 2026 02:14:36 -0800 (PST)
Received: from localhost.localdomain
 (host-94-89-17-99.business.telecomitalia.it. [94.89.17.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm43651234f8f.26.2026.11.27.02.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:14:36 -0800 (PST)
From: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
 Dale Whinham <daleyo@gmail.com>, Stephen Boyd <swboyd@chromium.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
Subject: [PATCH v2 10/10] drm/msm/dp: dispatch native IRQ_HPD directly to
 msm_dp_irq_hpd_handle()
Date: Fri, 27 Nov 2026 11:14:17 +0100
Message-Id: <20261127101417.24303-11-gianfranco.mariotti94@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
References: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 10:27:44 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

msm_dp_display_irq_thread() forwards DP_DP_IRQ_HPD_INT_MASK via
drm_bridge_hpd_notify(..., connector_status_connected), relying on
msm_dp_bridge_hpd_notify() to observe ISR_IRQ_HPD_PULSE_COUNT in
REG_DP_DP_HPD_INT_STATUS[STATE_STATUS].

Because an IRQ_HPD short pulse lasts 0.5-1.0 ms, STATE_STATUS has
already returned to DP_DP_HPD_STATE_STATUS_CONNECTED by the time the
threaded IRQ handler runs, misrouting the short pulse to
msm_dp_hpd_plug_handle() instead of msm_dp_irq_hpd_handle().

Dispatch DP_DP_IRQ_HPD_INT_MASK directly to msm_dp_irq_hpd_handle():
- Guard msm_dp_irq_hpd_handle() with dp->plugged and skip sink requests
  in msm_dp_ctrl_handle_sink_request() while mainlink clocks are off.
- On DS_PORT_STATUS_CHANGED from a branch device, update or clear
  downstream sink state and invoke drm_bridge_hpd_notify() after
  releasing dp->plugged_lock when called from the IRQ thread (skipping
  re-entrant notification when called from msm_dp_bridge_hpd_notify()).

Fixes: 5043357e75ba ("drm/msm/dp: rework HPD handling")
Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  5 ++
 drivers/gpu/drm/msm/dp/dp_display.c | 86 +++++++++++++++++++++--------
 2 files changed, 68 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 1b2ab7db28cb..2b5e085afbcb 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2329,6 +2329,11 @@ void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
 	}
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+	if (!ctrl->link_clks_on) {
+		drm_dbg_dp(ctrl->drm_dev, "link clocks off, skipping sink request\n");
+		return;
+	}
+
 	sink_request = ctrl->link->sink_request;
 
 	if (sink_request & DP_TEST_LINK_PHY_TEST_PATTERN) {
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index fd9d5f176329..fef758ca9062 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -513,32 +513,74 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 	return 0;
 }
 
-static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
+static int msm_dp_display_handle_ds_port_status(struct msm_dp_display_private *dp,
+						enum drm_connector_status *hpd_status,
+						bool *notify_hpd)
 {
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	int rc;
+
+	if (dp->link->sink_count) {
+		rc = msm_dp_display_process_hpd_high(dp);
+		if (!rc) {
+			*hpd_status = connector_status_connected;
+			*notify_hpd = true;
+		}
+		return rc;
+	}
+
+	dp->panel->video_test = false;
+	if (!msm_dp_display->is_edp) {
+		drm_edid_connector_update(msm_dp_display->connector, NULL);
+		drm_dp_set_subconnector_property(msm_dp_display->connector,
+						 connector_status_disconnected,
+						 dp->panel->dpcd,
+						 dp->panel->downstream_ports);
+	}
+	msm_dp_display_handle_plugged_change(msm_dp_display, false);
+	*hpd_status = connector_status_disconnected;
+	*notify_hpd = true;
+
+	return 0;
+}
+
+static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, bool notify)
+{
+	enum drm_connector_status hpd_status = connector_status_disconnected;
+	bool notify_hpd = false;
 	u32 sink_request;
 	int rc = 0;
 
-	guard(mutex)(&dp->plugged_lock);
-
-	/* irq_hpd can happen at either connected or disconnected state */
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
-			dp->msm_dp_display.connector_type,
-			dp->link->sink_count);
+	scoped_guard(mutex, &dp->plugged_lock) {
+		if (!dp->plugged)
+			return 0;
+
+		/* irq_hpd can happen at either connected or disconnected state */
+		drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
+			   dp->msm_dp_display.connector_type,
+			   dp->link->sink_count);
+
+		/* check for any test request issued by sink */
+		rc = msm_dp_link_process_request(dp->link);
+		if (!rc) {
+			sink_request = dp->link->sink_request;
+			drm_dbg_dp(dp->drm_dev, "sink_request=%d\n",
+				   sink_request);
+			if (sink_request & DS_PORT_STATUS_CHANGED)
+				rc = msm_dp_display_handle_ds_port_status(dp,
+									  &hpd_status,
+									  &notify_hpd);
+			else
+				rc = msm_dp_display_handle_irq_hpd(dp);
+		}
 
-	/* check for any test request issued by sink */
-	rc = msm_dp_link_process_request(dp->link);
-	if (!rc) {
-		sink_request = dp->link->sink_request;
-		drm_dbg_dp(dp->drm_dev, "sink_request=%d\n", sink_request);
-		if (sink_request & DS_PORT_STATUS_CHANGED)
-			rc = msm_dp_display_process_hpd_high(dp);
-		else
-			rc = msm_dp_display_handle_irq_hpd(dp);
+		drm_dbg_dp(dp->drm_dev, "After, type=%d, sink_count=%d\n",
+			   dp->msm_dp_display.connector_type,
+			   dp->link->sink_count);
 	}
 
-	drm_dbg_dp(dp->drm_dev, "After, type=%d, sink_count=%d\n",
-			dp->msm_dp_display.connector_type,
-			dp->link->sink_count);
+	if (notify && notify_hpd)
+		drm_bridge_hpd_notify(dp->msm_dp_display.bridge, hpd_status);
 
 	return rc;
 }
@@ -1037,10 +1079,8 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
 		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
 				      connector_status_connected);
 
-	/* Send HPD as connected and distinguish it in the notifier */
 	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
-		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
-				      connector_status_connected);
+		msm_dp_irq_hpd_handle(dp, true);
 
 	ret = IRQ_HANDLED;
 
@@ -1661,7 +1701,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			msm_dp_hpd_unplug_handle(dp);
 			msm_dp_hpd_plug_handle(dp);
 		} else if (hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT) {
-			msm_dp_irq_hpd_handle(dp);
+			msm_dp_irq_hpd_handle(dp, false);
 		} else {
 			msm_dp_hpd_plug_handle(dp);
 		}
-- 
2.25.1

