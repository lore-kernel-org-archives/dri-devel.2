Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B53CD5BD0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 12:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1302310E0FB;
	Mon, 25 May 2026 12:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WIonNY/4";
	dkim-atps=neutral
Received: from smtp.smtpout.orange.fr (smtp-79.smtpout.orange.fr
 [80.12.242.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7502D10E0FB
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:35:23 +0000 (UTC)
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
 by smtp.orange.fr with ESMTPSA
 id RUWdwkexnb370RUWdw6JPe; Mon, 25 May 2026 14:35:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1779712522;
 bh=ljvFcHVr5NanSDqM3RBqxRSwTWh7Ck4wjtjVJuilOnw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=WIonNY/4gKDnfqCVHquYVLbYKe9nCgMH5xepGWVv/w096T2UKTolcCStk+GyLi5l0
 vQbrw7FbnzLiPeZY+RJi+PpvZw49lJP89HSXBntrI7sXBeoC3Uj2LOTIDLQXkA/aM3
 VKbaxv31PLQFBr9cVOie//0eO9jqEzN20lCsgt6sXNFoTez8A40Y2ozcXSrlSnGARe
 4IWetzYobZFiUrKIa79A7YKWq37adtSgYBxq0HYWI829T9PwIctZ4GmBJJxZEOwmvc
 vZN3pGJXaX9feHVrwzs1hvFDlObXadBpryj2JXIkkrX4ovIac3q79zpJLxsjixYqPI
 agIenAIN/4jQQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 25 May 2026 14:35:22 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/xe/configfs: Constify struct configfs_item_operations and
 configfs_group_operations
Date: Mon, 25 May 2026 14:35:15 +0200
Message-ID: <ee83bb3bc0518db4a0a73c3e8df814a45549a064.1779712504.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.54.0
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

'struct configfs_item_operations' and 'configfs_group_operations' are not
modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  34095	  15704	    128	  49927	   c307	drivers/gpu/drm/xe/xe_configfs.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  34447	  15352	    128	  49927	   c307	drivers/gpu/drm/xe/xe_configfs.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/gpu/drm/xe/xe_configfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_configfs.c b/drivers/gpu/drm/xe/xe_configfs.c
index 32102600a148..5c2072f18a57 100644
--- a/drivers/gpu/drm/xe/xe_configfs.c
+++ b/drivers/gpu/drm/xe/xe_configfs.c
@@ -838,7 +838,7 @@ static void xe_config_device_release(struct config_item *item)
 	kfree(dev);
 }
 
-static struct configfs_item_operations xe_config_device_ops = {
+static const struct configfs_item_operations xe_config_device_ops = {
 	.release	= xe_config_device_release,
 };
 
@@ -855,7 +855,7 @@ static bool xe_config_device_is_visible(struct config_item *item,
 	return true;
 }
 
-static struct configfs_group_operations xe_config_device_group_ops = {
+static const struct configfs_group_operations xe_config_device_group_ops = {
 	.is_visible	= xe_config_device_is_visible,
 };
 
@@ -950,7 +950,7 @@ static bool xe_config_sriov_is_visible(struct config_item *item,
 	return true;
 }
 
-static struct configfs_group_operations xe_config_sriov_group_ops = {
+static const struct configfs_group_operations xe_config_sriov_group_ops = {
 	.is_visible	= xe_config_sriov_is_visible,
 };
 
@@ -1054,7 +1054,7 @@ static struct config_group *xe_config_make_device_group(struct config_group *gro
 	return &dev->group;
 }
 
-static struct configfs_group_operations xe_config_group_ops = {
+static const struct configfs_group_operations xe_config_group_ops = {
 	.make_group	= xe_config_make_device_group,
 };
 
-- 
2.54.0

