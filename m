Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB74C5DF6A
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1165110E5AF;
	Fri, 14 Aug 2026 20:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="H7UP/L3A";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D492A10E5A4
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786739762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8HxtGS/+pDsEWZq9YYRCPV84sZrTTgU1WrgrxJbu3s=;
 b=H7UP/L3ARE0/bTVvirc3xmDHx/wKHGmB/WFp4XiMVEMg+fuKs+uW+ieuTt9abMah/4EBdC
 y8R9ArTJsEmzVzNImxgj0IyI3iUwBGgagRww3ktlfDlvlZcOMGZq7rVY7wzK1uxF1+3v6q
 73o+68/ALx7yBsDx5lz5yhPxMLfeomY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-OoJM1A43PeiGF1bcosKBrg-1; Fri,
 14 Aug 2026 16:35:57 -0400
X-MC-Unique: OoJM1A43PeiGF1bcosKBrg-1
X-Mimecast-MFC-AGG-ID: OoJM1A43PeiGF1bcosKBrg_1786739754
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC0B919560B5; Fri, 14 Aug 2026 20:35:53 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12FBC197751A; Fri, 14 Aug 2026 20:35:49 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 nouveau@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-sunxi@lists.linux.dev,
 asahi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-samsung-soc@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-mediatek@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 linux-aspeed@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-mips@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 imx@lists.linux.dev
Subject: [PATCH 1/5] drm/vblank: Add drm_device.has_hw_vblank
Date: Fri, 14 Aug 2026 16:35:29 -0400
Message-ID: <20260814203542.1405135-2-lyude@redhat.com>
In-Reply-To: <20260814203542.1405135-1-lyude@redhat.com>
References: <20260814203542.1405135-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: KZ7cAR7WPISYSsIMQavyF9z1o2JGFiylaeOfSJYhwFY_1786739754
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Currently the way we check if a driver supports hardware vblanks or not is
actually funny and cursed! Likely because it predates KMS.

As it turns out, we only check dev->num_crtcs to see if we have vblank
support. Why? Because it doesn't actually represent the number of CRTCs on
the device, unless drm_vblank_init() has been called - which sets
dev->num_crtcs. And as it turns out, this is the second place we keep track
of the number of CRTCs we have.

Let's clean this up by starting with adding a variable specifically for
tracking whether drm_vblank_init() has been called or not.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 3 ++-
 include/drm/drm_device.h     | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e423..d317148af8cb3 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -557,6 +557,7 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 	if (!dev->vblank)
 		return -ENOMEM;
 
+	dev->has_hw_vblank = true;
 	dev->num_crtcs = num_crtcs;
 
 	for (i = 0; i < num_crtcs; i++) {
@@ -600,7 +601,7 @@ EXPORT_SYMBOL(drm_vblank_init);
  */
 bool drm_dev_has_vblank(const struct drm_device *dev)
 {
-	return dev->num_crtcs != 0;
+	return dev->has_hw_vblank;
 }
 EXPORT_SYMBOL(drm_dev_has_vblank);
 
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 768a8dae83c52..2df08c756afd3 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -287,6 +287,13 @@ struct drm_device {
 	 */
 	struct drm_vblank_crtc *vblank;
 
+	/**
+	 * @has_hw_vblank:
+	 *
+	 * Has the driver called drm_vblank_init() to setup hardware vblank support?
+	 */
+	bool has_hw_vblank;
+
 	/**
 	 * @vblank_time_lock:
 	 *
-- 
2.55.0

