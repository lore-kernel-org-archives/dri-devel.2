Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CF2C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C3A10F313;
	Thu, 16 Jul 2026 13:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IowfboUh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8E710F313
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:23:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 64C7142A88;
 Thu, 16 Jul 2026 13:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F7A1F00A3E;
 Thu, 16 Jul 2026 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784208218;
 bh=DQd5hmt1V3Fks8f3fFFJfaBxLsLUIIZKU1MWSoqMvKE=;
 h=From:To:Cc:Subject:Date;
 b=IowfboUhr8P42HNe1BpcpBM9FTRvF92Ti3r4QpbhkopVRDoCg/nR0M7X4HVOq1uBT
 KhxlmBxfMskfqXpa08SyIyGuh4CWIhbtAjmtaLPREUgfqwZ3Y/J4bC/gMwybLlVNAy
 PYn7XWg0/nt8j3NN7srCJAizVG4tR8e7uBWDe2wquCr0o976ldo9p+T5pE5ulkP4u4
 aoif53t1l4X9rDaI5yor1cfIOR1/oiSuMpestD4LOr95HpNKrmsO3fLCodW0dy5aL+
 cDxC4ESEZAVuK1yNWlXQGy31q5Ten4EDSrKGujkpW3rEYeidfUmIR31mRRzfk0kfxj
 XT6gnwUe7Knuw==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wkM3s-00000006ZBB-0gn1;
 Thu, 16 Jul 2026 15:23:36 +0200
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>
Subject: [PATCH] drm/panel-simple: take i2c adapter module reference
Date: Thu, 16 Jul 2026 15:23:34 +0200
Message-ID: <20260716132334.1565183-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
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

The i2c subsystem currently blocks during adapter deregistration
whenever there are consumers holding a reference.

Switch to using of_get_i2c_adapter_by_node() which also takes a
reference to the adapter module so that an attempt to unload the module
while in use fails gracefully instead of blocking uninterruptibly.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c09bf3db5e78..f58e83aa4ebe 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -701,7 +701,7 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
 
 	ddc = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
 	if (ddc) {
-		panel->ddc = of_find_i2c_adapter_by_node(ddc);
+		panel->ddc = of_get_i2c_adapter_by_node(ddc);
 		of_node_put(ddc);
 
 		if (!panel->ddc)
@@ -746,7 +746,7 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
 	pm_runtime_disable(dev);
 free_ddc:
 	if (panel->ddc)
-		put_device(&panel->ddc->dev);
+		i2c_put_adapter(panel->ddc);
 
 	return ERR_PTR(err);
 }
@@ -791,7 +791,7 @@ static void panel_simple_remove(struct device *dev)
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 	if (panel->ddc)
-		put_device(&panel->ddc->dev);
+		i2c_put_adapter(panel->ddc);
 }
 
 static const struct drm_display_mode ampire_am_1280800n3tzqw_t00h_mode = {
-- 
2.54.0

