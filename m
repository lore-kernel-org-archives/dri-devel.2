Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2BDC5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B9710E6FA;
	Tue, 18 Aug 2026 23:47:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OtNqmMWM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05A2F10E0A2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 23:47:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49CFA601FB;
 Tue, 18 Aug 2026 23:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68E31F000E9;
 Tue, 18 Aug 2026 23:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787096870;
 bh=XGdv0RPOWe/xI6/BGdKprEdeW/PFOM5P0htoiHIhNCk=;
 h=From:To:Cc:Subject:Date;
 b=OtNqmMWMB8OOrCPC9pwgxmbJh22movI2zM5rX0dASUCE6tyXOTANnC445CfwnwqbT
 Rl5WjaAHhSIXs3YV3HsxA7dsQS/3w5Ky2oq+JXa7za6lZX88T5jIs/q6NRhJAiES+E
 tM7Kec1NZ5hzKFtNtfUIyc+RRxFyXTUjAV3osOEAmptvAHPPUtO43GJZRPag1jKGZw
 NJugVwtS0RCAQtUsGdHTqHBffbmoEzI4jStTEOAzPPy0LPzhVcS3AlyX/Xn+LrvnRc
 EyIDzJHuwHi+qnWK1/maxsvt8+AYDPJkPRrwflTa3BSr0y0iBNzT3D3wgavUq4Sw8L
 UjX4Mut8uVElg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: sii902x: Read "sil,i2s-data-lanes" as u32
Date: Tue, 18 Aug 2026 18:46:20 -0500
Message-ID: <20260818234621.1265415-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The "sil,i2s-data-lanes" binding and in-tree DTS files use normal
uint32 cells. Reading the array as u8 only works because the values are
small, but it does not match the documented DT element size.

Use the u32 array helper so the driver follows the binding. Changing to
u32 increases a potential OOB access range due to using unchecked
values, so add a check on the read values.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Add bounds check for property values as reported by sashiko
---
 drivers/gpu/drm/bridge/sii902x.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 9aac44ed5b67..241b472ab13e 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -862,7 +862,7 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 		.max_i2s_channels = 0,
 		.no_capture_mute = 1,
 	};
-	u8 lanes[4];
+	u32 lanes[4];
 	int num_lanes, i;
 
 	if (!of_property_present(dev->of_node, "#sound-dai-cells")) {
@@ -871,10 +871,10 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 		return 0;
 	}
 
-	num_lanes = of_property_read_variable_u8_array(dev->of_node,
-						       "sil,i2s-data-lanes",
-						       lanes, 1,
-						       ARRAY_SIZE(lanes));
+	num_lanes = of_property_read_variable_u32_array(dev->of_node,
+							"sil,i2s-data-lanes",
+							lanes, 1,
+							ARRAY_SIZE(lanes));
 
 	if (num_lanes == -EINVAL) {
 		dev_dbg(dev,
@@ -890,9 +890,12 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 	}
 	codec_data.max_i2s_channels = 2 * num_lanes;
 
-	for (i = 0; i < num_lanes; i++)
+	for (i = 0; i < num_lanes; i++) {
+		if (WARN_ON(lanes[i] >= ARRAY_SIZE(i2s_lane_id)))
+			break;
 		sii902x->audio.i2s_fifo_sequence[i] |= audio_fifo_id[i] |
 			i2s_lane_id[lanes[i]] |	SII902X_TPI_I2S_FIFO_ENABLE;
+	}
 
 	sii902x->audio.mclk = devm_clk_get_optional(dev, "mclk");
 	if (IS_ERR(sii902x->audio.mclk)) {
-- 
2.53.0

