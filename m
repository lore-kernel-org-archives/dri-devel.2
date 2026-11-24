Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D768606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jovbAs3+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9968A10EED1;
	Tue, 24 Nov 2026 07:41:34 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0393610EED1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:41:23 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2f04b676219so22116135ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 23:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795506082; x=1796110882;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h3c2lWC29hGMhiXznbuXjidfPs4Wpjz3u2lyu3ifusU=;
 b=jovbAs3+xkPjFTaWI5nH3rnwEbyhwNaD6x01wTgH6sN2oBS6BO5+QJazRW3HtInPHp
 8xF5j/1+qdhOCTXSETdFoMWy+C7RV49almyee8+QHQ7VgioJJaiouM6eSGyEgVDVK1un
 Zssa15t5c/z25DPeP6c+Wf0OWosKauwlO7ynk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795506082; x=1796110882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h3c2lWC29hGMhiXznbuXjidfPs4Wpjz3u2lyu3ifusU=;
 b=g/wdVcNdvoBtitnUTWAFj8ANMmQyPlhVQIPvFSjGVDwhdLEl/Ri5tsq4G8DBRsY5QP
 qww0/gOZN7Ip8+YrHGKR11A2F+Kk1bsrrhGK6+FZUXNZkoqRBJat5mRwt+g17rEtK31G
 wztV3/nBNVonHFpZZ0lGEwJ4DWRFBeR/UIAGbN7Q9sR+V5cDxn84j3HJV7w5R3WZnQfY
 8z0VVl3MvzvOB9Wb9xSORssxznwAyjjJTuzb3Aoc7x0gBf51bAYukG5U1T1Hqcq8/5ym
 gSeqRN+N12vVWRODvoG+Ygzh0QqlTRPDBSIM2bqOj0ffKUT34wwL7RxcSWVsdBD8sCpq
 BxyA==
X-Forwarded-Encrypted: i=1;
 AL+hErFqLFI3BXslMNRe/btOATH1RVg3MHccple+42DQF/68GKArs3ehm7+Ua8aHFJUsHopSbKt2COufPn8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8JNshnt/fQWDiK1Xn631TAxx14q9uTEpn972La1jUpglgn7IPD
 GnU7YSLvdDL3MDCGzcDmveU8RLLOksGrK0YtZr64QXMN8i1/Lc1D3ZGDO3CYe1u0wQ==
X-Gm-Gg: AZFdTZcRLMyrkgyxCuhSnBfT3LN2nzTuh91fhfFmi7wIj1ccRLWG2ZAlIerAhaK3bEy
 mlZLvHQHGeURMGD40fWsMR+/Vur5VNl8HtNlwm07YlCeAOGv63XXZpRQHH/RPx6j+kcoQSNyNqO
 OHaY0QlbqsHtEXZ8RO2EULx+I2WA9BK/MaSQAKlSQB6KVkyz6knbR3megR1PNu7VymWgo+rKkcP
 0jfAV+QpU6j3agVpHW8TFvrW+xWuo7rZUU+ARl189RhuSoBm924lHoQrWjbSRAri4a/A23SDpq0
 MRiDeabXgJv2yfQj/gxzCns59li6OUw6IIvP45oqfXYsMtBy/4AKgH4up26BWNfkG/63pfroVl6
 AtAxB+U+Jm/cXnas6VIR4qXjzaN3JWofDfeS6Fei78TaFKMJTIep26FwJMFNqKLvptnUGxzTMAS
 ci8c84q8+vf1QhLZeWg/obdoIUw+cO++TFHlI9hZ7AVV4RArdDZSB6nInYEZzmh8zftqy6zFli8
 6kcyPshUNcj0EOXNAKXloY5hEBDPyJV8C7pwWKHPgD0XxZ7wfB5URStY81fofNkSdn0E5NnciRH
 DxWikgtVoxW9Ris27+gMyBCt1qQRBQxFGLGdNtarj2eQKiYCk1hGMZYmcqTu
X-Received: by 2002:a17:903:19e7:b0:2ed:b7e4:f5b with SMTP id
 d9443c01a7336-2f03f18a7d9mr127037815ad.40.1795506082519; 
 Mon, 23 Nov 2026 23:41:22 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:8f32:8910:4727:ea03])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2f03f120830sm64742695ad.61.2026.11.23.23.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 23:41:22 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFT v3 5/5] drm/imx/dcss: plane: Switch to
 drm_fb_dma_get_gem_clipped_addr()
Date: Tue, 24 Nov 2026 15:39:33 +0800
Message-ID: <20261124074041.115251-6-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124074041.115251-1-wenst@chromium.org>
References: <20261124074041.115251-1-wenst@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The i.MX DCSS driver is open coding drm_fb_dma_get_gem_clipped_addr(),
with only a slight difference of rounding down the X offset for the
first plane if the format is packed, sub-sampled YUV. This is likely
to correct the buffer address to the first pixel of the 2-pixel group.
Otherwise the hardware will start the scan-out from the second pixel,
which leads to the U/V components getting swapped around, and the
chroma component of the next pixel group being used.

Switch to drm_fb_dma_get_gem_clipped_addr(), and offset the address by
a pixel if the X offset is odd.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/imx/dcss/dcss-plane.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-plane.c b/drivers/gpu/drm/imx/dcss/dcss-plane.c
index 303e93fd036c..580d9cfb4053 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-plane.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-plane.c
@@ -219,28 +219,22 @@ static void dcss_plane_atomic_set_base(struct dcss_plane *dcss_plane)
 	struct dcss_dev *dcss = plane->dev->dev_private;
 	struct drm_framebuffer *fb = state->fb;
 	const struct drm_format_info *format = fb->format;
-	struct drm_gem_dma_object *dma_obj = drm_fb_dma_get_gem_obj(fb, 0);
 	unsigned long p1_ba = 0, p2_ba = 0;
 
-	if (!format->is_yuv ||
-	    format->format == DRM_FORMAT_NV12 ||
-	    format->format == DRM_FORMAT_NV21)
-		p1_ba = dma_obj->dma_addr + fb->offsets[0] +
-			fb->pitches[0] * (state->src.y1 >> 16) +
-			format->char_per_block[0] * (state->src.x1 >> 16);
-	else if (format->format == DRM_FORMAT_UYVY ||
-		 format->format == DRM_FORMAT_VYUY ||
-		 format->format == DRM_FORMAT_YUYV ||
-		 format->format == DRM_FORMAT_YVYU)
-		p1_ba = dma_obj->dma_addr + fb->offsets[0] +
-			fb->pitches[0] * (state->src.y1 >> 16) +
-			2 * format->char_per_block[0] * (state->src.x1 >> 17);
-
-	if (format->format == DRM_FORMAT_NV12 ||
-	    format->format == DRM_FORMAT_NV21)
-		p2_ba = dma_obj->dma_addr + fb->offsets[1] +
-			(((fb->pitches[1] >> 1) * (state->src.y1 >> 17) +
-			(state->src.x1 >> 17)) << 1);
+	p1_ba = drm_fb_dma_get_gem_clipped_addr(fb, state, 0);
+
+	/*
+	 * TODO fix address until helpers know packed, sub-sampled YUV format block size
+	 *
+	 * The buffer address for packed, sub-sampled YUV formats such as DRM_FORMAT_UYVY
+	 * need to be on the first pixel of each pixel group or block. Otherwise the first
+	 * pixel of the next pixel group is read and the U/V values get swapped around.
+	 */
+	if (drm_format_info_is_yuv_packed(format))
+		p1_ba -= ((state->src.x1 >> 16) & 1) * format->cpp[0];
+
+	if (format->num_planes > 1)
+		p2_ba = drm_fb_dma_get_gem_clipped_addr(fb, state, 1);
 
 	dcss_dpr_addr_set(dcss->dpr, dcss_plane->ch_num, p1_ba, p2_ba,
 			  fb->pitches[0]);
-- 
2.56.1.809.ga0b61035b5-goog

