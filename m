Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521D606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F+b+LUUe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A85510F04E;
	Thu, 19 Nov 2026 17:54:56 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C2610F06C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:54:45 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso18474335e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795110884; x=1795715684; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JZeXMm6AAi44BWshE63wgfUA4zyj+3ZnN7hXQLNUFPk=;
 b=F+b+LUUeC+m5La01LFDmUp7VKIP+W7q0SdI8C2x1SYl5UZKZV+2agP4B3hGH6RlhJf
 0wodbAMFJE/33x1C/AIptwqKlWwqjhEeyfuMIlXFyG4+cyJUYCg8ZO5w4PUfoCdWaVcy
 HSUQHvvTNybJgEiFRfD2g6JRwLoMtJgOBzalxYXsBczAAd8FA19sHAPU9MFJ3WmzcqY4
 Hg2lFMELcHP2k/4KP3Iq6J9d8JtTMIt4qSHRRMoNUE8wRPia2CTCRl8VE4L0VY9DjEPp
 LtSdWZ2hOzimrFnQfkNNbC2iPhMmV5d5WEH9jw5dUAWRNP7RzwfALCoVZHUV0l8AqFPC
 HCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795110884; x=1795715684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JZeXMm6AAi44BWshE63wgfUA4zyj+3ZnN7hXQLNUFPk=;
 b=KxQ8FD6j/y/SVbOHK9sWk38IEQi1xesUZofTcCE1ViFbqREr0hqcOeu3jhIAzfgmjS
 Sw6NfRPGIqPiu+9oFIzrdD484oO7JO+ULwy7ogaNsB8ZIZRsVihnPBizw4wdgqlSn+9F
 +HFP+5MOz5kyGvChtDjIMem/rxCz/MaUVsidZaTqlvVOYXyGbfH7zldkbbS8b6T0IlA5
 arQaOb7SuLT5PrDSxsLJ7Tq9qBuN9YFzkzMWCLBJ5H+d1giVHyMr+PCrbTsxgvgtUZJX
 Uborsn/Z3HWgcFs25ksFJiIiUCo7ZWkRyejHPg3ltUuZKbtdfdUccBs4ai+YIXrn9YWK
 xKWQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEIYrZO1/RANE8i9WxVxql34gIhlFmGsEkfL56P+o8JZWFLYjxDzC8L+RUPLWOXJvDPo5xsQohmxkw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z840okgODo/dQb9XH9KFNvDIWPU79U1FRBKWArMAe5z0fDORitw
 nf53moc9WALHht8W7oVgdMd/w8cSV/phgSsKnAnZVUEl9U5KbZ0/WWQL
X-Gm-Gg: AYBFou1jmcgXKtopqjPximYcVtf4X2/CuDInA4oDmNNHX4PTEb/FgUUopFu2pxaKtoV
 Gs4hgil5LnY17YuF9d6vRfSX0l9E8mKupdiDtFIlxbpnvmrS0cL2BvqzjjwP5MPkANG6mLl9IKs
 IF+ZRdQY2bAe76M/QROae0TzRDKor1YY28myVML2bhgBpkXBby7NVkoou/XZ87LHXE43BIyfpnw
 mHuAlr2z5zeNnnRH74EgI3ycywRwMGgH/CuryLInFr9aqoUwdecmBXIaplOlHFkhonjJ5QAFTOt
 2yRrid2OzYTR7hiLeNt9GLEyBTjhH+i6Rjin534OnsWkM+cNXO1fJ/KeF9WMi5qjRGm0zuuO6QM
 0d5+z8uH61UtoIlFdpKx785MBMIxVDhhntMA7RiZKHyO5lfeudt2bn/i574nkv6YxxXWvMkPBwi
 AKroKJkqIJeX6jscJzYu5W0qEgbOzRt+BCvr+eAaMdNzGGsJAgsF3mc7dvTUWhY/IueBpr0ezDZ
 HrvJfT2q6g6lwVRvIDKCncAvfMXvCVb4bB3jqLOsY0ES4BaOT4wmv9ARUfmxKeG5rrvV3Oz6ALD
 2C8lYYUnphK5GbBpSkOJGbktlkuOGTM5QoIlOvhfiCyVz9O5iYmPHDwjcq1ob3g57x9Huc/GgMc
 N4K3yBIgFF21UmnL0hPRdFgFRIVV07ulIAbtBF1rZGE/F/bICPW66a+7bEt2hYBaHNPPXvOANXW
 4orKZ44X7ThnTCfOkzMFiW76ySFu0r2K2wVqo+zqY0xJxWr4gje0RTZE/wutcXzcJswq7faGmLa
 0aVW8K/T+5pMBg5pl748GelM8AFtH8DgE7BF/z2xxuPyTdwi8QM2WlZ
X-Received: by 2002:a05:600c:a08e:b0:4bb:647d:dabe with SMTP id
 5b1f17b1804b1-4bb887c3afamr8512525e9.3.1795110884056; 
 Thu, 19 Nov 2026 09:54:44 -0800 (PST)
Received: from jernej-laptop (95-143-148-21.dynamic.telemach.net.
 [95.143.148.21]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e50512sm29390035e9.3.2026.11.19.09.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 09:54:42 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] drm/sun4i: Reject fractional source coordinates
 without scaler
Date: Thu, 19 Nov 2026 18:54:33 +0100
Message-ID: <20261119175437.2520400-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119175437.2520400-1-jernej.skrabec@gmail.com>
References: <20261119175437.2520400-1-jernej.skrabec@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The layer code programs the scaler whenever the source rectangle has a
fractional offset, since only the scaler can apply a sub-pixel phase.
drm_atomic_helper_check_plane_state() with DRM_PLANE_NO_SCALING doesn't
catch that: it only compares the scaling factor, which may still be
exactly 1.0 with fractional source coordinates.

Channels without a scaler would thus have the non-existent scaler
programmed instead of an error being returned. Reject fractional source
coordinates on such channels.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 24 ++++++++++++++++++++----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 24 ++++++++++++++++++++----
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index cf66f676824e..f9c7f28f9fa2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -179,10 +179,26 @@ static int sun8i_ui_layer_atomic_check(struct drm_plane *plane,
 		max_scale = SUN8I_UI_SCALER_SCALE_MAX;
 	}
 
-	return drm_atomic_helper_check_plane_state(new_plane_state,
-						   crtc_state,
-						   min_scale, max_scale,
-						   true, true);
+	ret = drm_atomic_helper_check_plane_state(new_plane_state,
+						  crtc_state,
+						  min_scale, max_scale,
+						  true, true);
+	if (ret)
+		return ret;
+
+	/*
+	 * Fractional source coordinates can only be handled by the scaler,
+	 * so reject them on channels without one.
+	 */
+	if (new_plane_state->visible &&
+	    !(layer->cfg->scaler_mask & BIT(layer->channel)) &&
+	    ((new_plane_state->src.x1 | new_plane_state->src.y1 |
+	      new_plane_state->src.x2 | new_plane_state->src.y2) & 0xffff)) {
+		DRM_DEBUG_DRIVER("Fractional source coordinates need scaler\n");
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 09d94f7f9977..4d3fc03f9877 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -259,10 +259,26 @@ static int sun8i_vi_layer_atomic_check(struct drm_plane *plane,
 		max_scale = SUN8I_VI_SCALER_SCALE_MAX;
 	}
 
-	return drm_atomic_helper_check_plane_state(new_plane_state,
-						   crtc_state,
-						   min_scale, max_scale,
-						   true, true);
+	ret = drm_atomic_helper_check_plane_state(new_plane_state,
+						  crtc_state,
+						  min_scale, max_scale,
+						  true, true);
+	if (ret)
+		return ret;
+
+	/*
+	 * Fractional source coordinates can only be handled by the scaler,
+	 * so reject them on channels without one.
+	 */
+	if (new_plane_state->visible &&
+	    !(layer->cfg->scaler_mask & BIT(layer->channel)) &&
+	    ((new_plane_state->src.x1 | new_plane_state->src.y1 |
+	      new_plane_state->src.x2 | new_plane_state->src.y2) & 0xffff)) {
+		DRM_DEBUG_DRIVER("Fractional source coordinates need scaler\n");
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
-- 
2.43.0

