Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1A606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=j+aYmhUQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50FE410FBAC;
	Wed, 18 Nov 2026 12:08:53 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CB710FB8E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:08:42 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so5926015e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795003721; x=1795608521;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ziv2NlTRI30TM8LVv4R5YtX1fTjU8SYVeoKSZhByl3k=;
 b=j+aYmhUQmfsffXPYWXD44K0feCNtiEZ/9gVyYGhReDCEQQgA/2LLJQvypVNBmoYGY0
 wCB7IRuq4dqs3y7U/s0TEGgGiyghBZLRqZP3I69SVLjmPuigI9Q98M6rZtCqcqjoa8Ed
 YGCt8dXfEooVmlBQNKVeun3ovtd1vE6WG+YmXrsf0UFI5iR2RK1IJOkJn1LRwuFMq3/+
 ZIsuQOlAs5XU9DlFy5YqPUML3kqJbI0wnzpI0XcMekCVHcLyArhX+szQIyMkOtamwCid
 7ecwk0S0+k/sN3k227gtQWI4wSy9LjAFxgEuAsfrN/o7ONRHUKoNRhxoX+z16Wz1h1/b
 BNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003721; x=1795608521;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ziv2NlTRI30TM8LVv4R5YtX1fTjU8SYVeoKSZhByl3k=;
 b=P4EjNkb//h2RykzDQMY5J2nSbc6LRbJw32TWC+dLavpXCBP6gwfHKfM1Rv1qDpst9W
 d5R0iAnZUMrVfmW8pDrg3+y8lPEM3hTKUv1BkZlFmAAUr74xk582/mq1X1UjJkjBsms8
 mfC7Z3OACfd4FcCDOOGMhd4VkMvZVJpYDpNiapXZIw31S/w62+PpL7IkD1QDvI7sj3iT
 xgXjsv4CnmGnW0Fd3X7KuW3PQ1iu+/yYtYaEgv2y4O8REEnuoZ8dFHVx7bR5TJI+zRQK
 z+uMf18EUcRrOhLA3i7SaN0u05IYdAfpPNYQM+n2unV0q9b0/SZlyrB6GxA7dDFzZDGd
 mMnw==
X-Forwarded-Encrypted: i=1;
 AL+hErG6qL2hdtU9xQx4Lsa9roQ+ptcwYUWeQSJ0LYLgbrTIOE8kr4V+zckChyztejKD07ZdubJZ9yPTuT8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8NPSER7AYfUWDjghYDfeYi6QDwYajsOtZJRyfB0fOIQqvDB2va
 ZlPSH1zgY36tOAK8MYjDTtqs7DJwYt3XvcgyTYTsEyJuH3FdAvT4u9L4t/TBvjPUTddxFPt42LD
 P4o7y2FY=
X-Gm-Gg: AYBFou2rHrvCvRM9tHW3pFFOi/PSz+rYQeF49+/Mqolg+JcW1D4lhGQR0bXfUF4bOrq
 9ZJyvUi4W8kvAJRKJBpwWNTrdX+JKD7YG3GrUB5JFnai9yuUHTkVaCVtgiDhrPOpeCufDg7iLUC
 zboDHi1AibBblPQj8H7kYn2ocTENTWfFfgsKzM4hDlYFVU5jn2FInhQT87HEGQCeT0sfD/GHUaX
 zjBgC78rnF+xWxDTflFEJJFqu6CC2O4TM93XQT6yf5cgUQQADeUH7kEW2JOgLB374rYFgGNNISY
 nMWA8RGWNWH70CLYhTCDgBFz6q2iYsirS3WHogaC2qstWQYAUEm+6JgApWabw0HM2VL+38UWg2c
 EYTb0jbYsJiuEY2Pjl/mVkYt+2n5Y3hkU5EKyKXVxJ8mtT9u5NfxML8+ah1bsqZTrqHQyPkvrx/
 sebAOIqU5AS6OyW0lSJ0vnufi6lckAO+Vpnk9ntyihzBTYaQRE0wlkjSsHwpPgTAlpyGRjqdJZH
 P0zAVrwzV4NlOpXcDE65BK+cZ0Vtg1b7ZFWnTkZNON2gvC3Z+i4XcE7xZHzhst9KbTNzcS0yXMy
 6FBqj2cnp642X74jAsGpCb7yzMkIG5cVDY8xhfavEPpXPBU2JK27GI2O3ItuME/ClnTTed+6JCi
 GO9V+zgcIlTAcZHA=
X-Received: by 2002:a05:600c:4fc6:b0:4bb:6823:3d3c with SMTP id
 5b1f17b1804b1-4bb7da26fc7mr46277215e9.20.1795003721097; 
 Wed, 18 Nov 2026 04:08:41 -0800 (PST)
Received: from localhost
 (p200300f65f19a904dea20c2220232395.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:dea2:c22:2023:2395])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb7d2cfce7sm62975535e9.14.2026.11.18.04.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:08:40 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org,
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v1 5/9] drm: Use designated initializers for i2c_device_id
 arrays
Date: Wed, 18 Nov 2026 13:08:12 +0100
Message-ID: <11a5c3e4a62d43f88266b1c90cd5e0664a13ab19.1795002467.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795002467.git.ukleinek@kernel.org>
References: <cover.1795002467.git.ukleinek@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=mDLMtyJGFJJyd8ezKBIhdp20gdAl9VX7cmcNszox8rU=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq/ZUz1dIhyPLZdkKgPQxFgUCg+Lxh0woqC34/q
 8jkLAviwt6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCav2VMwAKCRCPgPtYfRL+
 TocgCACBQk4rf4X6R5KlkmydUmCCOKHlnrm1KXhKhJsPzswKggtDSjB9ylufN3rYaK+BtUUOT3H
 NSUGUT/zhpxV5Q+OLP0IC1C+t+zZTNQE/0wN+eYpoXtxyZGq/MKhx4llu5Zg8qPhtAjnmmooAJ5
 h/EIbxy1CKfXjWJc7y9FdLgbZxXvc3o8jwzCeYHTtr9GjtOEzuR66wHIsGmNLaaXWz84PjDzyXw
 8v2VJ+gbbl1SJ6yMi3K1uMrzaI4RqHLcAIj6hkqNRasgRvofWHCSs60bqVqSzQxjU6sY4QV70YY
 VDzffGGIhIDRy7W0v999Sa+tokPfLwR9zFyI0F/AKUxFHHRU
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

Named initializers are better readable and more robust to changes of the
struct definition. This robustness is relevant for a planned change to
struct i2c_device_id replacing .driver_data by an anonymous union.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c | 2 +-
 drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
index 976ed59a86e4..96dabdb38c4b 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
@@ -486,7 +486,7 @@ static int ch7006_encoder_init(struct i2c_client *client,
 }
 
 static const struct i2c_device_id ch7006_ids[] = {
-	{ "ch7006" },
+	{ .name = "ch7006" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ch7006_ids);
diff --git a/drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c b/drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c
index 7f402b901977..2324507eb5f3 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c
@@ -414,7 +414,7 @@ sil164_encoder_init(struct i2c_client *client,
 }
 
 static const struct i2c_device_id sil164_ids[] = {
-	{ "sil164" },
+	{ .name = "sil164" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sil164_ids);
-- 
2.56.0.rc1

