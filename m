Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59870CC6B1F
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16FE610EA58;
	Wed, 14 Oct 2026 01:03:56 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E910D10E32F
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 01:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791939814;
 bh=T+SNMPmeWRlsuFf7ZP5o5uvYb87cW44vhQfQYpyHRFA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OhSLv8p56t7fXcv6aiSeyBfeYyqcprrg7f36+pU6cT5jBU2RS5FyQdNH1mXfchzfN
 ulaZtgX4BLXRYR9VjOrHU0GSlLykEX9xT5qafcRnFeZ1IB93U5SX8tGMqsSaePSemJ
 iFxtY2rVn2upQ5o7/0VOENt85V/PWv3fAUogCSYUc2Ed8sK3WF58Hu74w4t4kk2GXU
 D8U6MX6DXmIkjfUX58WeDg+m76qQRaeuO+uHtHCDQf5NqP9ygRt/YAIOv8ajOkGrqb
 JtKyEjna0DHbgsEvLDS20dCy+pw0eedl01f0ZGNmlDSQKgkOVKH99ut7dOqUIkM+k8
 71rLOKjYKOKAQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0F68617E0EB0;
 Wed, 14 Oct 2026 03:03:34 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 14 Oct 2026 04:03:15 +0300
Subject: [PATCH v3 8/9] drm/vc4: hdmi: Bump BCM2835 max pixel clock to 165 MHz
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-vc4-common-scramb-v3-8-c68d58d959a2@collabora.com>
References: <20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com>
In-Reply-To: <20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 0a95e14792e8..5b7dedd7a9a1 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1319,7 +1319,7 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
 	 * users are able to use pixel clocks closer to HSM's, namely for
 	 * 1920x1200@60Hz. So it was decided to have leave a 1% margin between
 	 * both clocks. Which, for RPi0-3 implies a maximum pixel clock of
-	 * 162MHz.
+	 * 165MHz.
 	 *
 	 * Additionally, the AXI clock needs to be at least 25% of
 	 * pixel clock, but HSM ends up being the limiting factor.
@@ -3190,7 +3190,7 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.debugfs_name		= "hdmi_regs",
 	.card_name		= "vc4-hdmi",
-	.max_pixel_clock	= 162000000,
+	.max_pixel_clock	= HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ,
 	.registers		= vc4_hdmi_fields,
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 

-- 
2.55.0

