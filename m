Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1C0CA6004
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 20:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86BF710F3C0;
	Tue,  6 Oct 2026 20:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="l2hKmePc";
	dkim-atps=neutral
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com
 [209.85.161.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D7C110F3C0
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 20:25:46 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id
 006d021491bc7-6de08b2e447so497346eaf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791318346; x=1791923146;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TuMJ7m5Vcv+rXpqn/K7pApUYeSmPWZZlEhNlSrC3ot4=;
 b=l2hKmePcMNiw+DeS6vZAc2oPvFFEwAl7KxZRKGNhNm3oDb7wiWISGnUeAdCl6zH9t+
 Y3loJwJ0hdJbq/vVXxpw02eknxsnODdhE1+THuguj9utPWMeyvP+zItYS6/PYW3b1bd9
 UOFk7PecOrukVeDdBlRKMauM88sPhqZuFaSzRUffifXY3oB3tBgIw+Inp1dP2oGt7x8e
 sA17wej2n0xwke00u9Fni++egsjLHsCP5HcJLOXoUhyuSV0dwor9wmHKQdi7RcaSVE/L
 O0ussAaNLL3su1552Ftr7C2iWstkUwGtt4ncupI+SM16NL0Nlk/A8ZhjLFW44a85ObUb
 etpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791318346; x=1791923146;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TuMJ7m5Vcv+rXpqn/K7pApUYeSmPWZZlEhNlSrC3ot4=;
 b=ltXZllGy6esqG+ZE0hvoQuTbLXUskhRyOOeFShsNon3QbSr3ICtsK3mymGiScEi7jw
 LCEfVsJ85GX8ahAw8ZA9baGjCGLKSmZpBpqIVYhrJX17wM8KfIUsTfxRbXAN0N/rxQhT
 fq5yvGy1t2fGoQxDjPNDSy6skF3JmDWuGNimWQs0AX3tbKXQ1XKXAjlu6Jbte7tFGFbq
 OgEjzcPnWr7/G0KoXKBm8qYlKvB0uJYz4+z2ebXuWp4T5aZmH0fn+rfIKOYJ6B/OSgtc
 4oWPIBdPXsnkl31ghuGkarUNv6yG/+NUrkBpuqG0xFqkjz/s1xHBwYzjJYFyXv1J6nLU
 lhzQ==
X-Gm-Message-State: AFuF++nBjNJM4W1qNChfPh7jdUyPDKitTFMw35EMS+dfTcR+r9X36Q2d
 9uYv2J0Tu7AEIJ+5LxsdEv4lZdPDc3mzrIrHmteOx9OrGNN6/ZvxAsZeZXs4M+ncKcI=
X-Gm-Gg: AYBFou3CRknZuDWhsDkVf8WhGKEbwwpMqpVbzAo8q1JnQxfzmLCwON+SJ3BElt7vE2x
 R1ky7lcYq7GsfunfFybgHk0YzFYJRb3aWZB+yabz/GwAxprGsBz16wQPxakBu+gYOGkslnf5cls
 Dm8ary6eXzRFHBC1kCh0eJdcDVmJdrF2IQXvGp2uFohMUped9U/zIN4EkjDIL7CRxQdyABO+bcb
 ENcKfTeIfwVvTzZ6wo9bVORgDwx1f6ps+9DBIXxxpfNyckBAJyvY59ZynMurJmzppzdhRTGnZDv
 aj6eQ5G7P3L/OmMNvZ3+8tW3EuLTkAU83DsB+wKvp2rkE6G4IuhQyQCbyWxHmcRxHav53r4AVjc
 8RjXUWJeKN7z0NJQN3kHC9MMuxe5xhLC0n5ur5G08ZXCF0b1nI49CNP5mNyUVgyRglNNOtMJ87I
 QrC9TRZlrkpI0Ywt9liooYuQcumAqTHCagvxxvw5n0mLxCjsUb6t1xutP27PkRgrP2GjK3jRSiW
 Q==
X-Received: by 2002:a05:6820:1996:b0:6df:961a:af2f with SMTP id
 006d021491bc7-6e7ac5151d7mr253655eaf.85.1791318345779; 
 Tue, 06 Oct 2026 13:25:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e793f68bf6sm463442eaf.8.2026.10.06.13.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 13:25:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Oct 2026 15:25:02 -0500
Subject: [PATCH 2/4] drm/panel: himax-hx8279: add the VDDP supply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-panel-himax-hx8279-vddp-v1-2-50d884b42aae@baylibre.com>
References: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
In-Reply-To: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=NyTgz/hgDxQKSuA5Ck4SyFt9fR3sfL/MexR3R/H3dxg=; 
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqxVksNR5t/ywYjewlDcdi0ghHLOdJJIGqzYu4S
 0FRGFjsMxSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVZLAAKCRDCzCAB/wGP
 wCSBB/4nAAPLD1Yv3Td1SgrZyG8pm0J+BxnvcD4ztUnuid/60B8XkFmMjr6FQkqLK1d/baXFatE
 cbGI8eGxXtN9EELfUFzkaiI6pbFo9vOfFbKfurBWmbBbZqfRPcn2p1P/KwOT8e9ERwN3pJBgDtw
 IJnA7ofvPQwKGq+hg/++URBXqdhW+mxUBDmxQ5lrxAKGaRxYsDnjzMf9aLhuEGGceSHp46P1zX7
 guK6fHdEksNWYX+mLcopg1bP6zp2KmcaUalp9b1hlPC3s2Xtoq75Qas1m+fWyast2NbbU+XFCNI
 OcROe3ts3gEeZSCMkm8yhiT4SXC0JamLJMaY4PxVT7cnbLG/
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Get and enable the vddp-supply along with VDD and IOVCC.

The Startek KD070FHFID078 panel has a VDDP power input, which the
MediaTek Genio 520 and 720 EVKs switch with a regulator of its own, so
the driver has to enable it for the panel to be powered on those boards.

On boards that do not describe vddp-supply, the regulator core provides
a dummy regulator, so they only see a "using dummy regulator" message.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/gpu/drm/panel/panel-himax-hx8279.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8279.c b/drivers/gpu/drm/panel/panel-himax-hx8279.c
index 9e443c719843..fe665cd3a3d2 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8279.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8279.c
@@ -112,7 +112,7 @@
 struct hx8279 {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi[2];
-	struct regulator_bulk_data vregs[2];
+	struct regulator_bulk_data vregs[3];
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *reset_gpio;
 	const struct hx8279_panel_desc *desc;
@@ -769,6 +769,7 @@ static int hx8279_init_vregs(struct hx8279 *hx, struct device *dev)
 
 	hx->vregs[0].supply = "vdd";
 	hx->vregs[1].supply = "iovcc";
+	hx->vregs[2].supply = "vddp";
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(hx->vregs),
 				      hx->vregs);
 	if (ret < 0)

-- 
2.53.0

