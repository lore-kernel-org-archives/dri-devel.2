Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9BBC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC9A10E59A;
	Thu,  9 Jul 2026 07:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FwyG8AI6";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7CBC10E398
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:27:04 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-37d55e8d3e3so1900841a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783344424; x=1783949224; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n0i9VdK/Ma3gHZKckXQb+1T7ww2+Cb/2KCUzwQQKXZo=;
 b=FwyG8AI6hF0Um3VZf84qWpTdzXARL3IudFNPX4mU9hIpXVXgq2qjMfynZ3xAVDcOM/
 gCA6metcq6AHbgLpNh8r2ZNZTNhrGMlqqySIJPX7MWxwKoZRYSk0ffxpH2C3kQ1I2cwb
 aTrtVFqrts1ZNRrA990mvUwq1HvFW1hM41ChruAQu9cZBlfG828YpNUwSK7pvfQCVR93
 8vYfF6DNYku4VYrk3JmTtP3M70bmnEFaH1E7P6CGoCBqGufdf1s8yu1cwlA1adlMA8nY
 9ymezPltRJLE1rZ9Q8T/GTG1CfdTTf5wgYmfTivE50kfS5G5uLrjZQYV9jbFI1NDNOa6
 KSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783344424; x=1783949224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0i9VdK/Ma3gHZKckXQb+1T7ww2+Cb/2KCUzwQQKXZo=;
 b=TE6kcs/N8GAJ9S7V2NxQ5YksOCWgEfxjWLNf2owScoJ+bRFfRzHoz38lB+ikj41QRK
 8zmyVAcEBGuXH1sOOrO/fEWLWjqpbyR0y8QvyT2lb0uD1d4FQ7HzfNC8CTjJ2HriEZEH
 i+XZJyNvaAzzzj1oV3YM3pulpNoFnq6Y9f+fbZlqQ/rT4OrI568zg2D+oaKKS5fPR/HQ
 gRTKdSvvQBfgwhd5WQD3LKxe1+CyLxngc9fWNO66stOuUta0sLWVReO3qz8fDsCcRUXl
 X13PoF0ZJ+3bdcc5vxRi2nAPz7rd3oWmtVgIfYMtOYGrd6y1cn5p5zV63I1xPvytqG3I
 4OWQ==
X-Gm-Message-State: AOJu0YzMsyIdifoD2Mf5ErcXKidoW14n4Xp6GVyvjWUZ56RVWCZWTqV/
 z1rZ5Jqvz3KuGPd4TLj3ixQP83lDmfozHhwU3giwmOypCEcMa2TFkpHy
X-Gm-Gg: AfdE7cmdiuFOdD8Lq7fGVzRnOCRXLfELcwXPsdAiK7JCPR2wdlvas0ZtNWY81a5rDB6
 afUL19vYuCCJlZUkgL5CqeQt2bkcktIvG34UCiB/dC8eFqbCaQVEcB7h9uEGCY5LJKPC1UwrD6n
 98vk7ZLbvi4URPqlY+cijZJuw2F1R0Xbe4ByDdYvGN+69fiXuRrXh5WX45ENh3Cmwbn91XRcatA
 QRE1pQF9QZcfD7Uc6eXQcrXkfLBRKAdXVT3InAirKHX1BDUrPsiqBWrFCRAdln/vnH0efy+fzDW
 BKn7pAWcKZmaTLke0K5bwytaj3RjAzt6jwwL+ep/AvWAW/PLjdeSIKqV2Q3Rhp0V9RI0gTk9hNW
 xDbYGVOT2wHlJusKb03lTjO6tMrylqN7HeZ/zWhXib2KfFMT6yZNTnBX+vNpXxZFnSt6U9iVmeg
 hxlqMGppbGADDf/c94ED166RL50wXszFbJVEtoB22c+W1r48Mkb+6rX9r3/+MZ5NCiHohFo2wzj
 /YmbDzo
X-Received: by 2002:a05:6a21:4c11:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3c01c65ff4fmr14772604637.14.1783344424235; 
 Mon, 06 Jul 2026 06:27:04 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3114fe08b1bsm17734598eec.26.2026.07.06.06.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 06:27:03 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 tomi.valkeinen@ideasonboard.com, francesco@dolcini.it,
 leonardo.costa@toradex.com, stable@vger.kernel.org
Subject: [PATCH RESEND] drm/bridge: tc358768: Enforce input bus flags via
 atomic_check
Date: Mon,  6 Jul 2026 10:24:17 -0300
Message-ID: <20260706132440.1594239-1-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:20 +0000
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

From: Leonardo Costa <leonardo.costa@toradex.com>

The tc358768 declares static bridge timings requiring pixel data to be
sampled on the positive clock edge.

However, the DRM core default propagation simply copies the output-side
bus flags, coming from the next bridge, connector or panel, to the
input side. If the propagated flags are incompatible with the bridge
ones, the data is wrongly sampled, typically resulting in visual
artifacts on the panel.

Implement the atomic_check hook, replacing the mutually exclusive
mode_fixup, and set the bridge state input bus flags to the ones
required by the tc358768. The sync polarity defaulting previously done
in mode_fixup is carried over into atomic_check unchanged.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 0d85120fcc7a3..0516a331e71ba 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -1262,10 +1262,13 @@ tc358768_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
-static bool tc358768_mode_fixup(struct drm_bridge *bridge,
-				const struct drm_display_mode *mode,
-				struct drm_display_mode *adjusted_mode)
+static int tc358768_bridge_atomic_check(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
 {
+	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+
 	/* Default to positive sync */
 
 	if (!(adjusted_mode->flags &
@@ -1276,13 +1279,15 @@ static bool tc358768_mode_fixup(struct drm_bridge *bridge,
 	      (DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC)))
 		adjusted_mode->flags |= DRM_MODE_FLAG_PVSYNC;
 
-	return true;
+	bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
+
+	return 0;
 }
 
 static const struct drm_bridge_funcs tc358768_bridge_funcs = {
 	.attach = tc358768_bridge_attach,
 	.mode_valid = tc358768_bridge_mode_valid,
-	.mode_fixup = tc358768_mode_fixup,
+	.atomic_check = tc358768_bridge_atomic_check,
 	.atomic_pre_enable = tc358768_bridge_atomic_pre_enable,
 	.atomic_enable = tc358768_bridge_atomic_enable,
 	.atomic_disable = tc358768_bridge_atomic_disable,
