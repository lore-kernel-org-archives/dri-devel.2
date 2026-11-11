Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A2606B34B
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CivBytze
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 081D710E208;
	Wed, 11 Nov 2026 22:03:38 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4468B10E208
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 22:03:31 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7f84a55cc06so2176423a34.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794434610; x=1795039410; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sPfQCcrAfCjRkFz6L9qyGHzK9Ch2pW+l+JfxC7qRxyM=;
 b=CivBytzefCwgWKW5ZSE1b17kJ5ujG8Dkuh5aqUCGWxtEQw2FzZD4ldEH02avK2a9t5
 xl6ls6AL+a23PDqqD8iWabY0vFnG+TqqrB5ScWF0UcbE/CkBMuO/DmNm90558R55hjVJ
 L1J0GrdiwE2NVzdWkwnxzMuY/YpTm6Cz0WWve4GNwa/HJuffFX+pn3KbqDONpuHHhasR
 rFSCsG6w38VbgES2KazHAPEw8BMUoXEjHaVxecBBar/0zHAnMtaJOq7qswAYhahA9X1b
 ZALdTjUeiXJhkdS3hqg8Aw+KkM3c3pOUZBL6lvKiNhRhVmvok7oD0/+mTL8vqrd5Tajw
 NPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794434610; x=1795039410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sPfQCcrAfCjRkFz6L9qyGHzK9Ch2pW+l+JfxC7qRxyM=;
 b=bBRM7J3e+sK3j27bgaLq3XMo69ghzeKPvvV9bOz1auPnhwgCUmIyhtTzy3wDXi5yLx
 D4rbdeyMEDFMU81zkQ+AoGszh/7tN5Jx3CCe8Qhd2oB+j+AgNv9LdRyvZCe5S4UooKRJ
 OHYe1Gok7338/AxBsfsCDFowFRkZExx3sdB7/VayzbMYFYXWsq4Lw7pXFV9Q2hS4C83g
 xaB2La6m6CkJdqQjglGYJaOklBYoSm1YCnRMK631rFLg1PojYULDEOGP6l53akbtMRi8
 qGXW2DqRiFRarMO3Bzn0dQhi2Vb+MEuSgb6wBQlCzAPJ5f9glWN1qebpPkVSthqC/YSk
 Pp7Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFvotjjt6NqKCKyXIWc1ijaYGmkZcy7cs3APQINfdBtM806UVrERy97pvI6fTONVzBXXYAcD7T3ZTE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/0/nDSJZ/aB3BKTeMx5r2r+ltaHK9raq1FtoF/jQPhWbiiJlo6
 sX0YkOZUIdCKf3WOIhPYRwxiD+tjPqZ6/RrX66vuvgp86dPx3LEbg8ou
X-Gm-Gg: AYBFou2FDJAUtt9vquwMET4QqmOYv0kOMOGxiXC/oAWiptDNZBb0geFk3ZzqPJFKun3
 HqBqc5NsIHGtbQsduTg8wA1TAv1DA1GVQdCv8oTp+WW57JKO89Sp3c1lfXwgbkd4QPrlGVVyHxY
 D0wx7+eUdAiP4jG6vc/2aRuQRKaVWNP9+zRCbygWcxF+WdrweQ9acGv5s00ZZL7pyqQXZTENV8o
 Tky72m9zjv2H7jrW2fB7b3Sxvjf/KVZkh9xqlxHx6ysx9OuZC1d7UhoptIrRga1LBgQDsBZ+mLc
 R1xx6stFaUSZBb9iX/1zSSlktwR4zbIeyxeSxks1MP7BASS03uxuX7nZSzyyrHVWi+mRbp8RGAd
 iV0BSeVNc4DbZAK1HOYe6KxgrUOScpxQtkKWzwA8DE7kMh38EU7Kwn0vh+GIaecx1Ii5SnRA3Ed
 uTFq+KR5aFvUZ3fQUcxibcXztRtXUdQNFpgvA89X6Il+Ln+JnxGLHvaoG9Zbt5vu6IrRiJG0m5e
 jyeR0Y6/FC/jyDx5VeX5BE+TEkSRJyc0ycCS2Wl58H7XwPF+5RO5b/5zBn2xBQgRpvTG9Va2YkJ
 5aXJSCghhIMf4/YmkQv5SBg1reDsXwoOQwucbilAucww7EEQTN0upmDEuOsW6OVYLW/VYRwgTYr
 zxaYZKrqiB9MfRj+1HVtipvoE/+7BzK7lmIu1r2lmMVouVi1fwQ6Z84c7fo8fhSf3x8rO/xuC4c
 a8
X-Received: by 2002:a05:6830:270b:b0:822:b35a:a2c3 with SMTP id
 46e09a7af769-860f25eafa0mr3652101a34.3.1794434605465; 
 Wed, 11 Nov 2026 14:03:25 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8615518d641sm236715a34.21.2026.11.11.14.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 14:03:24 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>, Kees Cook <kees@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: [PATCH v2] drm/exynos: gsc: allocate formats as a flexible array
 member
Date: Wed, 11 Nov 2026 14:03:08 -0800
Message-ID: <20261111220308.12684-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The formats array is allocated separately with devm_kcalloc() and only
referenced through the gsc_context. Make it a flexible array member at
the end of the context and allocate both in one go.

Annotate it with __counted_by(num_formats) so the array accesses can be
bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use devm_kzalloc_flex()
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 4a07deeb382b..303e94df632a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -99,7 +99,6 @@ struct gsc_context {
 	void		*dma_priv;
 	struct device	*dev;
 	struct exynos_drm_ipp_task	*task;
-	struct exynos_drm_ipp_formats	*formats;
 	unsigned int			num_formats;
 
 	void __iomem	*regs;
@@ -110,6 +109,7 @@ struct gsc_context {
 	int	id;
 	int	irq;
 	bool	rotation;
+	struct exynos_drm_ipp_formats	formats[] __counted_by(num_formats);
 };
 
 /**
@@ -1222,21 +1222,19 @@ static int gsc_probe(struct platform_device *pdev)
 	struct gsc_context *ctx;
 	int num_formats, ret, i, j;
 
-	ctx = devm_kzalloc_obj(dev, *ctx);
+	num_formats = ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_formats);
+	ctx = devm_kzalloc_flex(dev, *ctx, formats, num_formats);
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->num_formats = num_formats;
+	formats = ctx->formats;
+
 	driver_data = device_get_match_data(dev);
 	ctx->dev = dev;
 	ctx->num_clocks = driver_data->num_clocks;
 	ctx->clk_names = driver_data->clk_names;
 
-	/* construct formats/limits array */
-	num_formats = ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_formats);
-	formats = devm_kzalloc_objs(dev, *formats, num_formats);
-	if (!formats)
-		return -ENOMEM;
-
 	/* linear formats */
 	for (i = 0; i < ARRAY_SIZE(gsc_formats); i++) {
 		formats[i].fourcc = gsc_formats[i];
@@ -1256,9 +1254,6 @@ static int gsc_probe(struct platform_device *pdev)
 		formats[j].num_limits = driver_data->num_limits;
 	}
 
-	ctx->formats = formats;
-	ctx->num_formats = num_formats;
-
 	/* clock control */
 	for (i = 0; i < ctx->num_clocks; i++) {
 		ctx->clocks[i] = devm_clk_get(dev, ctx->clk_names[i]);
-- 
2.56.1

