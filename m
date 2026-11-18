Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED29606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ip/wTSgx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D1D10FBA4;
	Wed, 18 Nov 2026 12:09:01 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF32310FB9E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:08:38 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so13458375e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795003717; x=1795608517;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nd8iVSzCMPFKuyJXWKCFFPvwVs+jInJ4ROa0Pp5xvE0=;
 b=ip/wTSgxBMPQ6afFAqMXsa4xO//MEyTJ3z0NRs/zeQYe3qw0I9Li/4EdnRMKFS13xl
 b1DmwQzLeO8rgFfHafEdJgRTFZi2dEVfZfQ2qjUJi0se+8uCfYOCua7qLkd12MeyxdES
 W+EHntRfrNWaI+mhfeJlfyQU89kMhSzei/s1+i/ZZC4K0Za5kDIG2j9jhzvCChxJmDDa
 hpoORc4oRb8QlxklBHisqkZif67C8sd9/0HCeHvtVqdOpyAp9apA2itXShToCj+LVD+i
 s+HfLKcNixB2RDAjNLCJ/FzbS2EGhZMxFEeEtXrNWqVkb9iAQSYwsee+Qm92msHhPLuf
 zvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003717; x=1795608517;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nd8iVSzCMPFKuyJXWKCFFPvwVs+jInJ4ROa0Pp5xvE0=;
 b=ef4azeSS/V9Oab1E7QpgzjZra0vAzDhpXTQF63+VCgAgGNwCLO2Ch5nDAkH/5q+ahk
 T4xo6WaNtI/N0eOFlE+KprxgQTytnJ97Mgby28d5zctY63B9aTvSIAwsjjaK6dyGM0kk
 LfuVfcKamkgHuo+2eceR98KoCYgNHYXc/LmrElbpMkMJsxd9JD4Pqn/5lKVQvk/MObeT
 m9fWpesYLUrXQnvOkxjSUIclPAxAn/NhN3vOZZeIk+m/pjxifmuXQLGsBu590b4YmrjY
 Lnm1Y7rm0qAYBfEsm+uz1SBHOlW/DmVPGXEo9gyRch1U8KfQ/2eJcz1ZjZV36j3Rv3h1
 oPoQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG2CyW47frjJwYM1SZP0LIeoXbVnPTMoovAxfwj7y2am3m+kaEFpH6jlpDu2Swsnpz2cJR92cZ1cQY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+8264Y+C9gSvp/1mPEBn+VasJtdNiER0OKAeltGYL3fqgkR15c
 2xxUjn20vtnQmVWjq0W7OVL7RtjfpgsYnHwYSuTS0RrfKmULnVk/jwrBI/AEyQt/96tvlpfonlU
 QCRKUx+Q=
X-Gm-Gg: AYBFou0viZ8+L+OQqypAIDvr/f4t/awusI6CoAHaZOhqkgNcaacUtTxt6p5SLipdmNR
 RLFzfHRlMBSK492x9TtkiBWiLs5qjjjvX/JDri674hK6p3RYTK3K5Fa4rXCSSkbISoMEAK4Uko+
 5O1Wkdl+FhfGOMeMgN9NMbtdJFLmhtx5eu/DrLptWyw23vIj2Jt8XKp2s4pUwZx1cjn8w0PoQ7Z
 BaJXq8iZD8rIlSh7cSzd74OCIsrK6Num4F3aki08Qsv8Oc08PcCGMtkAtiOQzyZagjS32lOTSyT
 LWfXswa49DwXKjFp3mP43W/iEMXEwnrODlHtuF6QXXc44LVxKNSG4WGrOXbaJxt9ulWCr1OQJE7
 Kw2cqtK/A2Fmf26oF8m5tDHwFVdvCZFoQIDrLAbCEXCqIZvZfi3qCUX9X9SETEoQFNjIBNyeock
 W7Skt/jlI6hzlZhLZ2lgyJY6F3V/edbGn6X6ifJOLM4HLI4K9OFltXp0HKBThoC0ie/kM3vIg/i
 Mg10ViUd06tQXacGhtxm1onp4CnuyGjTIDkzHvoeTcDHQ6lfrLgEEMl+ucbtgl2ljlA5lCkcxtH
 adDfw1BJuOUCuhUI4u+3MElAq9/OS5aA/OWsJDCLP+tc27HiAbF1Aa4BYe6yAUQtkonRreWV0qz
 VhGuWH4Hu4NklbLM=
X-Received: by 2002:a05:600c:6b16:b0:4bb:6816:127c with SMTP id
 5b1f17b1804b1-4bb783cb70emr90966955e9.8.1795003717355; 
 Wed, 18 Nov 2026 04:08:37 -0800 (PST)
Received: from localhost
 (p200300f65f19a904dea20c2220232395.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:dea2:c22:2023:2395])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4a656095e98sm4115924f8f.42.2026.11.18.04.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:08:36 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v1 2/9] drm/sitronix/st7571-i2c: Drop unused assignment of
 i2c_device_id driver data
Date: Wed, 18 Nov 2026 13:08:09 +0100
Message-ID: <c5d986e89b515d6230c01defea528e92b56a0892.1795002467.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795002467.git.ukleinek@kernel.org>
References: <cover.1795002467.git.ukleinek@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=947;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=mCZcbE2UHgPbrGBqE3nz1qX9Pv5BppiEZVdyZ9HS8wo=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq/ZUsLmhUcaQRJ+kM4Yok/KXL5lc9z78YFVvDX
 8uidHNUNVCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCav2VLAAKCRCPgPtYfRL+
 TlOXB/9Al2IzlmIbGq11J50fUtOEjGDQcHPP4d+Z+r5qNtXl+FRUmhKgJT9GLsfFNBq/xHiHPf/
 /yiQ5nVJ98NPcqX/HSAxI3qNav+Wr5n/MZgDhW5Pos9qwQyQ3OKMr9IzMRyzKRfcanK26ccHtb/
 Rrqz8eqQVyO3z01NzqLTRZs/egJf+jTgtkapw/55X7oIFUsGRRQrvNn040+7099/deJXzEDyo+r
 IgIyFbQHkzxw64YOCoRTURr3J6mJSbckw0bX6L4l8w/sO0fJ4FPeoz/j18PwvPcLQxIYSy+DyBR
 pwjMvFOa8iDBsFVlCEbjZPxix0D8ITRaTgRHjiEmkvP0WSC4
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The driver explicitly sets the .driver_data member of struct
i2c_device_id to zero without relying on that value. Drop this unused
assignment. While touching that array also use a designated initializer
for .name.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index c96490b6e499..e66eaa059439 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -134,8 +134,8 @@ static const struct of_device_id st7571_of_match[] = {
 MODULE_DEVICE_TABLE(of, st7571_of_match);
 
 static const struct i2c_device_id st7571_id[] = {
-	{ "st7567", 0 },
-	{ "st7571", 0 },
+	{ .name = "st7567" },
+	{ .name = "st7571" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st7571_id);
-- 
2.56.0.rc1

