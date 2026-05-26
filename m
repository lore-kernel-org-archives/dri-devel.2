Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3586BCD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6E210E69A;
	Tue, 26 May 2026 14:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="QHVeLCOF";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D8210E69A
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:18:05 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so6242864f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1779805084; x=1780409884;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcGq1XrISl74r5Iag0hCS2Wz/dm0EE2zh+iieQwt2tE=;
 b=QHVeLCOFZJC6ln/wNnpNWnBFgZyhndpLkra2g6dADJyzUWh2VtNnJ+JCPnnBqY+b8e
 kg+x0QY9CQMaiGlgqPN8d7mz8UdWod7trGL7i5iyjRt/tNErpQ7D7Cg0ZfEvHfTuIhNZ
 zY05fZJD0NU4Ith7mK5RSxmmqqirpQwBaNtIff60jfWdiNLLfXJHXo3ihgPALgWxjRt+
 1b4t6UT+8IvgKZ2QYBvGpgF8efYTPmB5cKVWwu+yGLkZ+B8Kge/e4wF8LQrkmsSwR1PT
 47yvsfAO3hPF7c7nEy/1fiBtVKjCTFFiTIoULSu7/oGZW9qBMd6xCsii6lC66i6+ixb+
 MxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805084; x=1780409884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HcGq1XrISl74r5Iag0hCS2Wz/dm0EE2zh+iieQwt2tE=;
 b=hEECno4xUgGSteC5fHOEjk+W6YG1pR1xNYZjGo9wPV/QTYL6yvHqk8yXbs943H+PDY
 4a/RtqMtkSWSS1zyvQDM5TbXb2GVPuyu0bYpGs/H7939MYKAJRrY/57Bs1hmgr8/6dlN
 wbtd85jlWsMog5muhs18cJo701KE8J0aaD6tEU3lMxj/V3uE642jqaz7nMtIxGvgmZ1t
 vx5rAoyvZ9JRbxqUvydbSR96nrlh23xHOaOFQdq7+H8P+drd+n/AyTzPooQQf9oPoF9W
 x6e/1jETyfKt/CgJN/qBQXVQTDJT7ViqHtnaOy59vyAh/f8spEPY7i9B1GVH3JUdgVn5
 BWhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NOsIx6d24PeE93O7Elpl9I/A6MrO0UqS65ueoOJsHGRxbSk38VWDb/qJyRSDuIo57JtEURkoKiqs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOmSgUyiDcYkbV4Peh6OflGGEu90h13i2X1M3f4/XyiLc4ycaT
 Y+s22Wn+DmInpR4OKO2HZCeSpUgocrJDmdXxY8h8/pNBrCyTdrJyfrWR6tnwXU78LxQ=
X-Gm-Gg: Acq92OHWRknJ9b4afaqdtFyCjEtzjRbulnzVNMlXFyudv8fduwwbe6VQ0voBGZt+Tql
 keUCwAkncpkYK/nG9aK+BGKPaepadr1abRUEeyLtPXXPRcTvvqwoYYAzm7u8+eBDKfKLvDVRnOr
 Ty7UF741Z+7Dust0bMC5MbW7ktJIWOJ1BYGdmpmFQxnuloIu8Qf0sNt3nDrpmi2Ftt5s52uik6f
 yCtAIv9gVyY1W+7iu4sOzlFVehBgxAExdPPRpLyanCzBuZSv6JpkTWzKWseQjvT853YagJQduq4
 5pOAMZ0ed36rxjqr8vDh5wQ46xwjDI3d9FiGJJ94GzcAZAL0bTfn257JEhdWkIMjGekd4YNAoGz
 fRsFUE/x04REI7mUSN63C4YXejIcUa31cuBEQZswp0dqksTsxMB9ZKqFW80nhINcLzqChoCkD7c
 O+YiG4XYsq4IxB5Bid0ACz8IJTu5ypgY2FQlJaQ540zdKxegxA1MZ4MvPq+dZz8498OBZpxuOfo
 tVdaV6OPwrB2Cw=
X-Received: by 2002:a5d:588d:0:b0:43d:a37f:8d5c with SMTP id
 ffacd0b85a97d-45eb36a860amr35484418f8f.17.1779805083801; 
 Tue, 26 May 2026 07:18:03 -0700 (PDT)
Received: from localhost
 (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45eb6cce0a4sm35446032f8f.12.2026.05.26.07.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:18:03 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 5/8] video: fm2fb: Use named initializer for
 zorro_device_id array
Date: Tue, 26 May 2026 16:17:31 +0200
Message-ID: <12911d2a1dfc4e482bbc0a417df73748283d04ee.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=vLYhva7TFPlfvxBS6GmaWUTUrenc6YRKtxASZZ8jZAs=;
 b=owGbwMvMwMXY3/A7olbonx/jabUkhizR1U3u1mK5E3TLryob8TbMXBf7Meys0fYbv3Zb72143
 3vnx1XHTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmIn2Yg2FmQtmKN5sOa66d
 rJ39ZNfE2ot/OA2maOQlfn6hfan1i8Mb4SIfoZq/cUIZGvkL54m+vZ7BXv+uMskjeJbmFLOL0ge
 i121P2PLYp/i5QtlVhXVqG52cctz7l9vnZS38pPBF91FWn9T5+RVBSk62Nu9Dklb/T7DRamzO05
 Ws7ZzWfPdGfHXDwb73Nx04dA3T4rvVFhXvkzGM97/dY/gncmbLuv/qzy+5NTMns0fkBx5iyGj59
 ujvn7LK/lfNL5l53ikZMQTw3+D4s/H93QKxqaUlit7rQ9amBjunr++0kjj7/1d7xiy7L9K+UnEF
 nCeFvxe0nPmySbTYOCDD7DST1Ns1rbkRO5akO9YE8W8DAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

Using named initializers is more explicit and thus easier to parse for a
human.

While touching this array, drop the explicit zero from the list terminator.

This change doesn't introduce changes to the compiled zorro_device_id
array.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/fm2fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/fm2fb.c b/drivers/video/fbdev/fm2fb.c
index 25d2e716edf2..a62c8d86bf69 100644
--- a/drivers/video/fbdev/fm2fb.c
+++ b/drivers/video/fbdev/fm2fb.c
@@ -212,9 +212,9 @@ static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 static int fm2fb_probe(struct zorro_dev *z, const struct zorro_device_id *id);
 
 static const struct zorro_device_id fm2fb_devices[] = {
-	{ ZORRO_PROD_BSC_FRAMEMASTER_II },
-	{ ZORRO_PROD_HELFRICH_RAINBOW_II },
-	{ 0 }
+	{ .id = ZORRO_PROD_BSC_FRAMEMASTER_II },
+	{ .id = ZORRO_PROD_HELFRICH_RAINBOW_II },
+	{ }
 };
 MODULE_DEVICE_TABLE(zorro, fm2fb_devices);
 
-- 
2.47.3

