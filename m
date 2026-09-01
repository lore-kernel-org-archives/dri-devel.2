Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819D8C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFAF10F3F1;
	Thu,  3 Sep 2026 07:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AEmAPqmF";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 170FD10EEE3
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:55:29 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-6b37782d003so194320eaf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 12:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788292528; x=1788897328; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jE7YeOTH+Slgx2JFrDNEXYntxMlmYaSvMdCwqmpupuI=;
 b=AEmAPqmFAne5r+D0ZLbR4f8Maw7nla6hlt/dwPgLG/Par0LF6WlDFi5El3bIRIHKLC
 1pwMPlJCZS7MH9sykfIAcVGQeMmC+pjk4P3TFcE9i4f7gxfAWsu2v7USQj8nb6DmbsEn
 14u27y8ATsN/10vHNjQJeus+PD/lWHdaJjtsY1ZyVpKK5O+xda48/c+YFG0ZnzBgaJtj
 /KiF90aUwmrxz47zAmBXttPGrogF9+SfLf3OKfwhRfVenfbzywa9Z44zV73Kb9WjthuP
 4yLHTTWNOh3QOifVqNhZumqHQ6bsW3Xr9gBXGhJ/GNG+ELX8/ZUmyVmLzWOQdb79J/Cv
 UDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788292528; x=1788897328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jE7YeOTH+Slgx2JFrDNEXYntxMlmYaSvMdCwqmpupuI=;
 b=Qkasvscpf7zHLPsbS1zNexi6orsdYPis6MUO+mZWE7Ekvqbrp79BoouaD+mWNhrrI2
 e30CFxvbNMkH7CMeEEAmyBbcv6yz9DqT1Yuo67OiZLv492fYmuQc2W94zHIMPXT/DmOK
 42PwidllR7dzB1iv69E7n+gLlXXhui00ONYyO7IyiG/yOTmb21LS4lKXw6h7gCTUN5VP
 iiW1c/9ct3Fww9jpHkE4d8thjKlleL712HY1LerqMWv/YIG2AP/Nn3BhVd0g7SM3nUiq
 pGcxiVouy8eBFKT2VOmAjZNUYHyoH8sK66M0qaAew448Tt2tIeMG9NtlxGqDSb93ZJz8
 YM7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpr/JIOsupWu/1X054PsCoGtz2CAIFB7wZw7xXYwgFgaxJDl5sz4jABC8J7okPlLqdIrHmDpgLBeOg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kfe8eaTL547F3imvG1WPEbVTKqokuPVv3zH/I7FFRo0NaXDEzc
 eRxoATtxwzKztcbmGIN2zdmyXBvk3EYJzd3wPta0K9OM25hl/OVRGploSXvbYrnj
X-Gm-Gg: AR+sD11I049frIgAc7q/3ar+jbl5zf2cN4TMkUtyH05g5CRW8wWh0HrPrxgprjwCpiT
 CWJWgbLEuQtTY84GTFq2eHFsaJ0SkRrOvo1jP+iCrpF800pYrd7WIkKuLWDjYjO8pi8GZ5ZBLfn
 KmYSuuW2Fo8F2Y1Erm1kwqajwn16/+OVwAUMBq8DwZxZDA9+9UKuOzD1+4N5eo7fqmUgSFR0Azh
 Eotad7TR5LXHo1ASeCjYY0SwO8r6qZIey36knR+WB8TiZOOOa+0IZK8gBu8tZzR2azATsfZy0eD
 RLWIiVEZtdgjhb3ehFTk/OqgvOCz4bWBePIS0TkKfjSZu0u95Ew8r/gYwugw/ZvKuxgi7yLojYh
 5PHjZZxEIiDFODhZRG+NLK0V+AJmUQFf84VE6gq8amkEMdY9q3rgQJ4VWA4wVnlmrJcgvQyPSeM
 DTMGeBt2it2V64Ar1y+DHEO+9jC1gTkqQ4LyTlBnFYzPE3GyyhsdT86GBwmyvMXOHhxmbJXMQBH
 Bhmcfv1jnZGL5GhGPc3xO/jv/NzONVFi1H42/3iK2byUCg=
X-Received: by 2002:a05:6820:823:b0:6aa:cce3:ab61 with SMTP id
 006d021491bc7-6b372d20e4fmr8604105eaf.9.1788292528131; 
 Tue, 01 Sep 2026 12:55:28 -0700 (PDT)
Received: from memorizer.localdomain
 (47-163-111-11.bng01.bytw.tx.frontiernet.net. [47.163.111.11])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b40f81f374sm868636eaf.14.2026.09.01.12.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 12:55:27 -0700 (PDT)
From: Yudi Yang <2000jedi@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Yudi Yang <2000jedi@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/rockchip: analogix_dp: bound endpoint name formatting
Date: Tue,  1 Sep 2026 14:55:11 -0500
Message-ID: <20260901195511.2761251-1-2000jedi@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

rockchip_dp_drm_encoder_enable() uses sprintf() to format a device tree
path into a 32-byte stack buffer. Device tree paths are not limited to
this size, so a sufficiently long path can overflow the buffer.

Use snprintf() with the destination size to truncate the generated name
and keep the writes within bounds.

Fixes: 729f8eefdcad ("drm/rockchip: analogix_dp: Add support for RK3588")
Cc: stable@vger.kernel.org
Signed-off-by: Yudi Yang <2000jedi@gmail.com>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 587e60232ec7..efd5a98e80bd 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -241,10 +241,11 @@ static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder,
 				of_graph_get_remote_port(endpoint.local_node);
 
 			of_property_read_u32(remote_port, "reg", &port_id);
-			sprintf(name, "%s vp%d", remote_port_parent->full_name, port_id);
+			snprintf(name, sizeof(name), "%s vp%d",
+				 remote_port_parent->full_name, port_id);
 		} else {
-			sprintf(name, "%s %s",
-				remote_port_parent->full_name, endpoint.id ? "vopl" : "vopb");
+			snprintf(name, sizeof(name), "%s %s",
+				 remote_port_parent->full_name, endpoint.id ? "vopl" : "vopb");
 		}
 
 		DRM_DEV_DEBUG(dp->dev, "vop %s output to dp\n", (ret) ? "LIT" : "BIG");
-- 
2.43.0

