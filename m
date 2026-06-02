Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D06CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A018110F4C3;
	Tue,  2 Jun 2026 18:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="Et/OyKEq";
	dkim-atps=neutral
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [91.218.175.186])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13A610F4C4
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 18:44:47 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1780425466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FIRnKnjUEgwNKRFP5/LIIC27jGvHXMJS53DGStupNA=;
 b=Et/OyKEqDlCNwgBBSAxwg24mwBIGKpaAPg/nD9PdjfNMHte6RReHyoaiXE+1s1esIcI1l2
 e32gAzaEJl6vsA0U1W2tTgZm6sXrWG4Jhst6gyKh1k9Hlb4wyyum/e0JKP0vwluv/MUVyW
 cPls8YUocn/uw5F+w4Z04/f7xIg1NMM=
From: Henrik Grimler <henrik@grimler.se>
Date: Tue, 02 Jun 2026 20:36:48 +0200
Subject: [PATCH RESEND v4 1/3] drm/bridge: sii9234: fix some typos in
 comments and messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-exynos4-sii9234-driver-v4-1-9b2fc38e104a@grimler.se>
References: <20260602-exynos4-sii9234-driver-v4-0-9b2fc38e104a@grimler.se>
In-Reply-To: <20260602-exynos4-sii9234-driver-v4-0-9b2fc38e104a@grimler.se>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org, 
 linux-kernel@vger.kernel.org, Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382; i=henrik@grimler.se;
 h=from:subject:message-id; bh=ov52qv09hURyivLgIT73m1vzdLOIqjhLJ2nQEw37YQE=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqHyLokf4gb92s793rV1c2L9bTU6iH6/9jwx0pL
 2yifYgO6M2JATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCah8i6AAKCRCwB25JC3Fh
 axtJB/9/R1jZ8CU5+J0KrHfzmNzGXAi0vkD3kVIRkSrWwXPRfj6gFpsJyNgulaFEHBk404EdS0R
 RzjfwjzpoS+BolcXKq9xoPMu2pk34tMk6HlAC58RPLB8v/yAHd3+awMUIV3YB/KkeWe3kuAHF/2
 xalZfxg3R0Gob0XuVaeL4QVp1MQMEWwBRpzV8/7KWOLzCVPffEOnh/+StGAyMN1EmJHA3WWjoUd
 pRFXdUXkiafcqNNbU2wGkhTfWJfdtYgrGNdjt20urZZzG5FDVVFRdvpslaQR816iD24yVyJBlBJ
 qMekqJFEclKY6o+4giXBSU9J0uzGpehLhHYO1LfPpXX/SdPi
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT
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

Fix spelling and formatting so that the code is easier to follow, and
so that it is more searchable.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
v4: no changes
v3: collect tags
v2: no changes
---
 drivers/gpu/drm/bridge/sii9234.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index bb1bed03eb5b..930117bbba87 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -339,7 +339,7 @@ static int sii9234_cbus_reset(struct sii9234 *ctx)
 	return sii9234_clear_error(ctx);
 }
 
-/* Require to chek mhl imformation of samsung in cbus_init_register */
+/* Require to check mhl information of samsung in cbus_init_register */
 static int sii9234_cbus_init(struct sii9234 *ctx)
 {
 	cbus_writeb(ctx, 0x07, 0xF2);
@@ -614,7 +614,7 @@ static void sii9234_cable_out(struct sii9234 *ctx)
 
 	disable_irq(to_i2c_client(ctx->dev)->irq);
 	tpi_writeb(ctx, TPI_DPD_REG, 0);
-	/* Turn on&off hpd festure for only QCT HDMI */
+	/* Turn on&off hpd feature for only QCT HDMI */
 	sii9234_hw_off(ctx);
 
 	ctx->state = ST_OFF;
@@ -708,7 +708,7 @@ static enum sii9234_state sii9234_rsen_change(struct sii9234 *ctx)
 {
 	int value;
 
-	/* Work_around code to handle wrong interrupt */
+	/* Workaround code to handle wrong interrupt */
 	if (ctx->state != ST_RGND_1K) {
 		dev_err(ctx->dev, "RSEN_HIGH without RGND_1K\n");
 		return ST_FAILURE;
@@ -723,9 +723,9 @@ static enum sii9234_state sii9234_rsen_change(struct sii9234 *ctx)
 	}
 	dev_dbg(ctx->dev, "RSEN lost\n");
 	/*
-	 * Once RSEN loss is confirmed,we need to check
-	 * based on cable status and chip power status,whether
-	 * it is SINK Loss(HDMI cable not connected, TV Off)
+	 * Once RSEN loss is confirmed, we need to check
+	 * based on cable status and chip power status, whether
+	 * it is SINK Loss (HDMI cable not connected, TV Off)
 	 * or MHL cable disconnection
 	 * TODO: Define the below mhl_disconnection()
 	 */
@@ -820,7 +820,7 @@ static int sii9234_init_resources(struct sii9234 *ctx,
 	int ret;
 
 	if (!ctx->dev->of_node) {
-		dev_err(ctx->dev, "not DT device\n");
+		dev_err(ctx->dev, "no DT device\n");
 		return -ENODEV;
 	}
 

-- 
2.54.0

