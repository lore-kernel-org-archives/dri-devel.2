Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6730606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VKKG0/e4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3484810EA13;
	Thu, 19 Nov 2026 16:28:11 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D6CF112573
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:24:38 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-170135e43c7so3723298c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795105478; x=1795710278; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lsB+BaEFTRj6WfPSLmY0ldBNLoRsO2D6mQEhh6aIV78=;
 b=VKKG0/e4VaPmtqv4iJQdO39VY9SG6PBMScdbexGzEhBYuqcr4yFm3Qt+Iwsf8HhV2u
 9phAJKtxhTb0YVj7bifsYFzdtIJre1bSSYG5EmEkKxhF9V7HaSwWok0quWexWglf2BTz
 z0ln2zkGEVcBOwtwYNTVixDywey3k7gMoe4IRtF1S0bdKPwhNB9d54KCFCcUWZ6hzosc
 8tfBjwIbt08WI3qMDFcuvxNmNcQr1VXtD8kNgAWfDO1+LM1xRCFEorNv1iau1WnsjcFN
 BDF68rKMDmEuqrJzdp0QgAwNP5oQyn7gAPBYPRjDawomf30ELfO0rN6D4aYmGlAcyTb0
 VyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795105478; x=1795710278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lsB+BaEFTRj6WfPSLmY0ldBNLoRsO2D6mQEhh6aIV78=;
 b=z+lTNeHPFxz4g98iytt3TNEQ9swvWa5SNHurDQwUiCOEUB5HE4CrRnSx32FC+TDJx1
 Fj/YDJZQunJmTem6oS7g7/GpP+uhi3cRgo8M+yAUWkcBAjYJos2COu92B4xmLIHneYAM
 ZXBhzBFr/ruY82vBtUaaqGhdtcgGlX3DEshBEusDK2btXoc4bgUeo2D+i6pNZXmFkaT9
 7Wwh9jvWxM9k1aOUl88mHls1/OR7QL3uFd2Hi7+j1Y1TxGp1szs8uuC5SYw4NUYibhI5
 6foYpZKBiORqR+kHxPXkXGvQOC9sISf27qFw9dEj18ZLWyNLAmh4ef22hfn4lwxaC6R+
 OyGg==
X-Forwarded-Encrypted: i=1;
 AL+hErEYWylVgAiS+hsRRimdiMUFrOUeLjdsOCNGDsbzPtDZz6/+Ycdt/fOH3vGYLxbmJEkI9WwxZiQ3Z0Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9DBLMRtUGbjE92Yatb9ZlH3DekHMjOwHVabygsfJgihJYh0sSq
 bciUu+vIRMOIT2CXQv8Sy/fVU7iX7K7BmGJDGchuKCIivT9O1ox7uNUU
X-Gm-Gg: AYBFou1Y38bG/tYgrngHC5747nDDnv2TjSrGuid9ppyhstyApzDNtGyR6od9EFtSWLm
 qA7bAqHK+1p1out2gNiT3IfB/59GNtUCxAxtsEkdRq6nDXrQ84BfRDWAyrpzaT+cDYBCcrMvnzE
 W1HijmwpUv527dW7amcc3dU7zBDEBYxAl0aWVyMzUu70jDJ5+MOcHyaDUOYzXNodTWH3Vw84ZPM
 O3oCJt4SFu3lMxdvovzE7GkURgx4VXfHJT+EgJlopNxBAa8C0YnlOVPkQbXSSEoIaUHDgtflUX0
 a/R3C0oiXwU9ciCuV2y73pPEpboU5aPjufWRXgpQ8OfGtL/9ygwd0PoMdo0UNYlt4QKQuGGz8F7
 QebuZNdWex0AyilmePywgfznC6KARr/F+93WR/aTduQp8EAumOVZv3rDqH7FxRnEvw/xfVy0oDc
 8sI0B4AVsJGiuYeAlf1i/qTTT4C7WU41HpxBSdTcqDVWhnELBB60nh8X+2TkmV6vzsQNSOVR+Yy
 ZYFggVb4akkx60EVUSzxU+SLtjns8keH9fpMkrSi5qHUPh0LkpeQvNEN66HdUK8RQ3HpHFO9ACw
 eUIWl8sP8YxfQ8dEZWSXi45R0LfqY7YprRTyiA3m82yI
X-Received: by 2002:a05:7022:e80a:b0:1b3:b8a2:825d with SMTP id
 a92af1059eb24-1b5567f681emr195885c88.3.1795105477660; 
 Thu, 19 Nov 2026 08:24:37 -0800 (PST)
Received: from evo.www.tendawifi.com ([103.98.7.209])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55681301asm302840c88.8.2026.11.19.08.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:24:37 -0800 (PST)
From: Archit More <architmore303@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: Akash Sukhavasi <akash.sukhavasi@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Archit More <architmore303@gmail.com>
Subject: [PATCH 1/3] drm/panel: newvision-nv3051d: Use lowercase hex literals
Date: Thu, 19 Nov 2026 21:53:51 +0530
Message-Id: <20261119162353.12962-2-architmore303@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119162353.12962-1-architmore303@gmail.com>
References: <20261119162353.12962-1-architmore303@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 16:27:44 +0000
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

Convert hexadecimal literals in the NV3051D initialization sequence
to lowercase.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Archit More <architmore303@gmail.com>
---
 .../gpu/drm/panel/panel-newvision-nv3051d.c   | 286 +++++++++---------
 1 file changed, 143 insertions(+), 143 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
index 38d49e1d27a6..013d94e7ce6f 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
@@ -51,108 +51,108 @@ static void panel_nv3051d_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 	 * documentation.
 	 */
 
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x30);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x52);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x01);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xE3, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x52);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe3, 0x00);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0x40);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x04, 0x00);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x03);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x24, 0x12);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x25, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x25, 0x1e);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x26, 0x28);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x27, 0x52);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x28, 0x57);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x29, 0x01);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2A, 0xDF);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x38, 0x9C);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x39, 0xA7);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3A, 0x53);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2a, 0xdf);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x38, 0x9c);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x39, 0xa7);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3a, 0x53);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x44, 0x00);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x49, 0x3C);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x59, 0xFE);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5C, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x49, 0x3c);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x59, 0xfe);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5c, 0x00);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x91, 0x77);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x92, 0x77);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA0, 0x55);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA1, 0x50);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA4, 0x9C);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA7, 0x02);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA8, 0x01);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA9, 0x01);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xAA, 0xFC);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xAB, 0x28);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xAC, 0x06);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xAD, 0x06);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xAE, 0x06);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xAF, 0x03);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB0, 0x08);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB1, 0x26);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB2, 0x28);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB3, 0x28);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB4, 0x33);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB5, 0x08);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB6, 0x26);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB7, 0x08);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB8, 0x26);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x30);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x52);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x02);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB1, 0x0E);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD1, 0x0E);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB4, 0x29);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD4, 0x2B);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB2, 0x0C);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD2, 0x0A);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB3, 0x28);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD3, 0x28);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB6, 0x11);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD6, 0x0D);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB7, 0x32);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD7, 0x30);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC1, 0x04);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xE1, 0x06);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB8, 0x0A);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD8, 0x0A);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB9, 0x01);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD9, 0x01);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBD, 0x13);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDD, 0x13);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBC, 0x11);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDC, 0x11);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBB, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDB, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBA, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDA, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBE, 0x18);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDE, 0x18);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBF, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDF, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC0, 0x17);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xE0, 0x17);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB5, 0x3B);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD5, 0x3C);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB0, 0x0B);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD0, 0x0C);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x30);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x52);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x03);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x00, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x02, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0x2A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xa0, 0x55);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xa1, 0x50);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xa4, 0x9c);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xa7, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xa8, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xa9, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xaa, 0xfc);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xab, 0x28);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xac, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xad, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xae, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xaf, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x08);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb1, 0x26);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb2, 0x28);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb3, 0x28);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb4, 0x33);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb5, 0x08);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb6, 0x26);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb7, 0x08);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb8, 0x26);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x52);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb1, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd1, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb4, 0x29);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd4, 0x2b);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb2, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd2, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb3, 0x28);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd3, 0x28);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb6, 0x11);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd6, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb7, 0x32);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd7, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc1, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe1, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb8, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd8, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb9, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd9, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbd, 0x13);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdd, 0x13);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbc, 0x11);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdc, 0x11);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbb, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdb, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xba, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xda, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbe, 0x18);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xde, 0x18);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbf, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdf, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc0, 0x17);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe0, 0x17);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb5, 0x3b);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd5, 0x3c);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd0, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x52);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x00, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x02, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0x2a);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x04, 0x61);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x80);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x06, 0xC7);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x06, 0xc7);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x07, 0x01);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x08, 0x82);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x09, 0x83);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x30, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x31, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x32, 0x2A);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x33, 0x2A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x30, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x31, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x32, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x33, 0x2a);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x34, 0x61);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x35, 0xC5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x35, 0xc5);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x36, 0x80);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x37, 0x23);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x40, 0x82);
@@ -160,80 +160,80 @@ static void panel_nv3051d_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x42, 0x80);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x43, 0x81);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x44, 0x11);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x45, 0xF2);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x46, 0xF1);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x45, 0xf2);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x46, 0xf1);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x47, 0x11);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x48, 0xF4);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x49, 0xF3);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x48, 0xf4);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x49, 0xf3);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x50, 0x02);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x51, 0x01);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x52, 0x04);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x03);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x54, 0x11);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0xF6);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x56, 0xF5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0xf6);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x56, 0xf5);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x57, 0x11);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x58, 0xF8);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x59, 0xF7);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7E, 0x02);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7F, 0x80);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xE0, 0x5A);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB1, 0x00);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB4, 0x0E);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB5, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB6, 0x04);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB7, 0x07);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB8, 0x06);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB9, 0x05);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBA, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC7, 0x00);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCA, 0x0E);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCB, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCC, 0x04);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCD, 0x07);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCE, 0x06);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCF, 0x05);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xD0, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x81, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x84, 0x0E);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x85, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x58, 0xf8);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x59, 0xf7);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7e, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7f, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe0, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb1, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb4, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb5, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb6, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb7, 0x07);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb8, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb9, 0x05);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xba, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc7, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xca, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xcb, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xcc, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xcd, 0x07);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xce, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xcf, 0x05);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd0, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x81, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x84, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x85, 0x0f);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x86, 0x07);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x87, 0x04);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x88, 0x05);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x89, 0x06);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x8A, 0x00);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x97, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9A, 0x0E);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9B, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9C, 0x07);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9D, 0x04);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9E, 0x05);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9F, 0x06);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA0, 0x00);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x30);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x52);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x8a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x97, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9a, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9b, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9c, 0x07);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9d, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9e, 0x05);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9f, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xa0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x52);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x02);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0x01);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x02, 0xDA);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0xBA);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x04, 0xA8);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x9A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x02, 0xda);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0xba);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x04, 0xa8);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x9a);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x06, 0x70);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x07, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x07, 0xff);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x08, 0x91);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x09, 0x90);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0A, 0xFF);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0B, 0x8F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0C, 0x60);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0D, 0x58);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0E, 0x48);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0F, 0x38);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x10, 0x2B);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x30);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x52);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0a, 0xff);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0b, 0x8f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0c, 0x60);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0d, 0x58);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0e, 0x48);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0f, 0x38);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x10, 0x2b);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x52);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x00);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x36, 0x02);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3A, 0x70);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3a, 0x70);
 }
 
 static int panel_nv3051d_unprepare(struct drm_panel *panel)
-- 
2.34.1

