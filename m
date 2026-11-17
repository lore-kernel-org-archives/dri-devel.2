Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB260606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SvLsGhkT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0429E10EBCC;
	Wed, 18 Nov 2026 08:23:24 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132E110E69D
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iI
 GCznXhTjwwAbtISLd9zxt6KkpRGg6tsCKG2gaFg90=; b=SvLsGhkTDPXzAfq3BR
 9/l8k4//D8k9qjpqRh6nqSAT52sbBOOoDZV1S38pDyyER2j/AgTIWZL6jMwOD1sH
 CwstOyXCpV9EwQiVgZB+gbA4YVlyD4r5+KrkJ6Q1pyEtVD/eY55ea0C9I4CINX0I
 7b4hH93gFoHRAHeRsNjYh5mww=
Received: from SYPC (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgCXyQiu4Pxq15exGA--.55935S2;
 Wed, 18 Nov 2026 07:18:07 +0800 (CST)
From: Yang Siyuan <hsyysy@163.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/sun4i: report coverage blending for alpha-capable
 planes
Date: Wed, 18 Nov 2026 07:17:49 +0800
Message-ID: <20261117231751.264258-1-hsyysy@163.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117091932.12063-1-hsyysy@163.com>
References: <20261117091932.12063-1-hsyysy@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgCXyQiu4Pxq15exGA--.55935S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrW8ZFy3Zw1rAw15ZFWUJwb_yoW8Jw18pF
 WrG3Z8G34kGr4av3WfJa47XFy3ua1fGFWrWrnxJ3Z3Aw1DAFy5Gryjk3Wa9FWDJr4Ikw47
 tws8ur9IkFyDC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0GQDUUUUU=
X-CM-SenderInfo: 5kv152r16rljoofrz/xtbC7RA+cmr84LABfwAA3J
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux 7.3 added validate_blend_mode_for_alpha_formats(), which warns once
per plane that exposes a pixel format with an alpha channel but has no
blend mode property.  Neither the DE2+ mixer planes nor the DE1 backend
planes create one.

Both engines blend a layer with its own alpha channel and do not
premultiply, which is the DRM "coverage" equation, so advertise exactly
DRM_MODE_BLEND_COVERAGE and leave the register programming unchanged.

Changes in v2:
- Drop the Fixes: tag.  860e748bddcc only added the generic check; it did
  not change this driver.
- Drop the code comments; they only restated the commit message.
- Handle the DE1 backend planes too, in a separate patch, since they
  expose alpha formats as well and still warned on A10/A20/A31/A33.
- Link to v1: https://lore.kernel.org/dri-devel/20261117091932.12063-1-hsyysy@163.com/

Yang Siyuan (2):
  drm/sun4i: mixer: report coverage blending for alpha-capable planes
  drm/sun4i: backend: report coverage blending for alpha-capable planes

 drivers/gpu/drm/sun4i/sun4i_layer.c    | 7 +++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 7 +++++++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 9 +++++++++
 3 files changed, 23 insertions(+)

base-commit: 091b06388b117fefdcb63336ac09956a4914b961
-- 
2.56.1

