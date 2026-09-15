Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF62C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 01:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D116E10E231;
	Tue, 15 Sep 2026 01:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E96jjB/v";
	dkim-atps=neutral
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com
 [74.125.230.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66D810E231
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 01:27:51 +0000 (UTC)
Received: by mail-qk2-f13.google.com with SMTP id
 af79cd13be357-939eb3249c1so338941485a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 18:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789435670; x=1790040470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Iu+JFm569gxQFfXrOc5fB1avNX3cgHG06h6b0Ix3qh0=;
 b=E96jjB/vsAcaZxkYzdnSksHoI4JApvx+cwIeo2N+47eDdYDoLFdZi64ln3Mgl8LEzV
 rArFyQIwhyuPWMH1v68pI+rNLglnl12UnYYDON3csNH8JjCP+Wvebf7ROVXmpTS6WRtO
 4mK3taYS0th7dojTpfeLEtHXb1aakdOLtvCMYE5ZaQAt6Arn2hAxQymDLlSFv70uUx9g
 vWEqRuqo7b6KI7MnX4+qRDYWUEgMocVppzYmSSSoJO107P6A1Tcar4wq4j3IyhYRh0tJ
 xqlu6uteipSfjMllHUrijGHRfpnXOfw9mXD9QbAhsDv2ycL0q7NHjPDDqijz/bO3cSuZ
 38Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789435670; x=1790040470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Iu+JFm569gxQFfXrOc5fB1avNX3cgHG06h6b0Ix3qh0=;
 b=nnLdVTLKPXtkrndmiKUsg7BiDPqxWznVZo04dpvGLUfj879Tl5w/FCJLAIdsztiSBi
 Zkcy8YxBRcOg1dHr3PKMyjwi+pNWv+Hj4z7fYyW356jZgtEKgaMQfrJJuCjznpttoZ7y
 Yly0NXYU8J9aTVR/FvdortjV8PzIJ+lz6CnnShT14MHD9LeihsZedNFJbVek8Cy4i83M
 bYfI9aV/whftKhawpZUTVwsVgUq/Inc4l1YJROhX/udsjPBWWrinrSW5vDNDzvl5laDy
 sei25DKdZVAq2occHgf3nI7z2+wbBld4ToFkuf5MDwYaDNLhhSv9oQA2EMwg9baCTSPA
 tIGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNVE+s9V8b8GKfAWPVuj1R0U9A4rKbmJdI5lK9rRFlZaLYT37mWOE4uqCy39lj/UL1lyf/5nXB0ww=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lOc+yrUjTv/eYxQE25Mvnj3nFJJqsKHqviZIX5CecwOWzKDfOX
 AgN0ZqbZgNhEitm7QoVUtjAtUvkwQhTkZ09VUuuueHgTW8HhJbNYQ+c=
X-Gm-Gg: AYBFou0iM56Nh2H3thN8OhvtfmXaUeZHnmXIJt0v1qx5Z3VjNxRvdAPy/z9XHSSdeE0
 zy0IFuwKs90ml7dT2ima31cpLmdFB++emzK3m0i5rOsQF5mv3KZkpx4u1Ey6sSomNfEJr7vxdrS
 bp2DsxOe5QtfZIuhiIToS59nJO7Hn6FOviDFT+bv1Tx4Bcou4l9B+XwAP6PjS3QpnwHIvcQ9sd4
 BkRl/TqYhtRsH4BOPYP1UGE3wlNSBlth2j7vUucS5KvjWwcRGDoqnrcLAOcjTD95FNqH6Z1V4/5
 iH9VnLZJ2Bh/Mxmb0uSXrkLYmyGojnCvw1+vZcknwwQv8fSJ2ZQC9bKVbBb2s2WFJszyLpSIrw/
 JcA/p5GajTui+QqrllWQ3fdw6GJ4jXqKcEpr1Rbzt+9JgtMTAgZQZk3kmF9NpIldZrPl2bgNltu
 b992kNY/+kO7hwQ+WydMXvM2jdvKdnPLXupjjT+Ew9oUFCUhIkgRWd+Zf7r6fu2X5tiq4AOLMbK
 NNDu9NEUAef4qGhLsPFHoFyQariupLHhNQJxTIiMm5auhQTaCW8PNquBdIIOQKuwv9F8BJws3nX
 peF5sy8tobHaKdlujze7W/8PF6Wj425Tpp1Sc95/FUBruI/zKkpQmBKk7TXTOLwG9wJQSg==
X-Received: by 2002:a05:620a:2904:b0:930:9091:f0ce with SMTP id
 af79cd13be357-93a2985a593mr832839785a.22.1789435670571; 
 Mon, 14 Sep 2026 18:27:50 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu.
 [104.39.213.233]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e80471a3sm1131736185a.22.2026.09.14.18.27.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Sep 2026 18:27:48 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/gma500: Balance MSI and IRQ state on installation failure
Date: Mon, 14 Sep 2026 21:27:40 -0400
Message-ID: <20260915012740.66623-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

gma_irq_install() leaves MSI enabled when requesting the IRQ fails.
Disable MSI on failed installation and clear irq_enabled on uninstall,
so an unsuccessful reinstall after suspend does not leave stale state
that makes a later uninstall free an unregistered IRQ.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 9b6a16575ebf ("drm/gma500: Fix (vblank) IRQs not working after suspend/resume")
Fixes: da596080b2b4 ("drm/gma500: Fix call trace when psb_gem_mm_init() fails")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/gma500/psb_irq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
--- a/drivers/gpu/drm/gma500/psb_irq.c
+++ b/drivers/gpu/drm/gma500/psb_irq.c
@@ -316,15 +316,17 @@ int gma_irq_install(struct drm_device *dev)
 		dev_priv->use_msi = false;
 	}
 
-	if (pdev->irq == IRQ_NOTCONNECTED)
-		return -ENOTCONN;
+	if (pdev->irq == IRQ_NOTCONNECTED) {
+		ret = -ENOTCONN;
+		goto err_disable_msi;
+	}
 
 	gma_irq_preinstall(dev);
 
 	/* PCI devices require shared interrupts. */
 	ret = request_irq(pdev->irq, gma_irq_handler, IRQF_SHARED, dev->driver->name, dev);
 	if (ret)
-		return ret;
+		goto err_disable_msi;
 
 	gma_irq_postinstall(dev);
 
@@ -332,5 +334,10 @@ int gma_irq_install(struct drm_device *dev)
 
 	return 0;
+
+err_disable_msi:
+	if (dev_priv->use_msi)
+		pci_disable_msi(pdev);
+	return ret;
 }
 
 void gma_irq_uninstall(struct drm_device *dev)
@@ -373,6 +380,7 @@ void gma_irq_uninstall(struct drm_device *dev)
 	free_irq(pdev->irq, dev);
 	if (dev_priv->use_msi)
 		pci_disable_msi(pdev);
+	dev_priv->irq_enabled = false;
 }
 
 int gma_crtc_enable_vblank(struct drm_crtc *crtc)
-- 
2.51.0
