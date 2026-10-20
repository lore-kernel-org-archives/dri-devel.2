Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1F1606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=FX/5zit4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D4B10FCD9;
	Wed, 21 Oct 2026 08:53:01 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34A210E5C3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:49:44 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso2715610f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neat.no; s=google; t=1792504183; x=1793108983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JoIbT4JqQMzKpOCz4KsxBI33UMCOAPIEksfMpvE0MPk=;
 b=FX/5zit4gOqQtx7D9zJKmUzeCrpCY/7J8YkY/xycgwtLAUctaA1AEatidkm8wFiTyA
 DuES5ce+1OR7Qym07uGtyC1gHC1eke3uoQsrq4POn9xQtI0SAKjwLNz9F/u6vDS/gZRh
 MEwS6gauZ7406MrasZG8kAzYDBEdsqkaVlnC0eudDaEtNWrdyyMDNAYjyZZDHxQDydbD
 JSTV4gr8OfNsCS+I8Hccagr1bRofUh8FkILmHSUoE+ewR5hIPz7FXrdx8/bZZZgJ9k/2
 oswU4o1hP8ZUqMBXyE3THJa0m4Hlr2sO5bqPub1a/KOq6ghnviqSNRPbW2Lmr5pLLK5F
 cfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792504183; x=1793108983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JoIbT4JqQMzKpOCz4KsxBI33UMCOAPIEksfMpvE0MPk=;
 b=VK/RkIoy5RNOMCMFn9EXl0BkVIDRvRKl9lBRfQ2dejZDJxa4o6+lS0nUFjGcXElQr8
 /XThs43c3LkE7F45IypsaJxaNnJt89fbJqu03nE56MQqTss2Aym5f/9hNlsC4RkyV0ed
 uPZq7/88Fq+XpMrR5sMYkbCuBuK45JhUiMNVp/CMtxFHRT0iRk/FLCjOynS8DOoxJp+F
 6Iv+gQHsJZGIq/8sTyuAIATyjwB8juWIs8mW/7JOX1DqwC5M9df7q53y25fhb/3HC6Wh
 SBp0rUfFUgokutieA+VDoDfPFWC6jG3q89acUVrCqD78ZpCQFjHYmMTFyNVfFrX0Es9+
 05HQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEpgLlNUdfDJRs/ADaPIO9u99fPCGbwTDqOA4YCIa3Cqq+cK8PgrNkJogbmfRRZAaXvTi9AzQNuKk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLdPBin9MkSTGAvbWVNX+uYDRXcqbj6DSqEP+L534PMUOQc97Cz
 3sSnN/ATK8Ib5mXgd5rgoCrtq5oMXlG+HhGAFvRlAU2c0w9X4LI3LSHub8Kx9nhJYb3hg+YzXBA
 L7OobFRUYMTS4tCSHtAuQPQTI0O2/Flqz8Oz38pakwczlgLcJ0N19lEAJZSgGfD+T2bhgWPYLHq
 gHe96THsVqZg80kA7C9rMiuIDimpVtXWOAwTvm4+yse91YB/7IUZffwQ4Th9v77jODwp9+RpbUq
 kIKXcHMluihwuef/dON9Nk6VTQ=
X-Gm-Gg: AYBFou2LCvDoyr4CdxVYNGxObNwpbt0qfaOzK3XkzDhCqaoYU2O61t65ZIFsRlCbgK2
 9PfMzLbQOEwcmtGyjUrlZ3+fiVE82/kN/zMmFcjKunjehV8ypie8P8dHiC9Xg/GbVqTomIHD8Fj
 Cn/hecrtVcSmH3lzvEe4mb6ymFfJBzQKAMMyhqx3nGUb5dB/B1SstlU8OWZiqoNiGqJ+MmcTvZx
 EHCfjS/Z6dLWRYsMaY2qavf+yi7Jt+0vOw/J8I6IRYp/5OoaFlwPtzShZRLCgKMjNay9CMcmNpS
 61GHvpYnh0I/JMXoO9z3MxxT8+m9TRLecQ7g+BQJJiO5qsToYUS+EPbOCeYX/g2Ja5GMAe8UB4R
 3LFHhSJOiGTNz8oeM+vkVnKqULjq8MRVBNBzn55D3aO15XgLQuSevEK7xn6Tcnuw5hWE7DM6DwL
 accFzLz4aKlTaWgm61a1bBsAKNsm7TsW2vE0Xp1F5PMT6l/ieJWVu6WJxAZNjF75WZN46/cPh9y
 Pt90hc=
X-Received: by 2002:a05:6000:29ca:b0:48d:f498:91e9 with SMTP id
 ffacd0b85a97d-48e07bb592fmr17075762f8f.9.1792504182888; 
 Tue, 20 Oct 2026 06:49:42 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d80fea2sm6589469f8f.10.2026.10.20.06.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 06:49:42 -0700 (PDT)
From: Lucas Tanure <lucas.tanure@neat.no>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vc4: hdmi: write SCDC TMDS_Bit_Clock_Ratio before the
 TMDS clock starts
Date: Tue, 20 Oct 2026 14:49:41 +0100
Message-ID: <20261020134941.631907-1-lucas.tanure@neat.no>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HDMI 2.0 requires a source to suspend the TMDS clock, write the
TMDS_Bit_Clock_Ratio bit in the sink's SCDC registers, wait at least
1 ms and only then resume the clock. vc4 does the opposite: the PHY
starts at the new rate first, and the SCDC bits are written tens of
milliseconds later from the post-enable step. On disable the bits are
cleared while the clock is still running.

Some sinks sample the bit only when the clock appears. One HDMI 2.0
sink we tested then sets up its receiver for a 1/10 clock and never
recovers: a Raspberry Pi 5 at 3840x2160@60 shows no picture, while
1080p60 and 4K30 work and other sources work at 4K60 on the same sink.
Writing the bit by hand before enabling the output makes the same mode
lock every time.

Fixes: c85695a2016e ("drm/vc4: hdmi: Enable the scrambler")
Link: https://github.com/raspberrypi/linux/issues/7693
Assisted-by: LLM
Signed-off-by: Lucas Tanure <lucas.tanure@neat.no>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 2cc46036f11d..abab7a10fa12 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -812,9 +812,6 @@ static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
-	drm_scdc_set_high_tmds_clock_ratio(connector, true);
-	drm_scdc_set_scrambling(connector, true);
-
 	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
 	HDMI_WRITE(HDMI_SCRAMBLER_CTL, HDMI_READ(HDMI_SCRAMBLER_CTL) |
 		   VC5_HDMI_SCRAMBLER_CTL_ENABLE);
@@ -919,8 +916,6 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
 		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 	}
 
-	vc4_hdmi_disable_scrambling(encoder);
-
 	drm_dev_exit(idx);
 
 out:
@@ -948,6 +943,8 @@ static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder,
 	if (vc4_hdmi->variant->phy_disable)
 		vc4_hdmi->variant->phy_disable(vc4_hdmi);
 
+	vc4_hdmi_disable_scrambling(encoder);
+
 	clk_disable_unprepare(vc4_hdmi->pixel_bvb_clock);
 	clk_disable_unprepare(vc4_hdmi->pixel_clock);
 
@@ -1555,6 +1552,13 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
 		goto err_disable_pixel_clock;
 	}
 
+	if (vc4_hdmi_supports_scrambling(vc4_hdmi) &&
+	    vc4_hdmi_mode_needs_scrambling(mode, vc4_hdmi->output_bpc, vc4_hdmi->output_format)) {
+		drm_scdc_set_high_tmds_clock_ratio(connector, true);
+		drm_scdc_set_scrambling(connector, true);
+		usleep_range(1000, 2000);
+	}
+
 	if (vc4_hdmi->variant->phy_init)
 		vc4_hdmi->variant->phy_init(vc4_hdmi, conn_state);
 
-- 
2.56.0

