Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF5AC43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F02410E432;
	Sat, 27 Jun 2026 03:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mgWfATN0";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19ADE10E429
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:31:21 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E17861A0A16;
 Sat, 27 Jun 2026 03:31:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AE35D60233;
 Sat, 27 Jun 2026 03:31:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EFDB3106F1174; 
 Sat, 27 Jun 2026 05:31:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531078; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7t4wxccSVE+8YpNtCCYNB6F0KQiLmWtDWy0z8sUDzNs=;
 b=mgWfATN05p3uSCk5D3rXBj6g9bD4yIVBqfuItCRyvbI6KDsvC2fv1WWPSdfDIE9lOuelxk
 6M5fTRm134YoTK8EI195rhSbrE58n0mFbm6B34X8hm6H63IPLSDiNkVozzs7KKaYeQ8c7Q
 NM6PxmnDoN3KSjZRGp6DO574Acr4cG3x4NunZibheX3PF/7ixFUrbl5xuCt+VU5Z1XEalE
 kVCv1g/zl/Y8RfRpia+81QBgNy/LlupUqQqB3BNoqtPXwiuoicpNT/7ayocTbKjrHaned5
 e/8q+m4aEEBYKd1S3v3IEtFBTc5B6aKp5neatpwGDkvDJAzqbUW7Z3eEP+xb1Q==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:29 +0200
Subject: [PATCH v5 12/38] drm/vkms: Explicitly display connector status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260627-vkms-all-config-v5-12-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
In-Reply-To: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, victoria@system76.com, 
 sebastian.wick@redhat.com, victoria@system76.com, airlied@gmail.com, 
 thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, llvm@lists.linux.dev, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=oxr/CF0EOleBJpYQ0o3XQ1eFlhGpl9bHjVK5vcH/zUw=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0Pe03kOlBSLeLny4z2YzohoyX0ZyfDtpYSnn
 eu936/sl3iJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D3hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOKHmg/7BakTXcTMLBqo/YspJqXwtq3VhskmGJx
 cDXjP+hdjJZiCCfZC8exAZqDyk2BOPqq1MyHjCDkNfGR7dVvfAf5HLu6V9G30CvjiKDLmyuBQAh
 4O3zD+2J4Bm9VIIBsGTQAeQkzFlrUMhU6SksHh7ZjgflyQMwLtrU4rqko0GNkP8JiycImGRB3BZ
 t56vZfAdO7lln+YLwgCZor5DJOKgSkOINUqtvKZUa43bhlWTCG4HWTLPvFMLd2pVKweqaMINb5n
 vs1FYS38teJqemDVRqz5kPd99kopiq3MsqdLRtgJdORRFkSwOKWv8gQxRCkuvZ4unCg2w8+GeMd
 3Yn/l/bxxAKsYZHuUFSKIcwyAK/Xe1skcMAE76fw60xqIPhiLNGmltfp8cniXF8VQw87xNsFIs2
 uK+eHvKILuQaNngeRTBmy2D5eqb62z/O0RSiz1aHEVqcL7cNpdqev5fA71zrpLPTvQAiDmXkWnU
 rJdQkWXSZSiY4uSfg9PttW4hJ0LTYTTXma3jH0MZoGqQIep+lJ2ZBconXZs+ZYAcMczF6/uq5MP
 +BPmMol12Vgq8fWZks2/1wo8MjyPy2H2E6ahRhYQl1QkMRuYuh1R6KPJcSu2pN6i1Xh1vEDFsQQ
 OmmkkiOEC1tG1tNvtcY4R55Joeb1Mc0TA0PBgL3z7MUc20IQdOcs=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

Debug information are mainly read by human, so use full name instead
of raw values for connector status.

Reviewed-by: José Expósito <jose.exposito@redhat.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 4c6f3ead51d7..9071d6864d52 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/string_choices.h>
 
+#include <drm/drm_connector.h>
 #include <drm/drm_print.h>
 #include <drm/drm_debugfs.h>
 #include <kunit/visibility.h>
@@ -368,8 +369,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 
 	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
 		seq_puts(m, "connector:\n");
-		seq_printf(m, "\tstatus=%d\n",
-			   vkms_config_connector_get_status(connector_cfg));
+		seq_printf(m, "\tstatus=%s\n",
+			   drm_get_connector_status_name(vkms_config_connector_get_status(connector_cfg)));
 	}
 
 	return 0;

-- 
2.54.0

