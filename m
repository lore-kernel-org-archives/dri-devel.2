Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114C410F9312
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 00:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6867810EAEF;
	Wed,  1 Apr 2026 00:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GUkkw9c/";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB89210EAEF
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:34 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so12339426eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003974; x=1775608774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izF33sGDSHxUIsJEwsnSvCBwPxbglhEjEwQBj49A0mg=;
 b=GUkkw9c/ku15DU4/NWm7EuqHKcUF6DUHVUV4FlUEKK3LHEmZJxSltx+nnMGBg5/hfb
 8UTy0JvLPeQYSxY3My5GzRMBudhQXIvoUInYgt00oOU8DUfM95EV2B9jwT9VbdpQFh5f
 hiYoMgr02GxoVaOb7zS2HjeosuV63MKkYTOztsM6Y8Tv3NioVVsqPLFh9K8hVsrg1Z/j
 QlIFGx0bIcNkMKlV3txA9G3Lrd1X9H9Hxzty8Mc8Pbq7e/tVXXGHyxWd49odhqXp/T0h
 rZVvCb60YZ0XVwb4xE7djN3q/1PGKC3H+7EEEGoJIgzvy5gnaBImfiCiukEG4m1z1OpY
 iQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003974; x=1775608774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=izF33sGDSHxUIsJEwsnSvCBwPxbglhEjEwQBj49A0mg=;
 b=ddmSgI41Jo95trz3zdU5NFa85dqlo3zBOWvtPiNXlvNrm1HOYGTKUBuvVDEBvpaStI
 bWnSoDPcBYqsnmEADc69EcumlCRPGdl/+uAjD3vdplQWIRkL/wZRhgFM4nHr/uQ1eRYN
 dIE6BwWLfiCfSC9cvBVGuQ0Vx7WFJZbLUwG8vHG3Tv3Xdbz86llWaR8ZEumdpSQCJqdv
 vdG2+h22u+lZMAH+n0sd4ku1kBEKOSTfKOfpbC6ePX1tPWBrhnm0PoiDGp5TTKNuXVAB
 jp/wj+BumaIdJFUA2WXGAu3wEqDMoIXt4vAjalRNQWlYW53nAD5Mhv6xCjxlkEED+OB+
 VzPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp3d6ebBcXzlnzRYWmvuSAHPM8IrO7vgbhTwf8/7q3H6LMwknjr0bpwu2adqNrhA1h+hWBRCwgGxI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOXdQan1l4OUjJeJ0OMc20wSV3oyb9WOBvIG2nwJtOsWLJHr2l
 DUC+VEszTM/ra6/4CBv4inofCUxN3V7XyDCdhGgU+5lthP4aUzffBfgSAOgG8Y60
X-Gm-Gg: ATEYQzzQ95aVhIDirgCq0RxnnvjyspSofudQ/hS60NCYAdLSaXGy+UR4JY1oqadMWj5
 EkdMYZJ+JQSvmWrSjQcx5jtFWzg1rU7L9yflGorn6DG6iUsMxY6SO0TvPetHLsscazNMxT+YA5l
 IVXFmVdsAzaPlnjzzH+p+6MdrrDy+Z8LCI/56FRnir59CZOXmwN7ywPS4MYhfwMtj5D49LvAjKp
 1eM/jRMoYA/Z3JBqVyJnWxoG0ojhsBPwNZVbvhTdAuPG1My/8EkgBpY2HyK4dBH+P11REDNmRHq
 NsyEIN/K86fPolOIy4/cyJEMAXvS1rOpe6ORh1CdiD1eIPiOyXXYLqah04aYBo2xPBP6ZV0hW6F
 iPQDoZKBH2a9rvFiyka5kxEBFRU3MawtxyjTf+m0YaXGKWe0sIk2mapg+qIuDItlxcwEkD5FkrN
 fB3u3mkl1hzdX9drSc09GoNgNOaZ6C+UOtrA6+cnLk2qyo1yUopEAMGv8=
X-Received: by 2002:a05:7300:5b83:b0:2c1:6cfd:73dc with SMTP id
 5a478bee46e88-2c9327a1ac9mr827510eec.17.1775003973981; 
 Tue, 31 Mar 2026 17:39:33 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 03/10] drm/amd/display: Disable fastboot on DCE 6
 too
Date: Tue, 31 Mar 2026 17:39:01 -0700
Message-ID: <20260401003908.3438-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]

It already didn't work on DCE 8,
so there is no reason to assume it would on DCE 6.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index df69e0cebf78..7dc99c85b8ea 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
-	// Check fastboot support, disable on DCE8 because of blank screens
-	if (edp_num && edp_stream_num && dc->ctx->dce_version != DCE_VERSION_8_0 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_1 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_3) {
+	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)
-- 
2.53.0

