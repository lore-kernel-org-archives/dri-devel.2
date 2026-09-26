Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6BCCA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA1510E86A;
	Mon, 28 Sep 2026 08:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DlrKmcmy";
	dkim-atps=neutral
Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com
 [74.125.230.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 287AB89233
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:31:30 +0000 (UTC)
Received: by mail-qk2-f40.google.com with SMTP id
 af79cd13be357-93c5b166b8fso46753585a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790440289; x=1791045089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T+XTa7v9YGLEx2g2NOBefUwMoQWTvFtXhbpvBGy7RY4=;
 b=DlrKmcmyGCxo7lJoA9RYvNXoBH4mr/k8GAo7eUPcdp6j8Oy54gCc75eUWbehGInMQ5
 xKJsodbT4eKXTNmW/mCEWIsS8MisoMpo6qT41O4NRgMRFn5uLD8GtTUkB/9TQYLhLcVL
 CeH/d9Aikdep0bFOQydG6k5l4r9LTtN+IW57rKPX9IfhB1imAHJqVpZtBCNfo79fvkv9
 EToaOfSk0D6pND9JtV2P+zR02lEJm+jTF8cuZ35ztHDG5JcDIxRYgnMMfA6h1jTiFbm+
 SZUfe0mBbV1cBKUa3c9nFNgabRkl8chIRPzFVcJzWB2JxaC3j1Slvll6qJogqn8mSLkq
 Y6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790440289; x=1791045089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T+XTa7v9YGLEx2g2NOBefUwMoQWTvFtXhbpvBGy7RY4=;
 b=rP4E+KFIAQnLl90z2QX0R3QnZOKWR63NU85UXXMTjUYRc8fPZow1HdJM4u5LUy/LtT
 u694EmWxmD7HR+CFw0zfRbsoypxUyjo7kK8EZFAT7/n+3obqJhIfqaDG2VNToVXgrHyL
 U5eXHvN4HDiTye3Lk/4KjlKIPsuJara6P08zrfLp0zwLXyWqflFjmK1u3/UTYxuhkXib
 vnCvfJyoR0gOESIz9ceZOZlqBzy3XlEWzylMRw1cql9ScE8DE9mPUc14UyOdpzw2o9XY
 Ii8XzXOyuHpE9zQnfyL74m04Pt2soedW/F4FlN1et0GOVhPYe/JvHJCwP8HXR04o1Wm7
 OSWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1aokaBJnCMpNUVwjfS3Z4acO6aUHrQkIFIQRqDmiGTVY16intLZAAN1w98i4m7jbOT//abIGioC0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mk12We2spDUrr/cGdLG0kE7+sMPK0t0iNi26swZFHSoOPcYV3j
 ypphs9BxQto6q8bFbO3H5reGhzta2V7jAEjA1ib34WAI9Qq+W2lhueZH
X-Gm-Gg: AYBFou0010DPdpy3xtCBDlKbohI30ZOJSJoWpWw4QCZ1V7mrHcZ68T0X+WqeKeOHJ9l
 rIVJ5dUKSYfymtTZfydY6XoJbLb/gIRdHiJtreARDScTq0ukcveEt3shUaa1PcS0QrbMHIDTXbX
 DrrqoIHupa4MgGqKxvZzY9lNPVRUQyLETQB7hWW/SdoymeO9g4yN+ZEZugPeoj4PaUiwylNXf5Q
 CP6oIKNBrUmvMLi2+aTSBNeT43H6Wga6n3jzxcZFO5/vbCYbEGH2HJ+9g8ygmJe7DBNVVpu9c7f
 oWJaWdRHLvCdlq3cZUu/2G6r1aJ4hsUMBh8Kynm5ANufaqM5NT4REMPM1ZBORq5rOShfzSj5EHG
 7ZHu8Hrq8u2hLcqw8e/N8GV3UQzLm+S60QewFnF1B9heSCPQI3OLcRL+m4UvfLemGW4TE8BakBG
 sQEP5OLauiEQPc7RV9o/SQEkUO90qNTHbegKmTx2wDJtizMoJBzqLwmpg/OPwFUOqFuM04LfUDS
 tS9V+mz7wRow/7aTIVO2fwr44+BwnFWSnwLmEaGtRCcPrfXDNgDfmhwq61y+GrGjMI=
X-Received: by 2002:a05:620a:400d:b0:93b:d7a2:dd29 with SMTP id
 af79cd13be357-93c43d2d070mr1066129985a.57.1790440288703; 
 Sat, 26 Sep 2026 09:31:28 -0700 (PDT)
Received: from localhost.localdomain
 ([2600:4040:29f7:9600:f571:6178:b590:34a4])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c4fe09037sm341332385a.27.2026.09.26.09.31.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Sep 2026 09:31:27 -0700 (PDT)
From: Dillon Amburgey <dillona@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Dillon Amburgey <dillona@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, christian.koenig@amd.com, krisman@collabora.co.uk,
 noralf@tronnes.org
Subject: [PATCH v3 0/5] drm/qxl: fix shared-primary lifetime and source packing
Date: Sat, 26 Sep 2026 12:31:18 -0400
Message-ID: <20260926163123.39217-1-dillona@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:41 +0000
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

QXL packs dumb framebuffers into a shared primary surface. Failed
preparation and multihead updates can leave shadow bindings inconsistent;
packing whole allocations instead of visible sources also produces
oversized surfaces and incorrect coordinates. Patch 4 establishes atomic
ownership of the shared shadow before patch 5 changes its geometry.

This series supersedes the single-patch v2 posted on September 24:
https://lore.kernel.org/r/20260925033011.12560-1-dillona@gmail.com

Changes since v2:
- Split out fixes for framebuffer pin unwinding, DirtyFB commit ordering
  and error propagation, and stale disabled-head-zero monitor metadata.
- Replace BO-global shadow mutation and the shared redraw flag with
  prepared atomic plane-state ownership. Include every primary plane and
  CRTC in commit dependencies, replacing the lockless redraw of other
  heads. This addresses the state-lifetime and redraw-flag races raised
  by Sashiko AI:
  https://lore.kernel.org/r/20260925034208.6B9F61F000FF@smtp.kernel.org
- Separate shadow lifetime from source-sized packing, retaining source
  X/Y translation, packed monitor origins and clipped DirtyFB updates.
- Rebase onto mainline 6812ce4e4379 and expand regression coverage.

The series also applies and builds on drm-misc-fixes 94cf5971b1d0.
For drm-misc-next 98c7fc4219b9, patch 4 needs adaptation to the new
atomic_create_state API.

Validation:
- Each commit builds on x86 with W=1 and no new sparse diagnostics.
  The final QXL driver is also compile-tested on ARM and ARM64.
- QEMU/KVM tests cover error unwinding, commit/DirtyFB ordering, shared
  framebuffers, source offsets, clipped damage and concurrent modesets.
  Error-path and ordering tests used test-only hooks, absent from the
  series and final kernel.
- End-to-end Xorg/SPICE tests verify multihead resizing and DPMS resume
  without an application repaint.

OpenAI Codex assisted development and review of the patches and regression
fixtures.

Dillon Amburgey (5):
  drm/qxl: unpin the framebuffer when plane preparation fails
  drm/qxl: wait for pending commits before applying DirtyFB
  drm/qxl: clear the monitor configuration for disabled head zero
  drm/qxl: own packed primary shadows in atomic plane state
  drm/qxl: pack dumb heads from their plane source rectangles

 drivers/gpu/drm/qxl/qxl_display.c | 370 ++++++++++++++++++------------
 drivers/gpu/drm/qxl/qxl_draw.c    |   6 +-
 drivers/gpu/drm/qxl/qxl_drv.h     |   5 +-
 3 files changed, 229 insertions(+), 152 deletions(-)


base-commit: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
-- 
2.43.0
