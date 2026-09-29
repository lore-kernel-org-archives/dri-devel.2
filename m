Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A67CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B561B10F378;
	Wed, 30 Sep 2026 12:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UGdqjRSi";
	dkim-atps=neutral
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9D210EEA4
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:06:32 +0000 (UTC)
Received: by mail-pz2-f39.google.com with SMTP id
 41be03b00d2f7-cc794a06e5fso2071732a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790687191; x=1791291991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y5LyVPNhnJ5Rp7yPTDFXlLblOQWcWIIfQuz7DLHUCd8=;
 b=UGdqjRSiD0X9J7j3eAKuzxDaA9HAwVmUiAhJSGN//hLwFF3vsyCNcUzJZE+G+4S4ln
 vYcNdJhaJhuOdCPc+0C4LzTQS9BbAU1CVYF87OJmf/cPA3cRx9J5bV9K1Hik4T9FumLm
 hmZWkYGOcQBBNq8n3orgeV3QhA6c8+Cl5VsBnwL9Dy/waamNHvTYqpp1zYvbN9JtKkIX
 MSfjBcPviPgrV1prEMDRQA9wgMkzWPsTT7qao6zY1K1/WkIH+AaIEDuZCYLiM+4fjsNP
 HrJ8h1SjW9ckcDGxKzWAe+pEYfUHbJWdnWg0Yz2pbBX9LeMsPYe2sXEqi0krS1rtOeJI
 qutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687191; x=1791291991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y5LyVPNhnJ5Rp7yPTDFXlLblOQWcWIIfQuz7DLHUCd8=;
 b=iB4y9Q5p6rcLkmtBQyC95hC3fwknQYK7BSfsgC9dScPEaxNXVEOasTAbI+Kn5fz3Fu
 kMDxvEr3VLBid2DRUfQHj9FXi6TSN78ouVxJ5BDsaAHnn5/YwT/FL32gFnV/GT2fm3Mw
 p2KSrJnqoUSs8fDk+beoHOeiNcO2IAVzvq0sExrwJlD82UcWnUDueDXFqC+P1WXmVZ8u
 w/hyNe32KyYJ9yikMD/KFaQVa0l4UE8OhbSQYO1LLDmwBSgPoGD4gxHsDN9ZqCYiCaBC
 CW+Fsap5pGpsRpYqLyvxKRr3Ad1KRwdHfGh4o6xu8q2MRei6Hg62Zggntb8fPeFNxzQw
 pFQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvftqIQDVUQQqn5+inHb61LsvW1fQ/0h8vTeQ0zPupCRLksnu3VLefgDv3wX6NvaziP98btVYleP0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k73JTHS3uOkf4UINky32JsDtJewhq6YgaJ3ItnUtnRHgHxti39
 7YyI2oxC6+0jh+iLE6jxfzkBosPiYinUwGmwgTB3YLuindRRqxNKETKy
X-Gm-Gg: AYBFou1koBAH50AuGOaETtbBghDfLD+30A+8Vs7hIj0/a2XBkkJYxVurRbn7yhhdaIz
 6jVYuJI1XFxWRHJq+iqjEjXvxSvXof6JNWHL40gpYmk1hQLAevRFe8lJOiQ/dBywN047CJ0MAis
 ebkk/ggnMI00QlHABI+iBJiWd+gz3mu50M278WLpYd6y0flADViS+ivS8Ngt9Zu8YMvLTq4uQdQ
 zaro63t3a3HT8yvP/xS8s854yxu466eerXgzGhCAAtCadWHnNhD6SFqJRy7gBYmcc889bHQNLnk
 QG8aJ+WpLEUG9znw8ElTW6GhPlQUq1pavqUiC+rBIw62wVYoK7GcrkqcOIyJ9uxzLYn7+0PniAo
 4ERZ68z1Zbxcl9mGjXJJa80TP4gco4/QzZJzrEJjcvZ7pmVVfz6bLMC1Y1LBQ1appZMouSeafwk
 mhbk7RLMza0kYHCq+F0jZdkB0kUpOGUEraimrjOyXGqd/Tfa/cWNEijYIG68ahEKijlEx90bNVu
 IfJpngT2NPc+g==
X-Received: by 2002:a05:6300:44:b0:3dd:85a9:55ac with SMTP id
 adf61e73a8af0-3de26db6d92mr12641170637.37.1790687191466; 
 Tue, 29 Sep 2026 06:06:31 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e115e41asm841108b3a.10.2026.09.29.06.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:06:30 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yongxing.mou@oss.qualcomm.com, Joonhoe Kim <26rote@gmail.com>
Subject: [PATCH] drm/msm/dp: hold one runtime PM reference per plugged state
Date: Tue, 29 Sep 2026 22:06:27 +0900
Message-ID: <20260929130627.959-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

The plug handler takes a runtime PM reference every time it runs and
sets dp->plugged; the unplug handler drops a single reference when
dp->plugged is set. msm_dp_bridge_detect() also takes a reference and
marks the sink plugged, and keeps that reference as well -- on every
detect while the sink stays connected. On top of that, in the current
tree the plug handler runs more than once per plug:
drm_bridge_connector_detect() calls .detect() and then .hpd_notify(),
and pmic_glink altmode reports an IRQ_HPD as "connected" too. Every
extra reference is leaked on unplug.

On a Lenovo TB323FU (SM8850, DP over the USB-C port via pmic_glink
altmode) the DP controller's usage count reached 28-34 after a few
plugs (rpm_usage tracepoint), so the controller never runtime-suspended
after the display was unplugged. It in turn kept the MDSS core GDSC on
while all displays were off.

Make the plugged state own exactly one reference: the plug handler
only takes it when the sink was not plugged yet, and detect() returns
its own reference when the plugged state already holds one, or drops
both when it finds the sink gone.

With this the count stays at 1-3 while a display is connected, the
controller suspends 3-4 s after unplug, MDSS suspends and its GDSC
powers off on DPMS off, and replugging (quickly or after 20 s) still
brings the picture back. Only tested on this device.

Fixes: 3ea2d1c3d154 ("drm/msm/dp: turn link_ready into plugged")
Assisted-by: LLM
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
Related pending work: "drm: handle IRQ_HPD events correctly" v5
(https://lore.kernel.org/all/20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com/)
removes the IRQ_HPD-as-plug path, and MST v7 26/35
(https://lore.kernel.org/all/20260929-msm-dp-mst-v7-26-4b81473185e7@oss.qualcomm.com/)
the detect-based hpd_notify for DP; the reference that
msm_dp_bridge_detect() keeps is leaked either way. MST v7 27/35 touches
the same lines as the first hunk; happy to rebase on top of it.

 drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6abe30bdff12..4e47b659c71d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -412,10 +412,17 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 
 	guard(mutex)(&dp->plugged_lock);
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret) {
-		DRM_ERROR("failed to pm_runtime_resume\n");
-		return ret;
+	/*
+	 * The plugged state holds one runtime PM reference, dropped by the
+	 * unplug handler. The Type-C side repeats "connected" notifications,
+	 * and detect() may have seen the sink first: take it only once.
+	 */
+	if (!dp->plugged) {
+		ret = pm_runtime_resume_and_get(&pdev->dev);
+		if (ret) {
+			DRM_ERROR("failed to pm_runtime_resume\n");
+			return ret;
+		}
 	}
 
 	msm_dp_aux_enable_xfers(dp->aux, true);
@@ -897,6 +904,7 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	struct drm_dp_desc desc;
 	bool phy_deinit;
+	bool was_plugged;
 	int ret;
 
 	dp = to_dp_bridge(bridge)->msm_dp_display;
@@ -910,6 +918,7 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 		return status;
 	}
 
+	was_plugged = priv->plugged;
 	phy_deinit = msm_dp_display_host_phy_init(priv);
 
 	msm_dp_aux_enable_xfers(priv->aux, true);
@@ -960,6 +969,12 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 		}
 
 		pm_runtime_put_sync(&dp->pdev->dev);
+		/* the sink is gone: drop the plugged state's reference too */
+		if (was_plugged)
+			pm_runtime_put_sync(&dp->pdev->dev);
+	} else if (was_plugged) {
+		/* the plugged state already holds its reference */
+		pm_runtime_put_sync(&dp->pdev->dev);
 	}
 
 	return status;

base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
-- 
2.43.0

