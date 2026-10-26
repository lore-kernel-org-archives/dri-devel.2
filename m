Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00D606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JHuCpQk0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903FD10F329;
	Tue, 27 Oct 2026 09:32:01 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D62510E393
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 19:17:00 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-35943f55c06so370196eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793042220; x=1793647020; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b+bGNbnue3tJ58zjsjRmvD5wgIcpWQRHib1cVlgVdWU=;
 b=JHuCpQk0ZAoqRFgv4fqWRru7QLrakJhGRd6SBhX8y95u6arL3bMvppHB3gzvjM4Lrs
 ObwuAeUo+Lv5Bq7IMGsQTqFapXFzpcd6iPJFmvNX7DHQXd6WUIzpOLVG5dPKkcUnLcZX
 uXFeqhJeyO99E7AeowsT9GvAyNlFAum3fiDgiuIFkOOJMYtC3Lzn8x8sg6du3mBVhVnh
 uTX+QA/C0muk9uLCbYJmCgC8lpYmGdTiFubOjs3g+l4ipNP30+c/EaurmTZdJWyPn0E6
 36tBohAHdpy7T+Hx25dA3Kh1DBoYGdjs9Z/ii/IjuWXVPtTSBKLG9gFke3LA0ALJrzbf
 kULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793042220; x=1793647020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b+bGNbnue3tJ58zjsjRmvD5wgIcpWQRHib1cVlgVdWU=;
 b=aJqoiM7QWDFkcIJlvFmBzMBzwmzTmAFOEFw2zjsjHfeDL6QB6+5XmT0IaKMeikjfRY
 p1YDPuCoQc2pieMvfQL1MShfF4o18hiEbGiKDvQ+B5chHyBp83xAlGzgLUsC0MfNdH8N
 Cxi3xxBDkqwUXwpVqwUOyVDfBv1Jiysm1yQ/C2fh5LodnAlsAMjEJdMAqWisrRwf9cQS
 n/i0mCSSdavWFiQRESqUA9ew8I79aPI0QkLYdazSyQ2prxAYfpuG/Cv8iasvitC8FsyP
 4wVWrPKS507ULXiFuDbZ8zE8GyXOCvXyGA1GvXZoDNRX6eKxWcbRN53yA9okNJWoojT+
 zW3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxgajcMAJpHYrdPOolubYDekHmauH5BQO/5eo3GajCXpPmMGnUDjCw2r4Cn2eSMJJPlr8ThB+x77Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLikGhBFEsWkcW+UMz2jb7may9/HIK8ZVFnvHRoSYrYfK9AcRlT
 a1Fg/bdZ384WdlFNL5lndX76qlX6kLdvDaaf7nnZHElc8iz3veGhFTie
X-Gm-Gg: AYBFou3YwPC9NtqK4aHI14R+4UjOj4oJtAYoIa4wLuZHSUYnM6dI8Ia6W/XkakYd93V
 U4A0x5gXEdNWrFY5Nfzt5bs5cRJOmdcUfc/4d6a7rSxzKmPazlo1ekrvxhDTNF/DxRotdJu92cM
 zELm5cloc9jmcsxnEJgo3v4AKJWcK6uL0IAXZwkF0xYuJXwBPVw3XO+GMK7MPAwSk3KIIVAte0N
 VGTy52+a+pjpusZbX87Rl9heqwFwHX9CRILNee1dQI4YpxUtxTEYugwNFqMkz9TXjJt3jEx9Neo
 us0FdjWHsuphWnm76m+G4Grm+zZk5aFvO8fhQldA/zd+oqZKChlS75KZsUD4X3NZQhWsFgiWu32
 Q8v8Q1YJbhx31Y75Q7AxtsuCjh3Uu9M3d+yx9LFdTsZgxX41ioeZUCagSLdfM7k4E8aIbDGICJV
 vWFOJvObf8IFuhOrHbv4KGmUCZBG4U545l9XP8yo5GQacabIOfFIwleVyIfvAjjEh9NM/fg+tTs
 G+QQPLKmKLFidybqVv2fJ3s2pJOWSefxCVO6x3M2QJvAo21RKoQNect0D+yT9sbOedsaIWfzCYi
 niY2I06cIcQyns2AaBTaGw==
X-Received: by 2002:a05:7301:2123:b0:361:cd8f:7422 with SMTP id
 5a478bee46e88-36a0f7617bemr638620eec.9.1793042219444; 
 Mon, 26 Oct 2026 12:16:59 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a01fa4c58sm25348449eec.21.2026.10.26.12.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:16:59 -0700 (PDT)
From: Henry Zhang <henryzhang62@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Henry Zhang <henryzhang62@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] drm/vc4: dsi: Serialize host transfers
Date: Mon, 26 Oct 2026 12:14:57 -0700
Message-ID: <20261026191618.9430-4-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026191618.9430-1-henryzhang62@gmail.com>
References: <20261026191618.9430-1-henryzhang62@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vc4_dsi_host_transfer() fills the command FIFOs and the TXPKT registers
and waits on a single completion without any locking. Two callers
sending at the same time, for example a panel driver and a backlight
update, can overwrite each other's packets. Nothing keeps a transfer
from running while the bridge callbacks reprogram the block either,
for example while pre_enable sets up the PHY timings.

Add a mutex and hold it for the whole host transfer and in the bridge
pre_enable, enable, disable and post_disable callbacks. None of these
callbacks calls into the DSI device, so the lock is never taken
recursively.

Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index face44a23..ea3a6d06b 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -25,6 +25,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/io.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -595,6 +596,11 @@ struct vc4_dsi {
 	 */
 	struct clk *pixel_clock;
 
+	/*
+	 * Serializes host transfers against each other and against the
+	 * bridge enable/disable paths, which reprogram the block.
+	 */
+	struct mutex transfer_lock;
 	struct completion xfer_completion;
 	int xfer_result;
 
@@ -805,6 +811,8 @@ static void vc4_dsi_bridge_disable(struct drm_bridge *bridge,
 	struct vc4_dsi *dsi = bridge_to_vc4_dsi(bridge);
 	u32 disp0_ctrl;
 
+	guard(mutex)(&dsi->transfer_lock);
+
 	disp0_ctrl = DSI_PORT_READ(DISP0_CTRL);
 	disp0_ctrl &= ~DSI_DISP0_ENABLE;
 	DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
@@ -816,6 +824,8 @@ static void vc4_dsi_bridge_post_disable(struct drm_bridge *bridge,
 	struct vc4_dsi *dsi = bridge_to_vc4_dsi(bridge);
 	struct device *dev = &dsi->pdev->dev;
 
+	guard(mutex)(&dsi->transfer_lock);
+
 	clk_disable_unprepare(dsi->pll_phy_clock);
 	clk_disable_unprepare(dsi->escape_clock);
 	clk_disable_unprepare(dsi->pixel_clock);
@@ -891,6 +901,8 @@ static void vc4_dsi_bridge_pre_enable(struct drm_bridge *bridge,
 	unsigned long phy_clock;
 	int ret;
 
+	guard(mutex)(&dsi->transfer_lock);
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
 		drm_err(bridge->dev, "Failed to runtime PM enable on DSI%d\n", dsi->variant->port);
@@ -1148,6 +1160,8 @@ static void vc4_dsi_bridge_enable(struct drm_bridge *bridge,
 	bool debug_dump_regs = false;
 	u32 disp0_ctrl;
 
+	guard(mutex)(&dsi->transfer_lock);
+
 	disp0_ctrl = DSI_PORT_READ(DISP0_CTRL);
 	disp0_ctrl |= DSI_DISP0_ENABLE;
 	DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
@@ -1181,6 +1195,8 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
 	bool is_long = mipi_dsi_packet_format_is_long(msg->type);
 	u32 cmd_fifo_len = 0, pix_fifo_len = 0;
 
+	guard(mutex)(&dsi->transfer_lock);
+
 	mipi_dsi_create_packet(&packet, msg);
 
 	pkth |= VC4_SET_FIELD(packet.header[0], DSI_TXPKT1H_BC_DT);
@@ -1807,6 +1823,7 @@ static int vc4_dsi_dev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct vc4_dsi *dsi;
+	int ret;
 
 	dsi = devm_drm_bridge_alloc(&pdev->dev, struct vc4_dsi, bridge, &vc4_dsi_bridge_funcs);
 	if (IS_ERR(dsi))
@@ -1814,6 +1831,9 @@ static int vc4_dsi_dev_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, dsi);
 
 	dsi->pdev = pdev;
+	ret = devm_mutex_init(dev, &dsi->transfer_lock);
+	if (ret)
+		return ret;
 #ifdef CONFIG_OF
 	dsi->bridge.of_node = dev->of_node;
 #endif
-- 
2.47.3

