Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5F606A32F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EJqoa5Kx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7898C10F16C;
	Mon, 16 Nov 2026 13:27:37 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 588C910E799
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:27:19 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so9331615e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794835638; x=1795440438; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O6r/oWNBOG36lWqoLzVVjpOTVHNbWXetI9wfOlj3IbA=;
 b=EJqoa5KxFPAR0wHmcDNd4on1WiHxMFVP2RZPtO4Rc5lT0ryrxQ/ZBa/Jl5lQbFGDz1
 c0LKYYLLtLyh349KXw6Vzz3IM6zNwXgDGDfkyULYN/8q1bscp7D30wxDHsFa4saZ9lsa
 HLDubCDNHUbal5bM8TAnXC/Aa2KRva5WRXfMHmuW9MOWUM8im484MWwl15A3LW8wg99a
 UAPglzxeCK/tCb3LMwDka6y4xI41/NirJGEZUzp0ecEyzdJlfdpUBQz7rInkl7S1HR77
 RickLPJwxNBFzJwhMaYauJokh+KV4kp1UV1KxtCoo+AkvDbIUPiCFvd1iaHeb2IuUAYx
 yp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835638; x=1795440438;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O6r/oWNBOG36lWqoLzVVjpOTVHNbWXetI9wfOlj3IbA=;
 b=wORbekjpHfWAY04d+U9Vub3URkkIQaAgyrjbjukxyUdbJPBFPV1Vl/u0WRwuIDcE31
 q1YSwJwnCaCaUTmP071vOwaeD9xhed4b+323Drukr5RLaendThAQQ28OtnFesHFYViW1
 waOM+3CT1KuI385x1UxRgp3kiTHzDxyRpwZuxkSXiuuywcjJpvu56/juWilQGkEJLqbX
 MHauQjWSI56DrkIRdEVRZPFs/ro+7k3Rq6mgPeZvVYo/pUydIW6c4ik/cQiRyPWdoOsS
 uJ/YpNGYYOUd4fvyrgA8xxdZbqv9HzpOU0LQPdlOuZzEBJgBbvS1yoRgc9oHD2lonbwE
 lntA==
X-Forwarded-Encrypted: i=1;
 AL+hErECxZCzxN9EqAWzMkk/hpm8+B3p1k2T0WuQycq50BacwRSwc3GV2/ujbnPsjF18tsSg6N0OAx0dQs8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9OCbD4RIE21xTfZkaSKHpmo7AJd4uTJNa4yyp96FI6dbg+XLNX
 zg5zfZ6Ky2qLbDjn8CrWlfBqSrwpFJ1YohwKYQg2VSE5DWEVgnnZfbGw
X-Gm-Gg: AYBFou3Yq0bpFSf9rvW9QWfpI8rxuYy4HlzoJld3/N87tLBHHNZI4gbj93M/sC22CfP
 LOcA9m/JySOL5PMssJq52PkYd8a+C/ai9xChZvyGuZoFqUV/1zRtnDeE3WvW+L7+5xm2091zJwu
 MYYBropPDcX4LD0WHUHRBrsiC0kWzP9VY0qZsp4SyLtiqj5HkwDR8EiPr8Ck93rLHwj0K0+bUl6
 kZFAbO+dcvkbE0G1uhazvsJrcXi+BeS4lPLLWpOmtTe2WnoBh11Fo8Y81PE5ejXF1cdVJAAROzu
 xK8CgdxV8TbQDCRrCZnI+GSQNDu9gEKlc4+np09VDCeVEowH9dC1t6K3G2FZzymITHeSgb/vV/F
 NJvrFeuJu1ZdD4I+spFM/DoB4wjh2M6SegCL8aZWLNKKWWqHcetpjpolgKS55ELRj4qYrW0yXoz
 ov7aaM3KSUnrr/nK5SldcFZhERelX6UbXyK6JFcNlchkjhZGjK6mg1ckNs0oZHoXQ8xxUVHQObv
 i+od4j5RDZnkPG7t6pfYcSF28OjiulyuwxALjW7t7yx+q0EnFjFrBmhw9vuOC+73fTvu3swQfXb
 jnCSSJFlAImR7xGcpcR3x0H/Th4UoSY7WH+OPJIS3CvzU7vrjuswN76NRiwtH6aWEWLMY8svI0o
 m
X-Received: by 2002:a05:600c:8905:b0:4a3:5a98:c279 with SMTP id
 5b1f17b1804b1-4bb55a57c66mr151263305e9.8.1794835637587; 
 Mon, 16 Nov 2026 05:27:17 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm40370240f8f.7.2026.11.16.05.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:27:17 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] drm/panel: simple: Keep the enable GPIO as left by
 the bootloader
Date: Mon, 16 Nov 2026 15:27:07 +0100
Message-Id: <20261116142707.1299360-5-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116142707.1299360-1-maximpedraza@gmail.com>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
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
index a944c34642dc..9d2aa4d16f97 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -341,7 +341,7 @@ static int panel_simple_resume(struct device *dev)
 		return err;
 	}
 
-	gpiod_set_value_cansleep(p->enable_gpio, 1);
+	gpiod_direction_output(p->enable_gpio, 1);
 
 	if (p->desc->delay.prepare)
 		msleep(p->desc->delay.prepare);
@@ -688,7 +688,7 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
 		return ERR_CAST(panel->supply);
 
 	panel->enable_gpio = devm_gpiod_get_optional(dev, "enable",
-						     GPIOD_OUT_LOW);
+						     GPIOD_ASIS);
 	if (IS_ERR(panel->enable_gpio))
 		return dev_err_cast_probe(dev, panel->enable_gpio,
 					  "failed to request GPIO\n");
-- 
2.39.5

