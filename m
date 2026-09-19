Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDC3C982D8
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 19:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE58910E1EA;
	Sat, 19 Sep 2026 19:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EGVRnRjM";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2275C10E1EA
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 19:15:38 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49e73611928so13553765e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789845336; x=1790450136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TYG31FNdE+jTjB9/DDoxQaNK7idCKtZmhwSMIq4k/44=;
 b=EGVRnRjMkdDFnSMTPaqnGfsuHwT8RwgTp/TYwjpgkwpGNeGq4KVjxgCsdwJRvNzqh2
 KUz+uPUN/oSdPccrlz83HhhdFKtN2TTvZSWjy/l8bpTkx7frXjeQIli1nzROYwfGVU6v
 BfFmItoBRsMEbDXU3cpjclppMxvRDPRscGooinN0ewurPfjFsjGeskrkqlTrBf0hL+0z
 fuBPPHcWso9n5Uh2JaAeDBNiwXg8GrZ+6/dbgtLOZYJzeO5YdSGtsa2FtoDmyBwbAJep
 sHRagZVM7FqlzN2Ui1wgH5/Wqcs2metG2xHNieNjpY7tBc8hCY7rZ4s4z/02xlSQ9KTs
 OXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789845336; x=1790450136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TYG31FNdE+jTjB9/DDoxQaNK7idCKtZmhwSMIq4k/44=;
 b=xxOod1GdLN2lnoFgUmO5TICveMz4hV+v+5MnqgVT+ZyRShAMklDHXjea+339f2+gdv
 iC3sG9MLruE5poMb4gj0bQpp35tWX9OWvFvBxr7YU29++yydPZLloRVCgEbnKcVg2zgv
 gKSOii1zeaQunV3Nojh6emHJUn8a44u92daInju92YDDkZioDF+f/5kQIClfnhyCecPL
 rPRd9sZaolY2mxir/Pe0iQpuV+ucbEYwpZ9L29USSWdfe7QFdbO3OqLdCZd+Iu3t/Zwz
 Cqjtt0fXH/UZe9faBy/P79gMMUa+dKpKhCBqD3u4wtojFWe/AtXlAS77OvKk6uMTyAtD
 jbbg==
X-Forwarded-Encrypted: i=1;
 AKwUvByXdOpaZ87FY8z81+hXzZbXFFWBGmzzT1C1eFtObOZyoipEF73z3cgkiaHSHMhIkaJ38LnXgMVE8nM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k3nVH8GRH8dclTYVInTYWbvYXopG0Mmw8QkR916fHIVADfOquA
 LKegneDSpZ4G/32JziRCLYd6UKBDVsxyLoCe9Uefm4Qo9ty06qsOdm1+
X-Gm-Gg: AYBFou2ST5160a0joy8JQm8EbhUVCfR1bTlosWyPciA+TOWoLb+IXja54AB1dgvM59H
 qXNKUibxQRI6/nxIfOC83nVdjrHM9iWc2mg3frM/69Yzy6B7dxA4C9LLOzhaJF8UJIVgzh+ODoW
 rFl8Y2O/qywQwaCBYBeRhvQOPAi4FIGPz3goIEGw22HDiR9e89TudrzH6urws1xu7MNvClUqJXR
 QoxqT+fVRoNwD7426vBoiCQBrD9POKDCZKVB66Iwo/amwcz3RmrkclkPwOBfaHpJCSBqY4Oc+fc
 WofvtPcvakeTnsSm7jKy69/EC32i+iUMSokhsq1IuoNcBFCEJfo+UN6BjjEQ1C1n0Qbks0TD0zA
 IrgkmijkUcM/zMnRhFzC1qUoAttVdg3+GkUBiXZr6v7dFgzC2M3HNHYqWC7RcWb5sihE/aIxMoa
 nXw5p9kStMHtAfo7BeEhshCbQ+tM6Ced3nHdB/9qXgdkSfqPrhNqldnkb47rkW1I7ZqsIH0Qlou
 jkp39xZmRoqrREVIeSdpT/VbwmAxm1vDto1EdSZu8SN0slTPFJo
X-Received: by 2002:a05:600c:81c5:b0:49d:28fc:d6a0 with SMTP id
 5b1f17b1804b1-49fbd200256mr159837415e9.18.1789845336038; 
 Sat, 19 Sep 2026 12:15:36 -0700 (PDT)
Received: from fedora ([202.47.63.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872458f7e3sm8932380f8f.25.2026.09.19.12.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 12:15:35 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Muhammad Bilal <meatuni001@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/panel: tdo-tl070wsh30: Remove panel on attach failure
Date: Sun, 20 Sep 2026 00:15:23 +0500
Message-ID: <20260919191524.268810-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
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

tdo_tl070wsh30_panel_add() calls drm_panel_add() to link the panel
into the global panel_list before tdo_tl070wsh30_panel_probe() calls
mipi_dsi_attach(). The panel object itself is allocated with
devm_drm_panel_alloc(), which only arranges for an automatic
drm_panel_put() (via devm_add_action_or_reset()) when the DSI device
is torn down; unlike devm_drm_panel_add(), it does not call
drm_panel_remove() for you.

If mipi_dsi_attach() fails, probe() returns the error directly:

	return mipi_dsi_attach(dsi);

Once probe() returns an error, the driver core releases devres
resources for the device, which drops the allocation's own
reference. But drm_panel_add() had already taken its own reference
and linked panel->list into the global panel_list, and nothing
undoes that. The panel is left registered in panel_list pointing at
a device that failed to bind, where it can still be found and
dereferenced by later lookups/iterations such as
of_drm_find_panel() or find_panel_by_fwnode().

Call drm_panel_remove() when mipi_dsi_attach() fails, mirroring what
tdo_tl070wsh30_panel_remove() already does on the normal teardown
path, and matching the pattern used by other MIPI-DSI panel drivers
that pair a manual drm_panel_add() with mipi_dsi_attach().

Fixes: cf40c6600592 ("drm: panel: add TDO tl070wsh30 panel driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index fa961abdd2d7..32f2dd2bcee7 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -179,7 +179,11 @@ static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	return mipi_dsi_attach(dsi);
+	err = mipi_dsi_attach(dsi);
+	if (err < 0)
+		drm_panel_remove(&tdo_tl070wsh30->base);
+
+	return err;
 }
 
 static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
-- 
2.55.0

