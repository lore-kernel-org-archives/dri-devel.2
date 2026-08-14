Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41412C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF6010E590;
	Fri, 14 Aug 2026 17:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="djE887sn";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA3410F6AE
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 17:15:31 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso16839785e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786727730; x=1787332530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NlJYVJ/8GdD4qg+Ajeu5HEDnsi7CdGS+uFMUtLjS2lM=;
 b=djE887sn2VlrjEj3qJ/EhodRLUs+gBY/Jb61yEHdkS0rzQvoQrLs1d0lCFJcgTcbQw
 d+tOuF4yvMgnchYnBbOXM2VsNyN1fHo6rJ/DFrE+kC7omKRtkNLJkhBsntWlYjdZiG4b
 WqywLTfMUa5/cttERyHJosVjOFBqRx3r/eudF4dU4DIweTKty4T1TNeFBs0G21W4vS2/
 qGIeVwplaf9Ycr5Q5Ik57IDXHwNBtUlrAA57O7S+oGF/7zlpGs8h/9l5WyziqrjI+d+s
 ucdHDZyEPWqDf1wNsx7Xs6GcCINacM6JXcf+rwR/d3J6lMFDz00SoFJ7qt8DQnchfhQj
 j8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786727730; x=1787332530;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NlJYVJ/8GdD4qg+Ajeu5HEDnsi7CdGS+uFMUtLjS2lM=;
 b=XfD64uswxx9gSDY5pvg08FODOH/aFcE/yjrjHdxHVVsuW/6it4/qbEs+RPpzZ1D2IV
 cj7wva12uXP/vIn/wYz3DoXHwy+yCgMPiX0HgNeIEVFLWj9zzBBRU9Dk9KXSbSJbbJpe
 9V2AVdge5dM/vbALufOQrX2rkOj5mOVaJQdSsTwWTYAWuWP5QrJMGwQ8FS1bLHtmbarY
 MR72zuj/BYC0TO+iOdV9E7Vpt85XUePkB9Gs4CFdbwdepIoD6py6xBbJrLhpulmaJnN0
 EOhzoj3qcH+vQr9biAJHgCDN7Az2ruPp10lcUrDUxlOnW/9M+rGKSl/iDLS+LWV6GkpW
 +KYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZYOfQBEiPmPSTipwucxxxU3QjR5oITDHMcIoZsjeGDO0g6x5rmStlLNMD3bHRMZoapWaU9xXyNFw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzhg0lZTaNtDDD48+nyRiGMvi3lfDycBVkL2MKNbqLWgHsXfjkg
 kKCLTKYW61s8fSxKqZiNGMrdEHvTvuthB+re5VGjHNwEvZsDEEmKWkKl
X-Gm-Gg: AR+sD137vwsZa6k349TaSU3WYU2rFXvaoMvN8nFYV1VcvEiEWbXgAXugNvSxMeA7zy9
 lr0LH+GGMlUp+zbYWeAcfbE3Wha8xLuGSE+xm6TdYqXpxZ5WoAMRduIYsEM1HUraMCpWpRnrcZv
 YXP6EiATAoHkOIv6g2kjblT6r0ALOk/u4WW3QbzqbqUDBKfbu5kdefergAkxUa3U5qjoIkspGdw
 w5EnMiW4Kk1oECtze0ayGBrVzyLA7+rtSJv0mdCV4+HZLUE6ahb9uzbjSt/fQIsNMtFR6kcfusf
 9IDRLXtk5QD0n8XoYATKCMnnBkTY7CSD3tX3FaJfVc6z4E2nrwSJhlhdKR6Ajav8NMpaPKsq24Q
 PEsHhvUTVkhOmAmkDSGkClTGfRY8JAFzZct9h6/7zFMApXhEWbrCmDUlXriip2Xumi8AiBQCWNi
 Bye++E3kdRZZTGUMTVmkmHEvW6xfUWVqaow2LEYP7OXmrleqkcDxXzChmc+rM=
X-Received: by 2002:a05:600c:5643:b0:499:77ba:4b6 with SMTP id
 5b1f17b1804b1-49987ad988emr70687995e9.9.1786727730016; 
 Fri, 14 Aug 2026 10:15:30 -0700 (PDT)
Received: from localhost ([5.83.201.220]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899b5ad0sm44859855e9.4.2026.08.14.10.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:15:29 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix spelling mistake "optmization" ->
 "optimization"
Date: Fri, 14 Aug 2026 18:13:35 +0100
Message-ID: <20260814171335.1099999-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

There is a spelling mistake in a DML_ASSERT_MSG message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
index ab9cadaf5a60..79ec5838c26f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
@@ -123,7 +123,7 @@ static enum dml2_status dml2_top_perform_stage_optimization(struct dml2_instance
 	DML_ASSERT_MSG(worksheet->validation_result.is_mode_support_valid
 			&& worksheet->validation_result.is_mcache_allocation_valid
 			&& worksheet->validation_result.is_prefetch_valid,
-			"worksheet must be valid on exit independent from optmization resul!\n");
+			"worksheet must be valid on exit independent from optimization resul!\n");
 //	DML_ASSERT_MSG(iteration <= MAX_OPTIMIZATION_ITERATIONS,
 //			"exceeds max optimization iterations!\n"
 //			"\t is_permissible_found = %s\n"
-- 
2.55.0

