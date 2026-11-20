Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F760A3811
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=P9W9WMta
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36911112C61;
	Fri, 20 Nov 2026 18:04:11 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F14112C61
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:04:03 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 25D321A1756;
 Fri, 20 Nov 2026 18:04:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EDB65601B9;
 Fri, 20 Nov 2026 18:04:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A801111BC09FC; Fri, 20 Nov 2026 19:03:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197839; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=EWvTyJ0GKSZ0OW9hy14bottUtec95h3CpCl/9rBJjxg=;
 b=P9W9WMtas5JI8irOOHVzjhnj5lJfAPEKbVtuVoaGThNK6KVLDad5IAlQJAe/4b7xGt0v6f
 lfP72nsjnXgbZSbKkaYsL8HZLdjam4OAdrxRAMEECA+m8t5cFvbfSaIul/0hFggs5Hg8M6
 Ck9PEgHBaW80dgQyY+BSU6P+R4CB1Ashft35xsRgkHdgZlngBYEwh8KjSpuAtz0MhOuCfR
 RQ1cINtZicmfYQoy+SPwPWE4EsFEEwV0MvT5cOkUpSAkLpuTLrcDAnioYIQp24/d+IVtcB
 53Btq5083RoDtjNndmsO/NZfItr1VR4V12G+TNM68gQGAyqzKQ5ttb1SN6D7gQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:58:56 +0100
Subject: [PATCH v6 14/43] drm/vkms: Add error handling in plane config creation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-14-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2118;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=tJ6CmTl8tZxoxLjfFVZLDN6OYWoWi2kn4tyF5DKaWI0=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr/M5fxgGdZQwxOEDXjpj2q9XdrXZF3dhvDi
 VTjE3JoX6CJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLzBBAAtQUiY8IycgCKZvm2cEsLaGPaRAacj5U
 24hdcs3OtVaNAAvcSZOrCQ9wVivgqDbNU8cQSKNn4AXqyhKhkS6GcgSAHvlLPZ61NsRhoha8X65
 gCmADE3pgA5I7oXkJocjSwsaxGVPcvfVEo904PC3OBgBOAC/k4C48bHPcS5AMf4Z6KCtjGKtGRl
 N3Di6sie6PwpkTbk/RlYGMz8OB1JoL9LHLDx58AXGGY9sf3bZX/rCtpDrDwN5WWfsITv28W22bX
 7sE4GImBld5nod5ggGidCNWOtxw+I/vMHoN5fAEKrYsXyEmkLw0LBR/Hp/armvQsnr/wdJ9MY64
 rI0wk7M+fPVBldJQtIltd2aTaBmz3/nzbdnPYMa0wJvmIb1u2yFUwcL8Dmzp1vScG00qen7eyMy
 2Hwj3CZJ7TbOsiRjqTYtXgMmq7Otk5J0DKF5No6iBx6kO3G0Ou/qmeoom3FoMTCA4fhriAY0f6A
 5N4sizlLkfi0Sq4tJktPTOj6Ix9gAN5k5c0mK9q3ebv9q3pH92ETgIRTOzFr3x+dmKZEbSxx71h
 RYiQqUrG5Lxs6m7CB0Zf6cdkvoXeep47hU15YiJnD5oVY6SBLxD3Egq6Ouart9d6eMpEI6gelH6
 R5wDR7sa5U+FCGeyDuy57+pJvC/wd4L2oDGHLq/v0mRAnq2y0s5A=
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

Properly route the error path of vkms_config_create_plane() through a
fail label to simplify future work.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 12 +++++++++---
 drivers/gpu/drm/vkms/vkms_config.h |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 50cde689f482..03f2d0f0e327 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -424,13 +424,16 @@ void vkms_config_register_debugfs(struct vkms_device *vkms_device)
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
@@ -440,6 +443,9 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
 	list_add_tail(&plane_cfg->link, &config->planes);
 
 	return plane_cfg;
+
+fail:
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_plane);
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index de6a89819daf..49510a0957c7 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -288,7 +288,7 @@ void vkms_config_register_debugfs(struct vkms_device *vkms_device);
  * The new plane configuration or an error. Call vkms_config_destroy_plane() to
  * free the returned plane configuration.
  */
-struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config);
+struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_config *config);
 
 /**
  * vkms_config_destroy_plane() - Remove and free a plane configuration

-- 
2.56.0

