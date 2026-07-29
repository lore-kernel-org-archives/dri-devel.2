Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1E4C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E9C10EB06;
	Wed, 29 Jul 2026 08:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="pQQAsUsZ";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0562510EB06
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jY
 IeGNTvuuzaSmmfDPikq4VasOlaegKTO3joNGMAJBM=; b=pQQAsUsZlZ2DmmeBTA
 LfZ7NzAumj3TFWGOqFYQPJHgOTZdcVzISkJ8rhgscLLhedXSxxkiz3FfoA7i9ZVF
 MEfxvrCVfq+UepdC8fuj4TZNVsFpxC94IbEgjJ+8EsyWeW6Dfk4C/OmnRo8TT1fE
 vv+QWHA0ksSR+ARACksRXK/mA=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wDHu0yhvWlqbOVpMg--.26952S3; 
 Wed, 29 Jul 2026 16:45:25 +0800 (CST)
From: oushixiong1025@163.com
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 2/4] drm/log: Fix division by zero when scale module parameter
 is 0
Date: Wed, 29 Jul 2026 16:45:18 +0800
Message-Id: <20260729084520.688087-2-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260729084520.688087-1-oushixiong1025@163.com>
References: <20260729084520.688087-1-oushixiong1025@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHu0yhvWlqbOVpMg--.26952S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy8uF1DWw1UAw45GrW3KFg_yoW8Xr43pw
 4xAry5XrW8tFsIya9avF48Cwn09a4xtFZ8KFy7twn3urZ8AF10yFy5t3y7uF17K39xGF4a
 ga9xtr4UWF12ka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsUUUUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-QWNnGppvaWwewAA35
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

From: Shixiong Ou <oushixiong@kylinos.cn>

The scale module parameter can be set to 0 via kernel command line or
sysfs. When scale is 0, scaled_font_h and scaled_font_w become 0,
causing a division by zero in the rows/columns calculation.

Add a custom param_ops setter to clamp scale to a minimum of 1 at the
source, ensuring scale is always valid for all users.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/clients/drm_log.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 294b3be1a6b3..a04f651e8265 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -26,7 +26,27 @@ MODULE_DESCRIPTION("DRM boot logger");
 MODULE_LICENSE("GPL");
 
 static unsigned int scale = 1;
-module_param(scale, uint, 0444);
+
+static int drm_log_scale_set(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_uint(val, kp);
+	if (ret)
+		return ret;
+
+	if (scale < 1)
+		scale = 1;
+
+	return 0;
+}
+
+static const struct kernel_param_ops drm_log_scale_ops = {
+	.set	= drm_log_scale_set,
+	.get	= param_get_uint,
+};
+
+module_param_cb(scale, &drm_log_scale_ops, &scale, 0444);
 MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, default is 1");
 
 /**
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

