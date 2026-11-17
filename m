Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A71606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sjgHCxwr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07AA510EBCF;
	Wed, 18 Nov 2026 08:23:24 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3B410E6B9
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:00:59 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-380b40319bdso573388eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794949258; x=1795554058; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OljbLO0o7fbYwnjA2PLLGVcm6yo2I+s32YKKod0cYck=;
 b=sjgHCxwr13I1H/Oxm6571lcUlQNlnQe6Ombj07BRvkvRpx/HWUbBQLe7WvsZFmVHho
 WPqIeU6sQPSSf1JnAUhHPQ/PWKPe00w2y0VtrImS5KTeJUwzBkoeG3QJBQ20rrrAn0dv
 Hw6pR0BwnJe6TjTU2c+J+EYqeVfKp7gQfzAp7lCTHWePiNbng+4GbP9Q1KJCPUM6txOc
 pARmJQjaguYrjJNnigmWcFHtC/Ms6Q1xLBx6m9UcQhi+2smJUKLSFY9ASxVSf7uHKs41
 EO65Oyd2QLBI6DKP+B2oC6wnDylut9iLD9SKefED5MEU6BJTh9Wa8qh07faxtEbVMTWL
 POXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794949258; x=1795554058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OljbLO0o7fbYwnjA2PLLGVcm6yo2I+s32YKKod0cYck=;
 b=tZspDDTL2pc9Qy278mYRn2dIixSQ4yICdCDJtrudWo/yMA4fMLzL1SFIqtFNjtPe/c
 Duq85PqGnYnO90wt4lmBbeLYt0Hmt7wVt1xsFAU9qTnRa2mjO7Vz57D/tDffbdnH4Dl5
 TRw0Mzx6J4kBFgWxBN1UvvJeeX/TsGeyAJahn7FFbNTYDAOHCyBC2uJezUpKCEqYb2Km
 dp7u+vKei2euYhdqOI52DwlF1HKuMRcyxwWJqirs6VoOG3BsraEN3icC94KYYWWByigg
 kKZT+UyiUwMSAUQ4b/qz/udKxvoePhaD5F4PJL/t/CHiDGhzw6hseCTvx9EBq49nPVHa
 3Esg==
X-Forwarded-Encrypted: i=1;
 AL+hErED1oQiwmsfYkp+oU//O6NAnSXKQteeRkVjPr/rxspXjLcUGHmWWGpz/YiGjOZ7Foihp/ITzlJcTuo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9v2W/Fm1r5Z05vKF35mJQL5Pu5HOsB7514sCQ3JCvWfFGKDHS3
 R+HZVtf7EEuVuAX8NFnY/jy0P6BmoOFY8ygb59FyjGqqVIXeCLoOkb6c
X-Gm-Gg: AZFdTZdvcSiZHvTPQNeMB7w+4J1duFwYTSDBNfBkgwgxSh7AfQHJ9pJqcei6mPcwZDx
 xPM6D3k+HuXwhoq5eR2h3ugKNzMdhf5KX2bgsofxRnuRbOysoEl+qafn7PVDc3yHv1takSRVMFu
 0D0vYYEWMQcVb2mI0LSOqQ6LKFEgGq0m0ph1RyQFvuVgj7NyYcUUqlI4u4sr11mMq674oI0Lr1N
 XwBveUiHVNJyPfVEo1UBz9O7qOOW3F015s88fDf9J3W+KykylAdzo6RJDpb0MTZ1rVIoMWUoD1S
 WqXMqOHG/4k7WcOcAFj7lbgv0hnMTdWgek0UIC8nOAhg5VGCq2LM9m0e6XQ3h30ofVkr0C4BlQi
 ZpuBSaO7lCfSEusgc1Fiw5xgMIdPy7ByOqAdWsFTvsu8L0pC+qE47Gkdr5GEgcoHgGo6gN9Ee4j
 dcx4clvc45CmFVEW6Yg0+S2cQ8WxyOGVzd2x75b5lVgSTFqrUEwct4ObRLY8eNWmT0LMbq5iUXo
 k1j9hzrxhIjfxySLx7UFG0sfnjPTSJtgX/K4hataWUj3kB2KWWYawrVQTnljjKPWWitJvOUbauW
 mPFGaRWJnuRe1PoGKzbiDmlYIU0GVJj/Ri+mcsyiROE8dgNXtl0rAEG75YuA0SMcoPIytLRRNm0
 pv21t/11aF1JQC3/T
X-Received: by 2002:a05:7301:4712:b0:35e:f4ac:5f8e with SMTP id
 5a478bee46e88-3827a312061mr456032eec.0.1794949258014; 
 Tue, 17 Nov 2026 13:00:58 -0800 (PST)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a6800338sm665842eec.11.2026.11.17.13.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 13:00:55 -0800 (PST)
From: Henry Zhang <henryzhang62@gmail.com>
To: mripard@kernel.org,
	dave.stevenson@raspberrypi.com,
	mcanal@igalia.com
Cc: kernel-list@raspberrypi.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vc4: dsi: Allocate the encoder per DRM device
Date: Tue, 17 Nov 2026 12:59:02 -0800
Message-ID: <20261117205902.1293962-1-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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

The DSI encoder is embedded in struct vc4_dsi, which lives as long as
the DSI platform device, but it is initialised with drmm_encoder_init()
and so is only cleaned up when the DRM device is released. The DRM
device can outlive the unbind of the vc4 components: unloading the DSI
panel driver detaches from the DSI host, which deletes the DSI component
and unbinds the whole vc4 DRM device, but a compositor that keeps the
DRM device open keeps it alive.

If the panel driver is loaded again before that, the new DRM device
binds the DSI component and calls drmm_encoder_init() on the encoder
that is still on the old DRM device's encoder list. The old device's
release later cleans it up from under the new one. On a Raspberry Pi 4
with a 6.18-based kernel, closing the old DRM device then gave:

  WARNING: drivers/gpu/drm/drm_encoder.c:214 at drmm_encoder_alloc_release+0x30/0x40 [drm]
  Call trace: drmm_encoder_alloc_release <- drm_dev_put <- drm_gem_dmabuf_release <- __fput
  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
  pc : drm_mode_config_cleanup+0x5c/0x2f0 [drm]
  Call trace: drm_mode_config_cleanup <- drm_managed_release <- drm_dev_put

Allocate the encoder in bind with drmm_encoder_alloc(), so each DRM
device has its own and releases only its own. The DSI bridge is still
shared: while the old DRM device holds it, drm_bridge_attach() in the
new bind fails with -EBUSY, so binding again before the old DRM device
is released now fails cleanly instead of corrupting both devices.

The analysis, this change and this description were prepared with the
help of an AI coding assistant (Claude Code).

Fixes: 6f0ca506c30e ("drm/vc4: dsi: Switch to DRM-managed encoder initialization")
Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---
Testing:

- On this base (drm-misc-next 467ac0b56aeb): compile-tested only,
  arm64 defconfig with DRM_VC4=m, W=1, no new warnings.

- A backport to a downstream Raspberry Pi 6.18.34 kernel, on a
  Raspberry Pi 4 with an out-of-tree modular DSI panel driver: with the
  compositor stopped and a process holding /dev/dri/card1 open, unload
  the panel driver and load it again. The bind now fails cleanly:

    vc4-drm gpu: failed to bind fe700000.dsi (ops vc4_dsi_ops [vc4]): -16
    vc4-drm gpu: adev bind failed: -16

  the panel probe fails with -16, and there is no warning or oops,
  also when the holder then closes the old DRM device. Unloading and
  loading the panel driver again after that brings back the display
  and the compositor. Without the change, the same kernel gave the
  warning and oops above. The backport differs from this patch in two
  ways: that kernel still gets the panel bridge with
  drmm_of_get_bridge(), which has a use-after-free of its own in this
  sequence, so the test kernel used devm_drm_of_get_bridge() instead
  (not needed here, where the panel bridge is refcounted); and a
  downstream DSI restart worker that used the embedded encoder now
  follows a pointer to the current one.

The -EBUSY is final: the panel probe is not retried when the old DRM
device goes away, so the panel driver has to be loaded again. Would you
prefer the DSI host to wait for the old DRM device to be released
before adding its component again, or a bridge allocated per bind?

Not addressed: a connector probe that is already running when the
panel is removed can still call into the panel driver.

This applies to drm-misc-next on its own. It also applies on top of my
"drm/vc4: dsi: Serialize register writes through the DMA workaround",
and it does not touch the code changed by my vc4 DSI series
<20261028164539.3471833-1-henryzhang62@gmail.com>.

Tools: Claude Code (an AI coding assistant) analysed the crash logs and
the vc4/DRM lifetimes, located the introducing commit, wrote the change
and this description, built and checkpatch-checked it, and ran the
backport test on the board, at my request.

 drivers/gpu/drm/vc4/vc4_dsi.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index ec008f766..5bd8f579b 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -546,9 +546,18 @@ struct vc4_dsi_variant {
 
 };
 
+/*
+ * The encoder of one DRM device. The DRM device can outlive the unbind of
+ * this component, so a later bind must not reuse the encoder of an earlier
+ * one: allocate one per bind, managed by the DRM device.
+ */
+struct vc4_dsi_encoder {
+	struct vc4_encoder base;
+	struct vc4_dsi *dsi;
+};
+
 /* General DSI hardware state. */
 struct vc4_dsi {
-	struct vc4_encoder encoder;
 	struct mipi_dsi_host dsi_host;
 
 	struct platform_device *pdev;
@@ -601,7 +610,7 @@ struct vc4_dsi {
 	container_of_const(host, struct vc4_dsi, dsi_host)
 
 #define to_vc4_dsi(_encoder)					\
-	container_of_const(_encoder, struct vc4_dsi, encoder.base)
+	(container_of_const(_encoder, struct vc4_dsi_encoder, base.base)->dsi)
 
 #define bridge_to_vc4_dsi(_bridge)				\
 	container_of_const(_bridge, struct vc4_dsi, bridge)
@@ -1626,7 +1635,8 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = dev_get_drvdata(master);
 	struct vc4_dsi *dsi = dev_get_drvdata(dev);
-	struct drm_encoder *encoder = &dsi->encoder.base;
+	struct vc4_dsi_encoder *dsi_encoder;
+	struct drm_encoder *encoder;
 	int ret;
 
 	drm_bridge_get(&dsi->bridge);
@@ -1637,9 +1647,6 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 
 	dsi->variant = of_device_get_match_data(dev);
 
-	dsi->encoder.type = dsi->variant->port ?
-		VC4_ENCODER_TYPE_DSI1 : VC4_ENCODER_TYPE_DSI0;
-
 	dsi->regs = vc4_ioremap_regs(pdev, 0);
 	if (IS_ERR(dsi->regs))
 		return PTR_ERR(dsi->regs);
@@ -1758,12 +1765,16 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	ret = drmm_encoder_init(drm, encoder,
-				&vc4_dsi_encoder_funcs,
-				DRM_MODE_ENCODER_DSI,
-				NULL);
-	if (ret)
-		return ret;
+	dsi_encoder = drmm_encoder_alloc(drm, struct vc4_dsi_encoder, base.base,
+					 &vc4_dsi_encoder_funcs,
+					 DRM_MODE_ENCODER_DSI, NULL);
+	if (IS_ERR(dsi_encoder))
+		return PTR_ERR(dsi_encoder);
+
+	dsi_encoder->dsi = dsi;
+	dsi_encoder->base.type = dsi->variant->port ?
+		VC4_ENCODER_TYPE_DSI1 : VC4_ENCODER_TYPE_DSI0;
+	encoder = &dsi_encoder->base.base;
 
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)

base-commit: 467ac0b56aebc804360f276feffbc9032c265a6e
-- 
2.47.3

