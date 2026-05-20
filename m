Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808C0CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EAB10EFB4;
	Wed, 20 May 2026 09:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MhyGhcEs";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F276810EFB4
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:26:42 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso25251265e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779269201; x=1779874001; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SCjCJBZvnIiFnT2W/ro1v1Aq/+Z3LzD35axaVYH+sU=;
 b=MhyGhcEsA3E3WD8zEb2Yd/5ytoYTDdBuiX/2kAjBhWIo3Uyqop3IQUb+QPsoO5ODLR
 qGtKg+yLX7mp2lSHrWcpAXs6vHsunoBUpTp60vUDQU7bBdgC/SKJdvYNW5bW7C+G6LrJ
 3S7EswQbPK83MOdGyHvPl7GVMs9CbRJsMD2NUgAFzVvUpGrAfNRlA2UUFAATCBucx5Tg
 aEwb1ZoyJga2/b+7ZgEZyizCbDu6g9TfHnAgJ0rkHqUq48oSiJEYHDoHFsfNgWTr6J77
 Ya7FI5NyC6b4FrCiK4Vh407vLn6Jm5KyEtP6ssJH7VkVjSdFOxQnPPEJPlBwyopk1DRP
 GMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779269201; x=1779874001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+SCjCJBZvnIiFnT2W/ro1v1Aq/+Z3LzD35axaVYH+sU=;
 b=abKPRrwSI1j72J90jH8ukNSAiNfC8YIqRxw1UjWYGm677MxnIsKJ8k4hWSSTy75rXA
 HTwb7j929int3QykbfJgpI6yt9PpfDrgZUzo2GFCqWQLx+dazEWXIlVL+cWNXtlhgkWa
 OmrdRS5PwL6fp1OJMYBzZz3NuP8j/v5nEOTko63YSVLzZPlnVCEgPhO8KVHPx9w58I0v
 Lz+gVP/AZCCAWBTXxgP5DQLvmzcDWu6uQCHVH0IhR8y2fyEZ4x75+1/FfGkajHwby1BF
 QVMlhKdedlwUJGH7GAuyGMSZxaCABGB9LDu3M3bgcxC2ZrC2HgJwLlKOM0ZwWvOc2YMH
 mHiQ==
X-Gm-Message-State: AOJu0YxbgMbmOSVwu7CFX1QIu/e+j3RRxmOp93TleqOGmTRy26RJuQln
 0WbXC4MzaA6I/TFoF74v/bEAZr+GQ9IGTSau+oBVcB3dv+YOe1FBYryD
X-Gm-Gg: Acq92OESJ6LLl72Tsbgfmaw0BnczjY7dkbe0bc7pcfhGF1AoC1cmIy4jWRsEnqymi14
 C4MQkjm8aGWX1N5L9Guy+UOrq/sa53rc0LwbPRY45KD87Lz+8YzOsNhPwKxvrwyZedAXcm2dxnp
 M4TrJ2D7M1VXtUeqO6Tpwf/uulqIKIaa8oQZUVLi17dOq6EdlFHVFkH/eR5OSPkTnzqhPSBp6t5
 JAfRtb3V1SXdZpXH2eCzbxVplHI77puOzSj0GW8WiTCodf8ZvcTbIxAsC+M1E2IAXPt4gxyCpch
 JgaqaUQytfLGnigAkHSFITJ78eeuBiqiDQj881dC0tIKVKoYM3GpZyxSh9nNBYrOkYPx4uc7amf
 4qZ48tr+3dQpKuasF5V736sLuWj8UgcDDojO7dieRnzvM/v9sl/w8rS12Kde/2FBJVWPAoiWKw0
 5g8m2eTMPDKECR
X-Received: by 2002:a05:600c:310f:b0:48f:d346:e646 with SMTP id
 5b1f17b1804b1-48fe60d5693mr337098675e9.10.1779269201416; 
 Wed, 20 May 2026 02:26:41 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49031731733sm7960805e9.0.2026.05.20.02.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:26:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] gpu/drm: bridge: tc358768: Add delay after PLL setup
Date: Wed, 20 May 2026 12:26:28 +0300
Message-ID: <20260520092628.47539-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520092628.47539-1-clamor95@gmail.com>
References: <20260520092628.47539-1-clamor95@gmail.com>
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

After tc358768_setup_pll() enables PLL_CKEN and the lock indicator comes
up, the DSI register sequence runs near immediately. On TF700T this
results in the bridge claiming PLL lock but producing no DSI video output:
the panel powers up, the backlight comes on, but the framebuffer is never
scanned out.

Insert a small settling delay between PLL setup and the rest of the
attach.

Suggested-by: Michele Brocco <brocco@perceptos.de>
Tested-by: Michele Brocco <brocco@perceptos.de> # TF700T
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 0f2820b37302..17abb24a7181 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -824,6 +824,9 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 		return;
 	}
 
+	/* Allow the PLL to settle */
+	msleep(20);
+
 	drm_display_mode_to_videomode(mode, &vm);
 
 	dsiclk = priv->dsiclk;
-- 
2.51.0

