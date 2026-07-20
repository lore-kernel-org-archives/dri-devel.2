Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4129C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DDD810E8B4;
	Mon, 20 Jul 2026 11:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="RUB5bnBr";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62E710E183
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:26:06 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so17954625e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 04:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784546765; x=1785151565;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZtSu1sg4Mo6FKm7OCMBmlEb51T52Dq/HZQyX8of3xok=;
 b=RUB5bnBri5zqyalFeV6wB5xyBWjcIwYXrZDvccDwjgn2KeKP/5R1iY/QY8OOhvf2Ut
 PWHYvYujUDwGfa4iQZE+z/c3+xvt7ss80L/0xVkhvgQTa9B5pRsiGhYD/lHZVRWo42dL
 zOGUc303QF1gkxdc5d3myQah2egXjJBjfxpQkIHV9V3bLMRyDOg+MDqNFEkKPRYdCfQx
 QJ2+RpFGrKTzL8lMplo+E+1dGvGh7QpzYhj0PeB/MBlKBmxGVpoUn63dDqXBpZO1nBUK
 D5Oj5CIRaULMgZHS4Ll/JhLUrSAi3Tfus9qpwBNw9udf7TBXG76grabp1wF89xYL3hry
 Kl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784546765; x=1785151565;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZtSu1sg4Mo6FKm7OCMBmlEb51T52Dq/HZQyX8of3xok=;
 b=BmFaZWV5nPOsdXaH/x82XHhtDc5aJZdqEEXRakCENPsqKwBpOJsCOKvn1qgLMYizZb
 nEqdDcb2jKYkqPafnWLF4/7m+XYnAvPJt0QD2+dovsEegZS2eOIG22bxE0WkeUhqskMC
 72A80Y2/7rOtjjeH0co88Eb7E4+lVWv7+m6qIILwf9s7h0sWzU04dYI1b8O6WsLLhzYF
 6+SxvusNKMyiWsnyitEZKNu1PPAph8WzTFDPnjAkyd7oZfGQZ6HMWymXmPsN/q+Gdajs
 YCSp/bBVSsH35HJICTrc7Fs4P91GdbnyOlgrwT7Wp5kDHy7hvXV+DqYAxbzWJRJM04Iy
 xCdw==
X-Gm-Message-State: AOJu0YwH1eaLYGvoJMK1vwFcDzIJ0wg1WU7M574dnPBjWEDjAM35pRKJ
 +wU2W3hSpWyNvvZ5wr7hAT9YZAMglUxA6qpOUOAkYDujTYAlKO7Sb3c3GtEEcJjBbSY=
X-Gm-Gg: AfdE7cmsOIho30gW7U9ZR5/0P49bmVhAlXMNTGiiV2ZUDwwRUDDdRi1ilXM2lLKOihL
 GTkXjwppMu4AgcmmVNTb+H9GzD5/ax3jnas/v8vHdoImqjmjgKV1cSR4Van63hIaMh3x/qzu644
 2qpaz19OGzOHdYZNnlrOj5XPD+V8LbWrKqcN4q28lCYCF0W4YKuM166XY4cus+rFM57zbSj/VnV
 0xklg/7CwXTR2zgei4PzpHnBl5qzYzPD0s7feReL7GzBIgYZv8WbUYYze3mv25mbX98/LMnIzgX
 in8we73tXUPzyu4xdaqEd85Qt8wEI1AShlXq5+SZ9P2N4vSumMJUVdl7jmvfuskWmSKUxG1iQOq
 b+6JoExXoRvgStvYZdvhTblIutusBPEJGa6hS0gGCMwDISBdXsWCHx77VN7qcvJzcLdp0f9CHqr
 kDoEVXkM0z2g4n927pJX+mUz+0mCwXRjkbDeTn5bi3HWNFwAQc7H42eOPNI7PI7JAzUg==
X-Received: by 2002:a05:600c:4755:b0:493:c2cc:aecb with SMTP id
 5b1f17b1804b1-4954a51590fmr164725985e9.38.1784546765098; 
 Mon, 20 Jul 2026 04:26:05 -0700 (PDT)
Received: from localhost
 (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4955dfa4a97sm102201175e9.4.2026.07.20.04.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:26:04 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 2/3] drm/sitronix/st7571-i2c: Drop unused assignment of
 i2c_device_id driver data
Date: Mon, 20 Jul 2026 13:25:48 +0200
Message-ID: <03ac0f712b98e9a54f3d4cd3018ed051d033415c.1784545092.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1784545092.git.u.kleine-koenig@baylibre.com>
References: <cover.1784545092.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=AjScIC8386oRvz0uOkzCvg3Rp/hD+fRVIo1CSQBirvw=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqXgXA24Hi5K/n9FyI0M3hVqjnjmax9++Is5pih
 bejRmsdJTiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCal4FwAAKCRCPgPtYfRL+
 Tjz+CACZ1e7AUkKmJjoRhEpDsKvvXwZrbdkBetHXbnPgCqN/FLFpQtLXPt+c4aU+wdzXLinZTRX
 qjLFmsHxX/FEzsfdFadTm/KzUigLtBZxVHtXEHytB+1h3A77hk0mxuyBNEQZJ9ODporGNe0shfZ
 YqIhyMTupg3JDwvkVs/Tb0Vfpm14cami7IEnCkLzX1a4BOaSpAgviQCuvUrPAF+txWbggc3uFLk
 +W4M2j/llK2xMUKUQqA6xkNrId39W3iEcTdzHqp4ntpnLvUjdBQM1ORkrcPyzrtwb6kJKlA5fCi
 lx37vHKo5vTY03lgYdA9zOD1AjhO+XGWzgO+VYz4xX4lrWWv
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

The driver explicitly set the .driver_data member of struct
i2c_device_id to zero without relying on that value. Drop this unused
assignment.

While touching this array use a named initializer for .name.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 44bc94be33d6..be6fbed8adaa 100644
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
2.55.0.11.g153666a7d9bb

