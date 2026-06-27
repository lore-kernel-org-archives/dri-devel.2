Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC0FC43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4477B10E428;
	Sat, 27 Jun 2026 03:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ppq/X1ip";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA3010E41B
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:31:11 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0DB364E409E5;
 Sat, 27 Jun 2026 03:31:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D441760233;
 Sat, 27 Jun 2026 03:31:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3EEAA106F1173; 
 Sat, 27 Jun 2026 05:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531068; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GjZ3Li0hgSFG+5Kg7ETwAe+lLOQj73cG0WZcoLSfcXY=;
 b=ppq/X1ipGF3iKp+kGv0c25M1V/c1Sq4H91lMH/v1vcf1LWaFhRDClGReSMeDWuoXsQZ0Es
 ZMVYL+DDVMKy6zjDBU/h5AEJu1EcTszNL/huFGqaakA2w7gAyayJKE+KgB7nNr+DXcVw5J
 5UI8eviOQhStoDTxg3xdBgqvjhw/vPyzExOX4tGjWkmDnELlRckS6Oe9DfssC0/V7vF5Mj
 YrN/WOdR+jC2t1WULAZWlauNFDnoMtbalWzMMgLOboWuaeHKWkbh9mN8p2TzCqKVqgwpxm
 lWDYj+ebTG00EPW8UqhmX1J9rheqxZirNPhfeBjtImgVsnWB0u2ViZYS9wb2fw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:25 +0200
Subject: [PATCH v5 08/38] drm/vkms: Add error handling in plane config creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-vkms-all-config-v5-8-854aa0840926@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>, llvm@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=LLCs59HPPrtC3R4f8VpEHvL6MwP8Mnd84ez61GoVGBU=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0PdDKSWdqTqaUvS8fdk/TcviTi37rTfMk3s/
 WyzHb6bB+iJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D3RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOKTdhAAgHCx9KfVwso11uvcNybor36VUrIRrmh
 MEH5sxALaswhF5Qjh6L1bPiajNiK1ljYf9HhKQ+kOoTAwi5ONB169d/yu2dzYOdeC52pUSkhU2V
 z4Hd70Wq9afnJvKflDK61m1CYa+warWiGgwsahNz5XDP0eOa/T7/kJFF7bbQbaqoPaNw7QNEY9s
 XTGaV71GO4oUc4VzYkwf9jZXUsdVoexIN370cxQVvDEh79FEasAy0K9TgwPgit8D2BW8Pd/OKSL
 4HKcz3EHdTFNpGb5DugX4W/j6HsN/fjo7Q8zc1BM2AxSJySwAwuobPLHwMNNJfZFfjzArdBREaU
 KpUhZfxrkPVn3mq5cn2+mob/SpZTqjhmcVfNiSxnR8TuZC75TJ2Hr63nQYIB3P6NA7HivdVMd7O
 acpCE8B0ArWd2FhLrYXUtT2lf3GFEf0hb65bq04A+NNuuVrV4ygCMEnG53HMDu2FaGpIzkxWUD6
 /dBMXgr3UnEAfqeAHnKp1ldRmUM9cPtOaXHcFGWfECVAX4pCgeAJGuY25AXYH7MWqRhMjdS9ZOB
 6fLmPgvnfmwxZfBb9PFDP8XR3dloGC+0N6RkdcUtr7vUC8YQ7YtrlSv3OJ8BAUD07X5TlZnSRhp
 0tWVaAjmc7xEIfJJiMjjmq2PQNjt3u/HDJbhfgxzwuit9Sq0SZU0=
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

For future patches, it is useful to properly handle errors in
vkms_config_create_plane.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 5a654d6dead8..1fd2ed1167c5 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -384,13 +384,16 @@ void vkms_config_register_debugfs(struct vkms_device *vkms_device)
 			      ARRAY_SIZE(vkms_config_debugfs_list));
 }
 
-struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
+struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_config *config)
 {
 	struct vkms_config_plane *plane_cfg;
+	int ret;
 
 	plane_cfg = kzalloc_obj(*plane_cfg);
-	if (!plane_cfg)
-		return ERR_PTR(-ENOMEM);
+	if (!plane_cfg) {
+		ret = -ENOMEM;
+		goto fail;
+	}
 
 	plane_cfg->config = config;
 	plane_cfg->default_pipeline = false;
@@ -400,6 +403,9 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
 	list_add_tail(&plane_cfg->link, &config->planes);
 
 	return plane_cfg;
+
+fail:
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_plane);
 

-- 
2.54.0

