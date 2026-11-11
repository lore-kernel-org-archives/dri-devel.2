Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90A606A327
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QNsb9ozs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BFE910F9AA;
	Wed, 11 Nov 2026 08:50:06 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1A610F99C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:50:00 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso20144305e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794386999; x=1794991799;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DAjH7rhz1z4KSbnwHBvTiPD/Y54KnFcA/42ynmyzXDs=;
 b=QNsb9ozs24hLNiFjxX5EobFHHBVRLKCuUuCmwOMKN84Lp6IZzSpTZR3kbRjtnuWa3G
 rUv2UResy3If2fBNTTxqP/GfBi6WuSFItCl5WQicB8IEVnfxZxXlhht8ho3tyyKtE1yt
 x8il+W3BVjOi8GYzS/If1gqm+o9DPrZG9uUCMbrB0hywujCGiyKkQowYNPLxJ7BoGUlD
 F7KW0gfliJIwdPYbikjz9N/DgNzgq0cBP+3eUmrCr6Wsd9OR8vWfRw+odPjM/iZeOpTw
 3udHjLRPJspXjww+pnmMS9q0KtqJp4sbIdxkv1+wlXiYpEfDsUbGx80rr4l8djcA6Ivg
 AJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794386999; x=1794991799;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DAjH7rhz1z4KSbnwHBvTiPD/Y54KnFcA/42ynmyzXDs=;
 b=iIriEiPyKgOsAbmYPF443CzHk2zyd2zXGo6wKZOev9JRrjIJsz5tOXnk/NEvqSkJ50
 hM2pRO2zZN90jsqy6C7Ic6d7sSsNlTYhf0mmS5Dqcg3o7t4HPEVdavSQ926P7LuOAwVM
 w1/6j9Fe6IZ/BBQKr9pdvNK0izm9bO3ZSbvEc7amAilOcWN7hljK32o3DuC7gXvyTjT0
 9BuIy75XEAh8BSYwFF+OvD86VhVy7tGqxd3g7CbJ6/OdrRnbDsSa6E0EPNMZN/22baHf
 elrER0TVObX4lFCIEizLD9i7KZ+BbZB2tsy597A8wJapSg/wMeYu7fqCd4zlLJZXFrPH
 dY9Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHtSttoK+sHE62J0hXHQfO6wFmJuWVnWgP8AchgLkMaFfHNh9ijw7FXELlBkTlvX0wQVMmNq2XUvZ8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z86QmDS4mo1Gcqnj1TjJOno3R2Tz3E4fZInsvAK0g02nYaZopxD
 uiXkXTedp0U0wXRYr6nOPL5TZz+FuPLTr0l6/bmh29HaCv64aNvRWDXdmBs19DMNSTM=
X-Gm-Gg: AYBFou0h199BfTKTKZyBXBjQTxX5QghZ6NOMxbpTU9JrLKlRCJnl/ECygV1T0UMxpmV
 nEw7OcGLTOifdd9kVhSoWlBNaUhjSWhBgBOlWuoxXHHOB1tQwrgQWxggmkb1uhYTQboDSOu9PJO
 8e8u1TFsvL4lAxmVLEBk3/GCsr5BQCoYMEPR+KFFdSrn72Alzd5bmfLHuWGBfMryW0RcxgMDCyJ
 Ypqzu8xDcq953DZcB+Sa3XnYnzfYmGcvMfTLPjLYKHHPuoqJbMAN/bdO0giz+LLnny4gzkJ7+GH
 W4mpnHQ2y3LO1IQqagSQXA+zYpSLADeQ6uDd5MjWlkf52FGV8bvcnk5Ap6QzmURIockZeOBwBGZ
 2Sc4xfzlle40lysdvY/hNVsH0VTyQQ3qITlQWEB+3WHM6zXhcT/3IldDB6lU9RrInfqP5TJvDY6
 hbhM61cjkfbQqkAoW1WcfzXict96ehBjqKMqokTk+S35V5GsQGEC8gpH/RAkBKp95s0xUGm+kAl
 hVX6Qmzay8IaM8ET1zJkKuM6ty43+Nq0MUmiE2l3+pTFB/TMAU8feZ+4zbx/wM1vQ7Azod6rHQt
 1EjRKxqKoC2eBZc2Pw5B/j/2O2kh5LZetJ03BOdJXe0ky+3ZY2LMG9cih4UsRGPQmI/AUGUITvU
 xKMBucaZGJJvP5g==
X-Received: by 2002:a05:600c:8b31:b0:4a1:dadf:9876 with SMTP id
 5b1f17b1804b1-4ba0938e3aamr26912035e9.23.1794386998742; 
 Wed, 11 Nov 2026 00:49:58 -0800 (PST)
Received: from localhost
 (p200300f65f19a90460510dd506fc51af.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:6051:dd5:6fc:51af])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4ba020485bcsm116471585e9.11.2026.11.11.00.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:49:58 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v3 1/2] drm/sitronix/st7571-i2c: Drop unused assignment of
 i2c_device_id driver data
Date: Wed, 11 Nov 2026 09:49:44 +0100
Message-ID: <f83da708ef041941601961d0016c5313e97f110b.1794386771.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <cover.1794386771.git.u.kleine-koenig@baylibre.com>
References: <cover.1794386771.git.u.kleine-koenig@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=fg2QklYtm/9gXlEzyJ8j9Z7yTECu6swZ3dSAWb+zMrI=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq9CwtlavBHc3+gfrAfS+A5Z9uBMlkdiYKbks+G
 ss6woPjcgGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCavQsLQAKCRCPgPtYfRL+
 TrOdB/0eHbAOSDst1e5C3c/X85agF6KTSm6bDzf2JtV3R+CeVU3Zj/X4KJH6oRSoQCY43Ars6vL
 MBmbW5JvCnJKQqJurY6au0cFhtVJJWFMS1jHFDfLTaam+nsA7PJpu8f+6P9FXRRYG5isRPwYhxt
 RpklF64MRFVxr5/Mo/1JKjHdLf5MH767jHRZNs4P60pjYE/u/BYxKwyyd2gviKX3yZ4g5HSE1vO
 8TWZhgBpNm9Nxwnp5svVP66uN8/5E9I4ZM0ffv4WtC/nPbSjBKoqG3c44Z8AwzGv5OzZdzdTzGr
 Aqq4f0D25zd7Lgd3HpYyGbMGKjQrg7dyx+QmzeLbOiw8z9UP
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.0.rc1

