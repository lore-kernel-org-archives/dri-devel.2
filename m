Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E510CD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 14:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 643C510F506;
	Fri,  8 May 2026 14:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CZincF9m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9072B10F505
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 14:46:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CE6643ABD;
 Fri,  8 May 2026 14:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC36EC2BCF4;
 Fri,  8 May 2026 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778251588;
 bh=2giSI3kqJQB//8Ul4n6V6oSBt4dteqqZbtnY9HL2lmI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CZincF9mC3NmZSqxHHKRkfKONNaSaR+Mm6VKQ0Wyoho14LWeLeH3BvUK7sfhcGVVK
 6kHXC92Ptya1PcIniCqAVsrnmACAiornk/fkc15wSIc0wQWiTxrU+XhxDQqAlFbDMu
 iCRWgyZ9ENGsmExpNIMgzxIxXob6eb47U1nufCyRtIPn6dlLio4m2a/k6CfjJsRIPV
 z99kDT3j3zGDLCH6x1f35pJ1wJv3VsMzuMKrBmgolv9bMcT4Q4UHbDY7tT3FL58Xl5
 ODDZmm7u2OsUnDV1LH+KW9lj9b4QfCJKkhjwTUnyHm9OCFOX8D4mL7aKScU40neoOL
 R05oiK7wvwz2Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
 (envelope-from <johan@kernel.org>) id 1wLMTC-00000000FZ5-2iOV;
 Fri, 08 May 2026 16:46:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 stable@vger.kernel.org
Subject: [PATCH 2/3] drm/gma500/oaktrail_lvds: fix hang on init failure
Date: Fri,  8 May 2026 16:44:45 +0200
Message-ID: <20260508144446.59722-3-johan@kernel.org>
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

The error handling does not separate these cases so on a late init
failure it will try to deregister and free also an adapter that had
previously been registered. Since i2c_get_adapter() takes another
reference to the adapter, deregistration hangs indefinitely while
waiting for the reference to be released.

Fix this by only destroying adapters allocated during LVDS init on
errors.

Fixes: a57ebfc0b4da ("drm/gma500: Make oaktrail lvds use ddc adapter from drm_connector")
Cc: stable@vger.kernel.org	# 6.0
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/gma500/oaktrail_lvds.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma500/oaktrail_lvds.c
index 884d324f0044..983cc60a1e69 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
@@ -293,7 +293,7 @@ void oaktrail_lvds_init(struct drm_device *dev,
 {
 	struct gma_encoder *gma_encoder;
 	struct gma_connector *gma_connector;
-	struct gma_i2c_chan *ddc_bus;
+	struct gma_i2c_chan *ddc_bus = NULL;
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
@@ -421,7 +421,8 @@ void oaktrail_lvds_init(struct drm_device *dev,
 
 err_unlock:
 	mutex_unlock(&dev->mode_config.mutex);
-	gma_i2c_destroy(to_gma_i2c_chan(connector->ddc));
+	if (!IS_ERR_OR_NULL(ddc_bus))
+		gma_i2c_destroy(ddc_bus);
 	drm_encoder_cleanup(encoder);
 err_connector_cleanup:
 	drm_connector_cleanup(connector);
-- 
2.53.0

