Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B1960A3813
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gzmRpfKy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A3BE112C6B;
	Fri, 20 Nov 2026 18:04:23 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0446112C67
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:04:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 801321A1759;
 Fri, 20 Nov 2026 18:04:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 554DC601B9;
 Fri, 20 Nov 2026 18:04:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 04F7A11BC0627; Fri, 20 Nov 2026 19:04:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197854; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=tbl7KbbWqbfMj9Je7A0HPDYmT/fmrxkKs/AK6iFXtPU=;
 b=gzmRpfKy1Cjr1LkvGCUqP92ZEUvjeLQi8ln4r6Wjkj9+v9w9pqKkbQgtMr+QLZdb7lo/ji
 ZCZpCuyqiRNU6LBfrn+5NAQWNCX5uZV02OsUwENSovQD/lNZf60Hkxd+6a+a2vuahfW88T
 kzGQJIVzqnGTAI7vJqhgs0m8w8YpHy8ouPeZvjSkPHaZ8RNTQXmdSVZxLLHPbSt28hSNIF
 es/psjgSF3Kkz1m0ZJLRvB5hy16DfgpBi7OYuGzAlprjz+AGnOs207CbMLE25bhNHKtQEl
 vC/HQJJWwMOGS/8l4XS7B+FlyY4zcpgpe9mGdLK5ecm1oSgfjOutjaQiPnAhmw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:58:59 +0100
Subject: [PATCH v6 17/43] drm/vkms: Use enabled/disabled instead of 1/0 for
 debug
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261120-vkms-all-config-v6-17-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=FuLxv4IS8t2OQ5v1HuAk78riDXjuPDUEQbNHD3ODm3Y=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr/Hsg3FddplCIKcqug0I7EdumRSe4lf/48B
 qkjemsQq4GJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOJPoxAA021lc8DnTStnlAZWYd5TyVyTIS3Shax
 26CLO8CrwR4KPHH9sPBz+mUc1wbkTjpXv6qHrg20lIokU2JQqpRfuVTIpOePS4SZ260XEAeAgFO
 UcVNldCpSGb7bnVfl0OVrnpnjL5LUniHXyA9Zsm2C06VmEUaGHEQiUo3f5ZSydKB3SoYz+AW4Oj
 Ok7bgjMD1AMCJtJxTgFpp2JkJ1h8Z15nAeFCypCtfenQAXvM/9e6k8kSeJ/9ckeYHJOe4aeAvXY
 JKh6n2ybpZXAQC0y0jl3B44WWy0ti9wRa8JX8ifrjFGSKbtJQ/1OTuemR2PFyf2NPNlced6TXcJ
 seDS5OlCcn1S1O4MEeuFkMBjrxDGZb/n7cB+vcm3Yel1ogRgii5XA42MZL6hWIEduK4ZJQgKyns
 Nx6xN27slWcCVk6ehjPPQXO4blYkgxlKrlaH+4jaZHQwIFOuxgKPGR/Claz8FiC4h/pTTrD3t28
 yto5Tdp85ITP6iwyuDQxqn9Erwk1E6AGiQapKpm9QeiUw0Tf79/D0xKdcLKAmEiv733ncY0Zijc
 HdjBe1fOpM6VMyJmAjcz+TqiCdATexgULvF24wf4k3dYwuYpsgzyRV6QGduq5y9LKHai7Z6HLly
 QGlMzq3LvblNCMzVxbiQ8h87H3Ux6fF7HLKW/WI6q7pBz1f/muzg=
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

Debug information are mainly read by human, so display human
readable values.

Reviewed-by: José Expósito <jose.exposito@redhat.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 44ded8a86a6e..4127fb176a87 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 
 #include <drm/drm_connector.h>
 #include <drm/drm_print.h>
@@ -397,8 +398,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
 		seq_puts(m, "crtc:\n");
-		seq_printf(m, "\twriteback=%d\n",
-			   vkms_config_crtc_get_writeback(crtc_cfg));
+		seq_printf(m, "\twriteback=%s\n",
+			   str_enabled_disabled(vkms_config_crtc_get_writeback(crtc_cfg)));
 	}
 
 	vkms_config_for_each_encoder(vkmsdev->config, encoder_cfg)

-- 
2.56.0

