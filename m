Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF603606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JR4mHy9h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AA5010FA4F;
	Wed, 11 Nov 2026 09:37:18 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C5910F9EB
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:17:46 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-36fc0a3fe93so5832473eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 01:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794388665; x=1794993465; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aPNp2WgpgPHRfZu0DFCm+CGOWcM+7olBPXi5wHu617Q=;
 b=JR4mHy9hoMQM3B50NMnum89AWFpJn5eoXljZdCNIYCTB8a2nlv7X8CYT4m4PG27xJ6
 dI9kCmiz58G7fYOZC7AL19lxfcjnGX88Atq70mjBNnMVCvV5oUHG51gKc4nomg/ad+ew
 m2Z3gKdBB2JCk01pOZtmVXl/OldYfflrYiCDff63ExtiuDpq1UE5FyP1FnTipdG+N0mu
 s5wgRAf61ganD9DoTcl4ICK6GCGGsZq/P9vs2aR4TZs4K4hygzhEQQim7JPnyfovJFdk
 C6sptyiaIPxyJUxnczGiw7DZCmh+QHlJ5Ufq9Gr4zfA7epJDRGlwdnQLzZx5MRvNF09p
 2o7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388665; x=1794993465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aPNp2WgpgPHRfZu0DFCm+CGOWcM+7olBPXi5wHu617Q=;
 b=qKdUOEcmozEnf79H9bXCfv/VfDmtc30Kwi6R6nmXhMnB5oveqbcQ3SgWoLfCjH3slD
 WgXX98FpDnvAxZggcTtDcHA88mYV+szcXe7HgGWvecez7qN5R3DANUT+makoAV1G3Yc0
 jx9N2+qTJILzbYeQf9kogbdj6l3Gro3JuoZ5QLmfw4T8IfIOP0jA+lC/RmNKIiSzjkz3
 mZDMtL7XJdBlt6RVvtedLZppacz4D51Laz5aZpntecdKsOfAwuvVqWz9KvNerOclm9ES
 0V9Jfc5BOfyLWnGrAYv2CYhK/JIXpLSjannY7zg7twkeFsvAPGCTeGkUh9YhCXTj19Fj
 xinw==
X-Forwarded-Encrypted: i=1;
 AL+hErHSpKqUtPv4ntm2b4CasvQNLZT+TAM6T6YhGqJk+tIoVrSj0PtEb94+npYq69RoXb4O74PpB3xsblw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z90CWqmDEoiRi8saW3DYIZUP+tEjH0/qq1AQlIzEFuLp6lFKhV2
 kMGX3Cq2o3NrBRTic4tyNDaafK2Aa8RnmnsDbluG6wMeo2w3wyU1f0wn
X-Gm-Gg: AYBFou0oz7t1V59kYKuGLpeR2z+pyYzX+RodMqM6grZWtM4hI/vwq1mqyTftmFE9zAU
 VOUP5Hhq/w16+jj0nRVfvey71L567eIog6H7nfvaid4hfvv3d3ayobg13usNXcrmPaeciEV7lj8
 AXf6QNFJwpEx5SfXYlrgmrvrU+tBImM1EWDhkeebvU627d4ABrbFNoTe5/B1529V5rvLyOW1jqM
 YnpEcQrYa0kye7K4P3wcSztFX86SMwxc4Q7FZVAaM93ER0LUbgRno7+LF5IsDDF/+wWkewmDvoy
 8RLWFSyUvyyeSPRE/CMcxDvY+6DdZ9IaJav864KDLJH5gd5t/UiVZBIkPc/hLncCh0n3GNgiXNh
 MhRHI2Z7OkFYW0MhngLsVSGxybJAzGjLQj3fOs/pyXwNtG9qzU9xZU43PdIpSEkQQ2rPrZcgwAX
 xEaS7xVoTter/1WfbjVIWrbRDniql7eyEuGseGKKuNT0HH6WdHkFHl4MJt1iwqe1cxOH71+5IhR
 Q4Kv3fkhyduKLb8Z8O/0FJqBBg/Mk3LXIr1/X3Nq2HlVQE9jV5kIdfp8iAmXRGFkAVu59d2jMwn
 QkAaYN6xCzL0pOvuLmAdzLB5JFXlXw03g7rRiQ5mt/Z0zxNcX+l04YGRGOhCG/3Q+HJPN62QQ8F
 ME5oDPkx6PGVtotEqAJG9enyMk9Ayi8lkmLdx4NCk2v3YTtvg
X-Received: by 2002:a05:7300:d94a:b0:36d:4135:cd7 with SMTP id
 5a478bee46e88-3768617ce1bmr2715415eec.18.1794388665237; 
 Wed, 11 Nov 2026 01:17:45 -0800 (PST)
Received: from DESKTOP-DIIS71I ([5.18.141.223])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520512ec1sm13540869eec.12.2026.11.11.01.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:17:44 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Nicolas Belin <nbelin@baylibre.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 deeb.rand@confident.ru, shda@confident.ru, lvc-project@linuxtesting.org,
 Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] drm/meson: fix NULL pointer dereference in
 meson_drv_bind_master()
Date: Wed, 11 Nov 2026 12:16:57 +0300
Message-ID: <20261111091657.598-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 09:37:13 +0000
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

If the allocation of priv fails, meson_drv_bind_master() jumps to the
free_drm label, which calls meson_encoder_{dsi,hdmi,cvbs}_remove() with
a NULL priv. These functions dereference priv, so the error path oopses
instead of returning -ENOMEM.

Only the drm device has been allocated at that point, so put it and
return directly.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
Compile tested only.

Fixes: 6a044642988b ("drm/meson: fix unbind path if HDMI fails to bind")
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 38bf2811d..a9b707062 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -204,8 +204,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 
 	priv = devm_kzalloc_obj(dev, *priv);
 	if (!priv) {
-		ret = -ENOMEM;
-		goto free_drm;
+		drm_dev_put(drm);
+		return -ENOMEM;
 	}
 	drm->dev_private = priv;
 	priv->drm = drm;

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.39.5

