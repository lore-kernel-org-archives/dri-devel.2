Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13863C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1669B10F411;
	Thu,  9 Jul 2026 07:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mEtkk92W";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634FD10E370
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:00:37 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8479f1a86ecso1878097b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783335637; x=1783940437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n0i9VdK/Ma3gHZKckXQb+1T7ww2+Cb/2KCUzwQQKXZo=;
 b=mEtkk92WdLBlIGJC5aQpSg2weLuQxVnKZggEmB+iTpfjbERRQvTlMG6u6IDGsT1vLN
 o5Of7D5aBphWhs4IbBewHOPcFKsO2ngdQBiZDQNhVWu9wkC1uxyfmPKpRaeh/EYG7iKd
 mAgYG9QAFrGlj6BaUDRWA/Z/RKR+SZtONCx5wgDVopv1UXkxovHOyFb2Og/t29gE+TmR
 SPjwBjFHYdkgJzXUlbB16ajCMYO2IDg4rvfWLtC85VLQnvUptmqa22I5xlxnzT3Brm7U
 s43iwGImlotk3RBcjgfyzZFpgVzKdI7CGZsFg633S++ul0M/yZyaTXEcLNk0Wf9QUZ87
 Cl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783335637; x=1783940437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n0i9VdK/Ma3gHZKckXQb+1T7ww2+Cb/2KCUzwQQKXZo=;
 b=XJ0QEvoxUO/gPOaBvaPQXXpX1fq3rMD66NuXn8wUt8jM1OtpDYLrBCUrzMXWp+HGil
 x7XgU+qDGHvEKpvIw3F9OhuHkFul/0+6ZmzoYgdzRAeugu8/XBVKIMN+e9QixM6iKo0u
 KLJSY4nYxOQ+U8QMXJfTg6KjEV0K3gn+JkGAuPNwjgAh4mWrhscnrxPqEPsQk/G1Cw8J
 6XKka3G2KHK6Yco1GglTD4fgOqfN4jOoE3/H2TSVEHDfzi4WfrOgv2xTGaJa7AtBMk+H
 v6Ad9JrCmGagbBeJAdsy7Pr25zWnxJOjmwsb7ylgR9TiDliD+BYl0GExV+ySh323UsEG
 qH7w==
X-Gm-Message-State: AOJu0YyudsoSwh7/aB8Nqpdv28rFhCbFufZfVMYgQwjBYEg0jmhCg6u3
 gkfF+75ngvJHwoXvoUZvFfyfkkFfNxz5R54DYF3TEgW6RuR9EU7AbPQF
X-Gm-Gg: AfdE7ckdlg3vp6VwHYcPZ55ogM7f5oaPl/0qLPLW3ZhB339aZUSZ3c+lmr0pfZj3Y2B
 y/sjDpMCnkgvSx76/ncjiDPWxY9zrDMFhe/lS9WRidkp2pYJ5urcryq6Qu3bo1m2vVUm6y2EVLW
 lYfbAuPZpVp8tpSmR+7EZ3wOaEeUG6euwr5iuLEv4f5SFpX9JWJ6nOyFLtOd7hgunm12RQ/no5c
 gh8EoGqte8aHMgwvrYExvro7fYRLxTjEc/QncOx4NNCVvpaMXRra7okw0n5wqOWGo5w3UX1w/9v
 yVrpn4spY6t0pExmT8uaCdVEHukmmIFWg9/npRzNwkQtn1E3cy3qbn60wz94kVAM3jbKexRBK4U
 n1Q33GEtD6gDv6BNx1v0lr2yGewsoJWYuqLTPfAjRf9TGA5CJQQzGG1HDVR94RimydgFrtq/XEP
 MUgeFXeRLTM47o7h+9/blUIk5KZZnvLe0GPbmPf7UqmZrdFt8vHdW8AkHerA+2Lc1EIFLn5D+Vf
 Mn3XRNN
X-Received: by 2002:a05:6a21:2d46:b0:3b3:1b38:d9d6 with SMTP id
 adf61e73a8af0-3c08ee3658cmr63419637.39.1783335636463; 
 Mon, 06 Jul 2026 04:00:36 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7ef728sm47797381c88.3.2026.07.06.04.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 04:00:36 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 tomi.valkeinen@ideasonboard.com, francesco@dolcini.it,
 leonardo.costa@toradex.com, stable@vger.kernel.org
Subject: [PATCH] drm/bridge: tc358768: Enforce input bus flags via atomic_check
Date: Mon,  6 Jul 2026 07:57:45 -0300
Message-ID: <20260706105840.1582166-1-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106141227.899054-6-s-jain1@ti.com>
References: <20251106141227.899054-6-s-jain1@ti.com>
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
