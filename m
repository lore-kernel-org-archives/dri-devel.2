Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D060A260F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ezCr+9SN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E0F10F5B6;
	Tue, 10 Nov 2026 00:13:58 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51B110F5B8
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 00:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794269626;
 bh=wCOnp9+5u8evN0rwFofYAOmzMKIlis4jJWgauhb4z0g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ezCr+9SNN59szgGcm4IM919KpQ52EWmW5VTxUN1dS2soLiHkhZAmQTUZaf0RH3dYQ
 iisnDToBHCxCt2dMTTdvOkkWO2Q7kV34BXk8TMdfUwGp/YfGw15R1Mnjg//Zd18Q5L
 xF8m32eGyIqaMgzVYMTE03vf25pHusyYzexjJlEerplF57FpdM81D35jdTRmq/sPHa
 c2m5xavdbfIUC/E7sSojMXvi40GFl0W0RVgDO1l2wQ1+/yYpqmy7QFS0hATd/VEZx5
 cG6eda9niJK/QOKmnX9+zKWzlrarapzxCZ7ZTdzY3xCu+Uy4UIn5SjFlZA0mjAR7hk
 chSnm/c44sPWw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7011917E3610;
 Tue, 10 Nov 2026 01:13:46 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 10 Nov 2026 02:13:45 +0200
Subject: [PATCH v4 8/9] drm/vc4: hdmi: Bump BCM2835 max pixel clock to 165 MHz
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-vc4-common-scramb-v4-8-eaa141a0da0f@collabora.com>
References: <20261110-vc4-common-scramb-v4-0-eaa141a0da0f@collabora.com>
In-Reply-To: <20261110-vc4-common-scramb-v4-0-eaa141a0da0f@collabora.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Lucas Tanure <lucas.tanure@neat.no>
X-Mailer: b4 0.15.2
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

Historically, the HSM clock for BCM2835 was fixed at 163.7 MHz.  Since
the pixel clock had to be at least 1% below the HSM clock, it was capped
at 162 MHz.

Since commit cd4cb49dc5bb ("drm/vc4: hdmi: Adjust HSM clock rate
depending on pixel rate"), the HSM clock rate is set to pixel clock *
101 / 100.  For a 165 MHz pixel clock, this gives an HSM rate of 166.65
MHz, which, per Dave Stevenson, the hardware can handle without issues.

Increase the max pixel clock to 165 MHz, which matches the maximum TMDS
character rate of HDMI 1.0 through 1.2.

Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 04712e975051..29e608e4d610 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1333,7 +1333,7 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
 	 * users are able to use pixel clocks closer to HSM's, namely for
 	 * 1920x1200@60Hz. So it was decided to have leave a 1% margin between
 	 * both clocks. Which, for RPi0-3 implies a maximum pixel clock of
-	 * 162MHz.
+	 * 165MHz.
 	 *
 	 * Additionally, the AXI clock needs to be at least 25% of
 	 * pixel clock, but HSM ends up being the limiting factor.
@@ -3203,7 +3203,7 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.debugfs_name		= "hdmi_regs",
 	.card_name		= "vc4-hdmi",
-	.max_pixel_clock	= 162000000,
+	.max_pixel_clock	= HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ,
 	.registers		= vc4_hdmi_fields,
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 

-- 
2.55.0

