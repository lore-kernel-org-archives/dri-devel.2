Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFFBC44523
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 23:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DE810E61C;
	Sat, 18 Jul 2026 23:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DpsiuwSB";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9403E10E60E
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 23:36:28 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-495590dde14so1122095e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784417787; x=1785022587; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3qoMRiXvV6BHSei+lkJBYDW1cqZXXpht0BCmlOitIE4=;
 b=DpsiuwSBPe6yuL4Q++55EBBCgbCi5kKaFHN9D9ax+MnRZue/vFf6BPdVromtxnTm1N
 SpHlCNodqZYd0pQjXldixZy1W32n8DWSfs8M5DiEm2IseR/Loq/5uZ6lLG+sUWo/J9Ax
 ccSjvKjQ+/a6AyoXP+r/6MYVaN7wmUfS+FJFtDNU8fhCB2L/M76exWZjCNpjnFuvi4Rj
 4FwoBUk7Pc4XcAWYAy7dOMXge4r57eQXQLOdCbXI2VNyuahBbGer08nURWXQHjyPMhMk
 hc6bNhouIlCv2ndaJ4XtHaKMOZJ2LjOY9v67LA45SUDqoJnB50BN0IjppEZmWXRktbkc
 KlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784417787; x=1785022587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3qoMRiXvV6BHSei+lkJBYDW1cqZXXpht0BCmlOitIE4=;
 b=ajMq2aJVt/o/89mIjkVNssv+fzGnyPNitaUYBqht0Lre0dn0eKGftu7diS2WR8ApA+
 /GJjzccpc1zgfy067kXH1AkcURAIkrWQKlg2tnzZjO0b6sVE9bDWtt8aokncXJuTLKVT
 GtjhevM9tDAkREVH413heFMmojSg8VuESBcCfr7R5vSV7Ckplo9WpC3mgsrH6KitUrsC
 fZtPjcu9W3z/j3TSRNqLmJbCBt1nAkNcpfPvwLhdEalDiKOV40+MBvJQnpaPuO2DbmaS
 0BM1MZtyDGdu8TwTXN6L+eOgss8WbvEAtjZNRU+Eti/ncwaYFImJq+cn3P7FKxFLHkHr
 O1sQ==
X-Gm-Message-State: AOJu0YxmgM/ooBIO0wxftAbYbQU0ldRlg7ApZixEPXmnPNoJmcnLLpTL
 jTNpVLXP66568t2GWtsvfJaJoB9JJIb4x7cb+GiinVFSP7VcH6+qYvY0
X-Gm-Gg: AfdE7clWCBbOvzh1j/znKzQySb5uPJOXBLRay6uapAAj5+sT59VNFMEHS7z+U0UEIc5
 4itK7D8bJZYJMYWJ9ClZil+OaEG/2Pr3/7wG/J8+H6r/7OXiPO4CrBqlU7s2m83RXqbS/9TiJ3D
 BN5PdkTmBy+ovolwd0HPKypTrTiTOUSWIo/e4hZ4usxrTsgc9Cmm/q9GeEju1ADIgNcMmE3O9Cf
 9E7peNpj2O8XqMbTDymYW/xWKwy2ylwkN032nNHjzVNYdi8JCNfm7AXl91TxmXOC42/cYwdCuvg
 sDOcU/Omzixy8435DvQTIzCTD0Hiq6Hi2Vgli1WA7w85ptocCEwaMc5BvpDWLAGj6+v8SBKhr82
 SSrttakIy3u+ws9doH+RWlfX0o5LuiHpXIir84YzFdNd6+lGlVJJV3f7QTr1L+zBPh523WA4TGD
 RwbGhUXG+ArJgMPpyrtCrc
X-Received: by 2002:a05:600c:a42:b0:493:e983:806e with SMTP id
 5b1f17b1804b1-4954a3ee98emr95800615e9.3.1784417786829; 
 Sat, 18 Jul 2026 16:36:26 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:645b:9e5c:7fe3:c09f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a24b6sm160964675e9.3.2026.07.18.16.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 16:36:26 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 19 Jul 2026 01:35:39 +0200
Subject: [PATCH 08/15] drm/imx: remove dependency on DRM simple helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-drm_simple_encoder_init-v1-8-a78c509e3062@gmail.com>
References: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
In-Reply-To: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
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

The simple KMS helpers are deprecated because they only add an
intermediate layer between drivers and atomic modesetting.

Open-code drm_simple_encoder_init() by calling drm_encoder_init()
directly and providing driver-local drm_encoder_funcs.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/imx/dc/dc-kms.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-kms.c b/drivers/gpu/drm/imx/dc/dc-kms.c
index 0f8cfaf4c4d1..a9adcfc68b84 100644
--- a/drivers/gpu/drm/imx/dc/dc-kms.c
+++ b/drivers/gpu/drm/imx/dc/dc-kms.c
@@ -17,7 +17,6 @@
 #include <drm/drm_mode_config.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 
 #include "dc-de.h"
@@ -30,6 +29,10 @@ static const struct drm_mode_config_funcs dc_drm_mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
+static const struct drm_encoder_funcs dc_kms_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int dc_kms_init_encoder_per_crtc(struct dc_drm_device *dc_drm,
 					int crtc_index)
 {
@@ -55,7 +58,8 @@ static int dc_kms_init_encoder_per_crtc(struct dc_drm_device *dc_drm,
 	}
 
 	encoder = &dc_drm->encoder[crtc_index];
-	ret = drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_NONE);
+	ret = drm_encoder_init(drm, encoder, &dc_kms_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret) {
 		dev_err(dev, "failed to initialize encoder for CRTC%u: %d\n",
 			crtc->index, ret);

-- 
2.54.0

