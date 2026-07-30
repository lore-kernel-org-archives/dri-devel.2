Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A29C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9695410F08C;
	Thu, 30 Jul 2026 20:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ibe2WKvb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6722C10F093
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785443445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Rslbn4Tu1YwerRYRd6bF7m2/jkRf+QSYz600R8qBXA=;
 b=ibe2WKvb+u2P3R9SuQ3dlN+zEBElVXiY85WX086vQHOriLlFSyaLym8/1+b87jpxktQWYb
 qLwxlI/MptutJku+Li9vDqVBirVXLaKbv0bbyAdVg9XzMp6H73Iz5G9czFDovjT1o8TJl1
 bTXUb/Yyb73XxmZFbJ8EtOa1EYuK8jI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-f22UFDI9M0u3KOfjH-6Xkg-1; Thu,
 30 Jul 2026 16:30:40 -0400
X-MC-Unique: f22UFDI9M0u3KOfjH-6Xkg-1
X-Mimecast-MFC-AGG-ID: f22UFDI9M0u3KOfjH-6Xkg_1785443438
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76B721800473; Thu, 30 Jul 2026 20:30:38 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.88.35])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1AF72423; Thu, 30 Jul 2026 20:30:37 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Simona Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v3 3/5] drm/nouveau: Fix drm_driver struct/nouveau.atomic
 parameter handling
Date: Thu, 30 Jul 2026 16:28:06 -0400
Message-ID: <20260730203015.1572240-4-lyude@redhat.com>
In-Reply-To: <20260730203015.1572240-1-lyude@redhat.com>
References: <20260730203015.1572240-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 3am-_clHc2b97kUfSnzUucLSuM8PIFE5iC6T7a-C_pg_1785443438
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

The way we handled the nouveau.atomic module parameter before was fairly
broken, and had a number of issues:

- It was only ever actually parsed in the case of PCI devices.
- When nouveau.atomic was enabled, it would add the cap for atomic
  modesetting to the global driver_pci structure. This meant that if one
  GPU on a system supported atomic and another didn't, it would still get
  enabled for both.

Looking into this exposed further silliness in the way that we actually
handle the drm_driver struct. We have one global structure for platform
devices, and another for PCI devices - both of which are literally
identical.

So before we start preparing to enable atomic modesetting by default, let's
fix this. Instead of sharing driver_pci and driver_platform, we move the
drm_driver struct we use over to the nouveau_drm struct, and then copy the
contents of driver_stub over to it. We then convert driver_stub to a const,
and move the handling of the nouveau.atomic module parameter into
nouveau_drm_device_new(), and conditionally add the atomic modesetting
capability to the embedded drm_driver struct.

Doing this is also preferable, as the next step for enabling atomic
modesetting by default will be ensuring that we don't enable it for legacy
devices that still don't support it. This requires only checking the atomic
modesetting module parameter after the NVIF device is ready, as this allows
us to check the GPU family that nouveau is running on.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V2:
* s/driver_pci/drm_driver/
* Dynamically allocate drm_driver struct, get rid of duplicate global
  driver structs to fix another Sashiko issue.
V3:
* Don't use devm (sashiko)

 drivers/gpu/drm/nouveau/nouveau_drm.c | 27 +++++++++++----------------
 drivers/gpu/drm/nouveau/nouveau_drv.h |  1 +
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 6940e774ace07..95daf2643e1df 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -111,9 +111,7 @@ MODULE_PARM_DESC(runpm, "disable (0), force enable (1), optimus only default (-1
 static int nouveau_runtime_pm = -1;
 module_param_named(runpm, nouveau_runtime_pm, int, 0400);
 
-static struct drm_driver driver_stub;
-static struct drm_driver driver_pci;
-static struct drm_driver driver_platform;
+static const struct drm_driver driver_stub;
 
 #ifdef CONFIG_DEBUG_FS
 struct dentry *nouveau_debugfs_root;
@@ -727,8 +725,7 @@ nouveau_drm_device_del(struct nouveau_drm *drm)
 }
 
 static struct nouveau_drm *
-nouveau_drm_device_new(const struct drm_driver *drm_driver, struct device *parent,
-		       struct nvkm_device *device)
+nouveau_drm_device_new(struct device *parent, struct nvkm_device *device)
 {
 	static const struct nvif_mclass
 	mmus[] = {
@@ -744,9 +741,10 @@ nouveau_drm_device_new(const struct drm_driver *drm_driver, struct device *paren
 	if (!drm)
 		return ERR_PTR(-ENOMEM);
 
+	drm->drm_driver = driver_stub;
 	drm->nvkm = device;
 
-	drm->dev = drm_dev_alloc(drm_driver, parent);
+	drm->dev = drm_dev_alloc(&drm->drm_driver, parent);
 	if (IS_ERR(drm->dev)) {
 		ret = PTR_ERR(drm->dev);
 		goto err_free_drm;
@@ -770,6 +768,9 @@ nouveau_drm_device_new(const struct drm_driver *drm_driver, struct device *paren
 		goto err_device_del;
 	}
 
+	if (nouveau_atomic)
+		drm->drm_driver.driver_features |= DRIVER_ATOMIC;
+
 	ret = nvif_device_map(&drm->device);
 	if (ret) {
 		NV_ERROR(drm, "Failed to map PRI: %d\n", ret);
@@ -877,16 +878,13 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 		return ret;
 
 	/* Remove conflicting drivers (vesafb, efifb etc). */
-	ret = aperture_remove_conflicting_pci_devices(pdev, driver_pci.name);
+	ret = aperture_remove_conflicting_pci_devices(pdev, driver_stub.name);
 	if (ret)
 		goto fail_nvkm;
 
 	pci_set_master(pdev);
 
-	if (nouveau_atomic)
-		driver_pci.driver_features |= DRIVER_ATOMIC;
-
-	drm = nouveau_drm_device_new(&driver_pci, &pdev->dev, device);
+	drm = nouveau_drm_device_new(&pdev->dev, device);
 	if (IS_ERR(drm)) {
 		ret = PTR_ERR(drm);
 		goto fail_nvkm;
@@ -1363,7 +1361,7 @@ nouveau_driver_fops = {
 	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
-static struct drm_driver
+static const struct drm_driver
 driver_stub = {
 	.driver_features = DRIVER_GEM |
 			   DRIVER_SYNCOBJ | DRIVER_SYNCOBJ_TIMELINE |
@@ -1460,7 +1458,7 @@ nouveau_platform_device_create(const struct nvkm_device_tegra_func *func,
 	if (err)
 		goto err_free;
 
-	drm = nouveau_drm_device_new(&driver_platform, &pdev->dev, *pdevice);
+	drm = nouveau_drm_device_new(&pdev->dev, *pdevice);
 	if (IS_ERR(drm)) {
 		err = PTR_ERR(drm);
 		goto err_free;
@@ -1485,9 +1483,6 @@ nouveau_drm_init(void)
 {
 	int ret;
 
-	driver_pci = driver_stub;
-	driver_platform = driver_stub;
-
 	nouveau_display_options();
 
 	if (nouveau_modeset == -1) {
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 5fc75dc750ed0..5cc0001134e74 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -216,6 +216,7 @@ struct nouveau_drm {
 
 	struct nouveau_cli client;
 	struct drm_device *dev;
+	struct drm_driver drm_driver;
 
 	struct list_head clients;
 
-- 
2.55.0

