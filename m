Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E829EF5A8DB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D92510E95B;
	Wed, 22 Apr 2026 08:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="QIiQiyGK";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="uQPt8J6s";
	dkim-atps=neutral
X-Greylist: delayed 436 seconds by postgrey-1.36 at gabe;
 Tue, 21 Apr 2026 15:40:15 UTC
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B8310ED13
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1776785561; bh=fVRhtyjLDHRWXj7cJQzxSuC
 CdVr8YdgSrxsxTmgjANc=; b=QIiQiyGKyKTVI1qfXp/bWKUbqi0Rw5bKIeS14nEycduRWTX9gt
 0gRa2ozCJzPXhOQYA3re90gFQemh5Z95YKSvrME+qVdxkjLpodbQRe2vce2jcZWARvJRxzpDMaR
 xKyMHzGbSsRDNRy/gx1A/nteiTO8MoZLSgEvsh0vtYkBCjk3ZAXgkvunwvyMyybYe5W3G5M7dBL
 Kioon3uBRAzl3YHMw+PJznTCN806kjz+eQJoGgvFLzd6niQFIfSGTBTKE/zVti6rqEPnoADp8fa
 hsdyMx0XSkfyu6fEmM+ipt+Y+ffp4Ez2AZZGmZtbA0TzFRqd+VOIraoAvE3QzrbQbRQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1776785561; bh=fVRhtyjLDHRWXj7cJQzxSuC
 CdVr8YdgSrxsxTmgjANc=; b=uQPt8J6sdZDORmvDmz9e+mfDPQjXTpl/JOmktPfvSsMDZ0oxri
 xQz2J5a8/n0x1Qn2rgPzXiMedtjcWhEPgVDg==;
From: Brady Norander <brady.norander@mainlining.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Brady Norander <brady.norander@mainlining.org>
Subject: [PATCH] drm/panel/boe-tv101wum-nl6: set MIPI_DSI_MODE_LPM after
 sending panel disable cmds
Date: Tue, 21 Apr 2026 11:31:48 -0400
Message-ID: <20260421153147.4378-2-brady.norander@mainlining.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 08:26:51 +0000
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

A recent change to Mediatek drm driver enabled HS mode support. With that
change, my MT8183-based krane sku176 chromebook display's colors would look darker
and desaturated after turning the display off and back on. Looking at other panel
drivers, it seems common to enable HS mode to send the disable commands and to
disable HS mode afterwards. However, the boe-tv101wum-nl6 driver would never
disable HS mode, leading to this issue. Update the behavior of boe_panel_disable
to match those other panel drivers. As a side note, I did also test removing the
line which enables HS mode during panel_disable. This worked fine for my device,
but just in case that doesn't work for other devices, I chose to keep that and
instead disable HS mode after sending the panel disable commands.

Signed-off-by: Brady Norander <brady.norander@mainlining.org>

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index d5fe105bdbdd..f69b5bd776c0 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1326,6 +1326,8 @@ static int boe_panel_disable(struct drm_panel *panel)
 
 	mipi_dsi_msleep(&ctx, 150);
 
+	boe->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
 	return ctx.accum_err;
 }
 
-- 
2.52.0
