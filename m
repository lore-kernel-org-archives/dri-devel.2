Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D6BC5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6D710F099;
	Thu, 30 Jul 2026 20:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eK6ijLHA";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E684810F08D
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785444382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HM8zvcL/8EecJPDVQT6aSutYylxT/HBspErHsI6olAE=;
 b=eK6ijLHALPLIOS0MI6AJtb0rjbdEmDPiJjEmyRGS2dZ4fawDIjXKWP3FaNdzszUBTY01VF
 hlbLVnZR4/MkmLh8S0ndEMv52LjUjbqIUPZIf+T/z2rvZLHJY+nIU//iBGAyWg/cl2hwlT
 aczW7+A59KhBLdWxjepzd3OVv9t1lb8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-G3_UlRhPNJCbbYze2ETfPQ-1; Thu,
 30 Jul 2026 16:46:14 -0400
X-MC-Unique: G3_UlRhPNJCbbYze2ETfPQ-1
X-Mimecast-MFC-AGG-ID: G3_UlRhPNJCbbYze2ETfPQ_1785444373
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B54601800352; Thu, 30 Jul 2026 20:46:12 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.88.35])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 313DA1956094; Thu, 30 Jul 2026 20:46:11 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Simona Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v5 1/5] drm/nouveau: Fix cleanup bug in
 nouveau_drm_device_new()
Date: Thu, 30 Jul 2026 16:45:06 -0400
Message-ID: <20260730204604.1729505-2-lyude@redhat.com>
In-Reply-To: <20260730204604.1729505-1-lyude@redhat.com>
References: <20260730204604.1729505-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 8x0ps2xnep09WrXbk9GXcO5Sv8ZBcE8NPy9U-mAdsxk_1785444373
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

Sashiko caught this while reviewing the patches for enabling atomic by
default - if we fail to allocate the DRM device pointer, we'll attempt to
free the error pointer that it returns rather than the actual struct.
Let's fix this while we're at it.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V3:
* Don't use devm, that will just break during unbind (Sashiko).
V5:
* Fix silly rebasing error
* Go back to the old style of error handling since we're not using a second
  allocation for drm_driver anymore.

 drivers/gpu/drm/nouveau/nouveau_drm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 4d1ad718e09b7..a348115518ec4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -749,7 +749,8 @@ nouveau_drm_device_new(const struct drm_driver *drm_driver, struct device *paren
 	drm->dev = drm_dev_alloc(drm_driver, parent);
 	if (IS_ERR(drm->dev)) {
 		ret = PTR_ERR(drm->dev);
-		goto done;
+		kfree(drm);
+		return ERR_PTR(ret);
 	}
 
 	drm->dev->dev_private = drm;
-- 
2.55.0

