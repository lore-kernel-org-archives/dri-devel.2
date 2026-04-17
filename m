Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5369F436B4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32DEB10E037;
	Fri, 17 Apr 2026 15:55:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fQV/UTXp";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B23A10E037
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:55:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E8901C5C3E8;
 Fri, 17 Apr 2026 15:56:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6AB5C60497;
 Fri, 17 Apr 2026 15:55:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 62381104608CF; 
 Fri, 17 Apr 2026 17:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776441354; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=SC5KgtNDECT79SEhO/TMJ71KVo3cM9lJBIlNAMqtxeg=;
 b=fQV/UTXp0nUT7+ix6awtZKiJq+HkdExUrz305631ArXGBUlMWVa26V+Pf0xWw5eOF+tM4k
 BX726q3b80XLaKEsSkjVhPOUO/QoIB0dUhLWn8TlQEhmIRwLyuGuiasbolgf9uAsNHGeQa
 KfUkTxEXkBMGbOvAdOu89znTc0ehgp37Mniz0QCZ7ABEJxdRa2pd7kVhcpKkajtDHnBfkn
 zZltvf7/Moo2FbwZEhymZ8BB5nxtyviI5/LFl+m1zt3l/Us+q7Fq/9VqZc/yo7/GJjXOaM
 VsbSld06Ax4nBZaK+TbMdGuVbF3a2UnmLdvbceGmtjFVMf539WwXWLzyArCvaQ==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Jyri Sarha <jsarha@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Bajjuri Praneeth <praneeth@ti.com>, kernel test robot <lkp@intel.com>,
 thomas.petazzoni@bootlin.com, Russell King <linux@armlinux.org.uk>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/bridge: tda998x: Use __be32 for audio port OF property
 pointer
Date: Fri, 17 Apr 2026 17:55:44 +0200
Message-ID: <20260417155545.1069280-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>

of_get_property() returns a pointer to big-endian (__be32) data, but
port_data in tda998x_get_audio_ports() was declared as const u32 *,
causing a sparse endianness type mismatch warning. Fix the declaration
to use const __be32 *.

Fixes: 7e567624dc5a4 ("drm/i2c: tda998x: Register ASoC hdmi-codec and add audio DT binding")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604172257.Imo6GOH9-lkp@intel.com/
Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/bridge/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index d9b388165de15..779b976f601c1 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -1762,7 +1762,7 @@ static const struct drm_bridge_funcs tda998x_bridge_funcs = {
 static int tda998x_get_audio_ports(struct tda998x_priv *priv,
 				   struct device_node *np)
 {
-	const u32 *port_data;
+	const __be32 *port_data;
 	u32 size;
 	int i;
 
-- 
2.43.0

