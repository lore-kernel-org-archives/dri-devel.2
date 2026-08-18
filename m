Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D4EC5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D9CE10EA2E;
	Tue, 18 Aug 2026 08:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mn9qXtb+";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C230110E44D
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:06:50 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so35038815e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787040409; x=1787645209; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hDobaOMuKjNNpK+xr0rXVpHpoQTLjSO4XFTBJQNN0Ug=;
 b=mn9qXtb+4PVZljICOJiOWypgR0+cN/qgp8YrSg2hBWLSNmQNBIabmQbG/HKvSKgo46
 493kjltztFgdd+leOC7rVowW+Zsc/jz5I+Dki43g1fUqPUXp/cWayOlCtDNjQ5cHIa1R
 1Q5mViLc41470XW5VAd9KIe6fGA3F2ZPuzHjQpD9CWNU5GdBxQAOb2kJwC6T+CjkwpnE
 yk+mWZn3Q4MjmYYy11Xjhvebs2L7wfdyyQWjkacSgyElpFcQixuQQVAPX/OoUfKcpZkh
 w2wcnQz7eTxDuCmA4Nm3ryl6StxbMW0FkWTCtU10qcoTfxZ94Z9P+M0/ptlSXCh3c3/0
 bBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787040409; x=1787645209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hDobaOMuKjNNpK+xr0rXVpHpoQTLjSO4XFTBJQNN0Ug=;
 b=ZyXcr+aIpWgW3xkFLwl57N2czQgEeBIrDkf5odVabgp+biX6SSla/APkWLnaRVl79p
 7c6ILNhi5l51sJto0VNL3DYQDNOnBpYz83X5OLxllaCcVjtuUk2LCwOCYRM5b/ACr+yJ
 8kgXZqFXoJUHp/ZeJgrAXLpZ4hMPttzT04V0Nhla1weyQIR5TJDrhV4IAJy00MyxV0AK
 mdrCij+3VH8j6yjvNVVK797QsiSwqOJf9Uq8oxu3r7TXyrg4BeBwxnpvt/RN2I2tk9SK
 /pR+GUU1eNHLa9DVCg3bBUBNpwLDqFBnjrkFgckTcaRclORmxVDq4EMaxkK8t5zNSVfK
 3Qcg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqam7PZ/I2uiIv1D9rHeEZ5bTqdTeiNKORBFZGOOco7zzaoYNNrR3XIA0OPokVVvBGR0R3lL4PK3t4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzH0KpMb3gAfOrcnUkNVgQRx8k+OKvX8ZPXhmOyeJYUXqMEDCA
 yiUACXRh+p53faGQb+WZcaQ3mfOxETXXp9fJzDBtkQkf9spUi4ffCVWj
X-Gm-Gg: AR+sD11zq3QvqerhG9anEwvbH0fmTukpAA+iug+YljCmPszZpba34Z6DhQCtdp34cyq
 0t9BUa6VLlZ/qM+Sv/RBjCjUi8YQ0p/16xuvrjosWgKL561Ea9r1VCMSV5EiWoo6T1fS4dHxBq5
 oIbf2GbKIuax9r3RoSB1NvJWWfcrBIvfSD+dNqn/De7SjyltjL6UcMP1fev0ZPhGwkiwQJ4wn9T
 9iDS8sRl/bqaTapkPQF7SEFFbaDA7DPZ7HUjpRyi1poFP4RaUk4KfYz4VSryJq5sYok6V5t+nwc
 mlEMPIn8g5NYiFZGOadh9gDk6f4YaMts2WIuAU7OOh1qtN3P4Ie2x8CVedo0eSoucn50mzW+unx
 mQuxn80pD7G/3OkXWglLPoPjBc3P2tKaENGJkzMMkTIDjGGJ+vemNKSvXXobgpZpQzHPJP14Pwi
 ClrjXO1Av1fejRYEt42emB2V1KGpaPbqdBs7RzU8EIZ06nWt5eSrTrV6DYvhCNwVPK8rSWEPEft
 ZI=
X-Received: by 2002:a05:6000:4a01:b0:47f:7b75:9dfe with SMTP id
 ffacd0b85a97d-482a9109c9bmr10864250f8f.8.1787040409063; 
 Tue, 18 Aug 2026 01:06:49 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b2e9sm10367223f8f.9.2026.08.18.01.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:06:48 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v4 4/6] drm/ssd130x: Replace positional ssd130x_spi_id[]
 initialization with C99
Date: Tue, 18 Aug 2026 11:06:24 +0300
Message-ID: <20260818080626.30430-5-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818080626.30430-1-amit.barzilai22@gmail.com>
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
MIME-Version: 1.0
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

ssd130x_spi_id[] is initialized with positional initializers, which
easily create easy-to-miss bugs when changing the members of the target
struct (struct spi_device_id in this example).

Change this to C99 initializers to guarantee each member is initialized
with the correct value.

Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x-spi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
index b52f5fd592a1..be50e5aa2c87 100644
--- a/drivers/gpu/drm/solomon/ssd130x-spi.c
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -160,17 +160,17 @@ MODULE_DEVICE_TABLE(of, ssd130x_of_match);
  */
 static const struct spi_device_id ssd130x_spi_id[] = {
 	/* ssd130x family */
-	{ "sh1106",  SH1106_ID },
-	{ "ssd1305", SSD1305_ID },
-	{ "ssd1306", SSD1306_ID },
-	{ "ssd1307", SSD1307_ID },
-	{ "ssd1309", SSD1309_ID },
+	{ .name = "sh1106", .driver_data = SH1106_ID },
+	{ .name = "ssd1305", .driver_data = SSD1305_ID },
+	{ .name = "ssd1306", .driver_data = SSD1306_ID },
+	{ .name = "ssd1307", .driver_data = SSD1307_ID },
+	{ .name = "ssd1309", .driver_data = SSD1309_ID },
 	/* ssd132x family */
-	{ "ssd1322", SSD1322_ID },
-	{ "ssd1325", SSD1325_ID },
-	{ "ssd1327", SSD1327_ID },
+	{ .name = "ssd1322", .driver_data = SSD1322_ID },
+	{ .name = "ssd1325", .driver_data = SSD1325_ID },
+	{ .name = "ssd1327", .driver_data = SSD1327_ID },
 	/* ssd133x family */
-	{ "ssd1331", SSD1331_ID },
+	{ .name = "ssd1331", .driver_data = SSD1331_ID },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, ssd130x_spi_id);
-- 
2.55.0

