Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4300CA9EC8
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8C110E5F3;
	Sat, 10 Oct 2026 11:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rYuWYsP9";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CAF3112325
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 23:50:50 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3ab62a8250aso98186a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791589849; x=1792194649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o03daM7+t5eI5rI8Xu7b7WsUdFV31fx6hSpjs/Fu/WY=;
 b=rYuWYsP9ws1gBny9DOtr33pIeOieHArIgvvAgzUnE1yt723Ia/AVE+Kbg3cKQt8WuC
 SFiwe0zJDEQPT+x4iemKB2XRxINK8vHxhMqKCF8bwj63ArrB0QNFRWOo62Rr5FIC6yIr
 vRpvZmXWSLik7xTZ10IZvDl9coTiymcBu2xbTB5sAebijRR70rm1xhCxv0270512gzR6
 BGDfwjEjZ4yeadzfTuKh66diWM8b5ekCNgYUlsCb1F31S0JVjiEOs6n3Ta5qHeHKHeOW
 rDM+jGoJptPXQmstFwZ7tBKkWfuSu6b/G+wsSS44SrPcc1toPgVkWAKc4QydcmtSALT0
 CYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791589849; x=1792194649;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o03daM7+t5eI5rI8Xu7b7WsUdFV31fx6hSpjs/Fu/WY=;
 b=cfdRnixTyisJmyze7/Sh5J3HwmlRjm+bd12J4/rMKjRfXbING2vuhofgqJyrwxekMH
 204wpxh5EgFXGtsKQIsBszEdqHCG6WkbUn6tXHVDnTJvYIzoWoUzlCacecGUrO0vptmh
 qbwyuFy6mnbQCPDe+3b5dWHzvbLN8bP5tQ6aisdWCTxyw1WTrCIN+uCSCbDE9tP+sxrY
 r0G6/GahaX130TjXkrsJ8K6Z+8MvkorhQF0xNFkpLulzSLkcrT7Sl5U139Fnfw2TGBxN
 omDmOR2r0GtZNU1bK9RQa7NwVnjtDU16MBclgWL7OOz0t5pj216ihEdJ2kJxV+wsKzsT
 H0WQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBywoBFv3DU8wxosAel59hz70x0yn9vVr+Nhkty4HohcL68bVvmfdcb7UqK31e55H4Ug+5ASvHELJiw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKiDxYrrhYZfHikTvCfC/+b35EHjXjlxtj5WJr8QemZ0CAeg/7C
 KsVnh571PGXs7njuDHSs+ULhD8xT8jWZVDP2xLAYDvCUrgEI7wN1z0VBpFBq5ekdYh0=
X-Gm-Gg: AYBFou0lv4jnh11ogV3LHnPGdCYiNvywquU9+8dfA07sV24B3enxxzBMSUDuRnX7vui
 zmuYYyOlTdYGpw8gMgp48/pCJQiktVWdbP0eskhQfkV+0Hx0yr0/3t+BP3QCGh/nIXCFEShl5nO
 898T8mEaCSCMfRqESe0CiP3snvfnMRNzdKbnhjPxv134li3MDcbBlSLBxHhtHB3lUdQ8rmhwNgu
 98TknjvE1qHDu4q6g7QHpdwv8qpPycjef55zMKCICnFsJYq6N73+wFU3p7jFxv+m3CfRggGhaVC
 GRR19Ys4rnVimN6yV1MEEU64US3HbBTXU4o1BgvAjaXWIBPz3A7B6ypg09mOiBAcJ43viaNDU9C
 qwMgrRZBJdUdEAkQicBhZuhS8bAct3a5m7pXD3nZFXD1ZQeCpLQXuyT128yPmWL2U/Zic3YwnLR
 J2Go7mcG/ikLOjOI32y6AgFqAqYPsRXuTF8R6fmMcPUmSfgbp5RsGBOFOIuP5N+rAuRGEhdwwCE
 yjnOTPZisUACeS2GK7dwi0Q2xU=
X-Received: by 2002:a17:90a:e09:b0:3ab:3d8e:f29 with SMTP id
 98e67ed59e1d1-3ab3d8e36e0mr1785522a91.46.1791589849536; 
 Fri, 09 Oct 2026 16:50:49 -0700 (PDT)
Received: from liu-logos (KD106129078135.au-net.ne.jp. [106.129.78.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab32d58bd0sm3363186a91.0.2026.10.09.16.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 16:50:48 -0700 (PDT)
From: takanashi-tetsuya <isenasakujp@gmail.com>
To: maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel: quirks: Fix minimum backlight on MECHREVO GM5HG7A
Date: Sat, 10 Oct 2026 08:50:40 +0900
Message-ID: <20261009235040.8059-1-isenasakujp@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 Oct 2026 11:45:03 +0000
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

The MECHREVO Yilong15Pro Series GM5HG7A with a BOE NE153QDM-NZ1
panel has an excessively high minimum screen brightness under Linux.
The lowest brightness setting remains visibly brighter than it does
under Windows.

Add a panel backlight quirk to override the minimum brightness to zero,
scoped to the specific DMI product name and BOE EDID identity.

Tested on a GM5HG7A running Ubuntu kernel 7.3.0-9-generic. With the
quirk applied, the backlight can be dimmed further while the image
remains visible. The AMDGPU driver confirms the override with:

    Applying panel backlight quirk, min_brightness: 0

The quirk and commit description were prepared with ChatGPT assistance.
The submitter reviewed the change and tested the module on hardware.

Assisted-by: LLM
Signed-off-by: takanashi-tetsuya <isenasakujp@gmail.com>
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index e417c75..96d85d7 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -29,6 +29,16 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
 		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x08df),
 		.quirk = { .force_pwm = true, },
 	},
+	/* MECHREVO Yilong15Pro GM5HG7A with BOE NE153QDM-NZ1 panel */
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "MECHREVO",
+		.dmi_match_other.field = DMI_PRODUCT_NAME,
+		.dmi_match_other.value = "Yilong15Pro Series GM5HG7A",
+		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x0c8e),
+		.ident.name = "NE153QDM-NZ1",
+		.quirk = { .min_brightness = 1, },
+	},
 	/* 13 inch matte panel */
 	{
 		.dmi_match.field = DMI_BOARD_VENDOR,
-- 
2.55.0

