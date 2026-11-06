Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E8606A33B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ztKXed1m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2CB112ED6;
	Fri,  6 Nov 2026 16:17:55 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5F0112ED6
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 16:17:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7CF2B4E4147C;
 Fri,  6 Nov 2026 16:17:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4A8EC5FFBC;
 Fri,  6 Nov 2026 16:17:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 38D58103292CA; Fri,  6 Nov 2026 17:17:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793981861; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=CKwMnEUj4bTsuKO0oSBkdV6rE9qwvY1RjDCI8454OCM=;
 b=ztKXed1mjd73LCPlNvEG2FOfcKs8NtEVdr3hJjrfgoVmpXKrrpfRnBcrKROTALsd7FeCP+
 yv72DeWFJA6VSKkYDYD48JFeSnz9Bcp3IeLFrWBA3afasjcQS23AOBB5j1nntFpaNU1Qrb
 SM62WQNYcMk+uVlGpPW1rpqlrPhpRxv9QraQswzqx2MnhHj5fFHYTZxJA/Zar2yB32U9S7
 0ZqeFs+oydqbnD+PanIDfAH/CKJ5gs/iaL/WHuowN4sYvs9M7DDb/wiq/SFT40loe27QQn
 c3ISR82B7tmAel4rISMxnhptzSlW2NW0FxoKLA/U6Sn6gE7Ca+AiCtac5dEvsA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 06 Nov 2026 17:17:04 +0100
Subject: [PATCH 1/3] drm: adp: stop using deprecated drmm_of_get_bridge()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-1-c0ea3382b798@bootlin.com>
References: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com>
In-Reply-To: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com>
To: Sasha Finkelstein <k@chaosmail.tech>, Janne Grunau <j@jannau.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, asahi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

drmm_of_get_bridge() is deprecated, switch to
of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint() returns
a refcounted bridge, ensure the reference is put on later bind error and on
unbind.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/adp/adp_drv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
index fdf0e6316175..1c4c39695e42 100644
--- a/drivers/gpu/drm/adp/adp_drv.c
+++ b/drivers/gpu/drm/adp/adp_drv.c
@@ -517,7 +517,7 @@ static int adp_drm_bind(struct device *dev)
 
 	writel(ADP_CTRL_FIFO_ON, adp->fe + ADP_CTRL);
 
-	adp->next_bridge = drmm_of_get_bridge(&adp->drm, dev->of_node, 0, 0);
+	adp->next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 0, 0);
 	if (IS_ERR(adp->next_bridge)) {
 		dev_err(dev, "failed to find next bridge");
 		return PTR_ERR(adp->next_bridge);
@@ -525,17 +525,21 @@ static int adp_drm_bind(struct device *dev)
 
 	err = adp_setup_mode_config(adp);
 	if (err < 0)
-		return err;
+		goto err_put_next_bridge;
 
 	err = request_irq(adp->fe_irq, adp_fe_irq, 0, "adp-fe", adp);
 	if (err)
-		return err;
+		goto err_put_next_bridge;
 
 	err = drm_dev_register(&adp->drm, 0);
 	if (err)
-		return err;
+		goto err_put_next_bridge;
 
 	return 0;
+
+err_put_next_bridge:
+	drm_bridge_clear_and_put(&adp->next_bridge);
+	return err;
 }
 
 static void adp_drm_unbind(struct device *dev)
@@ -546,6 +550,7 @@ static void adp_drm_unbind(struct device *dev)
 	drm_dev_unregister(drm);
 	drm_atomic_helper_shutdown(drm);
 	free_irq(adp->fe_irq, adp);
+	drm_bridge_clear_and_put(&adp->next_bridge);
 }
 
 static const struct component_master_ops adp_master_ops = {

-- 
2.56.0

