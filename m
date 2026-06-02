Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8EACD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 00:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A480110EAAC;
	Tue,  2 Jun 2026 00:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="fjF5qGPG";
	dkim-atps=neutral
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com
 [209.85.160.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C84010EAAC
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 00:38:50 +0000 (UTC)
Received: by mail-oa1-f98.google.com with SMTP id
 586e51a60fabf-43ccf0ba2e5so772577fac.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780360729; x=1780965529;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ayU/x0WtpZTsR5rv9XRaFNrlrHBXlA8WVlJvVhM02fg=;
 b=Zjxl1edMD1eakdWAEQbry85ERvbhWqqaEdApksrIFNzDEeRbVP4T1kVDpzcsCn2Bj0
 8t6A2kFfl4EE9BhSkRgs4Gz2DmmXXxmZ5oQKsMMZhYT5C/8Bx0Bo1g4i5mPdj8t6kCJo
 wu5Sn8yDRRzSN0T2KUxSFJGJSLV8n3MquJ7kizLGP+h1sFgEpVxbXrmCG/tZfOEo6wrK
 TdDSY099LlNA/ytAieluZXA9Mnv0Yf4GDBTj62wuiPca1xMWKJBD0yXlcOArie6VfGuA
 TGtEI//93ovpmjwDC8rStDZbWrB9LRDSPTVGn8/ZZdqk/rT86DFtogkOwiXLGbSABdwC
 Hmjg==
X-Gm-Message-State: AOJu0YwqipmgCArYHmzT8B7L1rF07xAMKOBMXyS8hwPLUhqCZ/SnuvF/
 RkLi76IAeThTUPoENd3/zC30Uj91XYhW1s8mvOcFbOQWI9oUyvnpvXmc++VlVpy7W9Z9ONoIxdn
 N140UtBbLjJ1mDdbT/VqPmWAl3x3IE5vtqpmJhP0VPgNRHdvkmA12CipTFSJiPxOarhLTV0f+uY
 m38qIWvpcIVStdn/nxHKe1QazfnCuiTMA7vmZII218t7hqDyXjl89GK5sWSzpB7Uhba6G8ZXdw9
 WcWAxvU4XuiUY0X3Vz9wyxpGa9I
X-Gm-Gg: Acq92OG9qKRclEbG+21mzN40xsuz8dcjg6dWak9GAqljp6FxAkhc9xe/ddbPxF5zcBy
 D9qR8BxyBG8cEEpIYQoOO8DLgMSIXVJe7tiYXZi+HIHZPt1qnl2KdevnJz5vuSelzuGmhgklty6
 lp/LnxQ9UQuxQjbJdDRWK1Tf0mD318YiFe7johLAJgzbIDs9t0MeCBO8AwHAQb1o0PZgUXqqeZ2
 y/F3/PvHsj1IIOZfmI3ylL4/k/5GWiukFMYuuPvbseLJ+htKMbrhoepdH1E6OVzNJZzMonmr+nc
 LOI2BfNV8P4sVxU1xNPbRR7iCb10TJwnZa8EL6lSoMM9YJGk2bfkrivAaKHg4WBsT6tzh3xpgXj
 eL7BrVTz3vEy1qn4xupNnun+DzjghOm4MyQ8jma7HdCiPz7Ze2BFgPQhOZn7n17mh+jssTKjrzS
 hsUKAdOI+QK85MLw1IEbtvK1gZ1EDCx9LM/7qgYYv+/+J1ChaQ3lytpVT2qiS303N7yxGGHLZX
X-Received: by 2002:a05:6870:6c0d:b0:430:29f5:285f with SMTP id
 586e51a60fabf-43ca43929admr7836550fac.35.1780360728935; 
 Mon, 01 Jun 2026 17:38:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-43c93a2f59dsm962465fac.3.2026.06.01.17.38.48
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2026 17:38:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8cced2dabc1so79164966d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780360728; x=1780965528;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ayU/x0WtpZTsR5rv9XRaFNrlrHBXlA8WVlJvVhM02fg=;
 b=fjF5qGPGiMFjjjYZbsYRonKCADDGRVsYKVFM+YZDRS7Wry9R+KPY1E2zTU+nmNWsHW
 g/hBsRP6ZjYsvuGpUsQ5//QUMr8PE8OU+354TZ5TI2vc0VXd3tfcMi3+vCiTMBxj8IFX
 Kge2be7Jvq+LJzC58Y3jG/Ccwtt373Jrqmggc=
X-Received: by 2002:a05:6214:29e9:b0:8ce:aace:eaf8 with SMTP id
 6a1803df08f44-8ceaaceefe2mr111722106d6.43.1780360727946; 
 Mon, 01 Jun 2026 17:38:47 -0700 (PDT)
X-Received: by 2002:a05:6214:29e9:b0:8ce:aace:eaf8 with SMTP id
 6a1803df08f44-8ceaaceefe2mr111721806d6.43.1780360727344; 
 Mon, 01 Jun 2026 17:38:47 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([216.221.25.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea1cadd2sm108125616d6.24.2026.06.01.17.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 17:38:47 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v5 0/4] Fix some issues from igt runs.
Date: Mon,  1 Jun 2026 17:41:59 -0700
Message-ID: <20260602004203.102901-1-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

I ran igt-gpu-tools with vmwgfx and fixed some issues I found.

Changes in v5:
- Get display unit from cursor plane, so there is no need for
old_crtc.
- Cast ALIGN to u64.
- Check return value of ttm_bo_reserve().

Changes in v4:
- For ttm ref change, changed to incrementing the refcount on
the ttm base object of the dumb surface instead of holding a
ttm ref object so that it is not exposed to tfile.
- Added Fixes messages.
- Removed BO cleanup patch.

Changes in v3:
- Minor changes so series can apply cleanly on drm-misc-next.

Changes in v2:
- Changes based on Zack's comments.
- For vrefresh changes, removed stdu specific checks so that test
kms_invalid_mode@overflow-vrefresh passes with sou and ldu displays.
For ttm ref changes, fixed a ref leak in ttm_prime_fd_to_handle()
which fixes a memleak in test vmw_prime@tri-map-dmabuf and removed
release callback for dumb buffer surface since the gem buffer will
handle release of the surface.
Added commit to remove duplicate functions in vmwgfx_bo.h.

Maaz Mombasawala (4):
  drm/vmwgfx: Add some checks to vmw_cursor_plane_atomic_update
  drm/vmwgfx: Check vrefresh in drm_mode_setcrtc.
  drm/vmwgfx: Reserve ttm object before resv usage
  drm/vmwgfx: Change ttm refs for dumb buffers.

 drivers/gpu/drm/vmwgfx/ttm_object.c          |  7 +++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c           |  8 +++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 16 +++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h          |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c          | 30 ++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h          |  9 ++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c         | 12 ++------
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c      | 14 ++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c         |  8 ++++++
 9 files changed, 86 insertions(+), 19 deletions(-)

-- 
2.54.0

