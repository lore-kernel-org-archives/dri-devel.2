Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC490606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rcRj4eNe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F8BE10F2CF;
	Tue, 20 Oct 2026 07:36:09 +0000 (UTC)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6096C10E04F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 17:54:52 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-170135e43c7so792890c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792432492; x=1793037292; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6tvnT4WjayZKEzPxATY6QVNXUD2F/sefS+MOejf1A/0=;
 b=rcRj4eNemC9KYola0Kohf6Aa9T9cLG2KKSlNtLB2ucKXrY1IYt2frBkHPwl5JB5KuZ
 FiJOJZVQsH733wzhGZICvmyEGzi/RsovQqs9yI7lpogU3O/kaLwZifPKo335sOdv/qG8
 bSd80dga0uDyOAfL7FOXi4M+gEnhh3I7sgBBXS5ex/2GnCsuTKcFI4RKhj+OTfFU/S9B
 ScRuoWZC3Zkd3g7TY+V2tvwIPnpJn0GytO9Qzc+wNvYEwpyU8vLHU4JWG1qCWDZrjvn4
 dqFGJeShS1pu8Sy2Rx88koukPqeDaIwDUjKZKC90pPUGhtJuTyKgOqRUeXPOiOVLtPyM
 wkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792432492; x=1793037292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6tvnT4WjayZKEzPxATY6QVNXUD2F/sefS+MOejf1A/0=;
 b=PPkhwVd+pABHi3Dt6SnhFFA01+qrIBJVe9VoS/zqxJ5ZCD/0zoTbs3CJKmIuokS+MO
 fiQ5F4+jr5z/S24uZ5bvxQn7+Pg7f7VI8nQo4uPE1E5pbxZBvUO4MN160IuSb3CWgbWj
 NfSwXwufcDjHOEXE5iZUs/uuzcHzDGxYBGATpY42s2wYDQnu7ssCUVsSKTOYpnxRine1
 mIYouxucWiV1k/EG4yUKc1eEMU2KfaFhEH/gtdCkbl7+H4MdT2Pbl6/Bs609isQj4Qej
 wF/qhiv5ax2VQyldqoYzRXnKZmxJQGTE6S2kQBrwAWqpV9HxfWo1W8iC+aY8bABv7owH
 OCvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+EDsSKYWedNuQpHxnFBjKYVcPKglXKhEmVkSRcGnMOZ1VmRhRdkFyAEvj10a4dSTMRCF51yQCagU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK7MD0Md2fSooUeRNRNQ+mVlOS69lI5xgHyl7C6B1JCmxhZh8Go
 pE8OezPxqkwAS306kuDAiqaRuFPHsS+KOWk3J7M9TDtCMGCUbhzc8D52
X-Gm-Gg: AYBFou1SU+nrCFwx/qQMvTDBvah1UWEG3vRulT9kz6YTGVuLltU4SlmruDHera5zTSW
 UeyVQ0qX04sK81ITW5fmKxRAreGZEL73kLC3e9Xd9AhD+wt6FlSzgHgnSKWsj/hwKrErE5LvDD+
 0FWZz5zRzb7gJmFiEJq+RN3UaIs1pbtiJgoTCkXqtRPC7zmkMzSgDJ4QtiiIbPJYrPXzUzfu8+k
 KskrJYy6gNtQXySpZd6bcHN7R8ST77EBRjahbxsZtVXik0bjUBRbLOlV9RMFx7ClqA4hhK4/I/H
 qQgK6X+OzYC0O/1R+fwN1K6FXXCMTTOqcO1T9a9Y1rDHvdUy1PdWWGYgzXRlQcc4I2NtyL0FWem
 pfoUY0oua5hwAnAqvYFv1a7v00tXydL5M06mKKpm2lyB7YNH4zZSjqE1BUwG+J4MAXUhjN/i0Yt
 H1QUUduGmWmVpexFfGbUIGduX82fsVHXccsTB9o6xjLq4v/0AOgpABRuDgfNjO49XL6yVbk2NUM
 bS8YEnEUy7ESQxWyYrY60c93IqmuQdMFyEIR+sjMmfIG3K4RdFudun0NEk2wqBFai0dDgpQbfAz
 IA6b3jXWGBpG1ucrscpM
X-Received: by 2002:a05:7022:7e88:b0:153:7a27:b7d with SMTP id
 a92af1059eb24-18512c381a4mr17900397c88.20.1792432491313; 
 Mon, 19 Oct 2026 10:54:51 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831c5cb39esm31837697c88.22.2026.10.19.10.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:54:50 -0700 (PDT)
From: Henry Zhang <henryzhang62@gmail.com>
To: henryzhang62@gmail.com, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/vc4: dsi: Recover from a timed-out transfer
Date: Mon, 19 Oct 2026 10:49:29 -0700
Message-ID: <20261019174930.7237-3-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019174930.7237-1-henryzhang62@gmail.com>
References: <20261019174930.7237-1-henryzhang62@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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

Reset the DSI block and its analog front end after a timeout and
restore the configuration programmed in pre_enable, in the same order
as pre_enable: the block is ungated and the AFE released only after
the timings are programmed. Before resetting, wait for the interrupt
handler, so that a late completion interrupt of the timed-out transfer
cannot complete the next one. The timed-out message is not resent, as
it may already have been executed by the peripheral; the error is
returned and the caller decides whether to retry.

This does not prevent the timeouts themselves. With video running,
vc4 does not keep commands within vertical blanking, and transfers can
still time out, sometimes several in a row after a reset. That is a
separate issue.

Tested on a Raspberry Pi 4 (DSI1, 2 lanes, video mode at 120 Hz) with
a panel driver that retries failed reads up to 8 times. Without this
change, the first timed-out transfer left DSI unusable until the
display was switched off and on. With it, 499 of 500 reads with video
running (71 transfers timed out, 58 of them writes, all followed by
working transfers; the remaining read returned the panel's own
timeout status) and 1000 of 1000 reads with video stopped returned
the expected data.

Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---

Notes:
    Changes in v2:
    - Restore the registers in the same order as pre_enable, ungating the
      block only after the timings are programmed (Sashiko review)
    - Call synchronize_irq() before the reset so that a late completion
      interrupt cannot complete the next transfer (Sashiko review)

 drivers/gpu/drm/vc4/vc4_dsi.c | 114 ++++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 5452b72..2d985bc 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -597,6 +597,7 @@ struct vc4_dsi {
 
 	struct completion xfer_completion;
 	int xfer_result;
+	int irq;
 
 	struct debugfs_regset32 regset;
 };
@@ -1170,10 +1171,9 @@ static int vc4_dsi_bridge_attach(struct drm_bridge *bridge,
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
@@ -1358,6 +1358,106 @@ reset_fifo_and_return:
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
+	ret = vc4_dsi_transfer(dsi, msg);
+	if (ret != -ETIMEDOUT)
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
@@ -1727,14 +1827,18 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
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

