Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF96EC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1030A10EDFA;
	Tue,  7 Jul 2026 15:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="amsx8B8m";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3896610EDFA
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:33:46 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493b1710405so27586695e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783438425; x=1784043225; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DlDWtQ71cy4M6Iwx6C9VpFd4pqPTgh6eJknwRkh5wwk=;
 b=amsx8B8mPAa5LZSf3rXr/o27MHiugC/hRrL2SdSY2n5K08Kn3VOaUyGFL/m7hqDYwN
 hYTH/qUziNbmLVqEDjdRIm3E0NcaGTo2zL/y6uY405AsOXubrzg0MvGDd64PU39tJEEH
 rJi9UuaSlKUXo2zKUzsNcSkk1KYHx9TZ0c0xv37snB1lcBRpSvnCrLTSrVaOAuEKQILH
 RgYJJolP1GCRLGueI94EptViwEqnHAPZBkgr888Nvd3FUMeQwuFXIudIS2Qgvm9wpWVo
 au6O+Hnbg9n7V3S+AGqQ+VMlun/VaWfqrPKuF5zdKp9AlIdXhlAVSuMlaZE8IjKBAIhG
 qPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438425; x=1784043225;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DlDWtQ71cy4M6Iwx6C9VpFd4pqPTgh6eJknwRkh5wwk=;
 b=SVm764ncFUbyReW2BddhS8iF0Nm166x6MmVNzmpLljuIYqPgi5jPVtcwl6gTGbu2VU
 1x46bMQ1xoNL8uRHS0ZiVfQzJrM9V+Bks/DKlFokLbJL01+rXj7AMoIbMi6Y7tJYUSfA
 MJ6Eh7o9x0KFv4Bby6dzC0ufLb5LJ9IFOfG1TXQ4eDM6VITci7rI7AJqnai+eNfSZq1j
 l/vErlLCZ9j+eXWItVq61iVDmOCRLZmY5qJ4mVd3IseYsel/ZEpTugBg7bjhx6udnjJ4
 7QsZIRDaMI3BM9gNVTBF/ZK/E566Bots/n+AdofPFa3fO+Hdxjkd3wET+N8RS2sT7EfL
 waWQ==
X-Gm-Message-State: AOJu0YzfscliIX2j+2Nfe8eqG6XbrHcYd8tqcp8CL9ug1gXBshqEnzYJ
 UK7K9AmQ8L/Gq02/9f4Pz+24Ow60+xi68TKpc1Tk7qtWJdh9zAADwkoj
X-Gm-Gg: AfdE7cnHzh4l/MieU5p1ulPpqalMpfh15rcc3wZu10iSLY0UeXiE76iNxUoNVZJOAuh
 02kI6KQ8pvc0u4UDWcf+Lj0BEUPw1XLmlQKL7P8HC1y7js6EQ4qd08j/RuszwwP3WUXI3WxszYA
 HgqyABTczONK0qpm4fMoNEPQ+sTcxGvo1ZgYW5aT4sycLRXcbQkdKU0e223KbeCQWA7pYgvtYwP
 MEFLJqVL9rcHI1s/uKNzcIsWnxt9owG379HjQR1IsBtAji5X8TPpsDHWfYwtZiJlttI3Gm1h0w5
 4gWm4ntcDBfFevdEFeXqrbF9sIzYSUW+4ky59/UkrALyPDS8ln3q+tEkpsrMM/chvxZZ0aPKa2P
 Zlul3wiRXdCA3pHZwx53Ccj+G+JpoGjwmLJDOzlVBU4MLZ3ZUq++IjRmaUvik8+DYtR0++RgZK3
 ppygTBixCCtuSdZt5Dnyx3
X-Received: by 2002:a05:600c:6085:b0:493:bc97:916b with SMTP id
 5b1f17b1804b1-493df0929f3mr4664575e9.26.1783438424204; 
 Tue, 07 Jul 2026 08:33:44 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f5b811sm100622385e9.13.2026.07.07.08.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:33:43 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 07 Jul 2026 17:33:27 +0200
Subject: [PATCH 2/2] drm/xlnx/zynqmp_dpsub: check return value on
 drm_encoder_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-xlnx-simple-v1-2-df50c6665b02@gmail.com>
References: <20260707-xlnx-simple-v1-0-df50c6665b02@gmail.com>
In-Reply-To: <20260707-xlnx-simple-v1-0-df50c6665b02@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.14.3
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

A call to drm_encoder_init() can fail. If the error code is not checked
this may lead to drm_encoder_cleanup() being called on an uninitialized
drm_encoder.
This patch addresses this by adding the proper return value check to the
drm_encoder_init() function call.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/xlnx/zynqmp_kms.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index 698ac692abce..1d194c2824e3 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -439,8 +439,13 @@ static int zynqmp_dpsub_kms_init(struct zynqmp_dpsub *dpsub)
 
 	/* Create the encoder and attach the bridge. */
 	encoder->possible_crtcs |= drm_crtc_mask(&dpsub->drm->crtc);
-	drm_encoder_init(&dpsub->drm->dev, encoder, &zynqmp_dpsub_encoder_funcs,
-			 DRM_MODE_ENCODER_NONE, NULL);
+	ret = drm_encoder_init(&dpsub->drm->dev, encoder,
+			       &zynqmp_dpsub_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret) {
+		dev_err(dpsub->dev, "failed to initialize encoder\n");
+		return ret;
+	}
 
 	ret = drm_bridge_attach(encoder, dpsub->bridge, NULL,
 				DRM_BRIDGE_ATTACH_NO_CONNECTOR);

-- 
2.51.2

