Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EA7606A321
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=daC0Yrz9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DAF7112759;
	Fri, 30 Oct 2026 11:22:07 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6595D11275D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:22:01 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so3334215e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793359319; x=1793964119;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vuufPDmq8YPQW8AY0Jp/JU0SY6cRQYf0nWENHHY4ooc=;
 b=daC0Yrz9agMN/hilqhsSTk+XvSbNB1wZr/nPKpsAStO94Dx8d/0EFTY9uaxVkCacgn
 w+2s/dPU9nqzZTj4zSya/5ZtxqCUWiJPa34nbeRQ2T7OzXr2blLhy9/yMtGryE3EmOlF
 ptFf2VPM9XcwKD0cqiDHjxD/q0dK5VPTXCDad1zE7iOJlSiQI4phxdhpwg+WCI5LCM0/
 N/zFqi1j6T2BGxfNpYYYGfgsYfM3iNh86yoyw/g2zYqucFeFP1niKY1kLkdX03ZYd3hx
 2PbWJtMt6W6X+UokYM1zJROig5xkfn061NNzIJNS6X98C7Oo6RyNIAwQK/DuMPUhxInS
 sAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359319; x=1793964119;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vuufPDmq8YPQW8AY0Jp/JU0SY6cRQYf0nWENHHY4ooc=;
 b=HMc8taCMPGn362KADz2tbT+TEHbHsrVkSCFkCJe2nuUiWTfIbA5HcFT58n5sVcuFTy
 UKUP8Gpc3vkwwcikfCuHh26V2O7zxBufPSkyvTFlK6ubTlyaJ7PWvNJ6AF5bx1ybGr1i
 lAfI+qf+yFFKzfMMs8S8QU8EHqBK6FIZvlJ0SyNTeGwmoejUpNHIiSI5oXVDPbMmIFpr
 skd0uTPc87GikLTT3V0u35xBTAXAtqmmW3FjnqfYUb6p5pOnRUuC1jHpKDyddgwva4hO
 roDXj6MD4sLOcMWxnEn1/ewwBfpXSOMPIjE/rr2qq7JRCF8xHzLOvrRcPOboHrZnRFTQ
 6yTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHZjpwV6ZZto4dSER75WzELf2pHUfb1Ekn4MfjxnrMlXGHkyREO7QX9038fXEkrBbQreChUv99g04=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKYPGLYxIfSSa9xqlg8LDbM5C/8dfMA00n1sD3Cl1SeDXCU8osr
 tuSYUVMkcmkH35Fk4SmgrA1ufofYA3bZEYB27F/Dkgc42qWrwyyHKDjcMp6V5P76sa8=
X-Gm-Gg: AYBFou2cCvggj8NBoyyE9w4I5G7GOqKwg0KVlCbqcw7EcKnb2G3R+CZcuIGwp2rZg3D
 2ScuoFoL+yQBXOx03aqvX+eV5VYiUpJYjrHJdOe6A5gQ2zMeBG1slLNUtm+BjSoVb8l+lnri/3b
 rJERWFbhRMjmalCLUaXf9DTtJTaedT08zF+zwXOVDsKLZ4bSTrkr+zoPX/EIRy5TYZgSv/FNTj9
 hTZnlFC0ibCCfXNoDm3M1cKAFkFBNBsyCGiGol1vd9k3BcKAWzvPWcVLAuJs27eYMvWj0Re4iVO
 rplFRNlRgSUaZEL3bjXEFD6soz7gA5672P31jIPQrL1hZjt9n6YxJ/PI+8GffQQP+po+HX618tE
 r9pOsOMH1iDHIfO6bySCio2KhQASIiELM2IO2rLs87CknK9+iQsgVZFWX2h+XEosyzOYNB/FuRG
 HnGHcOfb9Py8vCjeOB5KwlucOsmCWouofAkqg0ystSEqlKkduJx0r333GY3gYY4W965OodMr5tF
 8lQ8wqkyd4YShoFf9GixDx7iicDRtmh14+8kX/l0GSnmMKMkLxHCdECE5bHoYmLSYhb9RJpTmVI
 pPgOYhelf4A8yf9E/FBhzYPHSpFkpJSwFTkSv2Gcz+/YaNZl
X-Received: by 2002:a05:600c:8b06:b0:4a8:9a2f:d27 with SMTP id
 5b1f17b1804b1-4ac17b2c907mr39680395e9.25.1793359319469; 
 Fri, 30 Oct 2026 04:21:59 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3f9sm2939706f8f.4.2026.10.30.04.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:21:58 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 30 Oct 2026 12:20:47 +0100
Subject: [PATCH] drm/etnaviv: hold the core in reset while runtime
 suspended
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-etnaviv-rpm-reset-v1-1-f45761846329@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCQAxG4auUrA10YqvoVaSLdvzVCI4lGQeh9
 O6OuvwW7y3kMIXTsVnIUNT1mSrCpqF4G9MVrOdqklZ2oZUtI6exaGGbH2xwZO6kP0wS+7CPHdV
 uNlz0/Xuehr/9Nd0R83dE6/oBkhDNx3UAAAA=
X-Change-ID: 20261023-etnaviv-rpm-reset-4259b2c517c4
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Simon Lenain <simon.lenain@thalesgroup.com>, 
 LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5557; i=jbrunet@baylibre.com; 
 h=from:subject:message-id;
 bh=68/E5Cj9ssNc1McLhgmPI5778X5fLNH57nbXqLBBDGo=; 
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFlPaq/OqfR1uf6k/7KK+7GH+9tTdi5ZPf3CqxV8E+8r5
 lyU2fVHv6OUhUGMi0FWTJGlhrta/J2k1pdZ03Vuw8xhZQIZwsDFKQAT2XOT4X+ytdRJDcbMxxXn
 l6bdydN3uPrGLfZip+vhOfxp83o15s1h+F+TrXpzX+x8ZllvHqfIdO2dC+Ru7EwKWKubtu5gbfc
 NR04A
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The reset is asserted at probe and released once, in etnaviv_gpu_init(),
and is never asserted again. Runtime suspend only stops the clocks, and the
power domain may then cut power to the core. On the next runtime resume,
the domain powers the core up again while the reset is still deasserted.

On the Amlogic A311D NPU, the power domain lifts isolation on a core that
is out of reset, which locks up the SoC on the first runtime resume after
a runtime suspend. Toggling the reset again solves the problem.

From an existing comment in the driver, the reset must be deasserted with
the clock running, so handle it together with the clocks. Rename the clock
helpers accordingly, as they now handle the reset as well. This way the
reset is properly handled whether or not CONFIG_PM is enabled.

Fixes: 6bde14ba5f7e ("drm/etnaviv: add optional reset support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
This was found while running the MobileNetV1 demo with Teflon on the
Khadas VIM3 (Amlogic A311D).
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 64 +++++++++++++++--------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index e75dab5e407d..b372f454f676 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -175,29 +175,6 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
 	return 0;
 }
 
-static int etnaviv_gpu_reset_deassert(struct etnaviv_gpu *gpu)
-{
-	int ret;
-
-	/*
-	 * 32 core clock cycles (slowest clock) required before deassertion
-	 * 1 microsecond might match all implementations without computation
-	 */
-	usleep_range(1, 2);
-
-	ret = reset_control_deassert(gpu->rst);
-	if (ret)
-		return ret;
-
-	/*
-	 * 128 core clock cycles (slowest clock) required before any activity on AHB
-	 * 1 microsecond might match all implementations without computation
-	 */
-	usleep_range(1, 2);
-
-	return 0;
-}
-
 static inline bool etnaviv_is_model_rev(struct etnaviv_gpu *gpu, u32 model, u32 revision)
 {
 	return gpu->identity.model == model &&
@@ -842,12 +819,6 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 		goto pm_put;
 	}
 
-	ret = etnaviv_gpu_reset_deassert(gpu);
-	if (ret) {
-		dev_err(gpu->dev, "GPU reset deassert failed\n");
-		goto fail;
-	}
-
 	etnaviv_hw_identify(gpu);
 
 	if (gpu->identity.model == 0) {
@@ -1649,7 +1620,7 @@ static irqreturn_t irq_handler(int irq, void *data)
 	return ret;
 }
 
-static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
+static int etnaviv_gpu_clk_rst_enable(struct etnaviv_gpu *gpu)
 {
 	int ret;
 
@@ -1669,8 +1640,26 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
 	if (ret)
 		goto disable_clk_core;
 
+	/*
+	 * 32 core clock cycles (slowest clock) required before deassertion
+	 * 1 microsecond might match all implementations without computation
+	 */
+	usleep_range(1, 2);
+
+	ret = reset_control_deassert(gpu->rst);
+	if (ret)
+		goto disable_clk_shader;
+
+	/*
+	 * 128 core clock cycles (slowest clock) required before any activity on AHB
+	 * 1 microsecond might match all implementations without computation
+	 */
+	usleep_range(1, 2);
+
 	return 0;
 
+disable_clk_shader:
+	clk_disable_unprepare(gpu->clk_shader);
 disable_clk_core:
 	clk_disable_unprepare(gpu->clk_core);
 disable_clk_bus:
@@ -1681,8 +1670,11 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
 	return ret;
 }
 
-static int etnaviv_gpu_clk_disable(struct etnaviv_gpu *gpu)
+static int etnaviv_gpu_clk_rst_disable(struct etnaviv_gpu *gpu)
 {
+	/* The core may lose power: keep it in reset until it is clocked again */
+	reset_control_assert(gpu->rst);
+
 	clk_disable_unprepare(gpu->clk_shader);
 	clk_disable_unprepare(gpu->clk_core);
 	clk_disable_unprepare(gpu->clk_bus);
@@ -1817,7 +1809,7 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 		goto out_workqueue;
 
 	if (!IS_ENABLED(CONFIG_PM)) {
-		ret = etnaviv_gpu_clk_enable(gpu);
+		ret = etnaviv_gpu_clk_rst_enable(gpu);
 		if (ret < 0)
 			goto out_sched;
 	}
@@ -1863,7 +1855,7 @@ static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
 		pm_runtime_put_sync_suspend(gpu->dev);
 	} else {
 		etnaviv_gpu_hw_suspend(gpu);
-		etnaviv_gpu_clk_disable(gpu);
+		etnaviv_gpu_clk_rst_disable(gpu);
 	}
 
 	if (gpu->mmu_context)
@@ -2013,7 +2005,7 @@ static int etnaviv_gpu_rpm_suspend(struct device *dev)
 
 	gpu->state = ETNA_GPU_STATE_IDENTIFIED;
 
-	return etnaviv_gpu_clk_disable(gpu);
+	return etnaviv_gpu_clk_rst_disable(gpu);
 }
 
 static int etnaviv_gpu_rpm_resume(struct device *dev)
@@ -2021,7 +2013,7 @@ static int etnaviv_gpu_rpm_resume(struct device *dev)
 	struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
 	int ret;
 
-	ret = etnaviv_gpu_clk_enable(gpu);
+	ret = etnaviv_gpu_clk_rst_enable(gpu);
 	if (ret)
 		return ret;
 
@@ -2029,7 +2021,7 @@ static int etnaviv_gpu_rpm_resume(struct device *dev)
 	if (gpu->state == ETNA_GPU_STATE_IDENTIFIED) {
 		ret = etnaviv_gpu_hw_resume(gpu);
 		if (ret) {
-			etnaviv_gpu_clk_disable(gpu);
+			etnaviv_gpu_clk_rst_disable(gpu);
 			return ret;
 		}
 	}

---
base-commit: 14c3f1cbcec18927f1b6faab03f0d95c0bd1da74
base-tree: https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
change-id: 20261023-etnaviv-rpm-reset-4259b2c517c4

Best regards,
--  
Jerome

