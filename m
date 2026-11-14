Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299C606A32E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxMJw2xN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8875510F016;
	Sat, 14 Nov 2026 16:25:00 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0920A10E115
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 13:54:29 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-36dbde64409so2949695eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794664468; x=1795269268; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gGmruHJ/d6lhrlzOYNGlUsY2YpHY8fcVGUsWg8qJB1g=;
 b=mxMJw2xNnjHIz4LwYV6Whzrmzvkk5xWgpHxpoKxPwm4NzbZr9CWYjS8Z5HgJvwUuej
 Q4ab0Vj4iSLSfEg0FApyIp/IbtTtjnmtJHPL5s2eIQO6g38IYxn4nr9MiaA2m/6dZJE6
 kQGTjXVd5Z5u+taCt2S0iFbq46dMTAXWbaDp3MoUMGY/zalVMmq023i5EA1DbRoDBIK5
 5I25klBRITWJ8h9EBgHP5fvP7InQkcSzNWRdhKx7uiswv6wXG3O65Jh4tvFqENlMgaSJ
 wKC5n+0fRgzyPxYz4dW56CYlvGbOy+ArCAS/GiWqUx237yU8u334mtH7PKkAHtW6EbbN
 JkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794664468; x=1795269268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gGmruHJ/d6lhrlzOYNGlUsY2YpHY8fcVGUsWg8qJB1g=;
 b=Q8rWoGivGx4/3nAmEIlwQ7xkA+C7RxkMf8czvn61sQFtXgtvg0GIuvb1LLCG72TtTf
 Uxe1virAeeNDQq7XSknGIwcjFuz9gKneD1jxkxE64OvaHb7n/1eGQdB5tlEiphC/A2TC
 kuxtR6xWwkCS5oanPlv2PYfIi4CP5z+jvrPgMqMWnABnTuDL7ziwvbHWeNfOvuX7lATW
 bnrNGCPdfJfifYnfWnD1Asm1p5fIa7dJl49/4n13siZW+bxF6YGv2iyxp7jBllGiFR+5
 V3P9g8YcDe4Ie6eUyKw2tWG1zCMMRHO6RBEgomUCuwBdRn0dLs62iAWb+K0byrLUh+jR
 6Bbw==
X-Forwarded-Encrypted: i=1;
 AL+hErGelnCLai6IKyP0SHl8pYiTNh0Za+iKCMlq4HQI6JhVktPyER+HgjACyImkLQHn0qC6PMEnanfsUSY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/qc7PxR8vBTPEVFym9uRI0QRqLFDwiwWTrPRQz3Xih/i0IRbjP
 iV712Vx3z1Yh8LZF03mlJkfEF6K1wVZN/7K7q1IvWq18EfrRd5/WMACX
X-Gm-Gg: AYBFou2iLmOU+fb1721T6JKuLkaYE6PWCkBt6zYklKQEfWYZCHrNtoYyQhjP1f30/VE
 UHmYmqImDAaZ4YxX75nP1KMaAR2ozzIH7IjiAtBzs/QWRVSRaAPo9s10d1fpB6r1UXMl2n9KMrp
 4heXWJI9sNVxb7jVtSbyVmh/6XUJiJMXOxRSQpa8+sHBIchiXqxVWpixqHBst+8xGvaC9xNNdwi
 Ulg+3TjyJ/ZUYCKvXoudcESW9tEB8rvPwKF9kld+Nya2qc5Me0DzuiulFNIgrSDwRByD5JrEwxr
 zvQ7DRjqquVLIIS+stEQVJRTw9M2nrFLXXGm2dIZ1PxWY/c0nLgwHkjZFFQT++Bgn3XsdCeYRjc
 S6aTp1BZubnj2MjI8nfkIR5BqA2/GOdzxT5WmyshaMvAMkKzmkB0q9f75WdQn60ThBTDvOp2wez
 OXh1huV/LdML9ghZ2dLVioPHxNEX3JCFm2fJT8vwVu0IzYF5gG4ZF1/d+XiMBdmaKJ4HRIE0EuN
 Gn7RR0V2YX3i06jo3P10udxAq9Xq3xrZgxEoolGyjWGegKQXOq10BMAmTZLMCigmT0/uam3ArBZ
 gH9l1Ji3I/+FWkZr2nTikXSpzoZRkhrD7G/wer6r8v3b
X-Received: by 2002:a05:7300:fb8c:b0:376:a62b:ae09 with SMTP id
 5a478bee46e88-3796676a1e8mr7262154eec.16.1794664467912; 
 Sat, 14 Nov 2026 05:54:27 -0800 (PST)
Received: from evo.www.tendawifi.com ([103.98.7.211])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563df84fsm32749525eec.20.2026.11.14.05.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 05:54:27 -0800 (PST)
From: Archit More <architmore303@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: Chris Morgan <macromorgan@hotmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Archit More <architmore303@gmail.com>
Subject: [PATCH] drm/panel: newvision-nv3051d: Propagate init sequence errors
 to prepare()
Date: Sat, 14 Nov 2026 19:22:51 +0530
Message-Id: <20261114135251.32775-1-architmore303@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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

In commit 3944ca3e6b7d ("drm/panel: newvision-nv3051d: Use
mipi_dsi_*_multi(); fix minor bugs"), prepare() and unprepare() were
converted to use mipi_dsi_*_multi() helpers, but
panel_nv3051d_init_sequence() continued using its own local struct
mipi_dsi_multi_context and unconditionally returned 0. Consequently,
errors encountered during the panel init sequence were discarded and
never reached prepare().

Convert panel_nv3051d_init_sequence() to take struct
mipi_dsi_multi_context * directly from prepare() so all DCS commands
share the same context. Referred to panel-elida-kd35t133 to solve
the issue.

Signed-off-by: Archit More <architmore303@gmail.com>
---
 .../gpu/drm/panel/panel-newvision-nv3051d.c   | 383 +++++++++---------
 1 file changed, 187 insertions(+), 196 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
index 9ee0fa5b446a..38d49e1d27a6 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
@@ -44,203 +44,196 @@ static inline struct panel_nv3051d *panel_to_panelnv3051d(struct drm_panel *pane
 	return container_of(panel, struct panel_nv3051d, panel);
 }
 
-static int panel_nv3051d_init_sequence(struct panel_nv3051d *ctx)
+static void panel_nv3051d_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	struct mipi_dsi_multi_context dsi_ctx = {.dsi = dsi};
-
 	/*
 	 * Init sequence was supplied by device vendor with no
 	 * documentation.
 	 */
 
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x30);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x52);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE3, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x40);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x12);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x1E);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x28);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x52);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x57);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2A, 0xDF);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x9C);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0xA7);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3A, 0x53);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x3C);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0xFE);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5C, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x91, 0x77);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x92, 0x77);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xA0, 0x55);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xA1, 0x50);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xA4, 0x9C);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xA7, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xA8, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xA9, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xAA, 0xFC);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xAB, 0x28);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xAC, 0x06);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xAD, 0x06);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xAE, 0x06);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xAF, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB0, 0x08);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB1, 0x26);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB2, 0x28);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB3, 0x28);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB4, 0x33);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB5, 0x08);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB6, 0x26);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB7, 0x08);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB8, 0x26);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x30);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x52);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB1, 0x0E);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xD1, 0x0E);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB4, 0x29);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xD4, 0x2B);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB2, 0x0C);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xD2, 0x0A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB3, 0x28);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xD3, 0x28);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB6, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xD6, 0x0D);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB7, 0x32);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xD7, 0x30);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xC1, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE1, 0x06);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB8, 0x0A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xD8, 0x0A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB9, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xD9, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xBD, 0x13);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xDD, 0x13);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xBC, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xDC, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xBB, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xDB, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xBA, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xDA, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xBE, 0x18);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xDE, 0x18);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xBF, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xDF, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xC0, 0x17);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x17);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB5, 0x3B);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xD5, 0x3C);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB0, 0x0B);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xD0, 0x0C);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x30);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x52);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x61);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x80);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0xC7);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x82);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x83);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x61);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0xC5);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x80);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x23);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x82);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x83);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x80);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x81);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0xF2);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0xF1);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0xF4);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0xF3);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0xF6);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0xF5);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0xF8);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0xF7);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7F, 0x80);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x5A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB1, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB4, 0x0E);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB5, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB6, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB7, 0x07);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB8, 0x06);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xB9, 0x05);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xBA, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xC7, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xCA, 0x0E);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xCB, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xCC, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xCD, 0x07);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xCE, 0x06);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xCF, 0x05);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xD0, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x84, 0x0E);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x85, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x86, 0x07);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x87, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x88, 0x05);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x89, 0x06);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8A, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x97, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9A, 0x0E);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9B, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9C, 0x07);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9D, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9E, 0x05);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9F, 0x06);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xA0, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x30);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x52);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xDA);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0xBA);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0xA8);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x9A);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x70);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0xFF);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x91);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x90);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0A, 0xFF);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0B, 0x8F);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x60);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0D, 0x58);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x48);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0F, 0x38);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x2B);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x30);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x52);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xFF, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3A, 0x70);
-
-	dev_dbg(ctx->dev, "Panel init sequence done\n");
-
-	return 0;
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x52);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xE3, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x04, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x24, 0x12);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x25, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x26, 0x28);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x27, 0x52);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x28, 0x57);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x29, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2A, 0xDF);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x38, 0x9C);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x39, 0xA7);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3A, 0x53);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x44, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x49, 0x3C);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x59, 0xFE);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5C, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x91, 0x77);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x92, 0x77);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA0, 0x55);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA1, 0x50);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA4, 0x9C);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA7, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA8, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA9, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xAA, 0xFC);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xAB, 0x28);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xAC, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xAD, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xAE, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xAF, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB0, 0x08);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB1, 0x26);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB2, 0x28);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB3, 0x28);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB4, 0x33);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB5, 0x08);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB6, 0x26);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB7, 0x08);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB8, 0x26);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x52);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB1, 0x0E);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD1, 0x0E);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB4, 0x29);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD4, 0x2B);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB2, 0x0C);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD2, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB3, 0x28);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD3, 0x28);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB6, 0x11);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD6, 0x0D);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB7, 0x32);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD7, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC1, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xE1, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB8, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD8, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB9, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD9, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBD, 0x13);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDD, 0x13);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBC, 0x11);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDC, 0x11);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBB, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDB, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBA, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDA, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBE, 0x18);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDE, 0x18);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBF, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDF, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC0, 0x17);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xE0, 0x17);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB5, 0x3B);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD5, 0x3C);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB0, 0x0B);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD0, 0x0C);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x52);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x00, 0x2A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0x2A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x02, 0x2A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0x2A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x04, 0x61);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x06, 0xC7);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x07, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x08, 0x82);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x09, 0x83);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x30, 0x2A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x31, 0x2A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x32, 0x2A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x33, 0x2A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x34, 0x61);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x35, 0xC5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x36, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x37, 0x23);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x40, 0x82);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x41, 0x83);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x42, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x43, 0x81);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x44, 0x11);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x45, 0xF2);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x46, 0xF1);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x47, 0x11);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x48, 0xF4);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x49, 0xF3);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x50, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x51, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x52, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x54, 0x11);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0xF6);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x56, 0xF5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x57, 0x11);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x58, 0xF8);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x59, 0xF7);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7E, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7F, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xE0, 0x5A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB1, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB4, 0x0E);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB5, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB6, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB7, 0x07);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB8, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB9, 0x05);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBA, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC7, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCA, 0x0E);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCB, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCC, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCD, 0x07);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCE, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCF, 0x05);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD0, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x81, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x84, 0x0E);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x85, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x86, 0x07);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x87, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x88, 0x05);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x89, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x8A, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x97, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9A, 0x0E);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9B, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9C, 0x07);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9D, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9E, 0x05);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9F, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x52);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x02, 0xDA);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0xBA);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x04, 0xA8);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x9A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x06, 0x70);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x07, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x08, 0x91);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x09, 0x90);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0A, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0B, 0x8F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0C, 0x60);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0D, 0x58);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0E, 0x48);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0F, 0x38);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x10, 0x2B);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x52);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x36, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3A, 0x70);
 }
 
 static int panel_nv3051d_unprepare(struct drm_panel *panel)
@@ -285,11 +278,9 @@ static int panel_nv3051d_prepare(struct drm_panel *panel)
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 	msleep(20);
 
-	ret = panel_nv3051d_init_sequence(ctx);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
-		goto disable_vdd;
-	}
+	panel_nv3051d_init_sequence(&dsi_ctx);
+	if (!dsi_ctx.accum_err)
+		dev_dbg(ctx->dev, "Panel init sequence done\n");
 
 	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 	mipi_dsi_msleep(&dsi_ctx, 200);
-- 
2.34.1

