Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8641D606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8Ztr54s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47FBB112065;
	Thu, 29 Oct 2026 07:59:19 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EABC10FD9F
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:46:19 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-369f3e9e431so943341eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793205978; x=1793810778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CeF2vXpdMa1pfvksP6uKJgr0A5M1DsAwpOtlsJ3oJeA=;
 b=b8Ztr54sHj/69WxByb1bqvdW8E8Zm/2548rlu+PusUErOefE0x0seRDqOEiSjN0K4X
 WUDN37K1bImlpWiG+Sx2fTK1ixrue9raAIIYBnlvo2evrFIwiia5tANBPUpkAj6W1aiG
 5KMsLGQXxS2R4iRHIrXhYzIzgIuu09loYIY4ThUpsz7lTYjnTnqmoYGkGjW0S+V5nrek
 Q3BkxA/Eq8MsY2cYSPG6r+GX6ppwPZzGlTH09B8nRA/66Wt2qGIy8dyIkFLxlIH2o6yT
 B3FHxLZJg5SHsPJKHeFGf9hQOELb18ue+a4i4GlroKO260KX55WpLyorvDvfoZKFkXWS
 GYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205978; x=1793810778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CeF2vXpdMa1pfvksP6uKJgr0A5M1DsAwpOtlsJ3oJeA=;
 b=bfIwtorVwdiijHK8cGZOKGmELbwELOco9tTpqP1VXBcoL0sbcihMVU7PDgQidI+eBj
 x4D6e9Yh2NFJoqbQG/76HkGJX2BUwryxWg74Q5RLOlgmzmLDhYB71WeIV+FGIIYt2SLF
 zam9f+jAed7WfSQgnnk1f5dvEu6J1xSYGTt6w9eC5xMUf14BljYESzOg4jZ4JcOWSoC8
 EnCqAUE0+o3y21vIKcmeiU2/wL+UmiBmKZQagfKsP4ETmawangpmycvrzsYcMQIleBr0
 cyAR4EeUzxenLOFvZrfsv/pDi/OSiXP909blyd5acn8fGZiZqanOuPjoQr87kCnI5RoN
 IJzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwM7V4vP8BDfzx8WaXuasXLcyWSG8TK5bMa+gYw63MzYnjngONqgyvCZyezbFuidhYizPeF9mpT3KE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLb+zu58ZuPGhCqRhlzH8BazuLMpEEdNrmSGfZeWwmrtFQdNHKw
 BXI7B0Y3gjb99kALoo7HyqpvyvGWYztvIwkohItXxmN/Zt4p7alyOoZ2
X-Gm-Gg: AYBFou0SjPUx/Jllfti64G1PjGpbvV/pdC+WD5JC2rAQz4HfvMOWCC8GCvk7gS1orUA
 i/aesAk8otxofpfaYjVvRDdtFG7jaNLmaUkSnR45QKiIjGTieUo/2eyPgTrxdiiAyd6yqXClb3n
 fT0fZcrcdRS7/RKDiWe7cv9tLsSmXUAXpeYsr04XgnsHbSXHnoUcQSYNlalwKhwr8s1KbQRrIKN
 6ComJvGWyjxA4uRDzFpi71aILRLFIiencfryJf7cu1GT0Td7Q1Nu0fVXa7Avwm6AY0oi6E42Rkp
 lWgILWp75mS/wvzo6YTlry5YIPbX6TKvCkyrC4XbEvt39hqXUVyijPp1Z0a+JRj77mi26ETDsjL
 KsgRDSjtso1hIa+m0Yet7koL6TeURR7c+OA/ygQRz/bY3F6bphd9qLbp6bOj27FsvV+1NSrJYMu
 rPhIUcamlqCeJcXvZt6580Pjc0u0xjJVGxzqBTIh2ZropVNp/p7BWeAhcFhwvdELq1VinzQTXR9
 zoUgZWoBeEG/HMF8mdXmqgAGZWpkBC/39XQ0myjRmzRs/IHwFZumAAmtID+xTXnTbfNyAYSQZlL
 qd6Hyh4wrRR0TrpEintpcWPYfiqfYc3e71fcHNmCq4/lvj1MsV4K/cSrbvlf6W0gvMbPfLw=
X-Received: by 2002:a05:7300:3b05:b0:369:fe82:8d3f with SMTP id
 5a478bee46e88-36a3002ef31mr138128eec.14.1793205978318; 
 Wed, 28 Oct 2026 09:46:18 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a23908449sm7821964eec.11.2026.10.28.09.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:46:17 -0700 (PDT)
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
Subject: [PATCH v4 4/5] drm/vc4: dsi: Serialize host transfers
Date: Wed, 28 Oct 2026 09:45:29 -0700
Message-ID: <20261028164539.3471833-5-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028164539.3471833-1-henryzhang62@gmail.com>
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
index be9caaf50..3ee6e8e86 100644
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

