Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4402BC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C2110F6D7;
	Fri, 14 Aug 2026 20:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="b38Em92c";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C50910F6E0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 20:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786739783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UEzS7cgh0s3kpDJoSKFSaeUbfz26XKFwvX4uV6Y0kQg=;
 b=b38Em92c4kCq6gdlSDSaFQ7fzyowCMItxkcA91Bz+0OoBrLe/uy+eGfZP1qEV7qMuAVMG7
 xPbHZF8Q0nImuKZW0q5MGNfCkwVlr5En25D2zV+urwO8TjDO80yYwjSFc1G0x6NYm3rr5C
 Pkf5OVrNZvoQtKeySjcEGIT6b0XpY1U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-oqOvZT7bMEW5oR1aBhdpHw-1; Fri,
 14 Aug 2026 16:36:07 -0400
X-MC-Unique: oqOvZT7bMEW5oR1aBhdpHw-1
X-Mimecast-MFC-AGG-ID: oqOvZT7bMEW5oR1aBhdpHw_1786739765
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FF7D195608A; Fri, 14 Aug 2026 20:36:04 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94B5E197751A; Fri, 14 Aug 2026 20:36:00 +0000 (UTC)
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
Subject: [PATCH 4/5] drm/vblank: Use drm_for_each_crtc() in drm_vblank_init()
Date: Fri, 14 Aug 2026 16:35:32 -0400
Message-ID: <20260814203542.1405135-5-lyude@redhat.com>
In-Reply-To: <20260814203542.1405135-1-lyude@redhat.com>
References: <20260814203542.1405135-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: n-oec64SmiRyi_Z2b4WWbM3YQvjXi64dZ38aR0yoBMw_1786739765
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

No functional changes yet, we just should be using this iterator here
instead of manually counting the number of CRTCs anyhow.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 17283e8920378..d57405050554f 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -547,19 +547,20 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 int drm_vblank_init(struct drm_device *dev)
 {
 	int ret;
-	unsigned int num_crtcs = dev->mode_config.num_crtc;
-	unsigned int i;
+	struct drm_crtc *crtc;
 
 	spin_lock_init(&dev->vbl_lock);
 	spin_lock_init(&dev->vblank_time_lock);
 
-	dev->vblank = drmm_kcalloc(dev, num_crtcs, sizeof(*dev->vblank), GFP_KERNEL);
+	dev->vblank = drmm_kcalloc(dev, dev->mode_config.num_crtc,
+				   sizeof(*dev->vblank), GFP_KERNEL);
 	if (!dev->vblank)
 		return -ENOMEM;
 
 	dev->has_hw_vblank = true;
 
-	for (i = 0; i < num_crtcs; i++) {
+	drm_for_each_crtc(crtc, dev) {
+		unsigned int i = crtc->index;
 		struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, i);
 
 		vblank->dev = dev;
-- 
2.55.0

