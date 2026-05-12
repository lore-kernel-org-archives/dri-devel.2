Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2D5CD37BE
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 00:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F7110E15A;
	Tue, 12 May 2026 00:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="TIWXrm+6";
	dkim-atps=neutral
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0303F10E15A
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 00:25:26 +0000 (UTC)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2ba17c8cfacso50382275ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778545526; x=1779150326;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wl2ZJ8X3Eoilqn5QpjtTqUKIgS6nYmoYzsOa+qFtvUU=;
 b=fvsJw0gviFL+VeITNbDI/IWH254FOSdqwu07vmhEBkz2j/Ih0GDt1mpQuF1dQyri/T
 Gt/D13WAPRFgsdyji5CUK2g1R3knIQvJfrZtjVYyt4BrGxg8zUU7XQh2LFdgInIrJ4bQ
 RGHaTPdmycGlkvXfF4PwFEWj2tjBVPHVfezPUljPJzIw9hduSbB8eej+xP6wLLp41vzp
 U5rNNUSvG7kAGRQW3dV7lARU8r+wIJJs+mVrHVKccZ2ofGyNpkqdBJm7iJwiJQxYMlfa
 6Jg9I9pMSNsdgwpQ9XDYQIlPCfN8uxUdmv4eCqGgjw/54XgsUfxqv5NsPiMAhi/ag/Hg
 nZJQ==
X-Gm-Message-State: AOJu0Yyycg3rdWZJmstCeenRkjVpULQAbB2y2UEjb8oNvD9Rv+sQHvQg
 qqGlLxI9GVnFjSA8iVAkzN6YkSaWFwVkCoTUluLANr9XqISJXo/IMeWrmUvwFVhp3zT/2bZn+5q
 Ow77Gztmc1FOFRwUlS99dOVGJmG7ytZ4HrHpJIm4HDBmyGI5vRWSls+bBLehJRJlngdS7qVX1/u
 p055wqwF7NdlgCMnpiORxFwRANInK0gCSK9pTzYz+KEOm/Rh7xsId5Z2CiKSgpVzQbu2QzJj0vF
 r/A3dhNGl3LCCleMoPyvGwwSali
X-Gm-Gg: Acq92OGAuHvCUadIL7H99a7yE2kboQCKN6fJTcBp2YEOyMHAvHFmV5qXorm+4CU4+qO
 usSHKj13bc4AXOcFxxYTcypZ2w2oCp/flfvkHXItAwvoa6yxAi/QjwwLQzMPmtc6YLabRi3FBd2
 dBN0/8E/1atgsVh4z/AAKMFOpQU2NsqHmkhoW6qQdXLYO4aT7eCAs7Yc/+IrbQTE/2NvO1Feytw
 DMd6E8UgvDpK9GReReJRlgr51MR/ElQje5paiBNJ6UdA95vi55fNsrU66JOY4a7whFjqILmkNVt
 tS3aervC1SRsrNYIj29cH9ybeXja4gDopoZqN9wtFw2T0HwIQRMI3xP/qsN2zI9bri4cAvq0zwb
 gEGK4j4OAFKVIvKMdUwSg6TiAGWghWik4EQk3e/bLXL4TuKnBI9uhZQpmlN5A8bHo73MCwZDStR
 n5K25xtenlitPJCsuYfIV4PMv/WFK7nxqQCDm9dhff7ck/W4kR1HckEk/5HiuyLkQy
X-Received: by 2002:a17:902:ef08:b0:2b2:4f43:b48c with SMTP id
 d9443c01a7336-2bd0116e644mr8775975ad.14.1778545526220; 
 Mon, 11 May 2026 17:25:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2bcc1af3f6esm3585415ad.36.2026.05.11.17.25.25
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 May 2026 17:25:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1334825df27so378113c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778545524; x=1779150324;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wl2ZJ8X3Eoilqn5QpjtTqUKIgS6nYmoYzsOa+qFtvUU=;
 b=TIWXrm+69O/hFQilcQEo8DdMnzQtr7TOxHbhUB9cedEjRwtp/BrDXKygeC0bblLiuj
 YP9/kbL+QjbtzkIlvjTpWGmAqxhCu2COFi6rb2cFKoAA4McYQ2p82ubjNGhH+Y0pQglq
 YYMVefnvySSGYqjiHDYT2PrFDS4D/8Uwskgds=
X-Received: by 2002:a05:7022:699a:b0:12c:3d30:37ba with SMTP id
 a92af1059eb24-13344f913cdmr601899c88.25.1778545524353; 
 Mon, 11 May 2026 17:25:24 -0700 (PDT)
X-Received: by 2002:a05:7022:699a:b0:12c:3d30:37ba with SMTP id
 a92af1059eb24-13344f913cdmr601876c88.25.1778545523466; 
 Mon, 11 May 2026 17:25:23 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327821fd00sm20395488c88.8.2026.05.11.17.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 17:25:23 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v2 0/5] Fix some issues from igt runs.
Date: Mon, 11 May 2026 17:27:47 -0700
Message-ID: <20260512002752.2826685-1-maaz.mombasawala@broadcom.com>
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

Changes in v2:
- Changes based on Zack's comments.
- For vrefresh changes, removed stdu specific checks so that test
kms_invalid_mode@overflow-vrefresh passes with sou and ldu displays.
- For ttm ref changes, fixed a ref leak in ttm_prime_fd_to_handle()
which fixes a memleak in test vmw_prime@tri-map-dmabuf and removed
release callback for dumb buffer surface since the gem buffer will
handle release of the surface.
- Added commit to remove duplicate functions in vmwgfx_bo.h.


Maaz Mombasawala (5):
  drm/vmwgfx: Add some checks to vmw_cursor_plane_atomic_update
  drm/vmwgfx: Check vrefresh in drm_mode_setcrtc.
  drm/vmwgfx: Reserve ttm object before resv usage
  drm/vmwgfx: Change ttm refs for dumb buffers.
  drm/vmwgfx: Remove duplicates in vmwgfx_bo.h

 drivers/gpu/drm/vmwgfx/ttm_object.c          |  7 +++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c           |  6 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h           | 15 ---------
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c      |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 16 +++++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h          |  1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c      |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c          | 32 ++++++++++++++++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h          |  9 ++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c      |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c        |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c     | 12 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c       |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c         | 12 ++------
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c      | 11 ++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c         | 12 ++++++++
 16 files changed, 94 insertions(+), 55 deletions(-)

-- 
2.54.0

