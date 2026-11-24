Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03DF606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LfrnIVIQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D0E10F67C;
	Tue, 24 Nov 2026 14:19:25 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5686B10F685
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:19:15 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so2965560f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795529954; x=1796134754; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FMjmA3g58cbdRJH+TuZR8yvx5Ws9bbqbRFbDnHsAmms=;
 b=LfrnIVIQiKStWUeSbdso0cGhqBAqIWirrsBVFJkrMQSx135lkuOvc/i6pbm/Lez/Ko
 Bdr6DiD3JZ/WjZqLZsWaiXUduxunx/Nv2D+G44+EslIlYeAar7B6vhpvXH9WIDOG3LYN
 LiiYzIkc1xRexT1XgW/EuLSgzS82NMa7BoC9G+YpHgtEs6+eRZC1zH2rmvZ7WH6kLEYB
 S10AlB4RVRUJ41yyiTI7PkCa0DXvjAyKNbZ7+khbpGXXSqOcAT5CGi40ocvGvnOU9jOX
 S11gIEcIXmcFRrQxYX4h9ryOZ0Llj4e1Coz7ps5eFF3Khu5Jbz0rPg6u4OrFU3vCQaTg
 GydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795529954; x=1796134754;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FMjmA3g58cbdRJH+TuZR8yvx5Ws9bbqbRFbDnHsAmms=;
 b=KMVcXDIa21D3OajvcUpZkpN6eOJ5h3VvGYibxPLoHnAF8bDdmHbuNSA/1QtIIKEQ5i
 ZLGPj0UnE1YmXZQH5zN0d2y4g2mmHJawKTIzf91m4i0Tt4TO8RTOfACbdk56ySdOXUp7
 tHvWv1bD2YshWCU+4Elpd9FlCImmLFgvNjtw6W8S0bRzVUAT/GCE5ctIGEVDQG6t0tHh
 ckR/W0Pp7X570LBilzSm929jRYbbFdDdxVte9XhpE+VzhATFx4qf/6cCJ6NIVTkNt7wx
 a3vugv32eGfeGiCw5RN35dJvnRV9x5jJhr+krkMsfSIDyFDkowukrCy5lh97FYqAtQAF
 vU/w==
X-Forwarded-Encrypted: i=1;
 AL+hErH2GjuPHy6cfNhZGWaACNHs7Fke962FfUoLA2J54APAmxOUIW6NXeKfsvzWAB+K63KVtJBqUQGW9vU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z93FnzPD9E9WttPdfnL1g9bzKsgo0lqPaClnqzS7gpn+MnXz1q4
 KiMphGeVLnF6h3uFkR9tdsZpHzbVHDEY2eA0p3efI/aBhmsQKYlxESMo
X-Gm-Gg: AZFdTZdvPbxcKhm/vJt7TpSIH4KE1j7L5Q4Jyft3No+PeQV9XEPEhO77RKBoEMOmZHL
 6Kin3TD6A2IEls2pJrZd6KwXEGr9Wujmu8JPTVPfgFGKx2v5hP4hS1mMW4+h6Htymevp3roWKiq
 UklQmxx1ZPCs8eaSWSNZUCaf35XmoFPfsxqS3GXsTyikwiWhBz8Xt1fLv8haCtgWCEaz6y5u82/
 VzdW0AQkp4kOCeSTXBG2DgoawHObtwC8OUf64z6MadynOI/Kg9vWTOXmg+nNAlofXDufN37BjGF
 IyPK6ZyqDbJg8LGSM4T3x/B9berBSbKzC0K+LZF20HCGWFlQ53edrxF9pSSAg8AnloqWPObGuJV
 9FNiY9Wq0O7LAfnhLYtACmOF2ynrbScnZFDYUVIGV1nz7XjDSEgG0VT5PxykvOeB4dUIez4p67g
 ChHy5WcnihzzgkiHnHQ/KnHUQXGpQuG4hwG3lxE90j3nVVhxGEYXz99+et1i22wrASuUdHMX0BO
 K9LxmnsDl4SQfPoBJm0M4EN4qN+K7u/kycsKI4EnHBCwu9DvLn28SWErvooCWe5orgfbsJUiIb8
 MNTopo0jvrNCidcSTru3SqzUeSaZpXcaCIlG6yRr/H7u6mTGr5iz6qU6
X-Received: by 2002:a05:6000:200e:b0:4aa:76ce:4b9f with SMTP id
 ffacd0b85a97d-4abb6746af3mr29201059f8f.56.1795529953487; 
 Tue, 24 Nov 2026 06:19:13 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d60sm28994719f8f.3.2026.11.24.06.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:19:13 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] drm/panel: simple: Keep the enable GPIO as left by
 the bootloader
Date: Tue, 24 Nov 2026 15:19:08 +0100
Message-Id: <20261124141908.443764-3-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261124141908.443764-1-maximpedraza@gmail.com>
References: <20261124141908.443764-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The enable GPIO is requested as output low at probe, which turns the
panel off and blanks a splash screen the bootloader left on it, even
when the display state is read out and kept.

Request it with GPIOD_ASIS instead, and set it as output when the panel
is powered up, since it may still be an input if the bootloader didn't
touch it.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 33d954f3ee28..d9e74d778575 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -336,7 +336,7 @@ static int panel_simple_resume(struct device *dev)
 		return err;
 	}
 
-	gpiod_set_value_cansleep(p->enable_gpio, 1);
+	gpiod_direction_output(p->enable_gpio, 1);
 
 	if (p->desc->delay.prepare)
 		msleep(p->desc->delay.prepare);
@@ -682,7 +682,7 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
 		return ERR_CAST(panel->supply);
 
 	panel->enable_gpio = devm_gpiod_get_optional(dev, "enable",
-						     GPIOD_OUT_LOW);
+						     GPIOD_ASIS);
 	if (IS_ERR(panel->enable_gpio))
 		return dev_err_cast_probe(dev, panel->enable_gpio,
 					  "failed to request GPIO\n");
-- 
2.39.5

