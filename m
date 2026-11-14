Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75120606A8AC
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AXUzCspi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7BD510E8CA;
	Sat, 14 Nov 2026 05:01:12 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85E310E777
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794632456;
 bh=aaF9G9vRtyHxyxIaTY8fV2Bu+8vPGjYVQJ9ai3cxtRY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AXUzCspihXgF5F/RfbTaPjagSIWOhEsqe9SIsy5Mt0EwTWrQtcpohsZzgbSESyPnF
 /rN44luMWZL5Z0fqCQJAxcutaniyg2lTP9HQcakHS8eQwsue/9l0p5soQ3CqXMKoLy
 OPdjr+hwVe/h9Qs8j9flL+XBlRrIn+SZzIJ/rdwJskdyZiTzj95j1ixuh2NH7gfTW+
 A6ICpj0KF8f3j4aeFQVt9hhHaP2Xi+eGRTqPGbE8ED7O39+III+OjKcGn7IZiAS34x
 +RgBT/zWzGdSSilu5mhgxbKCxQABD1g7ccDF24b6i07bGWAecb+rFR59l9AG3HMIOr
 ag3TcakqJMUhg==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B083117E3BCE;
 Sat, 14 Nov 2026 06:00:56 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 1593A48003D; Sat, 14 Nov 2026 06:00:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Sat, 14 Nov 2026 06:00:40 +0100
Subject: [PATCH v12 07/23] drm/bridge: synopsys: dw-dp: Fix support for
 short I2C reads
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-synopsys-dw-dp-improvements-v12-7-d42d3dc5bdd4@collabora.com>
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
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>, 
 Andy Yan <andyshrk@163.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=aaF9G9vRtyHxyxIaTY8fV2Bu+8vPGjYVQJ9ai3cxtRY=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr36wdsrZe53j9kYc0qHSAmKExD9Cz35Jq49
 2NVa6ysBl1A5IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq9+sHAAoJENju1/PI
 O/qasPAP/0B0prUvCL0gg6/fUlIt4Nhwnp3juBsDCMHQ1OfzKajQgsI1y5YZcT4KrPlX5j2rtiA
 RMgTnl1hYiAPKsR+MqHyEuqmiIX+9gStLTHJDg+EImTc75n1SXZ2BgJagKTMlR5+1ZKthu3pnka
 Ew2QlL2TUSajtWw3dWwX43k8svSrF2n4P13uVsialiZZpMq55zAmDOXmgDjdi1+zs2+42i/R35u
 tqfd+Ot/1E97sAkYpAQ8uWhF1A+3CD8zMdtgEAiwHyGvyIX7/nAXYORgmor8qIixdzZhpgJNITY
 FYaFm2Z2rD539fL6qGirl97hCa+Izd/8rfqLNCWdlmtRxmB7lGREmlh63FGwsQKJ2mjmpmrA0WF
 FFFl8zqOHujh81CcjyZ6EIiu3/AGjQNhrC0OttyFRQx5+KbMqgsmIc9Wtsig3kkgenDI90B0KdI
 P6yIG7lVz/8w1nhY9ccZF4SxZN4TUJHwk5/bdYF8ObS+6AgNSZURSKl/IrZyikIFkeIYrz3rxxA
 F0uoMtKF+iAAFVN801cdiH2tBeQH9y9E7Z+ACgGDU4bk0vTHG0hv2Jez+nia1Cc8T8Ao5yN/lox
 evTbtHpd7hmbHKorXD+P/krPwVweGN2JEmCPEpftlKcRh+aTedQJ41muhZJD3CZFPD5tScU4tea
 wiklWFLo9F+veZc50+YMt9w==
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

The transfer functions returns the amount of bytes read for
DP_AUX_I2C_READ. By returning -EBUSY for short reads, the caller has
less information available what is going wrong and possibly simply
resends the read request. On sinks not supporting long reads, this will
simply run into the same issue again.

Instead it makes more sense to return the data from the short read with
the length information, which allows drm_dp_i2c_do_msg() to read data in
smaller chunks and succeed in the end.

Due to lack of a sink, which only supports short reads, this change is
effectively untested.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Reviewed-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5+
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index df0b98cbbaab..4afa57f4bce2 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1512,7 +1512,7 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
 		if (msg->request & DP_AUX_I2C_READ) {
 			size_t count = FIELD_GET(AUX_BYTES_READ, value) - 1;
 
-			if (count != msg->size)
+			if (!count || count > msg->size)
 				return -EBUSY;
 
 			ret = dw_dp_aux_read_data(dp, msg->buffer, count);

-- 
2.53.0

