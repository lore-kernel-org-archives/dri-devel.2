Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576D0CCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D7810E148;
	Mon, 19 Oct 2026 07:29:59 +0000 (UTC)
Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B226110E7E8
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:29:53 +0000 (UTC)
Received: by mail-lr2-f7.google.com with SMTP id
 38308e7fff4ca-3a5d1645d85so17149001fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792394992; x=1792999792; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NmCIEe5EaGzU2U41ZTSvmQME4aOaTYAEh4vnVX7+bKI=;
 b=gVZcpqh4IwkUKYI776K0H0XCWHe4Ayd51jXg5XqoCDd833GAArQC6XqdsfQyffBLx1
 L3OlpAB5IAPeOCniRftYkthR1eWCFJXuWkMIofwgHtjDSLWgMMw/dEIWN0uhoDSnVgS1
 u0fD3yg0WARwsnHVE81niPDSXww+tR4Rz7SWcAfOgEgc78xOfD9yu3nY99prawfDw8B1
 iIuDF5CVjDVsBvV8G1Kw7JoUsUpqwXwLETWd73d61UH7Dty6LD9Aod2+jm8c3RzRgXY9
 LYRIIHSgqxfNNPn0yCaVbylDk2+UACvxLrjBkZqUPe7NQBlM5JKWQixakcqbxl04Ax9r
 FABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792394992; x=1792999792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NmCIEe5EaGzU2U41ZTSvmQME4aOaTYAEh4vnVX7+bKI=;
 b=IgC2H9vAQYCgKN7JEtuQrK8sl6R6fieDbCSnSld1Njpzvxo+5UtKhhKkWtocE4BNuh
 J5buaICyp4uD9iogWLDOf9V2hkOhoxieTmy37mzq798aSZTeD8CMFyDJtTZHsEAb4jGO
 hdTmDTVawp/7cT53VY5V6RjX1y705XzZx2fPx9HAWMd2iJkPcLjdn8FQKyP/Xwan4ccS
 vfp13aJV6JkrTPDRBF0Q3Y0FvKlAEW0sbmlZUr5wqvV3odHcfHlMBnlCS7+rnqDocJam
 zmtp7TJVB2OLZxi698PMU+74+63kRSf1B6rTrNt8A4kTffVRaAqTjzL8ZLJH1osaJKMJ
 By+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwe+EGS3AVcAWPu/G3GOIInaAOsfTdReKJrBAPPHNjQ03a3SH9n5b2JVAzBsLpji78efR0d6o+FWNU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI2w1M7P1L8nvFwQF3ttDXGBRz8/WZDO3eumixj75DDt0k4K6py
 BVMJFx5nOb1fnaJ4CQz5XEvrXZP25m7ECNGdI9rmK/m7j7LEVHuyChKQ
X-Gm-Gg: AYBFou08PsQXnDLpYiwU0EUd9PBT/wsIcq7cl3Avn97ZMAZQDfuZNcUQvOOj7XZLXU4
 //ekEeVvuGtFSAJ5hgN8u9mZxf3OltXiTy5M7IhDLcrLPd2wnVDuBA2TQhzKgDmD3AtAOnw1Ql5
 hP1gfvJE5+LRk+sHDZH8BBqsike6HeyIqUd7crLRAihufr9v61oXfCdgdtlISIxEDXcgtC7/MzW
 Emhraug8JdzZU4nLQJMmuUQQ53BZlbsd4XCYQkoMWAbMYXpaweIpHTnVOgjXBHdCbhvhFrtpSAU
 yJDUdw7naEfxt8xTlJENuImcA6YY2jt21v3kTcC3f5UVqFVMrZP007fox8qHo5LChbpW7K53i7u
 pDd1H6w3pjFejfEYLxZMyvQwaJAKipPSS8CVEi9bs3R38vimKByFns9iuPV7+4Pbnarg69ZofjT
 Z/VnE1xbSoe4ALdTcBGa1mLN57ylZJwxRue+W0pJz5l9H1Xbrp3g8XTfrMKkkirZGnyFv4IiJGq
 Q0oQj7jACEMew0O
X-Received: by 2002:a05:651c:324b:b0:3a3:3170:5420 with SMTP id
 38308e7fff4ca-3ab28f5a366mr14469931fa.3.1792394991368; 
 Mon, 19 Oct 2026 00:29:51 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab3afed52fsm8290511fa.8.2026.10.19.00.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 00:29:51 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dillon Varone <dillon.varone@amd.com>,
 Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 James Lin <pinglei.lin@amd.com>, Austin Zheng <austin.zheng@amd.com>,
 Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>,
 Kees Cook <kees@kernel.org>, Wenjing Liu <wenjing.liu@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] drm/amd/display: Fix NULL deref in
 dcn401_update_clocks_update_dtb_dto
Date: Mon, 19 Oct 2026 10:29:37 +0300
Message-ID: <20261019072938.10074-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

[Why]
resource_get_otg_master_for_stream() can return NULL if no OTG master pipe
is found for a given stream. The current code dereferences this pointer
without a NULL check. This may lead to a possible NULL pointer
dereference.

[How]
Add an explicit NULL check and skip the stream if the OTG master is not
found. This is similar to dcn60_update_clocks_update_dtb_dto().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b6d508533fa1 ("drm/amd/display: fix a crash when clock source is reference for non otg master pipe")
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 6ee3da89d058..135eeef68ac4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -538,6 +538,9 @@ static void dcn401_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr
 		otg_master = resource_get_otg_master_for_stream(
 				&context->res_ctx, context->streams[i]);
 		ASSERT(otg_master);
+		if (!otg_master)
+			continue;
+
 		ASSERT(otg_master->clock_source);
 		ASSERT(otg_master->clock_source->funcs->program_pix_clk);
 		ASSERT(otg_master->stream_res.pix_clk_params.controller_id >= CONTROLLER_ID_D0);
-- 
2.53.0

