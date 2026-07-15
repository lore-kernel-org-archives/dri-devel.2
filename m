Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F05C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D216110EFAA;
	Wed, 15 Jul 2026 10:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="igKtKQMh";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3B710EFA9
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:58:02 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4758b2a9e2aso3274042f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784113080; x=1784717880; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d5gkvpI9Oyf/G2+2m0pFo39aPpeK40umw3UAR9f4Ju4=;
 b=igKtKQMhev4rbrFPfzFCnL46iyfJozJdKCapM9tktwItvvcsK/XrOYh3H+fjsm4fTQ
 TJx949R+iyhTS3inXv0lGBDw37F6e1e4AEHH1+fgdh9KXQcHTicnplWvYHpnGo/0PsgX
 osDdkRlNqMcP+QTsHjcDNmn6x5WqMv3xbMWmAW6Ew1mL1FGzqNgzn6MCWDLswuTXxgMX
 R4OaK3UU57MM47JDjBGdJjeP+IHBGU1AmLE3w4LeGQ/7ZnwvumxiQLJW2gVDGoQMdG6E
 qbD0sABxHBNU8An3eIEll6Bkj4uXBsQVSnB5SPg6tz0oixIE397/wbt0hqgkqLu9GX+F
 ifxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784113080; x=1784717880;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d5gkvpI9Oyf/G2+2m0pFo39aPpeK40umw3UAR9f4Ju4=;
 b=JWnq8SUC7bSF9e30nicyLApkuEdLC5Kta8bJbXESkMuiNQXYg9IYjZQTb5GEin75oP
 v2slFjRXdGqxgldf1lfkOIJ8iWA079sCjpOkOSje7edoRCXzlQ3zQfa4C0dTW6Rormsl
 UvnGm9bavft4vFYa1Y+mOoW0dLibvzVzZbSk1kVWut96yaje+PnngEQ40KOnB3jcMGWQ
 201rodX062L2czK7XHIK4KwjbYIokSJ3tZX51T3GItG9OAfjm9M6zXbDiIzDjAYBa7rb
 VSqQOY6UYk58iHC7o7dgcZ4cUpr3TTFUTKOfi2L0nvVprTnY7LxwAudth+WaWsn4cpen
 QtWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsJFpQj528HoaKT9p93h7oYRX2+EwKUfEdAiLeWETkBQfEJThldyGpd+sLWyPd7kRg6RGhpBHl/1I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkMyQ0SryGSyLGmjuADOETXnsveGbexuPNthX7AY2tLxX+Djkk
 1P9tJBMyafbrkns1kwXuFZ/33eAjmI8UjpRAtP8Hd6exun9v3cQMvI/V
X-Gm-Gg: AfdE7cmEV9HTGS2T3pBxptq6a7+yG9mgz8L9NXdkokkSUDgKofgabjmC8UNiQV+EC6b
 sHTbNkNFfdigNeSj65ci5fyDOdw3LnPepSf3ritTQZ7zttnlC/hTLRvuWU4rHewWMR0gYAaE+1c
 d5iGE3UJDeXxl+RhNAAnYhsu9a1iXDl3WuYNARSMVj9li5y5nWflxw+PBAU5mC+RfdTBjD3N4Hc
 D8SlY/bdmRU3Eox0k4djNJSS54j1sq79g8OffRKW7L5rujLVo5/gc8Y9ujKQ1URKDMBVh1k3NZP
 ZzvPTNx2ccd+NEwMzoQkxmcVWfMZj8UqdOJ8bWZI6Uu0Bowe8IWxtx593CZrtZ7GwvaTMn5RWKG
 Fppseo7O6Ks8o1pR1qT0rgFqGR+Ca8jfRpCPNqq6tEnWUGd6QeshEEfX3mvCf/0f9e4rN3R+2NC
 1R62pxiuP1qH6Wqvcu5IXc8A3ZppzKdIcbwZPdD6ZNIIn4Xz+Pl+hyDA==
X-Received: by 2002:a5d:5f0a:0:b0:47f:2dec:fd64 with SMTP id
 ffacd0b85a97d-47f488bdb5cmr7389318f8f.45.1784113080267; 
 Wed, 15 Jul 2026 03:58:00 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c4320sm15091094f8f.32.2026.07.15.03.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:57:59 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Dieter@nuetzel-hh.de
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/4] drm/amdgpu: Support DRM format modifiers on GFX6-8 (v2)
Date: Wed, 15 Jul 2026 12:57:53 +0200
Message-ID: <20260715105757.13125-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

GFX6-8 are the oldest GPUs supported by the amdgpu
kernel driver, and the last ones that didn't support
DRM format modifiers until now.

On GFX6-8, the GFX block can only use pre-determined tiling
modes which are programmed by the kernel according to the
tiling mode table. The new modifiers encode all the details
needed for tiling on these GPUs.

For the exact details, see the commit message of:
"drm/fourcc: Add modifiers for AMD GFX6-8"

For a userspace implementation, see this Mesa MR:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41557
And for libdrm:
https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/481

Supporting DRM format modifiers on GFX6-8 will
unblock many things in the Linux graphics ecosystem
that previously either didn't work on these GPUs
or had to implement fallbacks.
For example, compositors written in Vulkan or
compositors running on Zink, interop between
different APIs (eg. VAAPI / OpenGL / Vulkan) etc.

Timur Kristóf (4):
  drm/fourcc: Add modifiers for AMD GFX6-8
  drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
  drm/amd/display: Support DRM format modifiers on GFX6-8
  drm/amd/display: Don't use tiling flags anymore

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 111 +++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  29 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 337 ++++++++++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   3 -
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    |  84 -----
 include/uapi/drm/drm_fourcc.h                 | 209 ++++++++++-
 6 files changed, 602 insertions(+), 171 deletions(-)

-- 
2.55.0

