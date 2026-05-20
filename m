Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD3ECD5BA6
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 06:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB7CD10F20C;
	Thu, 21 May 2026 06:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=zlab.su header.i=@zlab.su header.b="TkkMweIw";
	dkim-atps=neutral
X-Greylist: delayed 312 seconds by postgrey-1.36 at gabe;
 Wed, 20 May 2026 20:25:25 UTC
Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E6CA10E12A
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 20:25:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5B9F1BFC65; Wed, 20 May 2026 23:20:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
 t=1779308426; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=GtiYqYy+hDzTkXQ5MTlBCwaTo3F691qDupUBTSAssto=;
 b=TkkMweIwvfYkaGipbDFPIyErM9EHlA0yrjgNC3SZIODZpV4NYBNgn5oa7IK3qzaJNS8wnC
 udJFVs78NKbRsWeWsnolvQj+pIYx/XzrYIgS4DeGJddvyqski3z56YV08MhEUtoJIvnm8V
 sDCQt4oOEIsc5Ir4cc1+Cp2LCXypLWOf+hWz7IRlxEo732pEFE3irKf4dw5x86kEJDXgTu
 Nbrd9NJA7m6V9t7R3frP2PuyDb+ZUsm9Y6Lz3tw5zbsKldXQ+SNk0GP+w7YIul1BDXXHnU
 83Zd8P/rIOguEKHzFXnSUMA+K6AqVBP97+RhcorN7vTnUTbeEIQyiGXBgqUmhw==
From: Vladislav Leonov <vlad@zlab.su>
To: mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Vladislav Leonov <vlad@zlab.su>
Subject: [PATCH] drm: panel-orientation-quirks: Add quirk for Chuwi Minibook X
Date: Wed, 20 May 2026 23:19:51 +0300
Message-ID: <20260520201951.9126-1-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 21 May 2026 06:44:53 +0000
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

This adds a DMI orientation quirk for the Chuwi Minibook X notebook.

Signed-off-by: Vladislav Leonov <vlad@zlab.su>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3a218fb592ce..d185bf061385 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -283,6 +283,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Hi10 pro tablet"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
+	}, {	/* Chuwi Minibook X */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "CHUWI Innovation And Technology(ShenZhen)co.,Ltd"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "MiniBook X"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Dynabook K50 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dynabook Inc."),
-- 
2.47.3

