Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3046C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D3D10E8A3;
	Mon, 20 Jul 2026 11:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="gOcpCDff";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE26F10E8B5
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:26:09 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso11604635e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784546768; x=1785151568;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yj0kJxzJSZM6leFPQr41NPOQEAzzRxTMU/d+FHoaNn0=;
 b=gOcpCDff1FkBsxq6tQLGEJnpfYpAE4efRwLAeXa2ExqSXOiV6H1ssek4uxtLZ8e/1U
 B2xP6jcDoBrBYj65ZzPzn2efviXLuJAsccKFNA5RcrCd0E55vE/JBp15lARnKbo1svMx
 RxmAn9Q8gbUarnDK2OC9l9kmwTXG27qj8MNoK2uiT27vhkkI2WRXj3xpfwp9b7RJT9Mf
 ZAmUBTVxCnhDNqi2QOXbY8K+QF03KnKC45F+xuEej6SnCoRoRe7IPjGfzI0N1eiExZa2
 pUIgn0D4cBg2WOZJzw2Lq01WjrBELDySDbaDhn53+f7t+UYMmbi7TsGb8JMHnt7o7gjF
 ZnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784546768; x=1785151568;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yj0kJxzJSZM6leFPQr41NPOQEAzzRxTMU/d+FHoaNn0=;
 b=HlGKrPGbUGW/ByYUM2Nd/ycUIN9ba7pISwNkI/ahTtPJKzG7AxxOiigmi4NVMAWi34
 o+aEOUSQ/sPZMC9rnZl0NCewpgfeaeVDYnqQbk4hGuOwNaZBAg1K3VK7eJdBpyjTGgT0
 SL3cGgyOJTpEbRGBMtCem+Vb84U6SWWdXKvWGH+f2wY2z6Ie0RpuB5HGKn5OcTM8jbFO
 o/nM8BEBV3ky4Ms3dlkxPRaPlZrZCDUxM1mAdI3XR5G7nzlJC3+rXIHfwYDOvbL6jSfM
 Ad331QdG8gC9yK1CpOQfhxeTTAZwJrarnLl1lev695v6qJ5oQtNUQcvPdFyqmjfvMsAA
 qnhA==
X-Gm-Message-State: AOJu0YyZzUVm6gCr/hzHs4theAh4km6//s3xAYTX/3tKrVSRbd6K2zpM
 6eBUCMWFKsGZwpy96/vmghJzAzwsUKQPz+1GjGepC89XBboR5WsAItdL3KXiksUrl2E=
X-Gm-Gg: AfdE7clSaQvVdM4z7uZofo09XvuUY+9SS5oOxWL+MVIUZgMT+95j2SSF/bhXmcoYf2U
 xY7c2UtWKjqKrv9dl8PHhFjtKzHCQSfC/x2cTEB3zSTizCaf3ipNu13cYgl52XEf9YtrEG26NP4
 k/hz8L4C71iNNsS7jdRw4vKiKnYTOHtQO98tpIGARXwBf3ILIwVgPmlwS+wa1orMLEd6BTRhzKn
 Knu9DEso/HWzSR9dOA7FGglIR+QNY+myIuLqQaM6ZAq/JbZnTWLg50FFsEOPgol6yeBFakicQTx
 n8ErkxJ+V6TN4qgQNwvMHfmqUhmSo+D9kCVIVI03hAB6xfLYGsuf4bjB/dHutbHtAp81o8Edeiu
 UMvAmqUTLla9HyqwZYaKQhfBpok7b2bbgBRMmtlCsfMMuFDL2FVHggVYWbMDTa+T1Ta9OgT3R7h
 HLRnnGwYbxQ3qiOZvmPYycUavRnsyYEoQ3Q0K3eRp2Hjol2AKKUfVbZdqU6rx6XBlpLbr2kiWtX
 Ier
X-Received: by 2002:a05:600c:3b03:b0:493:e52f:6ee1 with SMTP id
 5b1f17b1804b1-4954a38d27bmr130686685e9.0.1784546768031; 
 Mon, 20 Jul 2026 04:26:08 -0700 (PDT)
Received: from localhost
 (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49549a3e56fsm267803265e9.5.2026.07.20.04.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:26:06 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 3/3] drm/nouveau: Use named initializers for i2c_device_id
 arrays
Date: Mon, 20 Jul 2026 13:25:49 +0200
Message-ID: <7d6033270daf9ff409b427897cb8218f9a69048a.1784545092.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1784545092.git.u.kleine-koenig@baylibre.com>
References: <cover.1784545092.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1681;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=aGE1vCQRPqHHuoXxkUDmiLkcQhSQQsTaegC9eIXSikQ=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqXgXCksDjGVj9HqXCVaRdDwGQP8qhkcHNaEqPq
 s8FEfd5KfuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCal4FwgAKCRCPgPtYfRL+
 TsFzB/0QKxyxmhMP/45nRTLxxVTfuBzwoJyIRuZbViNPZZ0+cMrSp0hAUlpFiRL8MnZ3Azw7Apv
 8dekmjP6V9A34O5WlhW6tgupyagrYBZHwJVjegyMoJE4/ZBV7HjKHaIWfsKX13hx2MaQz8CihFX
 xORbie0Tmiyl3MF/LzY+R693IPH/ue/wlQ/0vGQs+CisxUauyRTuTJpWVrHimMduv1N1As8J/ag
 dgBY4u4uCeh9HXX5E2PD9kqlV5Q/YYkuJj3F6yqgDf/ePgo4X1EsTfI/rOBSLrAX3BCT41th0/6
 Ro6o+Cx3HFel5JSfTfs0a3zDkzSogFT4gzgaODqXetRqs0ux
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

Named initializers are better readable and more robust to changes of the
struct definition. This robustness is relevant for a planned change to
struct platform_device_id replacing .driver_data by an anonymous union.
(Though these drivers don't use .driver_data, so this patch isn't
strictly needed, but still good for consistency.)

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
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
2.55.0.11.g153666a7d9bb

