Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A7606D835
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+/xRGNJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F161D10F117;
	Mon,  9 Nov 2026 09:31:35 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB8510E637
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 17:46:19 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso935998f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 09:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794073578; x=1794678378; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BICHTACzcYBYNKwFNl6UZpjtKoThY04fDneyezGDUuQ=;
 b=Z+/xRGNJBRU3WvFCxstjmD0q+HMpLXsSw/uVAF1a6qwM5Lm6neFszAfekko4vrP6kc
 rmltSiBK4p6qe+OKpaEYo7zLi4NBqYpCz5k9Bslud5+49UEKwdnQfA7KsMve76EkboG2
 31g0Sp/bEFu0df6GMT0T2xZDHbJtGI1VJMqLW2oPeqRDit8BYCUOM8/hNmI811kSdxCv
 VUS3utlvf9crncF8HUvslavqRD8nzLPReB1qFo1GNNdj+YcPfTxHTkA9qM2gtLAyhY5n
 Xvxk5tT8bNhvYY8Uv8vWHoO7WOkDrmSKHz9D3kX/onF9MeeL+3f7BXKtyUkA1knwYnAh
 Wzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794073578; x=1794678378;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BICHTACzcYBYNKwFNl6UZpjtKoThY04fDneyezGDUuQ=;
 b=uNvFGKsmaevADJDdi8jgm/am4zXmRpHqmrOYiGKiLn/uIFDNSTDDhBUtZw95Dkyd+9
 mbu+6NF7BAKLwSrzLnSgm61EOTqR4jhfGVhWq5RhPyp0tdWGtKP1JXMLQF7wDyXHkXTX
 0doAIXUtuJ0Le6fpU7m0Au1JywBJDkeqRW/FdmloDRXpcgeh+CnmYeANTgj1gnVMIJ92
 BGTCq9vNJs6GEbSXf6XZITEah4MeZ1wQYtXopC1Ba4jw5sgAEmiPbGEFLv/L8ttTDWeM
 K4CY2fvv98zpX2rBsFH/ZPpEBWDV6JDr3ZX4vC/Xn6viAETAeucwlhHjkPBYMJdk0Mc+
 abiw==
X-Gm-Message-State: APuU4Z/l8XxXF3tSW5Ek1bHVuExQMGGom+W2LOU43rZZfeBnAuWmhOBX
 HE3+siaNZTIZryMT0huuQWyeelbMbS1zlRamsD1PSayjOtb4gfkUmg4lI5rldTSg
X-Gm-Gg: AYBFou0zEXkrz1tTFn13msdGD0t/9FG02iG8YOhkWew9OfBCihrk/mlqZNppSuNj1Ci
 FO3ZOVocFrh8615HnFSxNH7mmJj55K+Y5J82HQ36No3lFXlFCKxshwR2zyK0gKWlCytmBz72tyO
 YrknhW38ZYuUBGeyrolLztpgtjmheWkmr6bOejgbBA8r4HjPnc8ojmJRNsyzvZphNlv52JhJMHc
 EFy4hod9CjVTTYaImskvJpnUyGiWmHxxO8U1N12ri5MLNPUMlCcZ+oQ/YYeOoc6Syk+ICZS32It
 dZAftRNrC42d8ElqPAdRr3f5j+Sd6ZA+O8SSY2+XcZ6paXNmJB8e9xhUX8+j9vYakm0twFbC3yx
 qaCXisUHPVGdh7lX7vmxEZeWRbvuQN8ejFuZPKGbRwds+ajQs8Stg6jkhLYt2Wh+15ETJOExWj4
 rM6p1Q6CpI+vjP7jE/8HGYld9O/TOra0uUHHKA3mh+OfloeVUotOq5F135VnSJBlN4hn5PTMWoQ
 kNZq2QiUoq8yLiH5vDZbMQzxiMVxw2djs9frDJ7cy6qSLLaW0w+Uyogq2+4Ocw53Fd1i298Eqcg
 On+lgMyHBij3tAUhrnT4ms6pfaHqv/zPD+8iRcyEYQ==
X-Received: by 2002:a05:6000:4690:b0:48d:f851:ee5f with SMTP id
 ffacd0b85a97d-4927721a2b2mr7918701f8f.24.1794073577747; 
 Sat, 07 Nov 2026 09:46:17 -0800 (PST)
Received: from cachyos-x8664.local ([188.127.103.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d770248esm11055718f8f.42.2026.11.07.09.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 09:46:16 -0800 (PST)
From: aic0d3r <igotmysoul@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, aic0d3r <igotmysoul@gmail.com>
Subject: [PATCH] drm: panel-backlight-quirks: Add ASUS ROG Flow Z13 (GZ302)
Date: Sat,  7 Nov 2026 18:45:53 +0100
Message-ID: <20261107174553.123652-1-igotmysoul@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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

The firmware (ATIF) minimum backlight on the 2025 ASUS ROG Flow Z13
(GZ302, Strix Halo) with its TMA 0x0803 panel is fairly bright: at the
lowest brightness level actual_brightness reads 539 of 65535, which is
uncomfortable in a dark room.

Lower min_input_signal to 1 via a min_brightness quirk. With it the
lowest level reads back 0 and the panel is still lit and readable, so
the usable range extends noticeably below the firmware floor.

Match on the product family rather than the product name, since the
product name carries the SKU ("ROG Flow Z13 GZ302EA_GZ302EA"), and on the
panel ID so other panels in the family are unaffected.

Tested on a GZ302EA with BIOS GZ302EA.314 on 7.3.1.

Signed-off-by: aic0d3r <igotmysoul@gmail.com>
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index dcb91e12b..fa5897bb2 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -68,6 +68,15 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
 		.dmi_match_other.value = "Galileo",
 		.quirk = { .min_brightness = 1, },
 	},
+	/* ASUS ROG Flow Z13 (2025, GZ302) */
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "ASUSTeK COMPUTER INC.",
+		.dmi_match_other.field = DMI_PRODUCT_FAMILY,
+		.dmi_match_other.value = "ROG Flow Z13",
+		.ident.panel_id = drm_edid_encode_panel_id('T', 'M', 'A', 0x0803),
+		.quirk = { .min_brightness = 2, },
+	},
 	/* Have OLED Panels with brightness issue when last byte is 0/1 */
 	{
 		.dmi_match.field = DMI_SYS_VENDOR,
-- 
2.56.0

