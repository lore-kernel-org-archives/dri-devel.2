Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A1606A893
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PQ+yCv+h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB0DE10E3FF;
	Wed, 11 Nov 2026 22:01:53 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF9E10E208
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 22:01:47 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-6ddef424972so3050634eaf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794434506; x=1795039306; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LOO2h5QK8CfY8Gg/3IS9sOkN8AMCYlWmi2Pn5OTG2Oo=;
 b=PQ+yCv+hSqZCZO7ucUwD/TSplWH1JpjFlDY/Hr8ffST9gL0ZWHFKNdajoviLKBYN8a
 4wwPEtfX7YbKw7asiY+9T8D2a08V4eDbo/q/2WNVNgS+PVut2FWb47SpLri0Zw10yq6n
 wGm7mEx8AmS/cHGCGYADE711gukNd/HyYtsmcs9Um1MI+CwbzA4NnhgIX71ZiKgaZfEv
 bkmiGq/n+u6K1j2JdiIpYiSQ3HizlVeGRXJqHZhqmIDFAshBkIHutDCRRPKSMqTl+2o7
 xyysk5vUYSSEgZCkLon4Tb/ZKxMRHgFOoCyu/PvnsU+YXAJJcPhCe0SGn1un+LSMtpz5
 Nh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794434506; x=1795039306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LOO2h5QK8CfY8Gg/3IS9sOkN8AMCYlWmi2Pn5OTG2Oo=;
 b=JZrIRnr5ZMTTuQm8gaqwlLXgHRxqZNxs9h7oouviCCCFIj8TnTkjD0MRda3gZXocAh
 eaPsc9+0zFVEkLGvIyEqFoks+ESmRxcpC3r+HLyy+tCWLZUOzbci9a0hPke/2CR+7GkI
 5XCHRAB+VxJFg6Gp/aul0vfDrDwU3QIDm0h2AyQnYWfaE9FWddbw+EXbrgeNh0uZmmmh
 S0cSpwfs3EujismtY5VWBfrlOhGlJbr90HlMHPR8/4gvwnNjaCi3UEmkLKRGZXb1iRx3
 coq9Ysi71eWUuHvL+8m3nFmO/NAhDItnCZCUSc8YwvZMKfhNZboLSWTra2FZPUvbLLQA
 xUaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGmMNnYc2Xj3iQovXYBkWzBJXh+tNYsi6v+V3hOjGZ80e3kZi1LW3EIxEtoIT0JwIR2oj2hyXMQF5g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+/p0YViUEPV+NqH2dLAHJw3MRHhyjIRgqFTvBriUy/0cHzLQ2S
 4ClVH6uQxvBc41Or0f3L1dDOZl7KtuWlabYeqL1Ybdr7qMlvtqDIySM2
X-Gm-Gg: AYBFou0jilbDojst+EbZ/O+5lf32YeBgo7U2ky25qBUuGLOT+WAt74jRFi0opTYKX6r
 6LqkVfag/SHgwS4z5ynLVBWu6AcoXAIeeUB+7fxdtH+GD9B6yf3CjC4r8q57dPJnZE2TM0LOyaE
 ZvTG6xprtFEY46femAHKFC3zLi4KGMgEjKe9vY3sn8hDlUgaxYKTE/TOZAQq8migZTLAndRti7e
 AJv0zAVZqMgIEsoYAC9RhnMlUXIA3hLW3H1mPGzR3g7AVvqD4QYHah52eqKqunLJfOmb3d01/jO
 gRZQz6QzL1isWGeVjgbSAzahgQ0KWBACqFYS/VTRHZgaBlJmC8RfMj1egxsm5bFgorWVRtxgi/G
 kI/p9ovKpuJ2fBowMOYuDc5dVMojXpwwFZgzoMOY25AhX3+N+sJpoKBk73uYsDt8/KoZHSzl8/s
 J0k/rc9rRolLIm9c/tyV3Iw9zQFftfAJv4RhRO+QGEvpJiwyptMnysK/SBqUGxlnMFq3F1IHQJm
 yQT9VPqDWnGonv4zDTOcl+gwV0JFQBtfIQy9+GIxe0b0B/yuGi4hbk34MkAvbJCYPyEPcADzGGy
 PL/FTcV8ACQrtdPbQjJkZCPX15vTU2wf5NfxbENxskFbFFidaoRmMH1frZme9nOcQzqqplGvXHR
 qlxN8THTfJwQB6O9FnZ4luN4Fby3kmZFtJkGq27ZAIpatJ1XNeu5IQWhsJKe9ZBl9TPnBTAr/gp
 pJfw==
X-Received: by 2002:a05:6820:1ca8:b0:717:866:abef with SMTP id
 006d021491bc7-7191789058bmr2582841eaf.34.1794434501099; 
 Wed, 11 Nov 2026 14:01:41 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae23095c5csm4206140fac.16.2026.11.11.14.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 14:01:39 -0800 (PST)
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
Subject: [PATCH v2] drm/exynos: fimc: allocate formats as a flexible array
 member
Date: Wed, 11 Nov 2026 14:01:29 -0800
Message-ID: <20261111220129.12128-1-rosenp@gmail.com>
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
referenced through the fimc_context. Make it a flexible array member at
the end of the context and allocate both in one go.

Annotate it with __counted_by(num_formats) so the array accesses can be
bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use devm_kzalloc_flex().
 drivers/gpu/drm/exynos/exynos_drm_fimc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
index 9c2ad95799ee..9233cd3b2f04 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
@@ -99,7 +99,6 @@ struct fimc_context {
 	void		*dma_priv;
 	struct device	*dev;
 	struct exynos_drm_ipp_task	*task;
-	struct exynos_drm_ipp_formats	*formats;
 	unsigned int			num_formats;
 
 	void __iomem	*regs;
@@ -108,6 +107,7 @@ struct fimc_context {
 	struct fimc_scaler	sc;
 	int	id;
 	int	irq;
+	struct exynos_drm_ipp_formats	formats[] __counted_by(num_formats);
 };
 
 static u32 fimc_read(struct fimc_context *ctx, u32 reg)
@@ -1273,19 +1273,16 @@ static int fimc_probe(struct platform_device *pdev)
 	if (exynos_drm_check_fimc_device(dev) != 0)
 		return -ENODEV;
 
-	ctx = devm_kzalloc_obj(dev, *ctx);
+	num_formats = ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_formats);
+	ctx = devm_kzalloc_flex(dev,*ctx, formats, num_formats);
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->num_formats = num_formats;
+	formats = ctx->formats;
 	ctx->dev = dev;
 	ctx->id = of_alias_get_id(dev->of_node, "fimc");
 
-	/* construct formats/limits array */
-	num_formats = ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_formats);
-	formats = devm_kzalloc_objs(dev, *formats, num_formats);
-	if (!formats)
-		return -ENOMEM;
-
 	/* linear formats */
 	if (ctx->id < 3) {
 		limits = fimc_4210_limits_v1;
@@ -1319,9 +1316,6 @@ static int fimc_probe(struct platform_device *pdev)
 		formats[j].num_limits = num_limits;
 	}
 
-	ctx->formats = formats;
-	ctx->num_formats = num_formats;
-
 	/* resource memory */
 	ctx->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ctx->regs))
-- 
2.56.1

