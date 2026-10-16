Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B870FCCF2CF
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C076810E66E;
	Sun, 18 Oct 2026 14:53:19 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB0D5112734
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:15:42 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3a7cfe8f761so576846a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792145742; x=1792750542; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZJlyzhoWQhc9t2V9V/IMOCakgx6bB3MzV1A39J6uch0=;
 b=awzylh808WKdMDXeX2TcapA2Z4vXDg4LcAUot1a/SooI4Qxk9pExlpuuBPKa22ShTa
 698Y0QqQdthsY7LIJVfzZdJeDNnS1/gBroHMKZgxAdRm7Lc92wIcwDSLt1iww1fJqvCc
 lLAwZ/XYmVPAgqkWOTzGlR0n72ka5yUkZzbps98FPuQNslhMGIK7AKdc1Dk++p3uHE4J
 60RPiK+QJNy01krLsF2/j7EgUzXTZVDH9irolDXfk28hGnK0UIXFWheHK+K4Ij7xO2k9
 +v7jZjMGyHWxvLVCdV0WQWwq6lk7atB0Lom5diBvDQ77phA5dBzS4xarjk0Q0It74nVC
 x49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792145742; x=1792750542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZJlyzhoWQhc9t2V9V/IMOCakgx6bB3MzV1A39J6uch0=;
 b=kAXupdIi/zhMwQV8RaWONhldzkVF1zcsodysLFPc0e0In3D9NlFBtbDCk/HAQgSv4V
 JxWWdYehKFRHIxP9qcsZCQkUhJIMZ6hKAWZsMCVXxXKMMROpeZzGRJegvbxuMvZa4JAJ
 Z+r340ouPYmVDqrH0lqO4XNucBDck9V76zErZBU5fc9fin2xxqcXPiSO9PHCgh1SVIII
 nzKRqMDKSWwPcbQof8SYOuFz8B5jKIIdiR/3euPOIN540xDRqH4zcMzHko++fFlH11wa
 3CjtljS+8O4DC11n7GU4E1je5MlSAd03uekZLGUUkpGReEM/W1KYd8Nr7JuPCU2HRjmQ
 4Vuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbnTbgVO39AXzC6flvKgyrkNRRzPwCJVuNagHHKt/hzogCYzR5rkhFi0dl3nWWBCmUIiXeqX2BHXU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIdBI+h2n7xR5upVGALbmssAIgcNAzijPdOvq58FAyTDmLAZwal
 KHXGOOFtxpJmInM9//ccjSOePRqnVJVHnBMiZf8aCVeZxbpF4XT42Xzv
X-Gm-Gg: AYBFou16p8CC51lAA6ciatuT1kK5HbqkkNAB6MSgh/2tn+6PNyEpQVQSvybisDE0ARf
 NGG2JU4seOhFzT9kb+W4Zyt1Upbmphuz0DohyHqG2HytNGRsrRIfMNcK/SbY1RIu4Ukb2qMydBr
 cAh1qJl0EfZfuUeCyJ/yScggrs/epRLNrv24bDJaCNfbEn4NAy9/QC6wFNmIeMmKVSX0pJuLYRg
 wE3I32lmEYlcgeerCTd6EBLqMpyFk7LKgopyYDFDlLT8FN6KxBXf/p4RM8F0pP+rucTCYL8cdWF
 7mQTFrq4l1A0ZAyylYhn9Gyt34zCxhI9ISKN8CWhOm9P6Qbv6/sT0s0CNWLwaUlE9re6uHQxUxx
 YbKhj/zrpFvaPm+u4tsfVJ8ntbOcr5BQExPCAphSlI3WFU625HzO9wBnI0J/GDu9WPOsEEiUG3x
 XBwmqK3bWTyml1MO9ONI2OR8l4xFoQZlh1Macoq9+nRJTOqY8dvFIsxniWy0++pSkdzd9VC9Y23
 p+SNAu25gdtU9QXk1zLto+c8lFAE0SVdej0Sl7gyMxjO6hB2NaaBKiAkAPKeMfwNgtEyw1P
X-Received: by 2002:a17:90b:17d1:b0:3a7:a3c8:8f4a with SMTP id
 98e67ed59e1d1-3acbb7ffa6emr1720514a91.18.1792145742097; 
 Fri, 16 Oct 2026 03:15:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:1467:1666:71b7:b993])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac943e7548sm8682651a91.1.2026.10.16.03.15.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Oct 2026 03:15:41 -0700 (PDT)
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
Date: Fri, 16 Oct 2026 15:45:30 +0530
Message-ID: <20261016101534.14179-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

