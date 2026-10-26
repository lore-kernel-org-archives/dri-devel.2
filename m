Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D88606A325
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mz09J6US
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01F510F339;
	Tue, 27 Oct 2026 09:32:07 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9808B10E398
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 19:17:01 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-35943f55c06so370226eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793042221; x=1793647021; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WdThmBOVOa/w02fpgl/UlhgNCKZr6lsQOjRvfRo8f+I=;
 b=mz09J6USob8lFKmR31aNXkn0t59RbZ9zlH5svWR/dUQIrVrXXwJ18EGUwU7t/UTocA
 9xPyAKOYmholWIvdfnOs6e5GEX2wcqQX/0GtJowbBue+5rr3Fud+nngeerzTH1u1t6o8
 b6UyDhh4toqGymO+8MlcDxXwpUMbkiO1NLktRYESGyQ/pjesNS5YWXRgwq1K8LDpemrT
 /xUuvwDtSSmHy6lNMqLKrV5vvuF2MtzSM7vtlss4CximF9kl4U4HGCeAXp9e2WxDYLRi
 k4P6jtBGV1EACqhfK/itn1PByWWHSvfy0yN5vH0AzDa/OLeoSEBCvIC9SKVo5uMptCgk
 FDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793042221; x=1793647021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WdThmBOVOa/w02fpgl/UlhgNCKZr6lsQOjRvfRo8f+I=;
 b=0Og72i4By/esuDpt5xqXeMx0gZC+7jBMcwNtPYrH0jzRCjGOgKyQb69NxsD8nyeahz
 T7hNIqj/oO6Ir/BhJ0207mscy/yJfl49kRnzzM9AQbqGDrmJ2vwQVQyCzBJvikH4+dgN
 Dvi2RYOoQrcjqwHTnoKNF3aP4zzUqsN/6A96ApzVQyfkZQuNLM+Ofa6TzRa5cM1zY1nk
 DjrdQSe4CLIQ1PhGyR8tnChauMK6v6MaQF1TCoTQfet54WXdb8lwBB1lJfo2PfPDGn0x
 CeraMyaAGtTOtr9MRjaOrDGj9yTQlRZoUiIXGQ2mBsbc+/DgmyO0qRSyx1XQMqTI2GPy
 mqeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUAcuIM9S/DY+p1vNa1fP6Jf0xR54n0sZNxvkx/QAH2n0ycZfEzqeDHqolsTcC+1i/kmscAReW5pA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIdFI2b27tiEg+AaPUgEy+Y9K75Rp+3T4qhChvc77FSYl6yC53C
 hDThA8jBVlT8O2VSviG0TMexP4UdkWe81K8jEYIKR+V8h/JboIhON7JH
X-Gm-Gg: AYBFou0LkOW6hPFzS8hoKZs6fLs2+flmOqE3YejvWwnsYJai4IVm9LZX40BTbHvlMzb
 ROnX1TNSflUbFth0oiAFn14J3TGsBwh1i8FBbMYqJP4XySios1UXQ1g0dcHsTXMso20qluxpSfH
 zabMpZftu6MpvlaTyXWREdFePWUVreMmcR38HelngmXULXrFkB6yfTMBeekQ6gE7ZLSSpBHxky+
 dOsIjK4ThhD6oreWuvZLLPcHX2+mj5PQXCzeiiaJpNhwMkOAIPt6Ql/5aAYq+1qrPidW2mnoJuj
 nOu+Rs/fAZmPEORfih2wCsMxSAkYXBAFV/CPySLq7LmcaUvsObEfI6C8JqLZl05/e8dnnFvZqO1
 67M5GELJx0784QIrzDvEjmsrZ7Kowpe41qL/TYrR2/7l3C1VdWCfnzGHjx0wAD6Aa/5h4TfaLqB
 JQJsUQL1vmibJqQBFcZPRz2G9Ppj0T5MUtsr60I1oHUftO71xXpw7Uw7fSG5r2s1fE0XuzvSeZh
 QqINRX3JqawhxD+/7kCFpWaHRT0p1xjcR4awsNT3bqLoQz7hg0/4sKBDJID/0HOKagIwmFMZT1u
 s7KlaqYzCbrE7nndjD78ZfP7mbGjS5E8JqxuKI2Am8vXtufomtfxasmIJRh4CmYK4PPBGw==
X-Received: by 2002:a05:7300:bf13:b0:369:fa21:ba12 with SMTP id
 5a478bee46e88-36a0f7df5ecmr573256eec.7.1793042220482; 
 Mon, 26 Oct 2026 12:17:00 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a01fa4c58sm25348449eec.21.2026.10.26.12.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:17:00 -0700 (PDT)
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
Subject: [PATCH v3 4/4] drm/vc4: dsi: Recover from a timed-out transfer
Date: Mon, 26 Oct 2026 12:14:58 -0700
Message-ID: <20261026191618.9430-5-henryzhang62@gmail.com>
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

When a transfer times out, vc4_dsi_host_transfer() disables the
command, resets the FIFOs and returns -ETIMEDOUT. That is not always
enough: after an LP receive timeout during a read (the peripheral did
not complete the bus turnaround), every following transfer times out
as well, with no interrupt and STAT reading back 0. Only a modeset,
which goes through post_disable/pre_enable, brings the block back.

Reset the DSI block and its analog front end after a timeout and restore
the configuration programmed in pre_enable, in the same order as
pre_enable: the block is ungated and the AFE released only after the
timings are programmed. Before resetting, wait for the interrupt
handler, so that a late completion interrupt of the timed-out transfer
cannot complete the next one, and mask the interrupts until the AFE is
out of reset: the error interrupts otherwise fire continuously while it
is held in reset. The timed-out message is not resent, as it may already
have been executed by the peripheral; the error is returned and the
caller decides whether to retry.

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
 drivers/gpu/drm/vc4/vc4_dsi.c | 130 ++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index ea3a6d06b..42f50d2ca 100644
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
@@ -1374,6 +1378,114 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
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
+	 * The completion interrupt of the timed-out transfer may still be
+	 * in flight; let it finish so that it cannot complete the next one.
+	 */
+	synchronize_irq(dsi->irq);
+	vc4_dsi_reset_and_restore(dsi);
+	DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
+
+	return ret;
+}
+
 static const struct component_ops vc4_dsi_ops;
 static int vc4_dsi_host_attach(struct mipi_dsi_host *host,
 			       struct mipi_dsi_device *device)
@@ -1743,14 +1855,18 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
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

