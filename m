Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9778606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=OvOg4Ui6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ADFC10F9A6;
	Wed, 11 Nov 2026 08:50:05 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF1210F99A
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:49:59 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so21589075e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794386997; x=1794991797;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XGjaUCUyroQZIq89TXjBp9/oGz8PABPtNLqz5N0kwPI=;
 b=OvOg4Ui6w75lh3y9B8RgI42tdvhqg2fmRYyZFhvYnNoge89PVVNExhYJr+E5UGbQwL
 o/8tkxtJYwrEZpIEKXk6BygbXz+nY/dJH6J28Sczkc/RQhKwU7Rl/ydS3nU26QAklykM
 8I8IJ6tIzME80nq5z7+0OyhZSaLXPTU4msXyJZPczYS9+1dOLyps54OgoxOfW2lcV0l5
 qZsi0G8gC826cjV1B1Xj2LL09QZOJKSBpvYnLU7sIskJeCBF8ASWsZZhbun0aCXldvD3
 NNsDUu0gu4wEuAJxD/aI4ymyYTyGxvRiQonlGiY5n0B+W7/uvfAkcjTIwZYJ+rK1Aec1
 4HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794386997; x=1794991797;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XGjaUCUyroQZIq89TXjBp9/oGz8PABPtNLqz5N0kwPI=;
 b=apHlx15esrHZBm2kd1xia0BCZ7mhMotLv4XDjb8PJ7GCFsFUR2A4T2xVY2iGuv3vQS
 YemfPLejQHntrtCSeT/hxgqOgtnroZ8vx1K4yvK80jJqkiJ5PwUYRphP23N6dPGtp9BH
 giZX8MsfvlGK0laXlQ+d/xIRzlInxRQx7gm4XH/FjBfLw2kmL45C/xa7EtKCuGnpOUke
 lo3X7iJync0uI10fe/k0zbVnjzKbwNA7YQHmszVbb+h0ewIV/9/rKzUl/oDXaZa5tOCB
 0d8qKkgoAmSMuktVvsQmOUS0B1jMGgdSrM0OI6yhxtr9ZpPRSU5ydiLyrd5ik3gx1SUq
 95vQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFRQ+H0r+GWWzq1VFfZv2waCahcDC6o29Tq8nuV6KzLAzIdb3obApUFTP9++ofvfynkpJckmLuY1fg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/EpbvW0QKO8hNi1ceGOIuieua31IfgyitwYzidDmv5YfuQX7O0
 7Iy/NTjZduRTMDoiiVekYP/3eqJhS6qlW28aYybDJocjMk2J0JEbCLcHxXRu95P9Pkw=
X-Gm-Gg: AYBFou3RtC4cEYEBv4U0+WWmAj8tJZa7rEiyELk2wdZ5qGVVUws0U4L148+CAsIkmpO
 ZdZ08UuVO2qU4oGUATncXAYMM5Bl00GZADjPGsJ5RyLThYaicLUuthSQ+aUqSbaqlDjVhIXFcru
 uGFk/bUFjcDorAGZ6GqybVTz0USEwmjteWseQt3XBQU8cWeTm7S/MAqSCAEYe50cFnPomq7lKfv
 yJklRIz2s1zRzoFieenN5q6+0TqrFpLpog+9T+9Jr5xJ5BukKINpNOgNB+P3FcqDQceba2Q4lq5
 shufZKzlHXVW7m/ruxroAjTruBefWXdMEqnT/EJy94Sbqmw4bXLZn1aPA8PQm3+SsYAOMb3AFwZ
 LfACKFAuxGJCffaRrpBzrZAfyXSJDnNLr1hZJn1MZl8ze8GbSzi0P9FEoxT9K8Q4aHODiOX5s4R
 8k/0ynDphqhxI0Vhc4lj8YR5EPDIMGRgmRO17Q6JmYJgmh1ynIOyLlk/X5CQfEq3bqwtMn84qav
 RAVZxgMUq7D7G1q2EPHNkjBrxx5s+eHF00kUAUavgYWKzoW3o9gT0bT4Fsk84AxbVQQZ2YWxBxj
 rbzWB/qGRmSEPkabMs9gQxC4nIK45wFPStA3GlRgkNMFwEYOzUbQ4ls5KLr88N4G784c237nrm+
 21QJTOzIhL0nKeQ==
X-Received: by 2002:a05:600c:83cf:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4ba0935d26emr28180515e9.5.1794386997367; 
 Wed, 11 Nov 2026 00:49:57 -0800 (PST)
Received: from localhost
 (p200300f65f19a90460510dd506fc51af.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:6051:dd5:6fc:51af])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4ba01fba476sm148718735e9.2.2026.11.11.00.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:49:56 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, nouveau@lists.freedesktop.org
Subject: [PATCH v3 0/2] drm: Use named initializers for arrays of
 i2c_device_data
Date: Wed, 11 Nov 2026 09:49:43 +0100
Message-ID: <cover.1794386771.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=793;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=4OKhZI7WlJ4g3SpBA2Ic0Zi5wRtesQaQ5X9mG3JF1mo=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq9CwqsDjTjvevC4e6nqty+iMT5kBDx/7rhbFyw
 dX0vM5YifiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCavQsKgAKCRCPgPtYfRL+
 TndLB/9XYRxFcRT5EeOK0C8h0ylgXzyp4HwyoRcTzvGkjbbhSRaKbbjv3XKo5beiM9yhF5iYMPY
 v61j3vOV/ikOH+pqF9jZpbWuZL+cavvkeZkT/1wRXkr10Dp64jBs8fp91loD3e4KaKWAm+a0DgX
 LXV5eq4mLtURTcM/4oteHsE//tDQi0O6a/r87LJO+S+6fzesH4CWf+JuHkkAUQ5r3MY8HK6wZau
 BULo2/W2NXGVKnYTopIWeNIeCItEMQYA6waNFgzuFq0a+m5UObpapu9aJI6MZmFtgk9utk0tA6G
 1Osj6Y3KIfM8Q3k3WyPw3eoWLLYg/h5lLuKogol8RjstG9vq
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

v2 is available at
https://lore.kernel.org/cover.1784545092.git.u.kleine-koenig@baylibre.com.
The first patch of the v2 series was applied, so this is a resend of the
two remaining patches with the collected tags added and (trivially)
rebased to v7.4-rc1.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (2):
  drm/sitronix/st7571-i2c: Drop unused assignment of i2c_device_id
    driver data
  drm/nouveau: Use named initializers for i2c_device_id arrays

 drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c | 2 +-
 drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c | 2 +-
 drivers/gpu/drm/sitronix/st7571-i2c.c             | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.rc1

