Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A91CC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A4A210E42A;
	Sat, 27 Jun 2026 03:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="etS9hEFo";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400C710E429
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:31:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0DEE24E409ED;
 Sat, 27 Jun 2026 03:31:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D536F60233;
 Sat, 27 Jun 2026 03:31:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D491106F1167; 
 Sat, 27 Jun 2026 05:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531087; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=cW7Vp+Ww0BHKeSJTjS4TB9rMtbkv5BfsUgPd2jn2qL4=;
 b=etS9hEFo8FXg8crsFqFPG5PHd2LHyzwxfAEuX+xDrIJlTwkrtJ42bKNk1OKPHF+bp52j6s
 SGEHufuYaNrmJVBYM7fk35RrMZD7OU9vyiqqWbTeEDOY4hmsZAB5QJzB3RQ6ZwXVFnCSlf
 pfz0eC63UDmiv2Ai0/YqJ4EbcGHqRhdp5vpSvh97oXc/3MeJYVhqBIFhcuDB8yLRmQgIO0
 AG9UUHSq7pNRQurkOVbTSizVqfvcBkNtrzaTFn71mylkK8ndFVrSz4UoLB5br26BGCmS/w
 BTCZYUgGJgHvA/XkZZgVH9iwX1Qir4nqwo6QA3SPLbiTxHP3pGZ+oHPjD6r68g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:33 +0200
Subject: [PATCH v5 16/38] drm/vkms: Use DRM_ROTATION_FMT macros for
 rotation display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-vkms-all-config-v5-16-854aa0840926@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=mRSqoUGmy2p732uiUceNdBnrTLFMu66qquxwXRZoWz0=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0Pea+CRmukZQmcQ579p36VF8zMX6xh0xQoML
 vWGaM9sWGuJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D3hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOI4jw/8Ccevri0r8ORDusswYP69rhtCM5CPILO
 N/72cm0g319PruVZOoTj/1NiRlE7c/4nIKqtJLN4mFFB8I3VNvVglR0agy5U4N+77Z0qTbiJchO
 nNXmQtTGbIC9uAXiEnGshf6DtnimHaZcVyRo5sTMVpt7EioXg+h57nNS3uMG/MMSUFEqkJBW0r1
 cqZFmm/qCRY25TBdR3D+HHogxA3NKUqt+OAsrXmX8aTsXPOJCwMV88HNJrL92iIwznha4D+T5vZ
 WAQMfYQecIrmacsPFhBkitUlwJIF+xGLWtrbRE8b8MSn7RL/9FoKqiuUrmME3IJljJVeRDA3jRL
 QYKw68nyHXzIohljol3xkW0f8SY8sk6vtcVxcniShPB91lvO9/0noiLDAqhPy4FhYB1dzKXBjVw
 eS8BDEEBeJ+2MZ4ARoZ3aD90qhq9ScevwUdJyEgU9V49sCtxNwWy5l4QOJzTkry06ebr3kC2sAy
 PxIcYFeWd/M+XSU2jHuF/q0zo88M+vNY9PAnUWkVkukRjH2EWxk6Sx78VfZyqxbn4rjoC/U0pgR
 RDM6qQEdGrytpla1fEOfearZc8opA5NfQwsfcFtnPM0LNxiVQPQvr0WkSGuI1y3fESuCHCsQLog
 wn9U8pPQrzxR9hrfvtijY7cJfCxK5izPG2Sqdb+JZCIHhNPjKZYg=
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

Replace show_bitfield calls for rotation/reflection with the new
DRM_ROTATION_FMT / DRM_ROTATION_FMT_ARGS macros for cleaner code.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 5c86eb24fedf..ca3ee3aa2c41 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/string_choices.h>
 
+#include <drm/drm_blend.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_print.h>
@@ -393,6 +394,10 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		seq_printf(m, "\tname=%s\n",
 			   vkms_config_plane_get_name(plane_cfg) ?
 			   vkms_config_plane_get_name(plane_cfg) : "(null)");
+		seq_printf(m, "\tsupported rotations=" DRM_ROTATION_FMT "\n",
+			   DRM_ROTATION_FMT_ARGS(vkms_config_plane_get_supported_rotations(plane_cfg)));
+		seq_printf(m, "\tdefault rotation=" DRM_ROTATION_FMT "\n",
+			   DRM_ROTATION_FMT_ARGS(vkms_config_plane_get_default_rotation(plane_cfg)));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {

-- 
2.54.0

