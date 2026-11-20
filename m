Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F2460A6F61
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GOmfKRR3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61ED0112C66;
	Fri, 20 Nov 2026 18:04:35 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9DE112C6C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:04:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 918671A1756;
 Fri, 20 Nov 2026 18:04:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 60EA3601B9;
 Fri, 20 Nov 2026 18:04:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E5DB711BC0990; Fri, 20 Nov 2026 19:04:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197862; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=VxvB3jeuaoZKF1Y80P48kAyWqaNMXNm9heNN4Bt5VPQ=;
 b=GOmfKRR39uEh79nQ5VS7qxRSBn53MS3obcc3+ILYBXYavhK6fZVFJzdiXXTQnC3ZFqR9Os
 lhPQJTCZ1xSH0Z7uqvK9iz6hiCgHIT1i8xgQlgs/sOGk+xuqkIFoSKdNtscbmdLF3P0+hR
 +UXry6+inwRL4eFQwAwhNjWgG5vOOykhPMl/FNxthyLuNmn5ukp+kZYniEn3BoI2RTsod/
 d/BjuJ9qrYtl0GYOJP/ij5n/l9izRHrcj4KpijAg6yoKTydsxr0rPuF1jzQNV1yGUfg/v7
 I8hrYnXDGsBChhdY0ccygLeYtiJFOgk6nzVT3eoDufoDLri8a+2pumA3v3qCZg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:59:01 +0100
Subject: [PATCH v6 19/43] drm/vkms: Use plane folder name as plane name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-19-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=LDiCl7pqKtJMqRvE3mr2TEpnty9XeoWtToOQc8swqm0=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr/uT/GiwWpk9F0PAnSY9Ce57lQHeRWwPXcU
 staq7AylL+JAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOJF9A//VV8Qu812gGTw/xKh/njTNShxFXd8n/e
 t+4hl5NwiIwrTAKlz5IC7pCZq20u8IDeK45jtVVWn8xIwN+wE7VO7TkA6Scveke7Oc9V/QCJTqb
 jvqlgQRR9DUpojMWHq8ohepesoDWlKDs7PTUaHV9BGod385iiuWq7FqNDPccoJ5l6F6BnMYVUBq
 NnqlGAboXEYO3jR6kybZSiVCg9P+U+rztaVdg1Jj2+BAr+yg+2OVS8bbhpyfQ8XMgNH1YdRtg+G
 1VPF0rzyuvYz59a2FLl7mLt/TpFxa5HCxcb+5mdrVsua/reJtb2UlIUfVJRtQDS6SEay1r/U7g+
 c8EMpicNbEEVvwkdWJvnb+NrfJHgnFQEPLvrGGotie55i4aVhfPLqwyT2xgFpxYiMcKxv2KG1SM
 PSjuk2nfdzQNUE6T3AR99P+nIMIjm2Q6BKtlfKjbCvT7/uGWz+74aba6fSkxj9Xyaa9Rk/qVWtq
 FGPCAWOLein0sN2BrOKrwzUAi+js4uMa4c8NeIZlsicag6Kyy2S4PWBzHE1iOiibD8YufXbiF6I
 WaiFfEnpny3M7eUQVBDvsl++cKL/9Xfq+ltBbLGrEgwsvv2KdVhcs2hy55TgVK9q67E9eziNMvo
 /5byyFbGZ1AxZMCfdDe+L26FL0WX79zWkMDQHnWM+Uy/UHJ0yJTI=
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

The plane name is now directly derived from the configfs folder
name. When a plane directory is created under
/config/vkms/<device>/planes/, the folder name is used as the
plane name via vkms_config_plane_set_name.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms | 3 ++-
 drivers/gpu/drm/vkms/vkms_configfs.c    | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index 26e7f81b5b7d..55e4183046ec 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -98,7 +98,8 @@ Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
 Description:
 	This group contains attributes corresponding to the
-	plane <plane> of the VKMS device <device>.
+	plane <plane> of the VKMS device <device>. The name of
+	the directory becomes the name of the DRM plane.
 
 What:		/sys/kernel/config/vkms/<device>/planes/<plane>/type
 Date:		Nov 2025
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index a7ddcfd4e86e..3a1a34643cce 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -375,6 +375,12 @@ static struct config_group *make_plane_group(struct config_group *group,
 			return ERR_PTR(ret);
 		}
 
+		ret = vkms_config_plane_set_name(plane->config, name, strlen(name));
+		if (ret) {
+			vkms_config_destroy_plane(plane->config);
+			return ERR_PTR(ret);
+		}
+
 		config_group_init_type_name(&plane->group, name, &plane_item_type);
 
 		config_group_init_type_name(&plane->possible_crtcs_group,

-- 
2.56.0

