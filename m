Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6627C5DF77
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A9210E941;
	Fri, 14 Aug 2026 20:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SWAPXsnx";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A345D10F6E6
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 20:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786739775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WquuCq3TQCd+s4bFYX3uFmTk9vt6sijgW3Z8EuiR4qM=;
 b=SWAPXsnx4GeeXSj+2mTkWM+M25nQt3SMTEOQ3+CHjNF4ejeRCgnQdlkuhHRIpad/IcbYb0
 Rs7V5fBshfSwGvdxoR50d4c5/QanI4JR98X+2LwBk1xhTwkvTlBf7lTGvbm7w/BEpGRO0s
 90ddnwcmcW7Aocy1EwwvnwhUcdzc6Q4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-3lqovXAqMhKKYoeTKCS2Bg-1; Fri,
 14 Aug 2026 16:36:10 -0400
X-MC-Unique: 3lqovXAqMhKKYoeTKCS2Bg-1
X-Mimecast-MFC-AGG-ID: 3lqovXAqMhKKYoeTKCS2Bg_1786739767
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A467E1956069; Fri, 14 Aug 2026 20:36:07 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFE71197750F; Fri, 14 Aug 2026 20:36:04 +0000 (UTC)
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
Subject: [PATCH 5/5] drm/vblank: Require all CRTCs implement vblank support in
 drm_vblank_init()
Date: Fri, 14 Aug 2026 16:35:33 -0400
Message-ID: <20260814203542.1405135-6-lyude@redhat.com>
In-Reply-To: <20260814203542.1405135-1-lyude@redhat.com>
References: <20260814203542.1405135-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: JnAGq-jpE5JdOmj9luY_Nn_2Dicz5tJXqT2PmFpHB1E_1786739767
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

Due to us previously allowing users to specify the number of CRTCs for
drm_vblank_init() manually, a untested and almost certainly UB edge case
was technically possible for drivers: implementing vblank support for some
of their CRTCs, and not implementing it for others.

I don't think there's any actual situation in the real world where hardware
like this exists, nor do I think supporting such a possibility was ever
actually the original intent here. But in Rust, we need to be able to
prevent such a situation from occurring since we cannot guarantee no UB is
possible otherwise. I think it makes sense here for us to just handle this
safety check in the DRM core though, since it's quite likely such an edge
case would break C drivers in addition to Rust drivers.

So, let's start enforcing this in drm_vblank_init by checking that every
CRTC has an enable_vblank function registered. Throw a warning if we find
that some CRTCs have it and others don't.

In the event that we don't actually find any CRTCs with vblank support,
simply skip init and return -ENODEV. We intentionally don't WARN_ON() this
scenario, as it isn't a fatal error and drivers which do support KMS but
don't end up registering any CRTCs can simply ignore the error. This is
also useful for Rust, since it saves us from having to track whether or not
any CRTCs registered vblank support ourselves.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index d57405050554f..17affae23e7a6 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -542,12 +542,31 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
  * drmm_add_action_or_reset().
  *
  * Returns:
- * Zero on success or a negative error code on failure.
+ * Zero on success or a negative error code on failure. If no CRTCs with vblank
+ * support implemented were found, -ENODEV will be returned.
  */
 int drm_vblank_init(struct drm_device *dev)
 {
 	int ret;
 	struct drm_crtc *crtc;
+	bool found_vbl_crtc = false, found_non_vbl_crtc = false;
+
+	/* Vblank hooks are per-CRTC, not per-device - which is contrary to how
+	 * the vblank core was written. Since hardware that only has vblank
+	 * support on some CRTCs but not all is non-existent and would likely
+	 * lead to UB, ensure that vblank support is all or nothing.
+	 */
+	drm_for_each_crtc(crtc, dev) {
+		if (crtc->funcs->enable_vblank)
+			found_vbl_crtc = true;
+		else
+			found_non_vbl_crtc = true;
+
+		if (drm_WARN_ON(dev, found_vbl_crtc && found_non_vbl_crtc))
+			return -EINVAL;
+	}
+	if (!found_vbl_crtc)
+		return -ENODEV;
 
 	spin_lock_init(&dev->vbl_lock);
 	spin_lock_init(&dev->vblank_time_lock);
-- 
2.55.0

