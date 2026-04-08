Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698A510F9969
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD50E10E6D7;
	Wed,  8 Apr 2026 19:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SF9zQbp2";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 297DA10E6D7
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 19:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
 :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u7pw0CfIdSLr4OFETtM4WJRAWr7L8IUM54hl6YYzK2A=; b=SF9zQbp2IBAZ6HP0OTWdc6VV3j
 7c55k/eVbF213YQRY3+VTkBuj7Pf1sSoEQHBd7wzp73piDvLphWbfEBja0OCD+VVHNU7E5Q/JIj8S
 oiufHthi6X+SwlbimbgfTaAy2pMiXUlpd45aaMqnSioQUU4wluN37C10KZmS1EeTE60nSExx2/PKj
 xijvr9ykkRxoCKFJ179xHdjdv++vGyCc7sJ3nguhdO9CgwxQhkZCy/0IeWsZsiK7NZHQNDhB6k86F
 7YfliVhTSzWf6hhbe/duQ2S3hKSoa53JQqpBx+f5ebJIC7bBAyF6nG8N+Z0bdfhdwNHIUcqyOdXh7
 NHOL/dBQ==;
Received: from 179-125-64-254-dinamico.pombonet.net.br ([179.125.64.254]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wAYcc-00Dcg1-38; Wed, 08 Apr 2026 21:31:30 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 08 Apr 2026 16:31:00 -0300
Subject: [PATCH] drm/vram: remove DRM_VRAM_MM_FILE_OPERATIONS from docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-drm_gem_vram_helper_docs-v1-1-4d667a768f75@igalia.com>
X-B4-Tracking: v=1; b=H4sIAPOs1mkC/x3MywqAIBBA0V+JWSfYyx6/EiGlYw1kxQgRhP+et
 DyLe18IyIQBhuwFxpsCnUdCkWdgtvlYUZBNhlKWStayE5a9XtHrm2evN9wvZG1PE8RiWldJ15t
 GFZDyi9HR86/HKcYP3P2z62oAAAA=
X-Change-ID: 20260408-drm_gem_vram_helper_docs-bc7f30f9c561
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.14.2
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

Commit 02f64b2d8605 ("drm/vram: drop DRM_VRAM_MM_FILE_OPERATIONS") dropped
DRM_VRAM_MM_FILE_OPERATIONS in preference for using DEFINE_DRM_GEM_OPS.

However, it was not dropped from the kernel docs.

Use DEFINE_DRM_GEM_OPS in the illustration on how to define a
struct file_operations for such a DRM driver and remove any reference
to DRM_VRAM_MM_FILE_OPERATIONS.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index d7fcced75e797ce1b86313612a577775c9c26487..bca802ccddee792b8a8f643ecb02a41915f7ba18 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -49,15 +49,12 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs;
  * To initialize the VRAM helper library call drmm_vram_helper_init().
  * The function allocates and initializes an instance of &struct drm_vram_mm
  * in &struct drm_device.vram_mm . Use &DRM_GEM_VRAM_DRIVER to initialize
- * &struct drm_driver and  &DRM_VRAM_MM_FILE_OPERATIONS to initialize
+ * &struct drm_driver and &DEFINE_DRM_GEM_FOPS to define
  * &struct file_operations; as illustrated below.
  *
  * .. code-block:: c
  *
- *	struct file_operations fops ={
- *		.owner = THIS_MODULE,
- *		DRM_VRAM_MM_FILE_OPERATION
- *	};
+ *	DEFINE_DRM_GEM_FOPS(fops);
  *	struct drm_driver drv = {
  *		.driver_feature = DRM_ ... ,
  *		.fops = &fops,

---
base-commit: 408df6213f56f467675dc0ecf156a8bd1984555e
change-id: 20260408-drm_gem_vram_helper_docs-bc7f30f9c561

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

