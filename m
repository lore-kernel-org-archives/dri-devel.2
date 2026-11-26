Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30DC606A326
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IpiM3ewU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEB610FCD5;
	Thu, 26 Nov 2026 07:13:31 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BBA10E1FF
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:13:24 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2f04e3bf46dso49551925ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795677204; x=1796282004;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6jLMJNG2/VMi4KMGExC+bNwMaNVFu7tNu9htN+cJ+pg=;
 b=IpiM3ewUjji2O8Dyaa5C5KlYORbFUZEI7ow8ysfgaktQbSX1yjrqMri+HT5xS5wzT+
 zBRK4Ldj1Fq8dpXGdaHE5GXOMvhTt5iFp3ClU+LYQctqO9dwUMv+e/qots/DXLVUmvgx
 KjgUZtUlilYYl/xITO1jZLeYtewC+A+al/5Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795677204; x=1796282004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6jLMJNG2/VMi4KMGExC+bNwMaNVFu7tNu9htN+cJ+pg=;
 b=EctnsTrn4YxLRdwpDu+krA2jP0LTZl0whYK0WW0Cwe7Rgn1MinnKPzIX1gYBEM2Xzq
 NmO1QOKOSYvtB0jvppRQGe2M81M+lE+axOmJciWP5ZH0hCfISWPLCovu1rcyGtuqII35
 8jAmwJi5KjMFiYLHP9ebDfhgWTTRGko/uwZ3JIOZ3DQI2SAGIVptq5+Yr4ghXLkS64xD
 PUcCKgnnA26cMlc0xCQRekGoVn9QZKcWu4S/Vus+ezeVgrccXchLGOYxrqbYnxxPUBdn
 829MU9MlGMCWmDTqscK76UYV4Atp/mjaQqRFD2vbYmFLzY/EkwDeXq6Q2hFrl1+Q2OyQ
 5BDw==
X-Forwarded-Encrypted: i=1;
 AL+hErHjiiAwaptJgOLBZvHrRO3FnDxgRVPjVVoSW9uteixI5QN3DxAed7udYIwjIWCAYjLn9YXz58Pkbfg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9vDRrNFKIRhqg753D0Zy/7/E3YHhaHyRk1QLylEL24NiZTo5m0
 UszslZ5MpYvWh98sdsqFeSoYeqBZCodsAxTBQlCAsYEtrq7YB9b5GZURSwyVsHkVGQ==
X-Gm-Gg: AZFdTZd8DYtvSmzl0VYMKLZPrQrACk7fpl6e1RXUDFSX887tz9dBHblzEm9ch8Bbwrf
 1aoheJ4G5r+vX2ToyMng4AUlFp8R2SAaKskNpojY3yspZPq9vB8XLXzxzHsiFPVetaJv8aooamY
 LToK7wEyjfx8S+BW5/58kKujAd7OBM0cImT/BkUTn0TSz11g9QlXTE0mL47As43j56u42pg7aY/
 ltOVnJBh7JnZfe59iAwVy+uE2X7apQmXI6HzZ/z51HsXQPpVjPMISSPkz1caoHzs8A0wJpSTTVt
 kG292lOQgqxFnTx6jduNiL4SKUBvlRu4eQyfO4gaxAExQWEiMn2K4mkb469a32OWZqL1WL8LsDi
 PSp7TAUaMEIc471loOC+UEGrEiFaw2JNtricIdjCgTtl4j/WM/8GU0yY3z3m2NKYlxaAxFekDmo
 5xxbXg3FvlDQ7gAK/x4weAowd9bNtCdUrf0pdSqX3kgMlf9vBsY+j+eD7SmF6mXZWqXjFBVByun
 ktA7VgK5exEGE2UflLpgfBsG3vGkq5OY4M56me+YKDx7PBLKMwP9BXIMOqrb/w9XDNMr0FlkrgE
 00ZOUCyTqEp45KQY4xwwfrKcryUg56sZXPHQLi6Ru0K/w+05Ox/TXdl14RZi
X-Received: by 2002:a17:902:ef45:b0:2ed:8bce:aa38 with SMTP id
 d9443c01a7336-2f03efb1064mr209959425ad.3.1795677204222; 
 Wed, 25 Nov 2026 23:13:24 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2f03f120016sm99270965ad.58.2026.11.25.23.13.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 23:13:23 -0800 (PST)
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
Subject: [PATCH RFT v4 0/5] drm: Add and use drm_fb_dma_get_gem_clipped_addr()
 helper
Date: Thu, 26 Nov 2026 15:12:48 +0800
Message-ID: <20261126071314.253890-1-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This is v4 of my drm_fb_dma_get_gem_clipped_addr() series.

Changes since v3:
- Expanded drm_fb_dma_get_gem_clipped_addr() kernel-doc to explain clipping
  and added an inline comment highlighting the clipped source coordinates
  (Thomas)
- Collected Reviewed-by tags on patches 1-3 and Tested-by on patch 3
  (Thomas, Jernej)
- Link to v3: https://lore.kernel.org/all/20261124074041.115251-1-wenst@chromium.org/

Changes since v2:
- Changed drm_framebuffer_get_block_offset() offset variable and return
  type to u64, and used mul_u32_u32() to avoid 32-bit overflow (Thomas)
- Link to v2: https://lore.kernel.org/all/20260916033327.3054126-1-wenst@chromium.org/

Changes since v1:
- Added and used new drm_framebuffer_get_block_offset() helper (Thomas)
- Link to v1: https://lore.kernel.org/all/20260908090745.1089143-1-wenst@chromium.org/


This series adds a helper to retrieve the buffer starting address of a
"clipped" framebuffer. This contrasts with drm_fb_dma_get_gem_addr(),
which gives the address of the full buffer.

Some drivers program their hardware with clipped dimensions, so they
should be using the clipped buffer address as well, unless the hardware
can advance the scanout directly. (Side note: many drivers still use
the non-clipped dimensions.)

While at it, also pull out the offset calculation of drm_fb_dma_get_gem_addr()
into a separate helper in drm_framebuffer.[ch], thereby separating
responsibilities.

The sun4i driver was recently incorrectly converted to use the unclipped
drm_fb_dma_get_gem_addr() helper. This broke offsets into subsampled
pixel groups, but also exposed the mismatch between the dimensions used
vs the buffer address. Two other drivers were also touched.


Patch 1 adds a new helper to return the byte offset into a framebuffer
for the start of the pixel block of the given pixel coordinates.

Patch 2 adds the new helper to return the buffer address based on
clipped coordinates.

Patch 3 switches the sun4i driver to the new helper, and fixes the
luma plane buffer address offset for subsampled YUV formats.

Patch 4 converts the imx/dc driver to use the new helper. This fixes a
mismatch between the programmed coordinates and the buffer address.

Patch 5 replaces the open coded buffer address calculation in the
imx/dcss driver with the new helper. Existing behavior, which might be
wrong, is preserved.


Patches 1-3 are reviewed and the sun4i changes (patch 3) have been tested
by Jernej. Please help review and test the imx/dc and imx/dcss changes
(patches 4 and 5), which are only compile tested on my end. The imx/dcss
changes should not have any behavioral difference.

My plan is to merge patches 1-3 in a couple days. Patches 4 and 5 can be
merged after they have been tested.


Thanks
ChenYu

Chen-Yu Tsai (5):
  drm: Split framebuffer pixel offset calculation from
    drm_fb_dma_get_gem_addr()
  drm/fb-dma-helper: Add drm_fb_dma_get_gem_clipped_addr()
  drm/sun4i: layers: Fix VI buffer address for clipped offsets
  drm/imx/dc: plane: Switch to drm_fb_dma_get_gem_clipped_addr()
  drm/imx/dcss: plane: Switch to drm_fb_dma_get_gem_clipped_addr()

 drivers/gpu/drm/drm_fb_dma_helper.c    | 74 ++++++++++++++++----------
 drivers/gpu/drm/drm_framebuffer.c      | 46 ++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-plane.c      |  4 +-
 drivers/gpu/drm/imx/dcss/dcss-plane.c  | 34 +++++-------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 16 +++++-
 include/drm/drm_fb_dma_helper.h        |  4 ++
 include/drm/drm_framebuffer.h          |  3 ++
 8 files changed, 132 insertions(+), 51 deletions(-)

-- 
2.56.1.839.g22a8290db9-goog

