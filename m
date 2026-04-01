Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5595510F9311
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 00:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3FE710E20C;
	Wed,  1 Apr 2026 00:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ze0yHTiA";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B396F10EA1C
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:29 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2c56aa62931so3207466eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003969; x=1775608769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ojh5tnUEiYmVdPjcqv3/1ea9VGb3tz1tyyEb2cwTcr4=;
 b=Ze0yHTiAb0pHTWMutm6hgyImF2Vpduv7Xt5bivkg0m9tKokaGooFqpO1QK6FRoRLXL
 Z4VU7Hi7UI/re6mS2dLVrtUBT33bE6WHHOpo830JOksLkioiFwH9iCRfWcMklq3kuEQt
 AvrNlDQ8D1MaGncimywEzXq2sFEKM5zlA6aOfl2KOUM21tnKWmx2WhbogpQabCow9SAe
 gg4cCocldmTK6uoebFSZuLQ/ZuacJoRX00TbOuaxsBFy4A24iCtcmKmKc/5m6x+RICDV
 PD8BJe2dXLBf4f+8nCE/3AZHoyXmyjPJkSdRDSIEd6WKNKBbc9qSz8Km0qX7xKKEBE2x
 3xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003969; x=1775608769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ojh5tnUEiYmVdPjcqv3/1ea9VGb3tz1tyyEb2cwTcr4=;
 b=p2zec3NSdMFdSLbwhnEHbvm3TmTqLOGyThw3FyPezojO/pabxVhuVPKChsNY0c0wgO
 WQpVhGeb8TjL4gxwzaKDH0FV0t57Tb31MO1TqzrkLooUS27+78g6D1ryKiWV7t+1lrKa
 B3fwwQvZkbmKo4+GUNFvRrp+Ar72DUe3ngARHVtp6S0hmEtgdrWoOkM6wK39zJEEJ1vy
 SV66NeUyn73pqFrB1iW8qkG8BNLNgQecJE4l50xEtyejsdpYy+IXXSQlHmYTZhxsHtrJ
 Vl4MkQ82vTatQuN9oIb/LExQkNAzQV6sNH2Dm2GQF4pS6JcCYt3A6zqeTL1Wp+3DDOVa
 q8BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUWOQvSPP+ICS7AAuaa2F03yt9OdAPkg//1K8UsigwIp7seN8fUqeVPauk1/+tBE5XZKBiM2yYusI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywIaJtcTCYomAnxQAKoE72LN5h4fv5ccSGpVaJAHD/+iSOIRnc
 aYaI6bmAO8nGrGCY5yk+S6dZQcV+glaRF4TmzjpLFxbS/4PmTGQU9uCn
X-Gm-Gg: ATEYQzwUGFW3/oCJoyiXWZkSKgxejA8IVx5g3hb5EA1eSxYdmw52pSzJOR/rwwJrf/H
 l+zDV09Kfit5H4x/RjfJYzuyAft+hj9enAVQIvg1679yNeoxa0FVQgDJdp5GEbACI+HTo2pmHd5
 5vVMkudEDJW7s5rbESkvwl3hS13KHPZj3i9HNUpf8xagAuy4GnTtam+MHOoFS6+R4G7VeZ1+C8i
 GamNFqYD2RwmGDXl+SaDPtUJ2F+QfIiW+fzasQzWE1/uFCpYrHAJDf6sRGLQfBhuDxB9JtR8rbr
 +/pEBqT4F9tuYEX6ZZONj0YMfLNNKlGAJihJo3UoUL/zAASooxCUCB48ee49TEI1s4MYvMnFT3v
 78YNvW/aEgJX0N+zxuCuZZsa6Y85pQP2ar+huNzZAwIjyy1D6SflXZDRyjArH3QBMWoceuRdo1o
 bCYIi41VdK0QjbSbuG2+FDtA2/oNcJril4saa4pgc4UhfER2mqYVnaIgU=
X-Received: by 2002:a05:7300:4309:b0:2c5:b23e:48a5 with SMTP id
 5a478bee46e88-2c9309866f8mr836144eec.1.1775003967392; 
 Tue, 31 Mar 2026 17:39:27 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:26 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 00/10] drm: amdgpu: backport suspend fixes for CI
Date: Tue, 31 Mar 2026 17:38:58 -0700
Message-ID: <20260401003908.3438-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Work that completed in kernel 6.18 resulted in working suspend with DC
on old hardware. This series aims to backport it to 6.12 to have working
suspend there as well.

All commits were applied with git cherry-pick, the only changes being
adding upstream commit, and signing off.

Tested on AMD HD7750 with:
radeon.si_support=0 amdgpu.si_support=1 amdgpu.dc=1
on Arch Linux.

v2: add extra upstream fix.

Charlene Liu (1):
  drm/amd/display: Correct logic check error for fastboot

Kenneth Feng (2):
  drm/amd/amdgpu: decouple ASPM with pcie dpm
  drm/amd/amdgpu: disable ASPM in some situations

Timur Kristóf (7):
  drm/amd/display: Disable fastboot on DCE 6 too
  drm/amd/display: Reject modes with too high pixel clock on DCE6-10
  drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4
  drm/amd/display: Fix DCE 6.0 and 6.4 PLL programming.
  drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
  drm/amd/display: Disable scaling on DCE6 for now
  drm/amd: Disable ASPM on SI

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 39 +++++++++++-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 20 ++++---
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  |  5 ++
 .../drm/amd/display/dc/dce60/dce60_resource.c | 59 +++++++++++++------
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 +-
 .../dc/resource/dce100/dce100_resource.c      | 10 +++-
 .../dc/resource/dce80/dce80_resource.c        | 10 +++-
 7 files changed, 117 insertions(+), 32 deletions(-)

--
2.53.0

