Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5B606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u894eou1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F31112A0B;
	Fri, 27 Nov 2026 10:27:50 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C641129AE
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:14:35 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e47347279so4821754f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795774474; x=1796379274; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZfuPsc7xLuv7FveL7LRtKmIlOFCOOjMPi+YwZzyG6OM=;
 b=u894eou1zrcYpw8r92gUg1tk+8iXYdEBBIAu5A3JRS/08+383jr7wOTllk+BSkju6Y
 hBXY2emi4AV55uK9FZ5jRG82xVOpVRNzAp+g+LGhQp/TIl4llQWletteR3iVJWHdd4Zo
 TXUq0J4qu1l4O/xV812tG/cLzaB28i5q2vxRKiHkH2okSSEN+SG8Gqg1VLfGBAKvemnl
 srK/I4ffD97X/KWbrMYDcaKJ2nwL/ok+x8mDt1n85s8jCf/XI3KBUtgHLdwAPdMj+4rC
 zdHamR5g6RFkDcTj38BvyJRVRKuCJ42WNEnh4HKsNrfcFtmRu3w2Afy6c1yFcDNzhhrD
 HfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774474; x=1796379274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZfuPsc7xLuv7FveL7LRtKmIlOFCOOjMPi+YwZzyG6OM=;
 b=rQGpxCLXOYi8OrJNU7p0QEDjXOjRX7Rt+HdJ+kKrD6kVHym02orkaonyULwtMIKxBN
 qHLmoXQ4ArXgK5iFeqEJGlOCGO1MA80wVp7goGe4BEHzQX2TJu8wMftx9Rsd6mjutLYW
 pYd+DwMDocwjrIVyREvV41fpMhqJC4BvGJVzoazpuYCo2QCTJi8YYN6tmaFvoMiEnkxD
 38qPCO6NLB/x103nBPQboM97DUDPEgASmiNF24ANjZ+0gMztTchI4e7rIV2DIgzE3Wda
 mQ9YBpsnsieEnyH4aN577p9sGKzeGaz+fQUBPDI9zHqt6nZ7PNYweJykZmezCk50TcwR
 70gQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH9GK8vC9F+AOJKbbkp7zgsLITvt2Ckd7VJNJfWWiv61KsUOFCf8CHmqdhRcEqQF1YYoWANQWMXL00=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/tV9JD1o56JVhlb2EELa5mbhGJq+xaV9PaeN13uDU2+f1m54Tp
 ty5ppqlvb1CwOQJrwVcaPh980wQuRALsznmvrv5GvRSMl2xHwGO4U+w=
X-Gm-Gg: AZFdTZfOb+i1jPXWz1zW8o5xdswYapC31Tu3lHYJHFqRvmXX2JFl1LPxzHm7c3wLe5K
 rQGH+fdZdEEh0GN4sSfaMpXaDI/XcxSHneWQAHH6bTqFdf7QxD3+LeeADH6x2x3i5vCv/CRSuq3
 1fOpAI9kGTdq3TfuJp6W3miXPVxUvHzr0Jj4sxzwsExbLWHtOy2a05Vzbc4nHtjFVTv1oxWnKg6
 iz1Y0SJTEsvwDrPJiKFG9dprd1uvCXpnOvIkz0RiRZgOAJA/v8QMhCwPLHRCXgJgWH4RrY2YEnR
 NWNmc1/xIU30c7JEJ6JzKGFtMquKVg/Br/K6QkudYsJzr6w4QUPadzwMMFJNu/1gRLvSnNHuDlQ
 GgV7v0EkBJ+HtP5SX+CGYREDj3A+nlVmrqxCrmdPisypfr4U4IOU56T/1PAdVQ19xeAELNl2vGp
 +uJGNPPqmrZF8l0UgIHYsmDqHyhHZEbYMpy4ybx+uU4AQD9zzhbtPxRe5yGJqzWewZwCco+LHvb
 W9ropcmViI7fEFGXu1ak9HhyRPE3wIGvVaDTQxATZH+EhIZ3y4J3Ma/4bN4Va5xvi2df9ptlxWX
 mOq1XjJzO47+oPRpLS+rxKuj6XcRSHFKUtM0kHebvw/gnNj5SltcpXTpaihssYJctplHd0ADc5S
 edN5gDmQpOjq7NhouFpNirC0jSI8iTCwASQ3nNgQsb3Di7VY9XoKL+6GabF8=
X-Received: by 2002:a05:6000:1789:b0:491:971a:c568 with SMTP id
 ffacd0b85a97d-4abb3861356mr43995162f8f.10.1795774473594; 
 Fri, 27 Nov 2026 02:14:33 -0800 (PST)
Received: from localhost.localdomain
 (host-94-89-17-99.business.telecomitalia.it. [94.89.17.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm43651234f8f.26.2026.11.27.02.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:14:33 -0800 (PST)
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
Subject: [PATCH v2 08/10] drm/msm/dp: keep PHY initialized while plugged
 across link unprepare
Date: Fri, 27 Nov 2026 11:14:15 +0100
Message-Id: <20261127101417.24303-9-gianfranco.mariotti94@gmail.com>
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

When a DisplayPort output is disabled while a sink remains physically
plugged in (e.g. DPMS off or connector force-off),
msm_dp_display_unprepare() calls msm_dp_display_host_phy_exit() whenever
sink_count != 0, leaving the PHY uninitialized while dp->plugged and AUX
transfers remain enabled. Subsequent AUX transactions (from IRQ_HPD or
connector re-detection) then stall and time out with -ETIMEDOUT. For the
sink_count == 0 case, msm_dp_ctrl_reinit_phy() bypassed
msm_dp_ctrl_phy_reset(), triggering spurious DP_INTR_PLL_UNLOCKED AUX
interrupts.

Serialize msm_dp_display_unprepare() under dp->plugged_lock, replace the
sink_count split and now-unused msm_dp_ctrl_reinit_phy() with
msm_dp_display_host_phy_exit() followed by
msm_dp_display_host_phy_init() whenever dp->plugged is true, exit the
PHY in msm_dp_hpd_unplug_handle() whenever !power_on, and balance PHY
exit/init across system sleep in msm_dp_pm_runtime_suspend()/resume().

Fixes: 3ea2d1c3d154 ("drm/msm/dp: turn link_ready into plugged")
Fixes: 1bda647ce61b ("drm/msm/dp: move link-level teardown from display_disable to display_unprepare")
Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 13 ------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 -
 drivers/gpu/drm/msm/dp/dp_display.c | 33 ++++++++++++++++-------------
 3 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 7201b7b513a3..1b2ab7db28cb 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2679,19 +2679,6 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 	return ret;
 }
 
-void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
-{
-	struct msm_dp_ctrl_private *ctrl;
-	struct phy *phy;
-
-	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
-	phy = ctrl->phy;
-
-	/* aux channel down, reinit phy */
-	phy_exit(phy);
-	phy_init(phy);
-}
-
 void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			  struct msm_dp_panel *panel)
 {
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 80d9258501b4..ea3a42e9b624 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -56,7 +56,6 @@ void msm_dp_ctrl_core_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 
-void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
 bool msm_dp_ctrl_stream_clks_on(struct msm_dp_ctrl *dp_ctrl,
 				enum msm_dp_stream_id stream_id);
 #endif /* _DP_CTRL_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index a48f42a17365..d3f4b5a9e723 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -483,8 +483,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 	if (!dp->msm_dp_display.is_edp)
 		drm_edid_connector_update(dp->msm_dp_display.connector, NULL);
 
-	/* triggered by irq_hdp with sink_count = 0 */
-	if (dp->link->sink_count == 0)
+	if (!dp->msm_dp_display.power_on)
 		msm_dp_display_host_phy_exit(dp);
 
 	dp->link->has_sink_count = false;
@@ -1330,10 +1329,9 @@ static int msm_dp_pm_runtime_suspend(struct device *dev)
 
 	disable_irq(dp->irq);
 
-	if (dp->msm_dp_display.is_edp) {
-		msm_dp_display_host_phy_exit(dp);
+	msm_dp_display_host_phy_exit(dp);
+	if (dp->msm_dp_display.is_edp)
 		msm_dp_aux_hpd_disable(dp->aux);
-	}
 	msm_dp_display_host_deinit(dp);
 
 	return 0;
@@ -1349,12 +1347,15 @@ static int msm_dp_pm_runtime_resume(struct device *dev)
 	 *
 	 * for DP, only host controller is enabled here.
 	 * HPD block is enabled at msm_dp_bridge_hpd_enable()
-	 * PHY will be enabled at plugin handler later
+	 * PHY will be enabled at plugin handler later, or restored here
+	 * across system suspend if a sink is already plugged in
 	 */
 	msm_dp_display_host_init(dp);
 	if (dp->msm_dp_display.is_edp) {
 		msm_dp_aux_hpd_enable(dp->aux);
 		msm_dp_display_host_phy_init(dp);
+	} else if (dp->plugged) {
+		msm_dp_display_host_phy_init(dp);
 	}
 
 	enable_irq(dp->irq);
@@ -1533,19 +1534,21 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
-	/* dongle is still connected but sinks are disconnected */
-	if (dp->link->sink_count == 0)
-		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+	scoped_guard(mutex, &dp->plugged_lock) {
+		/* dongle is still connected but sinks are disconnected */
+		if (dp->link->sink_count == 0 && dp->plugged)
+			msm_dp_link_psm_config(dp->link, &dp->panel->link_info,
+					       true);
 
-	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
 
-	if (dp->link->sink_count == 0)
-		/* re-init the PHY so that we can listen to Dongle disconnect */
-		msm_dp_ctrl_reinit_phy(dp->ctrl);
-	else
+		/* Keep PHY initialized for AUX and IRQ_HPD while a sink remains plugged */
 		msm_dp_display_host_phy_exit(dp);
+		if (dp->plugged)
+			msm_dp_display_host_phy_init(dp);
 
-	msm_dp_display->power_on = false;
+		msm_dp_display->power_on = false;
+	}
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 
-- 
2.25.1

