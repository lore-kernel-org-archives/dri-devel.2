Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F79CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904C210E32F;
	Wed, 14 Oct 2026 01:03:50 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1515810EA58
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 01:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791939813;
 bh=MckGun2gtejT560FK9QmGTltX7GCFvSkoYjqkh14MG8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mObrdfijFmViOyGYT9/2LsSylhyCXZJa6mmBSF/27GuhyH6futliqAHEQSGj0+ZQ4
 xAqEXn/0sCqZx8tR6kgCvE10um473Bdv+ms552qmC7sYX4nv3RZ1CWVKNElVtG0FKp
 HeSaogRmk8cpvssnMieDbh7/iRyeSnSsAik0Dbk/aSPlX3IEZMU70ap0jtNWVHrTE4
 wBoIsYprlCimRFIMsMxX97A4YFcr7lR1q9f7pgF/7Sexkg3UR/JWnV84fcZEQljG/b
 LJaETlUEkcT2PBloe5A9lgOPUQlHd/NvpiSDNHnc3mXcG3V9FLQ99IXYBAJFbaduUG
 I7K6qEPUbPP8A==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 44A0717E0EA9;
 Wed, 14 Oct 2026 03:03:33 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 14 Oct 2026 04:03:14 +0300
Subject: [PATCH v3 7/9] drm/vc4: hdmi: Clamp CEC clock divider to its
 register field width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-vc4-common-scramb-v3-7-c68d58d959a2@collabora.com>
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
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
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

The CEC clock divider computed in vc4_hdmi_cec_update_clk_div() is
written unmasked into the 12-bit DIV_CLK_CNT field of the CEC_CNTRL_1
register.  On BCM2835, the CEC clock is obtained by dividing the HSM
clock, which in turn is scaled to 101% of the pixel clock.  For HSM
clock rates above 163.8 MHz, the divider exceeds the field limit (4095),
corrupting the adjacent CEC_ADDR field and truncating the effective
divider, which breaks CEC entirely.

The BCM2835 maximum pixel clock of 162 MHz yields an HSM clock of 163.62
MHz, so the overflow cannot currently be triggered.

Clamp the divider to the field maximum.  This is a prerequisite for
raising the BCM2835 maximum pixel clock to 165 MHz, which pushes the HSM
clock up to 166.65 MHz.  The CEC bit clock will then run up to ~1.75%
faster than the nominal 40 kHz, i.e. ~40.7 kHz, which is still within
the CEC bit-timing tolerances.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-168686@kernel.org/
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 2451ff85e759..0a95e14792e8 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -231,9 +231,14 @@ static void vc4_hdmi_cec_update_clk_div(struct vc4_hdmi *vc4_hdmi)
 
 	/*
 	 * Set the clock divider: the hsm_clock rate and this divider
-	 * setting will give a 40 kHz CEC clock.
+	 * setting will give a 40 kHz CEC clock. Clamp the divider to
+	 * its 12-bit field to avoid corrupting CEC_ADDR; for HSM rates
+	 * above 163.8 MHz, the CEC clock runs marginally faster, but
+	 * still within CEC timing tolerances.
 	 */
-	clk_cnt = cec_rate / CEC_CLOCK_FREQ;
+	clk_cnt = min_t(unsigned long, cec_rate / CEC_CLOCK_FREQ,
+			VC4_HDMI_CEC_DIV_CLK_CNT_MASK >>
+			VC4_HDMI_CEC_DIV_CLK_CNT_SHIFT);
 	value |= clk_cnt << VC4_HDMI_CEC_DIV_CLK_CNT_SHIFT;
 	HDMI_WRITE(HDMI_CEC_CNTRL_1, value);
 

-- 
2.55.0

