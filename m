Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1767E99076
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 10:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 316E610E90B;
	Fri, 10 Apr 2026 10:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sE/4Rf/K";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B7010E90B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:12:13 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso27436835e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775815932; x=1776420732; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=22v578vS3urScHwXah/EGJm4oQZ5Dq0jM06OD1zJsnE=;
 b=sE/4Rf/KFZ3oNKczb9egj8ngROBjq2/2QAzU0vUqxZchg8r4opDjHWgv18HwLIZq50
 g+o7qx8d7Yfkdy20zVCGYYdoZ1Lx+YKoGVG5b3O3cx55Q1hm8zCeHXyco7I28aHY4z1P
 5udghTF4oE+P/wTOtVDSgo9s38iEJTG8Z/TVMztXfxeZSS3MXoCa55lSQ2pMj2vDWCwf
 bqNncdoyV234xrdMCSEvOLr9gwO8jcZIT8fzyIQd7KW/q3jI70+RsbvgDXLjLRr2/VDX
 9Aoa5oQrE6EsAIdSaHGf/otQ/ajD1LnFCWiV5YKJOEmr3a99ZDKvDT9zFEhlsLHUVNc7
 iQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775815932; x=1776420732;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22v578vS3urScHwXah/EGJm4oQZ5Dq0jM06OD1zJsnE=;
 b=aeQfVH/D2pZ3uQcayUU3RvkXea4rIqvtkyKj/wUTAXUMHwqX4BBsF8yN2skL7O57iy
 BSpOTM8ZFD+BVgY+dhhGQdz7H85XGjTQl/lXm1vTf1iG2LB9Vo6ylRlrUS+tXEUmgBpV
 fEzsG4Je1YsjA0yo0sYfB+wOka1v/sOFS6mwVs87diNiD/Mz9z8qMz6ICJYb7b59t5Tu
 PycA+HGS5nJdKFIwnnolw+sCV99221w0fImeYdLDGdQhD57SOMiyfp6cB9sYTPUUih7S
 +66HT1TMI3lxkFPL5nCYgeYh00Yr0I7o5vGNJu1DHSoad1EkkGOqe+49Jji+faItKlAz
 tIjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6AJEd5zCKGd5JSVs8jhGnHJPryxx3NwngRlUgrvxvxAEeIOp9GBTfi2wkMA0IEHDJHulSGZ35iBY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrKrgYgFdC75LfH89hJLf2TpWBaV3S2KuipT6iV5GvXQ+UmPhd
 GL//ghgLcer75y7KrZR4hnGSmtGBfr/pWgi/1iqq2Hna5nUNm9Dbh+sf
X-Gm-Gg: AeBDievAti4QCuPHqtkbodG36HsKmzJ7b4MplOQtV2yvdw9cY71qllv4iCzh01sQ8Xi
 zx1nY+RsnhW1isQhQ6Ya0uZncxdj3z8b3oB4KVhlMYryolkViFIyz55yaj0ruVyN1/miL/9Ta4g
 1AKlR5BDAmtXBpS8McoQmUIBVJh/dodS4orWksB1W8jY8ryZGIdq1UBtu7fuyptOssLKynulj1R
 HOeyJz6OhcHg6PpwUNsf5RvDe6Mx1llwsXyppE3oHQ/nB5H0guXZr6C0aMwlh/X6W8jY83Xk8wH
 u09n21/hDgb5LtcFVfc1Tl3L90WG5RZrD4VSR/3W6cVZ3tUwx/bamHnz+12gijf3w7pCRTHYsIa
 NKfCEZxBupUKjwOkijtEwzHUhEcFUR5x3OBfv+DCLGOeOwBMmuYrdcF0zbXQknHP78PbAm6ZZLu
 8RKOn8NSwvlPW+PoEaPvA=
X-Received: by 2002:a05:600c:3ba1:b0:488:90ac:8f71 with SMTP id
 5b1f17b1804b1-488d67c704amr32809435e9.5.1775815932319; 
 Fri, 10 Apr 2026 03:12:12 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d683c902sm17472615e9.22.2026.04.10.03.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 03:12:11 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:12:08 +0300
From: Dan Carpenter <error27@gmail.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/panel: himax-hx83121a: Fix NULL vs IS_ERR() check
 in probe()
Message-ID: <adjM-IhvtrghMDnB@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

The devm_drm_panel_alloc() function never returns NULL, it returns error
pointers on failure.

Fixes: a7c61963b727 ("drm/panel: Add Himax HX83121A panel driver")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
This email is a free service from the Smatch-CI project [smatch.sf.net].

 drivers/gpu/drm/panel/panel-himax-hx83121a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83121a.c b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
index ebe643ba4184..bed79aa06f46 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
@@ -596,8 +596,8 @@ static int himax_probe(struct mipi_dsi_device *dsi)
 
 	ctx = devm_drm_panel_alloc(dev, struct himax, panel, &himax_panel_funcs,
 				   DRM_MODE_CONNECTOR_DSI);
-	if (!ctx)
-		return -ENOMEM;
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	ret = devm_regulator_bulk_get_const(&dsi->dev,
 					    ARRAY_SIZE(himax_supplies),
-- 
2.53.0

