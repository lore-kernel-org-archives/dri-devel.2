Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31C1C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF19B10E426;
	Sat, 27 Jun 2026 03:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YB+KBu30";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAA610E41B
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:31:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 99BFE4E409D9;
 Sat, 27 Jun 2026 03:31:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6DE4960233;
 Sat, 27 Jun 2026 03:31:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E3937106F1176; 
 Sat, 27 Jun 2026 05:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531073; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ODS/KcKkaJlG9a45UpwMB6wA5ib5OPfBDYu35wZafPw=;
 b=YB+KBu30ZPq3ZtHw8VeMofiuEZIoVi/2X+Nuh7jiy+PaGre0DdmG0FQAvQ40kKvSIA0vD5
 GaNXUmlKY7s0j+tvAuh15LXqLXvnW1zTiP3QeYqWggOXPg1dXvDzqFFYsmOKnfsJ1bs+yP
 n/s8oJ57SN7zLbGWy4HxTiM9N3OKQ3adTi3ReDFA2oFHsSKfgq5x1ELF8kD5CbxRKs93ib
 zn0q/TU3rawkhtSoGigkHqeaygvjooQFJi/ZCc8oh0AnAQK265dJdFbYJFWOFPvIQPwWkh
 pQI7VZF2YPmvb87SBHg4uwBuzBUQ1rgQVyHRaWXX4deFg4Neg/RtHcimBs/zdQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:27 +0200
Subject: [PATCH v5 10/38] drm/vkms: Explicitly display plane type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260627-vkms-all-config-v5-10-854aa0840926@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=QatXxbwayl7ekIDPzWMFO8AtbyZH8hv2oADcMdSEKVg=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0PdNyCKzo5+Pqv7awnU62rGPxflbvcYSPcpC
 BsXxW6u5qKJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D3RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOJhrw/9HN97IeB1bHNm6RJCKgwALzDcvVJy8jn
 P18clTb8ozTwcU1qvq0ovPhgYNXpMkRKcMclyvaRY83BY8V9/XdaM4ROJIrF/S4ws6rl8OTukEP
 dE8x0NKUKe52SsuWV+BXymPVGwIpWCmiTVykMsO6moqBQVzkNB70N8u0X7tTDCqn4Sh2jWNlFi2
 J5N8v3o8TZr+xpxEcMBXR+IXPwpZXgxyk8RlwSzYZUPziAgBc30nc3I+Jj2TmLtnphdzl/HmHot
 mtEbeAXkMzCZMP0ot7/dYVC7WLRUlJVJ+Bmjnsz9tWA8M1CQz0+eIFnDLu8tXch/aEZv9ekueca
 XnhnaMM3fLem+fmFdggYSRXrmQkIMCP8bwdFr3QxwLER7SJPVgo4vReqB2EkJZ8oQkO6VJkNO1q
 o5eN+4hOnTrXqv3vPQm1+Q5bV1PuTMpeEr+iQInFCmXKI97mTbh4n+hELQ7/X7fFU9eksPpvzK5
 Q0jFshlgtgwqSh1mPX41LIaZH4QG8SqiBSyMTtxx9J6kB1etTYewjavGwzBB4ejqlkJeacFdNtU
 IDqHIWqrwZf1Xe19RlmxMBXtA0BAEZDowcsrdG03xE952tDuL0QMx2hLlEtk7kFA2pC3Bp6NDD3
 z3o8ekI6MA85AkoaX9JDz+IgcDs5ZwyFhY9OXFNrSXcU3p8MJeaA=
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
of values.

Reviewed-by: José Expósito <jose.exposito@redhat.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 1fd2ed1167c5..469c57c6d1e8 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -352,8 +352,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 
 	vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
 		seq_puts(m, "plane:\n");
-		seq_printf(m, "\ttype=%d\n",
-			   vkms_config_plane_get_type(plane_cfg));
+		seq_printf(m, "\ttype=%s\n",
+			   drm_get_plane_type_name(vkms_config_plane_get_type(plane_cfg)));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {

-- 
2.54.0

