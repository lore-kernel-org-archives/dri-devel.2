Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C347C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D36910E9A1;
	Mon, 20 Jul 2026 15:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VsUDMwDH";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36CF710E99A
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:41:45 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so7476801f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784562103; x=1785166903; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=77r3PWO7yo5+W5LQS9FlqiYUpbSGXMMaR8d5GZmSOF4=;
 b=VsUDMwDHMFbW1+fHpxCa8ecdzQZCqqzA4jhfRoV7zAvws8gMlxccH2B2lSYRg5cnuv
 DqgjgUjZcXnSh5uAbkdpLIeeUeWe2XNvwcjF3SIBixYlakE8VsZDaZPVYnnrr5G6B34X
 +ApzuXYmMpTZs//D5YjKOVinDi3vCR9vU1yU/mj3TWT4gbc42824nb5qstSbsxdY9fTb
 qN4QPy0kZPXjl1yKcNaOp8HQZIrmMMcxia6ovdqlRdyHXCNdxzGGQdtcRT8yLSYO1A6D
 ccjTxeesG09Rz+cVKh96urQZR3CTqGIidJZIiACgJyWYodwrDGPn8pLTlpeRi+C584F0
 D3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562103; x=1785166903;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=77r3PWO7yo5+W5LQS9FlqiYUpbSGXMMaR8d5GZmSOF4=;
 b=j+FzeB/K3YLmUL7uqjfe6mGINc7winNvsdBjiol9NKtM1IldAkHP6ZqrvrzwPfw2uk
 GzkxEPWVEWwS8ouhbXB/94GkfosrBkHDyYJHGJMujc6hgLphf6bpefLalOlsCTNRQ5ie
 XEmH1tncBJfBhMqmmKkUuypOiVUorsF/HUmLxyO0R5qLXR4ADrTxGBNltP488YP5Nfta
 BiRhUBOdexEBhhbOxrcmJgF5NHRz6EgwoJASDebEcBwWezdhvkqq7acHZYQSoIe736ED
 qIjaHG7BpBAqzNkikUc84q3EFq4wfKXrooM9my87PTXdKhpl4FBYa9uFLY3w7SPBkS0g
 9lMA==
X-Gm-Message-State: AOJu0YyINv8QvJ0KkguHa5W7a1zQ2MHdXomN6EHZ8/g6Ie+QgfixhD2d
 qf93SksV37Wehdq57+mU4Upwq+W8QgAtjEJ84ZDK8f8J9WrEssvjRDEE
X-Gm-Gg: AR+sD13C8O2A2w4rrstV2NjVMaqC2OZ12sfloDAevYh/YDQd252SvdNmxc9EJaS5KIZ
 vSwOZpF3Ihm6jBRTWbH4UlRddBI40VydFR0d5Y9XxwzMUlwch5g9Bviaomg4xbInYE10ZkWClBo
 0zoohJxcUv2nRWnzbk1el8bncUjlStYuh4ntBvSo727gxrV4J3EhwY0ewAylINmNyVqZng7ohM6
 JE8Jm21aUgJfwBTOmQAGsKhbxvqnxiPwuLgepOHrYt1bOmLAZ4KXqC7Ou+hweS7VZvP0RAXIGg6
 yar98GAbYLXL85UKJDPFkAjGBT1PqITfonoiXLx55FqSnfg7lRLa1SjylzxrLAeBPJPZqufMHvO
 tsRgZm43J+dghCRqPrWmQ3yNzvTo+IZQpl67wzlrTcZmsDHLj/b94WWEA/dGKcm5KTAtv2aOJcE
 2Xi5NGZ0PGLg==
X-Received: by 2002:a5d:584f:0:b0:47f:6d57:5a93 with SMTP id
 ffacd0b85a97d-47f6d575ccbmr10955450f8f.38.1784562103442; 
 Mon, 20 Jul 2026 08:41:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:41:42 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:47 +0200
Subject: [PATCH v2 15/15] Documentation/gpu: remove completed
 drm_simple_encoder_init() todo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-15-5020b630668a@gmail.com>
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
In-Reply-To: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Stefan Agner <stefan@agner.ch>, 
 Alison Wang <alison.wang@nxp.com>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Xinliang Liu <xinliang.liu@linaro.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-doc@vger.kernel.org, Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.15.2
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

All drm_simple_encoder_init() users have been removed, so drop the
completed todo item.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 Documentation/gpu/todo.rst | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 14cf37590fc7..b7351467dc74 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -29,21 +29,6 @@ refactorings already and are an expert in the specific area
 Subsystem-wide refactorings
 ===========================
 
-Open-code drm_simple_encoder_init()
------------------------------------
-
-The helper drm_simple_encoder_init() was supposed to simplify encoder
-initialization. Instead it only added an intermediate layer between atomic
-modesetting and the DRM driver.
-
-The task here is to remove drm_simple_encoder_init(). Search for a driver
-that calls drm_simple_encoder_init() and inline the helper. The driver will
-also need its own instance of drm_encoder_funcs.
-
-Contact: Thomas Zimmermann, respective driver maintainer
-
-Level: Easy
-
 Replace struct drm_simple_display_pipe with regular atomic helpers
 ------------------------------------------------------------------
 

-- 
2.54.0

