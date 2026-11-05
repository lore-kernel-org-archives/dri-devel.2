Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A8606D80B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fO08qq6s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7669112C7A;
	Fri,  6 Nov 2026 09:19:28 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3C510E13E
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:07:22 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so11791105e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793909241; x=1794514041; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v8EgQl9rPmO32J3WQwpPn6FuQGoxmZBgtbFEiMNkqUg=;
 b=fO08qq6sWlsk4smaq/fcY4V2kDw4YGHPRBqHKgFERwk2lbMT4vOyj0McD/c5/LFSFm
 VEFNYLCGvth0dwgbMQfwJvFLWXed1sdx+rw19PO8zvel/ZKdzTdZIyH94QV9DPnVPSDA
 Fl3lV8j7jsbhwZ3pAwEht2RDYkksTUekWZsDLOwv+ypr/A4zVj8p/xsPqlfXVmnZWpMC
 qtMWQh3WC8bKoqQcIeV+fKQVppV43JaoHLCuvtScumOxfhY84vSEyXOXkk9b2t2xl7F8
 LzBgcCu+BX0jPpacNwMqQjppWR1HSaS+jcUXD/BLjJuaW0sv9I3F9UGU5M5swjDgclc0
 Xjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909241; x=1794514041;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v8EgQl9rPmO32J3WQwpPn6FuQGoxmZBgtbFEiMNkqUg=;
 b=uOK0t7WFsZzawd7N5UuBAyhTOQOFS2xSi9iSBDhPQjXZ6uz7Lv7BWpBcH9EzBYp402
 RC3Yjvneb+9q37ew0tmKGJiuuIvT9G/7Edc7WyWC2WZjuxiX/RB0lmkeU/1RcoAO61EV
 +TX0cViRpcQX00ZJH9rV2rqbh/HVQXeyK2k3Qkkf7YFlza5Xfo8qNaSZV09SVrUi/7ha
 foML0CXlleroCn4SZ9DRbEOH4v5PAFsrvFi4a42v5hcjr596VH48o/pX22gjVnUqhtfU
 xsQJaRIBcf1KFXRnXQi8LsxsEaJNmJguwnaNNNUpEZlRPnC6twCbgYs7aGmGvJZxcC6M
 p1gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCwAlWkjIv62SHybrOMN9dgXQGAATl+jUSehT7IXyTF2ZZWiisEOqqWsilfDIij11K64XstfpgdVM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+WWstpA3iGfFNXFTDT51tKDWga9bhOcTYyDp4IrXN3xQDNj4nO
 B8EZtCZoUcvn+QhvWZnX6bUGDMN/0l63fReQfVR2auHVn4G/EkbjmTKZ
X-Gm-Gg: AYBFou3eXJfOvD0v1h0yzhTT9BnIyjod6SRaB5RVjTozSFcW/zoyYjyG2lV/QNTiZIh
 ECVN3LHOcwh3vMTpWLxduolP+UyIDKj9piK/o/sjEVMXUsu/THvFlJlydxiL7sZ3Q/vZYon1Hw9
 06g8jN2reXOm5VF7bnI8/LOKl0Xb9Rlfdm+kWLziN9Be9X0kMZJ3uy4P24DHaN0aIKtEGTRNy51
 Gf9wCLeKdZRtukkHkC0GeVp5gLAcn1NN4jQC7buBPk8aY0BungPPxBZnR93eKc+8hWgJTj/lJLZ
 sbJyU/82BMsk2uiVxYP8THaaqPy13JFrfcIdKu+KiLL+RMRPPYBwrWtExxJylrGnnw4lExiZx2j
 Kt1jVILLeT3TQ9plR/EGsWFcG/GbJiVmcKa9QWEIAFL8AECsYGUkNtnT1JsrH86cFR361/pG9Ci
 HJypzAH1FcxsohAlByvxq012hFPz2/ZCO7rjEmQowy/Zv0roVU49MfVDIbXnquyn/dJQhoEM83w
 C1i5GKKVUwXNU4Hx+Lc/oHErirg61d85JJbxYUqO5q7TxLedD9W4I3A6fl9JSGG50CSH+CQm5GS
 Ix/KF8OeXxrCmtChRJJrIZkY5pdveguGV+Fxtk0kcaW5LplyLdHmocmsnPhvKhZk0Fll1hbU7Iv
 pVTcS
X-Received: by 2002:a05:600c:4f42:b0:4b2:4b5e:8141 with SMTP id
 5b1f17b1804b1-4b6df4f2304mr3830505e9.9.1793909240484; 
 Thu, 05 Nov 2026 12:07:20 -0800 (PST)
Received: from antoniarch (78-212-29-45.subs.proxad.net. [78.212.29.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b433ebd278sm131671835e9.3.2026.11.05.12.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:07:20 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com, andi.shyti@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, aaro.koskinen@iki.fi,
 andreas@kemnade.info, khilman@baylibre.com, rogerq@kernel.org,
 tony@atomide.com, jmkrzyszt@gmail.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 3/3] i2c: omap: add DMA support
Date: Thu,  5 Nov 2026 21:05:54 +0100
Message-ID: <20261105200556.34240-5-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105200556.34240-2-apokusinski01@gmail.com>
References: <20261105200556.34240-2-apokusinski01@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the TX and RX DMA requests of the OMAP I2C controller.
The DMA transactions are dispatched only if the I2C message size is
a multiple of the configured FIFO threshold and is greater than a
predefined threshold of 8 bytes.

Support for DMA transactions that are not a multiple of the FIFO
threshold can be added in the future using the draining feature.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c | 291 +++++++++++++++++++++++++++++++++-
 1 file changed, 287 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f02d294db42a..59e633c80236 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2003 MontaVista Software, Inc.
  * Copyright (C) 2005 Nokia Corporation
  * Copyright (C) 2004 - 2007 Texas Instruments.
+ * Copyright (C) 2026 Antoni Pokusiński
  *
  * Originally written by MontaVista Software, Inc.
  * Additional contributions by:
@@ -13,10 +14,13 @@
  *	Juha Yrjölä <juha.yrjola@solidboot.com>
  *	Syed Khasim <x0khasim@ti.com>
  *	Nishant Menon <nm@ti.com>
+ *	Antoni Pokusiński <apokusinski01@gmail.com>
  */
 
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -50,6 +54,8 @@
 /* timeout for making decision on bus free status */
 #define OMAP_I2C_BUS_FREE_TIMEOUT (msecs_to_jiffies(10))
 
+#define OMAP_I2C_DMA_THRESHOLD	8
+
 /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
 enum {
 	OMAP_I2C_REV_REG = 0,
@@ -57,6 +63,10 @@ enum {
 	OMAP_I2C_STAT_REG,
 	OMAP_I2C_IV_REG,
 	OMAP_I2C_WE_REG,
+	OMAP_I2C_DMARXENABLE_SET,
+	OMAP_I2C_DMATXENABLE_SET,
+	OMAP_I2C_DMARXENABLE_CLR,
+	OMAP_I2C_DMATXENABLE_CLR,
 	OMAP_I2C_SYSS_REG,
 	OMAP_I2C_BUF_REG,
 	OMAP_I2C_CNT_REG,
@@ -176,12 +186,27 @@ enum {
 
 #define OMAP_I2C_IP_V2_INTERRUPTS_MASK	0x6FFF
 
+struct omap_i2c_dma {
+	struct dma_chan		*chan_rx;
+	struct dma_chan		*chan_tx;
+	struct dma_chan		*chan_using;
+	struct device		*dma_dev;
+	u8			*curr_msg_buf;
+	struct i2c_msg		*curr_msg;
+	dma_addr_t		dma_buf;
+	unsigned int		dma_len;
+	enum dma_data_direction dma_data_dir;
+	struct completion	complete;
+	dma_addr_t		phy_addr;
+};
+
 struct omap_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
 	int			irq;
 	int			reg_shift;      /* bit shift for I2C register addresses */
 	struct completion	cmd_complete;
+	struct omap_i2c_dma	*dma;
 	struct resource		*ioarea;
 	u32			latency;	/* maximum mpu wkup latency */
 	void			(*set_mpu_wkup_lat)(struct device *dev,
@@ -242,6 +267,10 @@ static const u8 reg_map_ip_v2[] = {
 	[OMAP_I2C_STAT_REG] = 0x28,
 	[OMAP_I2C_IV_REG] = 0x34,
 	[OMAP_I2C_WE_REG] = 0x34,
+	[OMAP_I2C_DMARXENABLE_SET] = 0x38,
+	[OMAP_I2C_DMATXENABLE_SET] = 0x3c,
+	[OMAP_I2C_DMARXENABLE_CLR] = 0x40,
+	[OMAP_I2C_DMATXENABLE_CLR] = 0x44,
 	[OMAP_I2C_SYSS_REG] = 0x90,
 	[OMAP_I2C_BUF_REG] = 0x94,
 	[OMAP_I2C_CNT_REG] = 0x98,
@@ -655,6 +684,144 @@ static void omap_i2c_wait(struct omap_i2c_dev *omap)
 	} while (!(stat & mask) && count < 5);
 }
 
+static void omap_i2c_dma_callback(void *arg)
+{
+	struct omap_i2c_dev *omap = (struct omap_i2c_dev *)arg;
+
+	complete(&omap->dma->complete);
+}
+
+static int omap_i2c_dma_xfer(struct omap_i2c_dev *omap, struct i2c_msg *msg)
+{
+	int ret;
+	struct dma_slave_config dma_sconfig = {0};
+	struct omap_i2c_dma *dma = omap->dma;
+	struct dma_async_tx_descriptor *txdesc;
+	struct device *dev = &omap->adapter.dev;
+
+	dma->curr_msg = msg;
+
+	dma->curr_msg_buf = i2c_get_dma_safe_msg_buf(msg, 1);
+	if (!dma->curr_msg_buf)
+		return -ENOMEM;
+
+	if (omap->receiver) {
+		dma->chan_using = dma->chan_rx;
+
+		dma_sconfig.src_addr = dma->phy_addr +
+				(omap->regs[OMAP_I2C_DATA_REG]
+					<< omap->reg_shift);
+		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		dma_sconfig.src_maxburst = omap->threshold;
+		dma_sconfig.direction = DMA_DEV_TO_MEM;
+	} else {
+		dma->chan_using = dma->chan_tx;
+
+		dma_sconfig.dst_addr = dma->phy_addr +
+				(omap->regs[OMAP_I2C_DATA_REG]
+					<< omap->reg_shift);
+		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		dma_sconfig.dst_maxburst = omap->threshold;
+		dma_sconfig.direction = DMA_MEM_TO_DEV;
+	}
+
+	ret = dmaengine_slave_config(dma->chan_using, &dma_sconfig);
+	if (ret < 0) {
+		dev_err(dev, "DMA channel config failed: %d\n", ret);
+		goto err_map;
+	}
+
+	dma->dma_len = msg->len;
+	dma->dma_data_dir = omap->receiver ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+
+	dma->dma_dev = dmaengine_get_dma_device(dma->chan_using);
+
+	dma->dma_buf = dma_map_single(dma->dma_dev, dma->curr_msg_buf,
+				      dma->dma_len, dma->dma_data_dir);
+	if (dma_mapping_error(dma->dma_dev, dma->dma_buf)) {
+		dev_err(dev, "DMA mapping failed\n");
+		ret = -EINVAL;
+		goto err_map;
+	}
+
+	txdesc = dmaengine_prep_slave_single(dma->chan_using, dma->dma_buf,
+					     dma->dma_len,
+					     omap->receiver ? DMA_DEV_TO_MEM :
+							      DMA_MEM_TO_DEV,
+					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!txdesc) {
+		dev_err(dev, "Not able to get desc for DMA xfer\n");
+		ret = -EINVAL;
+		goto err_desc;
+	}
+
+	reinit_completion(&dma->complete);
+
+	dmaengine_desc_set_callback(txdesc, omap_i2c_dma_callback, NULL, omap);
+	ret = dma_submit_error(dmaengine_submit(txdesc));
+	if (ret < 0) {
+		dev_err(dev, "DMA submit failed\n");
+		goto err_submit;
+	}
+
+	dma_async_issue_pending(dma->chan_using);
+	return 0;
+
+err_submit:
+	dmaengine_terminate_sync(dma->chan_using);
+err_desc:
+	dma_unmap_single(dma->dma_dev, dma->dma_buf, dma->dma_len,
+			 dma->dma_data_dir);
+err_map:
+	i2c_put_dma_safe_msg_buf(dma->curr_msg_buf, msg, false);
+	return ret;
+}
+
+static void omap_i2c_dma_cleanup(struct omap_i2c_dev *omap, bool xferred)
+{
+	struct omap_i2c_dma *dma = omap->dma;
+
+	dma_unmap_single(dma->dma_dev, dma->dma_buf, dma->dma_len,
+			 dma->dma_data_dir);
+	i2c_put_dma_safe_msg_buf(dma->curr_msg_buf, dma->curr_msg, xferred);
+}
+
+static void omap_i2c_dma_enable_req(struct omap_i2c_dev *omap)
+{
+	u16 w;
+
+	w = omap_i2c_read_reg(omap, OMAP_I2C_BUF_REG);
+	if (omap->receiver) {
+		w |= OMAP_I2C_BUF_RDMA_EN;
+		omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, w);
+
+		omap_i2c_write_reg(omap, OMAP_I2C_DMARXENABLE_SET, 1);
+	} else {
+		w |= OMAP_I2C_BUF_XDMA_EN;
+		omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, w);
+
+		omap_i2c_write_reg(omap, OMAP_I2C_DMATXENABLE_SET, 1);
+	}
+}
+
+static void omap_i2c_dma_disable_req(struct omap_i2c_dev *omap)
+{
+	u16 w;
+
+	w = omap_i2c_read_reg(omap, OMAP_I2C_BUF_REG);
+	if (omap->receiver) {
+		w &= ~OMAP_I2C_BUF_RDMA_EN;
+		omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, w);
+
+		omap_i2c_write_reg(omap, OMAP_I2C_DMARXENABLE_CLR, 1);
+	} else {
+		w &= ~OMAP_I2C_BUF_XDMA_EN;
+		omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, w);
+
+		omap_i2c_write_reg(omap, OMAP_I2C_DMATXENABLE_CLR, 1);
+	}
+}
+
 /*
  * Low level master read/write transaction.
  */
@@ -664,7 +831,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	struct omap_i2c_dev *omap = i2c_get_adapdata(adap);
 	unsigned long time_left;
 	u16 w;
-	int ret;
+	int ret, use_dma;
 
 	dev_dbg(omap->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
@@ -672,6 +839,14 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	omap->receiver = !!(msg->flags & I2C_M_RD);
 	omap_i2c_resize_fifo(omap, msg->len, omap->receiver);
 
+	/**
+	 * REVISIT: If the message size is not a multiple of the threshold,
+	 * the draining feature must be used.
+	 */
+	use_dma = !polling && omap->dma && msg->len >= OMAP_I2C_DMA_THRESHOLD &&
+		  !(omap->flags & OMAP_I2C_FLAG_NO_FIFO) &&
+		  msg->len % omap->threshold == 0;
+
 	omap_i2c_write_reg(omap, OMAP_I2C_SA_REG, msg->addr);
 
 	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
@@ -692,6 +867,17 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		reinit_completion(&omap->cmd_complete);
 	omap->cmd_err = 0;
 
+	if (use_dma) {
+		ret = omap_i2c_dma_xfer(omap, msg);
+		if (ret) {
+			omap_i2c_reset(omap);
+			__omap_i2c_init(omap);
+			return ret;
+		}
+
+		omap_i2c_dma_enable_req(omap);
+	}
+
 	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
 
 	/* High speed configuration */
@@ -742,8 +928,17 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	 * into arbitration and we're currently unable to recover from it.
 	 */
 	if (!polling) {
-		time_left = wait_for_completion_timeout(&omap->cmd_complete,
-							OMAP_I2C_TIMEOUT);
+		time_left = OMAP_I2C_TIMEOUT;
+
+		if (use_dma)
+			time_left = wait_for_completion_timeout(
+						&omap->dma->complete,
+						time_left);
+
+		if (time_left)
+			time_left = wait_for_completion_timeout(
+						&omap->cmd_complete,
+						time_left);
 	} else {
 		do {
 			omap_i2c_wait(omap);
@@ -753,6 +948,15 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		time_left = !ret;
 	}
 
+	if (use_dma) {
+		omap_i2c_dma_disable_req(omap);
+
+		if (!time_left || omap->cmd_err)
+			dmaengine_terminate_sync(omap->dma->chan_using);
+
+		omap_i2c_dma_cleanup(omap, time_left && !omap->cmd_err);
+	}
+
 	if (time_left == 0) {
 		omap_i2c_reset(omap);
 		__omap_i2c_init(omap);
@@ -1338,10 +1542,70 @@ static struct i2c_bus_recovery_info omap_i2c_bus_recovery_info = {
 	.recover_bus		= i2c_generic_scl_recovery,
 };
 
+static struct omap_i2c_dma *omap_i2c_dma_init(struct omap_i2c_dev *omap,
+					      dma_addr_t phy_addr)
+{
+	struct device *dev = omap->dev;
+	struct omap_i2c_dma *dma;
+	int ret;
+
+	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
+	if (!dma)
+		return ERR_PTR(-ENOMEM);
+
+	dma->phy_addr = phy_addr;
+
+	init_completion(&dma->complete);
+
+	dma->chan_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(dma->chan_tx)) {
+		ret = PTR_ERR(dma->chan_tx);
+		if (ret != -ENODEV)
+			dev_err_probe(dev, ret,
+				      "can't request DMA tx channel\n");
+		goto dma_free;
+	}
+
+	dma->chan_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(dma->chan_rx)) {
+		ret = PTR_ERR(dma->chan_rx);
+		if (ret != -ENODEV)
+			dev_err_probe(dev, ret,
+				      "can't request DMA rx channel\n");
+		goto dma_tx_fail;
+	}
+
+	return dma;
+
+dma_tx_fail:
+	dma_release_channel(dma->chan_tx);
+dma_free:
+	devm_kfree(dev, dma);
+
+	return ERR_PTR(ret);
+}
+
+static void omap_i2c_dma_free(struct omap_i2c_dev *omap)
+{
+	struct omap_i2c_dma *dma = omap->dma;
+
+	dma->dma_buf = 0;
+	dma->dma_len = 0;
+
+	dma_release_channel(dma->chan_tx);
+	dma->chan_tx = NULL;
+
+	dma_release_channel(dma->chan_rx);
+	dma->chan_rx = NULL;
+
+	dma->chan_using = NULL;
+}
+
 static int
 omap_i2c_probe(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*omap;
+	struct resource		*res;
 	struct i2c_adapter	*adap;
 	const struct omap_i2c_bus_platform_data *pdata =
 		dev_get_platdata(&pdev->dev);
@@ -1359,7 +1623,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (!omap)
 		return -ENOMEM;
 
-	omap->base = devm_platform_ioremap_resource(pdev, 0);
+	omap->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(omap->base))
 		return PTR_ERR(omap->base);
 
@@ -1478,6 +1742,22 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
+	if (omap->scheme != OMAP_I2C_SCHEME_0) {
+		omap->dma = omap_i2c_dma_init(omap, (dma_addr_t)res->start);
+		if (PTR_ERR(omap->dma) == -EPROBE_DEFER) {
+			r = -EPROBE_DEFER;
+			dev_err_probe(&pdev->dev, r,
+				      "can't get DMA channels\n");
+			goto err_unuse_clocks;
+		} else if (PTR_ERR(omap->dma) == -ENODEV) {
+			dev_dbg(omap->dev, "DMA setup failed\n");
+			omap->dma = NULL;
+		} else if (IS_ERR(omap->dma)) {
+			r = PTR_ERR(omap->dma);
+			goto err_unuse_clocks;
+		}
+	}
+
 	adap = &omap->adapter;
 	i2c_set_adapdata(adap, omap);
 	adap->owner = THIS_MODULE;
@@ -1523,6 +1803,9 @@ static void omap_i2c_remove(struct platform_device *pdev)
 	if (omap->mux_state)
 		mux_state_deselect(omap->mux_state);
 
+	if (omap->dma)
+		omap_i2c_dma_free(omap);
+
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
 		dev_err(omap->dev, "Failed to resume hardware, skip disable\n");
-- 
2.56.0

