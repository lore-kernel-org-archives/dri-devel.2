Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AEBCA600F
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4D510FCDD;
	Thu,  8 Oct 2026 07:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WfzDtIA7";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A39D910E618
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 15:58:54 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e541dc9cb9so10693465ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791388734; x=1791993534; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y0+BzHHJX5mfmFv3lfMeqEtJTStmMvjEmJulVgkK3Po=;
 b=WfzDtIA7auOr8cssYZbSbxOm6EJ/mJKTzgKuvNrGQOr/ZYd98AesAVGCe6UTRwCEjX
 4eLkb6HsOMXT04PRuuHJRFf+4R98uedd0kkhBv/l0gEdOfS0As3cp3AHzO45v5l7VkmP
 xF7xD/ZDhvAXVyp13GANZS4QonwseATGwZDjPrYODA97lohAPgC4HzVQN8S0zNcmTD7D
 KlU2uckjARNND0dJe1JsHp/kCIFrVyzOJdjqSXSlI7dSWoSEokZniPwvXAJQN+nd2cXF
 YNTVTJ+oPV678xDM/RK96zp2OIWFKX/lyLxyRkqvAstHVtO1eye9BcMdGEBpRjcF6QTH
 Csyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791388734; x=1791993534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y0+BzHHJX5mfmFv3lfMeqEtJTStmMvjEmJulVgkK3Po=;
 b=RrIivVjmIoGotQeYFp9dS5vTNW7mg8yXBC/CMbzgsFgmJ0DH8z3P3NGb9qMHY4+cg2
 1SAsUcE9fq3eLhqfUUrVipBGWvvndqv4A+JukYIqBpVMaCGf/NOMegtWCyCzfUW6F8Ki
 /AZhg6goi+ue7K8zZ50N7c/JcxETmrE/NmlV++3qE2zxeJ5CeiF54WCbk9au2snDHJJP
 9J/cKMV+Ap6pIOdQVHhLRyEnFSA5DKMHLb6DZ9YHLdmGqqAu3fbDICWL0fQvww5+9YBx
 hQ24ijnd/zfffZr8Cw8dtipMJhrkUKHNlKwblYOYzGhVkA4Sx1xofKULEDc6Z3bxC7Tt
 EnJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSa1k/G+CkrRjQEhzB76BPhxxXg4Gvho6GdcklCc7yJ70JkLZOieUiWW2mch6yZqDDQgsz2zumeyc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLxoDzwVNTlm4vfHbYBIVsEPWeOPSZPihPzNmZtJv2LuGODmIEu
 u0K1bdZ/+pauT1SrkUANZofBfWpiw3wjH6dl4DQj9ZA1BxSGOSwxfQAG
X-Gm-Gg: AYBFou0WGO1hzK1an28fpNy1N8bUwuYVxC5MYGgaZpqcyzl56mRfbIc4IHujbOpSAM7
 umwGxZM4lnpN0X9kFSJvSYfydxDW8Q7k1jNqC2Lvo2TRtj0D+m8TNIIBIcXu0CoQnbWClSZ+HVP
 /LXtpOT4vmvvaq+F0Mw/DCWXjtMkg5WV6CHauzNM1dp26fyhNue4Ez2yCnbQM/3mrET8nZPovRB
 8fS8GC2ObVXsipPrgWYq5v7dJadLa9WbCjXmfqGUM7kND+154cShumoPoGMaugFjyhyJHcoKZkm
 N3/Tg+Ez20GKsHiUYNnP4R7vvjDozPinkpAW5JOeIldSFAjEzFnSzh2Fzz4sZ3XhUk7LgcNEcVg
 RpN40EvjXzb+mrWCfrZTI5/EXVm9NkZtZeXinFM9xgDaf9jHTKG4AIFIT0MwIVDbLh5IJuEq3ai
 tBRSDuiXDI2xhE7xdHGk5usZf8whYR7lfhytdiGwtRVEu246adwqWedfSQCbSwci/iz5J8sDoLS
 HITun93rm/RfQ==
X-Received: by 2002:a17:903:2cb:b0:2dd:ad74:6d16 with SMTP id
 d9443c01a7336-2e6004e58f8mr21696275ad.28.1791388734016; 
 Wed, 07 Oct 2026 08:58:54 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e6046fe0c1sm13631695ad.21.2026.10.07.08.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 08:58:53 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 yongxing.mou@oss.qualcomm.com, val@packett.cool,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/msm/dp: hold one runtime PM reference per plugged state
Date: Thu,  8 Oct 2026 00:58:48 +0900
Message-ID: <20261007155848.106-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Oct 2026 07:42:48 +0000
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
Changes in v2:
- Drop the plugged state's reference once, after the if/else, instead
  of in both branches [Val]
- Drop the comments
- Link to v1: https://lore.kernel.org/all/20260929130627.959-1-26rote@gmail.com/

 drivers/gpu/drm/msm/dp/dp_display.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6abe30bdff12..4059cb9dba64 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -412,10 +412,12 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 
 	guard(mutex)(&dp->plugged_lock);
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret) {
-		DRM_ERROR("failed to pm_runtime_resume\n");
-		return ret;
+	if (!dp->plugged) {
+		ret = pm_runtime_resume_and_get(&pdev->dev);
+		if (ret) {
+			DRM_ERROR("failed to pm_runtime_resume\n");
+			return ret;
+		}
 	}
 
 	msm_dp_aux_enable_xfers(dp->aux, true);
@@ -897,6 +899,7 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	struct drm_dp_desc desc;
 	bool phy_deinit;
+	bool was_plugged;
 	int ret;
 
 	dp = to_dp_bridge(bridge)->msm_dp_display;
@@ -910,6 +913,7 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 		return status;
 	}
 
+	was_plugged = priv->plugged;
 	phy_deinit = msm_dp_display_host_phy_init(priv);
 
 	msm_dp_aux_enable_xfers(priv->aux, true);
@@ -962,6 +966,9 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 		pm_runtime_put_sync(&dp->pdev->dev);
 	}
 
+	if (was_plugged)
+		pm_runtime_put_sync(&dp->pdev->dev);
+
 	return status;
 }
 
-- 
2.43.0

