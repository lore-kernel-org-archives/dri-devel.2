Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AFA606D80F
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TO0kA5Po
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6C4112C78;
	Fri,  6 Nov 2026 09:19:18 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9920F10E02F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:07:33 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cc7e79c1eaaso840471a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 00:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793866053; x=1794470853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nPodO5AP64Dsdsqfhq9Y2o6KomJ/G83kxL2GrW1whbI=;
 b=TO0kA5PoBSCKwX7SHe304y32fqVaAZxFxRKlRdzAJvtp9EoJLGmJtcN+ZZak7BLhjU
 lWrq7JjMUDYNIeNWYcUKGfckMFf1N9kIDNNfw+cghsrweUJdW7SEOF6GP8bRa6aLE2Ak
 Gcz4+75zVPh4l5A+ugyd02Y3cpyBSBfDLdZn19dY+t5/MwBDwv5EFNayPoJqpx+kR7UH
 ri4+rAl/MlTPIWDdjU54jfiiqwod6pbXuODpmANbWmDqsRXpFg7PbGYRpcsCBYPmo4WP
 T4yeiIw1467GuiU70LSWY/GiGU+AKBdpqo78M/PQDOUQIvu9TTnXhoEMiRJg4aGM3ARg
 2ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793866053; x=1794470853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nPodO5AP64Dsdsqfhq9Y2o6KomJ/G83kxL2GrW1whbI=;
 b=u1QKOF1ccEFx+X7F0LqNEH9hu099I1EZd92OlUA0Eh0L8QShBm9MqOrYuqsg0piDy6
 W7oBX102mHDYsZ4YAnBtHwoTcm5YZ9HPfISq701fdLDGEmI/HI0QSa4ay8U8JN5YMMGj
 jtc8FKd2yBmqckolJq4ICWLjcNvrLDMA5jl4vzL9nWcJkVjGZ/XwM3q9WQzAWeYuNvb8
 DhzfJFE4zozb5lRROS5B2fqjNVTzhsG0QHsfmFj2mAWoaOvDdZLrXkfvlGywwsEp5Fhl
 6ovSDsQMAKja7osSbWujcjfu78Bk/hQljQL7s2GjtXqOFbCyfa/gD5+Sf815fdIsTKSF
 mIIQ==
X-Gm-Message-State: APuU4Z98fAibjSwpBsjI59U+ugB7aKPbxa0tGUEZwtda3/ymtFJlKrmt
 XYoLyUupZu3V3KfsBbbfZHtnIiL3DV2WB0rxuCWzZi6WjfrnADf859tuDTBiz80=
X-Gm-Gg: AYBFou0U6kAdM9Jt1tqWR7HFzA1JvHO6obEvb3zXLT7aDDFx9j96wuTiuU6hQ0Gcb0M
 k3NIw87DL0Ije6KRs2CDkDqUvvfNKu4l/ByqzXfBBoneelpEJODOENNYASJIN2wD6P0M61TzOv7
 tHgGChL3pR/1IDfXj4qxu4XtVizFzh4Ol5ZuYK0pMg0scy6jeEh28hcq3O9zggjeW0Le+NXRu+q
 L/QQt6pG+W4GNS3dy+jmuRG0LpUqKgPI6kFRXXni0TQuREj64UtGjqtbF+a4qKeyOmA2mnXVoxA
 /374vOidu2xXUNnCXgIjzXSOTbKkY8hlGE5URDWvT9f9LWk1fuRu1MT1JWZL+3sMxez/c5RvIu4
 4awfJ7lyI1AOcQpFUAHx6Qhb/qzVZeRlXJslfF6PBuGq84P/qcqDVmBKN9AAMYXMZCXXgORMOao
 dlZOZcwOpadI7hKWYP2QbkloAPmnGrz5jr1HeFEWEmBoOMQ4wYFku6ZYydMtrK4eCBdMRPm7dQE
 MU9unJYkAVAckkNUms5eobLWDLBq7blxJz0U9FSqakdx1L5ZTmUkDLmWm1/m0O9Yy2oWyiiQBVm
 b6WY8YH/FtYW5SetNOoHQ/C6BC9M+1I7IVwrMo+oT48W6JHfk9QXBPZF3g==
X-Received: by 2002:a17:90b:3bd0:b0:3b0:ad59:7199 with SMTP id
 98e67ed59e1d1-3b0ad59732fmr2113248a91.32.1793866053007; 
 Thu, 05 Nov 2026 00:07:33 -0800 (PST)
Received: from localhost.localdomain ([202.51.247.22])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b3163383sm2689684a91.7.2026.11.05.00.07.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 00:07:32 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Yige Jiang <yigejiang86@gmail.com>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] drm/exynos: dpi: release the node after looking up the panel
Date: Thu,  5 Nov 2026 16:07:24 +0800
Message-ID: <rc-review-20261105-14-00955ac4adbd@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260916072012.1967169-1-vulab@iscas.ac.cn>
References: <20260916072012.1967169-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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

exynos_dpi_parse_dt() acquires the remote panel node. The posted
display-timings fix releases it on that branch, but the panel lookup
path still retains it on success and failure, including deferred
probe. of_drm_find_panel() does not consume the node reference.

Put the node immediately after the lookup and clear the unused
pointer. This covers both lookup outcomes while leaving the
separate panel reference and its existing remove-time put unchanged.

Fixes: 14b6873a0198 ("drm/exynos: restore parallel output interface support")
Link: https://patchwork.kernel.org/series/1166158/
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261102 (2637bdec0535).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_OF_DYNAMIC=y.
COMPILE_TEST=y.
Baseline and patched target objects built from this exact base.
No full kernel/module-link, hardware or runtime test was performed.
AI assistance was used for analysis and patch preparation.

This is an incremental patch based on the following posted fixes:
  [PATCH 10/20] drm/exynos: dpi: Fix OF node leak in exynos_dpi_parse_dt()
  <20260916072012.1967169-1-vulab@iscas.ac.cn>

 drivers/gpu/drm/exynos/exynos_drm_dpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 92e8bbe9d35b..e98a9be0a705 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -243,6 +243,8 @@ struct drm_encoder *exynos_dpi_probe(struct device *dev)
 
 	if (ctx->panel_node) {
 		ctx->panel = of_drm_find_panel(ctx->panel_node);
+		of_node_put(ctx->panel_node);
+		ctx->panel_node = NULL;
 		if (IS_ERR(ctx->panel))
 			return ERR_CAST(ctx->panel);
 	}

base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
prerequisite-patch-id: 8f90819fd9f71f55560dc3af57c5a0bad07bc568
