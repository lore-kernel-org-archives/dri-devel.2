Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D765606A333
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtRqjbtF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BDF1125FA;
	Thu,  5 Nov 2026 15:30:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77784112760
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:30:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4727640A84;
 Thu,  5 Nov 2026 15:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34B61F00A02;
 Thu,  5 Nov 2026 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892650;
 bh=VFTNjG3GGS52cJtOAHi1LTNy1x8BV031w/2Z9U7HD3A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TtRqjbtFwTq7Z5+3BbvmPqEunnFgoAigwkKgqiyZyKOV7gs4ZzbWCbtFd4J3UZWoi
 IilNZG/bbOG+ZLJf8gvodZDKDgcw29eGJJDymKwXBy4gR3HWF/dpGzDnG6f0cb6Qjr
 sm9Fl2qxwEGlhZHg2XhJFZjxISxeD6gQX44B0Breoecz96fd7VCkNQQzL/gOxK9G5B
 xhDpKLNMZPX7GwhWg2Y1lfK5AR3OmWGy8XDIC4C56sAQgBKwn7f2FlJOEdTa9PRNFO
 xVaN6p/+00ouPQhok1TycpimHFEJCJOgOxuqxc9568G68PvM23dPRYvm53YJYp3XQT
 sVxzJAHhXRG/Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:19 +0100
Subject: [PATCH RESEND 10/83] drm/atmel-hlcdc: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-10-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Dharma Balasubiramani <dharma.b@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Ra6Jta20ThJ8hGjszg5mYjlF508y8naNH8MrbLU1ux0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjzMvr/hrds7jxkVIoG2B/MUoszUznQ+W/GAv9CNJ
 9Hu6Ym7HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi71oY610Umqby/wy/K2F+
 MuKJ3Mllu57/574RfONszrW2B7Pid4nUibkxGOw/9GWK/C2xL6mzZRkbmq9VHJ4V1Zdu8zPNwkn
 2PPu2WOtZ8mfWGr6I65OuuSJl8NfWbsrZhc+uT3RuVvIQvxMPAA==
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 2f41bce574dc..453c37de9bee 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -880,5 +880,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 	}
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		goto err_periph_clk_disable;
 
 	pm_runtime_get_sync(dev->dev);

-- 
2.55.0

