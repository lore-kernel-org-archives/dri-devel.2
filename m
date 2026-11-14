Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A80606A334
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AwU4ZKVz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDAF10E69A;
	Sat, 14 Nov 2026 05:01:17 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE0510E6EC
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794632457;
 bh=qiTnNJ+ur0YxXmV+nt05zCuHB94myasDkxur83iCFBk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AwU4ZKVzF8jDvmTXv5KxJT3byOWTHPEKnoYi6WSFYgThhCO5lb+eDqVrcRoYo0s4R
 Hvh/djDGXzNlycGOs3cjqzKJ170/Tl1yGyXG7zyHlQPeXawgUNkn/NjWMa2lSAMkM9
 LUe+g9gJsaDWQZaU3EZ1K08u6AgYSJ7PARRk/VmRVN3w2jeO0k1c9nGknwjVjH1Cnx
 TUxfdYFr9PFcSTI7Q7eMOyzpW+Z/APqacg8s8Tx2Nju2BMnut36jBNkeGkDnnu5zzV
 zxF5D7MH/sQCOqi4Il2WCAFNTNrh7rq/hhscIkUwNETgjLXZ+uyWh9iDyCp6w24+Tv
 d3wVTf/r5QtVg==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B0EA17E3BFD;
 Sat, 14 Nov 2026 06:00:57 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 2A267480067; Sat, 14 Nov 2026 06:00:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Sat, 14 Nov 2026 06:00:53 +0100
Subject: [PATCH v12 20/23] drm/bridge: synopsys: dw-dp: Use regmap_set_bits
 in dw_dp_send_sdp
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-synopsys-dw-dp-improvements-v12-20-d42d3dc5bdd4@collabora.com>
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
 Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=qiTnNJ+ur0YxXmV+nt05zCuHB94myasDkxur83iCFBk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr36wf4v07B4qdQilfmkg+Uyh3Lo+yP8VsVu
 FXfwNb9sqBh94kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq9+sHAAoJENju1/PI
 O/qa8SoP/0YImbqbgVdXBLzRUNM4BOriNDKJzweEyk9m+MVlwRxd4vZmJA83LzGmYyBEIPK6JHt
 wMytUCYMR5fQXoKZRfFBPP/tIQlULp7XvssuRPFWOYeKTyJ+rpBFObJLVuBo+y9nV0RZkxKlkvy
 7Xl5fZFiBpb0u+lstfbaT2oRI6p9bCdkWHiRB0smPaQMaCtMnr0GNHq+aqciLJH9hz7/R2RaC41
 gBPaJG+rgsABX4CwiOtf3XmxUrjbooR67QaGLYToSjlwnGkzm8vbgoOvOYMxKkcy59hBs/w9ycm
 Dml3mkqBI6ARBh8zrHOXMNijqTwzffvWGnExKDdjlkuoR1VkYJjg42RuTSb1hh3wKGziYE+WBSW
 SCWuhGNHicpZG725GvSpHyz/pEs7ix3rwVZodurDLNi/DUMk5RswimgPkKM3OLBCyI+jZ6yArP+
 FA8M1fJJ3Y3PYTibcQw0jnQnvVVTpGsgGnwr5CCU9UFmATFbbtTBNMcgcVqlRdtj+rTj2gAcl2d
 hBd1wqY3Nz2DPoMrybdTW30frn4GjWuwcN2PU/LOYrJJVfth63EScfz61wZD+KMTFECjzldZNyy
 iQXL3KfF5yxwxXUV9irsNHlGzMTkYVQVGLddwsi0SqDjBqMMADQWVjZJufPFokXipRvNmf4LQiK
 i3f7iiWsSPlAAeJMWzm8sOA==
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

Simplify dw_dp_send_sdp() a little bit by making use of
regmap_set_bits.

No functional change intended.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5+
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 6e165e39b1f8..3c10cdb9ca28 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1068,14 +1068,12 @@ static int dw_dp_send_sdp(struct dw_dp *dp, struct dw_dp_sdp *sdp)
 			     FIELD_PREP(SDP_REGS, get_unaligned_le32(payload)));
 
 	if (sdp->flags & DW_DP_SDP_VERTICAL_INTERVAL)
-		regmap_update_bits(dp->regmap, DW_DP_SDP_VERTICAL_CTRL,
-				   EN_VERTICAL_SDP << nr,
-				   EN_VERTICAL_SDP << nr);
+		regmap_set_bits(dp->regmap, DW_DP_SDP_VERTICAL_CTRL,
+				EN_VERTICAL_SDP << nr);
 
 	if (sdp->flags & DW_DP_SDP_HORIZONTAL_INTERVAL)
-		regmap_update_bits(dp->regmap, DW_DP_SDP_HORIZONTAL_CTRL,
-				   EN_HORIZONTAL_SDP << nr,
-				   EN_HORIZONTAL_SDP << nr);
+		regmap_set_bits(dp->regmap, DW_DP_SDP_HORIZONTAL_CTRL,
+				EN_HORIZONTAL_SDP << nr);
 
 	return nr;
 }

-- 
2.53.0

