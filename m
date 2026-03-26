Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BC010AB82D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 656FD10EB2C;
	Thu, 26 Mar 2026 23:47:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UyJbJJe2";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0307410EB15
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 23:47:42 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2a9296b3926so9917755ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 16:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774568861; x=1775173661; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izF33sGDSHxUIsJEwsnSvCBwPxbglhEjEwQBj49A0mg=;
 b=UyJbJJe2MugiBjAmpfGO6ZrlT0pHi3vMDOkeDls2jN53XVnUPoEMunfQcH/OKNbcWn
 wPSTWBbvvTCpptZF1MXh59d2DLItRpqLZZKEALV4x/unCz/p/a7T6/FSOF4MJ3Qtqxbf
 CqbYux0wRJIUPZQ7rWQYMlv8nDqQI6o6U5qOjl+akLsNIqsCqpMjIiEBxzZnjQRdHbtm
 1KcybiUFgItMREjtNu5WsZIPVDSjuTdDG4SoptL3adKmqtxyHnpVVRXPTeFbTNYC0Y4q
 kU5UtdMCKfGgo+n7viJmYW+dXB0VJvyOhCp7n9wCKVC906jv37CcyzR6zUCAhuiQ73qS
 9a4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568861; x=1775173661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=izF33sGDSHxUIsJEwsnSvCBwPxbglhEjEwQBj49A0mg=;
 b=kZD5jnA/rDiX7qFpnhw0kgW7hQD4JzNM3Ycu83kGdtId6RSHetWNxx2OMpznAjdqFE
 NLiloXJEw3WvWvD6Xfoer/z+WTqzBFjwjJO5ehBJxWwFZZSC5WAPqmLorCUvBV0kv4BF
 XGFJQyEjlrW7Yc11om7zVS98Xh3tXP9BB3suKHBLrAlZW3QscR2cWI1XynEWd+63uP3i
 u99FMaW7/MzlQoDh6a4NQlFrFRg2ksrHVIBzx9S9zG9kUIjjrDIVt8YKSfOIbHw7zozu
 evlhxHtSSx2llLPcKXjyw4YYDkxrQ1DwzNlf46t7OtcvyE22g68VYgodB442UUYhuWLF
 Iluw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhWIaaD7T7Dzjcsz8vsZ5UGg2h8FAb4nJSh0g/Ig6Ewire/7qQcJPsKXCStQxCg2UvRKBWjrXyajk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM6msn04E9ex+AtaV9WCT0Q19Y0Nt1Z/d4re5z8s5kXwFPnX0e
 wj8aOl+/p295ocTwn1XJc7NDZjEew8tAfTF224+2xaIA1t65QL7j+mma
X-Gm-Gg: ATEYQzywO2XHimG7TViWI315x9Im2YzpGEKyPMeJQ9LJN1VJi7cM1t2XBimj+Ou2Aa2
 OlJ++koBWHKP65jQ8khAlGlefnaJr5qWPk3tNpNoqEAUx7b5nPvQDyGbtKkQbaYRWJlUAF2jdjg
 zyqMfxqgmNOBfJTJgk6vCzWNbq2wSmkc6fZnq8TXpQ0dPhDYPYAyxqYajnIEoKius18EVTr0gkj
 9pf81zZx6nq1k1BzkbPnlcQqssp9jOsMnQnM/od46gxEhrH9YGBbe0UYjvtYE/qoJe664/vRoke
 SrMy7b3NfOq2p+S/IjpOERl9ggSIECsvYzEoVn6aV4uijSiMHJhNxY+hM+AGx672GXsAffzoVqb
 0+bytn284mb0DvNkHYRDiVjDsXoUhpxSq+E5O+fsLO/c0dV2W9XOoBCnl7sW8ccLJkp6YVAGFUI
 Svs2XmdYh8a980Z8mnuQ7EM/+KqLPk1i8v4naQaUXyMt4qqdiS/vhc+Fw=
X-Received: by 2002:a17:902:e5cd:b0:2ae:c907:85e6 with SMTP id
 d9443c01a7336-2b0cddb3827mr4478145ad.50.1774568861439; 
 Thu, 26 Mar 2026 16:47:41 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:47:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6 too
Date: Thu, 26 Mar 2026 16:47:10 -0700
Message-ID: <20260326234716.16723-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
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

