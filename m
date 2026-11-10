Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA2606A33C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VWHOSG0t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6690D10F5B8;
	Tue, 10 Nov 2026 00:13:58 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6A810F5B6
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 00:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794269625;
 bh=OnECVmvllvWZgJSm0XNuESSmGoHiaIZB6HDpLy2gW18=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=VWHOSG0tSZDB0ocveOKcfnD+SKNcs6Sen+HOvetAbB7nH73SpshVTt3tvNEvA+fcm
 dait7DQmCLflfOkOZRnSEyC+RHTauDY/C1OU1vpilWLzI21P+Hu9zHyTM5QikZou2F
 RndhrSwNIoxw2Zcfoi44pd+do25k5LBYfkn95x3N7NRK03M1eEvazxFGhJVBSXYqWm
 dfMwoT6gAa/pk8tou8b+vV52AexzPkc3Z0PdO0EWFFKWVV3Pni/05MX2ttgSniWjiS
 Jt4KtCWBu6pzONIsMSMupJTcTJieFmhZu5bM70ZVx3oCNM7gJTD2frecMypc/46agY
 xGLxi7CH/wb/Q==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A8BE917E35E9;
 Tue, 10 Nov 2026 01:13:45 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 10 Nov 2026 02:13:44 +0200
Subject: [PATCH v4 7/9] drm/vc4: hdmi: Clamp CEC clock divider to its
 register field width
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-vc4-common-scramb-v4-7-eaa141a0da0f@collabora.com>
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
 linux-kernel@vger.kernel.org, Lucas Tanure <lucas.tanure@neat.no>, 
 Sashiko <sashiko-bot@kernel.org>
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
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index d7ef47dc4b02..04712e975051 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -230,9 +230,14 @@ static void vc4_hdmi_cec_update_clk_div(struct vc4_hdmi *vc4_hdmi)
 
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

