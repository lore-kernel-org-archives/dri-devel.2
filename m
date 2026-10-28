Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D989F606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e4f8h41n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D8C112056;
	Thu, 29 Oct 2026 07:59:13 +0000 (UTC)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2357689C68
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 18:18:02 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so2332965c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793211481; x=1793816281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nb1GL7vyuk4wRsFBzPO4BunddjtAlFmqxmKJhxlenVk=;
 b=e4f8h41nsAtx/7IkDJPfXnxPrXg/Ko4ngATu0ZPSeDwfnjGGC3xo3cI5CZA0Tzt62J
 4wH2APl5erfCPrZOzNrocFs5nswfLCcwRAUwoBJIX/51meOi3BV3Ee0T+bdOuwERMIYx
 /fJo29l4jPXnTcAdrMKNvs60mxvKGjylIDHnc+sWZlYg9f+8wozVvnazIADh3xmt+irS
 +/GJhISq7I3AnxqbpKPF83GtJ9hiwqk5c3Wbt0oYKK73fjACc92AVUewSYUS03IM8F9o
 rqAvRMPtBzHRJF9YF2EDJBRQv+JxyxVtilLazJ4Nbih/Uwpk0wbndv9OuVJLbn9jSYd6
 YTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793211481; x=1793816281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nb1GL7vyuk4wRsFBzPO4BunddjtAlFmqxmKJhxlenVk=;
 b=O1rwD7KAAUHFluqJHUaqiGdjxtn1mMF+QYugiNAxIX63cLO+QKEmG2gM1l7CcZ4mQo
 U128dDr2x6go46k2eyaiBe22lgqBOYiuZNRxWXhQIc7BpcAOVW7BLE1/qNCXk6/Du5Sr
 FnExb7wuDM5dengKvCKrtKSZfZ4QqqKKdd0RvtidTCscxmXNlWb2I0myRA6REDa0sGad
 PAi6pJ4cTy/34BDTPv8BqnL+gRcXGQRb70IW9qELcuIDe1+eat9kWdr2dam1Oe5sMNAH
 fiqJ6n2wKC4HmUQojBu/1lvh7xbEMw/oweGywDq4KdxU8UI4UOYLGbFqOLYDKStuU2FL
 efBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBL/f95aMiYRb8t/9mWFYM0IF3YqHtGmjSS2F8UlUpJ6BmaX3QHGFYaRF2avrb1UKzkqdwwiK5Zvg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLknkQV2J00FhgZtvA2Undr1I1o+z6ydQsNQjVo/6Suq/AGhMXb
 9e2OB4WOVJfQPM8QlMCUfbfd7kxq4ISyI3hNn20SS4fmntkg+w04lkwc
X-Gm-Gg: AYBFou1x9QdOhFIwF6J3UaSqj4GJ/48RL46l4oMh9nyYt527wRJV/6yng05v62DHlz3
 SNGTtQa/0Ro/kUknUOXa7xfttaImeR4GmNI6Os6Yo6YrfKWtfmSCXJqGIsYRepNmWdpz+lWwAff
 t/NmJ/BNy9dpDUFBMHhQNmkieKOLvpgCi8+XiE7kYYrvFmNQdgH6Swxpg9MmnpxFC0Aqzw/yAPq
 /O28S+DQlxg1S8MayxYR6nDm57JA+WFQNWJ+O495GrysRnXZ/VyRHL2jdQK9tZm3xdMZ+zjeTaX
 wR3WiP0M0uXvb1HyL5u+NaAImdRmqx9BzB2yyekW3qtll1poZE1oh1Wq92lOTKsXoCuscJrwnia
 +OxBN4BP51TvxOzUVOB34TDpIZGZ4lnYtoVG4f0v0q68L2wlKahJ38ncTIQoMK1S6dmAkvO2Wln
 wwbxxsGHImo1ng+/rjhs5yrHjdw7Idd6ODO39YvO9j6e5nLlSrfT2czBRhW2p5NiuDgDL6FPpaB
 7Towle3W+GeJoyerpZyKNzsZineYMoCqE/ySwvcsfa8EY+DR9pdflAt480Av5jlkV1py7BBqeuZ
 FeuMjm8jH9RfjLO4HolEeZrCmiy/CSxQLlDMg9hjkJXUr4H5mjYQB3k0jFnnawjYmI4w3utbkrA
 VxSDVFD+KgJrq1j2V
X-Received: by 2002:a05:7022:ed07:b0:144:de98:eec1 with SMTP id
 a92af1059eb24-1a6cc90e818mr4693122c88.11.1793211481229; 
 Wed, 28 Oct 2026 11:18:01 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75fdc1031sm7441623c88.19.2026.10.28.11.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:18:00 -0700 (PDT)
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
Subject: [PATCH] drm/vc4: dsi: Serialize register writes through the DMA
 workaround
Date: Wed, 28 Oct 2026 11:17:17 -0700
Message-ID: <20261028181720.3476629-1-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
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

DSI1 on BCM2835/6/7 cannot take register writes from the ARM, so
dsi_dma_workaround_write() stores the value in the single coherent
buffer reg_dma_mem and has the DMA engine copy it to the register.
Nothing serializes these writes. The threaded interrupt handler writes
INT_STAT through the same buffer while process context may be
programming the block (in a transfer, in its timeout path or in the
bridge callbacks), so one write can overwrite the buffer before the DMA
of the other has run, and the wrong value lands in a register.

Take a mutex around the buffer write and the DMA. The writes already
sleep, which is why the handler runs in a thread on this port.

Fixes: 4078f5757144 ("drm/vc4: Add DSI driver")
Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---
Sashiko pointed this out in its review of my vc4 DSI series [1]. The
race is older than the series and not limited to its timeout path, so
I am sending the fix on its own. It applies to drm-misc-next and on top
of the series.

Compile-tested only (arm64 defconfig, DRM_VC4=m, W=1); I have no
BCM2835/6/7 board with a DSI1 panel to run it on.

[1] https://sashiko.dev/#/patchset/20261028164539.3471833-1-henryzhang62@gmail.com?part=5

 drivers/gpu/drm/vc4/vc4_dsi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 5ed3c35ee..b81b46829 100644
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
@@ -562,6 +563,11 @@ struct vc4_dsi {
 	struct dma_chan *reg_dma_chan;
 	dma_addr_t reg_dma_paddr;
 	u32 *reg_dma_mem;
+	/*
+	 * Serializes the register writes through the DMA workaround, which
+	 * all share the single reg_dma_mem buffer.
+	 */
+	struct mutex reg_dma_lock;
 	dma_addr_t reg_paddr;
 
 	const struct vc4_dsi_variant *variant;
@@ -625,6 +631,8 @@ dsi_dma_workaround_write(struct vc4_dsi *dsi, u32 offset, u32 val)
 		return;
 	}
 
+	guard(mutex)(&dsi->reg_dma_lock);
+
 	*dsi->reg_dma_mem = val;
 
 	tx = chan->device->device_prep_dma_memcpy(chan,
@@ -1667,6 +1675,10 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 	if (dsi->variant->broken_axi_workaround) {
 		dma_cap_mask_t dma_mask;
 
+		ret = devm_mutex_init(dev, &dsi->reg_dma_lock);
+		if (ret)
+			return ret;
+
 		dsi->reg_dma_mem = dma_alloc_coherent(dev, 4,
 						      &dsi->reg_dma_paddr,
 						      GFP_KERNEL);
-- 
2.47.3

