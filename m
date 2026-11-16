Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871F606A33D
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4AB10E49D;
	Mon, 16 Nov 2026 21:59:16 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72EF10E49D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:59:15 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8b4dbdc9592so6096847b3.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794866354; x=1795471154;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cDCmA76uVbC0tSHJSrf5hfj6GqNREL83/eNFtSmoII0=;
 b=Twdyki2c3kGIJ7gSomPBI4LuZyWD3/GvTJhHJLQ8avOsVB2nuykKN66Y29sJPiCeIl
 ajAFbdxR2XwE+VJlQ6C8rO/I6exJW8eLLuO6+3hoytGDRc128e9PDaA900xnMaqNMK31
 m7yfF+Y+ZG+zEAf/znn7nZryT0gViELKfKo5hLnDq8YTbwuWZym3viyuT8O2tOAwHEAA
 Yr4N8BNP/tGbE0gLSoRC6Vf2iI/Ll84G4SPro1l61KJqZndRkQER7fQZlIZMTsCsyRPr
 koCXiZxaw6lGrK2CcMMGF9xXiHaDdXiDwBeeBtNM8tfFm+aFiBve7eSJeVqdsC5Sz7D8
 EZrg==
X-Gm-Message-State: APuU4Z8XrwuG6o1/6EG010UZYVRZIZ//E5aNlA1rlweK5g9bIJDsgErA
 8J7HHUff5NK8rZf485SiodCq8yY1Ym9eoGFDcqMRGCV6Hl9An6gI2BQo
X-Gm-Gg: AZFdTZcxgXiSoeP2tjWdCejU6pkSPy5jyxxacjL3m6R+kJsAF6v+6NIcr6yI8BYb6tq
 Fx6IxJBiZ6vH2zdTUpqhdaHZIjC3EyKE7TS5UJTk/LVoP2pvzSXIOkdnVmddKf/fiIGKMDNGYdR
 1jF5Yh0mAyOrdrg0k0MKn03BqcoF6UAr9rWeYVyAzryWGAgsNURmCWdBbH5ZYT5JdNUkbqa4sCD
 G0unjkxnPTsdluPhJqMQkSbIUPIJJ7pyeTVNJGIerWq4ztKizcbqaHcC3gwaOFcSpkXvRzykhdw
 NZgCaWyRBNQZqPgyscqH4nxndrzcv1ys3khHH+cuD8Cf5aaczjK7g6G2viWoNNbmlm/u/cNWnPO
 P+v12DFoTUPYxKw3NdVxq4TUhfMCUzbpxowN5MDTKEQlWEWr/Clor0zAZVJzEk7MgwaR3Jh6Q47
 bCJSluo09EF/OGnMlE6BMz+n6YDWQQewKh5TpVI5PUtG+WupQBK3G8Gy9KY7kOf2FJW7mNI9bG4
 mlH8VFWx8bya+2RJ/IdsihdAluGLJxt+VUtG8hNMmwKJoIqAsZLxrReFUMCwIh5XHE+wvXcsqMz
 ub9CH0ODBWH+0tIjIFGyu+gQQFiLrpNd6FPUaOX+MWJHPspepLQTbWOvRBK8uaNeXe7M4Baey6L
 ZWHqBfMy42xMAYywKlL0j3j3J+X8DN3988w==
X-Received: by 2002:a05:690c:6e83:b0:8b4:ccfc:e38b with SMTP id
 00721157ae682-8b4ccfce9afmr29883057b3.24.1794866354031; 
 Mon, 16 Nov 2026 13:59:14 -0800 (PST)
Received: from josephs-mac-mini.local ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4ec064db9sm9656117b3.27.2026.11.16.13.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:59:13 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Mon, 16 Nov 2026 16:58:59 -0500
Subject: [PATCH] drm/bridge: adv7511: Accept S32_LE I2S samples
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-adv7511-s32-v1-1-40ae8228db42@telaak.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0NT3cSUMnNTQ0PdYmMjXVOLFKPkZEOTpMQkAyWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgA/ed7CbwAAAA==
X-Change-ID: 20261115-adv7511-s32-58d2cc14bab0
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 7c3127e4814c ("drm: bridge: adv7511: remove s32 format from i2s
capabilities") dropped S32_LE, which adv7511_hdmi_audio_prepare()
rejected, as the ADV7511 takes at most 24 bits per I2S sample.

A CPU DAI whose only format wider than 16 bits is S32_LE, and that puts
no padding between words, then has no format for 32-bit slots. As
hdmi-codec's I2S_FORMATS comment says, a 32-bit format gives such DAIs
24-bit precision. Advertise S32_LE again and program it like S24_LE: in
I2S and left-justified modes the ADV7511 takes the top 24 bits of the
slot, and hdmi-codec reports 24 significant bits. Right-justified it
would take the low 24 bits, so a 32-bit sample is still refused there.

Tested only on an ADV7513 fed 2 x 32-bit I2S slots by an OMAP3630
McBSP, where a left-only and a right-only S32_LE tone at 44.1 kHz both
play at full level.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
Found while adding set_tdm_slot to omap-mcbsp, posted separately to
linux-sound. omap-mcbsp offers only S16_LE and S32_LE.
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 4 +++-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c   | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 87e7e820810a..8e38b936ef6c 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -105,7 +105,9 @@ int adv7511_hdmi_audio_prepare(struct drm_bridge *bridge,
 		len = ADV7511_I2S_SAMPLE_LEN_20;
 		break;
 	case 32:
-		if (fmt->bit_fmt != SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE)
+		/* Right-justified takes the low 24 bits of a 32-bit slot */
+		if (fmt->fmt == HDMI_RIGHT_J &&
+		    fmt->bit_fmt != SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE)
 			return -EINVAL;
 		fallthrough;
 	case 24:
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index d3964adbb106..0cff81a6c086 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1351,6 +1351,7 @@ static int adv7511_probe(struct i2c_client *i2c)
 						  SNDRV_PCM_FMTBIT_S20_3LE |
 						  SNDRV_PCM_FMTBIT_S24_3LE |
 						  SNDRV_PCM_FMTBIT_S24_LE |
+						  SNDRV_PCM_FMTBIT_S32_LE |
 						  SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE),
 	adv7511->bridge.hdmi_audio_spdif_playback = 1;
 	adv7511->bridge.hdmi_audio_dai_port = 2;

---
base-commit: 17a180572ca50c8d38f3aa47d6fc81ce7c5594da
change-id: 20261115-adv7511-s32-58d2cc14bab0

Best regards,
--  
Joseph Telaak <joseph@telaak.dev>

