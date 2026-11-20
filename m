Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1C606A88D
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=y2BCqKNh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E35112C84;
	Fri, 20 Nov 2026 18:05:54 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6330F112C84
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:05:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D3F01C62225;
 Fri, 20 Nov 2026 18:05:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 10E6C601B9;
 Fri, 20 Nov 2026 18:05:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 59C8811BC0627; Fri, 20 Nov 2026 19:05:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197943; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=kU59R9B0ZGj/DStFfGWYpgpeLf3AWqEZ6qiHgIV7BCA=;
 b=y2BCqKNheon1ffznVYjaU7wq9bztjkm8uJkl9rbG9PThOjKaGWQjAWyyOqhlIIaqLHBKHP
 MMY+h6DVGcXBa3O7scAsl2ZJMysBBPVzMJIpisjtfKmGZPqjm5gFa8FtR5o9moVX4XqV7r
 iRrx8UTK8iQnenBZurymXDuQuw56I3yW6PHDyQihgerDmkHpeINpCEjFYNiMEIBRnoNeV3
 sVovF5quScr6kRPozburMZp228wKl6pVpvutw/R6bBakHfMPEgm8Iofaf6JlX8zvhZp29a
 93zruCoKHWyHKN2qMPXcWdcS1mVyAaQbX7pmSq54xNL1Ev98SkCK8lF9z7cDBA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:59:16 +0100
Subject: [PATCH v6 34/43] drm/vkms: Rename vkms_connector_init to
 vkms_connector_init_static
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-34-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
In-Reply-To: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Lucas De Marchi <demarchi@kernel.org>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com, 
 victoria@system76.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
 llvm@lists.linux.dev
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=AKXomGhTkxXeXR2/kPMqrcFHY6V0nkVDYPlGmwIr1i4=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIsCE4I/uPsDxWviWLS0ZrjBLOCTOouA7zNbR
 p3lvay4M3OJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCLAhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLzbQ//ZFy7J1MkThCl3HJqzZu38ximLCGmQ8F
 77reM1YrrVVfBKwXjKBKNSR8T6bkvOWKixvZQb7wL1Sw9KRcv85YhCxpyIFzI559b3UnnzyiQpr
 9rfRPXPVTD+vFDE0Ar/4GTr/3XmBtCJ+b2yYco/l+TbcKQ21t/rQpruZZOLIc2tBFKpDbAga6MN
 dGK7njWF6yTL1f/p4brU/RoUkCOM6/W469p/AQhnwR6Mcb4/FIOcM5CfmGuaO0226eCHgbpmDhJ
 6d6eHWXtnfabftrvjOnBdaaEwUcVhCGSnrDyh+4S2acINLejw8PmWdUw/dvDZ2D+U+OkQGtmp53
 p8+/DR7Xrdvb9ON8s5kPPb4SE7dg7qyL5cgO+NbeoYnnOjqYupWZXBDKm83VCX8njPezPH4CpC0
 Uq8SOuuPU7aXXmRogUUOewFpdHpgZKADKfmp/sg+6/4ESfc21BzaznlcKKfikvFAh5/N+xe6Ehu
 EU0iIGohRT0S8Ku2MhOWYnUNbRmCkedfkW2JkqvfIrBX0uIOqlgKnuVx64UWSDMIFG5lmk6gwlp
 amerQfnLKWSMm4hDizumVpnSC00aGjMcENKpAHIomTfXEuW2U8NBi21jK6CS9xjbbtySCj+zkHa
 9Os1wlm9rn7z5D4YBOlxeKNFfjTInx+7NusMi2VTeN0+cCCeZk/8=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the introduction of dynamic connectors we will have two way of
initializing a VKMS connector. Rename the current function to clarify
the case.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c | 5 ++---
 drivers/gpu/drm/vkms/vkms_connector.h | 6 +++---
 drivers/gpu/drm/vkms/vkms_output.c    | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index f5e99e77e84f..64d79b778551 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -75,9 +75,8 @@ static void vkms_connector_static_cfg_release(struct drm_device *dev, void *res)
 	vkms_config_connector_put(connector->cfg);
 }
 
-
-struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
-					   struct vkms_config_connector *connector_cfg)
+struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
+						  struct vkms_config_connector *connector_cfg)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_connector *connector;
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index 89d7f3a15d6e..61a8dd55d7f7 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -23,15 +23,15 @@ struct vkms_connector {
 };
 
 /**
- * vkms_connector_init() - Initialize a connector
+ * vkms_connector_init_static() - Initialize a connector
  * @vkmsdev: VKMS device containing the connector
  * @connector_cfg: Connector's configuration
  *
  * Returns:
  * The connector or an error on failure.
  */
-struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
-					   struct vkms_config_connector *connector_cfg);
+struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
+						  struct vkms_config_connector *connector_cfg);
 
 /**
  * vkms_trigger_connector_hotplug() - Update the device's connectors status
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 7783a2f6d343..2b0f7a8a80b5 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -97,7 +97,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		struct vkms_config_encoder *possible_encoder;
 		unsigned long idx = 0;
 
-		connector_cfg->connector = vkms_connector_init(vkmsdev, connector_cfg);
+		connector_cfg->connector = vkms_connector_init_static(vkmsdev, connector_cfg);
 		if (IS_ERR(connector_cfg->connector)) {
 			DRM_ERROR("Failed to init connector\n");
 			return PTR_ERR(connector_cfg->connector);

-- 
2.56.0

