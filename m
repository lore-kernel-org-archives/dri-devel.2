Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE7FCDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC3910E192;
	Thu, 25 Jun 2026 07:25:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZpRT1zlx";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Thu, 25 Jun 2026 07:25:34 UTC
Received: from mail-m103131191139.xmail.ntesmail.com
 (mail-m103131191139.xmail.ntesmail.com [103.131.191.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1E510E192
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:25:33 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 43b842440;
 Thu, 25 Jun 2026 15:20:27 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, Andy Yan <andy.yan@rock-chips.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1] drm/panel-edp: Add BOE NE160QDM-NY1 panel
Date: Thu, 25 Jun 2026 15:19:16 +0800
Message-Id: <20260625071916.744686-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9efda6cc9a03a8kunmc9dfba646bda1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHhpDVk5KS0hLHh0ZQh8eS1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=ZpRT1zlx823JtUoWaH+9HSGLO5KTO6REX2C8Yj1VeDNL3Qucuwz/IRW5odqyuuXJUcnewe6aP5nPM31PiflhEWPt+jyJZ+op2Rakn1kRU4EdlbcxYFqLD5KpO11VDxnzx1G2np1wHQDUiNTGS1u9a5wcMXXDeYwMNnVl1QqSidY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=hkT5IbpYSpS61ffyWxho5MXOBkX6yr/DgQcyC1Xvnvs=;
 h=date:mime-version:subject:message-id:from;
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

Add an entry for the BOE NE160QDM-NY1 eDP panel. The panel's AUX
backlight functionality is verified and working on the RK3576 EVB1
board.

edid-decode (hex):

00 ff ff ff ff ff ff 00 09 e5 85 09 00 00 00 00
1c 1e 01 04 b5 22 15 78 03 7c e5 a4 55 4c 9f 26
0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 6b 6e 00 a0 a0 40 84 60 30 20
36 00 58 d7 10 00 00 1a 00 00 00 fd 0c 3c a5 1f
1f 4e 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fe
00 4e 45 31 36 30 51 44 4d 2d 4e 59 31 0a 01 ed

02 03 1d 00 e3 05 80 00 e6 06 05 01 6a 6a 24 6d
1a 00 00 02 03 3c a5 00 04 6a 24 6a 24 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 27e40534e18b..3504ec00076c 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2013,6 +2013,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0964, &delay_200_500_e50, "NV133WUM-N61"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x096e, &delay_200_500_e50_po2e200, "NV116WHM-T07 V8.0"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0979, &delay_200_500_e50, "NV116WHM-N49 V8.0"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0985, &delay_200_500_e50, "NE160QDM-NY1"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x098d, &boe_nv110wtm_n61.delay, "NV110WTM-N61"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0993, &delay_200_500_e80, "NV116WHM-T14 V8.0"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09ad, &delay_200_500_e80, "NV116WHM-N47"),
-- 
2.34.1

