Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFFA606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=UUew/Oz/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D42D10FA4D;
	Wed, 11 Nov 2026 09:48:56 +0000 (UTC)
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com
 [111.22.67.139])
 by gabe.freedesktop.org (Postfix) with ESMTP id 254CB10E102
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=UUew/Oz/rUrlYEg/mMgL3LFx5lIL74NPwy/xBW4ODKKW6MzaLDaSmx3Xkom7PaFwi0C+DBDjE7XTt
 iOMWaobxzAhJzOyvnKoJ0R/LYggZyCyZd9DHfla86ElY9NcnsvoONKfSl0dKoGQUzhQEnp7VDdeQRX
 cFp+KDhysD2x9GHo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af439fe67e-b3b5d;
 Wed, 11 Nov 2026 17:48:47 +0800 (CST)
X-RM-TRANSID: 2ee16af439fe67e-b3b5d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
 by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af439fdf36-d712c;
 Wed, 11 Nov 2026 17:48:46 +0800 (CST)
X-RM-TRANSID: 2ee36af439fdf36-d712c
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v3] drm/bridge: analogix_dp: Drop dead error check for
 analogix_dp_init_analog_func()
Date: Wed, 11 Nov 2026 17:48:44 +0800
Message-ID: <20261111094845.1673-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

analogix_dp_init_analog_func() cannot fail: since commit 917c8d192ba6ad
("drm/bridge: analogix_dp: don't wait for PLL lock too early") removed
the PLL lock polling loop, the function only performs register writes
and always returns 0.  The error check on its return value in
analogix_dp_set_bridge() is therefore dead code.

Drop the dead check and make the function void.

Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
---
Changes in v3:

- Use the real name "Xiangwu Lai" for the author and in the
  Signed-off-by trailer instead of the account handle, as noted by
  the Sashiko AI review (Developer's Certificate of Origin).

Changes in v2:

- Rework the patch completely.  The v1 fixed the runtime PM reference
  leak on the analogix_dp_init_analog_func() failure path, but as
  noted in the Sashiko AI review that path is unreachable: since
  917c8d192ba6ad ("drm/bridge: analogix_dp: don't wait for PLL lock
  too early") removed the PLL lock polling loop, the function only
  performs register writes and always returns 0.  Instead of keeping
  a fix for an unreachable path, drop the dead error check and make
  the function void.

Link: https://lore.kernel.org/all/20261111080149.1567-1-laixiangwu@cmss.chinamobile.com
Link: https://lore.kernel.org/all/20261030082820.1457-1-laixiangwu@cmss.chinamobile.com
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 +---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 2 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 6df696374..5b1b05d24 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -996,9 +996,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 
 	pm_runtime_get_sync(dp->dev);
 
-	ret = analogix_dp_init_analog_func(dp);
-	if (ret)
-		return ret;
+	analogix_dp_init_analog_func(dp);
 
 	/*
 	 * According to DP spec v1.3 chap 3.5.1.2 Link Training,
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 456059760..440007e22 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -192,7 +192,7 @@ void analogix_dp_set_pll_power_down(struct analogix_dp_device *dp, bool enable);
 void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 				       enum analog_power_block block,
 				       bool enable);
-int analogix_dp_init_analog_func(struct analogix_dp_device *dp);
+void analogix_dp_init_analog_func(struct analogix_dp_device *dp);
 void analogix_dp_init_hpd(struct analogix_dp_device *dp);
 void analogix_dp_force_hpd(struct analogix_dp_device *dp);
 enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index c1344a3f0..3d196cf96 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -351,7 +351,7 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 	}
 }
 
-int analogix_dp_init_analog_func(struct analogix_dp_device *dp)
+void analogix_dp_init_analog_func(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
@@ -372,7 +372,6 @@ int analogix_dp_init_analog_func(struct analogix_dp_device *dp)
 	reg &= ~(SERDES_FIFO_FUNC_EN_N | LS_CLK_DOMAIN_FUNC_EN_N
 		| AUX_FUNC_EN_N);
 	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
-	return 0;
 }
 
 void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp)
-- 
2.50.1.windows.1



