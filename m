Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EC8CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB5B10F598;
	Tue, 13 Oct 2026 07:53:12 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D315410E5B8
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 19:03:37 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-3514e7cbbbaso5547727eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791831817; x=1792436617; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H5aK4FPgpgiV4UbCfqX+FC+2NP/WgnHYWZmGMbzi9uU=;
 b=c12gRhAMEcon9sltZDs9ayEYV1ND4nj7HIUea2WFuX2Y40Ue8/kd9gu8cVOXm2v20i
 aEwINnig/FM/n1dawpoQ0XD/99DKuPXjJvcRpTeVrbcgORcV12N+0hMY6IUMs9wMSJ44
 NwQlexkiIdqtkGR6BYKsklZ8+rciWxU5JIy6QvizmFN56qxQqy8/G97F0v/7sIIlMIbr
 1SrBnuhUSmfid/0p52qhSSM30nLvtmoXiIoLhY60mK9WpRdmPK7U6EfENxuRQ0dVdKau
 w9PhKPN4vilslgwf+9wGPFSloFrJo3BwoWdoJ3j3rwjT3oVh3ysi+71CBNNwRlEj+IHD
 yVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791831817; x=1792436617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H5aK4FPgpgiV4UbCfqX+FC+2NP/WgnHYWZmGMbzi9uU=;
 b=aHl2Qw8XXeBpJwf8EjJxEFD47kNl2SVZ4YB5TzogdDlVe31Mh4Yu75tm6t6SB0VCyk
 09LGXt4ww6KZn2Q3Fbq1OZ+7j3fLPTTW4Iv3kS85ePchIFCwOiGU/RUq2hxINhKBfYUE
 e89+IwzBOpCbNIn6FrLARlcculSkWTnHAb5zTs0BUT5yjI2ZD0uBMBuf7bM0BzUnGY1j
 VXHQnU9Zq+wh6pZPMRKYcO+niWEA/ZOhDXSqmALVaisMX75uuJqzL0B0pksyrV68TXqz
 eAungHxBVi7FL9cYR1l/uF/VaSH5FPApcxsQynBfmmeoPus+vy+CKG6bDedci9OiRqSk
 0aKg==
X-Forwarded-Encrypted: i=1;
 AKwUvByETVBbCwToh8Qhbbc42aB8HPBe5AeKb9YFXz4Cm5PF6j0eAqXCznY/31FqzMA7ELZtUf50zwiTh+I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKO71CQuEvcw0gXzgXBhRflF0bGI4GMnOfFGseyRbZcDoEvSocy
 7z4bo0q+6FanfyopT8saSlIBTyyRu5WTAVmRGxLakW5g4zq7I/1le/zg
X-Gm-Gg: AYBFou1Pq5p8oxW2smR68SCjxnWWyiHqXzxZVc6dzEACorv7jZGhP7foTyTrotU8h4W
 H5g6I1bZChI2u6LDGyCFQfJ6MMrPDYUrjIQ7NvKu6+OZGgXDpE/wlWHEIBQQzZT9hAmE4pnyqB8
 5mM4HmFM1GCJscMEacg+csq9cxpGtm6kOEbIVWgaGtb8lrYkHexf17wSHg5C3+yxyQDzfl3GghH
 Vrdfr/lXg2tOtdaMd/N0QM3kkjYMu16HuhduSzdPZEqs0cWPf2rb52KtT3FndQ4iskpl+tTTBF+
 qdDWQhuIuv7kA8HvMZUITXoMAXjEObzOiEMDPdTUTHO7zBtjkoTyLO91fkkQvcYDdDf1x23MMBt
 ukniS/47vfwYMFHUz7fXRm7Y2Kq/+JJRVrftUXcY4EUmhBs0XvbUkRBwMn3no/nZsqtHDjFF/h2
 ziA53ZLy9Sb5IqROx21ZshnGsUBLPFmXzl/6nzQwEWS5khhB6qOMBjCvrDeFcaEldPG5kI15nRP
 SDQGODJddbXlRhpXmuvlFO8RxTx6rPZUM4Yfuw=
X-Received: by 2002:a05:7300:de49:b0:35b:b3fa:40f7 with SMTP id
 5a478bee46e88-35bb3fa4218mr1657633eec.38.1791831816982; 
 Mon, 12 Oct 2026 12:03:36 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb6a279sm35501602eec.30.2026.10.12.12.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:03:36 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/vc4: dsi: Recover from a timed-out transfer
Date: Mon, 12 Oct 2026 12:02:43 -0700
Message-ID: <20261012190249.3167-3-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012190249.3167-1-henryzhang62@gmail.com>
References: <20261012190249.3167-1-henryzhang62@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

When a transfer times out, vc4_dsi_host_transfer() disables the
command, resets the FIFOs and returns -ETIMEDOUT. That is not always
enough: after an LP receive timeout during a read (the peripheral did
not complete the bus turnaround), every following transfer times out
as well, with no interrupt and STAT reading back 0. Only a modeset,
which goes through post_disable/pre_enable, brings the block back.

Reset the DSI block and its analog front end after a timeout and
restore the configuration programmed in pre_enable, so that DSI keeps
working without a modeset. The timed-out message is not resent, as it
may already have been executed by the peripheral; the error is
returned and the caller decides whether to retry.

This does not prevent the timeouts themselves. With video running,
vc4 does not keep commands within vertical blanking, and transfers can
still time out, sometimes several in a row after a reset. That is a
separate issue.

Tested on a Raspberry Pi 4 (DSI1, 2 lanes, video mode at 120 Hz) with
a panel driver that retries failed reads up to 8 times. Without this
change, the first timed-out transfer left DSI unusable until the
display was switched off and on. With it, 499 of 500 reads with video
running (77 transfers timed out, 71 of them writes, all followed by
working transfers) and 1000 of 1000 reads with video stopped returned
the expected data.

Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 92 +++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index c092a1a..3783ff3 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1171,10 +1171,9 @@ static int vc4_dsi_bridge_attach(struct drm_bridge *bridge,
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
@@ -1359,6 +1358,93 @@ reset_fifo_and_return:
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
+	DSI_PORT_WRITE(CTRL, ctrl & ~DSI_CTRL_CAL_BYTE);
+	DSI_PORT_WRITE(HSTX_TO_CNT, hstx_to);
+	DSI_PORT_WRITE(LPRX_TO_CNT, lprx_to);
+	DSI_PORT_WRITE(TA_TO_CNT, ta_to);
+	DSI_PORT_WRITE(PR_TO_CNT, pr_to);
+	DSI_PORT_WRITE(PHYC, phyc);
+	DSI_PORT_WRITE(HS_CLT0, clt0);
+	DSI_PORT_WRITE(HS_CLT1, clt1);
+	DSI_PORT_WRITE(HS_CLT2, clt2);
+	DSI_PORT_WRITE(HS_DLT3, dlt3);
+	DSI_PORT_WRITE(HS_DLT4, dlt4);
+	DSI_PORT_WRITE(HS_DLT5, dlt5);
+	DSI_PORT_WRITE(HS_DLT6, dlt6);
+	DSI_PORT_WRITE(HS_DLT7, dlt7);
+	DSI_PORT_WRITE(PHY_AFEC1, afec1);
+	DSI_PORT_WRITE(CTRL, ctrl);
+	DSI_PORT_WRITE(DISP1_CTRL, disp1);
+	DSI_PORT_WRITE(DISP0_CTRL, disp0);
+	DSI_PORT_WRITE(PHY_AFEC0, afec0 & ~DSI_PORT_BIT(PHY_AFEC0_RESET));
+
+	DSI_PORT_WRITE(STAT, DSI_PORT_READ(STAT));
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
+	vc4_dsi_reset_and_restore(dsi);
+	DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
+
+	return ret;
+}
+
 static const struct component_ops vc4_dsi_ops;
 static int vc4_dsi_host_attach(struct mipi_dsi_host *host,
 			       struct mipi_dsi_device *device)
-- 
2.47.3

