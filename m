Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB08606A33B
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tu2PZw02
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF4510E467;
	Sun, 22 Nov 2026 08:18:53 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6838710E467
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:18:47 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6b87a240de3so2715941a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795335526; x=1795940326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JbXjqMfnvt4YseLHRKZimZ/QrsGIK2yqJbgIKnZOfks=;
 b=Tu2PZw02zeOtpdXwT+06c2n1T15jEk/4qDZJSBO4F3Ck3332BhaK/gjPJMDFB3T18t
 cSg7x3o+X3djHqU9b+1nh5DjyAxd85IYbAzShb3/HFZXgl7Yxqfj4AGHGkvNPdsz1Vhb
 z0hrPfsZdj87KLj+ylHvljq6aJX/XGGJ6aQGbSHL2eUwaPWT9rF2TStwdlyiEMPJDez/
 rfF9xakQr4rmbXUUIzkLpqQPvR6p1ms3A27mEhFqKESIbbQR4ipqN/A2StlXxqam87yY
 G6WbE6iysSk4y6AAnKCmkjkWnyHSrDwYXmyvdQYqZD4qq3Ty9g/pKbgaypzFuKzbbxEj
 Dtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795335526; x=1795940326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JbXjqMfnvt4YseLHRKZimZ/QrsGIK2yqJbgIKnZOfks=;
 b=fSdH75ESALcnIWv2IXapA5QyiI951JYlctS4GK7QVwDyMmyyS5zT7XZ/CLnSD43xzd
 FFp1qjKzTxjvXnuRaU7I3FlrPt5PKBRe4cfFMQkNm6TDlXiuLSxMB0bSs6R2nzENAUPV
 HVN0YZPbhLeNZIPOfeMdmV15VsbDBgBGNYA8Oc+Fe+7kVC/o/VL8by1B9s+zI4yvFotQ
 4wD2iqwqnvs4pqMDVHWfcQbXALjXgYSOFg8Q+o48iVYGurrUDDdL1VXvvRPeJ4uWhI9I
 YBijgb+xOldft0mwEjaM6W/xUfx02syRsKjxpNWcAp+/F3btcbvn2cjatKUG7bgvAUlr
 AxKQ==
X-Gm-Message-State: APuU4Z+9YdPcM3Y4S7UXD43iZOQHgGB6FY5rBwbetWIHKtkW4zGBY5Xq
 bNIWa7x1Q7Qu50G2+DrrEUc7GWA9+MDXBQyiiQnJCzf8S7DkKO93PPpU
X-Gm-Gg: AZFdTZcn0gQ7X2DF6Wf+bxNIbLV/oxRWr28qy4RRAgMb//aESsdqd4QH8k3OHO1zdQH
 8RZNxmPH7c2S8kHqsF/Z3hDi+lsUrRGjGM0yX1I6abWwCSNfZ3KZI2BRQwEtY7IxAiBKrj1LIMP
 OMQECoEjpYq4ZEOnRuMW8vu/Cn1yikGejU3JIQ9OOUI7Vd94oyX1zhWaG/aKZqEuyriywNlPEvt
 2VQf3sAjBa3k7cfADxwuBfmdREaAcZH5d2KIHU+II+8Yz4CA4/vaPS2xeOCSvpW5CraTYwLSuXC
 Pk0yBvVmL3UMhVqJDzEsixH5uo+0N2m9+tRUc754RN7uR9V76yk8YfbTG6DwlA57zvhdnZxv0EN
 DG/flXBcAY6RNvgvQXe3XjyrxXWMUUk+qGffX+Iey0+Bd0VJT8xAdxSNbiRlcOzXJWvhebVQIMQ
 1ZTxNQoNVLQlPmbZZwwmZCmuOx29PZF1j82rjFRWV+JY4qXif5QhyV8VoCIp2qCwo2FUCxN93LT
 Y1L1PKGOeHRDHwVpzg3fEQ4vALK1VLhmJoyhsUb0p3uxul1Ky8oB5jP99i5OVDP7U55PnC2iUp+
 xXfdN2dWB58kRZAKCW/18yzEUG84636zPy1kbYOq+AEFvYXgWgevjrwdLbfbvbiFXlK0cGBP74i
 xqIIwV7R1dQ==
X-Received: by 2002:aa7:d842:0:b0:6b6:e808:9703 with SMTP id
 4fb4d7f45d1cf-6ba37c774camr4105257a12.4.1795335525661; 
 Sun, 22 Nov 2026 00:18:45 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370e8ad0sm3617167a12.18.2026.11.22.00.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 00:18:43 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/12] drm/panel: panel-hitachi-tx10d07vm0baa: Convert to
 mipi_dbi_write_seq_multi()
Date: Sun, 22 Nov 2026 10:18:11 +0200
Message-ID: <20261122081820.53199-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122081820.53199-1-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Switch from the internal panel command-sending macro to a generic one
to improve code reuse.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 213 +++++++++---------
 1 file changed, 101 insertions(+), 112 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
index 318ece68b7806..c5b59a7341d8e 100644
--- a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
+++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
@@ -37,19 +37,6 @@ static inline struct hitachi_tx10d07vm0baa *to_hitachi_tx10d07vm0baa(struct drm_
 	return container_of(panel, struct hitachi_tx10d07vm0baa, panel);
 }
 
-#define panel_dbi_command(priv, cmd, seq...) \
-({ \
-	const u8 d[] = { seq }; \
-	struct drm_panel *panel = &(priv)->panel; \
-	struct mipi_dbi_device *dbidev = (priv)->dbidev; \
-	struct device *dev = panel->dev; \
-	int ret; \
-	ret = mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_SIZE(d)); \
-	if (ret) \
-		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret, cmd); \
-	ret; \
-})
-
 static int hitachi_tx10d07vm0baa_prepare(struct drm_panel *panel)
 {
 	struct hitachi_tx10d07vm0baa *priv = to_hitachi_tx10d07vm0baa(panel);
@@ -76,118 +63,120 @@ static int hitachi_tx10d07vm0baa_prepare(struct drm_panel *panel)
 static int hitachi_tx10d07vm0baa_enable(struct drm_panel *panel)
 {
 	struct hitachi_tx10d07vm0baa *priv = to_hitachi_tx10d07vm0baa(panel);
-
-	panel_dbi_command(priv, MIPI_DCS_SET_PARTIAL_ROWS, 0x00, 0x00, 0x03, 0x1f);
-	panel_dbi_command(priv, MIPI_DCS_SET_SCROLL_AREA, 0x00, 0x00, 0x03, 0x20,
-			  0x00, 0x00);
-
-	panel_dbi_command(priv, MIPI_DCS_SET_ADDRESS_MODE, 0x0a);
-	panel_dbi_command(priv, MIPI_DCS_SET_SCROLL_START, 0x00, 0x00);
-
-	panel_dbi_command(priv, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_24BIT);
-	panel_dbi_command(priv, MIPI_DCS_SET_TEAR_SCANLINE, 0x00, 0x00);
-
-	panel_dbi_command(priv, 0x71, 0x00);		/* Ex_Vsync_en */
-
-	panel_dbi_command(priv, 0xb2, 0x00);		/* VCSEL */
-	panel_dbi_command(priv, 0xb4, 0xaa);		/* setvgmpm */
-	panel_dbi_command(priv, 0xb5, 0x33);		/* rbias1 */
-	panel_dbi_command(priv, 0xb6, 0x03);		/* rbias2 */
-
-	panel_dbi_command(priv, 0xb7, 0x1a, 0x33, 0x03, 0x03,
-			  0x03, 0x00, 0x00, 0x01, 0x02, 0x00,
-			  0x00, 0x04, 0x00, 0x01, 0x01, 0x01);	/* set_ddvdhp */
-	panel_dbi_command(priv, 0xb8, 0x1c, 0x53, 0x03, 0x03,
-			  0x00, 0x01, 0x02, 0x00, 0x00, 0x04,
-			  0x00, 0x01, 0x01);			/* set_ddvdhm */
-
-	panel_dbi_command(priv, 0xb9, 0x0a, 0x01, 0x01, 0x00,
-			  0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgh */
-	panel_dbi_command(priv, 0xba, 0x0f, 0x01, 0x01, 0x00,
-			  0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgl */
-	panel_dbi_command(priv, 0xbb, 0x00, 0x00, 0x00, 0x00,
-			  0x01, 0x02, 0x01);			/* set_vcl */
-
-	panel_dbi_command(priv, 0xc1, 0x01);		/* number of lines */
-	panel_dbi_command(priv, 0xc2, 0x08);		/* number of fp lines */
-	panel_dbi_command(priv, 0xc3, 0x04);		/* gateset(1) */
-	panel_dbi_command(priv, 0xc4, 0x4c);		/* 1h period */
-	panel_dbi_command(priv, 0xc5, 0x03);		/* source precharge */
-	panel_dbi_command(priv, 0xc6, 0xc4, 0x04);	/* source precharge timing */
-	panel_dbi_command(priv, 0xc7, 0x00);		/* source level */
-	panel_dbi_command(priv, 0xc8, 0x02);		/* number of bp lines */
-	panel_dbi_command(priv, 0xc9, 0x10);		/* gateset(2) */
-	panel_dbi_command(priv, 0xca, 0x04, 0x04);	/* gateset(3) */
-	panel_dbi_command(priv, 0xcb, 0x03);		/* gateset(4) */
-	panel_dbi_command(priv, 0xcc, 0x12);		/* gateset(5) */
-	panel_dbi_command(priv, 0xcd, 0x12);		/* gateset(6) */
-	panel_dbi_command(priv, 0xce, 0x30);		/* gateset(7) */
-	panel_dbi_command(priv, 0xcf, 0x30);		/* gateset(8) */
-	panel_dbi_command(priv, 0xd0, 0x40);		/* gateset(9) */
-	panel_dbi_command(priv, 0xd1, 0x22);		/* flhw */
-	panel_dbi_command(priv, 0xd2, 0x22);		/* vckhw */
-	panel_dbi_command(priv, 0xd3, 0x04);		/* flt */
-	panel_dbi_command(priv, 0xd4, 0x14);		/* tctrl */
-	panel_dbi_command(priv, 0xd6, 0x02);		/* dotinv */
-	panel_dbi_command(priv, 0xd7, 0x00);		/* on/off sequence period */
-
-	panel_dbi_command(priv, 0xd8, 0x01, 0x05, 0x06, 0x0d,
-			  0x18, 0x09, 0x22, 0x23, 0x00);		/* ponseqa */
-	panel_dbi_command(priv, 0xd9, 0x24, 0x01);			/* ponseqb */
-	panel_dbi_command(priv, 0xde, 0x09, 0x0f, 0x21, 0x12,
-			  0x04);					/* ponseqc */
-
-	panel_dbi_command(priv, 0xdf, 0x02, 0x06, 0x06, 0x06,
-			  0x06, 0x00);					/* pofseqa */
-	panel_dbi_command(priv, 0xe0, 0x01);				/* pofseqb */
-
-	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_BRIGHTNESS, 0xff);
-	panel_dbi_command(priv, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x40);
-
-	panel_dbi_command(priv, 0xe2, 0x00, 0x00);		/* cabc pwm */
-	panel_dbi_command(priv, 0xe3, 0x03);			/* cabc */
-	panel_dbi_command(priv, 0xe4, 0x66, 0x7b, 0x90, 0xa5,
-			  0xbb, 0xc7, 0xe1, 0xe5);		/* cabc brightness */
-	panel_dbi_command(priv, 0xe5, 0xc5, 0xc5, 0xc9, 0xc9,
-			  0xd1, 0xe1, 0xf1, 0xfe);		/* cabc brightness */
-	panel_dbi_command(priv, 0xe7, 0x2a);			/* cabc */
-	panel_dbi_command(priv, 0xe8, 0x00);			/* brt_rev */
-	panel_dbi_command(priv, 0xe9, 0x00);			/* tefreq */
-
-	panel_dbi_command(priv, 0xea, 0x01);			/* high speed ram */
-
-	panel_dbi_command(priv, 0xeb, 0x00, 0x33, 0x0e, 0x15,
-			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r pos */
-	panel_dbi_command(priv, 0xec, 0x00, 0x33, 0x0e, 0x15,
-			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r neg */
-	panel_dbi_command(priv, 0xed, 0x00, 0x33, 0x0e, 0x15,
-			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g pos */
-	panel_dbi_command(priv, 0xee, 0x00, 0x33, 0x0e, 0x15,
-			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g neg */
-	panel_dbi_command(priv, 0xef, 0x00, 0x33, 0x0e, 0x15,
-			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b pos */
-	panel_dbi_command(priv, 0xf0, 0x00, 0x33, 0x0e, 0x15,
-			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b neg */
-
-	panel_dbi_command(priv, MIPI_DCS_EXIT_SLEEP_MODE);
+	struct mipi_dbi_multi_context ctx = { .dbidev = priv->dbidev };
+
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_PARTIAL_ROWS, 0x00, 0x00, 0x03, 0x1f);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_SCROLL_AREA, 0x00, 0x00, 0x03, 0x20,
+				 0x00, 0x00);
+
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x0a);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_SCROLL_START, 0x00, 0x00);
+
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_24BIT);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_TEAR_SCANLINE, 0x00, 0x00);
+
+	mipi_dbi_write_seq_multi(&ctx, 0x71, 0x00);		/* Ex_Vsync_en */
+
+	mipi_dbi_write_seq_multi(&ctx, 0xb2, 0x00);		/* VCSEL */
+	mipi_dbi_write_seq_multi(&ctx, 0xb4, 0xaa);		/* setvgmpm */
+	mipi_dbi_write_seq_multi(&ctx, 0xb5, 0x33);		/* rbias1 */
+	mipi_dbi_write_seq_multi(&ctx, 0xb6, 0x03);		/* rbias2 */
+
+	mipi_dbi_write_seq_multi(&ctx, 0xb7, 0x1a, 0x33, 0x03, 0x03,
+				 0x03, 0x00, 0x00, 0x01, 0x02, 0x00,
+				 0x00, 0x04, 0x00, 0x01, 0x01, 0x01);	/* set_ddvdhp */
+	mipi_dbi_write_seq_multi(&ctx, 0xb8, 0x1c, 0x53, 0x03, 0x03,
+				 0x00, 0x01, 0x02, 0x00, 0x00, 0x04,
+				 0x00, 0x01, 0x01);			/* set_ddvdhm */
+
+	mipi_dbi_write_seq_multi(&ctx, 0xb9, 0x0a, 0x01, 0x01, 0x00,
+				 0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgh */
+	mipi_dbi_write_seq_multi(&ctx, 0xba, 0x0f, 0x01, 0x01, 0x00,
+				 0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgl */
+	mipi_dbi_write_seq_multi(&ctx, 0xbb, 0x00, 0x00, 0x00, 0x00,
+				 0x01, 0x02, 0x01);			/* set_vcl */
+
+	mipi_dbi_write_seq_multi(&ctx, 0xc1, 0x01);		/* number of lines */
+	mipi_dbi_write_seq_multi(&ctx, 0xc2, 0x08);		/* number of fp lines */
+	mipi_dbi_write_seq_multi(&ctx, 0xc3, 0x04);		/* gateset(1) */
+	mipi_dbi_write_seq_multi(&ctx, 0xc4, 0x4c);		/* 1h period */
+	mipi_dbi_write_seq_multi(&ctx, 0xc5, 0x03);		/* source precharge */
+	mipi_dbi_write_seq_multi(&ctx, 0xc6, 0xc4, 0x04);	/* source precharge timing */
+	mipi_dbi_write_seq_multi(&ctx, 0xc7, 0x00);		/* source level */
+	mipi_dbi_write_seq_multi(&ctx, 0xc8, 0x02);		/* number of bp lines */
+	mipi_dbi_write_seq_multi(&ctx, 0xc9, 0x10);		/* gateset(2) */
+	mipi_dbi_write_seq_multi(&ctx, 0xca, 0x04, 0x04);	/* gateset(3) */
+	mipi_dbi_write_seq_multi(&ctx, 0xcb, 0x03);		/* gateset(4) */
+	mipi_dbi_write_seq_multi(&ctx, 0xcc, 0x12);		/* gateset(5) */
+	mipi_dbi_write_seq_multi(&ctx, 0xcd, 0x12);		/* gateset(6) */
+	mipi_dbi_write_seq_multi(&ctx, 0xce, 0x30);		/* gateset(7) */
+	mipi_dbi_write_seq_multi(&ctx, 0xcf, 0x30);		/* gateset(8) */
+	mipi_dbi_write_seq_multi(&ctx, 0xd0, 0x40);		/* gateset(9) */
+	mipi_dbi_write_seq_multi(&ctx, 0xd1, 0x22);		/* flhw */
+	mipi_dbi_write_seq_multi(&ctx, 0xd2, 0x22);		/* vckhw */
+	mipi_dbi_write_seq_multi(&ctx, 0xd3, 0x04);		/* flt */
+	mipi_dbi_write_seq_multi(&ctx, 0xd4, 0x14);		/* tctrl */
+	mipi_dbi_write_seq_multi(&ctx, 0xd6, 0x02);		/* dotinv */
+	mipi_dbi_write_seq_multi(&ctx, 0xd7, 0x00);		/* on/off sequence period */
+
+	mipi_dbi_write_seq_multi(&ctx, 0xd8, 0x01, 0x05, 0x06, 0x0d,
+				 0x18, 0x09, 0x22, 0x23, 0x00);		/* ponseqa */
+	mipi_dbi_write_seq_multi(&ctx, 0xd9, 0x24, 0x01);		/* ponseqb */
+	mipi_dbi_write_seq_multi(&ctx, 0xde, 0x09, 0x0f, 0x21, 0x12,
+				 0x04);					/* ponseqc */
+
+	mipi_dbi_write_seq_multi(&ctx, 0xdf, 0x02, 0x06, 0x06, 0x06,
+				 0x06, 0x00);					/* pofseqa */
+	mipi_dbi_write_seq_multi(&ctx, 0xe0, 0x01);				/* pofseqb */
+
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_BRIGHTNESS, 0xff);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x40);
+
+	mipi_dbi_write_seq_multi(&ctx, 0xe2, 0x00, 0x00);		/* cabc pwm */
+	mipi_dbi_write_seq_multi(&ctx, 0xe3, 0x03);			/* cabc */
+	mipi_dbi_write_seq_multi(&ctx, 0xe4, 0x66, 0x7b, 0x90, 0xa5,
+				 0xbb, 0xc7, 0xe1, 0xe5);		/* cabc brightness */
+	mipi_dbi_write_seq_multi(&ctx, 0xe5, 0xc5, 0xc5, 0xc9, 0xc9,
+				 0xd1, 0xe1, 0xf1, 0xfe);		/* cabc brightness */
+	mipi_dbi_write_seq_multi(&ctx, 0xe7, 0x2a);			/* cabc */
+	mipi_dbi_write_seq_multi(&ctx, 0xe8, 0x00);			/* brt_rev */
+	mipi_dbi_write_seq_multi(&ctx, 0xe9, 0x00);			/* tefreq */
+
+	mipi_dbi_write_seq_multi(&ctx, 0xea, 0x01);			/* high speed ram */
+
+	mipi_dbi_write_seq_multi(&ctx, 0xeb, 0x00, 0x33, 0x0e, 0x15,
+				 0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r pos */
+	mipi_dbi_write_seq_multi(&ctx, 0xec, 0x00, 0x33, 0x0e, 0x15,
+				 0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r neg */
+	mipi_dbi_write_seq_multi(&ctx, 0xed, 0x00, 0x33, 0x0e, 0x15,
+				 0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g pos */
+	mipi_dbi_write_seq_multi(&ctx, 0xee, 0x00, 0x33, 0x0e, 0x15,
+				 0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g neg */
+	mipi_dbi_write_seq_multi(&ctx, 0xef, 0x00, 0x33, 0x0e, 0x15,
+				 0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b pos */
+	mipi_dbi_write_seq_multi(&ctx, 0xf0, 0x00, 0x33, 0x0e, 0x15,
+				 0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b neg */
+
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_EXIT_SLEEP_MODE);
 	msleep(110);
 
-	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_ON);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_ON);
 
-	return 0;
+	return ctx.accum_err;
 }
 
 static int hitachi_tx10d07vm0baa_disable(struct drm_panel *panel)
 {
 	struct hitachi_tx10d07vm0baa *priv = to_hitachi_tx10d07vm0baa(panel);
+	struct mipi_dbi_multi_context ctx = { .dbidev = priv->dbidev };
 
-	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_OFF);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_OFF);
 	msleep(35);
 
-	panel_dbi_command(priv, MIPI_DCS_ENTER_SLEEP_MODE);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_ENTER_SLEEP_MODE);
 	msleep(50);
 
-	return 0;
+	return ctx.accum_err;
 }
 
 static int hitachi_tx10d07vm0baa_unprepare(struct drm_panel *panel)
-- 
2.53.0

