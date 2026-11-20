Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37753606A337
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OKB4aw8n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB39112AE7;
	Fri, 20 Nov 2026 18:02:43 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF49112AE7
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:02:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D2A1E1A1756;
 Fri, 20 Nov 2026 18:02:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9D8F4601B9;
 Fri, 20 Nov 2026 18:02:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BAD7A11BC0990; Fri, 20 Nov 2026 19:02:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197749; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZzO+U2Lnfg9plIWGSv28AxEM5GDbXrtUBCUhiCBUCZ4=;
 b=OKB4aw8nfnHW4r6k1wydfMfX53z8laHDuf1eT166uhowfo8BI7MPRc5B+HfXkS1OWrmbUd
 uFkKeI0wJ35xyjOXOytcjtYAtOtzSzn9fUNS/vmEwbGt9mkut8tvEsQJD4Y7naXgD/wmpZ
 I4tjSDPz2cyVz/Awdlc9CeGtO8zZDLmNOOLa4dLPCUrbsYuv2uXQkQoZRKhvY0G45aoTAq
 k5xNWiRMm1LwJwz14FUOfsNuDbJfOyWRhOEBJE4mwN3nRDaSHuwU2keUHowvY/T2EL1uyG
 WWg6DrxhrFN6/rtpkLQowUX4y1cMEJpw3nrrJUDniuQQlzOhuiUb2PEpwdegtg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:58:46 +0100
Subject: [PATCH v6 04/43] drm/drm_mode_config: Add helper to get plane type
 name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261120-vkms-all-config-v6-4-78ace90f4fc1@bootlin.com>
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
 llvm@lists.linux.dev, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito@redhat.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=fQRMRUWWIUPvgnVPMhxGhrvkstz6tN1uMOHU/Q4xn8s=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr9QMJK1mnrn2UUoYaUcAetdOFePpEvtOiKt
 t7a8tykH8SJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOIIAxAAq/lblcMA3XwihiKvUX6lDYL5oLvzMeJ
 iJXhsiT4Tvk2dYQVXIn8DidFyJ9l9armgd6r2oNHaWTqBSieHfZz/fFnTP1VQnkKyjW5a4YjHG1
 4VoA4z8XeBr+xOFkPAWx3dl8EKt8J2wzIea2oInkrS+kGM3ZimAuwinkH6YHBaxLADzZKI+QS1H
 nDvsdhKF0ij7CF2Q8MOXEh/GqgZTxxa9LCZxVly63FASH2lE5w8poBeImOQcQTbY+i+rEYW36MK
 TYqosIr3n3UwVjuKU3rEU1NcBWUYNJJD7qYvC42isogY/RtklK2SzcwndZhGUF1aSSaqeLYOcPr
 yC0bJRFVlQwzdQInbB+093NkH/NQUbix2Sxa0DCNIcnC+8vN/3bosQAg+pdRYox9QgBRxog09OW
 xKNiFxD/Fr4LHu4dWbJviyuvrb3+UfgJbU4GmGzll+tZGY8DmB2irqlhvBzzsz3WRH/aVwgo5Hr
 6VHDA4H2Yozf4VnKhRXQGHyutyuHgh4P6nQ2T7AyzPuHueTjIkH5/6jTDuTcdkp7PvM7hfSwigK
 sdBvVELbap+AWZy9q8iPKCHbe3fgIkllVj0owARXs3FClPfSRAoPvYxzeGkqG7iocRjlW1YwJxy
 gDT2W9Wbj0YAqugxHmnWG2Z8cGhY821mND+c9t+TPlgKOpgaeJy8=
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

Create and export a helper to display plane type using the property
string. This could be used to display debug information in VKMS.

Reviewed-by: José Expósito <jose.exposito@redhat.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_mode_config.c | 16 ++++++++++++++++
 include/drm/drm_mode_config.h     |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index c1e993a78702..0d814424c698 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -419,6 +419,22 @@ static const struct drm_prop_enum_list drm_plane_type_enum_list[] = {
 	{ DRM_PLANE_TYPE_CURSOR, "Cursor" },
 };
 
+/**
+ * drm_get_plane_type_name - return a string for plane type name
+ * @type: plane type to compute name of
+ *
+ * Returns: The name of the plane type. "(unknown)" if type is not a known
+ * plane type.
+ */
+const char *drm_get_plane_type_name(enum drm_plane_type type)
+{
+	if (type >= 0 && type < ARRAY_SIZE(drm_plane_type_enum_list))
+		return drm_plane_type_enum_list[type].name;
+	else
+		return "(unknown)";
+}
+EXPORT_SYMBOL(drm_get_plane_type_name);
+
 static int drm_mode_create_standard_properties(struct drm_device *dev)
 {
 	struct drm_property *prop;
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 084517beb924..545a5b684acc 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -30,6 +30,7 @@
 #include <linux/llist.h>
 
 #include <drm/drm_modeset_lock.h>
+#include <drm/drm_plane.h>
 
 struct drm_file;
 struct drm_device;
@@ -1011,4 +1012,6 @@ int drm_mode_config_create_initial_state(struct drm_device *dev);
 void drm_mode_config_reset(struct drm_device *dev);
 void drm_mode_config_cleanup(struct drm_device *dev);
 
+const char *drm_get_plane_type_name(enum drm_plane_type type);
+
 #endif

-- 
2.56.0

