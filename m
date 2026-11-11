Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903B606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kZ0X45s7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC32110F9AC;
	Wed, 11 Nov 2026 08:50:11 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A140D10F9A3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:50:02 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso1285458f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794387001; x=1794991801;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mcw8tiKH/WX7VEn2tZaWKJlFFwouAMdTGd/w0+U3Fi0=;
 b=kZ0X45s7YZAeveGJ1ijZYfE4YT7gpMqGBSI/VEMMHOKOMexBaTTU1wLdrA/7uE9yRg
 6bZ94oupjRtpxrfdG7hBSmMAZaiLk+Az9SAOubFOJXeKHoudqiM3DRl8GzK3NGTzCUYq
 1TL1iw0BSwZy8Am9fGwUcv2J+SNaBclD+5ZUtkW+/vmxtb7ub3AusDb2vmck4s6QXgms
 7stPwpjWXP4uo1wdbPkuZTuBDSQo/mUV4G0eq14yijWyKp5aLMWg+AVw1WwJSQiSXZuS
 B4o3JuNC8MLDcHQIj79tMm7ZC0LbVGrtX41A0HlkLlHN56OGAegSlcO2V0H294MlB+U+
 M0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794387001; x=1794991801;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mcw8tiKH/WX7VEn2tZaWKJlFFwouAMdTGd/w0+U3Fi0=;
 b=R4Ivs2NqkgApWLMvy7TP/Qa2F103hr6Rua4cgl5l3t/dqfE7Cp+/0Tvqu3k2Ty3T0o
 ixqWPcN+cpiTqcyHZb2kzraihcPnE2Anm1sNS3i6k5rgIksKIwSak584HTYamkIKL5vJ
 +z5BYKgT2SChR7N3bu08/dpJPqPqmnrJhjZZAZgbdqMJwF7HpVYNqor6kOLLBSpPc4Fm
 dTCTN4ZKb+vcsIww39f/7SaeV2gDs3BIrQ9XFq/i3rfbR5Rs8ORqAeIApmwCoevOo1U2
 y3gINLztxAJcH4lO4uAyCAfnS99/EmWyuycJ35bMNoTpziVC6pgdA0iCpXkKpDPlUoH8
 WUSw==
X-Forwarded-Encrypted: i=1;
 AL+hErG/w7M2vydZEuxgoALHOD0eH/kitoMntjck5M5uuB74Weft3c6GSwAGZ83GCigiH7Xl0vlto/Gv+e4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/FD92sYbFm1cTSe44klDkWMQJOSq+hibSCCPqpPg4+9b1vTJEw
 +blYM46783VRQGPvK6YqByftZEvLEIllzcqkbE/qcG6SFrxXPtyZQ5Lk15XMf0SEiQL8CH4y98O
 f5j4VZEg=
X-Gm-Gg: AYBFou3F3cu4DNa484sL6SUuX1lZfTCIBcJmi9pnvB8wG4OhZCOH7iqCyxrBg+rgktp
 uEb7rQtqj9SBEZNIUKWSS3RpSW9sDk/1GqUgK1Cc/zpCJnrGqnAn6qmmfEqWLGgSiXkpTDJueR4
 DCHCuflMf+L6k5hOidYn8TuL1CFxyZD2kueTMnsuWTAGifEEobu4kFBHs0n0JlYqghaFwR5jVFN
 6fG4dukqIJx6lKyI2xSslRHx+bRI4GjrDudZzySFuj5lNWkrnKyJIbmu99soPA0ibFjUbK8m2/z
 gEvtt6Z0hsyRE45qmtunLf46HxocJIK6wu2679CmptzQoJXAH09Y6CeEa7NdjhFpMDQfQr+vQ1r
 i72K1FjvpG8dP9Uv0Dn3AMzYURNL2k//XtYANhrYHQ650c8HDZ8nR0wOWaRk28pPI8yoj1jqBM5
 rksLcJsXrmy1qepweIFe0YZMdc3BnqLyrhFyKZqiVhlZ4gp3zpHVdy8k3cXh3fSxIh/AQ8ps58e
 B/9wGxTIbsENGKmBqLCcYADn32pa15oTnOFAp1yS9pNPrLdx/GYMcfgEFLdMTgh6DPADbRNDoIq
 6Bcfj5sUV04NjUyQg35VovmMdP07VzlkVjmpQo8gSlkVCJosEVxvGmVs5UApzJXdEdcSDD8ffUY
 +ackSG75LBc37Ng==
X-Received: by 2002:a05:600c:1d28:b0:4a1:e6c8:ff74 with SMTP id
 5b1f17b1804b1-4ba0939db75mr30427005e9.29.1794387001054; 
 Wed, 11 Nov 2026 00:50:01 -0800 (PST)
Received: from localhost
 (p200300f65f19a90460510dd506fc51af.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:6051:dd5:6fc:51af])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4ba01ff3428sm142236795e9.15.2026.11.11.00.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:50:00 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] drm/nouveau: Use named initializers for i2c_device_id
 arrays
Date: Wed, 11 Nov 2026 09:49:45 +0100
Message-ID: <3dd75434da3c0e4b5ade3b802b4ab00a404e8bba.1794386771.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <cover.1794386771.git.u.kleine-koenig@baylibre.com>
References: <cover.1794386771.git.u.kleine-koenig@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=L8VndumebZ2MRoqro0RnaUijRD3vijSdtnwN+w0pZyc=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq9Cwv5LPQnzIxzz7hUpMPuIVPQccUHI3t5AUhf
 LUDPxo2ybGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCavQsLwAKCRCPgPtYfRL+
 Tkl9B/4tAll/ivGhonm0x9hqXABDz27C1LzXwKQ99PbJYQrZBYY+O5PpHY1m1fFVrWzFGedo6Yk
 vDO7Up0laCDvG4i2E38rwthFyFcoYsodI0MyYiHrxekWaiOO3klqdFkhUdwZq5f2MDuibrXoIf8
 AeP0wNKhbojgXXe3ZP9MB6HugJr+1doDFSrs1wRPHewnh6pZoyww2mhXKwWyTXgv43vvRj8rEHz
 cWyarlxT7ZQT8MaLjkYzS/F68BnIcYoUaKiTJazI1g6s4G3su8PDhFAP5h4tndnxvLJ/OjOmYhZ
 kH+cA4S+D7FFwqJTuWKVmNQChQwkbcuI86iBs5x5T8BIyn2Z
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
struct platform_device_id replacing .driver_data by an anonymous union.
(Though these drivers don't use .driver_data, so this patch isn't
strictly needed, but still good for consistency.)

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
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
2.56.0.rc1

