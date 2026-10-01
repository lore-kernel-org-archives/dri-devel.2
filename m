Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6886CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5F910EAB5;
	Sun,  4 Oct 2026 17:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pywHPjn9";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E3C10E3A7
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 16:31:14 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-3115c4451c8so1037996eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790872274; x=1791477074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EWggAU8+PC/wTcVJIK/vivRWl2rgbBRA+Bk0A2t4p2k=;
 b=pywHPjn9l8Cr+JnOv6sL29A9BQGDt5xYsGLGMuHz4l9tomOjZJn3iGnBlC8onS+zbO
 +/J5m3zWNpqctMzw63cYLyRei5LZMEsP+bHAMPbiQk2lVpe2Bb9xOT09FUSs6JZTPBs6
 kg3t60Dh9KRlxQ8Ih0IKViqprYczQi1gye4P1TSlycckqkHpHT+4WtpmDks4yrucfp2c
 r1PKDFUsGjJ5z6Htacs9l2zvWKIDEVNfKdmU7s5U2qAyaAt8//8Cl4e833EKWJkyq3vT
 BHLRMcxAws3DzvwQZHYDQHtBUjl0OY1hOVTH5XbFhIwNJPcD6nVGOdTAggn0jjL5dW9e
 YTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790872274; x=1791477074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EWggAU8+PC/wTcVJIK/vivRWl2rgbBRA+Bk0A2t4p2k=;
 b=dXoq2aZ5wDrVHYFRe8zZn9s6K/usofv2I8gfU2JgopEBscaIDA2FE48tECPvWX1812
 pOUYAVUBOs9G9wZiptPIOHDRRSppHK4WylCQ7fRZobXSp8X/cBGXodqOwMzFUla3HZST
 BpYvh+rR3EIK9+psDhz4DjBJOS4c7a/TeqUjiJv9hlTBhhiotB0cuIRaJ8mpry1d7QUJ
 hTeFQVh5wgrJFroVyrXFFkGircMApf+guI0ISV2INMjzZ3kwAM5/ZSJzUGm5ggL/xz42
 b0HYw9EcDtGNihrw/GHfMujU0Zcs9ywaFa7kgsCRjwLrm7gheyt6DsG9VFxlSXwfKTzo
 MaYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAWwJBuPFEOlbE4FRUOOXlLyuNqkaTPICLnk/cpm2kbs+iLPHsu22C0Y2NqonMxXZ0DjKyDfxowik=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nHShPWmbvtgkrDqA6vMp9OtQCvRtooV4MQP+PqwSnObmMZRtaC
 8mGoWpQiB8divH6gSfozevWEsVbWWlhehAnbxaDBEbqnbXeRmGS4IpPn
X-Gm-Gg: AYBFou0HrrzrXYI2jQK4imyIoQiTKemWvDO3jX0FfvLwiJsS9Bb4tf8qrHoZ21/MbGn
 Qq0Sdt/hV/OPFP36QRXTbXyVRZ1GbAzeI+kB0lVleYeYAStC7UecitBe9xQ3dqfb1LqP4AWYEzu
 3QfivygYADtBq5dm5n9Pr0Taf9nmKIiEd1lgHr7uRSI3Lzwcz35BrnThcKmHHOIHhNgWAOMwrd6
 BBDfuizmZE7TFWPLGrTmj/opDRYe+VrkCFW3SONf7yoEtCobruaeosxpsaK3y8vDFAB6+4PsOnJ
 z8Prw9VrM5NFRScPYtoZPyo5MCy2wCOl9Fh+3GkUEifJCuZ4SySAZzwt647tieVlf/EibuVb9Om
 9zklkYfcO+35BvWTu7sjYLDjLrb5Dm1StKXcqri1zgcoky083XX50bz8MIOTw2lUvN1gvxuBzAm
 t2E7DGeBNkLmiPWQ9nzjOSURfV0zVUh+AG2W0VeQc4BwFylMb733A64LaROHF2S9zGynX2mVs1h
 CluKWOutEYZqbHQSlEqmMw/G2j1T06Zk8X1C/y1cTzMNZwICTUQDAt/e1QFlkMWzIAeh7rO
X-Received: by 2002:a05:7301:550a:b0:34b:6f6c:2274 with SMTP id
 5a478bee46e88-34db3a44f9bmr2819377eec.5.1790872273852; 
 Thu, 01 Oct 2026 09:31:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:a4cd:e25d:fdef:4a3b])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34ef8de87casm21949eec.8.2026.10.01.09.31.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 09:31:13 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] drm/verisilicon: use ERR_CAST instead of ERR_PTR(PTR_ERR())
Date: Thu,  1 Oct 2026 22:00:53 +0530
Message-ID: <20261001163104.51165-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

ERR_CAST says the same thing without the round trip through an error
code.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/gpu/drm/verisilicon/vs_bridge.c | 2 +-
 drivers/gpu/drm/verisilicon/vs_crtc.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c b/drivers/gpu/drm/verisilicon/vs_bridge.c
index dc7c85b07..32f9984d8 100644
--- a/drivers/gpu/drm/verisilicon/vs_bridge.c
+++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
@@ -322,7 +322,7 @@ struct vs_bridge *vs_bridge_init(struct drm_device *drm_dev,
 	bridge = devm_drm_bridge_alloc(drm_dev->dev, struct vs_bridge, base,
 				       bridge_funcs);
 	if (IS_ERR(bridge))
-		return ERR_PTR(PTR_ERR(bridge));
+		return ERR_CAST(bridge);
 
 	bridge->crtc = crtc;
 	bridge->intf = intf;
diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/verisilicon/vs_crtc.c
index 0b8a35d09..af8e33c96 100644
--- a/drivers/gpu/drm/verisilicon/vs_crtc.c
+++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
@@ -172,7 +172,7 @@ struct vs_crtc *vs_crtc_init(struct drm_device *drm_dev, struct vs_dc *dc,
 	primary = vs_primary_plane_init(drm_dev, dc);
 	if (IS_ERR(primary)) {
 		drm_err(drm_dev, "Couldn't create the primary plane\n");
-		return ERR_PTR(PTR_ERR(primary));
+		return ERR_CAST(primary);
 	}
 
 	/* Create our cursor plane */
-- 
2.46.0

