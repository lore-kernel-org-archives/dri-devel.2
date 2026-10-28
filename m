Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196E606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=C5W7MAC4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166A110E07B;
	Wed, 28 Oct 2026 13:18:36 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1093510E3C3
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 13:18:30 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c4301e334ceso72569466b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793193508; x=1793798308;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fJDTYkE2YZ8PG/A+DXCn/A9p4GFLWYNYpfuX/w3z+V0=;
 b=C5W7MAC4I3Nk/kOyK0o7SieSPiLGFNPnqBr4/OvHGXr7Qylj6iza5SX2tG7AiZkrpL
 HfR/joonWz3eZO2tKZgE/m6ElAuqJtcfCf+qxIL/ib/X/fpJu1UBSlxnE1Ep/u6/fIjN
 CK0Flq2jgw3UYT1u9Vlc5zJKisPBC7AbDDKQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793193508; x=1793798308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fJDTYkE2YZ8PG/A+DXCn/A9p4GFLWYNYpfuX/w3z+V0=;
 b=AsQ9XLNZF+HnV5aaVPFUi6YjRzlBNmeRLV7V7KRrO+GMrC7MiiEErs4OGHizfNR3mw
 fL5JxohL5NqVNFcNf/E29673aLgtDEwidnJhsN0bOBbZ4ZFkbRllsdDoE6thY7qH+r73
 gsrCogsRWMUjrVDA4YkhTYDfdBVe9xgCZTcj0AF48QboYnQpRRKvtNCncA/Dhm/A+udO
 PnnASFnKtS+4oAtCaw9zrQOs8jYKkONIxC83G1X+Nxl4M4Y2oT1cs75CBkOouWUEGMBH
 X1DqQFYZlNImS5VIstaj7455OutT0Ja4qqX3CnaMUdYMB9TcA+EJ2x9AO6cclJxro0M7
 8gTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz209mm9gMi2gGAALN9XDp8YvXnRCceBWC9qsJoNgkif152Oku4lL6fZroGDUd8xHMnYLQOE18kmwI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ9NHOzIgKWsL6ziun/wfl0G8I5hl5/osvLbxKBYqELWLITYtX7
 MLQ75WSBTqVO3KYbgsNDZFh7v3IKysmynWDvI/v7cEYdehp1rfkdGf6S+visCAK2+CU=
X-Gm-Gg: AYBFou0WM+6m2BlQSoXKW9bapYmmwADRkj31lA2m+I0W9ScFuZgvjUbnJWfjgJHUwf+
 QiWPnCpR/OV3I8V3a5qhG70qcaGiCpKDIJ5KlkAqypMp5LbWe1SgkqrqM5dkGw7My4M07Wl0DHo
 VAsLAG+GFb40wri7cquXx6MrNznsfv6xAEaNLZjKy0RUgXk26IAUbiUdtHKj33CwRMI89PPoQdP
 jNk2G9R7JjNcg/GdfJPv+DNWcdUd862iXsxwShloo6i+1R0y/E1D1EVqAlUcDLi/OEQI8UaQQHL
 S/Om4PfM+rdVWjvtCFXLU5sBv60BdfBJQPb7oQYWQ/haOnfKJHFUtZMeaoTyNohNtbchGsWViw5
 hgo8s8i6TNZoQCOVsOMLZcz7yrMZN7YAcf8CrLo7oVKIKIrL5TRgAuC460ocOTZyV9G6/VAEXr8
 p2qqSDP0YEENzQO1dkRI6Eec5D4Lsioslj0N8Hy/Nt7Grcjg01+RxjvHn33/K+tojiOS7OsVdQ+
 YOrwNuYD+urqK/mKnLDrxuIzvOMtVQ5mdP3tuDUEFDXau2Y6zQkUrhTly6teXpaEqwd9ExvWLYK
 msOUb1EeB2cQPH3OHhYEtzTgSAfsm3nGtSsn+b16ocwQl16wKgj2jnakLGR1gzXkmeU6Pv8EMru
 /sp0r8OfxvAA7YInj6SPBfOyS1eJAjnV4NMZsFyZJSHPYS4cM
X-Received: by 2002:a17:907:80d:b0:c45:b99:f282 with SMTP id
 a640c23a62f3a-c49bdda6ee2mr203173666b.7.1793193508300; 
 Wed, 28 Oct 2026 06:18:28 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.42.39])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650a56sm602252766b.50.2026.10.28.06.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:18:27 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Daniel Stone <daniels@collabora.com>, David Airlie <airlied@gmail.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Maxime Ripard <mripard@kernel.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] drm/stm: ltdc: create blend mode property
Date: Wed, 28 Oct 2026 14:18:18 +0100
Message-ID: <20261028131823.2649142-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After commit 860e748bddcc ("drm: ensure blend mode supported if pixel
format with alpha exposed") we get warnings at boot:

stm32-display 48010000.display-controller: [drm] [PLANE:37:plane-0] pixel format with alpha exposed but blend mode not setup. Please fix.

The LTDC blends the pixel formats with alpha by straight alpha, the
only mode implemented in the driver. Create the blend mode property
with DRM_MODE_BLEND_COVERAGE only.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/gpu/drm/stm/ltdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 5311e0b3e8dc..3b6e680c1c61 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1642,6 +1642,7 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 	drm_plane_helper_add(plane, &ltdc_plane_helper_funcs);
 
 	drm_plane_create_alpha_property(plane);
+	drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_COVERAGE));
 
 	drm_dbg_driver(plane->dev, "plane:%d created\n", plane->base.id);
 
---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
branch: stm32-ltdc-blend-mode

-- 
2.43.0

