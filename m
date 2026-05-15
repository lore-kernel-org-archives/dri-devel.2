Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6D4CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 08:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BAC910E15B;
	Fri, 15 May 2026 08:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WbcC1JEs";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA7710E15B
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 08:22:46 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-bd0fc4c336eso966011366b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1778833365; x=1779438165;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jyqc86C0RaOsmVCtF4adD//ESUXJ+e9Bl/YFrb0r+E=;
 b=WbcC1JEs6kKmlpVBaYawA1XYFj6cxHxarSWcbnguOLX2oLVFAODwvsDKJjSv2Vg7Ga
 WwP8zx1C9Wm4ht9eXjMdH3RqUQlCMhSJ2gfjn/He3t2rNbyOKv7qXYUIz9vtdgKMYaha
 z6yHAPyGlFKmHMu370FDsol3jyZBb7ZWqe+XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778833365; x=1779438165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/jyqc86C0RaOsmVCtF4adD//ESUXJ+e9Bl/YFrb0r+E=;
 b=sNO0xCuvqouyD1SzrufOiGLajyzEvvU/TbPyeIN5qXz6XdHbssHUTWr5+LHsCw/I0L
 JsS4KGcw0+e62yPcDA3cXSzKCBhQ49/olPZmsPH9OctX/af8zVE70AEfSZFkxYgpq8U/
 sRfancyQOajsr0TZyo55X65FbRl4QXVQTJ9WBb4v4U8P0Sk9DEBp3JUn+D3pwLMNPhBB
 m45W6WI1ChfJobPT/dW2CkrvYOfi69f/RkoseFSe+8tYMhMOmZeBKAdL1AbKKCNPBH2p
 ByGXGRxpS1q7Hmy0Kj0JskaTFRvTGE/bqFGdjixvhlmJL6NVcY9INSdTn/V4EjddfdAw
 6Sow==
X-Forwarded-Encrypted: i=1;
 AFNElJ82iot09ALAQBwexOVfz9O52jqfEZ9PSoMJorPBckYOKovKyADF+/dmlN04tm5qlRC2TcC8/pLCSho=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yym3wubR6XmSVF5Guem6MtuFUl+46MnBKLPrOnKMQjay+lcnvgy
 YX6XAkN+FpmEmpRyFoYsQinOPkQu6Mmb3E5D8X9LKrbEcYkJXK0MLptTqHAQs4BLZRg=
X-Gm-Gg: Acq92OFa22lv9nz0dqev1lSfVdG4is0WPjXrHOW02biXrBHlxMgwE7/aKkm2LK8Z+Mp
 kEeIKBB7KXO7EgxgWtYgrQ8O+ZUjJbp6cjAcloP1RBx+1RSgHiv7G/gpbII9sGSRObifJqyRvs6
 5WQkfmoUe30fQwWvvneCnzAcsH7Ion05kMcIHgnOJjwuUiiNg7+kzzxmOaEf8Mctp1SmRCXc03R
 Utqu2dKx2UujzTcVQicuuoMgSnyvc4eXAwVyY06JVguNpyIPIRV4CG77xGSLXa47V4WPtQNFMv3
 8QzZ8UZ1fWHcULzDdVnuHkwhp6EOva9Bg228fc1EbPakLLhMezd6PEHstW+otFLr+Qoj1XLrbjd
 5KufD/jC/YdUhKdCnu+GFwhQw2yL9Sb6uA478XGc55fxmWLHxX77cN1iFwQRvGxf4sQsrE3PJc5
 h+rmjTuZktG3P7v5k7pDXy5pbbdXkRR5Gvn0mpE05BwY+bzqNj+oI4pdsGrm2aInRqRNTyH8RoA
 rTVRqhkf7I+9+VNyxMd7VHHnrS3g8GMOyJ8mAb1cE7foeLF
X-Received: by 2002:a17:907:94d0:b0:bd4:f3e2:ee5 with SMTP id
 a640c23a62f3a-bd51790b44fmr119141466b.23.1778833365102; 
 Fri, 15 May 2026 01:22:45 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.42.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4e4d54dsm189529966b.47.2026.05.15.01.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 01:22:44 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/panel: simple: Add AM-1280800W8TZQW-T00H
Date: Fri, 15 May 2026 10:22:01 +0200
Message-ID: <20260515082232.1766586-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515082232.1766586-1-dario.binacchi@amarulasolutions.com>
References: <20260515082232.1766586-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add Ampire, AM-1280800W8TZQW-T00H 10.1" TFT LCD panel timings.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Insert the new data in alphabetical order in
  drivers/gpu/drm/panel/panel-simple.c.

 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 236bd56208cc..1bf21cd836c1 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -820,6 +820,31 @@ static const struct panel_desc ampire_am_1280800n3tzqw_t00h = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct drm_display_mode ampire_am_1280800w8tzqw_t00h_mode = {
+	.clock = 72400,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 40,
+	.hsync_end = 1280 + 40 + 80,
+	.htotal = 1280 + 40 + 80 + 40,
+	.vdisplay = 800,
+	.vsync_start = 800 + 10,
+	.vsync_end = 800 + 10 + 18,
+	.vtotal = 800 + 10 + 18 + 10,
+};
+
+static const struct panel_desc ampire_am_1280800w8tzqw_t00h = {
+	.modes = &ampire_am_1280800w8tzqw_t00h_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 217,
+		.height = 136,
+	},
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode ampire_am_480272h3tmqw_t01h_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -5193,6 +5218,9 @@ static const struct of_device_id platform_of_match[] = {
 	{
 		.compatible = "ampire,am-1280800n3tzqw-t00h",
 		.data = &ampire_am_1280800n3tzqw_t00h,
+	}, {
+		.compatible = "ampire,am-1280800w8tzqw-t00h",
+		.data = &ampire_am_1280800w8tzqw_t00h,
 	}, {
 		.compatible = "ampire,am-480272h3tmqw-t01h",
 		.data = &ampire_am_480272h3tmqw_t01h,
-- 
2.43.0

base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
branch: am-1280800N3tzqw-to00h
