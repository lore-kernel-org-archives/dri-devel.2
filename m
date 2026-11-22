Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED189606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Zd2NvVET
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 133DB10E4DA;
	Sun, 22 Nov 2026 15:31:20 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C7BD10E19B
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:31:09 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so22127395e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795361467; x=1795966267;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=da6eqqr5+mNyqLPiJjh9XR2U6FENUUFBFqpSoPRBQAU=;
 b=Zd2NvVETI5zrBf9K2CjKpH2jJAE2AzJRke6jSQaqwm8LcfkTOgnLzHDpK0nGsxULXW
 +xEIUuaCp6eCAQGI8C7x07JhbZbYqG8rPFB1FEpbxRwBHbq1k6k/yWzaCH42zMZD5db6
 hr2NimOzhfEitgUl0ZSA42rsYOOVR09SeSauM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795361467; x=1795966267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=da6eqqr5+mNyqLPiJjh9XR2U6FENUUFBFqpSoPRBQAU=;
 b=effYdDFKNRLY4APzDWg4bLHVw35Wdabt5tPufcKtYBrySe12nj9ZOCU067RSUEa6uR
 8bVWk7Txm3kEvGkNt/QKluCT6HMcYmptaWiWQTBOmEAD7c99zkZvjDMR3yswmWevzcSq
 BsOcHw0WPdxZRjiqLpIjiVfwc7Jn4IahFSwzmMluouLvlqzUREZvnJGF42rW3xWv/Dur
 SCA0FOW2IUhjXRY5EuDVWiAnWug94mU5WI1csbtJCLOrmyMiKo3Vf/sr09vlN341Bb/t
 VWRBtTaHOWOHaLtrTZKAxfAbkmWkykZqtb9kQhsW2L/fsNKfUDa4uWU78quIs+MvAreK
 H8XA==
X-Forwarded-Encrypted: i=1;
 AL+hErF2gcNySag5huDX5bhUfB1ry121kyd0oupG8KzLUOFvEFW9nVJNo8sYzk2npRaxSaDDjzDFI3RkaZo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/zT2Ee8C1HjZnfp4dFvbGfqwRH1ZMePWLOAcRIS0niQN18CzG4
 T5n58l1ch2ldFDZqE1HBayQNHIVoN5gDZrPqKXLeZRkK6B1xJIYQw1hEaH8ZFV4x3is=
X-Gm-Gg: AZFdTZe572n4BZe5O5jSZB6QXZ4904yjIYQD2XNY1TEu0ffLpYnnQPIuOjnz56FamgR
 wuu8lA6mADY/1AFHU1SdSRzjOVJ8+usHU7DSmAqqRiACOIAzILNnxnasbpWGVbPz/dqE3Qlft9c
 P3XSfSycMJHwdQtgSeQjTa8vrSyETVtGfWmIMw9SuA309O6/Nrg0qtPtqWKsrcATHAS5FBmfJZ5
 6NThbX3YykSPthHTp7z91NP7rLoJg5pa6YMP9RskRmgjtTp+5lwUmzpWOCjdZ8NFhIhMw2Pn1r5
 doFxRaRLJxggtsL9NnMYQ/0/+uiqusiuVKd/e3sKujWVNrfQyMCdhIavC73/oCbDJSOV55iDkdT
 1XvFyO4WIicZ7mhUZZHfEAu4xb6/KGvJ4w27N3EhYyo5vF5ogO8NvxoAY0Oujik8wXnC40pKdim
 DT2m5FdPa9JGF6OLMu+PmbINXEwrJPyNDcFXuIReWU5R7elHcih8RFQz6MCbCEkvjnG2jP4NpZA
 R0ludBzrws2iv7R/TwQHEFZbpUfI09LokFKBAzUKzJBIiLe9iW6LDlsyp3kfuMt/1xZ81p4hfeG
 IIGdrhNNQAjJds8UVmiBw/9HMGt9JaO6MpNrmAC4R050l6dP0wpYISPCWwnpVTl8jlCJwhUnLNo
 Z90QGTE64gKYlz4RASd+CxutjjgW7xJBbiDTBH+uZ5RvejRdV3v0EIsHju9yvrThNmpQT2GC2zb
 3cYANiUv6eQRmJOWAGCxMA2s9nFWF1Tst2R2ObFcS6K8s+Yxc=
X-Received: by 2002:a05:600c:8287:b0:4a1:6992:f861 with SMTP id
 5b1f17b1804b1-4bb887e064dmr198299585e9.1.1795361467514; 
 Sun, 22 Nov 2026 07:31:07 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm237833815e9.9.2026.11.22.07.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 07:31:06 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 David Airlie <airlied@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marek Vasut <marex@denx.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 Stefan Agner <stefan@agner.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/8] drm/mxsfb: Stop the controller in hw_reset
Date: Sun, 22 Nov 2026 16:30:05 +0100
Message-ID: <20261122153032.2782768-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
References: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When the hardware state can't be read out, a controller left running
by the bootloader is reprogrammed while running on the first enable.
Stop it in the hw_reset hook.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/mxsfb/mxsfb_drv.c |  2 ++
 drivers/gpu/drm/mxsfb/mxsfb_kms.c | 33 ++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index c8bc79264361..ef4a47d238ed 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -31,6 +31,7 @@
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_mode_config.h>
+#include <drm/drm_modeset_helper.h>
 #include <drm/drm_module.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
@@ -110,6 +111,7 @@ static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
 	.fb_create		= mxsfb_fb_create,
 	.atomic_check		= drm_atomic_helper_check,
 	.atomic_commit		= drm_atomic_helper_commit,
+	.hw_reset		= drm_mode_config_helper_hw_reset,
 };
 
 static const struct drm_mode_config_helper_funcs mxsfb_mode_config_helpers = {
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index bbc2a2df9f16..96cd80c6e76c 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -35,6 +35,18 @@
 /* 1 second delay should be plenty of time for block reset */
 #define RESET_TIMEOUT		1000000
 
+static void mxsfb_hw_get(struct mxsfb_drm_private *mxsfb)
+{
+	pm_runtime_get_sync(mxsfb->drm->dev);
+	mxsfb_enable_axi_clk(mxsfb);
+}
+
+static void mxsfb_hw_put(struct mxsfb_drm_private *mxsfb)
+{
+	mxsfb_disable_axi_clk(mxsfb);
+	pm_runtime_put_sync(mxsfb->drm->dev);
+}
+
 /* -----------------------------------------------------------------------------
  * CRTC
  */
@@ -205,7 +217,7 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
 	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_SET);
 }
 
-static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
+static void mxsfb_stop_controller(struct mxsfb_drm_private *mxsfb)
 {
 	u32 reg;
 
@@ -221,6 +233,11 @@ static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
 	reg = readl(mxsfb->base + LCDC_VDCTRL4);
 	reg &= ~VDCTRL4_SYNC_SIGNALS_ON;
 	writel(reg, mxsfb->base + LCDC_VDCTRL4);
+}
+
+static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
+{
+	mxsfb_stop_controller(mxsfb);
 
 	clk_disable_unprepare(mxsfb->clk);
 	if (mxsfb->clk_disp_axi)
@@ -433,6 +450,19 @@ static void mxsfb_crtc_atomic_disable(struct drm_crtc *crtc,
 	pm_runtime_put_sync(drm->dev);
 }
 
+static void mxsfb_crtc_hw_reset(struct drm_crtc *crtc)
+{
+	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(crtc->dev);
+
+	mxsfb_hw_get(mxsfb);
+
+	/* The bootloader may have left the controller running */
+	if (readl(mxsfb->base + LCDC_CTRL) & CTRL_RUN)
+		mxsfb_stop_controller(mxsfb);
+
+	mxsfb_hw_put(mxsfb);
+}
+
 static int mxsfb_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(crtc->dev);
@@ -493,6 +523,7 @@ static const struct drm_crtc_helper_funcs mxsfb_crtc_helper_funcs = {
 	.atomic_flush = mxsfb_crtc_atomic_flush,
 	.atomic_enable = mxsfb_crtc_atomic_enable,
 	.atomic_disable = mxsfb_crtc_atomic_disable,
+	.hw_reset = mxsfb_crtc_hw_reset,
 };
 
 static const struct drm_crtc_funcs mxsfb_crtc_funcs = {
-- 
2.43.0

