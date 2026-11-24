Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650FB606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=e2s8XPoV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1474510F505;
	Tue, 24 Nov 2026 11:54:56 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FD810F504
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
 Reply-To:Content-ID:Content-Description;
 bh=x+9F4maA1q/9rHQs+iBe3+sg9AgMZGn1PVrFHNoUf/0=; t=1795521284; x=1796730884; 
 b=e2s8XPoVY1UIU7m0lZBHRaY9XJuMA0U4KBFuPcejaIda9qA+nod/07oVHNSHfUmnjNTunUUb1vl
 HOTIASFF1AbIOhsyS8QEXNhyE2ovn7NXyF2mIPE8z1eru7Noo9BSb2GZWv68Vz5dqiPoSZjcfHDFO
 rG6nli7CZ+JUJy5d0zk7/l+27OV7x6REhNbt6JvWsB300XZT547vGnPvREMJ4yvfI8i5C8qH82Nrt
 ikivn6yhEkyjbWPT32Zsm39p65TRZIFXyG0jLFSyIN9wjaQuJIXk+UMn8k2wMNnR18RoUPUEjS83Q
 P8P9dtL0jppqAqrexC7PET1qODhdRtus7WUQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 24 Nov 2026 12:54:17 +0100
Subject: [PATCH 1/2] drm/bridge: tc358762: fix reset gpio handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-tc3-reset-v1-1-a5d27fe4b5de@kemnade.info>
References: <20261124-tc3-reset-v1-0-a5d27fe4b5de@kemnade.info>
In-Reply-To: <20261124-tc3-reset-v1-0-a5d27fe4b5de@kemnade.info>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@nabladev.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 kernel@dh-electronics.com, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=azMO7qXFLB3Oq7I2Js+X2prmA8P3ATtPHmA5Y0XVp/k=; 
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBrBXryiHJRHKABncWLjlr5+3ieC2M8gm72Ymtau
 w7e0sQqIg+JAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCawV68gAKCRCEYUX6QCjc
 8YveD/9S/xOQE4ZQuQZwrguRBpV2LhlOu6ZaUFh9gSoMOJiupQolDPS95A8A7jBhnuOC3GKGIPQ
 EqFfsFw3PFu5KYaCZRN1TcvgIUhPzOgzwAB+b6esnBw6gKvsAzqI3xoeisJOj0ytlIdoS0oyX+y
 YHL5v+RMzHnyXje2w+mqs4MQrOFwjGTcOeDqXLtvVsLaxgJesimEodvsakHuEIe9sUgPFMrzHBb
 Ov/9HUvpPJlRrhp3hWf5JfzFwzTBPHqVgnXp0jUeRiuG9hRZK9Ns14XgJ1O0H3ay1H6KJ1vm1xC
 RMp25iIckdOjHqMlnMwI6+1eX9EwgHIRvJg/nZZVcIzDZOIWlZLVAZG+Xxx3PqTA8dwpVVhBn9E
 j8tdRWtZDqMVH6FBADh/4tEHIZnsqV6uPwiq/1gBjOzit1h6gwDuM6kE0Z9PMEABj379b7MxIir
 0mQQ6Pmql9drcRRKEv1+GSfBCggTEp8hFVINDDvPj38prXwKy/HB55JYh7ZwoHKEg9k/ydnrlYj
 ECqMKcoWMzBm4lWidRZ+ILw70XvcYW5fDCM8rO6ihZ6shPyw91Acyd4Ppz9X1BNu1HN8Ndd5+/3
 T4X9n83ZU9t8xvz0a5dXiLAX+lttTkW3cH8aK4wZqo+FHrHzd7U7QEeJZDIobDgbASGLl2/iygi
 KPwxrj8MPDw8CYw==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
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

Reset gpio is asserted when the chip should be active, deasserted when
the chip is enabled. That is the wrong way. Apparently users are working
around this by using GPIO_ACTIVE_HIGH to compensate for that bug but that
is not correcly describing the hardware. Ignore GPIO polarity for now
to ease transition hoping that nobody has an inverter in the signal path.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/bridge/tc358762.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 76564d5e4f69f..404420c7b517e 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -164,7 +164,7 @@ static void tc358762_post_disable(struct drm_bridge *bridge,
 	ctx->pre_enabled = false;
 
 	if (ctx->reset_gpio)
-		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+		gpiod_set_raw_value_cansleep(ctx->reset_gpio, 0);
 
 	ret = regulator_disable(ctx->regulator);
 	if (ret < 0)
@@ -182,7 +182,7 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 		dev_err(ctx->dev, "error enabling regulators (%d)\n", ret);
 
 	if (ctx->reset_gpio) {
-		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		gpiod_set_raw_value_cansleep(ctx->reset_gpio, 1);
 		usleep_range(5000, 10000);
 	}
 

-- 
2.47.3

