Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1070606A335
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Ar/jc+Up
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D959310E6EC;
	Sat, 14 Nov 2026 05:01:17 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CAF10E770
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794632457;
 bh=45boCezNlmhhziUm1FzEEYt43rJYJ/1/7ikuYa1yghs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Ar/jc+UpSFh0F7Z/zALXxHoNTyNx8NdTni49RhLmIZr6IJrWnFjKzgjbZdQZSnsXg
 yHEMITid2W09sa29SIdOTPTzaQ2aTsmbHJ7V+7y0K8pVVBASzF8NiY7/2nxzBgV9O0
 IlgsSDuROa5PWq4hTqqC7y39OX7fhvnztf8/eZOXZaPadqkEpuW3OXzThj38FTsS5F
 ytlQkrmWxRk0xArdnkC2VgCS8AtUyO8vbQVlauV4wSOJ5d7x2aSGTvHouDHN0GXGGp
 cV+cbE/2Fqe9Sui3KwfiNawhEbjrj6EPIRl2cRlGiq4lutjrIu7y+qoLvXfs0zRFxK
 +4fnpw7lwjlAQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 058D817E3BF6;
 Sat, 14 Nov 2026 06:00:57 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 23AB1480062; Sat, 14 Nov 2026 06:00:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Sat, 14 Nov 2026 06:00:49 +0100
Subject: [PATCH v12 16/23] drm/rockchip: dw_dp: Add system PM support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-synopsys-dw-dp-improvements-v12-16-d42d3dc5bdd4@collabora.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=45boCezNlmhhziUm1FzEEYt43rJYJ/1/7ikuYa1yghs=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr36weEWcInHZA679Yj1StCqOFPYLhDNHZLM
 vbi3xG9n43o14kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq9+sHAAoJENju1/PI
 O/qaHF4P/jVBIVmlo/DZ5M7ZQqryNZoQ03JqP8zliw6mRVyQBiGyuwo+6lQRA7vd1nKW97Eretf
 n/CWVYj8b79IxBUwYe9gjAX66suftDI90MsHUNFwUCO7dYqh64a9RqwwczocasmQ+aK2kFh6bEf
 lw9SmBaMuF/0Y69SUKY5cW2ClZlAscf4YbAL9jGN+4iC6GL8FfZMYHNe664Rp3EYUBBQen0UntD
 3SkQwWHvpTreN0B/ahxMQN9HFmtTJ1j2vgLQAi2Tg2pB11/qPT8leRBenFbMRmO7szL7o5nNYjT
 w2Mf7LqteW4KHfihXAfA4/SeU8mQPalm+BGQ0IM+B+2YtSb60wOUgsUI1D4YSQ1qAexQ9RGoQzx
 umlqz+RJEkm9cLDfaR7YaHDoyi1hWTa0/t69L7eF/58wP/ceqrslxPLoiWb3ONZEAmY5re89SGy
 l4Uvi4IDcY6/mGP2DUKuHP+iesKqDw2zGYgGtvnfSz1mp9yx9TTGRsmuVNxCXQVbS/oEK5C8GBj
 zo+Fl6HdUBxytK1WnO10nvSRSWpZAf0vx/6bg940/LIsrBZTDYcg0HIc5uYBr75ufQjGHh39IGj
 feQntBTSgYCci+GVGIebCCG9N78y9SefKt+93ZQ3xl230Qt+xV5u/I/iuBBYMvTZHP4FVTpRy87
 i3GUbhbZAQt1BB3TpuE4tpQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

Explicitly suspend the DP controller when the system goes to sleep and
more importantly resume it properly after system sleep exit to recover
USB-C HPD register state, which is lost when the system goes to sleep.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index 99d948a7c51f..4cfb40494379 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -269,6 +269,7 @@ static int dw_dp_rockchip_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops dw_dp_pm_ops = {
 	RUNTIME_PM_OPS(dw_dp_rockchip_runtime_suspend, dw_dp_rockchip_runtime_resume, NULL)
+	LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static const struct rockchip_dw_dp_plat_data rk3588_dp_plat_data = {

-- 
2.53.0

