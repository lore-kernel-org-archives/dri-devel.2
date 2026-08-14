Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AEAC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61F710E193;
	Fri, 14 Aug 2026 17:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fwaLXJLM";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB5710E193
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 17:34:16 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso627611f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786728854; x=1787333654; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gtJy9LLDFt0NmzJILJgVKeBO+MrtI49rw/kXkyURaBQ=;
 b=fwaLXJLMUNnaAufhCg0VV/HPRZbV76BwBrQzdAoubwPEzSFb+dyK5RO/yh8/jbc8Qz
 5GtdxMniyKvGDPjWnuH1uyiWBHgQAfvwxq7VHqvUo0Zt72HaNUJXUcrgaFHAIxUmmljX
 e0dNKkPA1oWbY2xEhSaVeqB75ZMSEr+NB26melHw2UEFTmckgNh0XVbHwqnQbNOqkQ/q
 1e5m7XkQfx3OUhKmn4GGz807HGMjId1P/HbRU6yMvYlCmkb21gOGcgfABqZgTaooNVNd
 /PAey3yKT08dZBncF2mWmaxPFJPzvU0MbmSpzDIPPgrYkW08RanOdkBOCNH1fF0CsZq2
 DsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786728854; x=1787333654;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gtJy9LLDFt0NmzJILJgVKeBO+MrtI49rw/kXkyURaBQ=;
 b=NhA0CCMsv4FMp/d10XX1qY9F5uWdlRxESpMEX71hoSxLx2NR0A+RPyqxxZn1KV+x7R
 8+G/AQyoEUEH6c6lJ+w7UtC10Kr+41eiQxm+WbdOw8O9jlLnfcW9cVU9QXdFcw034qEy
 DgXF22XwlRM9ScfJmD7CUvR1hU1MjiC0WLtfscQDb1llE15B1Jlndgvo4X31GLJ82Sgj
 m6BoNr7puYlkAIju1jQhLaBfIUMUvboFNTXOvK0/sqiBY3vPNdRUBFWf1yrzEh/0sYHi
 hc3hHzFVMI5eCwnpQIZXYeGJ5GFHBSDulG1cGkfpmH6GKniYD7DH6CdWB8evg+gr2fdG
 3eLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwJErQNl3dvLOM5qlcWCseZA7E4OMBbBEMRn+ciNB1IgXlR4Ecu2TphlxSSOOOOMtwW+2OjdrgU+Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxB9CYGtvla2ijittJi5C6kQAInxDOSD2qzA46D8Ny/apF/Ncye
 mrqwHJ5aLY8ymbb9HCUbT57Jx1ABTZ7tSAnEJL+yvYK19Fk7ekryMUvM
X-Gm-Gg: AR+sD12izpawn3ErHXrdtwpBpa6Vn9fWCWfrqK8nDq+ooFOMb0Fr2WTqV8E34z/a45m
 bMX2rlmtnFaiiZp8x2MprkGP9ykY97LqbZ0smq26xWA9U5BZONr+RBeW6kAfvjhFBI+3z9C63A3
 ZZOHKsVxj4f1hauReGeVQXFe0mtvoOopgffRk2slh9ABw8bCGUJFU84ZL5FkHcHoEaeLGRwcwm6
 R6zJwsKwqUXQyzxDDCVS6tlR+t+gpGAoKuqp8rzw0Iko+bbNv3lW5gT/jestIuPi0dj/X6hRt4G
 bGandQStU++VfoEdsuj7//etDkv7l0ymEIKwFO084RCt//MqtgCWD/EJ9FahutntTE2XpMk/y46
 06hjt1fBUrA3nT9EOA9T9BSRNn48b8MA0A6Dvpvg7ld9usfdeFQ4tQ46o6hynpmjf+bPz4z036c
 02aznoHlIFLoAYw1JCwLIq999ZDjSuozUNDs3k1Ba/TS8MEFor2Im9TjxM3jnU
X-Received: by 2002:a05:6000:1212:b0:47d:fc23:abe8 with SMTP id
 ffacd0b85a97d-4816079b5camr8667132f8f.28.1786728854523; 
 Fri, 14 Aug 2026 10:34:14 -0700 (PDT)
Received: from localhost ([5.83.201.220]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f219d3dsm10046899f8f.14.2026.08.14.10.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:34:14 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] drm/amd/display: Fix spelling mistakes "optmization
 and "resul"
Date: Fri, 14 Aug 2026 18:32:19 +0100
Message-ID: <20260814173219.1102435-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are spelling mistakes in a DML_ASSERT_MSG message. Fix them

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

---
V2: Fix resul too, Kudos to Rolf Reintjes for spotting that
---
 .../drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
index ab9cadaf5a60..79ec5838c26f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
@@ -123,7 +123,7 @@ static enum dml2_status dml2_top_perform_stage_optimization(struct dml2_instance
 	DML_ASSERT_MSG(worksheet->validation_result.is_mode_support_valid
 			&& worksheet->validation_result.is_mcache_allocation_valid
 			&& worksheet->validation_result.is_prefetch_valid,
-			"worksheet must be valid on exit independent from optmization resul!\n");
+			"worksheet must be valid on exit independent from optimization result!\n");
 //	DML_ASSERT_MSG(iteration <= MAX_OPTIMIZATION_ITERATIONS,
 //			"exceeds max optimization iterations!\n"
 //			"\t is_permissible_found = %s\n"
-- 
2.55.0

