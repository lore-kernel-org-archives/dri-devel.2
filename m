Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61631C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EFCB10ECE4;
	Tue,  1 Sep 2026 13:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="PXbAy1Ni";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 456FD10ECE4
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 13:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788269992; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nry4ugQOl/Iu/E673t76DZXpR0nhQujHqDzcSOCFgv9O6ay9n4UMKegSg/zbZlIqMUxqOCB9DwyuhfMjrUr1pCo3ZMG+O+KOTyMj4N+AyaF518TVL9/Evl/VqlGaAjFXkdmkZrzflOQ8wwphv8sgyOpg+0zeFf57tjVpGubfhJY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788269992;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=UuLBKWOVqpuqjOy5jkxqd2Ih1GKAPwy4tleGufy6v/o=; 
 b=dzIMoZCDyW2KYaYk8Ei7a8DN1wnDIMwNRyDG5DBGf5vEarZxdebrJ3qjlsHvtNc34AksVy8MF5RkwnFMtkAMTrghT4++7w4nwJ/ZIo8b+z0vDYS77dPkUbSohjLqgDfWxrsi7/QMxgsmQYEpIISVnSUegEjqWwNLRB4UNTfTHGA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788269992; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=UuLBKWOVqpuqjOy5jkxqd2Ih1GKAPwy4tleGufy6v/o=;
 b=PXbAy1NiGOaiMI/0E8brgr/lVSX77r4o2IxcjtUYCagrkqDIdUczP233hY6XJ1kW
 FnCbI9T2Q5iCMlJCv/k2Gt7zvG3NSBX/2Mgn5F/2E4OpbAQuvObfyDodMTbAk8x+KTr
 lBm9rVEZpxXAnU2W935EFqDoA9Eryg1iBeeDj+rE=
Received: by mx.zohomail.com with SMTPS id 178826998951974.78285142484401;
 Tue, 1 Sep 2026 06:39:49 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 01 Sep 2026 15:39:27 +0200
Subject: [PATCH] drm/panfrost: Rename "panthor" prefixes in debugfs identifiers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-panfrost-prefix-whoopsie-v1-1-138fb4c5a9f4@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNyw6CMBBFf4XM2omlJiTwK4YFlEHGpA87RUkI/
 261ursn97WDUGQS6KodIj1Z2LsM9akCswzuRshTZtBKN6pVNYbBzdFLwhBp5g1fi/dBmFA3F6X
 GWU+GWsj14n+nr31hWcc7mfTZ+yUiPdb8mUoMxkEIjbeWU1dN0aJlMee/QEdbgv443shdrGq2A
 AAA
X-Change-ID: 20260901-panfrost-prefix-whoopsie-26300bf2dce9
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

When gems debugfs support was copied over from panthor to panfrost, the
function and struct names were not adjusted to carry the panfrost
prefix instead of the panthor prefix.

Rectify this by renaming them. No functional change.

Fixes: e48ade5e23ba ("drm/panfrost: show device-wide list of DRM GEM objects over DebugFS")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 96a66d673ba6..f5f11ad5f9b3 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -794,7 +794,7 @@ static const struct file_operations panfrost_drm_driver_fops = {
 };
 
 #ifdef CONFIG_DEBUG_FS
-static int panthor_gems_show(struct seq_file *m, void *data)
+static int panfrost_gems_show(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = m->private;
 	struct panfrost_device *pfdev = to_panfrost_device(node->minor->dev);
@@ -845,15 +845,15 @@ static int show_file_jm_ctxs(struct panfrost_file_priv *pfile,
 	return 0;
 }
 
-static struct drm_info_list panthor_debugfs_list[] = {
+static struct drm_info_list panfrost_debugfs_list[] = {
 	{"gems",
-	 panthor_gems_show, 0, NULL},
+	 panfrost_gems_show, 0, NULL},
 };
 
-static int panthor_gems_debugfs_init(struct drm_minor *minor)
+static int panfrost_gems_debugfs_init(struct drm_minor *minor)
 {
-	drm_debugfs_create_files(panthor_debugfs_list,
-				 ARRAY_SIZE(panthor_debugfs_list),
+	drm_debugfs_create_files(panfrost_debugfs_list,
+				 ARRAY_SIZE(panfrost_debugfs_list),
 				 minor->debugfs_root, minor);
 
 	return 0;
@@ -915,7 +915,7 @@ static void panfrost_sched_debugfs_init(struct drm_minor *minor)
 
 static void panfrost_debugfs_init(struct drm_minor *minor)
 {
-	panthor_gems_debugfs_init(minor);
+	panfrost_gems_debugfs_init(minor);
 	panfrost_sched_debugfs_init(minor);
 }
 #endif

---
base-commit: 0116f19db5931348c937eafa1f76a9a19bf82c81
change-id: 20260901-panfrost-prefix-whoopsie-26300bf2dce9

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

