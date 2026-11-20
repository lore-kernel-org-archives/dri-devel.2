Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CCC60A260C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NsTyS/Z6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE82112C62;
	Fri, 20 Nov 2026 18:04:16 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F7D112C62
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:04:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 15A5A4E41690;
 Fri, 20 Nov 2026 18:04:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D84A7601B9;
 Fri, 20 Nov 2026 18:04:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D67A611BC0627; Fri, 20 Nov 2026 19:03:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197845; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=cb/Z49GOdF0yhnrGMPBIli0QFaYOE4T0zI22A2vgSV4=;
 b=NsTyS/Z672Ga97LeNAcqGw2xk/9+aqknpMHbbFqFJuzj0jYKXyjTT51ndif2xvJIOsJor9
 EJmvl0xKRWgSgRo0TSHnbm6/eOhYQ9VldDAcsJEZKyQzBZrtLSyAoMwW/4zmYuJNcO4RPb
 88jj4JOnM8jQY7/JUUgZXXnI2hfuoRaWh2Bs/IUy1MJGdL4aKSUck4J/sFZH/+iQinxeJT
 6JaIjYClkrsH/k5mqkBL8PEM6zA3I63Fw/4UMyqDfVIJfqCtmcip9OIODgcY8B8m0+YjG0
 EIXc9BAwuh7b9Dunu3Ha5vYoxY6pJ1BMlp6re3MT+IdH6exrDWQGEbCK9NYq6A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:58:57 +0100
Subject: [PATCH v6 15/43] drm/vkms: Simplify plane_release code
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-15-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=B5PM6W0vulahUUbfuhv5KpB093DKmScfUhoYA1BRCRg=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr/R7PpFpksTfLgK4M1WsKIZ+X/fHJw4Eo3k
 BptWgtELfSJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLjSA/9G4BWoCRvV7ItG+o3suAYmXVBO3mKIP1
 8lGsPLIMnO6rOYDQ+nIenc8oFgVcG987eX7ZNvFRYl3/TIEFOJ6VlKrkS/cy+GKRmZ3Lz7T33uo
 F1F0N/+wNDrJ5f62JYQSdU3aZhNG5XQ8/vJK5EQBXHQwvq3GavSvdp6hycJpyVoFTG9O3ooqKDL
 H4spwX4GVBEB1EpTDhRot71sfH2T1mFgJ0/FcLmfvd3FlyZnYHizXbZ8buSbsLQoo4hA2tSx6mH
 n1JEd0tAaOL5f/LqiqUHWgmGRxgBfIIQWOUbLCsKJwOMcWmgOFHMIKryJqzd8VdA2iiLxMDgfZ6
 oaod4upZewUA5SQo0cvJMjG7nBebj8B3Hr6rnM9ujrSrHa6tFZPfk2JhUeO1IO3oQLxhSli3n5p
 Ulk9KKLdJqNoGlvI4riaFBjiCN91fM5EoHKeBArbOo/sJxlYaT11LTv9zOoCBPvuMt3pupyfhkd
 0oB6ILATTqGuvvOI6dM2cv3sV3ppJx1F5uceGxHrcRWtUDYhl3IzUryQKrj2AJDEl/Awr7wIFhA
 XB/8QBVVS3c7m0yExDht+/0Vr/sUzQKHmCJozkfscLc0hJmw1+TN18IIpbST5Dd2XnMywIoJi15
 k3le8BhyxZ5faMbjkoVpK8kgk6E3MSaQ6NQSONYJBI2VhCcu4jfA=
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

plane_release  code used multiple intermediate variable, remove those in
favor of direct access.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_configfs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 5f5aa0a1812b..a7ddcfd4e86e 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -331,13 +331,9 @@ static struct configfs_attribute *plane_item_attrs[] = {
 
 static void plane_release(struct config_item *item)
 {
-	struct vkms_configfs_plane *plane;
-	struct mutex *lock;
-
-	plane = plane_item_to_vkms_configfs_plane(item);
-	lock = &plane->dev->config->lock;
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
 
-	scoped_guard(mutex, lock) {
+	scoped_guard(mutex, &plane->dev->config->lock) {
 		vkms_config_destroy_plane(plane->config);
 		kfree(plane);
 	}

-- 
2.56.0

