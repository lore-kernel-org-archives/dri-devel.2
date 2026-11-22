Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02030606A332
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=fwhOAl3f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F20C610E52A;
	Sun, 22 Nov 2026 15:31:20 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB8010E19B
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:31:03 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso29185915e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795361462; x=1795966262;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NKlfL/cIMbCShlnoUQAoP1Uep9RrtGH8SZf3MvBv2hw=;
 b=fwhOAl3ftlqHh33IlKemDEnWWiEZ7Yi/NUla8VQ0tOG4dejVf+Ec4lU2WhahUBrCSl
 bkZx2d0iwL9tOFICpXGScfRgle/va55m4yNTCM6jYy4E63BVNJZONJAoe5yIA40DW2Nj
 ekDyr76mKI9MZ/6eJRCL/N3oYWn4aRXjfjE6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795361462; x=1795966262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NKlfL/cIMbCShlnoUQAoP1Uep9RrtGH8SZf3MvBv2hw=;
 b=MV75zHv7eNPJQGLe+MVD8xODj5+38nL/E6Eqao4icx+8/HRPRzThxN1fCzje///Uv0
 G4yayr1mqj9JGKm/cNDfRfYL/rDASA9HkoSG1eYuVZeiVhAa6JbMIL2jcXvl3gwA2IcQ
 pp2to7ZaQWx+PBO1Ce/PPIkCJWAfMicHqROpwcuNdoZ+32J72pklsrUbUVMBx8sgWcv7
 80rKi4zG6r5zOIz2jCOwODfNOt0wlqCnQ2kfFGI9A2q0hsDbZlT3ws2CegjZKmGRYlUh
 bFA8sAvHffE+ltsU5OR4E99ZRA9ABp2y9CtuszrwZeIpBNSN3QelQ63i5nMiYH1cLuz+
 z8ew==
X-Forwarded-Encrypted: i=1;
 AL+hErFDlGcJj8/YqAIZmTKJpQ6oTqOOBh1KBv7N1MXQgvzqWFPY4sBL/uXJ0Ewj1SpXajM49dSDCABbfQo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+BJJRK+JI+JRpKDFdPrsve8eDoqmzE0jOqkkZV5OxPrYAOw0c7
 xDL3Artm2dcYTt5/VJqEIrOreV5Yv9W3/iY85rGGSIWeXwyb7pWt7YRx6FT0puygF0I=
X-Gm-Gg: AZFdTZePLNdxVFL5pCfUbXA2LUx/h+U/hDnLnn8ePZ1amK9ptsL8bC5yeA2vYWV2E+H
 bebYQ0JSQBRTqU+H4cogQuQPBPSJfCaSz84+fD918Nuhq5/KkyxmvGQPtfPz7WkKst5s1OZKrtT
 5rpsT7gU0cnf15CvPsS9C7/0q359PDVd6PuZFXlDSIWoCIoQ61M4LQnYFJyyIJ7uF5coPWreVdU
 i4ja/5VhmmBsaVqWJghiiNMhjOSQTo9po06t5/3TI6BTB8Xa0mnYNa6X5HQEr0vTvVuulTmu30+
 IeMMDj1P6x/NkO3+m04GNdJ/DtRwLGwZmpkiyDd6CCwzB3rzgcSPNx7zmSq2xxq+YGXqebndcv0
 JLH5d+sh5ETA6b6NbZQ9p0J6TSnFg+n/bhVXIcMGEXfVqTs3um8ViwA1i54tL1MDlvqFvKTl5qD
 QxJLrlTp2ke126lRHBJywNIxadzz9GGJLnsrWrFqGq+2MBW79SEYYJjOQcNWnPrSjdOdmZ/rtza
 2P7HDsvVu+NSe8jfvQJu7r+kU9NQDo/ckyH/BtFpa3S2F4opv8mMPgKTaM9OFWUmD3Qd33Nys1x
 13oUBw4CewsqkLbjMGXbnDDuEFzGgdOCggUDbzGqOMq3ZTnknlg7Jls1bW+pRUmmW/uzxdGKN9V
 47cRbKRwte4CdkRiowUDUZnspPII+dZgZ6gF12W6o9W788bxTT2BldQorQqQdNBbd1hay5JyF0r
 A3UWdvt/Bk3gqLRVA+OeNwMX6fxg==
X-Received: by 2002:a05:600c:4584:b0:4bb:5de1:e90f with SMTP id
 5b1f17b1804b1-4bb88819bcdmr186394735e9.31.1795361462157; 
 Sun, 22 Nov 2026 07:31:02 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm237833815e9.9.2026.11.22.07.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 07:31:01 -0800 (PST)
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
Subject: [RFC PATCH 4/8] drm/mxsfb: Switch to
 drm_mode_config_create_initial_state()
Date: Sun, 22 Nov 2026 16:30:04 +0100
Message-ID: <20261122153032.2782768-5-dario.binacchi@amarulasolutions.com>
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

The hardware state is read out only when the initial state is created
with drm_mode_config_create_initial_state().

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 038f5c896dcb..c8bc79264361 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -322,7 +322,11 @@ static int mxsfb_load(struct drm_device *drm,
 	drm->mode_config.funcs		= &mxsfb_mode_config_funcs;
 	drm->mode_config.helper_private	= &mxsfb_mode_config_helpers;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret) {
+		dev_err(drm->dev, "Failed to create initial state\n");
+		goto err_vblank;
+	}
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-- 
2.43.0

