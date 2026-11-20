Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B6606A336
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 00:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E73610E51D;
	Fri, 20 Nov 2026 00:03:16 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA07F10E51D
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 00:03:14 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xUC5t-0000000028C-2Pgf;
 Fri, 20 Nov 2026 00:03:10 +0000
Date: Fri, 20 Nov 2026 00:02:59 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hermes Wu <hermes.wu@ite.com.tw>, Pin-yen Lin <treapking@chromium.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v9 06/14] drm/bridge: it6505: bail out of the IRQ handler
 when status reads fail
Message-ID: <ce2a90cbb7a9de693d0b260dcc90572a473c9aab.1795132452.git.daniel@makrotopia.org>
References: <cover.1795132452.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1795132452.git.daniel@makrotopia.org>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When reading the interrupt status registers fails, the negative error
codes end up in int_status[], where it6505_test_bit() sees almost all
bits set: every interrupt sub-handler runs on garbage and the error
values are even written back to the status registers.

Read the three contiguous status registers with a single
regmap_bulk_read() and return IRQ_NONE if it fails. it6505_read()
only adds the powered check on top of regmap_read(), which the
handler has already done. Acknowledge them with a single
regmap_bulk_write() as well, and switch int_status[] and its users to
u8, dropping the casts.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 37 +++++++++++++++--------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 249c616300fde..434a4fa39a911 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2639,12 +2639,13 @@ static void it6505_irq_link_train_fail(struct it6505 *it6505)
 	schedule_work(&it6505->link_works);
 }
 
-static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
+static bool it6505_test_bit(unsigned int bit, const u8 *addr)
 {
 	return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
 }
 
-static void it6505_irq_video_handler(struct it6505 *it6505, const int *int_status)
+static void it6505_irq_video_handler(struct it6505 *it6505,
+				     const u8 *int_status)
 {
 	struct device *dev = it6505->dev;
 	int reg_0d, reg_int03;
@@ -2655,11 +2656,9 @@ static void it6505_irq_video_handler(struct it6505 *it6505, const int *int_statu
 	 */
 
 	if ((!it6505_get_video_status(it6505) &&
-	     (it6505_test_bit(INT_SCDT_CHANGE, (unsigned int *)int_status))) ||
-	    (it6505_test_bit(BIT_INT_IO_FIFO_OVERFLOW,
-			     (unsigned int *)int_status)) ||
-	    (it6505_test_bit(BIT_INT_VID_FIFO_ERROR,
-			     (unsigned int *)int_status))) {
+	     (it6505_test_bit(INT_SCDT_CHANGE, int_status))) ||
+	    (it6505_test_bit(BIT_INT_IO_FIFO_OVERFLOW, int_status)) ||
+	    (it6505_test_bit(BIT_INT_VID_FIFO_ERROR, int_status))) {
 		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
 		flush_work(&it6505->link_works);
 		it6505_stop_hdcp(it6505);
@@ -2684,7 +2683,7 @@ static void it6505_irq_video_handler(struct it6505 *it6505, const int *int_statu
 		return;
 	}
 
-	if (it6505_test_bit(INT_SCDT_CHANGE, (unsigned int *)int_status))
+	if (it6505_test_bit(INT_SCDT_CHANGE, int_status))
 		it6505_irq_scdt(it6505);
 }
 
@@ -2705,35 +2704,37 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 		{ BIT_INT_AUDIO_FIFO_ERROR, it6505_irq_audio_fifo_error },
 		{ BIT_INT_LINK_TRAIN_FAIL, it6505_irq_link_train_fail },
 	};
-	int int_status[3], i;
+	u8 int_status[3];
+	int i;
 
 	if (it6505->enable_drv_hold || !it6505->powered)
 		return IRQ_HANDLED;
 
 	pm_runtime_get_sync(dev);
 
-	int_status[0] = it6505_read(it6505, INT_STATUS_01);
-	int_status[1] = it6505_read(it6505, INT_STATUS_02);
-	int_status[2] = it6505_read(it6505, INT_STATUS_03);
+	if (regmap_bulk_read(it6505->regmap, INT_STATUS_01, int_status,
+			     ARRAY_SIZE(int_status))) {
+		pm_runtime_put_sync(dev);
+		return IRQ_NONE;
+	}
 
-	it6505_write(it6505, INT_STATUS_01, int_status[0]);
-	it6505_write(it6505, INT_STATUS_02, int_status[1]);
-	it6505_write(it6505, INT_STATUS_03, int_status[2]);
+	regmap_bulk_write(it6505->regmap, INT_STATUS_01, int_status,
+			  ARRAY_SIZE(int_status));
 
 	DRM_DEV_DEBUG_DRIVER(dev, "reg06 = 0x%02x", int_status[0]);
 	DRM_DEV_DEBUG_DRIVER(dev, "reg07 = 0x%02x", int_status[1]);
 	DRM_DEV_DEBUG_DRIVER(dev, "reg08 = 0x%02x", int_status[2]);
 	it6505_debug_print(it6505, REG_SYSTEM_STS, "");
 
-	if (it6505_test_bit(irq_vec[0].bit, (unsigned int *)int_status))
+	if (it6505_test_bit(irq_vec[0].bit, int_status))
 		irq_vec[0].handler(it6505);
 
 	if (it6505->hpd_state) {
 		for (i = 1; i < ARRAY_SIZE(irq_vec); i++) {
-			if (it6505_test_bit(irq_vec[i].bit, (unsigned int *)int_status))
+			if (it6505_test_bit(irq_vec[i].bit, int_status))
 				irq_vec[i].handler(it6505);
 		}
-		it6505_irq_video_handler(it6505, (unsigned int *)int_status);
+		it6505_irq_video_handler(it6505, int_status);
 	}
 
 	pm_runtime_put_sync(dev);
-- 
2.56.1

