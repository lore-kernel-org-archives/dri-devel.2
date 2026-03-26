Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F76010AB833
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7843F10EB7C;
	Thu, 26 Mar 2026 23:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AnOsvsYf";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA80D10EB69
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 23:47:52 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-82bae83318bso705327b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774568872; x=1775173672; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/3ZOVQYuvF8/v5An1EVVsLN1VlAxvgYs14Kv3HQDNc=;
 b=AnOsvsYfGdiwZwIyFsATjP6aX8tBDr0C0D+mKuhld+vnmBjc81fvCJ1frxgGcQMeyw
 P2VRM06UWBbuIXqoVeh19pLhR6kcf9UT79RHzSwDGepsqSmixpbl9XCcKObVqHMSu1Kp
 VxXgASAZwwMgRNxAjB3eXheMcK8nopYmsz5pQFyMZHhgN0veHACP9PgvAbU7S2XWfVW6
 qFQ3TVhd0RpSWnWBAkdGvePriTjwTzzy92HmJ5ebxPAuMqS8qnrQM6d1sk1OgLtwUucm
 dkUyCzWXcq7p/YzybzzrDuIGbuQtL1H1H7RTHAyhTdwPuTqGTSLfQZemdLU3RSimxUeV
 dr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568872; x=1775173672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0/3ZOVQYuvF8/v5An1EVVsLN1VlAxvgYs14Kv3HQDNc=;
 b=cSPfU2DhpJKg58GwojPjK9Qepd0JEISJbjhekRU9p0+9FIHgcKtpb1n2dzokebWuHi
 NK6yfCXOpBrp9G1V9KzHhGYlZu0yIob2W5UXwpDqhL8Ib1HswQApChcu3d4CoXpuZl7C
 ZTvmDMLRCWK5F5DBITkTv5QH6zmsCgrQPNwP3ZwxxyEyMTREqKxG5UHkc+KrKG1JV7u1
 1FDjOTHeFE7+ZJhbpTH2APtoJKgovWKNb+Frpd0BLN7zWh/rC5KBIAkoPJa+FihEsGZ7
 TBQPN+gqSPM6A9F0iIdurXFzwH7uPX1ThXIrE6lVUTU4jxGPpQbebOnPSzq+FTIux2kV
 FYGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPwmh8OCIWn3TGNcNpkeENWz052A1CgC+ghDtZz8q2rdbWOk7HqvUxM1bZc1bxjULLI6Pdh4pwAbY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxe+3HhOvTjmqjzQlui1ALssZ2w7LCvMtjxvwlmr6k1gry8lnem
 zlIeAiUULVHMrB1xSwJAKvvpLr2hodWGyLBEyEuGsnZclBm8xEd0jxtG
X-Gm-Gg: ATEYQzyHpEIGZijMEmLP7AisSDUQbbmeCLQtyT0tkXxpVieYoZ+/hc4zn5A07AYRbRi
 ca9rA4COv3ShTwI7fzBxbnom7DwgEWd7WWre5d9WAk3LIZrp6CffSjv3aS3manlljypXBV/JSPu
 5o3aR40v5zbjCmmzpg5vfXvBs1XKtYInviwvHtIREvUQzIoEPSbPc66u5u7qN7RA3ccZ1aK3a5D
 crRuz+aRvReiUBwhT6/mruedy6qF6QiAPiYAO7nAtvzLa19uUD1LI+HRtIzvmb2X+ofXU2uDIYa
 bR9DymnNVKLJLcc4+c5AmVT7q8b6Jv6pu0mozvs08nV5FmuGn4qZZ04Rmh0w+KY3anCozxZoRkk
 GsYWOjTCvEZR53MMnwewBhOqsLIKwnjcHbbr5SEEHOmse71Iy1oaHn0m+4ANilPZtYFVclH7g61
 uCNvdOR0BGPDYZSjuaavHcazhYPWnOaD0S0CyNNB+wLYJ/pAD8u+vAwSw=
X-Received: by 2002:a05:6a20:3ca3:b0:398:a060:a97b with SMTP id
 adf61e73a8af0-39c877b2c2fmr512115637.1.1774568872136; 
 Thu, 26 Mar 2026 16:47:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:47:51 -0700 (PDT)
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
Subject: [PATCH for 6.12 8/9] drm/amd/display: Disable scaling on DCE6 for now
Date: Thu, 26 Mar 2026 16:47:15 -0700
Message-ID: <20260326234716.16723-9-rosenp@gmail.com>
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

[ Upstream commit 0e190a0446ec517666dab4691b296a9b758e590f ]

Scaling doesn't work on DCE6 at the moment, the current
register programming produces incorrect output when using
fractional scaling (between 100-200%) on resolutions higher
than 1080p.

Disable it until we figure out how to program it properly.

Fixes: 7c15fd86aaec ("drm/amd/display: dc/dce: add initial DCE6 support (v10)")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 978c024c97ba..3f9ea4fdc7d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -404,13 +404,13 @@ static const struct dc_plane_cap plane_cap = {
 	},
 
 	.max_upscale_factor = {
-			.argb8888 = 16000,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	},
 
 	.max_downscale_factor = {
-			.argb8888 = 250,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	}
-- 
2.53.0

