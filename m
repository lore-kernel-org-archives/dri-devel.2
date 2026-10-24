Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDDC606A31B
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SqqxvfPc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D9410E54F;
	Sat, 24 Oct 2026 22:59:08 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C71410E19C
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 05:20:00 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cc52c1b8286so694712a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 22:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792819199; x=1793423999; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fBJqAEswmSE5diZ2tydC9GmlpfM+FyzcsAh2j2PMbx4=;
 b=SqqxvfPcnQzNhDU0i3GwQRxHEoNdBIWp0dZz8I6gDUFT5pVTLgfAtCQDj9sgTEmaHe
 zyJbWcbYiVqs44bJOt3zqle1NOacBfGNSiXvvbjUUki6HmOSf9QyIIxQlbK0aOYjYqRb
 jiyO2qMrzRQDx0gaIa2qB4rfItnXkvo3efATI+2RzbH2PFC0SNJOZ3zIpjuo8Lbq/HZR
 x19YhNVinGE30RveaJqKxeWSE+YZlNg9nZmrshKYd4X55tzQabXvqF9zNHYQXVqP2zN6
 k/Q942BFqudyhE1rZgSbNOJEwSiDrUgeQitfScprxf0I0tFz8/9sg85pE5a3jfy5lKGB
 fw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792819199; x=1793423999;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fBJqAEswmSE5diZ2tydC9GmlpfM+FyzcsAh2j2PMbx4=;
 b=TIQQ/GIjdYhfM4VavDo6llYPCtIGOoy+08DmXb6ID9gilT4r3nRPxpR0Jfx6XV6s1Y
 aK1L4VlWNnFmHJBA/9K0G2Waun4rovXlCS61qHFsUWApt13JNW+qqU535ILPpAsqDUQR
 E+a4WQD11mRB/K2tnq6DALz21l7goiZse3km0JQS1htskpx6UdixOSCexz0hJTZMB5HL
 qANU8amdPIuneFj/DWKWGK5BUeAqCQYrTOHdcenAzOw8IBgYt/NuYRNYPkj4yMUNOui8
 UMQWQCUAeWZ3CxJxDUilUgPAubDESSEVI98DQBIapRq4eS2wl3CaqJVUSlM+iXDNf5TN
 33jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5p3DmsYplrfY/XuGw0Eta7kdvMVRXiboH1RckothluLmToicfgGlleZAVyxISCrL4sdI7hfHOEic=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYInfDawQmR08JChRePy6YqTYQTOSxxDuiWPGDJC9sPLqiO1yHRd
 41HuaLboVdxavv4BSEbuMgFbocQsrFzyPj04It6UPrrvEdCTj4uAD9BG
X-Gm-Gg: AYBFou1Q/Y8r4dEPjgjm87rZioSUQRkZylNxAcvZvTAPCdBBVUPqGWY4fY/bBfBkuOX
 pLCQWgH5FJbIGkkpVTiLaox3Jd83ZVbafPP4Op57MQLLS7qWV7n3JNgDHRN6i0gAtOsIBUFZ3fx
 SW0QI+T7TYjVRt+qruiORuzCvJz0nyTjn5X8aecqDqcllKtqyhKy6vGgw6s2AjiEY1i7bRBuCY4
 Lw0KHmyIXaIwmDsLNtq+vxpaRcOxwLC3bdzZMBqioXCPgPMCIEaR4AgrOKBFiHNWfji8QSEeao7
 DXfLVlY3kHLSqqUhevJ24f0g1iUYmzlNeMwm/wOZskX47X7fgsm67T/JFrJGFefXKMX5Kvh5jUq
 0rxVdIgaQiFteBADo0HphiyNuFJru4x7E5NHzEXBcvPZUrj0Hceg1RLXQ7BofKgf8Ng0M4R8bfx
 mvWzImV9ESD0BuELlmjx4iXOkgG4F7wiYIc2D8GVZzXZt+rgtDUug7+gBOZOGdnWn+ZhJ6gytzA
 by2ZPe5oenM6YE4xXGryyPXy2dZepp+oF/2uew7Ajpv6FiweEE3w6+vJwclCFCRPPQGjg8=
X-Received: by 2002:a05:6a21:1f83:b0:3e1:1faf:eb73 with SMTP id
 adf61e73a8af0-3e7e84e47ebmr598064637.38.1792819199414; 
 Fri, 23 Oct 2026 22:19:59 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a36ada2780sm241619b3a.20.2026.10.23.22.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 22:19:57 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 yongxing.mou@oss.qualcomm.com, val@packett.cool,
 dmitry.baryshkov@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/msm/dp: hold one runtime PM reference per plugged state
Date: Sat, 24 Oct 2026 14:19:52 +0900
Message-ID: <20261024051952.2006-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

msm_dp_bridge_detect() takes a runtime PM reference and keeps it when
it leaves the sink plugged, so that the plugged state keeps the
controller on. If the sink was plugged already, the plugged state holds
a reference, and the new one is leaked. If the sink was plugged and
detect() finds it gone, it drops only its own reference and clears the
plugged state, so the unplug handler skips the put and the plugged
state's reference is leaked as well.

detect() runs on every probe of the connector. When HPD comes from a
later bridge, such as a USB-C connector, nothing else keeps the
controller on, and the leaked references keep it and the MDSS core GDSC
powered after the display is unplugged.

Hold the function's own reference for the duration of the call, take
the plugged state's reference when detect() sets the plugged state and
drop it when detect() clears it.

Fixes: 3ea2d1c3d154 ("drm/msm/dp: turn link_ready into plugged")
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
Depends on patch 6/9 of the IRQ_HPD series v8 [1], which stops the
plug handler from taking extra references; only detect() is left here.
Dmitry, feel free to fold this into that series if you prefer.

Tested on v7.3 with 6/9 of [1] and this patch on a Lenovo Y700 Gen 5
(TB323FU) with a USB-C display: booting with the display connected,
plug, unplug, quick replug and s2idle. The controller suspends after
unplug.

Changes in v3:
- Rebase on [1] and drop the plug handler part
- Hold detect()'s own reference with PM_RUNTIME_ACQUIRE_IF_ENABLED()
  and take or drop the plugged state's reference only when detect()
  changes the plugged state [Val]
- detect() now drops its last reference with pm_runtime_put() instead
  of pm_runtime_put_sync()
- Link to v2: https://lore.kernel.org/all/20261007155848.106-1-26rote@gmail.com/

[1] https://lore.kernel.org/all/20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com/

 drivers/gpu/drm/msm/dp/dp_display.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index ed899fcc9189..5f9402921efa 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -908,6 +908,7 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	struct drm_dp_desc desc;
 	bool phy_deinit;
+	bool was_plugged;
 	int ret;
 
 	dp = to_dp_bridge(bridge)->msm_dp_display;
@@ -915,12 +916,14 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
 	guard(mutex)(&priv->plugged_lock);
-	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(&dp->pdev->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
 		return status;
 	}
 
+	was_plugged = priv->plugged;
 	phy_deinit = msm_dp_display_host_phy_init(priv);
 
 	msm_dp_aux_enable_xfers(priv->aux, true);
@@ -970,7 +973,10 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 			msm_dp_display_host_phy_exit(priv);
 		}
 
-		pm_runtime_put_sync(&dp->pdev->dev);
+		if (was_plugged)
+			pm_runtime_put_noidle(&dp->pdev->dev);
+	} else if (!was_plugged) {
+		pm_runtime_get_noresume(&dp->pdev->dev);
 	}
 
 	return status;

base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
prerequisite-patch-id: f2dbe1f42c357bb1d32081f58660ed1fac8f7777
prerequisite-patch-id: 358e5f35d442041b88e52d8e39a564a053a0f990
prerequisite-patch-id: 9860b9acb12b1c2652e4e9f4860968a2ca3361f0
prerequisite-patch-id: 53486e695198f785401740f7f4372bdf335fb620
prerequisite-patch-id: c8e551a07553f7dc107063a1dbec1d415184f97b
prerequisite-patch-id: 1a6251919897ca5e8b12a63774a833fd8460c67a
prerequisite-patch-id: 846ab694795c6bec123d1dc46d7a53097bf594bf
prerequisite-patch-id: 2a058aa8309016f424b1d4ca19a9b20e92f4d8b6
prerequisite-patch-id: 76ea1ecf4e1d83ce2e5730aa36ed1a4524f15e56
-- 
2.43.0

