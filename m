Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A9606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yr7NyMPk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5529410E20D;
	Wed, 25 Nov 2026 22:25:43 +0000 (UTC)
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3762710E6B0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:25:33 +0000 (UTC)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b3b45597c7so1895310c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795645532; x=1796250332;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AOwnGeEvMBKI7TRyjGtfXvp7wm6CBN9E9DeU964AMeM=;
 b=Yr7NyMPkFwXPhEy+7/FbiMpSrIr+XC/ZJSTIAvM9ZrTPmttr857GsE+q2hJGA6yTmw
 fWTtV3cpcsWRF4w8JBbk9jfznVONGjzODXYfvMLQ9gq31bS23lymXWRbuhcjxC+sEG7L
 mncRG9fCxwtR1PjgS/l64sXwCgA/Ps0fevC4RZunusit3UzaCXyt3x/A82x2eQGTMjdE
 LhtN1cvtyEhqSh54D4o6QLtJdQONcLNvumsw5FeLsjUNL14/fY/6t84qMFXrsHkDUm2a
 c7Kj5kc0wUxxe/ZEXdDpVCFm/X0QN5qdZLxZbz4jeCYVrkFCCdLSqFuOuHMgwVIT2c7t
 rUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795645532; x=1796250332;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AOwnGeEvMBKI7TRyjGtfXvp7wm6CBN9E9DeU964AMeM=;
 b=guHk4CLS2VUnGSBUBIwgiEtblcFzwHf+lfCAm4QIQGNQmx3Vpvdu0c96iN0ojluYfd
 4rbwVUOV76ZeJrfrgQUgJtcHT8yOO/IfS6V2iihyrY4ybuoIasIWKds/zP38iA2RdgHz
 B1CXHUMLgkp0JVEzb6oWHN5izpxjZlnRGDVd2p/cnIgmoUB+C3q3UAcfmED5Hh+uy7Hi
 bxFk9+YffAkv/bqgOUL3obxUd5DT6k9i3k6RE60CTRfGpX3hPHvORljkc8vDVIUkRh76
 uDpR7rGfhky0HIpKqwb0xDClNjmq+ZDqxt5W8/W882U1YU+aryAhoTI/Qy6qi86RT+0X
 WsWQ==
X-Gm-Message-State: APuU4Z/birwnM/cLFyx5vLRxLpRd1LqCO9L5cZEsLH4mjJfLrZYWs4Us
 mu1/Qfr4BsXg0pYY1GNvENMeDRrQsdG/Uk7U58h/DnkxhtfK11TYNp3r+uFbCSVdWaa2c6lTRB9
 GPg==
X-Received: from dldz4-n1.prod.google.com
 ([2002:a05:701b:4184:10b0:1b3:af3d:1632])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ed02:b0:149:50cb:2175
 with SMTP id a92af1059eb24-1b5568fda53mr18476947c88.33.1795645532051; Wed, 25
 Nov 2026 14:25:32 -0800 (PST)
Date: Wed, 25 Nov 2026 22:25:11 +0000
In-Reply-To: <20261125222513.1446099-1-elkin@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261125222513.1446099-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222513.1446099-2-elkin@google.com>
Subject: [PATCH 1/3] drm/sitronix: st7920: Use DMA-safe serialized TX buffer
 for SPI writes
From: Elkin Cruz <elkin@google.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In st7920_spi_write(), u8 reg[CMD_SIZE] is allocated on the stack and
passed directly to spi_write(), violating SPI DMA safety requirements
when CONFIG_VMAP_STACK is enabled or an IOMMU is in use.

Embed an ARCH_DMA_MINALIGN-aligned TX buffer at the end of
struct st7920_device protected by a DRM-managed mutex, and pass
st7920 to st7920_spi_write().

Fixes: 88b09229f34a ("drm: Add driver for Sitronix ST7920 LCD displays")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 43 +++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index 616d83387d31..091e80d8bda5 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -7,9 +7,12 @@
  */
 
 #include <linux/bitrev.h>
+#include <linux/cache.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
@@ -24,6 +27,7 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -86,6 +90,10 @@ struct st7920_device {
 
 	u32 height;
 	u32 width;
+
+	/* Serializes SPI command and GDRAM transfers using tx_buf */
+	struct mutex tx_lock;
+	u8 tx_buf[CMD_SIZE] __aligned(ARCH_DMA_MINALIGN);
 };
 
 struct st7920_plane_state {
@@ -165,16 +173,21 @@ static int st7920_store_others(int cmd, const void *data, u8 *reg)
 	return i;
 }
 
-static void st7920_spi_write(struct spi_device *spi, int cmd, const void *data,
-			     int delay_us, struct spi7920_error *err)
+static void st7920_spi_write(struct st7920_device *st7920, int cmd,
+			     const void *data, int delay_us,
+			     struct spi7920_error *err)
 {
-	u8 reg[CMD_SIZE] = {0};
+	u8 *reg = st7920->tx_buf;
 	int size = 0;
 	int ret;
 
 	if (err->errno)
 		return;
 
+	guard(mutex)(&st7920->tx_lock);
+
+	memset(reg, 0, CMD_SIZE);
+
 	/*
 	 * First the sync bits are sent: 11111WS0.
 	 * Where W is the read/write (RW) bit and S is the register/data (RS) bit.
@@ -190,7 +203,7 @@ static void st7920_spi_write(struct spi_device *spi, int cmd, const void *data,
 	else
 		size = st7920_store_others(cmd, data, reg);
 
-	ret = spi_write(spi, reg, size);
+	ret = spi_write(st7920->spi, reg, size);
 	if (ret) {
 		err->errno = ret;
 		return;
@@ -232,14 +245,14 @@ MODULE_DEVICE_TABLE(spi, st7920_spi_id);
 static void st7920_power_on(struct st7920_device *st7920,
 			    struct spi7920_error *err)
 {
-	st7920_spi_write(st7920->spi, SET_DISPLAY_ON, NULL, 72, err);
+	st7920_spi_write(st7920, SET_DISPLAY_ON, NULL, 72, err);
 }
 
 static void st7920_power_off(struct st7920_device *st7920,
 			     struct spi7920_error *err)
 {
-	st7920_spi_write(st7920->spi, SET_DISPLAY_CLEAR, NULL, 1600, err);
-	st7920_spi_write(st7920->spi, SET_DISPLAY_OFF, NULL, 72, err);
+	st7920_spi_write(st7920, SET_DISPLAY_CLEAR, NULL, 1600, err);
+	st7920_spi_write(st7920, SET_DISPLAY_OFF, NULL, 72, err);
 }
 
 static void st7920_hw_reset(struct st7920_device *st7920)
@@ -257,10 +270,10 @@ static int st7920_init(struct st7920_device *st7920)
 {
 	struct spi7920_error err = {0};
 
-	st7920_spi_write(st7920->spi, SET_BASIC_INSTRUCTION_SET, NULL, 72, &err);
+	st7920_spi_write(st7920, SET_BASIC_INSTRUCTION_SET, NULL, 72, &err);
 	st7920_power_on(st7920, &err);
-	st7920_spi_write(st7920->spi, SET_GRAPHICS_DISPLAY, NULL, 72, &err);
-	st7920_spi_write(st7920->spi, SET_DISPLAY_CLEAR, NULL, 1600, &err);
+	st7920_spi_write(st7920, SET_GRAPHICS_DISPLAY, NULL, 72, &err);
+	st7920_spi_write(st7920, SET_DISPLAY_CLEAR, NULL, 1600, &err);
 
 	return err.errno;
 }
@@ -296,8 +309,8 @@ static int st7920_update_rect(struct st7920_device *st7920,
 			data_array[array_idx++] = line_buffer[j];
 		}
 
-		st7920_spi_write(st7920->spi, SET_GDRAM_ADDRESS, &i, 72, &err);
-		st7920_spi_write(st7920->spi, SET_GDRAM_DATA, line_buffer, 72, &err);
+		st7920_spi_write(st7920, SET_GDRAM_ADDRESS, &i, 72, &err);
+		st7920_spi_write(st7920, SET_GDRAM_DATA, line_buffer, 72, &err);
 	}
 
 	return err.errno;
@@ -309,7 +322,7 @@ static void st7920_clear_screen(struct st7920_device *st7920, u8 *data_array)
 
 	memset(data_array, 0, BYTES_IN_DISPLAY);
 
-	st7920_spi_write(st7920->spi, SET_DISPLAY_CLEAR, NULL, 1600, &err);
+	st7920_spi_write(st7920, SET_DISPLAY_CLEAR, NULL, 1600, &err);
 }
 
 static int st7920_fb_blit_rect(struct drm_framebuffer *fb,
@@ -812,6 +825,10 @@ static int st7920_probe(struct spi_device *spi)
 	st7920->width = ST7920_DEFAULT_WIDTH;
 	st7920->height = ST7920_DEFAULT_HEIGHT;
 
+	ret = drmm_mutex_init(drm, &st7920->tx_lock);
+	if (ret)
+		return ret;
+
 	st7920->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(st7920->reset_gpio)) {
 		ret = PTR_ERR(st7920->reset_gpio);
-- 
2.56.1.839.g22a8290db9-goog

