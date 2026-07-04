Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682BCC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 07:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C63BA10E021;
	Sat,  4 Jul 2026 07:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z54kXeqU";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E00410E021
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 07:06:55 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c85b73ffb52so628187a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 00:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783148815; x=1783753615; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1NiCKyVI2236oFQGXLuqi2mWCdxv0dZds07L8ektAd0=;
 b=Z54kXeqUfGz94GPeBhvtxQErUSHKS0CGeM95qqBR/O+Q3Yb6VlF2pHOG+PmKgy8k6s
 QVBK+b2fe3Sfx3fd1jCyKSbm9nh5kGOwebLorYybdmxAVnG2Xb49dj5QB95fpR3TWp0c
 88QCw57uceHPN/yO1HNKvQm022mDHgJs/1ca4YhqOMvq33Mg/M8MHqKjFHqj1jESTbbP
 g1loeVXRoyQ+V6YpIgcC9ZzJgrk3soc/8iQ5qV1+2h/u9+8nMHO4REjYdgV7MZbcyJll
 MVdL6RTiJ8p3C1fe3KtgYzH5nRWKE65EqahVSqILPNzzhen/u9kYhC7l6GpcVGU27UzP
 yvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783148815; x=1783753615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NiCKyVI2236oFQGXLuqi2mWCdxv0dZds07L8ektAd0=;
 b=qRk1AgJPqn8X/Zm3yywON4/8o43uo0Eqj2Z40niFmeNVvL2utLl5buLuyIwbwK5gt0
 z5yukpBvedUtLe4hyqEX+PHkWKlxYcm91wfBbypngs79wMnlcMTa8kxdXeYtZL+QAeY+
 vtFeZ+/59tzk5mzTOtn3zZYSLG/J1ktNLz4nckNMgYJxaYcOkeqZxvhffgZwsN/5ea0x
 Qk1dlJuQw38mnc9QbClUq9WjW11D/wNliXP1GfVasbu3Od353SneO3N5UuvC6JQETtKZ
 k7cAm9oKff2brSITV7FD2K6odjhSIcHhnR0A7EcVSzV1Oj59umDx6yQ15KhPYwZ69308
 gwVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GJHKJBHLAs5W0E6ouNsABRvJCl7cqWMBqgGqLMjjhyL0vLkWtLb+i6cugB7lbkg/wSn/KC/Mafgk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw90k3S+azqQ6gOA+oCVNQPBEo24chxEtDNPAWI+xadsZhDuYHK
 M5yAW28RFHECQoJufsfCrloDvXVz6hghhefSpbiO8Lg8TjWfx/O9XlZP
X-Gm-Gg: AfdE7clT9oDdH5g5rU3aUrRz976Uy5mfx+RR0kgvGXWRh4pl+qx0F1od/2XnciTI8aI
 LYYJrgFLX216IlRNxKMAIy629CpIrPW0D11dIhNcRDaHRmrDjMF+LBt+pG+eGTMJ6m8uQakJoHG
 WFH+NMb+YMRNe7RWDwhkyivCXn9x2Y0s3WZDXveP+XF1hh1PgVDnDGvl6eWL4m6M/FnqAMfXo0M
 fqOu+xdEzLutFa9tchoU5hfeBBnd+Z9/MepFFB6j3s0G1i2l3fL1HAqBAoSyNuhgBQROfmAhE78
 7AUR/A4wD6uLhjzsuMcplsdJM6sXBwDp754Q51bxcuw71jrhDE/Bs+wJV+R1hs2vNuMjEZUFl+z
 JSI8d+AtiSDIX/sgZ11YNAAnHDUiiUPK6Uxqww2irXs095Jy35poDDObUot8Do9jAKVk3hubIl1
 /+N7YswJ9USIjs4q3U4qX1Mct/5b82s8A4/T+oA+Og8lXZtJcum74Ngs5FJTGjrA==
X-Received: by 2002:a05:6a20:1604:b0:3bf:63af:859 with SMTP id
 adf61e73a8af0-3c03e489710mr2280246637.45.1783148814945; 
 Sat, 04 Jul 2026 00:06:54 -0700 (PDT)
Received: from localhost.localdomain
 ([2405:acc0:1306:1a77:4d22:a645:ecb4:40eb])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3ececfe4sm31918824c88.8.2026.07.04.00.06.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Jul 2026 00:06:54 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Subject: [PATCH v3] drm/panel: samsung-s6d16d0: Power off on prepare failure
Date: Sat,  4 Jul 2026 12:51:48 +0545
Message-ID: <20260704070648.35249-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If enabling tearing mode or exiting sleep mode fails after the
regulator is enabled, s6d16d0_prepare() returns without asserting
reset or disabling the supply. Since the DRM panel core leaves the
panel unprepared, a later unprepare call skips the driver callback
and the supply remains enabled.

Assert reset and disable the supply before returning the DSI command error.

Fixes: ac1d6d74884e ("drm/panel: Add driver for Samsung S6D16D0 panel")
Assisted-by: Codex:gpt-5
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
Changes in v3:
- Regenerate with git-format-patch to preserve tabs and whitespace.
- No code changes.

Changes in v2:
- Resend as plain text with git-send-email.
- Correct author, sign-off, and recipient formatting.
- No code changes.

 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
index ba1a02000..04e19b5f2 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
@@ -89,16 +89,22 @@ static int s6d16d0_prepare(struct drm_panel *panel)
 				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 	if (ret) {
 		dev_err(s6->dev, "failed to enable vblank TE (%d)\n", ret);
-		return ret;
+		goto err_power_off;
 	}
 	/* Exit sleep mode and power on */
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret) {
 		dev_err(s6->dev, "failed to exit sleep mode (%d)\n", ret);
-		return ret;
+		goto err_power_off;
 	}
 
 	return 0;
+
+err_power_off:
+	gpiod_set_value_cansleep(s6->reset_gpio, 1);
+	regulator_disable(s6->supply);
+
+	return ret;
 }
 
 static int s6d16d0_enable(struct drm_panel *panel)
-- 
2.51.2
