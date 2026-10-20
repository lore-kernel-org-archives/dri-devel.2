Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDC3606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=T1+8Qy3f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40AA510FCAA;
	Wed, 21 Oct 2026 08:51:53 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447AF10F678
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:19:54 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so607139f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neat.no; s=google; t=1792509592; x=1793114392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5BjdKvBZdXi8e0VydYgvdPKEZPO1zw4zmgyGyLoROGY=;
 b=T1+8Qy3fSrsUkdON+yx9C+VU08MjJ0bKG34cT0pZam7XYRdpQBM6OoSqvXpCXoXfWy
 ZLmfUJ8/738yfkLV/u4/FONr74SqHS0j7JhF0z4Mm2HrhAsGOundD5W4nQoOEkRKzqu9
 VjTV/LM9w6KqtNK81AfNGzWMVWtlaDCV3zyDyciv/nh6o5cJGB6mp6wQYieDYhtNKKzx
 8CoFgGFS7GvqpoJvu9OHVE7mZgJ7H22mqJZjgSzsuaDCZcjKDTOtU+fe51Dc4dffXhHb
 W7+jgEXaXtNi6iCKoTknbXX51wOYX2w1NbDxtYRXjzppCnW6AcV0P1GQrzxUAhftgGNg
 u+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792509592; x=1793114392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5BjdKvBZdXi8e0VydYgvdPKEZPO1zw4zmgyGyLoROGY=;
 b=IPZiO7qXHU7rbO6CYLy3ckEXXRdoxHUM+vgzPf9rBG0UAk2F7CD3ydPMcBcNq9cyZP
 vAC87v0Flck5DiHGCAHCrkAs7Gn/W75QQfOXH2sBekG52wckBQMVVzEnFguV+aQJll+x
 TItXRtceaXu+nm42bAIrTWLYdwf0euJsYwpMsvQhDuCoez6ZhR4Ax4xwHfH9dbqIsCTr
 gbKyGsrInogQTJdg8yZidQkpDNY8ltSCjrR1g7za+QWBKdyeL4e/7fPTUs2DOzOXs3mC
 OYH/AR53sInPfOfmgqsPqfx1opFJ1CXqG9cRxpZmvTwqDwFEiz2orZcUni/lVtgbjej7
 tZmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKeQk7IpzGUNiPKodIJU4O8RghVE0+9Erhl0zLh9v5jDfqN5Pb054Co5H5aM4wEnIE8i/uYRMLBSI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJHq7H3Yejx6slefm02fQqx5xvxXLd4K+ivRQ/r8QhcyLQxz0Qq
 JZRiw9bZucvChUQGHdP7LWALmJeabFmm5tq6DIse8PZAtsMUj6qCXN2fDlBxZ0U4RsXOXmOKcrN
 eYhz39/aQ742xAQHGVZBqFL9W7IPCK0jH72ML+cTbLxZHAo/vxTlYmZHF5+Bex+5MzDPsCLFL46
 XZWYMB6l4zc6Mpm7DEqszlPVWpfOshnHfCiicWYme5QlYqXSVz5BHia1c7mQptJCFdIWAGWcE2U
 h0uWQgiLOxCDTCxqWKAjD43DoU=
X-Gm-Gg: AYBFou3olbXauVCqlhuRGrFOYA+c/I6l+x35ceuiV0eSIV8Rlc7G7MsyEisd6r/+Di3
 O8neT7UxWzlKA05olIoSQu2TecA5TKFEsElbV+fwjWPUJ6T90IkOn7zjmtKDJU8C+l/X/MLjON1
 Or1eMW1HjBg2iMnc5wrEYTk11LIuvqdfIU605B/ycoXdw08EWf5ay8duhKFT3ac6Df0w2eOtNpZ
 h/UV6xAnlXdeZ5TtGWzy3xFLavcSh57Wf/4lMiFZf/P3Dg2OfpPaIej7TnfXd6PPWO4/yCJOjlL
 iXb9YR57VN22jGO5rMy+LYpVP4fWhJssef1brH2PhdBD1lvADGDduNTDVZzNwtIw36BGe/Ao1az
 aCyrx4YAubMYms0mb9548qLH9If90PoAkmMP4JOPajOwtKUaiQ71lJCuBfltsNuDLDU2/oFZS6U
 Do59ZdaQ4FV8I6M9WQZknvbucB4xL6w0JXPTNSfwKPV3pjYQ4EcQDetlXp78QpMCEGCbVBfCGL0
 SoIGkMP
X-Received: by 2002:a05:6000:491a:b0:48d:deb0:f1a7 with SMTP id
 ffacd0b85a97d-48e1e7a833fmr5356424f8f.10.1792509592395; 
 Tue, 20 Oct 2026 08:19:52 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d817d80sm7410663f8f.26.2026.10.20.08.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:19:52 -0700 (PDT)
From: Lucas Tanure <lucas.tanure@neat.no>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dom Cobley <popcornmix@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/vc4: hdmi: enable scrambling before the TMDS clock
 starts
Date: Tue, 20 Oct 2026 16:19:48 +0100
Message-ID: <20261020151948.83459-4-lucas.tanure@neat.no>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020151948.83459-1-lucas.tanure@neat.no>
References: <20261020151948.83459-1-lucas.tanure@neat.no>
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

