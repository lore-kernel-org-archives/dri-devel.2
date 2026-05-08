Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBFACD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 14:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 182E810F505;
	Fri,  8 May 2026 14:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tISLuLba";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E08810F4FD
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 14:46:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FE3F6111B;
 Fri,  8 May 2026 14:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519CBC2BCC9;
 Fri,  8 May 2026 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778251589;
 bh=G4Fkw46u7ywzQfjBZWK+OQ4pewgSnJib5ODBo6YmLF0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tISLuLbaQBDLelBEdX7IcdYPbIse/VEP3PQk32s/c9Sp8ATUJGHrIvuKl/e8u5NrP
 jo6assX84Y8cCs/Dm/Vj3xGPLdT71Yv009DeM5TLVpmq1X02Qn/1DvNeq4+zEEuprH
 CL/nNO2/aCS4sRMZvjrK6WUDWfiJJkEAAPxyfJvu/sPxqPfPB/k+lwtm17SG5TZSxC
 Q/VP/oC4ACaYBbcIglHgsR+HdagqlDWPoLrrzg5llqbbqUOF5aWSjk9UGGfDZ7heH3
 aAyc4QbLW7qA3QsnXPZxpWiF5XepUvNyb3oBD8pz2gCAb23AMIK6EaN088KBrd+uer
 VlndpYkC4pz7g==
Received: from johan by xi.lan with local (Exim 4.98.2)
 (envelope-from <johan@kernel.org>) id 1wLMTC-00000000FZ7-2kkp;
 Fri, 08 May 2026 16:46:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 stable@vger.kernel.org
Subject: [PATCH 3/3] drm/gma500/oaktrail_lvds: fix i2c adapter leaks on init
Date: Fri,  8 May 2026 16:44:46 +0200
Message-ID: <20260508144446.59722-4-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508144446.59722-1-johan@kernel.org>
References: <20260508144446.59722-1-johan@kernel.org>
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

The LVDS init code looks up an I2C adapter using i2c_get_adapter() and
tries to read the EDID before falling back to allocating and registering
its own adapter.

Make sure to drop the references taken by i2c_get_adapter() when falling
back to allocating an adapter as well as on late errors to allow the
looked up adapter to be deregistered.

Fixes: 1b082ccf5901 ("gma500: Add Oaktrail support")
Cc: stable@vger.kernel.org	# 3.3
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/gma500/oaktrail_lvds.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma500/oaktrail_lvds.c
index 983cc60a1e69..e194d0cce067 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
@@ -367,6 +367,8 @@ void oaktrail_lvds_init(struct drm_device *dev,
 	if (edid == NULL && dev_priv->lpc_gpio_base) {
 		ddc_bus = oaktrail_lvds_i2c_init(dev);
 		if (!IS_ERR(ddc_bus)) {
+			if (i2c_adap)
+				i2c_put_adapter(i2c_adap);
 			i2c_adap = &ddc_bus->base;
 			edid = drm_get_edid(connector, i2c_adap);
 		}
@@ -423,6 +425,8 @@ void oaktrail_lvds_init(struct drm_device *dev,
 	mutex_unlock(&dev->mode_config.mutex);
 	if (!IS_ERR_OR_NULL(ddc_bus))
 		gma_i2c_destroy(ddc_bus);
+	else if (i2c_adap)
+		i2c_put_adapter(i2c_adap);
 	drm_encoder_cleanup(encoder);
 err_connector_cleanup:
 	drm_connector_cleanup(connector);
-- 
2.53.0

