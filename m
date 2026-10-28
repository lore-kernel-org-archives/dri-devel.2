Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E79606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fLK5qeNJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84406112073;
	Thu, 29 Oct 2026 07:59:26 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D606510E6A7
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:46:20 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-36a121bb8c2so1501976eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793205980; x=1793810780; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZvvTNxs/XacaQ2La3iLx1ZfStPcFYBL7y25+anBmgsc=;
 b=fLK5qeNJoQDq14HL/OVeOmP39rf5YZyHokkKTNusI9LOhsHJ6kg02iSqTFo/PTXlZ0
 oDOGomL8/1xN8QEkyGtB2wmwKjj/xNkTDc5BGaNs+IlWi2Awx9/MqrS+612Iy39mRkSI
 N1W9K7rz3CvVTJZXHhZXBCNxHZyWTemlyQy1/YzhglwNP+vrFb454bTlF6S2tDgDOE6m
 upuPGipzdDrz+OKxmWDj3gt72iOhY6uJyy7SFEZl6Dc+2+B7MKM9PfR8vFHwe0VKQ4Zy
 PSR3/9ObdXCK6+erOJD2eX/dhG7paJBXsKSeFiVeXx1yoe+1W+KmgrazBSnWSOxOOkqH
 ordw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205980; x=1793810780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZvvTNxs/XacaQ2La3iLx1ZfStPcFYBL7y25+anBmgsc=;
 b=WxnxgD+wgDWqJup4JTnrvihB+Y0SJAqh2SaLq2ZofY1aZa+nxt+We+NXqWdVI6ZFNL
 YVIpwgVKq7RET/6vPSooWsaMOiTE1tW2WoykZ0dx4jOo5gfCdmvHRRzs3oH98I03GhRN
 p9WbXWMI1mu5XyoMUG8G6IXdNruFeaw+uvv11d6K1cptt5rSTVhCWg+t+8bruoArq5GH
 pxt0qBRPWAZX1dnM3AZ+NXlEw8S1t9nWTUhcit/sSG8jJvp2/KQDz83FdnfdSj2+GI5G
 B6uYy1ha1k6oBMKc3HuuGO/Ce0qP7rU8YRrmKDipUh2lPivYwgz6G868gFCHbzYzHXkL
 3b3A==
X-Forwarded-Encrypted: i=1;
 AKwUvByc/xkiCB9sUCOAojWlpKucAF54jSgDcXraEbA41WiS475DvdnWHBv5PlW8Onb6mSHccvPlgv9vXiU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI7jKYhehs/pr0mhbQ6rHzhAq/hL/mcV72wms6s59RgrturW/2R
 ArCpL1YZ14aau1MHDGtj3/TtlmldV3GNWUb0TgESeY7Vrs4iRdIakWO8
X-Gm-Gg: AYBFou2WgdQQdu86XZB/QqlXnYl7wkIN3QcHvhEacaASQv/e9cWzdeV4eZnVaVr/d2o
 h44PXQeRCtfxX5YHzRwm6Ue0in6JpD6gAg5ycGtMHdaPJTV1FcsxmL4k+vpNifjfF0Xbae6BNTQ
 NzI//f18DtuT5MHGCfgZc6RXEuYeWOs59FZJ4Ug+bC2boa7ZXi2yDtti0INAmVmz6x+JqlnbR6v
 l/9KE+Q13g8hOt9/H4CxujP+ZOZvZzHqnzOKBRUrc+uRvgbT/aHR1wk1/zzqBNoX8XFNLt3SuoJ
 7PmSV/3sC2Bt2TStfmjMM/SgrPFKDTShtWDOO8uiusfuvxrXgM4io1laGaw6aVuLYuV0aYA61S7
 IBIOd6h5wB1rmtd6Qm4539khHrBNCY7nhxjmKFKvQ9t1I5TOpZmTe8VggTxmpZ4rFKN7+TK3sGj
 5jPYHsJS0bvsUKafDT7taX/znGVoPsBa9js/1MnIOg50OWJ+ogsKcoWvdWOaCAy3JcwtlTuUdbj
 gqRXc48hqFbIuJx6winoK8uKZG1VfhT6QAV9+1gnsrx3OT6y+6veUvw7+zfPwl0ZXAJEopg/xHW
 OFMQ1UouPehq1V5e17mAwBo066t7AXf+bFLATrNwqiL6XrFRaE9GTihOkKTfIj+Q3uFzbIw=
X-Received: by 2002:a05:693c:6384:10b0:36a:60f:3e9c with SMTP id
 5a478bee46e88-36a2fc08c95mr168097eec.0.1793205979475; 
 Wed, 28 Oct 2026 09:46:19 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a23908449sm7821964eec.11.2026.10.28.09.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:46:18 -0700 (PDT)
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
Subject: [PATCH v4 5/5] drm/vc4: dsi: Recover from a timed-out transfer
Date: Wed, 28 Oct 2026 09:45:30 -0700
Message-ID: <20261028164539.3471833-6-henryzhang62@gmail.com>
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

When a transfer times out, vc4_dsi_host_transfer() disables the
command, resets the FIFOs and returns -ETIMEDOUT. That is not always
enough: after an LP receive timeout during a read (the peripheral did
not complete the bus turnaround), every following transfer times out
as well, with no interrupt and STAT reading back 0. Only a modeset,
which goes through post_disable/pre_enable, brings the block back.

Reset the DSI block and its analog front end after a timeout and restore
the configuration programmed in pre_enable, in the same order as
pre_enable: the block is ungated and the AFE released only after the
timings are programmed. Keep the interrupt handler out with
disable_irq() until the block is restored and INT_STAT is cleared, so
that neither a late completion interrupt of the timed-out transfer nor
an error interrupt raised during the reset can complete the next
transfer or run in the middle of the reset. Also mask the interrupts
until the AFE is out of reset: the error interrupts otherwise fire
continuously while it is held in reset. The timed-out message is not
resent, as it may already have been executed by the peripheral; the
error is returned and the caller decides whether to retry.

Only do this while the block is enabled. Between post_disable and
pre_enable the clocks are off and there is nothing to restore; a
transfer then times out as before. The transfer lock keeps the
recovery from running in the middle of pre_enable or post_disable.

This does not prevent the timeouts themselves. With video running,
vc4 does not keep commands within vertical blanking, and transfers can
still time out, sometimes several in a row after a reset. That is a
separate issue.

Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 136 ++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 3ee6e8e86..6edda74e1 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -601,8 +601,11 @@ struct vc4_dsi {
 	 * bridge enable/disable paths, which reprogram the block.
 	 */
 	struct mutex transfer_lock;
+	/* The block is powered and configured. Protected by transfer_lock. */
+	bool enabled;
 	struct completion xfer_completion;
 	int xfer_result;
+	int irq;
 
 	struct debugfs_regset32 regset;
 };
@@ -826,6 +829,8 @@ static void vc4_dsi_bridge_post_disable(struct drm_bridge *bridge,
 
 	guard(mutex)(&dsi->transfer_lock);
 
+	dsi->enabled = false;
+
 	clk_disable_unprepare(dsi->pll_phy_clock);
 	clk_disable_unprepare(dsi->escape_clock);
 	clk_disable_unprepare(dsi->pixel_clock);
@@ -1151,6 +1156,8 @@ static void vc4_dsi_bridge_pre_enable(struct drm_bridge *bridge,
 		DSI_PORT_WRITE(DISP0_CTRL,
 			       DSI_DISP0_COMMAND_MODE);
 	}
+
+	dsi->enabled = true;
 }
 
 static void vc4_dsi_bridge_enable(struct drm_bridge *bridge,
@@ -1184,10 +1191,9 @@ static int vc4_dsi_bridge_attach(struct drm_bridge *bridge,
 				 &dsi->bridge, flags);
 }
 
-static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
-				     const struct mipi_dsi_msg *msg)
+static ssize_t vc4_dsi_transfer(struct vc4_dsi *dsi,
+				const struct mipi_dsi_msg *msg)
 {
-	struct vc4_dsi *dsi = host_to_dsi(host);
 	struct drm_device *drm = dsi->bridge.dev;
 	struct mipi_dsi_packet packet;
 	u32 pkth = 0, pktc = 0;
@@ -1195,8 +1201,6 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
 	bool is_long = mipi_dsi_packet_format_is_long(msg->type);
 	u32 cmd_fifo_len = 0, pix_fifo_len = 0;
 
-	guard(mutex)(&dsi->transfer_lock);
-
 	mipi_dsi_create_packet(&packet, msg);
 
 	pkth |= VC4_SET_FIELD(packet.header[0], DSI_TXPKT1H_BC_DT);
@@ -1374,6 +1378,120 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
 	return ret;
 }
 
+/*
+ * Reset the DSI block and its analog front end, then restore the
+ * configuration done in pre_enable. Resetting the FIFOs alone does not
+ * clear the state the block can be left in after a transfer timed out
+ * (e.g. on an LP receive timeout): every following transfer then times
+ * out as well, until the next modeset.
+ */
+static void vc4_dsi_reset_and_restore(struct vc4_dsi *dsi)
+{
+	u32 en = dsi->variant->port ? DSI1_CTRL_EN : DSI0_CTRL_CTRL0;
+	u32 ctrl = DSI_PORT_READ(CTRL);
+	u32 afec0 = DSI_PORT_READ(PHY_AFEC0);
+	u32 afec1 = DSI_PORT_READ(PHY_AFEC1);
+	u32 disp0 = DSI_PORT_READ(DISP0_CTRL) & ~DSI_DISP0_ENABLE;
+	u32 disp1 = DSI_PORT_READ(DISP1_CTRL);
+	u32 hstx_to = DSI_PORT_READ(HSTX_TO_CNT);
+	u32 lprx_to = DSI_PORT_READ(LPRX_TO_CNT);
+	u32 ta_to = DSI_PORT_READ(TA_TO_CNT);
+	u32 pr_to = DSI_PORT_READ(PR_TO_CNT);
+	u32 phyc = DSI_PORT_READ(PHYC);
+	u32 clt0 = DSI_PORT_READ(HS_CLT0);
+	u32 clt1 = DSI_PORT_READ(HS_CLT1);
+	u32 clt2 = DSI_PORT_READ(HS_CLT2);
+	u32 dlt3 = DSI_PORT_READ(HS_DLT3);
+	u32 dlt4 = DSI_PORT_READ(HS_DLT4);
+	u32 dlt5 = DSI_PORT_READ(HS_DLT5);
+	u32 dlt6 = DSI_PORT_READ(HS_DLT6);
+	u32 dlt7 = DSI_PORT_READ(HS_DLT7);
+
+	/*
+	 * Mask the interrupts while the block and its AFE are in reset: the
+	 * error interrupts would otherwise fire continuously.
+	 */
+	DSI_PORT_WRITE(INT_EN, 0);
+	DSI_PORT_WRITE(DISP0_CTRL, disp0);
+	DSI_PORT_WRITE(TXPKT1C, 0);
+	DSI_PORT_WRITE(CTRL, DSI_CTRL_SOFT_RESET_CFG |
+		       DSI_PORT_BIT(CTRL_RESET_FIFOS));
+	DSI_PORT_WRITE(PHY_AFEC0, afec0 | DSI_PORT_BIT(PHY_AFEC0_RESET));
+	/* AFEC reset hold time */
+	mdelay(1);
+
+	/*
+	 * Same order as pre_enable: the block stays gated and the AFE in
+	 * reset until the timings are programmed.
+	 */
+	DSI_PORT_WRITE(CTRL, ctrl & ~(DSI_CTRL_CAL_BYTE | en));
+	DSI_PORT_WRITE(STAT, DSI_PORT_READ(STAT));
+	DSI_PORT_WRITE(PHY_AFEC1, afec1);
+	DSI_PORT_WRITE(HS_CLT0, clt0);
+	DSI_PORT_WRITE(HS_CLT1, clt1);
+	DSI_PORT_WRITE(HS_CLT2, clt2);
+	DSI_PORT_WRITE(HS_DLT3, dlt3);
+	DSI_PORT_WRITE(HS_DLT4, dlt4);
+	DSI_PORT_WRITE(HS_DLT5, dlt5);
+	DSI_PORT_WRITE(HS_DLT6, dlt6);
+	DSI_PORT_WRITE(HS_DLT7, dlt7);
+	DSI_PORT_WRITE(PHYC, phyc);
+	DSI_PORT_WRITE(CTRL, ctrl & ~en);
+	DSI_PORT_WRITE(HSTX_TO_CNT, hstx_to);
+	DSI_PORT_WRITE(LPRX_TO_CNT, lprx_to);
+	DSI_PORT_WRITE(TA_TO_CNT, ta_to);
+	DSI_PORT_WRITE(PR_TO_CNT, pr_to);
+	DSI_PORT_WRITE(DISP1_CTRL, disp1);
+	/* Ungate the block. */
+	DSI_PORT_WRITE(CTRL, ctrl);
+	/* Bring AFE out of reset. */
+	DSI_PORT_WRITE(PHY_AFEC0, afec0 & ~DSI_PORT_BIT(PHY_AFEC0_RESET));
+	DSI_PORT_WRITE(DISP0_CTRL, disp0);
+
+	DSI_PORT_WRITE(INT_STAT, DSI_PORT_READ(INT_STAT));
+	DSI_PORT_WRITE(INT_EN, DSI_PORT_BIT(INTERRUPTS_ALWAYS_ENABLED));
+}
+
+static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
+				     const struct mipi_dsi_msg *msg)
+{
+	struct vc4_dsi *dsi = host_to_dsi(host);
+	u32 disp0_ctrl;
+	ssize_t ret;
+
+	guard(mutex)(&dsi->transfer_lock);
+
+	ret = vc4_dsi_transfer(dsi, msg);
+	/* Only a running block can be reset and restored. */
+	if (ret != -ETIMEDOUT || !dsi->enabled)
+		return ret;
+
+	/*
+	 * Leave the block usable for the next transfer. The message is not
+	 * resent: it may already have reached the peripheral, and only the
+	 * caller knows whether it is safe to repeat.
+	 */
+	disp0_ctrl = DSI_PORT_READ(DISP0_CTRL);
+	dev_warn(&dsi->pdev->dev,
+		 "transfer timed out (stat 0x%08x), resetting DSI\n",
+		 DSI_PORT_READ(STAT));
+	/*
+	 * Keep the interrupt handler out until the block is restored and
+	 * INT_STAT is cleared. The error interrupts are still enabled, and
+	 * a handler running during the reset could complete the next
+	 * transfer, or race with the register writes on DSI1 of the
+	 * BCM2835, where both go through the DMA workaround. disable_irq()
+	 * also waits for a late completion interrupt of the timed-out
+	 * transfer.
+	 */
+	disable_irq(dsi->irq);
+	vc4_dsi_reset_and_restore(dsi);
+	DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
+	enable_irq(dsi->irq);
+
+	return ret;
+}
+
 static const struct component_ops vc4_dsi_ops;
 static int vc4_dsi_host_attach(struct mipi_dsi_host *host,
 			       struct mipi_dsi_device *device)
@@ -1743,14 +1861,18 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 	/* Clear any existing interrupt state. */
 	DSI_PORT_WRITE(INT_STAT, DSI_PORT_READ(INT_STAT));
 
+	dsi->irq = platform_get_irq(pdev, 0);
+	if (dsi->irq < 0)
+		return dsi->irq;
+
 	if (dsi->reg_dma_mem)
-		ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0),
+		ret = devm_request_threaded_irq(dev, dsi->irq,
 						vc4_dsi_irq_defer_to_thread_handler,
 						vc4_dsi_irq_handler,
 						IRQF_ONESHOT,
 						"vc4 dsi", dsi);
 	else
-		ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
+		ret = devm_request_irq(dev, dsi->irq,
 				       vc4_dsi_irq_handler, 0, "vc4 dsi", dsi);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
-- 
2.47.3

