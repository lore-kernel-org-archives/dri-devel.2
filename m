Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A73C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 19:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E3510F064;
	Thu, 30 Jul 2026 19:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="K2bknje4";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C266F10EFB2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 19:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785441353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pz8u2PCNU3eOGp8lK0CAqX+n/JHdMOCrvaZNNO/A7E=;
 b=K2bknje43FsaPGjCU7erXtaCl47uMvP49UqnIdW4DOKjZ47BFhLRFdFFv0MtZOV+QIlTZ5
 wi1SnmIOqXfcFLvCduK1wTdYuW24TrsIB7XtDblRPwboIBPrEHRsUt3K8AsfwBtzSrrCjZ
 x43fKasu3qnmDBjRsfhATyPEjI0E9wU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-zPNRc_WzMX2CG44a7SXSSQ-1; Thu,
 30 Jul 2026 15:55:49 -0400
X-MC-Unique: zPNRc_WzMX2CG44a7SXSSQ-1
X-Mimecast-MFC-AGG-ID: zPNRc_WzMX2CG44a7SXSSQ_1785441347
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAA58195609F; Thu, 30 Jul 2026 19:55:46 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.88.35])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59EA4423; Thu, 30 Jul 2026 19:55:45 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Simona Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 1/5] drm/nouveau: Fix cleanup bug in
 nouveau_drm_device_new()
Date: Thu, 30 Jul 2026 15:51:05 -0400
Message-ID: <20260730195523.1467423-2-lyude@redhat.com>
In-Reply-To: <20260730195523.1467423-1-lyude@redhat.com>
References: <20260730195523.1467423-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: S34mryEav7eMjC6NQyGVaGi88BCP37W378nlrbqJ9gE_1785441347
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
default. Trying to fix this properly would be a bit of a pain, and we're
going to be adding another pre-DRM allocation here anyway. So, let's
instead just convert the initial struct nouveau_drm allocation over to
using devm so it is freed automatically.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 4d1ad718e09b7..9570850656126 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -723,7 +723,6 @@ nouveau_drm_device_del(struct nouveau_drm *drm)
 	nvif_parent_dtor(&drm->parent);
 
 	mutex_destroy(&drm->client_mutex);
-	kfree(drm);
 }
 
 static struct nouveau_drm *
@@ -740,17 +739,15 @@ nouveau_drm_device_new(const struct drm_driver *drm_driver, struct device *paren
 	struct nouveau_drm *drm;
 	int ret;
 
-	drm = kzalloc_obj(*drm);
+	drm = devm_kzalloc(parent, sizeof(*drm), GFP_KERNEL);
 	if (!drm)
 		return ERR_PTR(-ENOMEM);
 
 	drm->nvkm = device;
 
 	drm->dev = drm_dev_alloc(drm_driver, parent);
-	if (IS_ERR(drm->dev)) {
-		ret = PTR_ERR(drm->dev);
-		goto done;
-	}
+	if (IS_ERR(drm->dev))
+		return ERR_CAST(drm->dev);
 
 	drm->dev->dev_private = drm;
 	dev_set_drvdata(parent, drm);
-- 
2.55.0

