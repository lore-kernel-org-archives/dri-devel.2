Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41C606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=d+a4GOZi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E655410F317;
	Tue, 27 Oct 2026 09:31:59 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B983F10F052
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:40:33 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so2795119f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neat.no; s=google; t=1793032832; x=1793637632; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oG0OCrqpe0XEV+bay86LwUo+wIO5sgYnrEJ8HAsyUYo=;
 b=d+a4GOZicOjS1AxKlOyHiZiaDMRxYpq1gVEJ8/GzepBYvUJbg8pNAmcrS5BmtNhq4y
 1s+IjyShCxrkrQZbI2lp5/dGWu2DJdcRAfkER8M1LAXfYTLE2KyCvwDL1ce5kksU3WsZ
 ZcNsEuEE2SZbtqXgShfeUS43ZIMwUP39FZnxYbEwp63kyKH1wVnU/Qeal6xyLY0KWV44
 FxUTdGkxHWKnt45HUu7ocRGUGaZTEzuTEweUcv4VLSXc7Jm4auVPftxfWyWEC4/Sc/Qw
 FZQZOgBMd7NHR6RQXhk5wnvX187SsnNDwbmaulrEl77fwtbISp951WpS2kMzSBAwEEhT
 MIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032832; x=1793637632;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oG0OCrqpe0XEV+bay86LwUo+wIO5sgYnrEJ8HAsyUYo=;
 b=oI8y0JYm65uRLQErEARIGqoZ5muTSUpMoqcUBOOl1BeARa3ccwNZ0Qfxb6iT52Bl/M
 xM6dC1g05Zw6k9v2azbFeHt7mQCarVj6FX6dyKcCFerObAFpYlEiLSSKGY0XGX+DwG2Q
 8W/biBg2j6LDDxtY8cggUsuEgzIQlF7JgqcA+oFq8vmeBU8vlH/3YEuejJR5UWjHxN18
 2ztdubr9b4A5tAh2TFGFgSCLMd3rgOx5lvMDKSn6EFWKpd5xZn1IHhYiR9dxXm2Xkdak
 xJ1w2+6iidtvqMjfNyTt2o79nBen4R1WRzlzpWfNl1WCwkbPo8eoDZh79rKaNy2Nv6jL
 azLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzC1Fm2TlUBecZYr5eaDgpRyuIkMVbDhNHgZHCzXBPcg5Stp8MScMqTbE57HOdzU8YsykKMcVQNAqs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLwQls77LEXuFpVj0K9fpsA+rHhj5kRSUGcKOHUm63Pa/gCvBUS
 dHE2yd+sn+o541ZW5EiJV3XEQBv0xlQAmTXpjgj4vGoSp7l/5CFunqb5buRv5iJ/qD3RrW8Owqw
 dmvcYo14QKUhqs087eYxoPOzerMCgK3ZKkRtH20+iisUsHzAa8PDNrmjliIEZ1p3HT9o0LOvZUY
 hFxHSZN38IHAx8a0JBIsoUTI7s+0EeQclfSRp2qO+szf3ZurEs+zqWzzLbxZG/ALrt0fAbX0d8b
 fCuJjuNOCLC1eAHuuXy40gt4VI=
X-Gm-Gg: AYBFou0lIO5RsgzG6/G0xEvjt8jOjg7WarXisL5YOOaVDFFL86x/k6ySdnXFnT6aCzu
 2lLXwpBkebEKGNORLoKKHeNLRsJi6/xUmgKYWhpSFD1HhqqMwCgbdSe2jTjbXa1JX2PumrkRG6M
 gm+3sjXPDa6ZeDcH8WSDRQt8zIRmBHzna3Fb2kVOEWp8ZF+VsHWLLwJKCG7L63Yh2m0y7DmXk+Z
 mUuvQkfx/dSva2Vj/d5ujbF4ShvEYJ7EA5nnTGx/dc7IbK9LMf3umY9b5aSKKzZcwlMHiZWsFiw
 1wCdtifDFPs6Td3hMln+1t+Qc0SRRKE9QSCjmyOfo9O0MQLdNO2WQoKfvb/13davQJyazBmIlsd
 LbK/tk8UbtPaNQAwoQvwNXzd5phIJEUYXYBOpEf0TFxV1cnnCDauwKUnmRLzl6J1gwFnylFYoXS
 xOFEBnWzDQJGOLM/NAAZhowj1suLBe52MWva+4w88KbkEWfN7P3Tlw34QEumH7CVW3nL39Qzvbs
 ZGTgNqskXC6Suk0rzc8U8jaKDzZPiNi7UXPIGTCJEvuIevvpDCT3FbbsFq4/dNO
X-Received: by 2002:a05:600c:19d4:b0:4a1:fa33:441a with SMTP id
 5b1f17b1804b1-4a35ac3f123mr144774155e9.2.1793032832124; 
 Mon, 26 Oct 2026 09:40:32 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a30e22csm205961655e9.2.2026.10.26.09.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 09:40:31 -0700 (PDT)
From: Lucas Tanure <lucas.tanure@neat.no>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dom Cobley <popcornmix@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] drm/vc4: hdmi: enable scrambling before the TMDS clock
 starts
Date: Mon, 26 Oct 2026 16:40:28 +0000
Message-ID: <20261026164028.78792-4-lucas.tanure@neat.no>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026164028.78792-1-lucas.tanure@neat.no>
References: <20261026164028.78792-1-lucas.tanure@neat.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
milliseconds later, at the very end of the enable sequence, together
with the source side scrambler. On disable the bits are cleared while
the clock is still running.

Some sinks sample the bit only when the clock appears. One HDMI 2.0
sink we tested then sets up its receiver for a 1/10 clock and never
recovers: a Raspberry Pi 5 at 3840x2160@60 shows no picture, while
1080p60 and 4K30 work and other sources work at 4K60 on the same sink.
Writing the bit by hand before enabling the output makes the same mode
lock every time.

Enable scrambling, on the sink and in the controller, before the PHY is
started, and disable it only after the PHY has been stopped. The SCDC
helper already waits the required time after writing the ratio bit.

Fixes: c85695a2016e ("drm/vc4: hdmi: Enable the scrambler")
Link: https://github.com/raspberrypi/linux/issues/7693
Assisted-by: LLM
Signed-off-by: Lucas Tanure <lucas.tanure@neat.no>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 4a386e053d3f..e57fc33af6b3 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -918,8 +918,6 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
 		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 	}
 
-	vc4_hdmi_disable_scrambling(encoder);
-
 	drm_dev_exit(idx);
 
 out:
@@ -947,6 +945,8 @@ static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder,
 	if (vc4_hdmi->variant->phy_disable)
 		vc4_hdmi->variant->phy_disable(vc4_hdmi);
 
+	vc4_hdmi_disable_scrambling(encoder);
+
 	clk_disable_unprepare(vc4_hdmi->pixel_bvb_clock);
 	clk_disable_unprepare(vc4_hdmi->pixel_clock);
 
@@ -1554,6 +1554,8 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
 		goto err_disable_pixel_clock;
 	}
 
+	vc4_hdmi_enable_scrambling(encoder);
+
 	if (vc4_hdmi->variant->phy_init)
 		vc4_hdmi->variant->phy_init(vc4_hdmi, conn_state);
 
@@ -1688,7 +1690,6 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 	}
 
 	vc4_hdmi_recenter_fifo(vc4_hdmi);
-	vc4_hdmi_enable_scrambling(encoder);
 
 	drm_dev_exit(idx);
 
-- 
2.56.0

