Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892E606D83F
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yu5I86GM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6914A10E14E;
	Wed,  4 Nov 2026 18:57:14 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FDC210E14E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:57:08 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so660611f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 10:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793818627; x=1794423427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C6QSFeWBFed5RRDCZFUyOzGQ53jm2iRwGaePUB0IWS8=;
 b=Yu5I86GMmY5mCzSFr8zdzBBwoDB2ZQ3i+crFeyQDaQlNsy9WtdMCCBzHWvUTU6p/zh
 orS4z3cVn5NcBcnp2zTSsocMyX/Tt+3X1PRP/MI+qwCwj9yw8yoX0VpXP8dFIntNMX3S
 rU4r0yOENcV4vHZt3RU3GALKQg4IdHk6oLPAfRXkWfooUDIHh+O8NyVeSbi6fH7IhJpA
 4Rh9o5fVX3NwD1z4zPqLfJfj2fPX299SaABss7WcdjR2kLKhIg0V1Tb4bz2uwYKZqZUK
 PjJSMz5R+QfwqCbWal6F63nGELX0pXO+wD6f5g+7C0ffHSRI3Ub0iQalDCM5mpwW5tY1
 bEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793818627; x=1794423427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C6QSFeWBFed5RRDCZFUyOzGQ53jm2iRwGaePUB0IWS8=;
 b=XNjR43DxpO3WLJuvSmcbB6IKnOfZ43vGht1vnZdhy/jvhRPHRiZ8JPVjLhvUx3fLef
 sz8me04DOPk8aEU6auM6HT5e3qmPIWewEkl68iLx0yk7dK4q9GUgAAFQAWd0nfX3Df5G
 Fmhzdfq7dbXl4f9IJAN0f7yZUyqLp6KrkXac2Zq3GpmvYYyZNKpMq3Jx04rNP+5kMgRv
 54bpDqhiIGZgXaicfidgp3pd3a438Z+yzKGna1ZlANlRxpdzRWO7D83MxKbWGTgCX7AT
 h8FCwyUCxdlf8gotmlZmwOMWllPb8KyELh1N6iMmT6VQ5KebfavZG9Kh92Lzgd4bT4sJ
 3mOQ==
X-Gm-Message-State: APuU4Z+QiW14OPysH9qpcb1KPCLwxjevqWkLMUfa8bzMfGXvPgnpZd6G
 HEbCkqwMvEEZkcK2LDf1mkVZ1Xc+/bkkWcUy5mAhatGS620NTWWb+rpU
X-Gm-Gg: AYBFou2POUodLYGZa8Tlh2eljNSArCxZiJ1beou2kmZzTIEXxkjMBLrc+8PV1Fq/eo2
 jggj4x3kBRY2k4KZ8ni4+OEtAhwv+eFUr0mDV/2UPugUsACMN+eZjQXrQOEGE+3nhc/0c9ZoD+r
 qwc2Umxfl6X0fvk5ofL43LVRswjFAB/2pR9WTBYOZ20HvzzoPiU/BpYxqN0XZYtYxKKSpFdHsnH
 9rmX4G9MRI/YgbNz8KPyllBQO0M3F1dJF6f+PibymOMYp+itzfkfDTjYJIwIld+Oy9hiaUKYmMF
 HGY0hsTzJiEjx95tYukFTT3JGUU8uvNC+wYZ161JVDwSzOCWhTz9k2dlvEPretAplaa+pGO6bsK
 rL2fXMog0TRtfPWM3TW3C6GFOAKSXWvLRPguDoPy6rhXMl+2j8G0Byu0Rl2qUV2RDr37XDSM9MV
 dXBZyB5oEehX9D9eiEGOYfnBSM3MsbHXf285vo47lIbN8Em/cG0hoTwdSQSYOuyMeTwjaKB7L4c
 NOuwvsc+uZ9hhUfJNbJXjzyKpdtVAchJQfnwBYV21kK35QgU+btxU5OramqYcqOLNQ4QxNADegN
 OAi+ZTCQOq0jRf//sDl3svBctLAc/Mh5+C7+fgXlBHykHXtU5TVxUwWmZSewWvXbEMvKZgtH2yz
 SLrZTBxrn+e22IsGGU0ScXC4EKtKvxBgfK1XBty37S7KSNPXclHIBP1kXkEbKlPjeBtxP5aAMEQ
 xeU3XdEPwFEqC0bPw4RWbxcwpXXDqqXDV5GtCEFN+9PvDbVVrUNfNIEItNL3uEG83YHJiRElI+L
 VVp146A1zpJDbqr8xfaOlRAxKgR8RGbwtOT/XimRFjxGdAP4pR/dRqr8bcLnJOoXvo=
X-Received: by 2002:a05:6000:160b:b0:48e:7476:9205 with SMTP id
 ffacd0b85a97d-48e74769219mr22849870f8f.31.1793818626772; 
 Wed, 04 Nov 2026 10:57:06 -0800 (PST)
Received: from jernej-laptop (APN-122-103-30-gprs.simobil.net. [46.122.103.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed08343dsm5463560f8f.30.2026.11.04.10.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 10:57:06 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Samuel Holland <samuel@sholland.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] drm/sun4i: dw-hdmi: Deinit PHY in bind error path
Date: Wed,  4 Nov 2026 19:56:59 +0100
Message-ID: <20261104185659.884455-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

sun8i_hdmi_phy_init() enables the PHY clocks and deasserts the PHY
reset. When dw_hdmi_bind() fails afterwards, the error path doesn't
undo that, so the clocks stay enabled and every further bind attempt
enables them once more.

Call sun8i_hdmi_phy_deinit() in the error path, like unbind does.

Fixes: c64c8e04a12e ("drm/sun4i: dw-hdmi: Fix HDMI PHY clock setup")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index bd3923ef5a41..983826001f12 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -209,6 +209,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 
 cleanup_encoder:
 	drm_encoder_cleanup(encoder);
+	sun8i_hdmi_phy_deinit(hdmi->phy);
 err_disable_clk_tmds:
 	clk_disable_unprepare(hdmi->clk_tmds);
 err_assert_ctrl_reset:

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

