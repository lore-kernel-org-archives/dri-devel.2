Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60DC606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=S7nOgFqX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5331C10EEDA;
	Tue, 24 Nov 2026 07:41:00 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3136710EED1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:40:54 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cde5a7d7849so1785399a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 23:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795506054; x=1796110854;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yq9KtC/Vr6jX4nQrqLEI9ETBwLEZhdEPTg6w69t4M3Q=;
 b=S7nOgFqXQ37SL1wTzHrhLtyTC/RqMByrQJxZoHo3m5rKR3+cFupWkmKc6xRO2ajbq9
 jXstd46kgZownoA7eOnC/0ncx38VYlnjywrbCZdS/FraMeqNBCxyFh+ogQxeSFp0zq1Q
 b5LaNiQ+0KUARC7+wfgRO8tEMFccl5tr0oyc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795506054; x=1796110854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yq9KtC/Vr6jX4nQrqLEI9ETBwLEZhdEPTg6w69t4M3Q=;
 b=N2uRlBWks9wgRcqcWD1ndlybWWSN2toC8Bskiu88s0n6yRiuHoZT+gWCmLgozsa9SJ
 5cdPr/u+kWQ6IJr+gSDF1/jVWO8wqG0++PHqULqk00c6cG2c5eVUSUuiqxKY3mAV/abM
 ZwvA1qhR537iVHxsjaHrjI5c7VrRqc6vQWbK9kyhS5JRqK2ADJj/xbTmSwB6ePMWKdU3
 sE4DNNr8aT8tz06dQO5KHrOW0RPKEd15OQngnxYCSN1ohRpMXZMyaFM5zaghAx4macth
 BV6MQ4UiIzQNngq7phJAoLCFl1TPXkG/6N8B9bAFUl8K8ZtnaltjhX++Dw6oJKztwZRE
 6dKA==
X-Forwarded-Encrypted: i=1;
 AL+hErF3W6LvRohHmHQtNUspkhqBiG6EqTGDSOGo+bz4axYBlJIAwcyA+LM012fL0ZzewpRpPOWi0p1O3X0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+70lLywDNvN8JyYsO5zEIZYOJDOwk8vwaBXlvcmhogTkB8gC5o
 JLTOCmlykYxjVHEXeCMEn9KceYOy3nqqWzR6GV10Pcfc6KcPvapNz4inXswo5Eaagw==
X-Gm-Gg: AZFdTZeGY8bCbccaJgiPfbj0BSZ2YpqHPXp0y6G7HzChbSW603T4VlA3ai1k5m8ZS1p
 xTyk9j9v77QP+PItP2fs/+xtvsLmmVlaAkj0BJ+sfrYOpEfkxRyLD7ZX+et/9QwF786Gw3aX4DK
 cZBNR+ATug2JTPigUrQujygvF28zMmLmWtkI1lB6L4saO/aV8MDC0l0U8Qpfw1vO/LSeqP7McPu
 RWN/VD0K29oJaIa4NMbekXeqs2rq3DAl6D1usmK6wCPZEJMbv34PMgxpGV+JhHo88FqhrKoagfZ
 cDD+hqRikFYfmidkb9kWaxQYTR7lFQV4ws+MG7Oy5M5MJ43A7XYqcgjS3vkfpyfTE/kpdEkVQ7+
 LAjqM+zhW3vWuLVpo2M3X1pgJu/b469cTo3KXLloAkBlgq5GpjbJKoDJ8imn9iHW5fBw9FzygfO
 L8KLPPc3LlwG9tT/hrKAagSpCnl7mpGyHdxATxsNzL1PgLfA7OvdfcYaTGFUnOiOTXbrjPBzH5N
 an4iaDmJAyfrFEUfX7pudW1NIaq+m5pJgIvp7iX5dJBibNZqImLsV8i9zsEXq/xEsmo4BMrYq3j
 smui5zGkNKRY/Wml3zrmPP09p4ieOE0o1R3m8MeJXaxMdpfJbBSDVWLl2noD
X-Received: by 2002:a17:90b:5289:b0:3b3:8094:321d with SMTP id
 98e67ed59e1d1-3b41c9080bamr13617140a91.32.1795506053661; 
 Mon, 23 Nov 2026 23:40:53 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:8f32:8910:4727:ea03])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-cde84cd5ed8sm3771777a12.10.2026.11.23.23.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 23:40:53 -0800 (PST)
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
Subject: [PATCH RFT v3 0/5] drm: Add and use drm_fb_dma_get_gem_clipped_addr()
 helper
Date: Tue, 24 Nov 2026 15:39:28 +0800
Message-ID: <20261124074041.115251-1-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
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

This is v3 of my drm_fb_dma_get_gem_clipped_addr() series.

Changes since v2:
- Change drm_framebuffer_get_block_offset() offset variable and return
  type to u64, and use mul_u32_u32() to avoid 32-bit overflow (Thomas)

Changes since v1:
- Add and use new drm_framebuffer_get_block_offset() helper (Thomas)


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


Please help test. The series is only compile tested on my end. The sun4i
changes should revert its behavior to before the drm_fb_dma_get_gem_addr()
helper was adopted. The imx/dcss changes should not have any behavioral
difference.


Thanks
ChenYu

Chen-Yu Tsai (5):
  drm: Split framebuffer pixel offset calculation from
    drm_fb_dma_get_gem_addr()
  drm/fb-dma-helper: Add drm_fb_dma_get_gem_clipped_addr()
  drm/sun4i: layers: Fix VI buffer address for clipped offsets
  drm/imx/dc: plane: Switch to drm_fb_dma_get_gem_clipped_addr()
  drm/imx/dcss: plane: Switch to drm_fb_dma_get_gem_clipped_addr()

 drivers/gpu/drm/drm_fb_dma_helper.c    | 61 ++++++++++++++------------
 drivers/gpu/drm/drm_framebuffer.c      | 46 +++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-plane.c      |  4 +-
 drivers/gpu/drm/imx/dcss/dcss-plane.c  | 34 ++++++--------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 16 ++++++-
 include/drm/drm_fb_dma_helper.h        |  4 ++
 include/drm/drm_framebuffer.h          |  3 ++
 8 files changed, 119 insertions(+), 51 deletions(-)

-- 
2.56.1.809.ga0b61035b5-goog

