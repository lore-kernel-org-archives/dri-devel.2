Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD53F10F9311
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 00:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CDE510EBBD;
	Wed,  1 Apr 2026 00:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fP7zGMjr";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE2E10EBBD
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:47 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2c160cb021cso6504542eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003987; x=1775608787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eei37i3TX+igH2enzLXynCDfuH92qYv7D/N1mhYCK9U=;
 b=fP7zGMjr0eov+6pS5YgobiOnUOy8guo2afM4nxNIUMza3LjuxVzmiUowsXQRYCyzHh
 uszx147WU7N+R+cWnirIs9jnsdqwJheRDvEVMf2hEVbSFC2nUOd+dtM9xun/0RIOUJy5
 wJGbXyhJ/B//nJo3y724Gsm5pHTLrMhQx/L/OivBgq8b/OgIDndf4B1N1S1BPq5+l2iZ
 CQgqFgaTd5roh2kXRPBMPxZPkXteb2bqwYL9p1xN7LwGWa1hwlmSc+LZzA1Kkha6WfFf
 m1tJkKx4NHMJ3mcDG46UWQi9wY18PoDYd2Hs+yYL7Zks0GfVgFxfRVr1YmXZt4WkSDC9
 aTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003987; x=1775608787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eei37i3TX+igH2enzLXynCDfuH92qYv7D/N1mhYCK9U=;
 b=J8B+nA01lv+Cy3H04gw1qFRdRzrdBkmZtxH80r1QaI05ovFbDeeU5xJyns9uY/+nss
 FN7TpALGl7l3SUx3Ivcn/2zKMEGrBctlWbZC7NK84I725IRgOk34Vs/NUJdUFVoLpdDV
 Zq680SBiwZnGxdNHAQgJkIeBw8WzHij8MajEYBGW/z8yIvVAO9ZspTa6GXtMiXPDapY+
 1EGzMs0K4AhQGsaRYcVwgjBq84mryvrFi7AjAEKUZnOkWBjgc+smWwt24khstQQj1GWS
 iF4IbEVkmrLbccODL7YF03/jlw32DK1J/YHIczGGFkJd2W6P8HFv95GGlhvTbroeyaZz
 m+vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzlfu2Y5HQgLPYrZ9tYdnIVi4VyqSz/nU2ztu2L46bKqPicRmJ0uhrsDNrahVLtJeComJUvvHBnpw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+WadjQNGdEnm0TpcDEXjgWyran1pKEFyFp680NI7eIjs6n71c
 UUtFROLN94Wt6LtfdD2HTXE0BAiAmMcfjP1RHk4LFpGvFq0O8JJ4FbNN
X-Gm-Gg: ATEYQzyYXRXyXL5yTT+NaGQI8xyAglNttrKMKpg97CEhJ4XAukBNRcjGPPSf2kIISKq
 ZpFtncZLu0dcV/CmPqg9M5ON6OOw7nz59w4F5z89pobvtQEhRSXURIkmWWLsNTCVZHloERVT/t7
 J+UUA0Sux6D/L7ekMifLDtvhy7tAnEZF4mXIWs4rNXgWdsdiKQvDYp/4O/zlcKfAw8w4sjYwMHT
 Asc1HhIsxMgHxjUB4RsAiar+198x/WTlqfAMvw88VK/r9oeRoF35qfd5FwCsD97wgSJcqnTDeo9
 oBCe7y+ZzCAC4J8vTE6w0LIvhmbhMMVNy4t0caliHvt/6zOYuNamUDqtSiTkRZTHMGYNDkifOk/
 Zz0KZrKh1bLF8Ybhsk4V6KyVLFE0/YyI0An4WvCnlP4NPg0Rugqe/0TqXbaQcIZuNsjk+bMTT32
 uGhIQ6JxlT22yXx8k5bSuoCmCK/wLEHpJPFtAGygoYdTNFmTxMTk/H/KCB+vVOqBRa4A==
X-Received: by 2002:a05:7300:2391:b0:2c1:27c:75cd with SMTP id
 5a478bee46e88-2c9311779d8mr930291eec.13.1775003986357; 
 Tue, 31 Mar 2026 17:39:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:45 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 10/10] drm/amd/display: Correct logic check error
 for fastboot
Date: Tue, 31 Mar 2026 17:39:08 -0700
Message-ID: <20260401003908.3438-11-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
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

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit b6a65009e7ce3f0cc72da18f186adb60717b51a0 ]

[Why]
Fix fastboot broken in driver.
This is caused by an open source backport change 7495962c.

from the comment, the intended check is to disable fastboot
for pre-DCN10. but the logic check is reversed, and causes
fastboot to be disabled on all DCN10 and after.

fastboot is for driver trying to pick up bios used hw setting
and bypass reprogramming the hw if dc_validate_boot_timing()
condition meets.

Fixes: 7495962cbceb ("drm/amd/display: Disable fastboot on DCE 6 too")
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 7dc99c85b8ea..551638d9ff61 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1910,8 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
-	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
-	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
+	/* Check fastboot support, disable on DCE 6-8-10 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version > DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)
-- 
2.53.0

