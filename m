Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F2606D826
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwa6NtOs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A09A711278C;
	Thu,  5 Nov 2026 15:32:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B23011278D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:32:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F401360A07;
 Thu,  5 Nov 2026 15:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3679B1F000C1;
 Thu,  5 Nov 2026 15:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892729;
 bh=bkpu6ZL3ErutQvIfcsBqrlNfY/0sVWD+ZEOXXop82zk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mwa6NtOsJmOxcGysWupST5RHWYgIilQuxElFBawAbP9jDhvVa6TRK5LdDGVqNWck8
 z9XPsMKGyjr1/+M+u8SEYKidXcbJU+25c4Sbl5GbXmBKhnr6mtT6BpvzKcgB4a/RSy
 ya/Bqiq6THtg89efBET0OXqObm3DVavplVo83/EiWcZN2qGXDYPdBXkIfIYYTr2zi0
 q8jeJE5Yp0yseBGZHspksIFtrJ9TicZ34DWoxdtq3WsIKRRZXRLAS4GH3L2cfDNlDa
 3meBsfBzrkF8CHnEe2VC57/Uc4Mo2u4zV6luJrzyJ+Us2yQNxv1zaR4I76iRHaa7Go
 DVpBBUI5/LbbA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:41 +0100
Subject: [PATCH RESEND 32/83] drm/omap: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-32-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9ywo6xhb9gZpGNqmzv5iljPggfLuHO5Ez0kOpB7fQKE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFrz+Pd9JSz1FyjTg8feLJ26KvUqfdFP1Zsq9GNc3y
 60DrlqVdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJPItjrE8+UPhMSUnnyQJO
 s4n8ihl7RCJlvO5+V+zZyuj5xEsm4/OTL+YLz9sGnUkOcZrIG6P7mrFhgbzm5xXLfEMiKhNffZ4
 b4bpoHXPJZa4Z5nXypjmaczgkl3JcvnTD1fTPghvnj7gXH48CAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 89a6d3b4aa6f..db216c888a8f 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -536,5 +536,7 @@ static int omap_modeset_init(struct drm_device *dev)
 	dev->mode_config.helper_private = &omap_mode_config_helper_funcs;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	omap_drm_irq_install(dev);

-- 
2.55.0

