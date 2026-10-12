Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53DDCC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C16110F5B9;
	Tue, 13 Oct 2026 07:53:29 +0000 (UTC)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C03A10E606
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 15:45:00 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-170135e43c7so1027110c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791819900; x=1792424700; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZJlyzhoWQhc9t2V9V/IMOCakgx6bB3MzV1A39J6uch0=;
 b=fdSTyf6+VvxIVvQtwtytmc7PRBCzWuCFGZ11KXqNdLPNwPJxE3QCe37jRxVALhponY
 rQycuB+drCCAg8Ra6D0TXuicAooxEbbLHnUNRRB4AzNtMzeQ1ek5maHOOR8F9Nulbc3g
 /nxRFmdJySVMPLT3pHh9bf4iiWhn5SDQY7IwK14iIyqvDSpxTYOO0UdVSi9HK2CWPWiF
 B1C0ilNZynhyAx9HqoHXyzgoo44lzFc0kTcT7CFYNBKGY5AzRK/aM+siA4EYFkqMq8Qy
 b4F7Ixlw6UQ6BOy2vLB8yF4g31aoIlRiKzD9f6szxGvKEeQwdHpZva4XfPA4x2fypyuj
 6qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791819900; x=1792424700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZJlyzhoWQhc9t2V9V/IMOCakgx6bB3MzV1A39J6uch0=;
 b=CAN9SRtVhlPzRfQ/A8KP9kNPdroFIzE8gPEAy/Zf5EEeu4JKxexlmkQ3WCUP9/IjHz
 Zoai69w/6eVpbSN4v6TFa+167QSsMQAXG/m6qUxR2F64+Ie1pUxnAZNjr00MvT7ddr/r
 eg6Z7E/XkPTc97xRP/+HTD2HyPioFLTLRVDoun6F+7QEb4MDox1Ki8KHGbVK2P2QEyiB
 A/b8M18UMsnWuRlblYKcyTKwiRoEEuuanw4YWUuP65Uj+TUdNP/D1lPHECplQjEVHm2N
 7A05+BTRyWXb35sBnqrKo9c3Gi0RqN1sO5ZtY8vXi4o22l68G+E6a0ftZg8N2OgEZTdm
 3kUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkrG1xAsfteuZk7E5bd22gUQndTYyMHsPBVfGD7BxJKIpY57ux3r8cDpQBnFaWDTH5eguogDpSeuo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJD13jW3xKILeYKaC0VuTL2SXGiT5yT6xVOloBZZdRAR63h/fWU
 TTVQFXYDLYgujbbj7HonuDOaWDMGBe81Scg0QOrGMAq1x9p//YZ12893
X-Gm-Gg: AYBFou0CYBWFzc+tiSMB2S91pMBUB+7uMsxVeOqe7HZIGLNRW/2Yr67dx7mmHRrDLk2
 jxP+JHLj0l96hSdv31CNvHVZ5RJfwsqgQMJRvYn/AzqjgQUU8JeTBlQtucwfHTW5yzwMK+ypobP
 HxJZexmkzDZsSfVvxmRLpWnC6Y39o2DL2rzrGmO83neri5O7yhvTiAOOW65HxmQ490Vg3mxFjeu
 Mcp13O5oxNCAeoQAFbHwJgYlzaG6MWpqvJotyGhLwALOHmMVCWrtkL+LAxLFZetclZSmcXZoTQu
 HN5uknYo38iSjyKgYDVaXINBKjgGh3cwGdbKV+INbPhE6cuvrKa0qY/UewwRhcPa4joTLnDDcV5
 KV/Ylw7TbOTJbX/8EQGSiqU6jZpg7vz8xgNVfYQvhwsjMfMWgLRUkKUGlAW5HoQ50ZI9euWmHmj
 TY3uRHlMPyOVPIgsPAY+sAORiVoYs57ddNIHMBh7XlVPzGEyw+0FH/7HlbIzk+5jW9+rNA9km81
 COiPRUQWp6U/eXBs1eP5/BNxbJf54K8IuthmmisVLItGgnu5MibRw+6g4OToj3tOL+DbEY6rovM
 HQtloIk=
X-Received: by 2002:a05:701b:291b:b0:14c:aaa0:941c with SMTP id
 a92af1059eb24-16a64ba421cmr13044123c88.35.1791819899484; 
 Mon, 12 Oct 2026 08:44:59 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:c1bb:8d21:6c07:8107])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a567aef5sm30728040c88.19.2026.10.12.08.44.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Oct 2026 08:44:58 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] drm/vkms: Fix kernel-doc parameter and member names
Date: Mon, 12 Oct 2026 21:14:47 +0530
Message-ID: <20261012154449.42015-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

A handful of kernel-doc entries name things that do not exist. struct
vkms_output documents encoder and connector and misspells wb_connector,
struct vkms_connector calls its base member drm, vkms_crtc_init() lists a
crtc argument it does not take, the CRTC plane helpers say crtc_config
instead of crtc_cfg, and vkms_config_plane_get_type() is written without
the get.

struct vkms_device used a dash instead of a colon, so its entries were
being ignored rather than warned about. Switch it over and drop output,
which is not a member either.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
@vblank_hrtimer and @period_ns in struct vkms_output are stale too, but
they are already removed by Thomas Zimmermann's pending patch, so this
one leaves them alone:
https://lore.kernel.org/all/20260420131831.242882-1-tzimmermann@suse.de/
 drivers/gpu/drm/vkms/vkms_config.h    |  6 +++---
 drivers/gpu/drm/vkms/vkms_connector.h |  2 +-
 drivers/gpu/drm/vkms/vkms_drv.h       | 11 ++++-------
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 8f7f286a4..56805b0c9 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -269,7 +269,7 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config);
 void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg);
 
 /**
- * vkms_config_plane_type() - Return the plane type
+ * vkms_config_plane_get_type() - Return the plane type
  * @plane_cfg: Plane to get the type from
  */
 static inline enum drm_plane_type
@@ -373,7 +373,7 @@ vkms_config_crtc_set_writeback(struct vkms_config_crtc *crtc_cfg,
 /**
  * vkms_config_crtc_primary_plane() - Return the primary plane for a CRTC
  * @config: Configuration containing the CRTC
- * @crtc_config: Target CRTC
+ * @crtc_cfg: Target CRTC
  *
  * Note that, if multiple primary planes are found, the first one is returned.
  * In this case, the configuration will be invalid. See vkms_config_is_valid().
@@ -387,7 +387,7 @@ struct vkms_config_plane *vkms_config_crtc_primary_plane(const struct vkms_confi
 /**
  * vkms_config_crtc_cursor_plane() - Return the cursor plane for a CRTC
  * @config: Configuration containing the CRTC
- * @crtc_config: Target CRTC
+ * @crtc_cfg: Target CRTC
  *
  * Note that, if multiple cursor planes are found, the first one is returned.
  * In this case, the configuration will be invalid. See vkms_config_is_valid().
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index ed312f4ef..52ae97af2 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -11,7 +11,7 @@
 /**
  * struct vkms_connector - VKMS custom type wrapping around the DRM connector
  *
- * @drm: Base DRM connector
+ * @base: Base DRM connector
  */
 struct vkms_connector {
 	struct drm_connector base;
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 0933e4ce0..1c94a2dea 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -202,9 +202,8 @@ struct vkms_crtc_state {
  * struct vkms_output - Internal representation of all output components in VKMS
  *
  * @crtc: Base CRTC in DRM
- * @encoder: DRM encoder used for this output
- * @connector: DRM connector used for this output
- * @wb_connecter: DRM writeback connector used for this output
+ * @wb_connector: DRM writeback connector used for this output
+ * @wb_encoder: DRM encoder used for this output
  * @vblank_hrtimer: Timer used to trigger the vblank
  * @period_ns: vblank period, in nanoseconds, used to configure @vblank_hrtimer and to compute
  *	       vblank timestamps
@@ -234,9 +233,8 @@ struct vkms_config_plane;
 /**
  * struct vkms_device - Description of a VKMS device
  *
- * @drm - Base device in DRM
- * @faux_dev - Associated faux device
- * @output - Configuration and sub-components of the VKMS device
+ * @drm: Base device in DRM
+ * @faux_dev: Associated faux device
  * @config: Configuration used in this VKMS device
  */
 struct vkms_device {
@@ -284,7 +282,6 @@ void vkms_destroy(struct vkms_config *config);
 /**
  * vkms_crtc_init() - Initialize a CRTC for VKMS
  * @dev: DRM device associated with the VKMS buffer
- * @crtc: uninitialized CRTC device
  * @primary: primary plane to attach to the CRTC
  * @cursor: plane to attach to the CRTC
  */
-- 
2.46.0

